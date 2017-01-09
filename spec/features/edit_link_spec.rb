require "rails_helper"

RSpec.describe "Can edit links" do
  scenario "edit a new link" do
    Link.create({title: 'Turing', url: 'http://turing.io'})
    login_user
    visit '/links/1/edit'
    fill_in "link[title]", with: "Turing 2"
    fill_in "link[url]", with: "http://turing.io/2"
    click_on "Submit"

    expect(Link.last.title).to eq("Turing 2")
    expect(Link.last.url).to eq("http://turing.io/2")
  end

  scenario "Invalid link" do
    Link.create({title: 'Turing', url: 'http://turing.io', id: 2})
    login_user
    visit '/links/2/edit'
    fill_in "link[title]", with: "Turing 2"
    fill_in "link[url]", with: "turing 2"
    click_on "Submit"

    expect(page).to have_text("Url is not a valid URL")
  end
end
