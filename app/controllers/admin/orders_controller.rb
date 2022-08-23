class Admin::OrdersController < Admin::AdminController
  before_action :load_order, only: :show
  def index
    @pagy, @orders = pagy(Order.all.newest, items: Settings.pagy.items)
  end

  def show
    @pagy, @order_details = pagy(@order.order_details.includes(:product),
                                 items: Settings.pagy.items)
  end

  private

  def load_order
    @order = Order.find_by(id: params[:id])
    return if @order

    flash[:error] = t ".not_found"
    redirect_to admin_orders_path
  end
end
