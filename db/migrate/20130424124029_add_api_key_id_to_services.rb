class AddApiKeyIdToServices < ActiveRecord::Migration
  def change
    add_column :services, :api_key_id, :integer
  end
end
