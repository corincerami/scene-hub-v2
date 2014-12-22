require 'rails_helper'

# - As a fan
#   I want to be able to see all of the shows happening in my area
#   So I can find some cool music to see

# ### Acceptance Criteria
# - [] Shows must be geocoded in the database
# - [] Users can search by zip code
# - [] Users can select a distance radius
# - [] Users can see all shows within the chosen radius

feature 'User searches for a show' do
  it "sees nearby shows when a valid zip code is entered" do
    show_1 = create(:show)
    show_2 = create(:show)
    visit '/'

    fill_in "Zip code", with: "02145"
    fill_in "Distance", with: "10"
    click_on "Search"

    show_1.bands.each do |band|
      expect(page).to have_content band.name
    end
    show_2.bands.each do |band|
      expect(page).to have_content band.name
    end
  end

  it "doesn't see shows that aren't within range" do
    show_1 = create(:show)
    show_2 = create(:show)
    visit '/'

    fill_in "Zip code", with: "07110"
    fill_in "Distance", with: "10"
    click_on "Search"

    expect(page).to have_content "No shows found"
    show_1.bands.each do |band|
      expect(page).not_to have_content band.name
    end
    show_2.bands.each do |band|
      expect(page).not_to have_content band.name
    end
  end
end
