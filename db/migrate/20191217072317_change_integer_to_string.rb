class ChangeIntegerToString < ActiveRecord::Migration[5.2]
  def change
    change_column :slots, :max_num, :string
  end
end
