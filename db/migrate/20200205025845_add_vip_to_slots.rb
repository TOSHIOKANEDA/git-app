class AddVipToSlots < ActiveRecord::Migration[5.2]
  def change
    add_column :slots, :vip, :integer
  end
end
