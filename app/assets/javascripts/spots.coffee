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
      styles: [
                {
                  featureType: "landscape"
                  stylers: [
                    {
                      saturation: -100
                    }
                    {
                      lightness: 65
                    }
                    {
                      visibility: "on"
                    }
                  ]
                }
                {
                  featureType: "poi"
                  stylers: [
                    {
                      saturation: -100
                    }
                    {
                      lightness: 51
                    }
                    {
                      visibility: "simplified"
                    }
                  ]
                }
                {
                  featureType: "road.highway"
                  stylers: [
                    {
                      saturation: -100
                    }
                    {
                      visibility: "simplified"
                    }
                  ]
                }
                {
                  featureType: "road.arterial"
                  stylers: [
                    {
                      saturation: -100
                    }
                    {
                      lightness: 30
                    }
                    {
                      visibility: "on"
                    }
                  ]
                }
                {
                  featureType: "road.local"
                  stylers: [
                    {
                      saturation: -100
                    }
                    {
                      lightness: 40
                    }
                    {
                      visibility: "on"
                    }
                  ]
                }
                {
                  featureType: "transit"
                  stylers: [
                    {
                      saturation: -100
                    }
                    {
                      visibility: "simplified"
                    }
                  ]
                }
                {
                  featureType: "administrative.province"
                  stylers: [visibility: "off"]
                }
                {
                  featureType: "water"
                  elementType: "labels"
                  stylers: [
                    {
                      visibility: "on"
                    }
                    {
                      lightness: -25
                    }
                    {
                      saturation: -100
                    }
                  ]
                }
                {
                  featureType: "water"
                  elementType: "geometry"
                  stylers: [
                    {
                      hue: "#ffff00"
                    }
                    {
                      lightness: -25
                    }
                    {
                      saturation: -97
                    }
                  ]
                }
              ]

    map = new google.maps.Map(document.getElementById("map-canvas"), mapOptions)

    marker = new google.maps.Marker(
      map: map
      position: new google.maps.LatLng(map.getCenter().k, map.getCenter().B)
      )

    google.maps.event.addListener(map, 'center_changed', ->
      marker.setPosition map.getCenter()
      )

    if localStorage.getItem("parked") == "true"
      $.ajax
        url : "/spots"
        method: "get"
        dataType: "json"
        success : (data) ->
          markerOverlay = new google.maps.Marker(
            map: map
            position: new google.maps.LatLng(data.latitude, data.longitude)
            animation: google.maps.Animation.DROP
            )
        error : ->
          alert "Server is broken!"
      $(".park").hide();
      $(".find").fadeIn();

    park = ->
      $.ajax
          url: "/spots"
          method: "POST"
          data:
            "spot":
              "latitude": map.getCenter().k
              "longitude": map.getCenter().B
          dataType: "json"
          success: (data) ->
            markerOverlay = new google.maps.Marker(
              map: map
              position: new google.maps.LatLng(data.latitude, data.longitude)
              animation: google.maps.Animation.DROP
              )
            $(".park").hide()
            $(".find").fadeIn()
            localStorage.setItem("parked", "true")
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
        start = new google.maps.LatLng(map.getCenter().k, map.getCenter().B)
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
      localStorage.setItem("parked", "false")
      
    $('.park').on 'click', park

    $('.find').on 'click', find

    $('.reset').on 'click', reset

  if navigator.geolocation
    navigator.geolocation.getCurrentPosition(loadMapFunctions)
  else 
    console.log("Browser doesn't support geolocate")

google.maps.event.addDomListener(window, 'load', initialize);