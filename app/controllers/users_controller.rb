class UsersController < ApplicationController
  before_action :set_user, only: [:show, :followers, :following, :follow, :unfollow]
  before_action :set_tweets, only: :show
  before_action :authenticate_user!
  respond_to :html, :js

  def index
    @user = current_user
    respond_with @users = User.includes(:tweets).where.not(id: current_user.id)
  end

  def show
  end

  def followers
    respond_with @followers = @user.followers
  end

  def following
    respond_with @following = @user.following
  end

  def follow
    respond_with current_user.follow(@user)
  end

  def unfollow
    respond_with current_user.unfollow(@user)
  end


  private

  def set_user
    @user = User.find(params[:id])
  end

  def set_tweets
    if @user == current_user
      @tweets = Tweet.where("user_id in (?) OR user_id = ?", current_user.following_ids, current_user).order("created_at DESC")
    else
      @tweets = Tweet.where(user_id: @user).order("created_at DESC")
    end
  end
end
