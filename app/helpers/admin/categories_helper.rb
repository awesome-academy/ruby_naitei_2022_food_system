module Admin::CategoriesHelper
  def category_collect
    Category.pluck(:name, :id).insert(0, ["self", 0])
  end
end
