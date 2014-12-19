require 'rails_helper'
require 'date'

feature "User posts a show" do
  it "sees the show on the page" do
    visit new_show_path
    fill_in "Band name", with: "Screaming Females"
    fill_in "Venue name", with: "Great Scott"
    fill_in "Street 1", with: "1222 Commonwealth Ave"
    fill_in "City", with: "Allston"
    fill_in "State", with: "MA"
    fill_in "Zip code", with: "02134"
    fill_in "Show date", with: DateTime.now
    # page.execute_script("$('#show_show_date').val('21/12/2014')")
    click_on "Post show"

    expect(page).to have_content "Show created!"
    expect(page).to have_content "Screaming Females"
    expect(page).to have_content "Great Scott"
    expect(page).to have_content "1222 Commonwealth Ave"
  end

  it "submits a blank form" do
    visit new_show_path

    click_on "Post show"

    expect(page).to have_content "Name can't be blank"
    expect(page).to have_content "Street 1 can't be blank"
    expect(page).to have_content "City can't be blank"
    expect(page).to have_content "State can't be blank"
    expect(page).to have_content "Zip code can't be blank"
    expect(page).to have_content "Show date can't be blank"

  end
end

