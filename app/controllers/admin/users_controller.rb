class Admin::UsersController < ApplicationController
  before_action :logged_in_user
  before_action :verify_admin
  before_action :load_user, only: :destroy

  def destroy
    if @user.destroy
      flash[:success] = t "controllers.admin.users.flash.success.delete_user"
    else
      flash[:danger] = t "controllers.admin.users.flash.fail.delete_user"
    end
    redirect_to users_path
  end

  def index
    @users = User.newest.paginate page: params[:page],
      per_page: Settings.user_per_page
  end

  private

  def user_params
    params.require(:user).permit :name, :email,
      :chatwork_id, :password, :password_confirmation
  end

end
