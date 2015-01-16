require 'rails_helper'
require 'date'

feature "User creates a show" do
  it "sees the show on the page" do
    user = create(:user_with_bands)
    follower = create(:user)
    create(:follow, user: follower, band: user.bands.first)
    sign_in(user)

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
    expect(ActionMailer::Base.deliveries.size).to eql(1)
    last_email = ActionMailer::Base.deliveries.last
    expect(last_email).to have_subject("#{user.bands.first.name} announced a new show!")
    expect(last_email).to deliver_to("#{follower.email}")
  end

  it "submits a blank form" do
    user = create(:user_with_bands)
    sign_in(user)

    visit new_show_path
    select user.bands.first.name, from: "Band"
    click_on "Post show"

    expect(page).to have_content "Name can't be blank"
    expect(page).to have_content "Street 1 can't be blank"
    expect(page).to have_content "City can't be blank"
    expect(page).to have_content "State can't be blank"
    expect(page).to have_content "Zip code can't be blank"
    expect(page).to have_content "Show date can't be blank"

  end
end

