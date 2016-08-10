class UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_tweet, only: [:show, :timeline]
  before_action :set_user, only: [:show, :followers, :following, :follow, :unfollow, :timeline]
  respond_to :html, :js

  def index
    @user = current_user
    respond_with @users = User.includes(:tweets).where.not(id: current_user.id)
  end

  def show
    respond_with @tweets = Tweet.includes(:user).where(user_id: @user.id).order("created_at DESC").paginate(:page => params[:page], per_page: 10)

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

  def timeline
    respond_with @tweets = Tweet.includes(:user).where("user_id IN (?) OR user_id = ?",
                                                        @user.following_ids,
                                                        @user.id).order("created_at DESC").paginate(:page => params[:page],
                                                                                                per_page: 10)
  end

  private

  def set_user
    @user = User.find(params[:id])
    authorize @user
  end

  def set_tweet
    @tweet = current_user.tweets.build
  end
end
