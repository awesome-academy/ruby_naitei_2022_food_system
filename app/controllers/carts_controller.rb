class CartsController < ApplicationController
  include ActionView::Helpers::NumberHelper

  before_action :find_product_by_id, except: [:show, :clear, :destroy]
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

  def update
    quantity = params[:quantity].to_i
    id = params[:id]
    if quantity <= @product.stock_quantity
      update_cart_item id, quantity
      sub_total = price_format sub_total(id)
      total = price_format(cart_total)
      render json: {status: 200, message: t(".success"),
                    cart_items_count: items_count,
                    sub_total: sub_total,
                    total: total}
    else
      render json: {status: 500, message: t(".failed")}
    end
  end

  def destroy
    if @cart.key? params[:id]
      @cart.delete params[:id]
      total = price_format(cart_total)
      render json: {status: 200, message: t(".success"),
                    cart_items_count: items_count,
                    total: total}
    else
      render json: {status: 500, message: t(".failed")}
    end
  end

  def clear
    clear_cart
    flash[:success] = t ".success"
    redirect_to carts_path
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

  def update_cart_item id, quantity
    (@cart[id] = quantity) if @cart.key? id
  end

  def price_format price
    number_to_currency(price, {unit: "đ ", precision: 0})
  end
end
