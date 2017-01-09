# RSpec.describe "User logout" do
#   scenario "Authenticated user logs out" do
#     User.new({email: 'joe@example.com', password: 'password'})
#     visit "/"
#     click_on "Log In"
#     fill_in "Email:", with: "joe@example.com"
#     fill_in "Password:", with: "password"
#     click_on "Submit"
#     click_on "Logout"
#
#     expect(page).to have_text("Log In")
#     expect(current_path).to eq('/')
#   end
# end
