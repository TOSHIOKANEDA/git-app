class ChangeTruckToTrucknumForOrders < ActiveRecord::Migration[5.2]
  def change
    rename_column :orders, :truck, :truck_number
  end
end
