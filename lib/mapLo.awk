function mapLo()
{

  # is it a blank call?
  if (!f["tag"] && !f["gen"] && !f["sp"])
	{
	  htmlHeader("Arnold Arboretum trees", 600);

	  print "<h1>Arnold Arboretum trees</h1> \
	         <form method=\"get\" action=\"map\"> \
 	         <p> \
		       <input name=\"method\" type=\"hidden\" value=\"search\" /> \
		       <input name=\"q\" type=\"text\" size=\"15\" /> \
		       <input type=\"submit\" value=\"search\" /> \
		       for family or genus &amp; species or tag code,<br /> \
               or browse by tapping on area to zoom in. \
		       (<a href=\"map?method=about\">about...</a>) \
	         </p></form> \
	         <div id=\"base\"> \
	           <img src=\"img/mapLo.jpg\" border=\"0\" alt=\"\" /> \
	           <div id=\"mid\"> \
		         <canvas id=\"gps\" width=\"525\" height=\"550\"></canvas> \
	           </div> \
	           <div id=\"top\"> \
		         <img src=\"img/blank.png\" width=\"525\" height=\"550\" \
                    usemap=\"#grid\" border=\"0\" alt=\"\" /> \
	           </div> \
	           <div id=\"toptext\"> \
		         <p>See recent citizen scientist<br/> \
                 <a href=\"map?method=obsS\">images and data</a></p> \
	           </div> \
	         </div> " ;

	  staticImageMap() ;
	}

  else mapLoQ() ;
}

function mapLoQ()
{

  htmlHeader("Search results", 600);


  print "<h1>Search results</h1>";
  print "<p><b>" f["fam"] f["sp"] f["tag"] "</b></p>" ;
  print "<map name=\"trees\">" ;

  FS="|";
  while ((getline < "data/aa-tree.csv") > 0)
	{
	  # if tag is given
	  if ($1 == f["tag"])
		{
		  xsq = substr(($14 - 0.001),1,7); ysq = substr($13,1,6) ;
		  print xsq + 0.0005" " ysq +0.0005 > "run/" ps ".dat";
		  print "<area shape=\"circle\" coords=" int(525 + (( xsq + 0.0005 ) - -71.115) * 25000) "," int(550 - ((( ysq + 0.0005 ) - 42.288) * 25000)) ",12\" href=\"map?method=mapHi&amp;long=" xsq "&amp;lat=" ysq "&amp;tag=" f["tag"] "\" />" ;
		  break ;
		}
	  # or if taxa given
	  else if (($3 == f["fam"]) || ($4 == f["sp"]))
		{
		  ll[ substr(($14 - 0.001),1,7) "|" substr($13,1,6) ]++;
		}
	}

  # if no tag given
  if (!f["tag"])
	{
	  for (i in ll)
		{
		  # print i;
		  split(i,tmp,"|");
		  print tmp[1] + 0.0005 " " tmp[2] + 0.0005 >> "run/" ps ".dat";
		  # x = -1000 *(tmp[1] + 71) ; y = 1000 *(tmp[2]-42) ;
		  if (f["fam"] != "") qry = "fam=" f["fam"] ;
		  else if (f["sp"] != "") qry = "sp=" f["sp"] ;
		  print "<area shape=\"circle\" coords=" int(525 + ((tmp[1] + 0.0005) - -71.115) * 25000) "," int(550 - (((tmp[2] + 0.0005) - 42.288) * 25000)) ",12\" href=\"map?method=mapHi&amp;long=" tmp[1] "&amp;lat=" tmp[2] "&amp;" qry "\" />" ;
		}
	}

  print "</map>";
  
  gpHeaderMapLo() ;

  print "plot \"run/" ps ".dat\" with points pointtype 4 pointsize 4 linewidth 2 lt rgb \"yellow" >> "run/" ps ".plt" ;

  system("gnuplot run/" ps ".plt >& /dev/null");

  cmd = "composite run/" ps ".png img/mapLo.png run/" ps "f.png" ;
  system(cmd);
  system("convert run/" ps "f.png run/" ps ".jpg");

  displayMapLo() ;
 
}

function gpHeaderMapLo() {
  print "set terminal png transparent size 525,550\nset xrange [-71.136:-71.115]\nset yrange [42.288:42.310]\nset border 0\nunset xtics\nunset ytics\nunset key\nset bmargin 0\nset tmargin 0\nset lmargin 0\nset rmargin 0\nset output \"run/" ps ".png\"\n" > "run/" ps ".plt" ;
}


function displayMapLo() 
{

  print "<div id=\"base\"> \
           <img src=\"run/" ps ".jpg\" border=\"0\" alt=\"\" /> \
           <div id=\"mid\"> \
             <canvas id=\"gps\" width=\"525\" height=\"550\"></canvas> \
           </div> \
           <div id=\"top\"> \
             <img src=\"img/blank.png\" width=\"525\" height=\"550\" usemap=\"#trees\" border=\"0\" alt=\"\" /> \
           </div> \
         </div> " ;
}

function staticImageMap()
{
  print "<map name=\"grid\" id=\"grid\">" ;
  print "<area shape=\"rect\" coords=\"0,0,25,25\" href=\"map?method=mapHi&amp;long=-71.136&amp;lat=42.309\" /> \
<area shape=\"rect\" coords=\"25,0,50,25\" href=\"map?method=mapHi&amp;long=-71.135&amp;lat=42.309\" /> \
<area shape=\"rect\" coords=\"50,0,75,25\" href=\"map?method=mapHi&amp;long=-71.134&amp;lat=42.309\" /> \
<area shape=\"rect\" coords=\"75,0,100,25\" href=\"map?method=mapHi&amp;long=-71.133&amp;lat=42.309\" /> \
<area shape=\"rect\" coords=\"100,0,125,25\" href=\"map?method=mapHi&amp;long=-71.132&amp;lat=42.309\" /> \
<area shape=\"rect\" coords=\"125,0,150,25\" href=\"map?method=mapHi&amp;long=-71.131&amp;lat=42.309\" /> \
<area shape=\"rect\" coords=\"150,0,175,25\" href=\"map?method=mapHi&amp;long=-71.130&amp;lat=42.309\" /> \
<area shape=\"rect\" coords=\"175,0,200,25\" href=\"map?method=mapHi&amp;long=-71.129&amp;lat=42.309\" /> \
<area shape=\"rect\" coords=\"200,0,225,25\" href=\"map?method=mapHi&amp;long=-71.128&amp;lat=42.309\" /> \
<area shape=\"rect\" coords=\"225,0,250,25\" href=\"map?method=mapHi&amp;long=-71.127&amp;lat=42.309\" /> \
<area shape=\"rect\" coords=\"250,0,275,25\" href=\"map?method=mapHi&amp;long=-71.126&amp;lat=42.309\" /> \
<area shape=\"rect\" coords=\"275,0,300,25\" href=\"map?method=mapHi&amp;long=-71.125&amp;lat=42.309\" /> \
<area shape=\"rect\" coords=\"300,0,325,25\" href=\"map?method=mapHi&amp;long=-71.124&amp;lat=42.309\" /> \
<area shape=\"rect\" coords=\"325,0,350,25\" href=\"map?method=mapHi&amp;long=-71.123&amp;lat=42.309\" /> \
<area shape=\"rect\" coords=\"350,0,375,25\" href=\"map?method=mapHi&amp;long=-71.122&amp;lat=42.309\" /> \
<area shape=\"rect\" coords=\"375,0,400,25\" href=\"map?method=mapHi&amp;long=-71.121&amp;lat=42.309\" /> \
<area shape=\"rect\" coords=\"400,0,425,25\" href=\"map?method=mapHi&amp;long=-71.120&amp;lat=42.309\" /> \
<area shape=\"rect\" coords=\"425,0,450,25\" href=\"map?method=mapHi&amp;long=-71.119&amp;lat=42.309\" /> \
<area shape=\"rect\" coords=\"450,0,475,25\" href=\"map?method=mapHi&amp;long=-71.118&amp;lat=42.309\" /> \
<area shape=\"rect\" coords=\"475,0,500,25\" href=\"map?method=mapHi&amp;long=-71.117&amp;lat=42.309\" /> \
<area shape=\"rect\" coords=\"500,0,525,25\" href=\"map?method=mapHi&amp;long=-71.116&amp;lat=42.309\" /> \
<area shape=\"rect\" coords=\"0,25,25,50\" href=\"map?method=mapHi&amp;long=-71.136&amp;lat=42.308\" /> \
<area shape=\"rect\" coords=\"25,25,50,50\" href=\"map?method=mapHi&amp;long=-71.135&amp;lat=42.308\" /> \
<area shape=\"rect\" coords=\"50,25,75,50\" href=\"map?method=mapHi&amp;long=-71.134&amp;lat=42.308\" /> \
<area shape=\"rect\" coords=\"75,25,100,50\" href=\"map?method=mapHi&amp;long=-71.133&amp;lat=42.308\" /> \
<area shape=\"rect\" coords=\"100,25,125,50\" href=\"map?method=mapHi&amp;long=-71.132&amp;lat=42.308\" /> \
<area shape=\"rect\" coords=\"125,25,150,50\" href=\"map?method=mapHi&amp;long=-71.131&amp;lat=42.308\" /> \
<area shape=\"rect\" coords=\"150,25,175,50\" href=\"map?method=mapHi&amp;long=-71.130&amp;lat=42.308\" /> \
<area shape=\"rect\" coords=\"175,25,200,50\" href=\"map?method=mapHi&amp;long=-71.129&amp;lat=42.308\" /> \
<area shape=\"rect\" coords=\"200,25,225,50\" href=\"map?method=mapHi&amp;long=-71.128&amp;lat=42.308\" /> \
<area shape=\"rect\" coords=\"225,25,250,50\" href=\"map?method=mapHi&amp;long=-71.127&amp;lat=42.308\" /> \
<area shape=\"rect\" coords=\"250,25,275,50\" href=\"map?method=mapHi&amp;long=-71.126&amp;lat=42.308\" /> \
<area shape=\"rect\" coords=\"275,25,300,50\" href=\"map?method=mapHi&amp;long=-71.125&amp;lat=42.308\" /> \
<area shape=\"rect\" coords=\"300,25,325,50\" href=\"map?method=mapHi&amp;long=-71.124&amp;lat=42.308\" /> \
<area shape=\"rect\" coords=\"325,25,350,50\" href=\"map?method=mapHi&amp;long=-71.123&amp;lat=42.308\" /> \
<area shape=\"rect\" coords=\"350,25,375,50\" href=\"map?method=mapHi&amp;long=-71.122&amp;lat=42.308\" /> \
<area shape=\"rect\" coords=\"375,25,400,50\" href=\"map?method=mapHi&amp;long=-71.121&amp;lat=42.308\" /> \
<area shape=\"rect\" coords=\"400,25,425,50\" href=\"map?method=mapHi&amp;long=-71.120&amp;lat=42.308\" /> \
<area shape=\"rect\" coords=\"425,25,450,50\" href=\"map?method=mapHi&amp;long=-71.119&amp;lat=42.308\" /> \
<area shape=\"rect\" coords=\"450,25,475,50\" href=\"map?method=mapHi&amp;long=-71.118&amp;lat=42.308\" /> \
<area shape=\"rect\" coords=\"475,25,500,50\" href=\"map?method=mapHi&amp;long=-71.117&amp;lat=42.308\" /> \
<area shape=\"rect\" coords=\"500,25,525,50\" href=\"map?method=mapHi&amp;long=-71.116&amp;lat=42.308\" /> \
<area shape=\"rect\" coords=\"0,50,25,75\" href=\"map?method=mapHi&amp;long=-71.136&amp;lat=42.307\" /> \
<area shape=\"rect\" coords=\"25,50,50,75\" href=\"map?method=mapHi&amp;long=-71.135&amp;lat=42.307\" /> \
<area shape=\"rect\" coords=\"50,50,75,75\" href=\"map?method=mapHi&amp;long=-71.134&amp;lat=42.307\" /> \
<area shape=\"rect\" coords=\"75,50,100,75\" href=\"map?method=mapHi&amp;long=-71.133&amp;lat=42.307\" /> \
<area shape=\"rect\" coords=\"100,50,125,75\" href=\"map?method=mapHi&amp;long=-71.132&amp;lat=42.307\" /> \
<area shape=\"rect\" coords=\"125,50,150,75\" href=\"map?method=mapHi&amp;long=-71.131&amp;lat=42.307\" /> \
<area shape=\"rect\" coords=\"150,50,175,75\" href=\"map?method=mapHi&amp;long=-71.130&amp;lat=42.307\" /> \
<area shape=\"rect\" coords=\"175,50,200,75\" href=\"map?method=mapHi&amp;long=-71.129&amp;lat=42.307\" /> \
<area shape=\"rect\" coords=\"200,50,225,75\" href=\"map?method=mapHi&amp;long=-71.128&amp;lat=42.307\" /> \
<area shape=\"rect\" coords=\"225,50,250,75\" href=\"map?method=mapHi&amp;long=-71.127&amp;lat=42.307\" /> \
<area shape=\"rect\" coords=\"250,50,275,75\" href=\"map?method=mapHi&amp;long=-71.126&amp;lat=42.307\" /> \
<area shape=\"rect\" coords=\"275,50,300,75\" href=\"map?method=mapHi&amp;long=-71.125&amp;lat=42.307\" /> \
<area shape=\"rect\" coords=\"300,50,325,75\" href=\"map?method=mapHi&amp;long=-71.124&amp;lat=42.307\" /> \
<area shape=\"rect\" coords=\"325,50,350,75\" href=\"map?method=mapHi&amp;long=-71.123&amp;lat=42.307\" /> \
<area shape=\"rect\" coords=\"350,50,375,75\" href=\"map?method=mapHi&amp;long=-71.122&amp;lat=42.307\" /> \
<area shape=\"rect\" coords=\"375,50,400,75\" href=\"map?method=mapHi&amp;long=-71.121&amp;lat=42.307\" /> \
<area shape=\"rect\" coords=\"400,50,425,75\" href=\"map?method=mapHi&amp;long=-71.120&amp;lat=42.307\" /> \
<area shape=\"rect\" coords=\"425,50,450,75\" href=\"map?method=mapHi&amp;long=-71.119&amp;lat=42.307\" /> \
<area shape=\"rect\" coords=\"450,50,475,75\" href=\"map?method=mapHi&amp;long=-71.118&amp;lat=42.307\" /> \
<area shape=\"rect\" coords=\"475,50,500,75\" href=\"map?method=mapHi&amp;long=-71.117&amp;lat=42.307\" /> \
<area shape=\"rect\" coords=\"500,50,525,75\" href=\"map?method=mapHi&amp;long=-71.116&amp;lat=42.307\" /> \
<area shape=\"rect\" coords=\"0,75,25,100\" href=\"map?method=mapHi&amp;long=-71.136&amp;lat=42.306\" /> \
<area shape=\"rect\" coords=\"25,75,50,100\" href=\"map?method=mapHi&amp;long=-71.135&amp;lat=42.306\" /> \
<area shape=\"rect\" coords=\"50,75,75,100\" href=\"map?method=mapHi&amp;long=-71.134&amp;lat=42.306\" /> \
<area shape=\"rect\" coords=\"75,75,100,100\" href=\"map?method=mapHi&amp;long=-71.133&amp;lat=42.306\" /> \
<area shape=\"rect\" coords=\"100,75,125,100\" href=\"map?method=mapHi&amp;long=-71.132&amp;lat=42.306\" /> \
<area shape=\"rect\" coords=\"125,75,150,100\" href=\"map?method=mapHi&amp;long=-71.131&amp;lat=42.306\" /> \
<area shape=\"rect\" coords=\"150,75,175,100\" href=\"map?method=mapHi&amp;long=-71.130&amp;lat=42.306\" /> \
<area shape=\"rect\" coords=\"175,75,200,100\" href=\"map?method=mapHi&amp;long=-71.129&amp;lat=42.306\" /> \
<area shape=\"rect\" coords=\"200,75,225,100\" href=\"map?method=mapHi&amp;long=-71.128&amp;lat=42.306\" /> \
<area shape=\"rect\" coords=\"225,75,250,100\" href=\"map?method=mapHi&amp;long=-71.127&amp;lat=42.306\" /> \
<area shape=\"rect\" coords=\"250,75,275,100\" href=\"map?method=mapHi&amp;long=-71.126&amp;lat=42.306\" /> \
<area shape=\"rect\" coords=\"275,75,300,100\" href=\"map?method=mapHi&amp;long=-71.125&amp;lat=42.306\" /> \
<area shape=\"rect\" coords=\"300,75,325,100\" href=\"map?method=mapHi&amp;long=-71.124&amp;lat=42.306\" /> \
<area shape=\"rect\" coords=\"325,75,350,100\" href=\"map?method=mapHi&amp;long=-71.123&amp;lat=42.306\" /> \
<area shape=\"rect\" coords=\"350,75,375,100\" href=\"map?method=mapHi&amp;long=-71.122&amp;lat=42.306\" /> \
<area shape=\"rect\" coords=\"375,75,400,100\" href=\"map?method=mapHi&amp;long=-71.121&amp;lat=42.306\" /> \
<area shape=\"rect\" coords=\"400,75,425,100\" href=\"map?method=mapHi&amp;long=-71.120&amp;lat=42.306\" /> \
<area shape=\"rect\" coords=\"425,75,450,100\" href=\"map?method=mapHi&amp;long=-71.119&amp;lat=42.306\" /> \
<area shape=\"rect\" coords=\"450,75,475,100\" href=\"map?method=mapHi&amp;long=-71.118&amp;lat=42.306\" /> \
<area shape=\"rect\" coords=\"475,75,500,100\" href=\"map?method=mapHi&amp;long=-71.117&amp;lat=42.306\" /> \
<area shape=\"rect\" coords=\"500,75,525,100\" href=\"map?method=mapHi&amp;long=-71.116&amp;lat=42.306\" /> \
<area shape=\"rect\" coords=\"0,100,25,125\" href=\"map?method=mapHi&amp;long=-71.136&amp;lat=42.305\" /> \
<area shape=\"rect\" coords=\"25,100,50,125\" href=\"map?method=mapHi&amp;long=-71.135&amp;lat=42.305\" /> \
<area shape=\"rect\" coords=\"50,100,75,125\" href=\"map?method=mapHi&amp;long=-71.134&amp;lat=42.305\" /> \
<area shape=\"rect\" coords=\"75,100,100,125\" href=\"map?method=mapHi&amp;long=-71.133&amp;lat=42.305\" /> \
<area shape=\"rect\" coords=\"100,100,125,125\" href=\"map?method=mapHi&amp;long=-71.132&amp;lat=42.305\" /> \
<area shape=\"rect\" coords=\"125,100,150,125\" href=\"map?method=mapHi&amp;long=-71.131&amp;lat=42.305\" /> \
<area shape=\"rect\" coords=\"150,100,175,125\" href=\"map?method=mapHi&amp;long=-71.130&amp;lat=42.305\" /> \
<area shape=\"rect\" coords=\"175,100,200,125\" href=\"map?method=mapHi&amp;long=-71.129&amp;lat=42.305\" /> \
<area shape=\"rect\" coords=\"200,100,225,125\" href=\"map?method=mapHi&amp;long=-71.128&amp;lat=42.305\" /> \
<area shape=\"rect\" coords=\"225,100,250,125\" href=\"map?method=mapHi&amp;long=-71.127&amp;lat=42.305\" /> \
<area shape=\"rect\" coords=\"250,100,275,125\" href=\"map?method=mapHi&amp;long=-71.126&amp;lat=42.305\" /> \
<area shape=\"rect\" coords=\"275,100,300,125\" href=\"map?method=mapHi&amp;long=-71.125&amp;lat=42.305\" /> \
<area shape=\"rect\" coords=\"300,100,325,125\" href=\"map?method=mapHi&amp;long=-71.124&amp;lat=42.305\" /> \
<area shape=\"rect\" coords=\"325,100,350,125\" href=\"map?method=mapHi&amp;long=-71.123&amp;lat=42.305\" /> \
<area shape=\"rect\" coords=\"350,100,375,125\" href=\"map?method=mapHi&amp;long=-71.122&amp;lat=42.305\" /> \
<area shape=\"rect\" coords=\"375,100,400,125\" href=\"map?method=mapHi&amp;long=-71.121&amp;lat=42.305\" /> \
<area shape=\"rect\" coords=\"400,100,425,125\" href=\"map?method=mapHi&amp;long=-71.120&amp;lat=42.305\" /> \
<area shape=\"rect\" coords=\"425,100,450,125\" href=\"map?method=mapHi&amp;long=-71.119&amp;lat=42.305\" /> \
<area shape=\"rect\" coords=\"450,100,475,125\" href=\"map?method=mapHi&amp;long=-71.118&amp;lat=42.305\" /> \
<area shape=\"rect\" coords=\"475,100,500,125\" href=\"map?method=mapHi&amp;long=-71.117&amp;lat=42.305\" /> \
<area shape=\"rect\" coords=\"500,100,525,125\" href=\"map?method=mapHi&amp;long=-71.116&amp;lat=42.305\" /> \
<area shape=\"rect\" coords=\"0,125,25,150\" href=\"map?method=mapHi&amp;long=-71.136&amp;lat=42.304\" /> \
<area shape=\"rect\" coords=\"25,125,50,150\" href=\"map?method=mapHi&amp;long=-71.135&amp;lat=42.304\" /> \
<area shape=\"rect\" coords=\"50,125,75,150\" href=\"map?method=mapHi&amp;long=-71.134&amp;lat=42.304\" /> \
<area shape=\"rect\" coords=\"75,125,100,150\" href=\"map?method=mapHi&amp;long=-71.133&amp;lat=42.304\" /> \
<area shape=\"rect\" coords=\"100,125,125,150\" href=\"map?method=mapHi&amp;long=-71.132&amp;lat=42.304\" /> \
<area shape=\"rect\" coords=\"125,125,150,150\" href=\"map?method=mapHi&amp;long=-71.131&amp;lat=42.304\" /> \
<area shape=\"rect\" coords=\"150,125,175,150\" href=\"map?method=mapHi&amp;long=-71.130&amp;lat=42.304\" /> \
<area shape=\"rect\" coords=\"175,125,200,150\" href=\"map?method=mapHi&amp;long=-71.129&amp;lat=42.304\" /> \
<area shape=\"rect\" coords=\"200,125,225,150\" href=\"map?method=mapHi&amp;long=-71.128&amp;lat=42.304\" /> \
<area shape=\"rect\" coords=\"225,125,250,150\" href=\"map?method=mapHi&amp;long=-71.127&amp;lat=42.304\" /> \
<area shape=\"rect\" coords=\"250,125,275,150\" href=\"map?method=mapHi&amp;long=-71.126&amp;lat=42.304\" /> \
<area shape=\"rect\" coords=\"275,125,300,150\" href=\"map?method=mapHi&amp;long=-71.125&amp;lat=42.304\" /> \
<area shape=\"rect\" coords=\"300,125,325,150\" href=\"map?method=mapHi&amp;long=-71.124&amp;lat=42.304\" /> \
<area shape=\"rect\" coords=\"325,125,350,150\" href=\"map?method=mapHi&amp;long=-71.123&amp;lat=42.304\" /> \
<area shape=\"rect\" coords=\"350,125,375,150\" href=\"map?method=mapHi&amp;long=-71.122&amp;lat=42.304\" /> \
<area shape=\"rect\" coords=\"375,125,400,150\" href=\"map?method=mapHi&amp;long=-71.121&amp;lat=42.304\" /> \
<area shape=\"rect\" coords=\"400,125,425,150\" href=\"map?method=mapHi&amp;long=-71.120&amp;lat=42.304\" /> \
<area shape=\"rect\" coords=\"425,125,450,150\" href=\"map?method=mapHi&amp;long=-71.119&amp;lat=42.304\" /> \
<area shape=\"rect\" coords=\"450,125,475,150\" href=\"map?method=mapHi&amp;long=-71.118&amp;lat=42.304\" /> \
<area shape=\"rect\" coords=\"475,125,500,150\" href=\"map?method=mapHi&amp;long=-71.117&amp;lat=42.304\" /> \
<area shape=\"rect\" coords=\"500,125,525,150\" href=\"map?method=mapHi&amp;long=-71.116&amp;lat=42.304\" /> \
<area shape=\"rect\" coords=\"0,150,25,175\" href=\"map?method=mapHi&amp;long=-71.136&amp;lat=42.303\" /> \
<area shape=\"rect\" coords=\"25,150,50,175\" href=\"map?method=mapHi&amp;long=-71.135&amp;lat=42.303\" /> \
<area shape=\"rect\" coords=\"50,150,75,175\" href=\"map?method=mapHi&amp;long=-71.134&amp;lat=42.303\" /> \
<area shape=\"rect\" coords=\"75,150,100,175\" href=\"map?method=mapHi&amp;long=-71.133&amp;lat=42.303\" /> \
<area shape=\"rect\" coords=\"100,150,125,175\" href=\"map?method=mapHi&amp;long=-71.132&amp;lat=42.303\" /> \
<area shape=\"rect\" coords=\"125,150,150,175\" href=\"map?method=mapHi&amp;long=-71.131&amp;lat=42.303\" /> \
<area shape=\"rect\" coords=\"150,150,175,175\" href=\"map?method=mapHi&amp;long=-71.130&amp;lat=42.303\" /> \
<area shape=\"rect\" coords=\"175,150,200,175\" href=\"map?method=mapHi&amp;long=-71.129&amp;lat=42.303\" /> \
<area shape=\"rect\" coords=\"200,150,225,175\" href=\"map?method=mapHi&amp;long=-71.128&amp;lat=42.303\" /> \
<area shape=\"rect\" coords=\"225,150,250,175\" href=\"map?method=mapHi&amp;long=-71.127&amp;lat=42.303\" /> \
<area shape=\"rect\" coords=\"250,150,275,175\" href=\"map?method=mapHi&amp;long=-71.126&amp;lat=42.303\" /> \
<area shape=\"rect\" coords=\"275,150,300,175\" href=\"map?method=mapHi&amp;long=-71.125&amp;lat=42.303\" /> \
<area shape=\"rect\" coords=\"300,150,325,175\" href=\"map?method=mapHi&amp;long=-71.124&amp;lat=42.303\" /> \
<area shape=\"rect\" coords=\"325,150,350,175\" href=\"map?method=mapHi&amp;long=-71.123&amp;lat=42.303\" /> \
<area shape=\"rect\" coords=\"350,150,375,175\" href=\"map?method=mapHi&amp;long=-71.122&amp;lat=42.303\" /> \
<area shape=\"rect\" coords=\"375,150,400,175\" href=\"map?method=mapHi&amp;long=-71.121&amp;lat=42.303\" /> \
<area shape=\"rect\" coords=\"400,150,425,175\" href=\"map?method=mapHi&amp;long=-71.120&amp;lat=42.303\" /> \
<area shape=\"rect\" coords=\"425,150,450,175\" href=\"map?method=mapHi&amp;long=-71.119&amp;lat=42.303\" /> \
<area shape=\"rect\" coords=\"450,150,475,175\" href=\"map?method=mapHi&amp;long=-71.118&amp;lat=42.303\" /> \
<area shape=\"rect\" coords=\"475,150,500,175\" href=\"map?method=mapHi&amp;long=-71.117&amp;lat=42.303\" /> \
<area shape=\"rect\" coords=\"500,150,525,175\" href=\"map?method=mapHi&amp;long=-71.116&amp;lat=42.303\" /> \
<area shape=\"rect\" coords=\"0,175,25,200\" href=\"map?method=mapHi&amp;long=-71.136&amp;lat=42.302\" /> \
<area shape=\"rect\" coords=\"25,175,50,200\" href=\"map?method=mapHi&amp;long=-71.135&amp;lat=42.302\" /> \
<area shape=\"rect\" coords=\"50,175,75,200\" href=\"map?method=mapHi&amp;long=-71.134&amp;lat=42.302\" /> \
<area shape=\"rect\" coords=\"75,175,100,200\" href=\"map?method=mapHi&amp;long=-71.133&amp;lat=42.302\" /> \
<area shape=\"rect\" coords=\"100,175,125,200\" href=\"map?method=mapHi&amp;long=-71.132&amp;lat=42.302\" /> \
<area shape=\"rect\" coords=\"125,175,150,200\" href=\"map?method=mapHi&amp;long=-71.131&amp;lat=42.302\" /> \
<area shape=\"rect\" coords=\"150,175,175,200\" href=\"map?method=mapHi&amp;long=-71.130&amp;lat=42.302\" /> \
<area shape=\"rect\" coords=\"175,175,200,200\" href=\"map?method=mapHi&amp;long=-71.129&amp;lat=42.302\" /> \
<area shape=\"rect\" coords=\"200,175,225,200\" href=\"map?method=mapHi&amp;long=-71.128&amp;lat=42.302\" /> \
<area shape=\"rect\" coords=\"225,175,250,200\" href=\"map?method=mapHi&amp;long=-71.127&amp;lat=42.302\" /> \
<area shape=\"rect\" coords=\"250,175,275,200\" href=\"map?method=mapHi&amp;long=-71.126&amp;lat=42.302\" /> \
<area shape=\"rect\" coords=\"275,175,300,200\" href=\"map?method=mapHi&amp;long=-71.125&amp;lat=42.302\" /> \
<area shape=\"rect\" coords=\"300,175,325,200\" href=\"map?method=mapHi&amp;long=-71.124&amp;lat=42.302\" /> \
<area shape=\"rect\" coords=\"325,175,350,200\" href=\"map?method=mapHi&amp;long=-71.123&amp;lat=42.302\" /> \
<area shape=\"rect\" coords=\"350,175,375,200\" href=\"map?method=mapHi&amp;long=-71.122&amp;lat=42.302\" /> \
<area shape=\"rect\" coords=\"375,175,400,200\" href=\"map?method=mapHi&amp;long=-71.121&amp;lat=42.302\" /> \
<area shape=\"rect\" coords=\"400,175,425,200\" href=\"map?method=mapHi&amp;long=-71.120&amp;lat=42.302\" /> \
<area shape=\"rect\" coords=\"425,175,450,200\" href=\"map?method=mapHi&amp;long=-71.119&amp;lat=42.302\" /> \
<area shape=\"rect\" coords=\"450,175,475,200\" href=\"map?method=mapHi&amp;long=-71.118&amp;lat=42.302\" /> \
<area shape=\"rect\" coords=\"475,175,500,200\" href=\"map?method=mapHi&amp;long=-71.117&amp;lat=42.302\" /> \
<area shape=\"rect\" coords=\"500,175,525,200\" href=\"map?method=mapHi&amp;long=-71.116&amp;lat=42.302\" /> \
<area shape=\"rect\" coords=\"0,200,25,225\" href=\"map?method=mapHi&amp;long=-71.136&amp;lat=42.301\" /> \
<area shape=\"rect\" coords=\"25,200,50,225\" href=\"map?method=mapHi&amp;long=-71.135&amp;lat=42.301\" /> \
<area shape=\"rect\" coords=\"50,200,75,225\" href=\"map?method=mapHi&amp;long=-71.134&amp;lat=42.301\" /> \
<area shape=\"rect\" coords=\"75,200,100,225\" href=\"map?method=mapHi&amp;long=-71.133&amp;lat=42.301\" /> \
<area shape=\"rect\" coords=\"100,200,125,225\" href=\"map?method=mapHi&amp;long=-71.132&amp;lat=42.301\" /> \
<area shape=\"rect\" coords=\"125,200,150,225\" href=\"map?method=mapHi&amp;long=-71.131&amp;lat=42.301\" /> \
<area shape=\"rect\" coords=\"150,200,175,225\" href=\"map?method=mapHi&amp;long=-71.130&amp;lat=42.301\" /> \
<area shape=\"rect\" coords=\"175,200,200,225\" href=\"map?method=mapHi&amp;long=-71.129&amp;lat=42.301\" /> \
<area shape=\"rect\" coords=\"200,200,225,225\" href=\"map?method=mapHi&amp;long=-71.128&amp;lat=42.301\" /> \
<area shape=\"rect\" coords=\"225,200,250,225\" href=\"map?method=mapHi&amp;long=-71.127&amp;lat=42.301\" /> \
<area shape=\"rect\" coords=\"250,200,275,225\" href=\"map?method=mapHi&amp;long=-71.126&amp;lat=42.301\" /> \
<area shape=\"rect\" coords=\"275,200,300,225\" href=\"map?method=mapHi&amp;long=-71.125&amp;lat=42.301\" /> \
<area shape=\"rect\" coords=\"300,200,325,225\" href=\"map?method=mapHi&amp;long=-71.124&amp;lat=42.301\" /> \
<area shape=\"rect\" coords=\"325,200,350,225\" href=\"map?method=mapHi&amp;long=-71.123&amp;lat=42.301\" /> \
<area shape=\"rect\" coords=\"350,200,375,225\" href=\"map?method=mapHi&amp;long=-71.122&amp;lat=42.301\" /> \
<area shape=\"rect\" coords=\"375,200,400,225\" href=\"map?method=mapHi&amp;long=-71.121&amp;lat=42.301\" /> \
<area shape=\"rect\" coords=\"400,200,425,225\" href=\"map?method=mapHi&amp;long=-71.120&amp;lat=42.301\" /> \
<area shape=\"rect\" coords=\"425,200,450,225\" href=\"map?method=mapHi&amp;long=-71.119&amp;lat=42.301\" /> \
<area shape=\"rect\" coords=\"450,200,475,225\" href=\"map?method=mapHi&amp;long=-71.118&amp;lat=42.301\" /> \
<area shape=\"rect\" coords=\"475,200,500,225\" href=\"map?method=mapHi&amp;long=-71.117&amp;lat=42.301\" /> \
<area shape=\"rect\" coords=\"500,200,525,225\" href=\"map?method=mapHi&amp;long=-71.116&amp;lat=42.301\" /> \
<area shape=\"rect\" coords=\"0,225,25,250\" href=\"map?method=mapHi&amp;long=-71.136&amp;lat=42.300\" /> \
<area shape=\"rect\" coords=\"25,225,50,250\" href=\"map?method=mapHi&amp;long=-71.135&amp;lat=42.300\" /> \
<area shape=\"rect\" coords=\"50,225,75,250\" href=\"map?method=mapHi&amp;long=-71.134&amp;lat=42.300\" /> \
<area shape=\"rect\" coords=\"75,225,100,250\" href=\"map?method=mapHi&amp;long=-71.133&amp;lat=42.300\" /> \
<area shape=\"rect\" coords=\"100,225,125,250\" href=\"map?method=mapHi&amp;long=-71.132&amp;lat=42.300\" /> \
<area shape=\"rect\" coords=\"125,225,150,250\" href=\"map?method=mapHi&amp;long=-71.131&amp;lat=42.300\" /> \
<area shape=\"rect\" coords=\"150,225,175,250\" href=\"map?method=mapHi&amp;long=-71.130&amp;lat=42.300\" /> \
<area shape=\"rect\" coords=\"175,225,200,250\" href=\"map?method=mapHi&amp;long=-71.129&amp;lat=42.300\" /> \
<area shape=\"rect\" coords=\"200,225,225,250\" href=\"map?method=mapHi&amp;long=-71.128&amp;lat=42.300\" /> \
<area shape=\"rect\" coords=\"225,225,250,250\" href=\"map?method=mapHi&amp;long=-71.127&amp;lat=42.300\" /> \
<area shape=\"rect\" coords=\"250,225,275,250\" href=\"map?method=mapHi&amp;long=-71.126&amp;lat=42.300\" /> \
<area shape=\"rect\" coords=\"275,225,300,250\" href=\"map?method=mapHi&amp;long=-71.125&amp;lat=42.300\" /> \
<area shape=\"rect\" coords=\"300,225,325,250\" href=\"map?method=mapHi&amp;long=-71.124&amp;lat=42.300\" /> \
<area shape=\"rect\" coords=\"325,225,350,250\" href=\"map?method=mapHi&amp;long=-71.123&amp;lat=42.300\" /> \
<area shape=\"rect\" coords=\"350,225,375,250\" href=\"map?method=mapHi&amp;long=-71.122&amp;lat=42.300\" /> \
<area shape=\"rect\" coords=\"375,225,400,250\" href=\"map?method=mapHi&amp;long=-71.121&amp;lat=42.300\" /> \
<area shape=\"rect\" coords=\"400,225,425,250\" href=\"map?method=mapHi&amp;long=-71.120&amp;lat=42.300\" /> \
<area shape=\"rect\" coords=\"425,225,450,250\" href=\"map?method=mapHi&amp;long=-71.119&amp;lat=42.300\" /> \
<area shape=\"rect\" coords=\"450,225,475,250\" href=\"map?method=mapHi&amp;long=-71.118&amp;lat=42.300\" /> \
<area shape=\"rect\" coords=\"475,225,500,250\" href=\"map?method=mapHi&amp;long=-71.117&amp;lat=42.300\" /> \
<area shape=\"rect\" coords=\"500,225,525,250\" href=\"map?method=mapHi&amp;long=-71.116&amp;lat=42.300\" /> \
<area shape=\"rect\" coords=\"0,250,25,275\" href=\"map?method=mapHi&amp;long=-71.136&amp;lat=42.299\" /> \
<area shape=\"rect\" coords=\"25,250,50,275\" href=\"map?method=mapHi&amp;long=-71.135&amp;lat=42.299\" /> \
<area shape=\"rect\" coords=\"50,250,75,275\" href=\"map?method=mapHi&amp;long=-71.134&amp;lat=42.299\" /> \
<area shape=\"rect\" coords=\"75,250,100,275\" href=\"map?method=mapHi&amp;long=-71.133&amp;lat=42.299\" /> \
<area shape=\"rect\" coords=\"100,250,125,275\" href=\"map?method=mapHi&amp;long=-71.132&amp;lat=42.299\" /> \
<area shape=\"rect\" coords=\"125,250,150,275\" href=\"map?method=mapHi&amp;long=-71.131&amp;lat=42.299\" /> \
<area shape=\"rect\" coords=\"150,250,175,275\" href=\"map?method=mapHi&amp;long=-71.130&amp;lat=42.299\" /> \
<area shape=\"rect\" coords=\"175,250,200,275\" href=\"map?method=mapHi&amp;long=-71.129&amp;lat=42.299\" /> \
<area shape=\"rect\" coords=\"200,250,225,275\" href=\"map?method=mapHi&amp;long=-71.128&amp;lat=42.299\" /> \
<area shape=\"rect\" coords=\"225,250,250,275\" href=\"map?method=mapHi&amp;long=-71.127&amp;lat=42.299\" /> \
<area shape=\"rect\" coords=\"250,250,275,275\" href=\"map?method=mapHi&amp;long=-71.126&amp;lat=42.299\" /> \
<area shape=\"rect\" coords=\"275,250,300,275\" href=\"map?method=mapHi&amp;long=-71.125&amp;lat=42.299\" /> \
<area shape=\"rect\" coords=\"300,250,325,275\" href=\"map?method=mapHi&amp;long=-71.124&amp;lat=42.299\" /> \
<area shape=\"rect\" coords=\"325,250,350,275\" href=\"map?method=mapHi&amp;long=-71.123&amp;lat=42.299\" /> \
<area shape=\"rect\" coords=\"350,250,375,275\" href=\"map?method=mapHi&amp;long=-71.122&amp;lat=42.299\" /> \
<area shape=\"rect\" coords=\"375,250,400,275\" href=\"map?method=mapHi&amp;long=-71.121&amp;lat=42.299\" /> \
<area shape=\"rect\" coords=\"400,250,425,275\" href=\"map?method=mapHi&amp;long=-71.120&amp;lat=42.299\" /> \
<area shape=\"rect\" coords=\"425,250,450,275\" href=\"map?method=mapHi&amp;long=-71.119&amp;lat=42.299\" /> \
<area shape=\"rect\" coords=\"450,250,475,275\" href=\"map?method=mapHi&amp;long=-71.118&amp;lat=42.299\" /> \
<area shape=\"rect\" coords=\"475,250,500,275\" href=\"map?method=mapHi&amp;long=-71.117&amp;lat=42.299\" /> \
<area shape=\"rect\" coords=\"500,250,525,275\" href=\"map?method=mapHi&amp;long=-71.116&amp;lat=42.299\" /> \
<area shape=\"rect\" coords=\"0,275,25,300\" href=\"map?method=mapHi&amp;long=-71.136&amp;lat=42.298\" /> \
<area shape=\"rect\" coords=\"25,275,50,300\" href=\"map?method=mapHi&amp;long=-71.135&amp;lat=42.298\" /> \
<area shape=\"rect\" coords=\"50,275,75,300\" href=\"map?method=mapHi&amp;long=-71.134&amp;lat=42.298\" /> \
<area shape=\"rect\" coords=\"75,275,100,300\" href=\"map?method=mapHi&amp;long=-71.133&amp;lat=42.298\" /> \
<area shape=\"rect\" coords=\"100,275,125,300\" href=\"map?method=mapHi&amp;long=-71.132&amp;lat=42.298\" /> \
<area shape=\"rect\" coords=\"125,275,150,300\" href=\"map?method=mapHi&amp;long=-71.131&amp;lat=42.298\" /> \
<area shape=\"rect\" coords=\"150,275,175,300\" href=\"map?method=mapHi&amp;long=-71.130&amp;lat=42.298\" /> \
<area shape=\"rect\" coords=\"175,275,200,300\" href=\"map?method=mapHi&amp;long=-71.129&amp;lat=42.298\" /> \
<area shape=\"rect\" coords=\"200,275,225,300\" href=\"map?method=mapHi&amp;long=-71.128&amp;lat=42.298\" /> \
<area shape=\"rect\" coords=\"225,275,250,300\" href=\"map?method=mapHi&amp;long=-71.127&amp;lat=42.298\" /> \
<area shape=\"rect\" coords=\"250,275,275,300\" href=\"map?method=mapHi&amp;long=-71.126&amp;lat=42.298\" /> \
<area shape=\"rect\" coords=\"275,275,300,300\" href=\"map?method=mapHi&amp;long=-71.125&amp;lat=42.298\" /> \
<area shape=\"rect\" coords=\"300,275,325,300\" href=\"map?method=mapHi&amp;long=-71.124&amp;lat=42.298\" /> \
<area shape=\"rect\" coords=\"325,275,350,300\" href=\"map?method=mapHi&amp;long=-71.123&amp;lat=42.298\" /> \
<area shape=\"rect\" coords=\"350,275,375,300\" href=\"map?method=mapHi&amp;long=-71.122&amp;lat=42.298\" /> \
<area shape=\"rect\" coords=\"375,275,400,300\" href=\"map?method=mapHi&amp;long=-71.121&amp;lat=42.298\" /> \
<area shape=\"rect\" coords=\"400,275,425,300\" href=\"map?method=mapHi&amp;long=-71.120&amp;lat=42.298\" /> \
<area shape=\"rect\" coords=\"425,275,450,300\" href=\"map?method=mapHi&amp;long=-71.119&amp;lat=42.298\" /> \
<area shape=\"rect\" coords=\"450,275,475,300\" href=\"map?method=mapHi&amp;long=-71.118&amp;lat=42.298\" /> \
<area shape=\"rect\" coords=\"475,275,500,300\" href=\"map?method=mapHi&amp;long=-71.117&amp;lat=42.298\" /> \
<area shape=\"rect\" coords=\"500,275,525,300\" href=\"map?method=mapHi&amp;long=-71.116&amp;lat=42.298\" /> \
<area shape=\"rect\" coords=\"0,300,25,325\" href=\"map?method=mapHi&amp;long=-71.136&amp;lat=42.297\" /> \
<area shape=\"rect\" coords=\"25,300,50,325\" href=\"map?method=mapHi&amp;long=-71.135&amp;lat=42.297\" /> \
<area shape=\"rect\" coords=\"50,300,75,325\" href=\"map?method=mapHi&amp;long=-71.134&amp;lat=42.297\" /> \
<area shape=\"rect\" coords=\"75,300,100,325\" href=\"map?method=mapHi&amp;long=-71.133&amp;lat=42.297\" /> \
<area shape=\"rect\" coords=\"100,300,125,325\" href=\"map?method=mapHi&amp;long=-71.132&amp;lat=42.297\" /> \
<area shape=\"rect\" coords=\"125,300,150,325\" href=\"map?method=mapHi&amp;long=-71.131&amp;lat=42.297\" /> \
<area shape=\"rect\" coords=\"150,300,175,325\" href=\"map?method=mapHi&amp;long=-71.130&amp;lat=42.297\" /> \
<area shape=\"rect\" coords=\"175,300,200,325\" href=\"map?method=mapHi&amp;long=-71.129&amp;lat=42.297\" /> \
<area shape=\"rect\" coords=\"200,300,225,325\" href=\"map?method=mapHi&amp;long=-71.128&amp;lat=42.297\" /> \
<area shape=\"rect\" coords=\"225,300,250,325\" href=\"map?method=mapHi&amp;long=-71.127&amp;lat=42.297\" /> \
<area shape=\"rect\" coords=\"250,300,275,325\" href=\"map?method=mapHi&amp;long=-71.126&amp;lat=42.297\" /> \
<area shape=\"rect\" coords=\"275,300,300,325\" href=\"map?method=mapHi&amp;long=-71.125&amp;lat=42.297\" /> \
<area shape=\"rect\" coords=\"300,300,325,325\" href=\"map?method=mapHi&amp;long=-71.124&amp;lat=42.297\" /> \
<area shape=\"rect\" coords=\"325,300,350,325\" href=\"map?method=mapHi&amp;long=-71.123&amp;lat=42.297\" /> \
<area shape=\"rect\" coords=\"350,300,375,325\" href=\"map?method=mapHi&amp;long=-71.122&amp;lat=42.297\" /> \
<area shape=\"rect\" coords=\"375,300,400,325\" href=\"map?method=mapHi&amp;long=-71.121&amp;lat=42.297\" /> \
<area shape=\"rect\" coords=\"400,300,425,325\" href=\"map?method=mapHi&amp;long=-71.120&amp;lat=42.297\" /> \
<area shape=\"rect\" coords=\"425,300,450,325\" href=\"map?method=mapHi&amp;long=-71.119&amp;lat=42.297\" /> \
<area shape=\"rect\" coords=\"450,300,475,325\" href=\"map?method=mapHi&amp;long=-71.118&amp;lat=42.297\" /> \
<area shape=\"rect\" coords=\"475,300,500,325\" href=\"map?method=mapHi&amp;long=-71.117&amp;lat=42.297\" /> \
<area shape=\"rect\" coords=\"500,300,525,325\" href=\"map?method=mapHi&amp;long=-71.116&amp;lat=42.297\" /> \
<area shape=\"rect\" coords=\"0,325,25,350\" href=\"map?method=mapHi&amp;long=-71.136&amp;lat=42.296\" /> \
<area shape=\"rect\" coords=\"25,325,50,350\" href=\"map?method=mapHi&amp;long=-71.135&amp;lat=42.296\" /> \
<area shape=\"rect\" coords=\"50,325,75,350\" href=\"map?method=mapHi&amp;long=-71.134&amp;lat=42.296\" /> \
<area shape=\"rect\" coords=\"75,325,100,350\" href=\"map?method=mapHi&amp;long=-71.133&amp;lat=42.296\" /> \
<area shape=\"rect\" coords=\"100,325,125,350\" href=\"map?method=mapHi&amp;long=-71.132&amp;lat=42.296\" /> \
<area shape=\"rect\" coords=\"125,325,150,350\" href=\"map?method=mapHi&amp;long=-71.131&amp;lat=42.296\" /> \
<area shape=\"rect\" coords=\"150,325,175,350\" href=\"map?method=mapHi&amp;long=-71.130&amp;lat=42.296\" /> \
<area shape=\"rect\" coords=\"175,325,200,350\" href=\"map?method=mapHi&amp;long=-71.129&amp;lat=42.296\" /> \
<area shape=\"rect\" coords=\"200,325,225,350\" href=\"map?method=mapHi&amp;long=-71.128&amp;lat=42.296\" /> \
<area shape=\"rect\" coords=\"225,325,250,350\" href=\"map?method=mapHi&amp;long=-71.127&amp;lat=42.296\" /> \
<area shape=\"rect\" coords=\"250,325,275,350\" href=\"map?method=mapHi&amp;long=-71.126&amp;lat=42.296\" /> \
<area shape=\"rect\" coords=\"275,325,300,350\" href=\"map?method=mapHi&amp;long=-71.125&amp;lat=42.296\" /> \
<area shape=\"rect\" coords=\"300,325,325,350\" href=\"map?method=mapHi&amp;long=-71.124&amp;lat=42.296\" /> \
<area shape=\"rect\" coords=\"325,325,350,350\" href=\"map?method=mapHi&amp;long=-71.123&amp;lat=42.296\" /> \
<area shape=\"rect\" coords=\"350,325,375,350\" href=\"map?method=mapHi&amp;long=-71.122&amp;lat=42.296\" /> \
<area shape=\"rect\" coords=\"375,325,400,350\" href=\"map?method=mapHi&amp;long=-71.121&amp;lat=42.296\" /> \
<area shape=\"rect\" coords=\"400,325,425,350\" href=\"map?method=mapHi&amp;long=-71.120&amp;lat=42.296\" /> \
<area shape=\"rect\" coords=\"425,325,450,350\" href=\"map?method=mapHi&amp;long=-71.119&amp;lat=42.296\" /> \
<area shape=\"rect\" coords=\"450,325,475,350\" href=\"map?method=mapHi&amp;long=-71.118&amp;lat=42.296\" /> \
<area shape=\"rect\" coords=\"475,325,500,350\" href=\"map?method=mapHi&amp;long=-71.117&amp;lat=42.296\" /> \
<area shape=\"rect\" coords=\"500,325,525,350\" href=\"map?method=mapHi&amp;long=-71.116&amp;lat=42.296\" /> \
<area shape=\"rect\" coords=\"0,350,25,375\" href=\"map?method=mapHi&amp;long=-71.136&amp;lat=42.295\" /> \
<area shape=\"rect\" coords=\"25,350,50,375\" href=\"map?method=mapHi&amp;long=-71.135&amp;lat=42.295\" /> \
<area shape=\"rect\" coords=\"50,350,75,375\" href=\"map?method=mapHi&amp;long=-71.134&amp;lat=42.295\" /> \
<area shape=\"rect\" coords=\"75,350,100,375\" href=\"map?method=mapHi&amp;long=-71.133&amp;lat=42.295\" /> \
<area shape=\"rect\" coords=\"100,350,125,375\" href=\"map?method=mapHi&amp;long=-71.132&amp;lat=42.295\" /> \
<area shape=\"rect\" coords=\"125,350,150,375\" href=\"map?method=mapHi&amp;long=-71.131&amp;lat=42.295\" /> \
<area shape=\"rect\" coords=\"150,350,175,375\" href=\"map?method=mapHi&amp;long=-71.130&amp;lat=42.295\" /> \
<area shape=\"rect\" coords=\"175,350,200,375\" href=\"map?method=mapHi&amp;long=-71.129&amp;lat=42.295\" /> \
<area shape=\"rect\" coords=\"200,350,225,375\" href=\"map?method=mapHi&amp;long=-71.128&amp;lat=42.295\" /> \
<area shape=\"rect\" coords=\"225,350,250,375\" href=\"map?method=mapHi&amp;long=-71.127&amp;lat=42.295\" /> \
<area shape=\"rect\" coords=\"250,350,275,375\" href=\"map?method=mapHi&amp;long=-71.126&amp;lat=42.295\" /> \
<area shape=\"rect\" coords=\"275,350,300,375\" href=\"map?method=mapHi&amp;long=-71.125&amp;lat=42.295\" /> \
<area shape=\"rect\" coords=\"300,350,325,375\" href=\"map?method=mapHi&amp;long=-71.124&amp;lat=42.295\" /> \
<area shape=\"rect\" coords=\"325,350,350,375\" href=\"map?method=mapHi&amp;long=-71.123&amp;lat=42.295\" /> \
<area shape=\"rect\" coords=\"350,350,375,375\" href=\"map?method=mapHi&amp;long=-71.122&amp;lat=42.295\" /> \
<area shape=\"rect\" coords=\"375,350,400,375\" href=\"map?method=mapHi&amp;long=-71.121&amp;lat=42.295\" /> \
<area shape=\"rect\" coords=\"400,350,425,375\" href=\"map?method=mapHi&amp;long=-71.120&amp;lat=42.295\" /> \
<area shape=\"rect\" coords=\"425,350,450,375\" href=\"map?method=mapHi&amp;long=-71.119&amp;lat=42.295\" /> \
<area shape=\"rect\" coords=\"450,350,475,375\" href=\"map?method=mapHi&amp;long=-71.118&amp;lat=42.295\" /> \
<area shape=\"rect\" coords=\"475,350,500,375\" href=\"map?method=mapHi&amp;long=-71.117&amp;lat=42.295\" /> \
<area shape=\"rect\" coords=\"500,350,525,375\" href=\"map?method=mapHi&amp;long=-71.116&amp;lat=42.295\" /> \
<area shape=\"rect\" coords=\"0,375,25,400\" href=\"map?method=mapHi&amp;long=-71.136&amp;lat=42.294\" /> \
<area shape=\"rect\" coords=\"25,375,50,400\" href=\"map?method=mapHi&amp;long=-71.135&amp;lat=42.294\" /> \
<area shape=\"rect\" coords=\"50,375,75,400\" href=\"map?method=mapHi&amp;long=-71.134&amp;lat=42.294\" /> \
<area shape=\"rect\" coords=\"75,375,100,400\" href=\"map?method=mapHi&amp;long=-71.133&amp;lat=42.294\" /> \
<area shape=\"rect\" coords=\"100,375,125,400\" href=\"map?method=mapHi&amp;long=-71.132&amp;lat=42.294\" /> \
<area shape=\"rect\" coords=\"125,375,150,400\" href=\"map?method=mapHi&amp;long=-71.131&amp;lat=42.294\" /> \
<area shape=\"rect\" coords=\"150,375,175,400\" href=\"map?method=mapHi&amp;long=-71.130&amp;lat=42.294\" /> \
<area shape=\"rect\" coords=\"175,375,200,400\" href=\"map?method=mapHi&amp;long=-71.129&amp;lat=42.294\" /> \
<area shape=\"rect\" coords=\"200,375,225,400\" href=\"map?method=mapHi&amp;long=-71.128&amp;lat=42.294\" /> \
<area shape=\"rect\" coords=\"225,375,250,400\" href=\"map?method=mapHi&amp;long=-71.127&amp;lat=42.294\" /> \
<area shape=\"rect\" coords=\"250,375,275,400\" href=\"map?method=mapHi&amp;long=-71.126&amp;lat=42.294\" /> \
<area shape=\"rect\" coords=\"275,375,300,400\" href=\"map?method=mapHi&amp;long=-71.125&amp;lat=42.294\" /> \
<area shape=\"rect\" coords=\"300,375,325,400\" href=\"map?method=mapHi&amp;long=-71.124&amp;lat=42.294\" /> \
<area shape=\"rect\" coords=\"325,375,350,400\" href=\"map?method=mapHi&amp;long=-71.123&amp;lat=42.294\" /> \
<area shape=\"rect\" coords=\"350,375,375,400\" href=\"map?method=mapHi&amp;long=-71.122&amp;lat=42.294\" /> \
<area shape=\"rect\" coords=\"375,375,400,400\" href=\"map?method=mapHi&amp;long=-71.121&amp;lat=42.294\" /> \
<area shape=\"rect\" coords=\"400,375,425,400\" href=\"map?method=mapHi&amp;long=-71.120&amp;lat=42.294\" /> \
<area shape=\"rect\" coords=\"425,375,450,400\" href=\"map?method=mapHi&amp;long=-71.119&amp;lat=42.294\" /> \
<area shape=\"rect\" coords=\"450,375,475,400\" href=\"map?method=mapHi&amp;long=-71.118&amp;lat=42.294\" /> \
<area shape=\"rect\" coords=\"475,375,500,400\" href=\"map?method=mapHi&amp;long=-71.117&amp;lat=42.294\" /> \
<area shape=\"rect\" coords=\"500,375,525,400\" href=\"map?method=mapHi&amp;long=-71.116&amp;lat=42.294\" /> \
<area shape=\"rect\" coords=\"0,400,25,425\" href=\"map?method=mapHi&amp;long=-71.136&amp;lat=42.293\" /> \
<area shape=\"rect\" coords=\"25,400,50,425\" href=\"map?method=mapHi&amp;long=-71.135&amp;lat=42.293\" /> \
<area shape=\"rect\" coords=\"50,400,75,425\" href=\"map?method=mapHi&amp;long=-71.134&amp;lat=42.293\" /> \
<area shape=\"rect\" coords=\"75,400,100,425\" href=\"map?method=mapHi&amp;long=-71.133&amp;lat=42.293\" /> \
<area shape=\"rect\" coords=\"100,400,125,425\" href=\"map?method=mapHi&amp;long=-71.132&amp;lat=42.293\" /> \
<area shape=\"rect\" coords=\"125,400,150,425\" href=\"map?method=mapHi&amp;long=-71.131&amp;lat=42.293\" /> \
<area shape=\"rect\" coords=\"150,400,175,425\" href=\"map?method=mapHi&amp;long=-71.130&amp;lat=42.293\" /> \
<area shape=\"rect\" coords=\"175,400,200,425\" href=\"map?method=mapHi&amp;long=-71.129&amp;lat=42.293\" /> \
<area shape=\"rect\" coords=\"200,400,225,425\" href=\"map?method=mapHi&amp;long=-71.128&amp;lat=42.293\" /> \
<area shape=\"rect\" coords=\"225,400,250,425\" href=\"map?method=mapHi&amp;long=-71.127&amp;lat=42.293\" /> \
<area shape=\"rect\" coords=\"250,400,275,425\" href=\"map?method=mapHi&amp;long=-71.126&amp;lat=42.293\" /> \
<area shape=\"rect\" coords=\"275,400,300,425\" href=\"map?method=mapHi&amp;long=-71.125&amp;lat=42.293\" /> \
<area shape=\"rect\" coords=\"300,400,325,425\" href=\"map?method=mapHi&amp;long=-71.124&amp;lat=42.293\" /> \
<area shape=\"rect\" coords=\"325,400,350,425\" href=\"map?method=mapHi&amp;long=-71.123&amp;lat=42.293\" /> \
<area shape=\"rect\" coords=\"350,400,375,425\" href=\"map?method=mapHi&amp;long=-71.122&amp;lat=42.293\" /> \
<area shape=\"rect\" coords=\"375,400,400,425\" href=\"map?method=mapHi&amp;long=-71.121&amp;lat=42.293\" /> \
<area shape=\"rect\" coords=\"400,400,425,425\" href=\"map?method=mapHi&amp;long=-71.120&amp;lat=42.293\" /> \
<area shape=\"rect\" coords=\"425,400,450,425\" href=\"map?method=mapHi&amp;long=-71.119&amp;lat=42.293\" /> \
<area shape=\"rect\" coords=\"450,400,475,425\" href=\"map?method=mapHi&amp;long=-71.118&amp;lat=42.293\" /> \
<area shape=\"rect\" coords=\"475,400,500,425\" href=\"map?method=mapHi&amp;long=-71.117&amp;lat=42.293\" /> \
<area shape=\"rect\" coords=\"500,400,525,425\" href=\"map?method=mapHi&amp;long=-71.116&amp;lat=42.293\" /> \
<area shape=\"rect\" coords=\"0,425,25,450\" href=\"map?method=mapHi&amp;long=-71.136&amp;lat=42.292\" /> \
<area shape=\"rect\" coords=\"25,425,50,450\" href=\"map?method=mapHi&amp;long=-71.135&amp;lat=42.292\" /> \
<area shape=\"rect\" coords=\"50,425,75,450\" href=\"map?method=mapHi&amp;long=-71.134&amp;lat=42.292\" /> \
<area shape=\"rect\" coords=\"75,425,100,450\" href=\"map?method=mapHi&amp;long=-71.133&amp;lat=42.292\" /> \
<area shape=\"rect\" coords=\"100,425,125,450\" href=\"map?method=mapHi&amp;long=-71.132&amp;lat=42.292\" /> \
<area shape=\"rect\" coords=\"125,425,150,450\" href=\"map?method=mapHi&amp;long=-71.131&amp;lat=42.292\" /> \
<area shape=\"rect\" coords=\"150,425,175,450\" href=\"map?method=mapHi&amp;long=-71.130&amp;lat=42.292\" /> \
<area shape=\"rect\" coords=\"175,425,200,450\" href=\"map?method=mapHi&amp;long=-71.129&amp;lat=42.292\" /> \
<area shape=\"rect\" coords=\"200,425,225,450\" href=\"map?method=mapHi&amp;long=-71.128&amp;lat=42.292\" /> \
<area shape=\"rect\" coords=\"225,425,250,450\" href=\"map?method=mapHi&amp;long=-71.127&amp;lat=42.292\" /> \
<area shape=\"rect\" coords=\"250,425,275,450\" href=\"map?method=mapHi&amp;long=-71.126&amp;lat=42.292\" /> \
<area shape=\"rect\" coords=\"275,425,300,450\" href=\"map?method=mapHi&amp;long=-71.125&amp;lat=42.292\" /> \
<area shape=\"rect\" coords=\"300,425,325,450\" href=\"map?method=mapHi&amp;long=-71.124&amp;lat=42.292\" /> \
<area shape=\"rect\" coords=\"325,425,350,450\" href=\"map?method=mapHi&amp;long=-71.123&amp;lat=42.292\" /> \
<area shape=\"rect\" coords=\"350,425,375,450\" href=\"map?method=mapHi&amp;long=-71.122&amp;lat=42.292\" /> \
<area shape=\"rect\" coords=\"375,425,400,450\" href=\"map?method=mapHi&amp;long=-71.121&amp;lat=42.292\" /> \
<area shape=\"rect\" coords=\"400,425,425,450\" href=\"map?method=mapHi&amp;long=-71.120&amp;lat=42.292\" /> \
<area shape=\"rect\" coords=\"425,425,450,450\" href=\"map?method=mapHi&amp;long=-71.119&amp;lat=42.292\" /> \
<area shape=\"rect\" coords=\"450,425,475,450\" href=\"map?method=mapHi&amp;long=-71.118&amp;lat=42.292\" /> \
<area shape=\"rect\" coords=\"475,425,500,450\" href=\"map?method=mapHi&amp;long=-71.117&amp;lat=42.292\" /> \
<area shape=\"rect\" coords=\"500,425,525,450\" href=\"map?method=mapHi&amp;long=-71.116&amp;lat=42.292\" /> \
<area shape=\"rect\" coords=\"0,450,25,475\" href=\"map?method=mapHi&amp;long=-71.136&amp;lat=42.291\" /> \
<area shape=\"rect\" coords=\"25,450,50,475\" href=\"map?method=mapHi&amp;long=-71.135&amp;lat=42.291\" /> \
<area shape=\"rect\" coords=\"50,450,75,475\" href=\"map?method=mapHi&amp;long=-71.134&amp;lat=42.291\" /> \
<area shape=\"rect\" coords=\"75,450,100,475\" href=\"map?method=mapHi&amp;long=-71.133&amp;lat=42.291\" /> \
<area shape=\"rect\" coords=\"100,450,125,475\" href=\"map?method=mapHi&amp;long=-71.132&amp;lat=42.291\" /> \
<area shape=\"rect\" coords=\"125,450,150,475\" href=\"map?method=mapHi&amp;long=-71.131&amp;lat=42.291\" /> \
<area shape=\"rect\" coords=\"150,450,175,475\" href=\"map?method=mapHi&amp;long=-71.130&amp;lat=42.291\" /> \
<area shape=\"rect\" coords=\"175,450,200,475\" href=\"map?method=mapHi&amp;long=-71.129&amp;lat=42.291\" /> \
<area shape=\"rect\" coords=\"200,450,225,475\" href=\"map?method=mapHi&amp;long=-71.128&amp;lat=42.291\" /> \
<area shape=\"rect\" coords=\"225,450,250,475\" href=\"map?method=mapHi&amp;long=-71.127&amp;lat=42.291\" /> \
<area shape=\"rect\" coords=\"250,450,275,475\" href=\"map?method=mapHi&amp;long=-71.126&amp;lat=42.291\" /> \
<area shape=\"rect\" coords=\"275,450,300,475\" href=\"map?method=mapHi&amp;long=-71.125&amp;lat=42.291\" /> \
<area shape=\"rect\" coords=\"300,450,325,475\" href=\"map?method=mapHi&amp;long=-71.124&amp;lat=42.291\" /> \
<area shape=\"rect\" coords=\"325,450,350,475\" href=\"map?method=mapHi&amp;long=-71.123&amp;lat=42.291\" /> \
<area shape=\"rect\" coords=\"350,450,375,475\" href=\"map?method=mapHi&amp;long=-71.122&amp;lat=42.291\" /> \
<area shape=\"rect\" coords=\"375,450,400,475\" href=\"map?method=mapHi&amp;long=-71.121&amp;lat=42.291\" /> \
<area shape=\"rect\" coords=\"400,450,425,475\" href=\"map?method=mapHi&amp;long=-71.120&amp;lat=42.291\" /> \
<area shape=\"rect\" coords=\"425,450,450,475\" href=\"map?method=mapHi&amp;long=-71.119&amp;lat=42.291\" /> \
<area shape=\"rect\" coords=\"450,450,475,475\" href=\"map?method=mapHi&amp;long=-71.118&amp;lat=42.291\" /> \
<area shape=\"rect\" coords=\"475,450,500,475\" href=\"map?method=mapHi&amp;long=-71.117&amp;lat=42.291\" /> \
<area shape=\"rect\" coords=\"500,450,525,475\" href=\"map?method=mapHi&amp;long=-71.116&amp;lat=42.291\" /> \
<area shape=\"rect\" coords=\"0,475,25,500\" href=\"map?method=mapHi&amp;long=-71.136&amp;lat=42.290\" /> \
<area shape=\"rect\" coords=\"25,475,50,500\" href=\"map?method=mapHi&amp;long=-71.135&amp;lat=42.290\" /> \
<area shape=\"rect\" coords=\"50,475,75,500\" href=\"map?method=mapHi&amp;long=-71.134&amp;lat=42.290\" /> \
<area shape=\"rect\" coords=\"75,475,100,500\" href=\"map?method=mapHi&amp;long=-71.133&amp;lat=42.290\" /> \
<area shape=\"rect\" coords=\"100,475,125,500\" href=\"map?method=mapHi&amp;long=-71.132&amp;lat=42.290\" /> \
<area shape=\"rect\" coords=\"125,475,150,500\" href=\"map?method=mapHi&amp;long=-71.131&amp;lat=42.290\" /> \
<area shape=\"rect\" coords=\"150,475,175,500\" href=\"map?method=mapHi&amp;long=-71.130&amp;lat=42.290\" /> \
<area shape=\"rect\" coords=\"175,475,200,500\" href=\"map?method=mapHi&amp;long=-71.129&amp;lat=42.290\" /> \
<area shape=\"rect\" coords=\"200,475,225,500\" href=\"map?method=mapHi&amp;long=-71.128&amp;lat=42.290\" /> \
<area shape=\"rect\" coords=\"225,475,250,500\" href=\"map?method=mapHi&amp;long=-71.127&amp;lat=42.290\" /> \
<area shape=\"rect\" coords=\"250,475,275,500\" href=\"map?method=mapHi&amp;long=-71.126&amp;lat=42.290\" /> \
<area shape=\"rect\" coords=\"275,475,300,500\" href=\"map?method=mapHi&amp;long=-71.125&amp;lat=42.290\" /> \
<area shape=\"rect\" coords=\"300,475,325,500\" href=\"map?method=mapHi&amp;long=-71.124&amp;lat=42.290\" /> \
<area shape=\"rect\" coords=\"325,475,350,500\" href=\"map?method=mapHi&amp;long=-71.123&amp;lat=42.290\" /> \
<area shape=\"rect\" coords=\"350,475,375,500\" href=\"map?method=mapHi&amp;long=-71.122&amp;lat=42.290\" /> \
<area shape=\"rect\" coords=\"375,475,400,500\" href=\"map?method=mapHi&amp;long=-71.121&amp;lat=42.290\" /> \
<area shape=\"rect\" coords=\"400,475,425,500\" href=\"map?method=mapHi&amp;long=-71.120&amp;lat=42.290\" /> \
<area shape=\"rect\" coords=\"425,475,450,500\" href=\"map?method=mapHi&amp;long=-71.119&amp;lat=42.290\" /> \
<area shape=\"rect\" coords=\"450,475,475,500\" href=\"map?method=mapHi&amp;long=-71.118&amp;lat=42.290\" /> \
<area shape=\"rect\" coords=\"475,475,500,500\" href=\"map?method=mapHi&amp;long=-71.117&amp;lat=42.290\" /> \
<area shape=\"rect\" coords=\"500,475,525,500\" href=\"map?method=mapHi&amp;long=-71.116&amp;lat=42.290\" /> \
<area shape=\"rect\" coords=\"0,500,25,525\" href=\"map?method=mapHi&amp;long=-71.136&amp;lat=42.289\" /> \
<area shape=\"rect\" coords=\"25,500,50,525\" href=\"map?method=mapHi&amp;long=-71.135&amp;lat=42.289\" /> \
<area shape=\"rect\" coords=\"50,500,75,525\" href=\"map?method=mapHi&amp;long=-71.134&amp;lat=42.289\" /> \
<area shape=\"rect\" coords=\"75,500,100,525\" href=\"map?method=mapHi&amp;long=-71.133&amp;lat=42.289\" /> \
<area shape=\"rect\" coords=\"100,500,125,525\" href=\"map?method=mapHi&amp;long=-71.132&amp;lat=42.289\" /> \
<area shape=\"rect\" coords=\"125,500,150,525\" href=\"map?method=mapHi&amp;long=-71.131&amp;lat=42.289\" /> \
<area shape=\"rect\" coords=\"150,500,175,525\" href=\"map?method=mapHi&amp;long=-71.130&amp;lat=42.289\" /> \
<area shape=\"rect\" coords=\"175,500,200,525\" href=\"map?method=mapHi&amp;long=-71.129&amp;lat=42.289\" /> \
<area shape=\"rect\" coords=\"200,500,225,525\" href=\"map?method=mapHi&amp;long=-71.128&amp;lat=42.289\" /> \
<area shape=\"rect\" coords=\"225,500,250,525\" href=\"map?method=mapHi&amp;long=-71.127&amp;lat=42.289\" /> \
<area shape=\"rect\" coords=\"250,500,275,525\" href=\"map?method=mapHi&amp;long=-71.126&amp;lat=42.289\" /> \
<area shape=\"rect\" coords=\"275,500,300,525\" href=\"map?method=mapHi&amp;long=-71.125&amp;lat=42.289\" /> \
<area shape=\"rect\" coords=\"300,500,325,525\" href=\"map?method=mapHi&amp;long=-71.124&amp;lat=42.289\" /> \
<area shape=\"rect\" coords=\"325,500,350,525\" href=\"map?method=mapHi&amp;long=-71.123&amp;lat=42.289\" /> \
<area shape=\"rect\" coords=\"350,500,375,525\" href=\"map?method=mapHi&amp;long=-71.122&amp;lat=42.289\" /> \
<area shape=\"rect\" coords=\"375,500,400,525\" href=\"map?method=mapHi&amp;long=-71.121&amp;lat=42.289\" /> \
<area shape=\"rect\" coords=\"400,500,425,525\" href=\"map?method=mapHi&amp;long=-71.120&amp;lat=42.289\" /> \
<area shape=\"rect\" coords=\"425,500,450,525\" href=\"map?method=mapHi&amp;long=-71.119&amp;lat=42.289\" /> \
<area shape=\"rect\" coords=\"450,500,475,525\" href=\"map?method=mapHi&amp;long=-71.118&amp;lat=42.289\" /> \
<area shape=\"rect\" coords=\"475,500,500,525\" href=\"map?method=mapHi&amp;long=-71.117&amp;lat=42.289\" /> \
<area shape=\"rect\" coords=\"500,500,525,525\" href=\"map?method=mapHi&amp;long=-71.116&amp;lat=42.289\" /> \
<area shape=\"rect\" coords=\"0,525,25,550\" href=\"map?method=mapHi&amp;long=-71.136&amp;lat=42.288\" /> \
<area shape=\"rect\" coords=\"25,525,50,550\" href=\"map?method=mapHi&amp;long=-71.135&amp;lat=42.288\" /> \
<area shape=\"rect\" coords=\"50,525,75,550\" href=\"map?method=mapHi&amp;long=-71.134&amp;lat=42.288\" /> \
<area shape=\"rect\" coords=\"75,525,100,550\" href=\"map?method=mapHi&amp;long=-71.133&amp;lat=42.288\" /> \
<area shape=\"rect\" coords=\"100,525,125,550\" href=\"map?method=mapHi&amp;long=-71.132&amp;lat=42.288\" /> \
<area shape=\"rect\" coords=\"125,525,150,550\" href=\"map?method=mapHi&amp;long=-71.131&amp;lat=42.288\" /> \
<area shape=\"rect\" coords=\"150,525,175,550\" href=\"map?method=mapHi&amp;long=-71.130&amp;lat=42.288\" /> \
<area shape=\"rect\" coords=\"175,525,200,550\" href=\"map?method=mapHi&amp;long=-71.129&amp;lat=42.288\" /> \
<area shape=\"rect\" coords=\"200,525,225,550\" href=\"map?method=mapHi&amp;long=-71.128&amp;lat=42.288\" /> \
<area shape=\"rect\" coords=\"225,525,250,550\" href=\"map?method=mapHi&amp;long=-71.127&amp;lat=42.288\" /> \
<area shape=\"rect\" coords=\"250,525,275,550\" href=\"map?method=mapHi&amp;long=-71.126&amp;lat=42.288\" /> \
<area shape=\"rect\" coords=\"275,525,300,550\" href=\"map?method=mapHi&amp;long=-71.125&amp;lat=42.288\" /> \
<area shape=\"rect\" coords=\"300,525,325,550\" href=\"map?method=mapHi&amp;long=-71.124&amp;lat=42.288\" /> \
<area shape=\"rect\" coords=\"325,525,350,550\" href=\"map?method=mapHi&amp;long=-71.123&amp;lat=42.288\" /> \
<area shape=\"rect\" coords=\"350,525,375,550\" href=\"map?method=mapHi&amp;long=-71.122&amp;lat=42.288\" /> \
<area shape=\"rect\" coords=\"375,525,400,550\" href=\"map?method=mapHi&amp;long=-71.121&amp;lat=42.288\" /> \
<area shape=\"rect\" coords=\"400,525,425,550\" href=\"map?method=mapHi&amp;long=-71.120&amp;lat=42.288\" /> \
<area shape=\"rect\" coords=\"425,525,450,550\" href=\"map?method=mapHi&amp;long=-71.119&amp;lat=42.288\" /> \
<area shape=\"rect\" coords=\"450,525,475,550\" href=\"map?method=mapHi&amp;long=-71.118&amp;lat=42.288\" /> \
<area shape=\"rect\" coords=\"475,525,500,550\" href=\"map?method=mapHi&amp;long=-71.117&amp;lat=42.288\" /> \
<area shape=\"rect\" coords=\"500,525,525,550\" href=\"map?method=mapHi&amp;long=-71.116&amp;lat=42.288\" /> \
</map>" ;
}
