class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  protect_from_forgery with: :null_session
  before_action :set_cart

  add_flash_types :success, :info, :warning, :danger

  helper_method :current_user, :set_redirect, :current_admin?

  def set_redirect
    if request.referrer == "/login"
      session[:redirect] = dashboard_path
    else
      session[:redirect] = request.referrer || dashboard_path
    end
  end

  def current_user
    @current_user ||= User.find_by(username: session[:username])
  end

  def set_cart
    @cart ||= Cart.new(session[:cart])
  end

  def require_user
    redirect_to "/errors/not_found.html" unless current_user
  end

  def current_admin?
    current_user && current_user.admin?
  end
end
