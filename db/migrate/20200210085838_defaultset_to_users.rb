class DefaultsetToUsers < ActiveRecord::Migration[5.2]
  def change
    change_column_default :users, :power_id, from: nil, to: 1
  end
end
