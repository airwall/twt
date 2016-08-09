require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  sign_in_user
  let(:users) { create_list(:user, 4) }

  describe "/GET index" do
    before { get :index }
    it "populates an array all tweets" do
      expect(assigns(:users)).to match_array(users << @user)
    end

    it "render index view" do
      expect(response).to render_template :index
    end
  end

end
