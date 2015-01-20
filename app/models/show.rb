class Show < ActiveRecord::Base
  include Geokit::Geocoders
  belongs_to :venue
  belongs_to :band
  has_one :genre_list, through: :band
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
      shows = self.joins(:venue).joins(:band).joins(:genre_list).
                  within(radius.to_i, origin: zip_code).
                  order(:show_date).
                  where("show_date > ?", DateTime.now)
      # if genre is included in search, find only shows which match genre
      if !genre.empty? && !genre.nil?
        shows.where("genre ILIKE ?", genre)
      else
        shows
      end
    else
      # return all future shows
      order(:show_date).where("show_date > ?", DateTime.now)
    end
  end

  def geocode_venue(params)
    address = "#{params[:street_1]}, #{params[:city]}, #{params[:state]}"
    loc = MultiGeocoder.geocode(address)
    if loc.success
      params[:lat] = loc.lat
      params[:lng] = loc.lng
    end
    params
  end

  def mail_followers
    Follow.where(band: band).each do |follow|
      ShowNotification.notification(follow, self).deliver
    end
  end
end
