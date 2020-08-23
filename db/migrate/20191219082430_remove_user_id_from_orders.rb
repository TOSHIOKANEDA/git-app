class RemoveUserIdFromOrders < ActiveRecord::Migration[5.2]
  def change
    remove_reference :orders, :user, index: true
  end
end
