class CreateServicesUsersJoin < ActiveRecord::Migration
  def change
    create_table :services_users, :id => false do |t|
      t.integer :service_id
      t.integer :user_id
    end
  end
end
