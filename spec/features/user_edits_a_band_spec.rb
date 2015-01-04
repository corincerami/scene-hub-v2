require "rails_helper"

feature "User edits a band" do
  it "submits a valid form" do
    user = create(:user_with_bands)
    band = user.bands.first
    
    sign_in(user)

    visit band_path(band)
    click_on "Edit band"
    fill_in  "Name", with: "NEW BAND"
    fill_in "Genres", with: "classical, mariacchi"
    click_on "Update band"
    
    expect(page).to have_content user.bands.first.name
    expect(page).to have_content "classical"
    expect(page).to have_content "mariacchi"
    expect(page).to have_content "Band updated!"
  end

  it "leaves the band name blank" do
    user = create(:user_with_bands)
    band = user.bands.first
    
    sign_in(user)

    visit band_path(band)
    click_on "Edit band"
    fill_in  "Name", with: ""
    click_on "Update band"

    expect(page).to have_content "Name can't be blank"
  end

  it "enters genres in an invalid format" do
    user = create(:user_with_bands)
    band = user.bands.first
    
    sign_in(user)

    visit band_path(band)
    click_on "Edit band"
    fill_in  "Genres", with: "classical and mariacchi"
    click_on "Update band"

    expect(page).to have_content "Genres must be entered as a comma separated list"
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
