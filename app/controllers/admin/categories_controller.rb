class Admin::CategoriesController < Admin::AdminController
  before_action :find_category, only: %i(edit update destroy)

  def index
    @pagy, @categories = pagy(Category.all, item: Settings.category.item)
  end

  def new
    @category = Category.new
  end

  def edit; end

  def update
    if @category.update category_params
      flash[:success] = t "flashes.update_success"
      redirect_to admin_categories_url
    else
      flash[:danger] = t "flashes.update_failed"
      render :edit
    end
  end

  def create
    @category = Category.new category_params
    if @category.save
      flash[:success] = t "flashes.create_success"
      redirect_to admin_categories_path
    else
      flash[:danger] = t "flashes.create_failed"
      render :new
    end
  end

  def destroy
    if @category.destroy
      flash[:success] = t "flashes.delete_success"
    else
      flash[:danger] = t "flashes.delete_failed"
    end
    redirect_to admin_categories_url
  end

  private
  def category_params
    params.require(:category).permit(:name, :parent_id)
  end

  def find_category
    @category = Category.find_by id: params[:id]
    return if @category

    flash[:danger] = t "flashes.not_found"
    redirect_to admin_categories_url
  end
end
