require 'rails_helper'

feature "User visits their profile page" do
  it "sees their information" do
    band = create(:band)
    user = band.user
    user.bands << band
    visit user_path(user)
    expect(page).to have_content user.email
    expect(page).to have_content user.bands.first.name
  end
end
