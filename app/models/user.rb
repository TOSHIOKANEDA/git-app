class User < ApplicationRecord
  belongs_to :power
  has_many :orders, dependent: :destroy
  has_many :notices
  has_many :my_trucks, dependent: :destroy

  
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :rememberable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable, :validatable,:recoverable

  def phone=(value)
    value.tr!('０-９', '0-9') if value.is_a?(String)
    super(value)
  end

end
