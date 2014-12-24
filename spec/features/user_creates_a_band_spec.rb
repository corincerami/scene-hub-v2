require 'rails_helper'

feature "User creates a band on their profile" do
  it "enters valid information" do
    user = create(:user)
    visit new_user_session_path
    fill_in "Emai", with: user.email
    fill_in "Password", with: user.password
    click_on "Log in"

    visit user_path(user)
    click_on "Add a band"
    fill_in  "Name", with: "Screaming Females"
    click_on "Create band"

    expect(page).to have_content user.bands.first.name
    expect(page).to have_content "Band created!"
  end

  it "enters invalid information" do
    user = create(:user)
    visit new_user_session_path
    fill_in "Emai", with: user.email
    fill_in "Password", with: user.password
    click_on "Log in"

    visit user_path(user)
    click_on "Add a band"
    click_on "Create band"

    expect(page).to have_content "Name can't be blank"
  end
end
