class TweetsController < ApplicationController
  before_action :authenticate_user!
  respond_to :js

  def create
    respond_with @tweet = current_user.tweets.create(tweet_params)
  end

  private

  def tweet_params
    params.require(:tweet).permit(:body)
  end
end
