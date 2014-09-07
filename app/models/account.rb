class Account
  include Mongoid::Document
  include Mongoid::Timestamps

  field :account_type_id, type: Integer
  field :name, type: String

  has_many :users

  validates_presence_of :account_type_id
end
