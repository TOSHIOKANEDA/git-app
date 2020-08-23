class ChanageColumnToOrders < ActiveRecord::Migration[5.2]
  def change
    add_column :orders, :ordered_end_time, :string
    add_column :orders, :ordered_begin_time, :string
  end
end
