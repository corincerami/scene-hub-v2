require "rails_helper"

feature "User edits a band" do
  it "submits a valid form" do
    user = create(:user_with_bands)
    band = user.bands.first

    sign_in(user)

    visit band_path(band)
    click_on "Edit band"
    fill_in  "Name", with: "NEW BAND"
    fill_in "Genre", with: "classical"
    fill_in "Spotify URI", with: "spotify:artist:3pZ666b6CyO1KGpVYirY0t"
    click_on "Update band"

    expect(page).to have_content "NEW BAND"
    expect(page).to have_content "classical"
    expect(page).to have_content "Band updated!"
  end

  it "fills in invalid information" do
    user = create(:user_with_bands)
    band = user.bands.first

    sign_in(user)

    visit band_path(band)
    click_on "Edit band"
    fill_in  "Name", with: ""
    fill_in "Spotify URI", with: "spotify:artist:3pZ666b6CyO1KGpVYirY"
    click_on "Update band"

    expect(page).to have_content "Name can't be blank"
    expect(page).to have_content "Spotify uri should be the URI for an artist on Spotify"
  end

  it "attempts to edit a band the user did not create" do
    user = create(:user_with_bands)
    user_2 = create(:user)
    band = user.bands.first

    sign_in(user_2)

    visit band_path(band)

    expect(page).not_to have_content "Edit band"
  end
end
