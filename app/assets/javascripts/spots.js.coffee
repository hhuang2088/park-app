initialize = ->

  startLocation = (position) ->
    latitude = position.coords.latitude;
    longitude = position.coords.longitude;
    # console.log("#{latitude}, #{longitude}")
    mapOptions = 
      center: new google.maps.LatLng(latitude, longitude)
      zoom: 17

    map = new google.maps.Map(document.getElementById("map-canvas"), mapOptions)
    # console.log(map)

    marker = new google.maps.Marker(
      map: map
      draggable: true
      position: new google.maps.LatLng(map.getCenter().k, map.getCenter().A),
      # animation: google.maps.Animation.DROP
      )

    google.maps.event.addListener(map, 'center_changed', ->
      console.log("#{map.getCenter().k}, #{map.getCenter().A}")
      marker.setPosition(map.getCenter())
      )

  if navigator.geolocation
    navigator.geolocation.getCurrentPosition(startLocation)
  else 
    console.log("Browser doesn't support geolocate")

google.maps.event.addDomListener(window, 'load', initialize);