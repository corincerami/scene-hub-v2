require 'rails_helper'
require 'date'

feature "User posts a show" do
  it "sees the show on the page" do
    user = FactoryGirl.create(:user_with_bands)
    visit new_user_session_path
    fill_in "Emai", with: user.email
    fill_in "Password", with: user.password
    click_on "Log in"
    visit new_show_path
    select  user.bands.first.name, from: "Band"
    fill_in "Venue name", with: "Great Scott"
    fill_in "Street 1", with: "1222 Commonwealth Ave"
    fill_in "City", with: "Allston"
    fill_in "State", with: "MA"
    fill_in "Zip code", with: "02134"
    fill_in "Show date", with: DateTime.now
    click_on "Post show"

    expect(page).to have_content "Show created!"
    expect(page).to have_content "Screaming Females"
    expect(page).to have_content "Great Scott"
    expect(page).to have_content "1222 Commonwealth Ave"
  end

  it "submits a blank form" do
    user = create(:user)
    visit new_user_session_path
    fill_in "Emai", with: user.email
    fill_in "Password", with: user.password
    click_on "Log in"
    visit new_show_path

    click_on "Post show"

    expect(page).to have_content "Name can't be blank"
    expect(page).to have_content "Street 1 can't be blank"
    expect(page).to have_content "City can't be blank"
    expect(page).to have_content "State can't be blank"
    expect(page).to have_content "Zip code can't be blank"
    expect(page).to have_content "Show date can't be blank"

  end
end

