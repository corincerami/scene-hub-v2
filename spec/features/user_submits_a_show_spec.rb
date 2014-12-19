require 'rails_helper'

feature "User views all the shows" do
  it "sees the shows on one page" do
    venue = FactoryGirl.create(:venue_with_shows)
    visit shows_path
    save_and_open_page
    expect(page).to have_content "Great Scott"
  end
end
