require 'rails_helper'

# ### As a musician
#   I want to post status alerts to my band profile
#   So that I can share news with my fans

# #### Acceptance Criteria
# - [ ] Visiting the band show page should have a form for updates
# - [ ] Posts should appear on the band profile, newest first
# - [ ] Only the user who created the band can post to the profile
# - [ ] An invalid form should render the band page and flash an error

feature "User posts a status update to their band's profile" do
	it "valid posts appear on the band page" do
		user = create(:user_with_bands)
		band = user.bands.first

		visit new_user_session_path
		fill_in "Email",    with: user.email
		fill_in "Password", with: user.password
		click_on "Log in"

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
		post_1.should appear_before(post_2)
	end
end