# frozen_string_literal: true

class UsersController < ApplicationController
  skip_before_action :require_login, only: [:new, :create]
  before_action :set_user, only: [:show, :edit, :update, :destroy]

  def show; end

  def new
    @user = User.new
  end

  def edit; end

  def create
    @user = User.new(user_params)

    if @user.save
      redirect_to root_path, notice: 'Registered Successful'
    else
      render :new
    end
  end

  def update; end

  def destroy
    # TODO: Check if user is allowed
    @user.destroy
    redirect_to users_url, notice: 'User was successfully destroyed.'
  end

  private
    def user_params
      params.require(:user).permit(:email, :password, :password_confirmation)
    end
end
