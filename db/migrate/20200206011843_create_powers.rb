class CreatePowers < ActiveRecord::Migration[5.2]
  def change
    create_table :powers do |t|
      t.integer :login_switch
      t.integer :update_switch
      t.timestamps
    end
  end
end
