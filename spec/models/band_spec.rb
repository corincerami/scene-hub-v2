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

  describe "spotify_uri" do
    it { should have_valid(:spotify_uri).when("spotify:artist:0v3aI02UKIlboNqYcKrpvr",
      "spotify:artist:3pZ666b6CyO1KGpVYirY0t",
      "spotify:artist:3jCDV35GjiUGWYWKgMd9CF")}

    it { should_not have_valid(:spotify_uri).when("https://play.spotify.com/artist/3pZ666b6CyO1KGpVYirY0t",
      "spotify:user:screamingfemales",
      "Screaming Females"
      )}
  end
end
