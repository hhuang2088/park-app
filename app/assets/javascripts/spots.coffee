initialize = ->
  loadMapFunctions = (position) -> 

    if !localStorage.getItem("parked")?
      localStorage.setItem("parked", "false")
    markerOverlay = null
    directionsDisplay = null
    latitude = position.coords.latitude
    longitude = position.coords.longitude
    mapOptions = 
      center: new google.maps.LatLng(latitude, longitude)
      zoom: 17

    map = new google.maps.Map(document.getElementById("map-canvas"), mapOptions)

    marker = new google.maps.Marker(
      map: map
      position: new google.maps.LatLng(map.getCenter().k, map.getCenter().A)
      icon: '/assets/parking.png'
      )

    google.maps.event.addListener(map, 'center_changed', ->
      marker.setPosition map.getCenter()
      )

    if localStorage.getItem("parked") == "true"
      marker.icon = "/assets/pedestrian.png"
      $.ajax
        url : "/spots"
        method: "get"
        dataType: "json"
        success : (data) ->
          markerOverlay = new google.maps.Marker(
            map: map
            position: new google.maps.LatLng(data.latitude, data.longitude)
            animation: google.maps.Animation.DROP
            icon: "/assets/car.png"
            )
        error : ->
          alert "Server is broken!"
      $(".park").hide();
      $(".find").fadeIn();

    park = ->
      $.ajax
          url: "/spots"
          method: "post"
          data:
            "spot":
              "latitude": map.getCenter().k
              "longitude": map.getCenter().A
          dataType: "json"
          success: (data) ->
            markerOverlay = new google.maps.Marker(
              map: map
              position: new google.maps.LatLng(data.latitude, data.longitude)
              animation: google.maps.Animation.DROP
              icon: "/assets/car.png"
              )
            $(".park").hide()
            $(".find").fadeIn()
            localStorage.setItem("parked", "true")
            marker.icon = "/assets/pedestrian.png"
          error: ->
            alert("Server is broken!")
    
    find = ->
      $.ajax
        url: "/spots"
        method: "get"
        dataType: "json",
        success : (data) ->
          getCar(data)
          $(".find").hide()
          $(".reset").fadeIn()
        error : ->
          alert("Server is broken!")

    getCar = (data)->
      directionsService = new google.maps.DirectionsService()
      directionsDisplay = new google.maps.DirectionsRenderer()
      center = new google.maps.LatLng(latitude, longitude )
      mapOptions =
        zoom: 17
        center: center
      directionsDisplay.setMap(map)
      calculateRoute = ->
        start = new google.maps.LatLng(map.getCenter().k, map.getCenter().A)
        end = new google.maps.LatLng(data.latitude, data.longitude)
        request = 
          origin: start
          destination: end
          travelMode: google.maps.TravelMode.WALKING
        directionsService.route(request, (response, status)->
          if status == google.maps.DirectionsStatus.OK
            console.log(directionsDisplay.setDirections response)
          )
      calculateRoute()

    reset = ->
      markerOverlay.setMap(null)
      directionsDisplay.setMap(null)
      map.setZoom(17)
      $('.reset').hide()
      $('.park').fadeIn()
      marker.icon = "/assets/parking.png"
      localStorage.setItem("parked", "false")
      
    $('.park').on 'click', park

    $('.find').on 'click', find

    $('.reset').on 'click', reset

  if navigator.geolocation
    navigator.geolocation.getCurrentPosition(loadMapFunctions)
  else 
    console.log("Browser doesn't support geolocate")

google.maps.event.addDomListener(window, 'load', initialize);