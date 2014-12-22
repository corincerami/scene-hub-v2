require 'rails_helper'

feature "User views all the shows" do
  it "sees the shows on one page" do
    venue = create(:show)
    visit '/'
    expect(page).to have_content "Great Scott"
  end
end
