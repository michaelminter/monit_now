class Service
  include Mongoid::Document
  include Mongoid::Timestamps
  include Mongoid::Attributes::Dynamic

  field :server_id, type: BSON::ObjectId
  field :type,      type: Integer

  before_create :rename

  belongs_to :server

  # def self.name
  #   self.@name
  # end
end
