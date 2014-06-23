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

  if navigator.geolocation
    navigator.geolocation.getCurrentPosition(startLocation)
  else 
    console.log("Browser doesn't support geolocate")

  # mapOptions = 
  #   center: new google.maps.LatLng(latitude, longitude)
  #   zoom: 5

  # map = new google.maps.Map(document.getElementById("map-canvas"), mapOptions)
  # console.log(map)

google.maps.event.addDomListener(window, 'load', initialize);