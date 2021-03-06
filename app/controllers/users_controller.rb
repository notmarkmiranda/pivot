class UsersController < ApplicationController
  before_action :require_admin, only: [:index]

  def new
    set_redirect
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      cookies[:auth_token] = @user.auth_token
      redirect_to dashboard_path, notice: "Logged in as #{@user.first_name} #{@user.last_name}"
      UserNotifier.welcome(@user, @user.email).deliver_now
    else
      render :new, danger: @user.errors.full_messages.join(", ")
    end
  end

  def show
    if current_admin?
      @user = User.find_by(username: params[:username])
    else
      render :dashboard
    end
  end

  def index
    @active_users = User.where(active: true)
    @inactive_users = User.where(active: false)
  end

  def destroy
    path = UserDeactivator.call(current_user.id, params[:id])
    if current_user && !current_admin?
      redirect_to logout_path
    elsif current_admin?
      redirect_to users_path, success: "Account deactivated!"
    else
      redirect_to root_path, danger: "You don't have permission"
    end
  end

  def dashboard
    if current_user
      redirect_to admin_dashboard_path if current_admin?
      @user = current_user
    else
      redirect_to login_path
    end
  end

  private

  def user_params
    params.require(:user).permit(:first_name, :last_name, :email, :address, :password, :city, :state, :zipcode, :username)
  end
end
