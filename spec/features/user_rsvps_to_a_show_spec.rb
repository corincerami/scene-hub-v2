require "rails_helper"

# As a user
# I want to RSVP to a show
# So I can keep track of what shows I want to go to

# Acceptance Criteria
# - When logged in, I can RSVP to a show from it's show page
# - Shows I've RSVPed to should appeaer on my user profile
# - RSVPed shows should also appear on a side bar on the front page
# - I can remove shows from my RSVP list

feature "User RSVPs to a show" do
  before(:each) do
    @show = create(:show)
    @user = create(:user)
    sign_in(@user)

    visit show_path(@show)
    click_on "RSVP"
  end

  it "adds the show to RSVPs from the show page" do
    expect(page).to have_content "RSVPed successfully"
    expect(page).to have_content "You're going to this show!"
  end

  it "sees RSVPed shows on the user profile" do
    visit user_path(@user)

    expect(page).to have_content @show.bands.first.name
    expect(page).to have_content @show.venue.name
    expect(page).to have_content @show.date_and_time
  end

  it "sees RSVPed shows on the index page" do
    visit shows_path

    expect(page).to have_content "You're seeing #{@show.bands.first.name}"
  end
end
