require "rails_helper"

RSpec.describe HomeController, type: :controller do
  sign_in_user
  let(:tweets) { create_list(:tweet, 4, user_id: @user.id) }

  describe "/GET index" do
    before { get :index }
    it "populates an array all tweets" do
      expect(assigns(:tweets)).to match_array(tweets)
    end

    it "render index view" do
      expect(response).to render_template :index
    end
  end
end
