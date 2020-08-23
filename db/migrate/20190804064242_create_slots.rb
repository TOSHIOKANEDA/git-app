class CreateSlots < ActiveRecord::Migration[5.2]
  def change
    create_table :slots do |t|
      t.date :date
      t.integer :am9_10
      t.integer :am10_11
      t.integer :am11_12
      t.integer :pm12_13
      t.integer :pm13_14
      t.integer :pm14_15
      t.integer :pm15_16
      t.date :date

      t.timestamps
    end
  end
end
