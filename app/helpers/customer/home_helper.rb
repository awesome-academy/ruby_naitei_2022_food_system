module Customer::HomeHelper
  def price_format price
    number_to_currency(price, {unit: "đ ", precision: 0})
  end

  def stars_avg product
    avg = product.ratings.average(:star)
    avg.presence || 0
  end
end
