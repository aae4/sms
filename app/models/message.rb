class Message < ActiveRecord::Base
  attr_accessible :body, :user_ids, :service_id, :group_ids, :custom_recipients
  attr_accessor :custom_recipients
  belongs_to :service
  has_and_belongs_to_many :users
  has_and_belongs_to_many :groups
end
