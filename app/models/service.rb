class Service
  include Mongoid::Document
  include Mongoid::Timestamps

  field :account_id, type: BSON::ObjectId
  field :server_id,  type: BSON::ObjectId
  field :name,       type: String
  field :type,       type: Integer

  belongs_to :server
  has_many :events

  validates_presence_of :account_id
  validates_presence_of :server_id
  validates_presence_of :name
  validates_presence_of :type, default: 0
end