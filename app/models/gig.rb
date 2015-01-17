class Gig < ActiveRecord::Base
  belongs_to :show, dependent: :destroy
  belongs_to :band

  validates :show_id, presence: true
  validates :band_id, presence: true
end
