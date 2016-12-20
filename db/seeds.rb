# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
user = CreateAdminService.new.call
puts 'CREATED ADMIN USER: ' << user.email
# Environment variables (ENV['...']) can be set in the file .env file.


user = User.new(
    :email                 => "test@example.com",
    :password              => "abc123",
    :password_confirmation => "abc123"
)
user.skip_confirmation! if user.respond_to?(:skip_confirmation!)
user.save!
puts 'CREATED USER: ' << user.email


#<Map id: 2, user_id: 2, name: "San Francisco", description: nil, lat1: 37.705523315255164, lng1: -122.54352347549813, lat2: 37.822865850024655, lng2: -122.3456116768909, zoom: 11.05774225980369, destroyed_at: nil, created_at: "2016-12-20 09:33:37", updated_at: "2016-12-20 09:33:37">
map_sf = Map.create(user: user, name: "San Francisco", lat1: 37.705523315255164, lng1: -122.54352347549813, lat2: 37.822865850024655, lng2: -122.3456116768909, zoom: 11.05774225980369)
map_ny = Map.create(user: user, name: "New York",      lat1: 40.68666415326038,  lng1:  -74.059408244369,   lat2: 40.766505152199045, lng2: -73.91893551359145, zoom: 11.552309786784818)
map_sl = Map.create(user: user, name: "Sri Lanka",     lat1:  5.524419763072899, lng1:   78.78010191009247, lat2: 10.20502677271,     lng2:  82.43542359147756, zoom:  5.370047571829553)


# San Francisco Markers
Marker.create(user: user, map: map_sf, name: 'Presidio',     lat: 37.798706, lng: -122.466122)
Marker.create(user: user, map: map_sf, name: 'Baker Beach',  lat: 37.794256, lng: -122.483262)
Marker.create(user: user, map: map_sf, name: 'Angel Island', lat: 37.861421, lng: -122.430058)


# San Francisco Markers
Marker.create(user: user, map: map_sl, name: 'Anuradhapura', lat:  8.314403, lng: 80.403637)
Marker.create(user: user, map: map_sl, name: 'Colombo',      lat:  6.928746, lng: 79.860464)
Marker.create(user: user, map: map_sl, name: 'Galle',        lat:  6.054444, lng: 80.220763)
Marker.create(user: user, map: map_sl, name: 'Polonnaruwa',  lat:  7.941691, lng: 81.018314)
