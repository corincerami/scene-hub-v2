require "rails_helper"

feature "User deletes a photo" do
  it "deletes a photo on the user's band page" do
    user = create(:user_with_bands)
    band = user.bands.first
    band.photos << create(:photo)
    photo = band.photos.first
    sign_in(user)

    visit band_path(band)

    click_on "Delete photo"

    expect(page).to have_content "Photo deleted"
  end

  it "attempts to delete a different user's photo" do
    user = create(:user_with_bands)
    user_2 = create(:user)
    band = user.bands.first
    band.photos << create(:photo)
    photo = band.photos.first
    sign_in(user_2)

    visit band_path(band)

    expect(page).not_to have_content "Delete photo"
  end
end
