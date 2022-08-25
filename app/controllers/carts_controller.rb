class CartsController < ApplicationController
  before_action :find_product_by_id, except: :show
  def show; end

  def create
    quantity = params[:quantity].to_i
    if quantity <= @product.stock_quantity
      add_to_card @product, quantity
      render json: {status: 200, message: t(".success"),
                    cart_items_count: items_count}
    else
      render json: {status: 500, message: t(".failed")}
    end
  end

  private

  def find_product_by_id
    @product = Product.find_by id: params[:id]
    return if @product

    flash[:error] = t ".no_product"
    redirect_to root_path
  end

  def add_to_card product, quantity
    if @cart.key? product.id.to_s
      @cart[product.id.to_s] += quantity
    else
      @cart[product.id.to_s] = quantity
    end
  end
end
