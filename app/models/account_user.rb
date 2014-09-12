class AccountUser
  include Mongoid::Document
  include Mongoid::Timestamps

  field :account_id, type: BSON::ObjectId
  field :user_id,    type: BSON::ObjectId

  belongs_to :account
  belongs_to :user
end
