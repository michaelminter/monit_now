class Account
  include Mongoid::Document
  include Mongoid::Timestamps
  include Mongoid::Attributes::Dynamic

  field :account_type_id,      type: BSON::ObjectId
  field :name,                 type: String
  field :stripe_customer_id,   type: String
  field :recurrence_at,        type: Integer

  belongs_to :account_type
  has_many   :account_users
  has_many   :servers
  has_many   :activities
  has_many   :events

  validates_presence_of :account_type_id

  before_create :add_recurrence

  def add_recurrence

  end

  def users
    User.in(id: account_users.map(&:user_id))
  end
end
