class AddServiceIdToApiKeys < ActiveRecord::Migration
  def change
    add_column :api_keys, :service_id, :integer
  end
end
