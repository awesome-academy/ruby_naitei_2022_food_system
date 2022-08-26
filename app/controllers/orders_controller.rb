class OrdersController < ApplicationController
  before_action :logged_in_user
  before_action :load_order, except: :index

  def index
    @pagy, @orders = pagy(current_user.orders.newest,
                          items: Settings.pagy.items)
    render "customer/orders/index"
  end

  def show
    @pagy, @order_details = pagy(@order.order_details.includes(:product),
                                 items: Settings.pagy.items)
    render "customer/orders/show"
  end

  private

  def load_order
    @order = current_user.orders.find_by id: params[:id]
    return if @order

    flash[:error] = t ".no_order"
    redirect_to root_path
  end
end
