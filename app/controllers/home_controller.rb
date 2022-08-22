class HomeController < ApplicationController
  def index
    @latests = Product.newest.take(Settings.num_products)
    @categories = Category.random
                          .limit(Settings.num_categories)
                          .includes(:products)
    render "customer/home/index"
  end

  def menu
    @pagy, @products = pagy(Product.search_by_name(params[:search]),
                            item: Settings.pagy.item)
    render "menu/index"
  end
end
