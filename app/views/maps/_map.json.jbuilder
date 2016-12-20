json.extract! map, :id, :lat1, :lng1, :lat2, :lng2, :zoom, :created_at, :updated_at, :name
json.url map_url(map, format: :json)