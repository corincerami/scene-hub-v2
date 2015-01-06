require 'date'
include Geokit::Geocoders

FactoryGirl.define do

  factory :band do
    sequence(:name) { |n| "Screaming Females#{n}" }
    user
    after(:create) do |band|
      band.genre_list = FactoryGirl.build(:genre_list)
    end
  end

  factory :genre_list do
    genres ["Punk", "Rock"]
  end

  factory :band_post do
    title   "News post"
    content "News post content"
    band
  end

  factory :comment do
    sequence(:title) { |n| "#{n}comment" }
    sequence(:body) { |n| "#{n}body" }
  end

  factory :user do
    sequence(:email) { |n| "#{n}user@example.com" }
    password "password123"
    factory :user_with_bands do
      transient do
        bands_count 1
      end
      after(:create) do |user, evaluator|
        create_list(:band, evaluator.bands_count, user: user)
      end
    end
  end

  factory :gig do
    band
    show
  end

  factory :venue do
    name     "Great Scott"
    street_1 "1222 Commonwealth Ave"
    city     "Allston"
    state    "MA"
    zip_code "02134"
    address = "1222 Commonwealth Ave, Allston, MA"
    loc = MultiGeocoder.geocode(address)
    if loc.success
      latitude = loc.lat
      longitude = loc.lng
    end
    lat      latitude
    lng      longitude
  end

  factory :show do
    show_date "2100-02-03T04:05:06+07:00"
    details   "A cool show"
    venue
    after(:create) do |show|
      user = FactoryGirl.create(:user_with_bands)
      show.bands << user.bands.first
      comment = FactoryGirl.build(:comment)
      comment.user_id = user.id
      comment.show_id = show.id
      comment.save
      show.comments << comment
    end
  end

  factory :photo do
    image_file_name    "photo.jpg"
    image_content_type "image/jpeg"
    image_file_size    "30000"
    image_updated_at   DateTime.now
    band
  end
end
