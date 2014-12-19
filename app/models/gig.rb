class Gig < ActiveRecord::Base
  belongs_to :show
  belongs_to :band
end
