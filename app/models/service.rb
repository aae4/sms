class Service < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  attr_accessible :email, :password, :password_confirmation, :remember_me, :name, :surname, :patronymic
  has_and_belongs_to_many :users
  has_many :messages
  has_many :groups
  has_one :api_key

  def full_name
    "#{self.surname} #{self.name} #{self.patronymic}"
  end
end
