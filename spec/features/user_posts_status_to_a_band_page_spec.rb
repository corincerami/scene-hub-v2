require 'rails_helper'

# ### As a musician
#   I want to post status alerts to my band profile
#   So that I can share news with my fans

# #### Acceptance Criteria
# - [x] Visiting the band show page should have a form for updates
# - [x] Posts should appear on the band profile, newest first
# - [x] Only the user who created the band can post to the profile
# - [x] An invalid form should render the band page and flash an error

feature "User posts a status update to their band's profile" do
	it "valid posts appear on the band page" do
		user = create(:user_with_bands)
		band = user.bands.first

		sign_in(user)

		visit band_path(band)
		post_1 = "Our new album is out!"
		fill_in "Title",    with: "Album news"
		fill_in "Content",  with: post_1
		click_on "Post status update"
		post_2 = "And...we broke up"
		fill_in "Title",    with: "Sad news"
		fill_in "Content",     with: post_2
		click_on "Post status update"

		expect(page).to have_content "Our new album is out!"
		expect(page).to have_content "And...we broke up"
		expect(post_2).to appear_before(post_1)
	end

	it "posts without a title/content are not saved" do
		user = create(:user_with_bands)
		band = user.bands.first

		sign_in(user)

		visit band_path(band)
		click_on "Post status update"

		expect(page).to have_content "Title can't be blank"
		expect(page).to have_content "Content can't be blank"
	end
end
