require "rails_helper"

describe Venue do
  describe "attributes" do
    it { should respond_to :name }
    it { should respond_to :details }
    it { should respond_to :street_1 }
    it { should respond_to :street_2 }
    it { should respond_to :city }
    it { should respond_to :state }
    it { should respond_to :zip_code }
    it { should respond_to :lat }
    it { should respond_to :lng }
  end

  describe "validations" do
    it { should validate_presence_of :name }
    it { should validate_presence_of :street_1 }
    it { should validate_presence_of :city }
    it { should validate_presence_of :state }
    it { should validate_presence_of :zip_code }
    it { should validate_presence_of :lat }
    it { should validate_presence_of :lng }
  end

  describe "associations" do
    it { should have_many :shows }
  end

  describe "deleting a venue" do
    it "should delete its dependencies" do
      venue = create(:venue)
      show = create(:show, venue: venue)
      show_count = Show.count

      venue.destroy

      expect(Show.count).to eq(show_count - 1)
    end
  end
end
