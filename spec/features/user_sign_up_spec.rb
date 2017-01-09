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

  scenario "Email is already taken" do
    user = User.create({email: 'joe@example.com', password: 'password'})

    visit "/"
    fill_in "user[email]", with: "joe@example.com"
    fill_in "user[password]", with: "password"
    fill_in "user[password_confirmation]", with: "password"
    click_on "Submit"

    expect(page).to have_text("Email has already been taken")
    expect(current_path).to eq('/signup')
  end

  scenario "Password and password confirmation don't match" do
    visit "/"
    fill_in "user[email]", with: "joe@example.com"
    fill_in "user[password]", with: "password"
    fill_in "user[password_confirmation]", with: "wordpass"
    click_on "Submit"

    expect(page).to have_text("Password confirmation doesn't match Password Signup!")
    expect(current_path).to eq('/signup')
  end
end
