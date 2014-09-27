class Server
  include Mongoid::Document
  include Mongoid::Timestamps

  field :account_id,     type: BSON::ObjectId
  field :ip,             type: String
  field :uptime,         type: Integer
  field :poll,           type: Integer
  field :start_delay,    type: Integer
  field :localhost_name, type: String
  field :control_file,   type: String
  field :httpd_address,  type: String
  field :httpd_port,     type: Integer
  field :httpd_ssl,      type: Integer
  field :platform_name,  type: String
  field :release,        type: String
  field :version,        type: String
  field :macine,         type: String
  field :cpu,            type: Integer
  field :memory,         type: Integer
  field :swap,           type: Integer
  field :monit_version,  type: String

  belongs_to :account
  has_many   :portlets
  has_many   :events
  has_many   :dashboard_portlets

  after_create :create_events_portlet

  def create_events_portlet
    Portlet.create({
        :account_id   => self.account_id,
        :server_id    => self.id,
        :name         => 'Events',
        :type         => 100,
        :order_column => 3,
        :order_row    => 0
                   })
  end
end
