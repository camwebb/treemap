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
	    var longOri = Number(queryString('long')) + 0.001 ;
	    var latOri  = Number(queryString('lat')) ;
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

  var xpx = parseInt( wid + ((p.coords.longitude - longOri ) * factr )) ;
  var ypx = parseInt( hig - ((+p.coords.latitude  - latOri ) * factr));  
  
  if ((xpx >= 0) && (xpx < wid) && (ypx >= 0) && (ypx < hig ))
	{
	  var ctx = document.getElementById("gps").getContext("2d");

	  var dot = new Image();
	  dot.src = "img/ring.png";
	  dot.onload = function() {
		ctx.drawImage(dot, xpx-25, ypx-25);
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
