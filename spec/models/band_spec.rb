require "rails_helper"

describe Band do
  describe "attributes" do
    it { should respond_to :name }
    it { should respond_to :user_id }
  end

  describe "validations" do
    it { should validate_presence_of :name }
    it { should validate_presence_of :user_id }
  end

  describe "associations" do
    it { should belong_to :user }
    it { should have_one :genre_list }
    it { should have_many :band_posts }
    it { should have_many :gigs }
    it { should have_many :photos }
    it { should have_many :shows }
  end

  describe "band with genres" do
    before(:each) do
      @band = FactoryGirl.create(:band)
    end

    it "should have a genre" do
      expect(@band.has_genre?("Punk")).to eq(true)
      expect(@band.has_genre?("Pop")).to eq(false)
    end
  end
end
