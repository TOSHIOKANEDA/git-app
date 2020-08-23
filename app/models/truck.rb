class Truck < ApplicationRecord
  belongs_to :order, dependent: :destroy
  validates :order_id, uniqueness: true
end
