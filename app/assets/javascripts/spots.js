// Generated by CoffeeScript 1.7.1
var initialize;

initialize = function() {
  var startLocation;
  startLocation = function(position) {
    var latitude, longitude, map, mapOptions, marker;
    latitude = position.coords.latitude;
    longitude = position.coords.longitude;
    mapOptions = {
      center: new google.maps.LatLng(latitude, longitude),
      zoom: 17
    };
    map = new google.maps.Map(document.getElementById("map-canvas"), mapOptions);
    marker = new google.maps.Marker({
      map: map,
      position: new google.maps.LatLng(map.getCenter().k, map.getCenter().A)
    });
    google.maps.event.addListener(map, 'center_changed', function() {
      console.log("" + (map.getCenter().k) + ", " + (map.getCenter().A));
      return marker.setPosition(map.getCenter());
    });
    $('.park').on('click', function() {
      return $.ajax({
        url: "/spots",
        method: "post",
        data: {
          "spot": {
            "latitude": map.getCenter().k,
            "longitude": map.getCenter().A
          }
        },
        dataType: "json",
        success: function(data) {
          new google.maps.Marker({
            map: map,
            position: new google.maps.LatLng(data.latitude, data.longitude),
            animation: google.maps.Animation.DROP,
            icon: "http://www.infosnacks.com/img/icons/automobiles.png"
          });
          $(".park").fadeOut();
          return $(".find").fadeIn();
        },
        error: function() {
          return alert("Server is broken!");
        }
      });
    });
    return $('.find').on('click', function() {
      return $.ajax({
        url: "/spots",
        method: "get",
        data: {
          "spot": {
            "user_id": 1
          }
        },
        dataType: "json",
        success: function(data) {
          console.log(data[1].latitude);
          console.log(data[1].longitude);
          $(".find").fadeOut();
          return $(".park").fadeIn();
        },
        error: function() {
          return alert("Server is broken!");
        }
      });
    });
  };
  if (navigator.geolocation) {
    return navigator.geolocation.getCurrentPosition(startLocation);
  } else {
    return console.log("Browser doesn't support geolocate");
  }
};

google.maps.event.addDomListener(window, 'load', initialize);
