class UsersController < ApplicationController
  before_action :logged_in_user, except: %i(new create)
  before_action :find_user_by_id, except: %i(new create)
  def new
    @user = User.new
    render :new, layout: "authentication"
  end

  def show; end

  def edit; end

  def update
    if @user.update user_params
      flash[:success] = t ".success"
      redirect_to @user
    else
      flash.now[:error] = t ".failed"
      render :edit
    end
  end

  def create
    @user = User.new user_params
    if @user.save
      log_in @user
      flash[:success] = t ".signup_success"
      redirect_to root_path
    else
      flash.now[:error] = t ".signup_failed"
      render :new, layout: "authentication"
    end
  end

  private

  def user_params
    params.require(:user)
          .permit(:name, :email, :password, :password_confirmation,
                  :address, :phone)
  end

  def find_user_by_id
    @user = User.find_by id: params[:id]
    return if @user

    flash[:error] = t ".not_found"
    redirect_to root_path
  end
end
