module ApplicationHelper
  include Pagy::Frontend
  include ApplicationAdminHelper
  def full_title page_title
    base_title = t ".foodee"
    page_title.blank? ? base_title : [page_title, base_title].join(" | ")
  end
end
