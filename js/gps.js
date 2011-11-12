function gpsit()
{
  // initialize, using geo.js
  if(geo_position_js.init())
	{
	  setInterval(retrieve,5000);
	}
  else
	{
	  document.getElementById('current').innerHTML="Functionality not available";
	  // alert("GPS functionality not available");
	}
}

function retrieve()
{
  document.getElementById('current').innerHTML="Updating location...";
  geo_position_js.getCurrentPosition(success_callback, error_callback, {enableHighAccuracy:true});  
	  // or try without accuracy ,options:5000
      // Aslo try geo_position_js.watchPosition(success_callback, error_callback, {enableHighAccuracy:true}); without an interval
     
}

function success_callback(p)
{
  // write to status bar
  document.getElementById('current').innerHTML="Your current lat: " + p.coords.latitude.toFixed(5)+", long: " + p.coords.longitude.toFixed(5) ;

  // if the script is called map, set params to small tiles
  // if ( window.location.pathname.substring( window.location.pathname.lastIndexOf('/')+1) == 'map')
  if (queryString('method') == 'mapHi')
	{
	    var longOri = new Number(queryString('long')) + 0.001 ;
	    var latOri  = new Number(queryString('lat')) ;
	    var wid = 500 ;
	    var hig = 500 ;
	    var factr = 500000 ;
	    // alert('map! '+ longOri + ', '+ latOri);
	}
  // else to large pane
  else
	{
	  var longOri = -71.115 ;
	  var latOri = 42.288 ;
	  var wid = 525 ;
	  var hig = 550 ;
	  var factr = 25000 ;
	}

  // convert long/lat to pixels
  var xpx = parseInt( wid + ((p.coords.longitude - longOri ) * factr )) ;
  var ypx = parseInt( hig - ((+p.coords.latitude  - latOri ) * factr));  
  
  // test for location in box
  if ((xpx >= 0) && (xpx < wid) && (ypx >= 0) && (ypx < hig ))
	{
	  var ctx = document.getElementById("gps").getContext("2d");

	  ctx.globalCompositeOperation = 'destination-over';  
	  ctx.clearRect(0,0,500,525); // clear canvas  

	  var dot = new Image();
	  dot.src = "img/ring.png";
	  dot.onload = function() {
	  	ctx.drawImage(dot, xpx-25, ypx-25);
	  }
	  // ctx.drawImage(dot, xpx-25, ypx-25);

	}
  else
	{
	  if (xpx < 0) { var locnwe = 'W' }
	  else if (xpx > wid) { var locnwe = 'E' }
	  else 	{ var locnwe = '' }
	  if (ypx < 0) { var locnns = 'N' }
	  else if (ypx > hig) { var locnns = 'S' }
	  else { var locnns = '' }

	  document.getElementById('current').innerHTML="Your current lat: " + p.coords.latitude.toFixed(5)+", long: " + p.coords.longitude.toFixed(5) + " (to " + locnns + locnwe + " of this map)";

	  var ctx = document.getElementById("gps").getContext("2d");
	  ctx.clearRect(0,0,500,525); // clear canvas  

	}
}

function error_callback(p)
{
  document.getElementById('current').innerHTML="Couldn't get location"
  // alert('error='+p.message);
}               


function queryString( key )
{
  // from http://blog.falafel.com/Blogs/AdamAnderson/07-12-17/Parse_a_Query_String_in_JavaScript.aspx
  var re = new RegExp( "[?&]" + key + "=([^&$]*)", "i" );
  var offset = location.search.search( re );
  if ( offset == -1 ) return null;
  return RegExp.$1;
}
