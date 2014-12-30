class GenreList < ActiveRecord::Base
	belongs_to :band

	validates :genres, presence: true
	validates :band_id, presence: true
end