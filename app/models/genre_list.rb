class GenreList < ActiveRecord::Base
	belongs_to :band

	validates :genres, presence: true
	validates :band_id, presence: true
  validates :genres, format: { with: /\A\[\"\w+\"(\, \"\w+\")*\]\Z/, message: "Genres must be entered as a comma separated list" }
end
