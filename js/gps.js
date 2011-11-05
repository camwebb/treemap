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
  if ( window.location.pathname.substring( window.location.pathname.lastIndexOf('/')+1) == 'map')
	{
	  var longOri = queryString('long') ;
	  var latOri = queryString('lat') ;
	  var wid = 500 ;
	  var hig = 500 ;
	  var factr = 500000 ;
	  // alert('map! '+ longOri + ', '+ latOri);
	}
  else
	{
	  var longOri = -71.115 ;
	  var latOri = 42.288 ;
	  var wid = 525 ;
	  var hig = 550 ;
	  var factr = 25000 ;
	}

  var xpx = Math.round( wid + ((+p.coords.longitude.toFixed(3) - longOri ) * factr )) ;
  var ypx = Math.round( hig - ((+p.coords.latitude.toFixed(3)  - latOri ) * factr));  
  
  // xpx = 100; ypx = 100;

  alert('lat=' + ypx + ';lon=' + xpx );

  if ((xpx >= 0) && (xpx < wid) && (ypx >= 0) && (ypx < hig ))
	{
	  var ctx = document.getElementById("gps").getContext("2d");
	  // left of map = -71.136, right of map = -71.115 : width = 
  
	  // var xpx = Math.round(525 + ((+p.coords.longitude.toFixed(3) - -71.115) * 25000)) ;
	  // var ypx = Math.round(550 - ((+p.coords.latitude.toFixed(3)  - 42.288) * 25000));

	  var dot = new Image();
	  dot.src = "img/dot.png";
	  dot.onload = function() {
		ctx.drawImage(dot, xpx, ypx);
	  }
	}
}

function error_callback(p)
{
  alert('error='+p.message);
}               


function queryString( key )
{
  // from http://blog.falafel.com/Blogs/AdamAnderson/07-12-17/Parse_a_Query_String_in_JavaScript.aspx
  var re = new RegExp( "[?&]" + key + "=([^&$]*)", "i" );
  var offset = location.search.search( re );
  if ( offset == -1 ) return null;
  return RegExp.$1;
}
