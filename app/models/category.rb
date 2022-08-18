class Category < ApplicationRecord
  has_many :products, dependent: :destroy
  validates :name, presence: true
  scope :random, ->{order("RAND()")}
end
