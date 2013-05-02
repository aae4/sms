class AddCustomRecipientsToMessages < ActiveRecord::Migration
  def change
    add_column :messages, :custom_recipients, :text
  end
end