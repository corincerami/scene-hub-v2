require "rails_helper"

feature "User delete a comment" do
	it "removes the comment from the show page" do
		show = create(:show)
		user = show.bands.first.user
		band = show.bands.first
		comment = show.comments.first
		title = comment.title
		body = comment.body

	    visit new_user_session_path
	    fill_in "Emai", with: user.email
	    fill_in "Password", with: "password123"
	    click_on "Log in"

	    visit show_path(show)
	    click_on "Delete comment"
	    expect(page).to have_content "Comment deleted"
	    expect(page).not_to have_content title
	    expect(page).not_to have_content body
	end
end