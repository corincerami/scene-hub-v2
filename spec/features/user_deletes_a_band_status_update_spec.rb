require "rails_helper"

feature "User deletes a band status update" do
	it "removes the post from the band profile" do
		user = create(:user_with_bands)
		band = user.bands.first
		band.band_posts << create(:band_post)
		post = band.band_posts.first

		visit new_user_session_path
		fill_in "Email",    with: user.email
		fill_in "Password", with: user.password
		click_on "Log in"

		visit band_path(band)
		click_on "Delete status"

		expect(page).to have_content "Status deleted!"
		expect(page).not_to have_content post.title
		expect(page).not_to have_content post.content
	end
end