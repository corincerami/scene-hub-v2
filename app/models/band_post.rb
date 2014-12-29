class BandPost < ActiveRecord::Base
	belongs_to :band

	validates :title, presence: true
	validates :content, presence: true
end