FactoryGirl.define do
  factory :map do
    sequence(:name){|n| "Map #{n}"}
    lng1 111.111
    lat1 11.11
    lng2 222.222
    lat2 22.22
  end
end
