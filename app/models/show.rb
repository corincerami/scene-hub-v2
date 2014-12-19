class Show < ActiveRecord::Base
  belongs_to :venue, dependent: :destroy

  has_many :gigs
  has_many :bands, through: :gigs
  accepts_nested_attributes_for :bands, :venue

  validates :show_date, presence: true
end
