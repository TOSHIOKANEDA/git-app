class AddFullStatusToSlots < ActiveRecord::Migration[5.2]
  def change
    add_column :slots, :full_status, :integer, default: 1
  end
end
