class AddSlotStatusToSlots < ActiveRecord::Migration[5.2]
  def change
    add_column :slots, :slot_status, :integer, default: 1
  end
end
