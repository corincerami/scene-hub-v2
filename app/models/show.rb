class Show < ActiveRecord::Base
  belongs_to :venue, dependent: :destroy

  has_many :gigs
  has_many :bands, through: :gigs

  validates :show_date, presence: true

  accepts_nested_attributes_for :bands, :venue

  acts_as_mappable through: :venue
  # ^^ it's thought to be good practice to break up
  # built-in methods like belongs_to etc and then
  # to separate them from the gem'd ones
end
