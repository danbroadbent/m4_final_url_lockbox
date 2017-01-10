require "rails_helper"

RSpec.describe "Links belong to users" do
  scenario "create a new link" do
    User.create({id:1})
    link = Link.create({title: 'Turing', url: 'http://turing.io', user_id: 1})
    user = User.find(1)

    expect(user.links.last).to eq(link)
    expect(Link.last.url).to eq("http://turing.io")
  end

  scenario "logged in user only sees own links" do
    Link.create({title: 'Turing', url: 'http://turing.io', user_id: 100})
    login_user
    visit '/'

    expect(page).to_not have_text('Turing')
    expect(page).to_not have_text('http://turing.io')
  end
end
