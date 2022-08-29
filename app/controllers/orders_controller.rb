class OrdersController < ApplicationController
  before_action :logged_in_user
  before_action :load_order, except: [:index, :new, :create]
  before_action :check_user_info, only: [:new, :create]
  before_action :check_stock_quantity, only: :create

  def index
    @pagy, @orders = pagy(current_user.orders.newest,
                          items: Settings.pagy.items)
    render "customer/orders/index"
  end

  def new
    @order = current_user.orders.build
    render "customer/orders/new"
  end

  def create
    if @over_stock_products.present?
      flash[:error] = t(".sp") << @over_stock_products.join(", ") << t(".kdu")
      redirect_to carts_path
    elsif create_order_detail
      flash.now[:success] = t ".success"
      clear_cart
      render "customer/orders/thank"
    end
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

  def check_user_info
    return if current_user.address.present? && current_user.phone.present?

    flash[:error] = t ".please_update"
    redirect_to edit_user_path(current_user)
  end

  def create_order_detail
    success = true
    create_new_order
    if @new_order.save
      current_cart.each do |id, quantity|
        product = Product.where(id: id).pluck :price
        detail = @new_order.order_details.build(
          product_id: id,
          price: product[0],
          quantity: quantity
        )
        success = detail.save
      end
    else
      success = false
      redirect_to carts_path
    end
    success
  end

  def create_new_order
    @new_order = current_user.orders.build(
      user_address: current_user.address,
      user_email: current_user.email,
      user_phone: current_user.phone,
      note: params[:note],
      total: cart_total
    )
  end

  def check_stock_quantity
    stock_arr = Product.get_by_ids(current_cart.keys)
                       .pluck(:stock_quantity, :name)
    @over_stock_products = []
    current_cart.to_a.each_with_index do |item, index|
      if item[1].to_i > stock_arr[index][0].to_i
        @over_stock_products << stock_arr[index][1]
      end
    end
    @over_stock_products
  end
end
