class UserSessionsController < ApplicationController
  skip_before_action :require_login, only: [:new, :create]

  def new; end

  def create
    user = login(params[:email], params[:password])

    if user
      if user.activated?
        redirect_back_or_to(root_path, notice: 'Login successful') and return 
      else
        logout
        flash.now[:alert] = 'Please verify your email before logging in'
        render :new and return
      end
    else
      flash.now[:alert] = 'Login failed, please check you data'
      render :new and return 
    end
  end

  def destroy
    logout
    redirect_to(root_path, notice: 'Logged out!')
  end
end
