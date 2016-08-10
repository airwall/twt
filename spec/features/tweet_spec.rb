require "rails_helper"

feature "Tweets" do
  let(:user) { create(:user) }
  scenario "User can create tweet with valid attributes", js: true do
    sign_in(user)
    visit user_path(user)
    within ".tweet_form" do
      fill_in "Body", with: "New tweet"
      click_on "Tweet"
    end
    within ".main-box" do
      expect(page).to have_content "New tweet"
    end
  end

  scenario "User can't create tweet with valid attributes", js: true do
    sign_in(user)
    visit user_path(user)
    within ".tweet_form" do
      fill_in "Body", with: nil
      click_on "Tweet"
    end
    expect(page).to have_content "Body can't be blank"
  end

  scenario "User can't create tweet most 140 length", js: true do
    sign_in(user)
    visit user_path(user)
    body = "body" * 140
    within ".tweet_form" do
      fill_in "Body", with: body
      click_on "Tweet"
    end
    expect(page).to have_content "Body is too long (maximum is 140 characters)"
  end
end
