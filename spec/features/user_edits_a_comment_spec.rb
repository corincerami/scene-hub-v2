require 'rails_helper'

feature "User edits a comment" do
	it 'fills in the title and body' do
		show = create(:show)
		comment = show.comments.first
    user = comment.user

    sign_in(user)

    visit show_path(show)
    click_on "Edit comment"
    fill_in "Title", with: "New title"
    fill_in "Body", with: "New body"
		click_on "Submit comment"

		expect(page).to have_content "Comment updated!"
		expect(page).to have_content "New title"
		expect(page).to have_content "New body"
	end

	it "leave the comment blank" do
		show = create(:show)
		comment = show.comments.first
    user = comment.user

    sign_in(user)

    visit show_path(show)
    click_on "Edit comment"
    fill_in "Body", with: ""
		click_on "Submit comment"

		expect(page).to have_content "Body can't be blank"
	end
end
