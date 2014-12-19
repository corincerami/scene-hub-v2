require 'date'

FactoryGirl.define do

  factory :band do
    sequence(:band) do |n|
      "Screaming Females#{n}"
    end
  end

  factory :show do
    details  "A cool show"
    show_date DateTime.now

    factory :show_with_bands do
      transient do
        band_count 2
      end
      after(:create) do |show, evaluator|
        create_list(:band, evaluator.band_count, show: show)
      end
    end
  end

  factory :venue do
    name     "Great Scott"
    street_1 "1222 Commonwealth Ave"
    city     "Allston"
    state    "MA"
    zip_code "07110"

    factory :venue_with_shows do
      transient do
        show_count 3
      end

      after(:create) do |venue, evaluator|
        create_list(:show, evaluator.show_count, venue: venue)
      end
    end
  end
end
