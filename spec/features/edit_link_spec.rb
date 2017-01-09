# require "rails_helper"
#
# RSpec.describe "Can edit links" do
#   scenario "edit a new link" do
#     Link.create({title: 'Turing', url: 'http://turing.io'})
#     login_user
#     visit "/"
#     click_on "Edit"
#
#     expect(current_path).to eq('/links/1/edit')
#
#     fill_in "Title", with: "Turing 2"
#     fill_in "URL", with: "http://turing.io/2"
#     click_on "Submit"
#
#     within('#links-list') do
#       expect(page).to have_text("Turing 2")
#       expect(page).to have_text("http://turing.io/2")
#     end
#   end
#
#   scenario "Invalid link" do
#     login_user
#     visit "/"
#     fill_in "Title:", :with => "Turing"
#     fill_in "URL:", :with => "http://turing.io"
#     click_on "Add Link"
#     click_on "Edit"
#
#     expect(current_path).to eq('/links/1/edit')
#
#     fill_in "Title", with: "Turing 2"
#     fill_in "URL", with: "turing 2"
#     click_on "Submit"
#
#     expect(page).to have_text("Url is not a valid URL")
#   end
# end
