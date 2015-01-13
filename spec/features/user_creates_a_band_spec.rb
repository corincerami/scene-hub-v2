require 'rails_helper'

# ### As a musician
#   I want to add genres to my band
#   So people can find us more easily

# #### Acceptance Criteria
# - [x] When creating a new band I must enter at least one genre
# - [x] My band's genres should appear on the band's show page

feature "User creates a band on their profile" do
  it "enters valid information" do
    user = create(:user)

    sign_in(user)

    visit user_path(user)
    click_on "Add a band"
    fill_in  "Name", with: "Screaming Females"
    fill_in "Genres", with: "punk, rock, indie"
    fill_in "Spotify URI", with: "spotify:artist:3pZ666b6CyO1KGpVYirY0t"
    click_on "Create band"

    expect(page).to have_content user.bands.first.name
    expect(page).to have_content "punk"
    expect(page).to have_content "rock"
    expect(page).to have_content "indie"
    expect(page).to have_content "Band created!"
  end

  it "submits a blank form" do
    user = create(:user)

    sign_in(user)

    visit user_path(user)
    click_on "Add a band"
    click_on "Create band"

    expect(page).to have_content "Name can't be blank"
    expect(page).to have_content "Genres can't be blank"
  end

  it "enters a band without genres" do
    user = create(:user)

    sign_in(user)

    visit user_path(user)
    click_on "Add a band"
    fill_in "Name", with: "Screaming Females"
    click_on "Create band"
    expect(page).to have_content "Genres can't be blank"

    visit user_path(user)
    expect(page).not_to have_content "Screaming Females"
  end

  it 'enters invalid input for genres' do
    user = create(:user)

    sign_in(user)

    visit user_path(user)
    click_on "Add a band"
    fill_in  "Name", with: "Screaming Females"
    fill_in "Genres", with: "what is a genre?"
    click_on "Create band"

    expect(page).to have_content "Genres must be entered as a comma separated list"
  end
end
