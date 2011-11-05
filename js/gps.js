function gpsit()
{
  if(geo_position_js.init())
	{
	  geo_position_js.getCurrentPosition(success_callback, error_callback, {enableHighAccuracy:true, options:5000});
	}
  else
	{
	  alert("GPS functionality not available");
	}
}

function success_callback(p)
{
  var xpx = Math.round(525 + ((+p.coords.longitude.toFixed(3) - -71.115) * 25000)) ;
  var ypx = Math.round(550 - ((+p.coords.latitude.toFixed(3)  - 42.288) * 25000));  

  // alert('lat='+p.coords.latitude.toFixed(3)+';lon='+p.coords.longitude.toFixed(3));
  
  // alert('lat=' + ypx + ';lon=' + xpx );
  //draw(p);
  var ctx = document.getElementById("gps").getContext("2d");
  // left of map = -71.136, right of map = -71.115 : width = 
  var xpx = Math.round(525 + ((+p.coords.longitude.toFixed(3) - -71.115) * 25000)) ;
  var ypx = Math.round(550 - ((+p.coords.latitude.toFixed(3)  - 42.288) * 25000));
  // ctx.fillRect(100, 100, 200, 200);
  var dot = new Image();
  dot.src = "img/dot.png";
  dot.onload = function() {
	ctx.drawImage(dot, xpx, ypx);
  }
}

function error_callback(p)
{
  alert('error='+p.message);
}               

function  draw(p) {
}

