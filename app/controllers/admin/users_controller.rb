class Admin::UsersController < Admin::AdminController
  before_action :load_user, except: :index

  def index
    @pagy, @users = pagy(User.all, items: Settings.pagy.items)
  end

  def show; end

  def destroy
    if @user.destroy
      flash[:success] = t ".delete_success"
    else
      flash[:error] = t ".delete_failed"
    end
    redirect_to admin_users_path
  end

  private

  def load_user
    @user = User.find_by id: params[:id]
    return if @user

    flash[:error] = t ".not_found"
    redirect_to admin_users_path
  end
end
