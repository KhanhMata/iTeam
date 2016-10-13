class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  include SessionsHelper

  def logged_in_user
    unless logged_in?
      flash[:danger] = t "please_login"
      redirect_to login_url
    end
  end

  def load_user
    @user = User.find_by id: params[:id]
    unless @user
      flash[:danger] = t "controllers.application.flash.danger.invalid_user"
      redirect_to root_url
    end
  end

  def verify_user
    @user = User.find_by id: params[:id]
    redirect_to root_url unless is_user? @user
  end

  def verify_admin
    redirect_to(root_url) unless current_user.admin?
  end
end
