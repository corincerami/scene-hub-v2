class Band < ActiveRecord::Base
  has_many :gigs
  has_many :shows, through: :gigs

  belongs_to :user
  # what is the benefit of a band belonging to a user?
  # is a user here forced to be a band or can be anyone
  # posting a band / show? Or maybe you want to know
  # who posted the band? Right now, as a user, I can post
  # multiple bands. I don't know if that was your intent
  # but if it isn't, you'd want to put some limits into
  # place

  validates :name, presence: true
  # ^^ just reordered here to separate associations from
  # validations
end
