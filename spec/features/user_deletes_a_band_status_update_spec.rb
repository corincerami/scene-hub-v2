require "rails_helper"

feature "User deletes a band status update" do
	it "removes the post from the band profile" do
		user = create(:user_with_bands)
		band = user.bands.first
		band.band_posts << create(:band_post)
		post = band.band_posts.first

		sign_in(user)

		visit band_path(band)
		click_on "Delete status"

		expect(page).to have_content "Status deleted!"
		expect(page).not_to have_content post.title
		expect(page).not_to have_content post.content
	end

	it "attempts to delete a post from a band it didn't create" do
		user = create(:user_with_bands)
		user_2 = create(:user)
		band = user.bands.first
		band.band_posts << create(:band_post)
		post = band.band_posts.first

		sign_in(user_2)

		visit band_path(band)

		expect(page).not_to have_content "Delete status"
	end
end
