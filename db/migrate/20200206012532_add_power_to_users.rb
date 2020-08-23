class AddPowerToUsers < ActiveRecord::Migration[5.2]
  def change
    add_reference :users, :power, foreign_key: true
  end
end
