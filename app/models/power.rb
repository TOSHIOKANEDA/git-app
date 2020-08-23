class Power < ApplicationRecord
  has_many :orders
  has_many :users
end
