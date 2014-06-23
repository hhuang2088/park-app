// Generated by CoffeeScript 1.7.1
"use strict";
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
      position: new google.maps.LatLng(latitude, longitude)
    });
    return google.maps.event.addListener(map, 'center_changed', function() {
      return console.log(map.getCenter());
    });
  };
  if (navigator.geolocation) {
    return navigator.geolocation.getCurrentPosition(startLocation);
  } else {
    return console.log("Browser doesn't support geolocate");
  }
};

google.maps.event.addDomListener(window, 'load', initialize);
