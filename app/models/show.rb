class Show < ActiveRecord::Base
  belongs_to :venue, dependent: :destroy
  has_many :gigs
  has_many :bands, through: :gigs
  accepts_nested_attributes_for :bands, :venue
  has_many :comments
  has_many :rsvps

  validates :show_date, presence: true
  validates :venue_id, presence: true

  acts_as_mappable through: :venue

  def date_and_time
    show_date.strftime("%B %d, %Y at %I:%M%p")
  end
end
