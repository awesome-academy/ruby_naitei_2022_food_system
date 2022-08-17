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
      flash[:success] = t ".update_success"
      redirect_to admin_categories_path
    else
      flash.now[:error] = t ".update_failed"
      render :edit
    end
  end

  def create
    @category = Category.new category_params
    if @category.save
      flash[:success] = t ".create_success"
      redirect_to admin_categories_path
    else
      flash.now[:error] = t ".create_failed"
      render :new
    end
  end

  def destroy
    if @category.destroy
      flash[:success] = t ".delete_success"
    else
      flash[:error] = t ".delete_failed"
    end
    redirect_to admin_categories_path
  end

  private
  def category_params
    params.require(:category).permit(:name, :parent_id)
  end

  def find_category
    @category = Category.find_by id: params[:id]
    return if @category

    flash[:error] = t ".not_found"
    redirect_to admin_categories_path
  end
end
