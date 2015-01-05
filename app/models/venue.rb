class Venue < ActiveRecord::Base
  has_many :shows

  validates :name, presence: true
  validates :street_1, presence: true
  validates :city, presence: true
  validates :state, presence: true
  validates :zip_code, presence: true

  acts_as_mappable

  def address_2
    "#{city}, #{state} #{zip_code} "
  end
end
