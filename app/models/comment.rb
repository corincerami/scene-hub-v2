class Comment < ActiveRecord::Base
	belongs_to :show
	validates :body, presence: true
end