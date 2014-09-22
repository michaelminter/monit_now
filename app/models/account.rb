class Account
  include Mongoid::Document
  include Mongoid::Timestamps

  field :account_type_id,    type: BSON::ObjectId
  field :stripe_customer_id, type: String
  field :name,               type: String

  belongs_to :account_type
  has_many   :account_users
  has_many   :servers
  has_many   :activities
  has_many   :events
  has_many   :stripe_charges
  has_one    :stripe_customer

  validates_presence_of :account_type_id

  def users
    User.in(id: account_users.map(&:user_id))
  end
end
