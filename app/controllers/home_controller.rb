class HomeController < ApplicationController
  before_action :authenticate_user!

  def index
    @tweets = Tweet.where("user_id in (?) OR user_id = ?", current_user.following_ids, current_user).order("created_at DESC")
  end
end
