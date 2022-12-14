class Product < ApplicationRecord
  PRODUCT_ATTRS = [:name, :description, :price, :stock_quantity, :category_id,
                   {images: []}].freeze

  belongs_to :category
  has_many_attached :images
  has_many :ratings, dependent: :destroy
  has_many :order_details, dependent: :restrict_with_error

  validates :name, presence: true,
            length: {minium: Settings.product.name_min,
                     maximum: Settings.product.name_max}

  validates :description, presence: true

  validates :price, presence: true,
            format: {with: Settings.product.price_format},
            numericality: {greater_than: Settings.product.num_min}

  validates :stock_quantity, presence: true,
            format: {with: Settings.product.price_format},
            numericality: {greater_than: Settings.product.num_min,
                           less_than: Settings.product.num_max}

  validates :images,
            content_type: {in: Settings.product.image.content_types,
                           message: :image_format_invalid},
            size: {less_than: Settings.product.image.size_limit,
                   message: :file_size_out_of_range}

  scope :newest, ->{order(created_at: :desc)}
  scope :search_by_name, ->(search){where("name LIKE '%#{search}%'")}
  scope :not_id, ->(id){where.not id: id}
  scope :get_by_ids, ->(ids){where id: ids}
end
