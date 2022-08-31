class SessionsController < ApplicationController
  def new
    render :new, layout: "authentication"
  end

  def create
    user = User.find_by email: params[:session][:email].downcase
    if user&.authenticate params[:session][:password]
      handle_log_in user
    else
      flash.now[:error] = t ".invalid"
      render :new, layout: "authentication"
    end
  end

  def destroy
    log_out if logged_in?
    redirect_to root_path
  end
end
