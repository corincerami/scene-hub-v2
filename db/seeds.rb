100.times do
  user = User.new(email: Faker::Internet.email, password: Faker::Internet.password)
  user.save
  puts "user created"
end

User.all.each do |user|
  band = user.bands.build(name: Faker::App.name)
  band.save
  puts "band created"
end

100.times do
  venue = Venue.new(name: Faker::Company.name,
                    street_1: Faker::Address.street_address,
                    city: Faker::Address.city,
                    state: "MA",
                    zip_code: Faker::Address.zip_code)
  venue.save
  puts "venue created"
end

Venue.all.each do |venue|
  show = venue.shows.build(details: Faker::Lorem.sentence,
                           show_date: DateTime.now + 1.year)
  show.save
  puts "show created"
end

Show.all.each do |show|
  gig = show.gigs.build(band: Band.find(rand(1..99)))
  gig.save
  puts "gig created"
end
