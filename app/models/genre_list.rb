class GenreList < ActiveRecord::Base
	belongs_to :band

	validates :genre, presence: true
	validates :band_id, presence: true
  # validates :genres, format: { with: /\A\[\"\w+\"(\, \"\w+\")*\]\Z/, message: "must be entered as a comma separated list" }
end
