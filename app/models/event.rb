class Event
  include Mongoid::Document
  include Mongoid::Timestamps
  include Mongoid::Attributes::Dynamic

  field :account_id, type: BSON::ObjectId
  field :server_id,  type: BSON::ObjectId

  belongs_to :account
  belongs_to :server

  validates_presence_of :account_id
  validates_presence_of :server_id

  after_validation :report_validation_errors_to_rollbar
end
