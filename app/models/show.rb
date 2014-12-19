class Show < ActiveRecord::Base
  belongs_to :venue

  has_many :gigs
  has_many :bands, through: :gigs
end
