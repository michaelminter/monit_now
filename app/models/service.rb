class Service
  include Mongoid::Document
  include Mongoid::Timestamps
  include Mongoid::Attributes::Dynamic

  field :server_id, type: BSON::ObjectId
  field :type,      type: Integer

  belongs_to :server

  validates_presence_of :server_id
end
