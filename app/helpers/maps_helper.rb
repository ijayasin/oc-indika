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


  # {
  #     "type": "Feature",
  #     "properties": {
  #         "description": "<strong>Some</strong><p> long description with HTML in it.</p>",
  #         "icon": "theatre"
  #     },
  #     "geometry": {
  #         "type": "Point",
  #         "coordinates": [-77.038659, 38.931567]
  #     }
  # }
  def geojson_feature_collection(map_id, markers)
    markers.map do |marker|
       {
          type: 'Feature',
          geometry: {
              type: 'Point',
              coordinates: marker.coordinates
          },
          properties: {
              # https://www.mapbox.com/maki-icons/
              icon:        'music' || marker.icon.presence || 'marker',
              map_id:      map_id,
              marker_id:   marker.id,
              title:       marker.name,
              description: marker.description,
              'color': '#3bb2d0',
              'size':  'large',
          }
      }
    end
  end
end
