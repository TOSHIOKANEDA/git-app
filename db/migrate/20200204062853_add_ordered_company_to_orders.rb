class AddOrderedCompanyToOrders < ActiveRecord::Migration[5.2]
  def change
    add_column :orders, :ordered_company, :string
  end
end
