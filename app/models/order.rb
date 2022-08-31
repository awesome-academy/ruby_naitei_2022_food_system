class Order < ApplicationRecord
  belongs_to :user
  has_many :order_details, dependent: :restrict_with_error
  has_many :products, through: :order_details
  enum status: {
    open: 0,
    confirmed: 1,
    shipping: 2,
    completed: 3,
    cancelled: 4
  }
  scope :newest, ->{order created_at: :desc}
end
