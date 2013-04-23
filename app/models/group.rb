class Group < ActiveRecord::Base
  attr_accessible :name, :user_ids, :service_id
  has_and_belongs_to_many :users
  belongs_to :service
  validates_presence_of :name
  validates_uniqueness_of :name
end
