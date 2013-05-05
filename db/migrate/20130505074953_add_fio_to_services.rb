class AddFioToServices < ActiveRecord::Migration
  def change
    add_column :services, :name, :string
    add_column :services, :surname, :string
    add_column :services, :patronymic, :string
  end
end
