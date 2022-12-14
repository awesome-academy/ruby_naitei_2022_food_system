class ApplicationController < ActionController::Base
  include Pagy::Backend
  include SessionsHelper
  include CartsHelper
  before_action :set_locale, :current_cart, :load_products_in_cart

  private
  def set_locale
    locale = params[:locale].to_s.strip.to_sym
    check = I18n.available_locales.include?(locale)
    I18n.locale = check ? locale : I18n.default_locale
  end

  def default_url_options
    {locale: I18n.locale}
  end
end
