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


marker_descs = {
  presidio:     'The Presidio of San Francisco is a park and former military fort on the northern tip of the San Francisco Peninsula in San Francisco, California, and is part of the Golden Gate National Recreation Area.',
  baker_beach:  'Baker Beach is a public beach on the peninsula of San Francisco, California, U.S.',
  angel_island: 'Angel Island is an island in San Francisco Bay offering expansive 360° views of the San Francisco skyline, the Marin County Headlands and Mount Tamalpais.',

  anuradhapura: 'Anuradhapura is a major city in Sri Lanka. It is the capital city of North Central Province, Sri Lanka and the capital of Anuradhapura District.',
  colombo:      'Colombo, the capital of Sri Lanka, has a long history as a port on ancient east-west trade routes, ruled successively by the Portuguese, Dutch and British. That heritage is reflected in its its architecture, mixing colonial buildings with high-rises and shopping malls.',
  galle:        'Galle is a major city in Sri Lanka, situated on the southwestern tip, 119 km from Colombo. Galle is the administrative capital of Southern Province, Sri Lanka and is the district capital of Galle District.',
  polonnaruwa:  'Poḷonnaruwa is the main town of Polonnaruwa District in North Central Province, Sri Lanka. Kaduruwela area is the Polonnaruwa New Town and the other part of Polonnaruwa remains as the royal ancient city of the Kingdom of Polonnaruwa.',
}


#<Map id: 2, user_id: 2, name: "San Francisco", description: nil, lat1: 37.705523315255164, lng1: -122.54352347549813, lat2: 37.822865850024655, lng2: -122.3456116768909, zoom: 11.05774225980369, destroyed_at: nil, created_at: "2016-12-20 09:33:37", updated_at: "2016-12-20 09:33:37">
map_sf = Map.create(user: user, name: "San Francisco", lat1: 37.705523315255164, lng1: -122.54352347549813, lat2: 37.822865850024655, lng2: -122.3456116768909, zoom: 11.05774225980369)
map_ny = Map.create(user: user, name: "New York",      lat1: 40.68666415326038,  lng1:  -74.059408244369,   lat2: 40.766505152199045, lng2: -73.91893551359145, zoom: 11.552309786784818)
map_sl = Map.create(user: user, name: "Sri Lanka",     lat1:  5.524419763072899, lng1:   78.78010191009247, lat2: 10.20502677271,     lng2:  82.43542359147756, zoom:  5.370047571829553)


# San Francisco Markers
Marker.create(user: user, map: map_sf, name: 'Presidio',     lat: 37.798706, lng: -122.466122, description: marker_descs[:presidio])
Marker.create(user: user, map: map_sf, name: 'Baker Beach',  lat: 37.794256, lng: -122.483262, description: marker_descs[:baker_beach])
Marker.create(user: user, map: map_sf, name: 'Angel Island', lat: 37.861421, lng: -122.430058, description: marker_descs[:angel_island])


# San Francisco Markers
Marker.create(user: user, map: map_sl, name: 'Anuradhapura', lat:  8.314403, lng: 80.403637, description: marker_descs[:anuradhapura])
Marker.create(user: user, map: map_sl, name: 'Colombo',      lat:  6.928746, lng: 79.860464, description: marker_descs[:colombo])
Marker.create(user: user, map: map_sl, name: 'Galle',        lat:  6.054444, lng: 80.220763, description: marker_descs[:galle])
Marker.create(user: user, map: map_sl, name: 'Polonnaruwa',  lat:  7.941691, lng: 81.018314, description: marker_descs[:polonnaruwa])
