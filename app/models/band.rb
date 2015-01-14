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
end
