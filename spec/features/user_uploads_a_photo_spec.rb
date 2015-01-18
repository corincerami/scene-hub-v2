require "rails_helper"

feature "User uploads a photo for their band" do
  it "shows the photo on the band's profile" do
    user = create(:user_with_bands)
    band = user.bands.first

    sign_in(user)

    visit band_path(band)

    click_on "Upload photo"
    attach_file("photo_image", "app/assets/images/marissa.jpg")
    click_on "Submit Photo"

    expect(page).to have_content "Photo uploaded"
    expect(page.find('#band-photo')['src']).to have_content 'marissa.jpg'
  end

  it "doesn't select a file to submit" do
    user = create(:user_with_bands)
    band = user.bands.first

    sign_in(user)

    visit band_path(band)

    click_on "Upload photo"
    click_on "Submit Photo"

    expect(page).to have_content "Image file name can't be blank"
  end

  it "selects a file of an invalid format" do
    user = create(:user_with_bands)
    band = user.bands.first

    sign_in(user)

    visit band_path(band)

    click_on "Upload photo"
    attach_file("photo_image", "README.md")
    click_on "Submit Photo"

    expect(page).to have_content "Image content type is invalid"
  end

  it "attempts to upload a photo without signing in" do
    user = create(:user_with_bands)
    band = user.bands.first

    visit band_path(band)

    expect(page).not_to have_content "Upload photo"
  end

  it "attempts to upload a photo for a band the user didn't create" do
    user = create(:user_with_bands)
    user_2 = create(:user)
    band = user.bands.first

    sign_in(user_2)

    visit band_path(band)

    expect(page).not_to have_content "Upload photo"
  end
end
