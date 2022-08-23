class Order < ApplicationRecord
  belongs_to :user
  has_many :products, through: :order_details
  has_many :order_details, dependent: :destroy
  enum status: {
    open: 0,
    confirmed: 1,
    shipping: 2,
    completed: 3
  }
  validates :user_phone, numericality: {only_integer: true},
    length: {maximum: Settings.user.phone_length}
  validates :user_address, presence: true,
    length: {maximum: Settings.user.high_length}
  scope :newest, ->{order created_at: :desc}
end
