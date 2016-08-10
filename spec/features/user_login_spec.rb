require "rails_helper"

feature "All users can signup/signin" do
  let(:user) { create(:user) }

  scenario "Guest can signup" do
    visit root_path
    expect(page).to have_content "Create a account"
    within ".registration_form" do
      fill_in "Email", with: "test@mail.com"
      fill_in "Username", with: "testuser"
      fill_in "Password", with: "1234567"
      fill_in "Password confirmation", with: "1234567"
      click_on "Sign up"
    end
    expect(page).to have_content "@testuser"
  end

  scenario "User can sign in" do
    visit root_path
    expect(page).to have_content "Sign In"
    within ".sign_in_form" do
      fill_in "Login", with: user.username
      fill_in "Password", with: user.password
      click_on "Sign in"
    end
    expect(page).to have_content "@#{user.username}"
  end
end
