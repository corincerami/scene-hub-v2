require "rails_helper"

feature "User delete a comment" do
	it "removes the comment from the show page" do
		show = create(:show)
		comment = show.comments.first
		user = comment.user
		title = comment.title
		body = comment.body

	  sign_in(user)

	  visit show_path(show)
	  click_on "Delete comment"
	  expect(page).to have_content "Comment deleted"
	  expect(page).not_to have_content title
	  expect(page).not_to have_content body
	end
end
