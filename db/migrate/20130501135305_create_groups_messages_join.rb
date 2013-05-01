class CreateGroupsMessagesJoin < ActiveRecord::Migration
  def change
    create_table :groups_messages, :id => false do |t|
      t.integer :group_id
      t.integer :message_id
    end
  end
end
