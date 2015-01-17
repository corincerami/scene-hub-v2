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
                    street_1: "66 Kenzel Ave",
                    city: "Nutley",
                    state: "NJ",
                    zip_code: "07110")
  venue.save
  puts "venue created"
end

Venue.all.each do |venue|
  Band.all.each do |band|
    show = venue.shows.build(details: Faker::Lorem.sentence,
                             show_date: DateTime.now + 1.year,
                             band: band)
    show.save
    puts "show created"
  end
end
