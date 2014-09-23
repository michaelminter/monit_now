class Service
  include Mongoid::Document
  include Mongoid::Timestamps
  include Mongoid::Attributes::Dynamic

  field :account_id, type: BSON::ObjectId
  field :portlet_id, type: BSON::ObjectId

  belongs_to :portlet

  validates_presence_of :account_id
  validates_presence_of :portlet_id

  after_validation :report_validation_errors_to_rollbar
end
