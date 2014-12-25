# include Geokit::Geocoders

# user_1 = User.create(email: "user_1@example.com", password: "password123")
# user_2 = User.create(email: "another_1@user.com", password: "password123")

# band_1 = Band.create(name: "Screaming Females", user_id: 1)
# band_2 = Band.create(name: "The Julie Ruin",    user_id: 2)

# address_1 = "1222 Commonwealth Ave, Allston, MA"
# loc_1 = MultiGeocoder.geocode(address_1)

# venue_1 = Venue.create(
# 	name:     "Great Scott",
# 	street_1: "1222 Commonwealth Ave",
# 	city:     "Allston",
# 	state:    "MA",
# 	zip_code: "02134",
# 	lat:      loc_1.lat,
# 	lng:      loc_1.lng )

# address_2 = "149 5th Ave, New York, NY"
# loc_2 = MultiGeocoder.geocode(address_2)

# venue_2 = Venue.create(
# 	name:     "Terminal 5",
# 	street_1: "149 5th Ave",
# 	city:     "New York",
# 	state:    "NY",
# 	zip_code: "10019",
# 	lat:      loc_2.lat,
# 	lng:      loc_2.lng )

# show_1 = Show.create(
# 	details:  "Some show",
# 	show_date: DateTime.now,
# 	venue_id: venue_1.id)

# show_2 = Show.create(
# 	details:  "Another show",
# 	show_date: DateTime.now,
# 	venue_id: venue_2.id)

# gig_1 = Gig.create(
# 	show_id:  show_1.id,
# 	band_id:  band_1.id)

# gig_2 = Gig.create(
# 	show_id:  show_2.id,
# 	band_id:  band_2.id)