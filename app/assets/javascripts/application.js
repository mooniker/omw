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

// pk.eyJ1IjoibW9vbmlrZXIiLCJhIjoiY2loNHkwMmUwMHp1Znc5bTVxZGptZ3d1eSJ9.IjtdkC-4egUXjw39mKShgA

// $(document).ready(function () {
//
//   if ( $('#lat') !== null && $('lon') !== null ) {
//     var lat = parseFloat( $('#lat').text() );
//     var lon = parseFloat( $('#lon').text() );
//     L.mapbox.accessToken = 'pk.eyJ1IjoibW9vbmlrZXIiLCJhIjoiY2loNHkwMmUwMHp1Znc5bTVxZGptZ3d1eSJ9.IjtdkC-4egUXjw39mKShgA';
//     var map = L.mapbox.map('map', 'mapbox.streets')
//         .setView([lat, lon], 6);
//
//     // L.marker is a low-level marker constructor in Leaflet.
//     L.marker([lat, lon], {
//         icon: L.mapbox.marker.icon({
//             'marker-size': 'large',
//             'marker-symbol': 'bus',
//             'marker-color': '#fa0'
//         })
//     }).addTo(map);
//   }
// });
