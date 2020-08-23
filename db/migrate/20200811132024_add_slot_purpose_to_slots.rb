class AddSlotPurposeToSlots < ActiveRecord::Migration[5.2]
  def change
    add_column :slots, :slot_purpose, :integer
    add_column :slots, :slot_size, :integer
  end
end
