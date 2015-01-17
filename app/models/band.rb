class Band < ActiveRecord::Base
  has_many :gigs, dependent: :destroy
  has_many :shows, through: :gigs
  has_many :band_posts, dependent: :destroy
  has_many :photos, dependent: :destroy
  has_many :follows, dependent: :destroy
  has_one :genre_list, dependent: :destroy

  belongs_to :user

  validates :name, presence: true
  validates :user_id, presence: true
  validates :spotify_uri,
    format: { with: /\Aspotify:artist:\w{22}\Z/,
    message: "should be the URI for an artist on Spotify"},
    allow_blank: true

  def has_genre?(genre)
    genre_list.genres.include?(genre)
  end

  def geojson
    geojson = Array.new
    shows = self.shows
    shows.each do |show|
      venue = show.venue
      show_count = self.shows.where(venue: venue).count
      if show_count < 10
        marker_size = "small"
      elsif show_count >=10 && show_count < 30
        marker_size = "medium"
      else
        marker_size = "large"
      end
      geojson << {
        type: 'Feature',
        geometry: {
          type: 'Point',
          coordinates: [venue.lng, venue.lat]
        },
        properties: {
          name: venue.name,
          address: venue.street_1,
          :'marker-color' => "#FF389C",
          :'marker-line-color' => "#FF389C",
          :'marker-fill' => "#FF389C",
          :'marker-symbol' => 'circle',
          :'marker-size' => "#{marker_size}"
        }
      }
    end
    geojson
  end
end
