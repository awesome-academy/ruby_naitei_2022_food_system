class Admin::OrdersController < Admin::AdminController
  before_action :load_order, except: :index
  def index
    if params[:status].nil?
      @pagy, @orders = pagy(Order.includes(:order_details, :user).newest,
                            items: Settings.pagy.items)
    else
      load_orders params[:status]
    end
  end

  def show
    @pagy, @order_details = pagy(@order.order_details.includes(:product),
                                 items: Settings.pagy.items)
  end

  def approve
    if @order.open?
      status_confirmed
    elsif @order.confirmed?
      status_shipping
    elsif @order.shipping?
      status_complete
    else
      flash[:error] = t ".failed"
    end
  end

  def reject
    if !@order.cancelled? && !@order.completed?
      @order.cancelled!
      redirect_to admin_orders_path
      flash[:success] = t ".cancel_success"
    else
      redirect_to admin_orders_path
      flash[:error] = t ".cancel_failed"
    end
  end

  def undo
    if @order.cancelled?
      @order.open!
      redirect_to admin_orders_path
      flash[:success] = t ".success"
    elsif @order.confirmed?
      status_open
    elsif @order.shipping?
      status_confirmed
    elsif @order.completed?
      status_shipping
    else
      redirect_to admin_orders_path
      flash[:error] = t ".failed"
    end
  end

  private

  def load_order
    @order = Order.find_by(id: params[:id])
    return if @order

    flash[:error] = t ".not_found"
    redirect_to admin_orders_path
  end

  def status_confirmed
    @order.confirmed!
    redirect_to admin_order_path
    flash[:success] = t "admin.confirmed"
  end

  def status_shipping
    @order.shipping!
    redirect_to admin_order_path
    flash[:success] = t "admin.approve"
  end

  def status_complete
    @order.completed!
    redirect_to admin_order_path
    flash[:success] = t "admin.complete"
  end

  def status_open
    @order.open!
    redirect_to admin_order_path
    flash[:success] = t "admin.open"
  end
end
