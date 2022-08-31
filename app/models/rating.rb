class Rating < ApplicationRecord
  belongs_to :product
  belongs_to :user

  validates :star, presence: true,
                   numericality: {greater_than: Settings.rating.star_min,
                                  less_than: Settings.rating.star_max,
                                  only_integer: true}
  validates :comment, length: {maximum: Settings.rating.length}

  scope :newest, ->{order(created_at: :desc)}
  scope :by_product, ->(id){where product_id: id}
  delegate :name, to: :user, prefix: true
end
