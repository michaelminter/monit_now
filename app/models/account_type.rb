class AccountType
  include Mongoid::Document
  field :name, type: String
  field :data_limit, type: Integer
  field :data_retention, type: Integer
  field :price, type: Integer
end
