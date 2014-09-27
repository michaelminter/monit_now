class DashboardPortlet
  include Mongoid::Document
  include Mongoid::Timestamps

  field :dashboard_id, type: BSON::ObjectId
  field :portlet_id,   type: BSON::ObjectId
  field :server_id,    type: BSON::ObjectId
  field :account_id,   type: BSON::ObjectId
  field :order_column, type: Integer
  field :order_row,    type: Integer
  field :name,         type: String
  field :type,         type: Integer

  belongs_to :account
  belongs_to :server
  belongs_to :portlet

  def current_service
    self.portlet.services.last
  end

  def services
    self.portlet.services
  end
end
