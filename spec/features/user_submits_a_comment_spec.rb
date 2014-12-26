require 'rails_helper'

# ### As a User
#   I want to comment on shows
#   So I can communicate with other people who are going

# #### Acceptance Criteria
# - [ ] Clicking on the comment button should take me to a comments form
# - [ ] Comments should have a body and an optional title
# - [ ] Upon submitting my comment, I should see it on the show page

feature "User submits a comment" do
	it "appears on the show page" do
		show = create(:show)
		user = show.bands.first.user
		band = show.bands.first

	    visit new_user_session_path
	    fill_in "Emai", with: user.email
	    fill_in "Password", with: user.password
	    click_on "Log in"

	    visit show_path(show)
	    fill_in "Title", with: "Comment title"
		fill_in "Body", with: "This is a comment."
		click_on "Submit comment"

		expect(page).to have_content "Comment posted!"
		expect(page).to have_content "Comment title"
		expect(page).to have_content "This is a comment"
	end
end