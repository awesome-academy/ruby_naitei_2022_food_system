class UsersController < ApplicationController
  before_action :logged_in_user, except: %i(new create)

  def new
    @user = User.new
    render :new, layout: "authentication"
  end

  def show; end

  def create
    @user = User.new user_params
    if @user.save
      log_in @user
      flash[:success] = t ".signup_success"
      redirect_to root_path
    else
      flash.now[:error] = t ".signup_failed"
      render :new
    end
  end

  private

  def user_params
    params.require(:user)
          .permit(:name, :email, :password, :password_confirmation)
  end
end
