class Message < ActiveRecord::Base
  attr_accessible :body, :user_ids, :service_id, :group_ids
  belongs_to :service
  has_and_belongs_to_many :users
end
