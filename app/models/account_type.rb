class AccountType
  include Mongoid::Document

  field :name,       type: String
  field :label,      type: String
  field :order,      type: Integer
  field :data_limit, type: Integer
  field :price,      type: Float
  field :stripe_subscription_plan, type: String

  has_many :accounts
end
