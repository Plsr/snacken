# frozen_string_literal: true

class UsersController < ApplicationController
  skip_before_action :require_login, only: [:new, :create, :activate]

  def show
    @user = current_user
  end

  def new
    @user = User.new
  end

  def edit
    @user = current_user
  end

  def create
    @user = User.new(user_params)

    if @user.save
      redirect_to root_path, notice: 'Registered successfully'
    else
      render :new
    end
  end

  def update
    @user = current_user
    if @user.update(user_params)
      redirect_to profile_path, notice: 'Update Successful'
    else
      render :edit
    end
  end

  def destroy
    # TODO: Check if user is allowed
    current_user.destroy
    redirect_to root_path, notice: 'User was successfully destroyed.'
  end

  def activate
    if @user = User.load_from_activation_token(params[:id])
      @user.activate!
      redirect_to(login_path, :notice => 'User was successfully activated.')
    else
      not_authenticated
    end
  end

  private
    def user_params
      params.require(:user).permit(:email, :password, :password_confirmation, :invite_code)
    end
end
