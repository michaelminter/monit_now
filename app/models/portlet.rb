class Portlet
  include Mongoid::Document
  include Mongoid::Timestamps

  field :account_id,   type: BSON::ObjectId
  field :server_id,    type: BSON::ObjectId
  field :name,         type: String
  field :type,         type: Integer
  field :order_column, type: Integer, default: rand(1..2)
  field :order_row,    type: Integer, default: rand(50..99)

  belongs_to :server
  has_many :services

  validates_presence_of :account_id
  validates_presence_of :server_id
  validates_presence_of :name
  validates_presence_of :type

  def current_service
    self.services.last
  end
end
