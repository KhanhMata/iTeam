class SessionsController < ApplicationController

  def new
  end

  def create
    user = User.find_by email: params[:session][:email].downcase
    if user && user.authenticate(params[:session][:password])
      log_in user
      params[:session][:remember_me] == Settings.remember_value ? remember(user) : forget(user)
      if user.admin?
        redirect_to admin_users_path
      else
        redirect_to user
      end
    else
      flash.now[:danger] = t "unsuccess_login"
      render :new
    end
  end

  def destroy
    log_out if logged_in?
    redirect_to root_url
  end
end
