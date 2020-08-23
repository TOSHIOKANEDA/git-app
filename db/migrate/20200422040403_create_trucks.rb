class CreateTrucks < ActiveRecord::Migration[5.2]
  def change
    create_table :trucks do |t|
      t.string :kanji
      t.string :up_num
      t.string :hiragana
      t.string :btm_left_num
      t.string :btm_right_num
      t.string :cntr_number
      t.string :date
      t.string :ordered_begin_time
      t.string :ordered_end_time
      t.references :order, foreign_key: true
      t.timestamps
    end
  end
end
