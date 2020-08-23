class CreateMyTrucks < ActiveRecord::Migration[5.2]
  def change
    create_table :my_trucks do |t|
      t.references :user, foreign_key: true
      t.string :my_kanji
      t.string :my_up_num
      t.string :my_hiragana
      t.string :my_btm_left_num
      t.string :my_btm_right_num
      t.string :my_truck_name
      t.timestamps
    end
  end
end
