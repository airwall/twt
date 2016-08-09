class UsersController < ApplicationController
  before_action :set_user, only: :show
  before_action :check_user, only: :show
  before_action :authenticate_user!

  def index
    @users = User.includes(:tweets).all
  end

  def show
    @tweets = @user.tweets.order('created_at DESC')
  end

  private

  def check_user
    if @user == current_user
      redirect_to root_path
    end
  end

  def set_user
    @user = User.find(params[:id])
  end
end
