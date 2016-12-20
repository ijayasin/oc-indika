FactoryGirl.define do
  factory :marker do
    user
    map
    sequence(:name){|n| "Marker #{n}"}
    description "Some description"
    residents 1
    lng 111.111
    lat 11.11
  end
end
