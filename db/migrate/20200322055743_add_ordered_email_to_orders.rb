class AddOrderedEmailToOrders < ActiveRecord::Migration[5.2]
  def change
    add_column :orders, :ordered_email, :string
  end
end
