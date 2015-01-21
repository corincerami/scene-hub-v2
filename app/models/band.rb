class Band < ActiveRecord::Base
  has_many :shows, dependent: :destroy
  has_many :band_posts, dependent: :destroy
  has_many :photos, dependent: :destroy
  has_many :follows, dependent: :destroy
  has_one :genre_list, dependent: :destroy

  belongs_to :user

  validates :name, presence: true
  validates :user_id, presence: true
  validates :spotify_uri,
            format: { with: /\Aspotify:artist:\w{22}\Z/,
                      message: 'should be the URI for an artist on Spotify' },
            allow_blank: true

  def genre?(genre)
    genre_list.genre.downcase == genre.downcase
  end

  def find_marker_size(venue)
    show_count = shows.where(venue: venue).count
    if show_count < 10
      'small'
    elsif show_count >= 10 && show_count < 30
      'medium'
    else
      'large'
    end
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
          title: "#{venue.name} | #{venue.street_1}, #{venue.address_2}",
          :'marker-color' => '#FF389C',
          :'marker-line-color' => '#FF389C',
          :'marker-fill' => '#FF389C',
          :'marker-symbol' => 'music',
          :'marker-size' => "#{find_marker_size(venue)}"
        }
      }
    end
    geojson
  end
end
