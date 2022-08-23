module Admin::OrdersHelper
  def total_price order
    sum = 0
    order.order_details.each do |order_detail|
      sum += order_detail.price * order_detail.quality
    end
    number_to_currency(sum, locale: :vi)
  end
end
