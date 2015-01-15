class Band < ActiveRecord::Base
  has_many :gigs
  has_many :shows, through: :gigs
  has_many :band_posts
  has_many :photos
  has_one :genre_list

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
          :'marker-symbol' => 'circle',
          :'marker-size' => 'medium'
        }
      }
    end
    geojson
  end
end
