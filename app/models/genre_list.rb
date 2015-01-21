class GenreList < ActiveRecord::Base
  belongs_to :band

  validates :genre, presence: true
  validates :band_id, presence: true
end
