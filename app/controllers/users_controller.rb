class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def show
    @user = User.find_by id: params[:id]
    return if @user

    flash[:danger] = t ".not_found_user"
    redirect_to root_path
  end

  def create
    @user = User.new user_params
    if @user.save
      log_in @user
      flash[:success] = t ".signup_success"
      redirect_to root_path
    else
      flash[:error] = t "shared.error"
      render :new
    end
  end

  private
  def user_params
    params.required(:user).permit(:name, :email, :password,
                                  :password_confirmation)
  end
end
