# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/


# Serves as a client-side controller which wraps the Mapbox view.
class MapHander
  constructor: (mapDiv, accessToken, mapBounds, geojson, options={}) ->
    @editable = options.editable
    @newMap   = options.newMap
    @setupMap(mapDiv, accessToken, mapBounds, geojson)


  setupMap: (mapDiv, accessToken, mapBounds, geojson) =>
    mapboxgl.accessToken = accessToken

    @map = new mapboxgl.Map
      style:        'mapbox://styles/mapbox/streets-v9'
      container:    mapDiv
      trackResize:  true

    window.map = @map

    @setMapBounds(mapBounds) unless @newMap

    @map.addControl(new mapboxgl.NavigationControl(), 'top-left')
    @map.addControl(new mapboxgl.GeolocateControl(),  'top-right')

    @populateMarkers(geojson)

    if @editable
      # @map.on('move', @setInputFieldValues)       # move, movestart, moveend
      # @map.on('zoom', @setInputFieldValues)       # zoom, zoomstart, zoomend
      @map.on('boxzoomend', @setInputFieldValues)   # zoom, zoomstart, zoomend

    @map.on('click',      @clickHandler)    # handle clicks on map
    @map.on('click',      @clickHandler)    # handle clicks on map
    @map.on('mousemove',  @hoverHandler)

    @setupMapPopup()


  setupMapPopup: =>
    @popup = new mapboxgl.Popup
      closeButton:  false
      closeOnClick: false

  setMapBounds: (mapBounds) =>
    @map.fitBounds(mapBounds)


  hoverHandler: (event) =>
    console.log "HOVER/MOUSEMOVE!"
    console.dir event
    return unless event.point
    features = @map.queryRenderedFeatures(event.point, { layers: ['places'] });
    map.getCanvas().style.cursor = (features.length) ? 'pointer' : '';
    unless features.length
      @popup.remove()
      return

    @displayExistingFeature(features[0])

  clickHandler: (event) =>
    console.log "CLICK!"
    console.dir event
    return unless event.point
    features = @map.queryRenderedFeatures(event.point, { layers: ['places'] });

    if features.length
      @displayExistingFeature(features[0])
    else
      @displayNewMarkerModal(event.point)

  displayNewMarkerModal: (point) =>
    console.log "displayNewMarkerModal"
    console.dir point
    return unless point

    if @newMap
      alert "You must save the map before you can add markers to it."
      return

  displayExistingFeature: (feature) =>
    console.log "displayExistingFeature"
    return unless feature.geometry?.coordinates
    # Populate the popup and set its coordinates
    # based on the feature found.
    @popup
      .setLngLat(feature.geometry.coordinates)
      .setHTML("""
        <h6>#{feature.properties.title}</h6>
        <p>#{feature.properties.description || ''}</p>
      """)
      .addTo(@map);


  populateMarkers: (geojson) =>
    @map.on 'load', () =>
      # Add a GeoJSON source containing place coordinates and information.
      @map.addSource "places",
        "type": "geojson"
        "data":
          "type": "FeatureCollection"
          "features": geojson

      # Add a layer showing the places.
      @map.addLayer
        "id":     "places"
        "type":   "symbol"
        "source": "places"
        "layout":
          "text-anchor":  "top",
          "text-field":   "{title}",
          "icon-image":   "{icon}-15"
          "text-offset":  [0, 0.6]
          "icon-allow-overlap": true

  # TODO: Parameterize the input field selectors used here.
  setInputFieldValues: (event) =>
    bounds = event.boxZoomBounds;
    return unless bounds

    # Lat1 = SW
    $('#map_lat1').val(bounds._sw.lat);
    $('#map_lng1').val(bounds._sw.lng);

    # Lat1 = NE
    $('#map_lat2').val(bounds._ne.lat);
    $('#map_lng2').val(bounds._ne.lng);

    $('#map_zoom').val(@map.getZoom());


window.MapHander = MapHander
