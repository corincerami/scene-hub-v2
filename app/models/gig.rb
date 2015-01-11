class Gig < ActiveRecord::Base
  belongs_to :show
  belongs_to :band

  validates :show_id, presence: true
  validates :band_id, presence: true
end
