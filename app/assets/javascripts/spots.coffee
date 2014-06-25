initialize = ->
  startLocation = (position) ->
    latitude = position.coords.latitude
    longitude = position.coords.longitude
    mapOptions = 
      center: new google.maps.LatLng(latitude, longitude)
      zoom: 17

    map = new google.maps.Map(document.getElementById("map-canvas"), mapOptions)

    marker = new google.maps.Marker(
      map: map
      position: new google.maps.LatLng(map.getCenter().k, map.getCenter().A)
      )

    google.maps.event.addListener(map, 'center_changed', ->
      marker.setPosition map.getCenter()
      )

    $('.park').on 'click', ->
      $.ajax
        url: "/spots"
        method: "post"
        data:
          "spot":
            "latitude": map.getCenter().k
            "longitude": map.getCenter().A
        dataType: "json"
        success: (data) ->
          new google.maps.Marker(
            map: map
            position: new google.maps.LatLng(data.latitude, data.longitude)
            animation: google.maps.Animation.DROP
            icon: "http://www.infosnacks.com/img/icons/automobiles.png"
            )
          $(".park").fadeOut()
          $(".find").fadeIn()
        error: ->
          alert("Server is broken!")

    $('.find').on('click', ->
      $.ajax
        url: "/spots"
        method: "get"
        data: 
          "spot":
            "user_id": 1
        dataType: "json",
        success : (data) ->
          console.log("sucess!!!!!")
          getCar(data)
          $(".find").fadeOut()
          $(".reset").fadeIn()
        error : ->
          alert("Server is broken!")
    )

    getCar = (data)->
      directionsService = new google.maps.DirectionsService()
      directionsDisplay = new google.maps.DirectionsRenderer()
      center = new google.maps.LatLng(latitude, longitude)
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

  if navigator.geolocation
    navigator.geolocation.getCurrentPosition(startLocation)
  else 
    console.log("Browser doesn't support geolocate")

google.maps.event.addDomListener(window, 'load', initialize);