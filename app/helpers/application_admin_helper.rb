module ApplicationAdminHelper
  include Pagy::Frontend
  def custom_bootstrap_flash
    flash_messages = []
    flash.each do |type, message|
      type = "success" if type == "success"
      type = "error"   if type == "error"
      text = "<script>toastr.#{type}('#{message}');</script>"
      flash_messages << text if message
    end
    flash_messages.join("\n")
  end
end
