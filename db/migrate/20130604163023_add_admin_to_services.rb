class AddAdminToServices < ActiveRecord::Migration
  def change
    add_column :services, :admin, :boolean
  end
end
