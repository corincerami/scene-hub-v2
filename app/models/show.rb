class Show < ActiveRecord::Base
  belongs_to :venue
  belongs_to :band
  accepts_nested_attributes_for :band, :venue
  has_many :comments, dependent: :destroy
  has_many :rsvps, dependent: :destroy

  validates :show_date, presence: true
  validates :venue_id, presence: true
  validates :band_id, presence: true

  acts_as_mappable through: :venue

  def date_and_time
    show_date.strftime("%B %d, %Y at %I:%M%p")
  end

  def self.search(zip_code, radius, genre)
    if !zip_code.nil? && !zip_code.empty?
      shows = self.joins(:venue).joins(:band).within(radius.to_i, origin: zip_code).order(:show_date).where("show_date > ?", DateTime.now)
      if !genre.empty? && !genre.nil?
        # only return shows whose bands match the supplied genre
        shows = shows.order(:show_date).to_a.select { |show| show.band.has_genre?(genre) }
        shows
      else
        shows
      end
    else
      order(:show_date).where("show_date > ?", DateTime.now)
    end
  end
end
