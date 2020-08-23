class AddCertificateToUser < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :certificate, :string
  end
end
