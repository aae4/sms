class User < ActiveRecord::Base
  attr_accessible :name, :phone

  validates_presence_of :name, :phone
  validates_uniqueness_of :phone
  has_and_belongs_to_many :services
  has_and_belongs_to_many :messages
  has_and_belongs_to_many :groups
end
