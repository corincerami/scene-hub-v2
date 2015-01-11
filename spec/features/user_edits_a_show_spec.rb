require 'rails_helper'

# ### As a musician
#   I want to be able to edit shows I've posted
#   So I can keep my fans up to date

# #### Acceptance Criteria
# - [x] Clicking on an Edit Show button should bring me to an edit form
# - [x] Submitting a valid form should bring me back to the show page
# - [x] Submitting an invalid form should re-render the form with an error

feature "User edits a show" do
  before(:each) do
    @show = create(:show)
    @user = @show.bands.first.user
    
    sign_in(@user)

    visit show_path(@show)
  end

  it "fills in valid information" do
    click_on "Edit show"
    select @show.bands.first.name, from: "Band"
    fill_in "Venue name", with: "Knitting Factory"
    click_on "Save changes"
    expect(page).to have_content @show.bands.first.name
    expect(page).to have_content "Knitting Factory"
    expect(page).to have_content "Show updated!"
  end

  it "fill in invalid information" do
    click_on "Edit show"
    fill_in "Venue name", with: ""
    click_on "Save changes"
    expect(page).to have_content "Name can't be blank"
    expect(page).to have_content "Venue name can't be blank"
  end
end
