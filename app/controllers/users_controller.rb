class UsersController < ApplicationController
  before_action :set_user, only: [:show, :followers, :following, :follow, :unfollow]
  before_action :set_tweets, only: :show
  before_action :authenticate_user!

  def index
    @user = current_user
    @users = User.includes(:tweets).where.not(id: current_user.id)
  end

  def show
  end

  def followers
    @followers = @user.followers
  end

  def following
    @following = @user.following
  end

  def follow
    current_user.follow(@user)
    # render_following
  end

  def unfollow
    current_user.unfollow(@user)
    # render_following
  end


  private

  # def render_following
  #   render json: { id: @user.id, following: @user.following }
  # end

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
