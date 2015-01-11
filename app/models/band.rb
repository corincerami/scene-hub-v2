class Band < ActiveRecord::Base
  has_many :gigs
  has_many :shows, through: :gigs
  has_many :band_posts
  has_many :photos
  has_one :genre_list

  belongs_to :user

  validates :name, presence: true
  validates :user_id, presence: true

  def has_genre?(genre)
    genre_list.genres.include?(genre)
  end
end
