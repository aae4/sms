class Message < ActiveRecord::Base
  attr_accessible :body, :user_ids, :service_id, :group_ids, :custom_recipients
  #serialize :custom_recipients, Array
  #attr_accessor :custom_recipients
  belongs_to :service
  has_and_belongs_to_many :users
  has_and_belongs_to_many :groups

  def self.reversed_order(service_id)
    where(:service_id => service_id).order('created_at DESC')
  end

  def self.total_on(date)
    where("date(created_at) = ?",date).size
  end
end
