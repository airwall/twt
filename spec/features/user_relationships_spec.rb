require "rails_helper"

feature "User relationships" do
  let(:user) { create(:user) }
  let!(:followings) { create_list(:user, 4) }

  scenario "User can see list of users" do
    sign_in(user)
    expect(page).to have_link "Users"
    click_on "Users"

    followings.each do |attr|
      expect(page).to have_link "@#{attr.username}"
    end
  end

  scenario "User can follow/unfollow another user from users list", js: true do
    sign_in(user)
    visit users_path

    within "#button_user_#{followings.last.id}" do
      find(".btn.btn-primary.btn-sm").click
      expect(page).to have_css ".btn.btn-success.btn-sm"
      find(".btn.btn-success.btn-sm").click
      expect(page).to have_css ".btn.btn-primary.btn-sm"
    end
  end

  scenario "User can visit another user from users list and follow/unfollow him", js: true do
    sign_in(user)
    visit users_path

    click_on "@#{followings.last.username}"

    within ".twPc-button" do
      within "#button_user_#{followings.last.id}" do
        find(".btn.btn-primary.btn-sm").click
        expect(page).to have_css ".btn.btn-success.btn-sm"
        find(".btn.btn-success.btn-sm").click
        expect(page).to have_css ".btn.btn-primary.btn-sm"
      end
    end
  end
end
