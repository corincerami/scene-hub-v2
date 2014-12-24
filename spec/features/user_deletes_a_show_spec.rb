require 'rails_helper'

# ### As a musician
#   I want to be able to delete shows I've posted
#   So I can remove shows that are cancelled

# #### Acceptance Criteria
# - [ ] Click on a Delete Show button should show a confirmation dialog
# - [ ] Confirming should delete the show and redirect to the index

feature "User deletes a show" do
  it "removes the show from the index page" do
    show = create(:show)
    user = create(:user)
    visit new_user_session_path
    fill_in "Emai", with: user.email
    fill_in "Password", with: user.password
    click_on "Log in"
    visit show_path(show)
    click_on "Delete show"
    expect(page).not_to have_content show.venue.name
    expect(page).not_to have_content show.bands.first.name
    expect(page).to have_content "Show deleted!"
  end
end
