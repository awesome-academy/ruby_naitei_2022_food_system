class HomeController < ApplicationController
  before_action :find_product_by_id, :all_reviews, only: :show

  def index
    @latests = Product.newest.take(Settings.num_products)
    @categories = Category.random
                          .limit(Settings.num_categories)
                          .includes(:products)
    render "customer/home/index"
  end

  def menu
    @pagy, @products = pagy(Product.search_by_name(params[:search]),
                            items: Settings.pagy.items)
    render "menu/index"
  end

  def show
    @related = @product.category.products
                       .not_id(@product.id)
                       .newest
                       .take(Settings.num_products)
    render "customer/products/show"
  end
  private

  def find_product_by_id
    @product = Product.find_by id: params[:id]
    return if @product

    flash[:error] = t ".not_found"
    redirect_to root_path
  end

  def all_reviews
    @pagy_review, @posts = pagy(@product.ratings,
                                items: Settings.pagy.review_items)
  end
end
