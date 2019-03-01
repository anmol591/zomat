// This example displays an address form, using the autocomplete feature
// of the Google Places API to help users fill in the information.

// This example requires the Places library. Include the libraries=places
// parameter when you first load the API. For example:
// <script src="https://maps.googleapis.com/maps/api/js?key=YOUR_API_KEY&libraries=places">
$(document).ready(function(){
  $("form").submit(function(event){
    if($("#autocomplete").val()=="")
    {
      alert("Please choose location");
      event.preventDefault();
    }
    else
    {
      $('input[name="lat"]').val(lat.toFixed(3));
      $('input[name="long"]').val(lng.toFixed(3));

    }

  });
});

 
        
var placeSearch, autocomplete,lat,lng;
// initAutocomplete();

function initAutocomplete() {
  // Create the autocomplete object, restricting the search to geographical
  // location types.
  autocomplete = new google.maps.places.Autocomplete(
      /** @type {!HTMLInputElement} */(document.getElementById('autocomplete')),
      {types: ['(regions)']});

  // When the user selects an address from the dropdown, populate the address
  // fields in the form.
  autocomplete.addListener('place_changed', fillInAddress);
}
function fillInAddress() {
  // Get the place details from the autocomplete object.
  var place = autocomplete.getPlace();
	lat=place.geometry.location.lat();
  lng=place.geometry.location.lng();
  $('#lat_input').val(lat)
  $('#lang_input').val(lng)
  
}


// Bias the autocomplete object to the user's geographical location,
// as supplied by the browser's 'navigator.geolocation' object.
function geolocate() {
  if (navigator.geolocation) {
    navigator.geolocation.getCurrentPosition(function(position) {
      var geolocation = {
        lat: position.coords.latitude,
        lng: position.coords.longitude
      };
      var circle = new google.maps.Circle({
        center: geolocation,
        radius: position.coords.accuracy
      });
      autocomplete.setBounds(circle.getBounds());
    });
  }
}