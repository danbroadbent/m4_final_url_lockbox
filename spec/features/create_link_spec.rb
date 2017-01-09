require "rails_helper"

RSpec.describe "can create links", :js => :true do
  scenario "Create a new link" do
    login_user
    visit "/"
    fill_in "Title:", :with => "Turing"
    fill_in "URL:", :with => "http://turing.io"
    click_on "Add Link"

    within('#links-list') do
      expect(page).to have_text("Turing")
      expect(page).to have_text("http://turing.io")
    end
  end

  scenario "Invalid link" do
    login_user
    visit "/"
    fill_in "Title:", :with => "Turing"
    fill_in "URL:", :with => "turing"
    click_on "Add Link"

    expect(page).to have_text("Invalid link, please use a valid URL")
  end
end
