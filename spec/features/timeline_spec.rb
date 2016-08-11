require "rails_helper"

feature "Timeline" do
  let(:user) { create(:user) }
  let(:following) { create(:user) }
  let!(:following_tweets) { create_list(:tweet, 5, user_id: following.id) }
  let!(:user_tweets) { create_list(:tweet, 5, user_id: user.id) }

  scenario "User can see his tweets and following", js: true do
    sign_in(user)
    user.follow(following)
    visit timeline_user_path(user)

    following_tweets.each do |attr|
      expect(page).to have_content attr.body.to_s
    end

    user_tweets.each do |attr|
      expect(page).to have_content attr.body.to_s
    end
  end

  scenario "User can't see not following tweets" do
    sign_in(user)
    visit timeline_user_path(user)

    following_tweets.each do |attr|
      expect(page).to_not have_content attr.body.to_s
    end

    user_tweets.each do |attr|
      expect(page).to have_content attr.body.to_s
    end
  end

  scenario "User can create tweet from timeline", js: true do
    sign_in(user)
    visit timeline_user_path(user)
    within ".tweet_form" do
      fill_in "Body", with: "New tweet"
      click_on "Tweet"
    end
    expect(page).to have_content "New tweet"
  end
end
