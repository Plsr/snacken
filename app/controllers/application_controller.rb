class ApplicationController < ActionController::Base
  before_action :require_login
  before_action :ensure_activated

  private

  def ensure_activated
    return unless current_user
    return if current_user.activated?
    logout
    redirect_to login_path
  end

  def not_authenticated
    redirect_to login_path, alert: "Please login first"
  end
end
