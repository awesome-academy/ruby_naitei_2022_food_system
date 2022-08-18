class Admin::ProductsController < Admin::AdminController
  before_action :find_product_by_id, except: [:index, :new, :create]

  def index
    @pagy, @products = pagy(Product.all.newest, items: Settings.pagy.items)
  end

  def show; end

  def new
    @product = Product.new
  end

  def create
    @product = Product.new product_params
    @product.images.attach(params[:product][:images])
    if @product.save
      flash[:success] = t ".success"
      redirect_to new_admin_product_path
    else
      flash.now[:error] = t ".failed"
      render :new
    end
  end

  def edit; end

  def update
    if @product.update product_params
      flash[:success] = t ".success"
      redirect_to admin_products_path
    else
      flash.now[:error] = t ".failed"
      render :edit
    end
  end

  def destroy
    if @product.destroy
      respond_to do |format|
        format.html{redirect_to admin_products_path}
        format.js
      end
    else
      flash[:error] = t ".failed"
      redirect_to admin_products_path
    end
  end

  private

  def product_params
    params.require(:product)
          .permit(Product::PRODUCT_ATTRS)
  end

  def find_product_by_id
    @product = Product.find_by id: params[:id]
    return if @product

    flash[:error] = t ".not_found"
    redirect_to admin_products_path
  end
end
