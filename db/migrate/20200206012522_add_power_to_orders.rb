class AddPowerToOrders < ActiveRecord::Migration[5.2]
  def change
    add_reference :orders, :power, foreign_key: true
  end
end
