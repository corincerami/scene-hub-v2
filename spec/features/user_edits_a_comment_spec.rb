require 'rails_helper'

feature "User edits a comment" do
	it 'fills in the title and body' do
		show = create(:show)
		user = show.bands.first.user
		band = show.bands.first
		comment = show.comments.first

	    visit new_user_session_path
	    fill_in "Emai", with: user.email
	    fill_in "Password", with: "password123"
	    click_on "Log in"

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
		user = show.bands.first.user
		band = show.bands.first
		comment = show.comments.first

	    visit new_user_session_path
	    fill_in "Emai", with: user.email
	    fill_in "Password", with: "password123"
	    click_on "Log in"

	    visit show_path(show)
	    click_on "Edit comment"
	    fill_in "Body", with: ""
		click_on "Submit comment"

		expect(page).to have_content "Body can't be blank"
	end
end