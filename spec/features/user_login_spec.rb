require "rails_helper"

RSpec.describe "User login" do
  scenario "Unauthenticated user visits login form" do
    visit "/"
    click_on "Log In"

    expect(current_path).to eq('/login')
  end

  scenario "Unauthenticated user logs in" do
    User.create({email: 'joe@example.com', password: 'password'})
    visit "/"

    expect(page).not_to have_text("Logout")

    click_on "Log In"
    fill_in "email", with: "joe@example.com"
    fill_in "password", with: "password"
    click_on "Submit"

    expect(page).to have_text("Logout")
    expect(page).to have_text("Succesfully logged in")
    expect(current_path).to eq('/')
  end

  scenario "Email doesn't match password" do
    User.create({email: 'joe@example.com', password: 'password'})
    visit "/"

    expect(page).not_to have_text("Logout")

    click_on "Log In"
    fill_in "email", with: "joe@example.com"
    fill_in "password", with: "wordpass"
    click_on "Submit"

    expect(page).to have_text("Email and password do not match, please try again")
    expect(current_path).to eq('/login')
  end
end
