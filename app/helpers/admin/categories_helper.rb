module Admin::CategoriesHelper
  def category_collect
    Category.pluck(:name, :id).insert(0, ["None", 0])
  end

  def category_options
    Category.pluck :name, :id
  end
end
