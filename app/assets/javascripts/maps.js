//var x = document.getElementById("demo");
var map = document.getElementById("map");

if (navigator.geolocation) {
	navigator.geolocation.getCurrentPosition(updateMap1);
} else {
  //x.innerHTML = "Geolocation is not supported by this browser.";
}

function updateMap1(position) {
	var map_url = map.src;
	var lat_lng_url = map.src.indexOf("&ll=");
	var new_location = "&ll=" + position.coords.latitude +", " + position.coords.longitude;
	var zoom = "&z=14";
	var new_url = map_url.substr(0, lat_lng_url) + new_location + zoom;
	map.src = new_url;
}

function updateMap2(lat, lng) {
	var map_url = map.src;
	var lat_lng_url = map.src.indexOf("&ll=");
	var new_location = "&ll=" + lat +", " + lng;
	var zoom = "&z=14";
	var new_url = map_url.substr(0, lat_lng_url) + new_location + zoom;
	map.src = new_url;
}