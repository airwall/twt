require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  sign_in_user
  let(:users) { create_list(:user, 4) }
  let(:tweets) { create_list(:tweet, 2, user_id: @user.id) }
  let(:following) { create(:user) }
  let(:followers) { create(:user) }

  describe "/GET index" do
    before { get :index }
    it "populates an array all users" do
      expect(assigns(:users)).to match_array(users << @user)
    end

    it "render index view" do
      expect(response).to render_template :index
    end
  end

  describe "/GET show" do
    context "current_user page" do
      before { get :show, params: { id: @user.id } }
      it "populates an array all tweets" do
        expect(assigns(:tweets)).to match_array(tweets)
      end

      it "render show view" do
        expect(response).to render_template :show
      end
    end
  end

  describe "/GET following" do
    before { get :following, params: { id: @user } }
    it "populates an array followers page" do
      @user.follow(following)
      expect(assigns(:following)).to match_array(following)
    end

    it "render user view" do
      expect(response).to render_template :following
    end
  end

  describe "/GET followers" do
    before { get :followers, params: { id: @user } }
    it "populates an array followers page" do
      followers.follow(@user)
      expect(assigns(:followers)).to match_array(followers)
    end

    it "render user view" do
      expect(response).to render_template :followers
    end
  end
end
