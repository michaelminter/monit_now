class Activity
  include Mongoid::Document
  include Mongoid::Timestamps

  field :account_id,    type: BSON::ObjectId
  field :recurrence_at, type: Integer # change recurrence to version
  field :amount_today,  type: Integer, default: 0
  field :amount_total,  type: Integer, default: 0
  field :allowance,     type: Integer
  field :exceeded_at,   type: DateTime
end
