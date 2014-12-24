class Band < ActiveRecord::Base
  has_many :gigs
  has_many :shows, through: :gigs

  validates :name, presence: true

  belongs_to :user
end
