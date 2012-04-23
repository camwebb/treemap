function error(msg) {
  print "<pre>" ;
  print msg ;
  print "Exiting. Please return to previous page.";
  print "</pre>" ;
  htmlFooter() ;
  exit;
}

# decode urlencoded string
function urldecode(text,   hex, i, hextab, decoded, len, c, c1, c2, code) {
	
  split("0 1 2 3 4 5 6 7 8 9 a b c d e f", hex, " ")
  for (i=0; i<16; i++) hextab[hex[i+1]] = i
  
  # urldecode function from Heiner Steven
  # http://www.shelldorado.com/scripts/cmds/urldecode

  # decode %xx to ASCII char 
  decoded = ""
  i = 1
  len = length(text)
  
  while ( i <= len ) {
    c = substr (text, i, 1)
    if ( c == "%" ) {
      if ( i+2 <= len ) {
	c1 = tolower(substr(text, i+1, 1))
	c2 = tolower(substr(text, i+2, 1))
	if ( hextab [c1] != "" || hextab [c2] != "" ) {
	  # print "Read: %" c1 c2;
	  # Allow: 
	  # 20 begins main chars, but dissallow 7F (wrong in orig code!)
	       # tab, newline, formfeed, carriage return
	  if ( ( (c1 >= 2) && ((c1 c2) != "7f") )  \
	       || (c1 == 0 && c2 ~ "[9acd]") )
	  {
	    code = 0 + hextab [c1] * 16 + hextab [c2] + 0
	    # print "Code: " code
	    c = sprintf ("%c", code)
	  } else {
	    # for dissallowed chars
	    c = " "
	  }
	  i = i + 2
	}
      }
    } else if ( c == "+" ) {	# special handling: "+" means " "
      c = " "
    }
    decoded = decoded c
    ++i
  }
  
  # change linebreaks to \n
  gsub(/\r\n/, "\n", decoded);
  
  # remove last linebreak
  sub(/[\n\r]*$/,"",decoded);
  
  return decoded
}

# the list of taxa for the Latin school
function latinlist() {
  
  htmlHeader("Latin School observations", 400);

  print "<h1>Latin School citizen science observations</h1>";
  print "<p>Please make observations of the following species:</p><ul>"
  print "<li><a href=\"map?method=mapLo&sp=Cephalanthus occidentalis\">Cephalanthus occidentalis</a></li> \
<li><a href=\"map?method=mapLo&sp=Prunus grayana\">Prunus grayana</a></li> \
<li><a href=\"map?method=mapLo&sp=Sorbus yuana\">Sorbus yuana</a></li>	\
<li><a href=\"map?method=mapLo&sp=Styphnolobium japonicum\">Styphnolobium japonicum</a></li> \
<li><a href=\"map?method=mapLo&sp=Robinia pseudoacacia\">Robinia pseudoacacia</a></li> \
<li><a href=\"map?method=mapLo&sp=Rhododendron vaseyi\">Rhododendron vaseyi</a></li> \
<li><a href=\"map?method=mapLo&sp=Koelreuteria paniculata\">Koelreuteria paniculata</a></li> \
<li><a href=\"map?method=mapLo&sp=Cotinus coggygria\">Cotinus coggygria</a></li> \
<li><a href=\"map?method=mapLo&sp=Staphylea trifolia\">Staphylea trifolia</a></li> \
<li><a href=\"map?method=mapLo&sp=Rhododendron calendulaceum\">Rhododendron calendulaceum</a></li> \
<li><a href=\"map?method=mapLo&sp=Ailanthus altissima\">Ailanthus altissima</a></li> \
<li><a href=\"map?method=mapLo&sp=Phellodendron amurense\">Phellodendron amurense</a></li> \
<li><a href=\"map?method=mapLo&sp=Tilia cordata\">Tilia cordata</a></li> \
<li><a href=\"map?method=mapLo&sp=Calycanthus floridus\">Calycanthus floridus</a></li> \
<li><a href=\"map?method=mapLo&sp=Magnolia virginiana\">Magnolia virginiana</a></li></ul>" ;
  print "<p>While you are searching for these plants, please feel free to make observations of other species that may be in flower, or if you see an animal feeding on the plant.</p><p>For this project, we request that you take a photo of the flowers or fruits, <i>and</i> add a photo of the tag in the appropriate place on the form. Please also add your email address, so you can track your progress.</p><p><b>iPhone users</b> please note: Safari prevents you from uploading files to a standard web form. You will need to download the <a href=\"http://itunes.apple.com/sa/app/webuploader/id448687892\">WebUploader</a> app, a simple drop-in replacement for Safari that does allow you to upload your photos.</p>"; 

  htmlFooter();

}
