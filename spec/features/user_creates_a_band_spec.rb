require 'rails_helper'

# ### As a musician
#   I want to add genres to my band
#   So people can find us more easily

# #### Acceptance Criteria
# - [ ] When creating a new band I should be given the option to select genres
# - [ ] On the form, genres should appear as a series of checkboxes
# - [ ] I must select at least one genre, or as many as I like
# - [ ] My band's genre should appear on the band's show page

feature "User creates a band on their profile" do
  it "enters valid information" do
    user = create(:user)
    visit new_user_session_path
    fill_in "Emai", with: user.email
    fill_in "Password", with: user.password
    click_on "Log in"

    visit user_path(user)
    click_on "Add a band"
    fill_in  "Name", with: "Screaming Females"
    fill_in "Genres", with: "punk, rock, indie"
    click_on "Create band"
    expect(page).to have_content user.bands.first.name
    expect(page).to have_content "punk"
    expect(page).to have_content "rock"
    expect(page).to have_content "indie"
    expect(page).to have_content "Band created!"
  end

  it "submits a blank form" do
    user = create(:user)
    visit new_user_session_path
    fill_in "Emai", with: user.email
    fill_in "Password", with: user.password
    click_on "Log in"

    visit user_path(user)
    click_on "Add a band"
    click_on "Create band"

    expect(page).to have_content "Name can't be blank"
    expect(page).to have_content "Genres can't be blank"
  end

  it "enters a band without genres" do
    user = create(:user)
    visit new_user_session_path
    fill_in "Emai", with: user.email
    fill_in "Password", with: user.password
    click_on "Log in"

    visit user_path(user)
    click_on "Add a band"
    fill_in "Name", with: "Screaming Females"
    click_on "Create band"

    expect(page).to have_content "Genres can't be blank"
  end
end
