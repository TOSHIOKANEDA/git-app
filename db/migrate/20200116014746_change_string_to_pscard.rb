class ChangeStringToPscard < ActiveRecord::Migration[5.2]
  def change
    change_column :orders, :ps_card, :integer
  end
end
