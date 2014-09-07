class AccountUser
  include Mongoid::Document
  include Mongoid::Timestamps

  field :account_id, type: Integer
  field :user_id,    type: Integer
end
