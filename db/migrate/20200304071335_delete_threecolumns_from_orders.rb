class DeleteThreecolumnsFromOrders < ActiveRecord::Migration[5.2]
  def change
    remove_column :orders, :t_range, :string
    remove_column :orders, :booking, :string
  end
end
