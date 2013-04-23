class AddServiceIdToGroups < ActiveRecord::Migration
  def change
    add_column :groups, :service_id, :integer
  end
end