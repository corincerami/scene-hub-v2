require 'rails_helper'

# ### As a musician
#   I want to be able to edit shows I've posted
#   So I can keep my fans up to date

# #### Acceptance Criteria
# - [ ] Clicking on an Edit Show button should bring me to an edit form
# - [ ] Submitting a valid form should bring me back to the show page
# - [ ] Submitting an invalid form should re-render the form with an error

feature "User edits a show" do
  it "fills in valid information" do
    show = create(:show)
    visit show_path(show)
    click_on "Edit show"
    fill_in "Band", with: "Priests"
    fill_in "Venue name", with: "Knitting Factory"
    click_on "Save changes"
    expect(page).to have_content "Priests"
    expect(page).to have_content "Knitting Factory"
    expect(page).to have_content "Show updated!"
  end

  it "fill in invalid information" do
    show = create(:show)
    visit show_path(show)
    click_on "Edit show"
    fill_in "Band", with: ""
    fill_in "Venue name", with: ""
    click_on "Save changes"
    expect(page).to have_content "Name can't be blank"
    expect(page).to have_content "Venue name can't be blank"
  end
end
