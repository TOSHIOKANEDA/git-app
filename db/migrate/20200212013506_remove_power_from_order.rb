class RemovePowerFromOrder < ActiveRecord::Migration[5.2]
  def change
    remove_reference :orders, :power, index: true
  end
end
