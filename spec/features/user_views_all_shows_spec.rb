require 'rails_helper'

feature "User views all the shows" do
  it "sees the shows on one page" do
    venue = FactoryGirl.create(:show)
    visit shows_path
    expect(page).to have_content "Great Scott"
  end
end
