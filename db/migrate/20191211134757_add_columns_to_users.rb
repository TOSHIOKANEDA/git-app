class AddColumnsToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :driver, :string
    add_column :users, :phone, :integer
    add_column :users, :company, :string
  end
end
