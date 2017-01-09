require "rails_helper"

RSpec.describe "User signup" do
  scenario "Unauthenticated user visits signup form" do
    visit "/"
    click_on "Sign Up"

    expect(current_path).to eq('/signup')
  end

  scenario "Unauthenticated user signs up" do
    visit "/"

    expect(page).not_to have_text("Logout")

    click_on "Sign Up"
    fill_in "Email:", with: "joe@example.com"
    fill_in "Password:", with: "password"
    fill_in "Confirm Password:", with: "password"
    click_on "Submit"

    expect(page).to have_text("Logout")
    expect(current_path).to eq('/')
  end
end
