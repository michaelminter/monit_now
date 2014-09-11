class Activity
  include Mongoid::Document
  include Mongoid::Timestamps

  field :account_id,    type: String
  field :recurrence_at, type: Integer
  field :amount_today,  type: Integer, default: 0
  field :amount_total,  type: Integer, default: 0
  field :allowance,     type: Integer
  field :exceeded_at,   type: DateTime
end
