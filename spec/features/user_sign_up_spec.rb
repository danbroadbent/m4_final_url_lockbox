require "rails_helper"

RSpec.describe "User signup" do
  scenario "Unauthenticated user visits signup form" do
    visit "/"

    expect(current_path).to eq('/signup')
  end

  scenario "Unauthenticated user signs up" do
    visit "/"

    expect(page).not_to have_text("Logout")

    fill_in "user[email]", with: "joe@example.com"
    fill_in "user[password]", with: "password"
    fill_in "user[password_confirmation]", with: "password"
    click_on "Submit"

    expect(page).to have_text("Logout")
    expect(page).to have_text("Succesfully logged in")
    expect(current_path).to eq('/')
  end

  # scenario "Email is already taken" do
  #   User.new({email: 'joe@example.com'})
  #
  #   visit "/"
  #   click_on "Sign Up"
  #   fill_in "Email:", with: "joe@example.com"
  #   fill_in "Password:", with: "password"
  #   fill_in "Confirm Password:", with: "password"
  #   click_on "Submit"
  #
  #   expect(page).to have_text("That email address that has already been used, please use a different email")
  #   expect(current_path).to eq('/signup')
  # end
  #
  # scenario "Password and password confirmation don't match" do
  #   visit "/"
  #   click_on "Sign Up"
  #   fill_in "Email:", with: "joe@example.com"
  #   fill_in "Password:", with: "password"
  #   fill_in "Confirm Password:", with: "wordpass"
  #   click_on "Submit"
  #
  #   expect(page).to have_text("Your passwords do not match, please try again")
  #   expect(current_path).to eq('/signup')
  # end
end
