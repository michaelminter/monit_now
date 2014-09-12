class Account
  include Mongoid::Document
  include Mongoid::Timestamps

  field :account_type_id, type: BSON::ObjectId
  field :name,            type: String

  has_many   :account_users
  belongs_to :account_type

  validates_presence_of :account_type_id
end
