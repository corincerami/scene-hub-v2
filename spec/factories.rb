require 'date'

FactoryGirl.define do

  factory :band do
    sequence(:name) { |n| "Screaming Females#{n}" }
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
  end

  factory :show do
    show_date DateTime.now
    details   "A cool show"
    venue
    after(:create) do |show|
      show.bands << FactoryGirl.create(:band)
    end
  end
end
