initialize = ->
  # map = new google.maps.Map(document.getElementById("map-canvas"), mapOptions)
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
      position: new google.maps.LatLng(map.getCenter().k, map.getCenter().A)
      )

    google.maps.event.addListener(map, 'center_changed', ->
      #console.log("#{map.getCenter().k}, #{map.getCenter().A}")
      marker.setPosition(map.getCenter())
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
        error : ->
          alert("Server is broken!")
    )

    getCar = (data)->
      # mapsUrl = "https://maps.googleapis.com/maps/api/directions/json?origin=" +
      #   "37.77139265936583,-122.40521395378113&" +
      #   "destination=#{data[1].latitude},#{data[1].longitude}&" +
      #   "mode=walking&"+
      #   "key=AIzaSyAd5T-_NYteKlBbmFHnx5IMH2T5OoJGds4"
      # encodeUrl = encodeURIComponent(mapsUrl)
      # proxyUrl = 'http://jsonp.guffa.com/Proxy.ashx?url=#{encodedUrl}'
      # $.ajax
      #   url: proxyUrl,
      #   type: 'GET',
      #   dataType: 'jsonp',
      #   success : ->
      #     console.log("success")
      #   fail : ->
      #     console.log("fail")
      # directionsService = new google.maps.DirectionsService()
      # start = "37.77139265936583,-122.40521395378113"
      # end = "#{data[1].latitude},#{data[1].longitude}"
      # directionsDisplay = new google.maps.DirectionsRenderer()
      # directionsDisplay.setMap(map)
      # request = 
      #   origin: start
      #   destination: end
      #   travelMode: google.maps.TravelMode.WALKING
      # directionsService.route(request, (response, status)->
      #   if status == google.maps.DirectionsStatus.OK
      #     directionsDisplay.setDirections(response)
      #   )

      directionsService = new google.maps.DirectionsService()
      directionsDisplay = new google.maps.DirectionsRenderer()
      center = new google.maps.LatLng(latitude, longitude)
      mapOptions =
        zoom: 17
        center: center
      # map = new google.maps.Map(document.getElementById('map-canvas'), mapOptions)
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