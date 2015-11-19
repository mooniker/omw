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


// function geoFindMe() {
//   var output = document.getElementById("out");
//
//   if (!navigator.geolocation){
//     output.innerHTML = "<p>Geolocation is not supported by your browser</p>";
//     return;
//   }
//
//   function success(position) {
//     var latitude  = position.coords.latitude;
//     var longitude = position.coords.longitude;
//
//     output.innerHTML = '<p>Latitude is ' + latitude + '° <br>Longitude is ' + longitude + '°</p>';
//
//     var img = new Image();
//     img.src = "https://maps.googleapis.com/maps/api/staticmap?center=" + latitude + "," + longitude + "&zoom=13&size=300x300&sensor=false";
//
//     output.appendChild(img);
//   };
//
//   function error() {
//     output.innerHTML = "Unable to retrieve your location";
//   };
//
//   output.innerHTML = "<p>Locating…</p>";
//
//   navigator.geolocation.getCurrentPosition(success, error);
// }

// defaults
var latitude = 38.8898; // U.S. Capitol
var longitude = -77.0091;

// constants
var token = 'pk.eyJ1IjoibW9vbmlrZXIiLCJhIjoiY2loNHkwMmUwMHp1Znc5bTVxZGptZ3d1eSJ9.IjtdkC-4egUXjw39mKShgA';
// var address_query = "https://api.mapbox.com/geocoding/v5/{dataset}/{query}.json?proximity={longitude},{latitude}&access_token={token}";
//
// function make_address_query_url( query ) {
// // "https://api.mapbox.com/geocoding/v5/{dataset}/{query}.json?proximity={longitude},{latitude}&access_token={token}";
//   var prefix = "https://api.mapbox.com/geocoding/v5/mapbox.places/";
//   return prefix + query + ".json?proximity=" + longitude + "," + latitude + "&access_token=" + token;
// }

// function set_lon_lat_from_address() {
//
//   var jsonhttp = new XMLHttpRequest();
//
//   jsonhttp.onreadystatechange = function() {
//     if (jsonhttp.readyState == 4 && jsonhttp.status == 200) {
//         var mapbox_address_JSON = JSON.parse(jsonhttp.responseText);
//         var latlon = mapbox_address_JSON.features[0].center;
//         latitude = latlon[0];
//         longitude = latlon[1];
//         console.log("Global lon/lat set to", longitude, latitude);
//     }
//     jsonhttp.open("GET", make_address_query_url("1600+pennsylvania+ave+nw"), true);
//     jsonhttp.send();
//   };
// }

function dashboard_has( stop_id ) {
  return $('#dashboard_stop_id_str').val().search( stop_id ) >= 0;
}

function get_bus_stop_geojson() {
  var geojson = {};
  geojson['type'] = 'FeatureCollection';
  geojson['features'] = [];

  $('.bus_stop_data').each( function (index, value) {
    var stop = $(this).children();
    var new_feature = {
      "type": "Feature",
      "geometry": {
        "type": "Point",
        "coordinates": [parseFloat( stop.eq(3).text() ), parseFloat( stop.eq(2).text() ) ]
      },
      "properties": {
        "title": stop.eq(0).text(),
        "amenity": "bus stop",
        "description": stop.eq(1).text(),
        "marker-symbol": "bus"
      }
    };
    if ( dashboard_has( stop.eq(1).text() ) ) {
      new_feature.properties['marker-color'] = '#277227'; // green
    } else {
      new_feature.properties['marker-color'] = '#000277'; // green
    }
    geojson['features'].push(new_feature);
  });
  return geojson;
};

var map;
var locations;
var listings = document.getElementById('listings');

function make_map (lat, lon) {

  var default_zoom = 15;
  L.mapbox.accessToken = token;
  map = L.mapbox.map('map', 'mapbox.pirates')
      .setView([lat, lon], default_zoom);
  // map.touchZoom.disable();
  map.scrollWheelZoom.disable();


  // L.marker is a low-level marker constructor in Leaflet.
  L.marker([lat, lon], {
      icon: L.mapbox.marker.icon({
          'marker-size': 'large',
          'marker-symbol': 'building',
          'marker-color': '#000277' //'#fa0'
      })
  }).addTo(map);

  locations = L.mapbox.featureLayer().addTo(map);
  locations.setGeoJSON( get_bus_stop_geojson() );

  // locations.setGeoJSON(geojson);

  // function setActive(el) {
  //   var siblings = listings.getElementsByTagName('div');
  //   for (var i = 0; i < siblings.length; i++) {
  //     siblings[i].className = siblings[i].className
  //     .replace(/active/, '').replace(/\s\s*$/, '');
  //   }
  //
  //   el.className += ' active';
  // }

  // locations.eachLayer( function( locale ) {
  //   // Shorten locale.feature.properties to just `prop` so we're not
  //   // writing this long form over and over again.
  //   var prop = locale.feature.properties;
  //
  //   // Each marker on the map.
  //   var popup = '<h3>omw?</h3><div>' + prop.title;
  //
  //   var listing = listings.appendChild(document.createElement('div'));
  //   listing.className = 'item';
  //
  //   var link = listing.appendChild(document.createElement('a'));
  //   link.href = '#';
  //   link.className = 'title';
  //   link.innerHTML = prop.title;
  //
  //   link.onclick = function {
  //     map.setView(locale.getLatLng(), 16);
  //     locale.openPopup();
  //   }
  // });

  // // for each bus stop on dashboard, display it
  // var stops = [];
  // $('.bus_stop_data').each( function (index, value) {
  //   var stop = $(this).children();
  //   var s = {};
  //   s.name = stop.eq(0).text();
  //   s.id = stop.eq(1).text();
  //   s.lat = stop.eq(2).text();
  //   s.lon = stop.eq(3).text();
  //   stops.push(s);
  // });
  //
  // stops.forEach ( function (stop) {
  //   // var marker_size = 'small';
  //   var marker_color = '#fa0';
  //   // console.log(stop.id);
  //   if ( dashboard_has(stop.id) ) {
  //     // marker_size = 'large';
  //     marker_color = '#277227'; // green
  //   }
  //   L.marker([stop.lat, stop.lon], {
  //       icon: L.mapbox.marker.icon({
  //           'marker-size': 'medium', // marker_size,
  //           'marker-symbol': 'bus',
  //           'marker-color': marker_color //'#fa0'
  //       })
  //   }).addTo(map);
  // });
}

$( document ).ready(function() {

  if ( $('#lat').length !== 0 && $('#lon').length !== 0 ) {
    make_map( parseFloat( $('#lat').text() ), parseFloat( $('#lon').text() ) );
  } else if ( $('#dashboard_lat').val().length > 0 && $('#dashboard_lon').val().length > 0 ) {
    var lat = parseFloat( $('#dashboard_lat').val() );
    var lon =  parseFloat( $('#dashboard_lon').val() );
    make_map( lat, lon );
    console.log( "Map set from dashboard form to", lat, lon);
  } else {
    make_map( latitude, longitude );
    console.log( "Map by default set to", latitude, longitude );
  }
});
