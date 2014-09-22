class StripeCharge
  include Mongoid::Document
  include Mongoid::Timestamps
  include Mongoid::Attributes::Dynamic

  field :account_id, type: BSON::ObjectId

  belongs_to :account
end
