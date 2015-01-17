require 'rails_helper'

# ### As a User
#   I want to comment on shows
#   So I can communicate with other people who are going

# #### Acceptance Criteria
# - [x] Clicking on the comment button should take me to a comments form
# - [x] Comments should have a body and an optional title
# - [x] Upon submitting my comment, I should see it on the show page

feature "User submits a comment" do
	it "posts a comment with a title and body" do
		show = create(:show)
		user = show.band.user
		band = show.band

    sign_in(user)

    visit show_path(show)
    fill_in "Title", with: "Comment title"
		fill_in "Body", with: "This is a comment."
		click_on "Submit comment"

		expect(page).to have_content "Comment posted!"
		expect(page).to have_content "Comment title"
		expect(page).to have_content "This is a comment"
	end

	it "doesn't provide a body" do
		show = create(:show)
		user = show.band.user
		band = show.band

    sign_in(user)

    visit show_path(show)
    click_on "Submit comment"

    expect(page).to have_content "Body can't be blank"
	end
end
