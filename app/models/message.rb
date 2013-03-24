class Message < ActiveRecord::Base
  attr_accessible :body, :subject, :user_ids
  belongs_to :service
  has_and_belongs_to_many :users
end
