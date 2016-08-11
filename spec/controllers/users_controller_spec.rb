require "rails_helper"
require "will_paginate/array"

RSpec.describe UsersController, type: :controller do
  sign_in_user
  let(:users) { create_list(:user, 4) }
  let!(:tweets) { create_list(:tweet, 2, user_id: @user.id) }
  let(:following) { create(:user) }
  let(:followers) { create(:user) }

  describe "/GET index" do
    before { get :index }
    it "populates an array all users" do
      expect(assigns(:users)).to match_array(users)
    end

    it "render index view" do
      expect(response).to render_template :index
    end
  end

  describe "/GET show" do
    context "Tweets on show page" do
      before { get :show, params: { id: @user.id } }
      it "populates all tweets" do
        expect(tweets).to eq @user.tweets
      end

      it "populates an array tweets per page" do
        assigns(tweets.paginate(per_page: 10))
      end

      it "render show view" do
        expect(response).to render_template :show
      end

      it "assigns the requested user to @user" do
        expect(assigns(:user)).to eq @user
      end
    end
  end

  describe "/GET following" do
    before { get :following, params: { id: @user } }
    it "populates an array followers page" do
      @user.follow(following)
      expect(following).to eq following
    end

    it "render user view" do
      expect(response).to render_template :following
    end
  end

  describe "/GET followers" do
    before { get :followers, params: { id: @user } }
    it "populates an array followers page" do
      followers.follow(@user)
      expect(followers).to eq followers
    end

    it "render user view" do
      expect(response).to render_template :followers
    end
  end

  describe "/POST follow" do
    let(:follow_post) { post :follow, params: { id: following.id }, format: :js }

    it "follow user" do
      expect { follow_post }.to change(@user.reload.active_relationships, :count).by(1)
    end

    it "render follow.js view" do
      follow_post
      expect(response).to render_template :follow
    end
  end

  describe "/POST unfollow" do
    let(:unfollow_post) { post :unfollow, params: { id: following.id }, format: :js }
    before { @user.follow(following) }

    it "follow user" do
      expect { unfollow_post }.to change(@user.reload.active_relationships, :count).by(-1)
    end

    it "render follow.js view" do
      unfollow_post
      expect(response).to render_template :unfollow
    end
  end

  describe "/GET timeline" do
    context "Tweets on timeline page" do
      before { get :timeline, params: { id: @user.id } }
      it "populates all tweets" do
        expect(tweets).to eq @user.tweets
      end

      it "populates an array tweets per page" do
        assigns(tweets.paginate(per_page: 10))
      end

      it "render show view" do
        expect(response).to render_template :timeline
      end

      it "assigns the requested user to @user" do
        expect(assigns(:user)).to eq @user
      end
    end
  end
end
