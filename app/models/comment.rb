class Comment < ActiveRecord::Base
	belongs_to :show
	belongs_to :user
	validates :body, presence: true
end