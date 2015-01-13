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

  def self.search(zip_code, radius, genre)
    if !zip_code.nil? && !zip_code.empty?
      shows = self.joins(:venue).joins(:bands).within(radius.to_i, origin: zip_code).where("show_date > ?", DateTime.now)
      if !genre.empty? && !genre.nil?
        # only return shows whose bands match the supplied genre
        shows = shows.order(:show_date).to_a.select { |show| show.bands.first.has_genre?(genre) }
        shows
      else
        shows
      end
    else
      where("show_date > ?", DateTime.now)
    end
  end
end
