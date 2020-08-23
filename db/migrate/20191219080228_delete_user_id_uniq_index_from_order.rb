class DeleteUserIdUniqIndexFromOrder < ActiveRecord::Migration[5.2]
  def change
  def up
    remove_index :orders, :user_id
    add_index :orders, :user_id
  end

  def down
    remove_index :orders, :user_id
    add_index :orders, :user_id, unique: true
  end
  end
end
