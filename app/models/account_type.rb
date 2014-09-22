class AccountType
  include Mongoid::Document

  field :name,       type: String
  field :data_limit, type: Integer
  field :price,      type: Float

  has_many :accounts
end
