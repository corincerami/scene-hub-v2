require "rails_helper"

# As a user
# I want to remove an RSVP from a show
# So I can update people if my schedule changes

# Acceptance Criteria
# - When logged in, I can remove an RSVP to a show from it's show page,
#   my profile page, or the RSVPs sidebar
# - Shows I unRSVP from should no longer appear in my RSVPed shows list

feature "User removes RSVP from a show" do
  before(:each) do
    @show = create(:show)
    @user = create(:user)
    sign_in(@user)

    visit show_path(@show)
    click_on "RSVP"
  end

  it "should remove the RSVP from the user's profile" do
    click_on "Cancel RSVP"

    expect(page).to have_content "RSVP cancelled"
    expect(page).not_to have_content "You're going to this show!"
    expect(page).not_to have_button "Cancel RSVP"
  end
end
