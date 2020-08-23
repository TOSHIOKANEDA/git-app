class AddTRangeToOrder < ActiveRecord::Migration[5.2]
  def change
    add_column :orders, :t_range, :string
  end
end
