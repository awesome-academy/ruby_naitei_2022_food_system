class HomeController < ApplicationController
  def index
    @latests = Product.newest.take(Settings.num_products)
    @categories = Category.random
                          .limit(Settings.num_categories)
                          .includes(:products)
    render "customer/home/index"
  end
end
