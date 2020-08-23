class AddAllowanceToTruck < ActiveRecord::Migration[5.2]
  def change
    add_column :trucks, :allowance, :integer, default: 1
  end
end
