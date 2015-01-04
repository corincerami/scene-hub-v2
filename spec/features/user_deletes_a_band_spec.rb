require "rails_helper"

feature "User deletes a band" do
  it "deletes a band the user created" do
    user = create(:user_with_bands)
    band = user.bands.first
    
    sign_in(user)

    visit band_path(band)
    click_on "Delete band"
    expect(page).to have_content "Band deleted!"
  end

  it "attempts to delete a band the user did not create" do
    user = create(:user_with_bands)
    band = user.bands.first
    user_2 = create(:user)

    sign_in(user_2)

    visit band_path(band)
    expect(page).not_to have_content "Delete band"
  end
end
