require "rails_helper"

RSpec.describe "User login" do
  scenario "Unauthenticated user visits login form" do
    visit "/"
    click_on "Log In"

    expect(current_path).to eq('/login')
  end

  scenario "Unauthenticated user logs in" do
    visit "/"
    
    expect(page).not_to have_text("Logout")

    click_on "Log In"
    fill_in "Email:", with: "joe@example.com"
    fill_in "Password:", with: "password"
    click_on "Submit"

    expect(page).to have_text("Logout")
    expect(current_path).to eq('/')
  end
end
