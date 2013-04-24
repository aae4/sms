class ApiKey < ActiveRecord::Base
  before_create :generate_token
  attr_accessible :token
  belongs_to :service

  private
    def generate_token
      begin
        self.token = SecureRandom.hex
      end while self.class.exists?(token: token)
    end

end
