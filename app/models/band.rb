class Band < ActiveRecord::Base
  has_many :gigs
  has_many :shows, through: :gigs
end
