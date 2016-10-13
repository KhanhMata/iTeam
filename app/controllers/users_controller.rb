class UsersController < ApplicationController

  before_action :logged_in_user, except: [:new, :create, :show]
  before_action :verify_user, only: [:edit, :update]
  before_action :load_user, except: [:index, :new, :create]

  def show
  end

  def index
    @users = User.newest.paginate page: params[:page],
      per_page: Settings.user_per_page
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new user_params
    if @user.save
      log_in @user
      flash[:success] = t "welcome"
      redirect_to @user
    else
      flash[:danger] = t "unsuccess"
      render :new
    end
  end

  def edit
  end

  def update
    if @user.update_attributes user_params
      flash[:success] = t "profileupdated"
      redirect_to @user
    else
      flash[:danger] = t "unsuccess"
      render :edit
    end
  end

  private

  def user_params
    params.require(:user).permit :name, :email,
      :chatwork_id, :password, :password_confirmation
  end

end
