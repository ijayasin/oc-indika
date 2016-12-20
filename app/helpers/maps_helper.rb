module MapsHelper

  def map_image_url(map, options={})
    opts = {
        token:  Settings.mapbox.access_token,
        height: options[:height] || 125,
        width:  options[:height] || 125,
        style:  options[:style]  || 'streets',
        lng:    (map.lng2 + map.lng1)/2,
        lat:    (map.lat2 + map.lat1)/2,
        zoom:   map.zoom || 5,
    }
    "https://api.mapbox.com/v4/mapbox.%{style}/%{lng},%{lat},%{zoom}/%{width}x%{height}.png?access_token=%{token}" % opts
  end
end
