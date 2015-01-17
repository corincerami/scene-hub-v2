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
    it { should have_many :follows }
  end

  describe "band with genres" do
    before(:each) do
      @band = create(:band)
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

  describe "deleting a band" do
    before(:each) do
      @band = create(:band)
      create(:band_post, band: @band)
      create(:gig, band: @band)
      create(:photo, band: @band)
      create(:follow, band: @band)
    end

    it "should detroy all dependencies" do
      genre_list_count = GenreList.count
      band_post_count = BandPost.count
      gig_count = Gig.count
      photo_count = Photo.count
      show_count = Show.count
      follow_count = Follow.count

      @band.destroy

      expect(GenreList.count).to eq(genre_list_count - 1)
      expect(BandPost.count).to eq(band_post_count - 1)
      expect(Gig.count).to eq(gig_count - 1)
      expect(Photo.count).to eq(photo_count - 1)
      expect(Follow.count).to eq(follow_count - 1)
      expect(Show.count).to eq(show_count - 1)
    end

    it "should be destroyed if it's user is destroyed" do
      band_count = Band.count
      user = @band.user
      user.destroy
      expect(Band.count).to eq(band_count - 1)
    end
  end
end
