include Geokit::Geocoders

if Rails.env.development?
  10.times do
    user = User.new(email: Faker::Internet.email, password: Faker::Internet.password)
    user.save
    puts "user #{user.email} created"
  end

  User.all.each do |user|
    band = user.bands.build(name: Faker::App.name)
    band.save
    puts "band #{band.name} created"
  end

  Band.all.each do |band|
    if band.id != 502
      GenreList.create!(band: band, genre: "punk")
      puts "genre list for #{band.name} created"
    end
  end

  10.times do
    street = "66 Kenzel Ave"
    city = "Nutley"
    state = "NJ"
    address = "#{street}, #{city}, #{state}"
    loc = MultiGeocoder.geocode(address)
    venue = Venue.new(name: Faker::Company.name,
                      street_1: street,
                      city: city,
                      state: state,
                      zip_code: "07110",
                      lat: loc.lat,
                      lng: loc.lng)
    venue.save
    puts "venue created"
  end

  Venue.all.each do |venue|
    Band.all.each do |band|
      if band.id != 502
        show = venue.shows.build(details: Faker::Lorem.sentence,
                                 show_date: DateTime.now + 1.year,
                                 band: band)
        show.save
        puts "show created"
      end
    end
  end
end

months = {
  "01" => "Jan",
  "02" => "Feb",
  "03" => "Mar",
  "04" => "Apr",
  "05" => "May",
  "06" => "Jun",
  "07" => "Jul",
  "08" => "Aug",
  "09" => "Sep",
  "10" => "Oct",
  "11" => "Nov",
  "12" => "Dec"
}

# seeds Screaming Females' tour history to demonstrate tour map
band = Band.find_by(name: "Screaming Females")
File.readlines("db/sf_shows.txt").each do |line|
  if line != "\n"
    data = line.split(" - ")
    date = data[0]
    venue_name = data[1]
    venue_street_1 = data[2]
    city_state = data[3]
    city_state = city_state.split(", ")
    city = city_state[0]
    url_city = city.gsub(" ", "%20")
    state = city_state[1]
    state.slice!(-1)
    date = date.split("/")
    month = months[date[0]]
    day = date[1]
    year = date[2]
    show_date = "#{day} #{month} 20#{year} 22:00:00 -0500"

    address = "#{venue_street_1}, #{city}, #{state}"
    loc = MultiGeocoder.geocode(address)
    if loc.success
      latitude = loc.lat
      longitude = loc.lng
    end

    venue = Venue.find_or_create_by(name: venue_name,
                         street_1: venue_street_1,
                         city: city,
                         state: state,
                         zip_code: "00000",
                         lat: latitude,
                         lng: longitude)
    show = Show.find_or_create_by(show_date: show_date,
                       venue: venue,
                       band: band)
    puts "Show created at #{venue.name} on #{show.show_date}"
  end
end
