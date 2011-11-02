BEGIN{

    print "<html xmlns=\"http://www.w3.org/1999/xhtml\"> \
         <head><title>Arnold Arboretum Trees</title> \
         <meta http-equiv=\"Content-Type\" content=\"text/html; \
           charset=utf-8\" /><link rel=\"stylesheet\" \
           href=\"aa.css\" type=\"text/css\" /> \
           </head><body>" ;
	print "<h1>Arboretum trees</h1>";
	print "<img src=\"thumb.jpg\" usemap=\"#grid\" border=\"0\" />";
	print "<map name=\"grid\">";
  for (y = 0; y < 22; y++)
	{
	  for (x = 0; x < 21 ; x++)
		{
		  print "<area shape=\"rect\" coords=" x * 25 "," (y+1) *25 "," (x+1)*25 "," y*25 "\" href=\"map?long=-71." 136-x "&lat=42." 309 - y  "\" />" ;
		}
	}

  print "</map></body></html>";
  exit
}