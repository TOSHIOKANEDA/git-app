class AddSlotRefToOrders < ActiveRecord::Migration[5.2]
  def change
    add_reference :orders, :slot, foreign_key: true
  end
end
