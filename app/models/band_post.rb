class BandPost < ActiveRecord::Base
  belongs_to :band

  validates :title, presence: true
  validates :content, presence: true
  validates :band_id, presence: true

  def time_created
    created_at.strftime('%B %d, %Y - %I:%M%p')
  end

  def time_updated
    updated_at.strftime('%B %d, %Y - %I:%M%p')
  end
end
