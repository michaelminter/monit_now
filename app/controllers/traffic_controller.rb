class TrafficController < ApplicationController
  skip_before_action :verify_authenticity_token

  def index
    p request.headers['content-length']
    if request.headers['Content-Type'] == 'text/xml'
      # Don't know what this does
      request.body.rewind

      ip       = request.ip
      account  = Account.find(params[:id])
      data     = request.body.read
      parser   = Nori.new(:convert_tags_to => lambda { |tag| tag.snakecase.to_sym })
      new_data = parser.parse(data)
      content_length = request.headers['content-length'].to_i

      xml_logger.info(data)

      if activity_allowed(account, content_length)
        begin
          # save server
          server = Server.where({ :account_id => account.id, :ip => ip }).first
          if server.nil?
            server = Server.create(map_server(account, ip, new_data[:monit]))
          end
          # save services
          parse_services(server, new_data[:monit][:services])
          render :nothing => true, status: 200
        rescue Exception => e
          puts e.message
          puts e.backtrace.join("\n")
          # Expectation Failed
          render :nothing => true, status: 417
        end
      end
    else
      # Upgrade Required
      render :nothing => true, status: 426
    end
  end

  private

  def activity_allowed(account, content_length)
    # get activity data from today
    activity_today = Activity.where({ :account_id => account.id, :recurrence_at => Time.now.strftime('%Y%m%d').to_i }).first
    if activity_today.nil?
      activity_sum   = Activity.where(account_id: account.id).sum(:amount_today) rescue 0
      activity_today = Activity.create({ account_id: account.id, recurrence_at: Time.now.strftime('%Y%m%d').to_i, amount_today: 0, amount_total: activity_sum, allowance: account.account_type.data_limit })
    end

    # Create new data lengths
    new_amount_today = activity_today.amount_today + content_length
    new_amount_total = activity_today.amount_total + content_length

    # Check data length allowance
    if new_amount_total > account.account_type.data_limit
      # if within less than one hour
      # send notification to account owner
      # save server
      # save services
      # else
      # Upgrade Required
      return false
      # end
    else
      # Set new daily amount
      activity_today.update_attributes({ amount_today: new_amount_today, amount_total: new_amount_total })
      return true
    end
  end

  def map_server(account, ip, data={})
    {
      :account_id => account.id,
      :ip => ip,
      :uptime => data[:server][:uptime],
      :poll => data[:server][:poll],
      :start_delay => data[:server][:startdelay],
      :localhost_name => data[:server][:localhostname],
      :control_file => data[:server][:controlfile],
      :httpd_address => data[:server][:httpd][:address],
      :httpd_port => data[:server][:httpd][:port],
      :httpd_ssl => data[:server][:httpd][:ssl],
      :platform_name => data[:platform][:name],
      :release => data[:platform][:release],
      :version => data[:platform][:version],
      :macine => data[:platform][:machine],
      :cpu => data[:platform][:cpu],
      :memory => data[:platform][:memory],
      :swap => data[:platform][:swap],
      :monit_version => data[:@version],
    }
  end

  def parse_services(server, data)
    if data[:services].class == Array
      data[:services].each do |service|
        service[:service][:server_id] = server.id
        Service.create(service[:service])
      end
    else
      data[:service][:server_id] = server.id
      p data[:service]
      Service.create(data[:service])
    end
  end
end
