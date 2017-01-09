RSpec.describe "User logout" do
  scenario "Authenticated user logs out" do
    User.create({email: 'joe@example.com', password: 'password'})
    visit "/"
    click_on "Log In"
    fill_in "email", with: "joe@example.com"
    fill_in "password", with: "password"
    click_on "Submit"
    click_on "Logout"

    expect(page).to have_text("Login")
    expect(current_path).to eq('/login')
  end
end
