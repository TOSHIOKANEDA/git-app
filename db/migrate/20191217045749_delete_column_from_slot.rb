class DeleteColumnFromSlot < ActiveRecord::Migration[5.2]
  def change
    remove_column :slots, :am9_10, :integer
    remove_column :slots, :am10_11, :integer
    remove_column :slots, :am11_12, :integer
    remove_column :slots, :pm12_13, :integer
    remove_column :slots, :pm13_14, :integer
    remove_column :slots, :pm14_15, :integer
    remove_column :slots, :pm15_16, :integer
    add_column :slots, :begin_time, :string
    add_column :slots, :end_time, :string
    add_column :slots, :max_num, :integer
  end
end
