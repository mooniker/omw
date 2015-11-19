// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require turbolinks
//= require_tree .


function geoFindMe() {
  var output = document.getElementById("out");

  if (!navigator.geolocation){
    output.innerHTML = "<p>Geolocation is not supported by your browser</p>";
    return;
  }

  function success(position) {
    var latitude  = position.coords.latitude;
    var longitude = position.coords.longitude;

    output.innerHTML = '<p>Latitude is ' + latitude + '° <br>Longitude is ' + longitude + '°</p>';

    var img = new Image();
    img.src = "https://maps.googleapis.com/maps/api/staticmap?center=" + latitude + "," + longitude + "&zoom=13&size=300x300&sensor=false";

    output.appendChild(img);
  };

  function error() {
    output.innerHTML = "Unable to retrieve your location";
  };

  output.innerHTML = "<p>Locating…</p>";

  navigator.geolocation.getCurrentPosition(success, error);
}

$(document).ready(function () {

  var latitude = 38.8898;
  var longitude = 77.0091;
  var token = 'pk.eyJ1IjoibW9vbmlrZXIiLCJhIjoiY2loNHkwMmUwMHp1Znc5bTVxZGptZ3d1eSJ9.IjtdkC-4egUXjw39mKShgA';
  var address_query = "https://api.mapbox.com/geocoding/v5/{dataset}/{query}.json?proximity={longitude},{latitude}&access_token={token}";

  function make_address_query_url( query ) {
  // "https://api.mapbox.com/geocoding/v5/{dataset}/{query}.json?proximity={longitude},{latitude}&access_token={token}";
    var prefix = "https://api.mapbox.com/geocoding/v5/mapbox.places/";
    return prefix + query + ".json?proximity=" + longitude + "," + latitude + "&access_token=" + token;
  }

  function set_lon_lat_from_address() {

    var jsonhttp = new XMLHttpRequest();

    jsonhttp.onreadystatechange = function() {
      if (jsonhttp.readyState == 4 && jsonhttp.status == 200) {
          var mapbox_address_JSON = JSON.parse(jsonhttp.responseText);
          var latlon = mapbox_address_JSON.features[0].center;
          latitude = latlon[0];
          longitude = latlon[1];
          console.log("Global lon/lat set to", longitude, latitude);
      }
      jsonhttp.open("GET", make_address_query_url("1600+pennsylvania+ave+nw"), true);
      jsonhttp.send();
    };
  }

  function makeMap (lat, lon) {
    L.mapbox.accessToken = token;
    var map = L.mapbox.map('map', 'mapbox.pirates')
        .setView([lat, lon], 16);

    // L.marker is a low-level marker constructor in Leaflet.
    L.marker([lat, lon], {
        icon: L.mapbox.marker.icon({
            'marker-size': 'large',
            'marker-symbol': 'building',
            'marker-color': '#fa0'
        })
    }).addTo(map);

    // for each bus stop on dashboard, display it
    var stops = [];
    $('.bus_stop_data').each( function (index, value) {
      var stop = $(this).children();
      var s = {};
      s.name = stop.eq(0).text();
      s.id = stop.eq(1).text();
      s.lat = stop.eq(2).text();
      s.lon = stop.eq(3).text();
      stops.push(s);
    });

    stops.forEach ( function (stop) {
      L.marker([stop.lat, stop.lon], {
          icon: L.mapbox.marker.icon({
              'marker-size': 'large',
              'marker-symbol': 'bus',
              'marker-color': '#fa0'
          })
      }).addTo(map);
    });
  }

  if ( $('#lat').length != 0 && $('lon') != 0 ) {
    var lat = parseFloat( $('#lat').text() );
    var lon = parseFloat( $('#lon').text() );
    makeMap( lat, lon );
    // console.log('Map generated');
  } else if ( $('#dashboard_lat').length == 1 && $('#dashboard_lon').length == 1 ) {
    var lat = parseFloat( $('#dashboard_lat').val() );
    var lon = parseFloat( $('#dashboard_lon').val() );
    // console.log('Map generated from form');
    makeMap( lat, lon );
  } else {
    makeMap( parseFloat(latitude), parseFloat(longitude) );
  }
});
