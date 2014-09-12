class Account
  include Mongoid::Document
  include Mongoid::Timestamps

  field :account_type_id, type: BSON::ObjectId
  field :name,            type: String

  belongs_to :account_type
  has_many   :account_users
  has_many   :servers

  validates_presence_of :account_type_id

  def users
    User.in(id: account_users.map(&:user_id))
  end
end
