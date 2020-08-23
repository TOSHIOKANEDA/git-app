class AddColumnToOrders < ActiveRecord::Migration[5.2]
  def change
    add_column :orders, :ordered_name, :string
    add_column :orders, :ordered_tel, :string
  end
end
