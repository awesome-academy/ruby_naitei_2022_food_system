class RatingsController < ApplicationController
  before_action :find_product, :logged_in_user, :has_bought_item?, only: :create

  def create
    post = current_user.ratings.by_product(@product.id).first
    if post.blank?
      create_review
    else
      post.update(star: params[:rating], comment: params[:comment])
    end
    flash[:success] = t ".success"
    redirect_to product_path @product
  end

  private

  def find_product
    @product = Product.find_by id: params[:id]
    return if @product

    flash[:error] = t ".no_product"
    redirect_to menu_path
  end

  def has_bought_item?
    return if current_user.orders.map(&:products).flatten.include? @product

    flash[:error] = t ".cant_review"
    redirect_to product_path @product
  end

  def create_review
    new_post = @product.ratings
                       .build(user_id: current_user.id,
                              star: params[:rating],
                              comment: params[:comment])
    return if new_post.save

    flash[:error] = t ".failed"
    redirect_to product_path @product
  end
end
