class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :lockable

  has_many :bands, dependent: :destroy
  has_many :comments
  has_many :rsvps
  has_many :follows

  def rsvped?(show)
    rsvps.find_by(show: show)
  end

  def following?(band)
    follows.find_by(band: band)
  end
end
