class TrafficController < ApplicationController
  skip_before_action :verify_authenticity_token

  def index
    if request.headers['Content-Type'] == 'text/xml'
      request.body.rewind # TODO: Find out what this does

      ip       = request.ip
      account  = Account.find(params[:id])
      xml      = request.body.read
      parser   = Nori.new(:convert_tags_to => lambda { |tag| tag.snakecase.to_sym })
      data     = parser.parse(xml)
      content_length = request.headers['content-length'].to_i

      if activity_allowed(account, content_length)
        xml_logger.info(xml)
        logger.info xml
        logger.info data
        begin
          # Find server
          server = Server.where({ :account_id => account.id, :ip => ip }).first
          if server.nil?
            server = Server.create(server_mapping(account, ip, data[:monit]))
          end
          # Create services
          if data[:monit][:services].present? || data[:monit][:services].present?
            create_portlets_and_services(account, server, data[:monit][:services].nil? ? data[:monit][:services] : data[:monit][:services][:services])
          end
          # Create events
          if data[:monit][:event].present?
            create_events(account, server, data[:monit][:event])
          end
          render :nothing => true, status: 200 # Okay
        rescue Exception => e
          Rollbar.report_exception(e)
          render :nothing => true, status: 417 # Expectation Failed
        end
      end
    else
      render :nothing => true, status: 426 # Upgrade Required
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

  def server_mapping(account, ip, data={})
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

  def service_mapping(data)
    response = {}
    unless data.nil?
      data.each do |key,value|
        response[key.to_s.gsub('@','').to_sym] = value
      end
      return response
    end
    return response
  end

  def create_portlets_and_services(account, server, data)
    if data.class == Array
      data.each do |service|
        service = service_mapping(service)
        find = Portlet.find_or_create_by(:account_id => account.id, :server_id => server.id, :name => service[:name].nil? ? service[:name] : service[:name], :type => service[:type].nil? ? service[:type] : service[:type])
        service[:account_id] = account.id
        service[:server_id]  = server.id
        service[:portlet_id] = find.id
        Service.create(service)
      end
    else
      data = service_mapping(data)
      find = Portlet.find_or_create_by(:account_id => account.id, :server_id => server.id, :name => data[:name].nil? ? data[:name] : data[:name], :type => data[:type].nil? ? data[:type] : data[:type])
      data[:account_id] = account.id
      data[:server_id]  = server.id
      data[:portlet_id] = find.id
      Service.create(data)
    end
  end

  def create_events(account, server, events)
    if events.class == Array
      events.each do |event|
        event[:account_id] = account.id
        event[:server_id]  = server.id
        event[:monit_id]   = event[:id]
        event.delete :id
        Event.create(event)
      end
    else
      events[:account_id] = account.id
      events[:server_id]  = server.id
      events[:monit_id]   = events[:id]
      events.delete :id
      Event.create(events)
    end
  end
end
