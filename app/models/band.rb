class Band < ActiveRecord::Base
  has_many :gigs
  has_many :shows, through: :gigs

  has_many :band_posts

  has_many :photos

  has_one :genre_list

  validates :name, presence: true

  belongs_to :user

  def has_genre?(genre)
    genre_list.genres.include?(genre)
  end
end
