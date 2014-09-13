class Event
  include Mongoid::Document
  include Mongoid::Timestamps
  include Mongoid::Attributes::Dynamic

  field :account_id, type: BSON::ObjectId
  field :service_id, type: BSON::ObjectId

  belongs_to :service

  validates_presence_of :account_id
  validates_presence_of :service_id
end
