module Customer::HomeHelper
  def price_format price
    number_to_currency(price, {unit: "đ ", precision: 0})
  end
end
