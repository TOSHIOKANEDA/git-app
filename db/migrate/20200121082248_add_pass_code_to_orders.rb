class AddPassCodeToOrders < ActiveRecord::Migration[5.2]
  def change
    add_column :orders, :pass_code, :string
  end
end
