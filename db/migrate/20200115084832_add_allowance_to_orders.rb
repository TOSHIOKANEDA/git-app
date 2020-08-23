class AddAllowanceToOrders < ActiveRecord::Migration[5.2]
  def change
    add_column :orders, :allowance, :integer
  end
end
