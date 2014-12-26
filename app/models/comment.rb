class Comment < ActiveRecord::Base
	belongs_to :show
	belongs_to :user
	
	validates :body,    presence: true
	validates :user_id, presence: true
	validates :show_id, presence: true
end