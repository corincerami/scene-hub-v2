require 'rails_helper'

feature "User edits a band status update" do
	it "fills in a new title and body" do
		user = create(:user_with_bands)
		band = user.bands.first
		band.band_posts << create(:band_post)

		sign_in(user)

		visit band_path(band)
		click_on "Edit status"
		fill_in "Title",   with: "New title"
		fill_in "Content", with: "New post content"
		click_on "Save changes"

		expect(page).to have_content "New title"
		expect(page).to have_content "New post content"
		expect(page).to have_content "Status updated!"
	end

	it "leave the form blank" do
		user = create(:user_with_bands)
		band = user.bands.first
		band.band_posts << create(:band_post)

		sign_in(user)

		visit band_path(band)
		click_on "Edit status"
		fill_in "Title",   with: ""
		fill_in "Content", with: ""
		click_on "Save changes"

		expect(page).to have_content "Title can't be blank"
		expect(page).to have_content "Content can't be blank"
	end
end
