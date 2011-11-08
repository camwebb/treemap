function htmlHeader(title, width) 
{
  # Most correct, but only opens on mobiles, not on desktop:
  # print "Content-type: application/vnd.wap.xhtml+xml\n\n";
  # print "<?xml version=\"1.0\" ?> \
  #        <!DOCTYPE html PUBLIC \"-//WAPFORUM//DTD XHTML Mobile 1.2//EN\" \
  #        \"http://www.openmobilealliance.org/tech/DTD/xhtml-mobile12.dtd\">";

  # Use html5
  print "Content-type: text/html\n" ;
  print "<!DOCTYPE html>";
  print "<html xmlns=\"http://www.w3.org/1999/xhtml\"> \
         <head><title>" title "</title>					\
         <meta name=\"viewport\" content=\"width=" width ", user-scalable=yes\" /> \
         <meta http-equiv=\"Content-Type\" content=\"text/html; \
           charset=utf-8\" /><link rel=\"stylesheet\" \
           href=\"css/treemap.css\" type=\"text/css\" /> \
           </head>";
  if ((f["method"] ~ "map") || (!f["method"]))
	{
	  print "<body onload=\"gpsit()\">" 
	}
  else print "<body>" ;

  # <link href=\"../img/icon.ico\" rel=\"shortcut icon\" type=\"image/x-icon\"/>

}

function htmlFooter()
{
  if ((f["method"] ~ "map") || (!f["method"]))
	{
	  print	"<p id=\"current\">Initializing GPS...</p>";
	  print "<script type=\"text/javascript\" src=\"js/gps.js\" ></script> \
	     <script type=\"text/javascript\" src=\"js/geo.js\"></script> \
	     <script src=\"http://code.google.com/apis/gears/gears_init.js\" \
                 type=\"text/javascript\" charset=\"utf-8\"></script>" ;
	}
  print "</body></html>\n";
}
  