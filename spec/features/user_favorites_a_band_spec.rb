require "rails_helper"

# As a user
# I want to be able to follow bands
# So I can more easily know when they're performing

# Acceptance Criteria
# - [ ] I can add a band to my follows from their profile
# - [ ] My followed bands should appear on my profile

feature "User favorites a band" do
  before(:each) do
    @band = create(:band)
    @user = create(:user)
    sign_in(@user)

    visit band_path(@band)

    click_button "Follow #{@band.name}"
  end

  it "adds a band to favorites" do
    expect(page).to have_content "Now following #{@band.name}"
    expect(page).to have_content "Following"
    expect(page).to have_button "Stop following #{@band.name}"
    expect(page).not_to have_button "Follow #{@band.name}"
  end

  it "removes a band from favorites" do
    click_button "Stop following #{@band.name}"

    expect(page).to have_content "No longer following #{@band.name}"
    expect(page).not_to have_content "Following"
    expect(page).to have_button "Follow #{@band.name}"
    expect(page).not_to have_button "Stop following #{@band.name}"
  end

  it "sees followed bands on the user profile" do
    visit user_path(@user)

    expect(page).to have_content "#{@band.name}"
  end
end
