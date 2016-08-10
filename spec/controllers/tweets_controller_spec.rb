require "rails_helper"

RSpec.describe TweetsController, type: :controller do
  sign_in_user

  describe "/POST create" do
    context "with valid attributes via AJAX" do
      let(:ajax_tweet) { post :create, params: { user_id: @user.id, tweet: attributes_for(:tweet) }, format: :js }

      it "Save tweet for question in database" do
        expect { ajax_tweet }.to change(@user.tweets, :count).by(1)
      end

      it "render create js" do
        ajax_tweet
        expect(response).to render_template :create
      end
    end

    context "with invalid attributes via AJAX" do
      let(:invalid_ajax_tweet) { post :create, params: { user_id: @user.id, tweet: attributes_for(:invalid_tweet) }, format: :js }

      it "Don't save tweet in database" do
        expect { invalid_ajax_tweet }.to_not change(Tweet, :count)
      end

      it "render create js" do
        invalid_ajax_tweet
        expect(response).to render_template :create
      end
    end
  end
end
