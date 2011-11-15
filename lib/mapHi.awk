function mapHi()
{
  htmlHeader("Arnold Arboretum trees", 620);

  # load the color map
  loadColors();

  # print the imagemap
  print "<map name=\"trees\">" ;

  FS="|";
  while ((getline < "data/aa-tree.csv") > 0)
	{
	  if (($14 <= f["long"]) && ($14 < (f["long"]+0.001)) &&	\
		  ($13 >= f["lat"]) && ($13 < (f["lat"]+0.001))) 
		{
		  # print "long: " $14 "; lat: " $13 ;
		  print $14 " " $13 >> "run/" ps "." $3 ".dat";
		  print "<area shape=\"circle\" coords=\"" int(($14-f["long"])*500000) "," int((f["lat"]+0.001 - $13)*500000) ",7\" href=\"map?method=info&amp;tag=" $1 "\" title=\"" $4 " (" $3 ") : " $1 "\"/>";
		  
		  hasFam[$3]++;
		  
		  # Hightlight
		  if ($1 == f["tag"])
			{
			  print $14 " " $13 > "run/" ps ".Q.dat";
			  hasQ = 1;
			}
		  else if (($3 == f["fam"]) || ($4 == f["sp"])) 
			{
			  print $14 " " $13 >> "run/" ps ".Q.dat";
			  hasQ = 1;
			}
		}
	}
  
  print "</map>";

  gpHeaderMapHi() ;

  for (i in hasFam)
	{
	  if (color[i] == "") error("color not found for fam " i);
	  print "plot \"run/" ps "." i ".dat\" with points pointtype 7 pointsize 2 lt rgb \"" color[i] "\"" >> "run/" ps ".plt" ;
	}
  
  if (hasQ) print "plot \"run/" ps ".Q.dat\" with points pointtype 4 pointsize 4 linewidth 2 lt rgb \"yellow\"" >> "run/" ps ".plt" ;
  
  # Run gnuplot
  system("gnuplot run/" ps ".plt >& /dev/null");
  
  cmd = "composite run/" ps ".png data/" (-1000 * (f["long"]+71)) "_" (1000*(f["lat"] - 42)) ".png run/" ps "f.png" ;
  system(cmd);
  system("convert run/" ps "f.png run/" ps ".jpg");

  displayMapHi();

}

function gpHeaderMapHi() {
  print "set terminal png transparent size 500,500\nset size square\nset xrange [" f["long"] ":" f["long"]+0.001 "]\nset yrange [" f["lat"] ":" f["lat"]+0.001 "]\nset border 0\nunset xtics\nunset ytics\nunset key\nset bmargin 0\nset tmargin 0\nset lmargin 0\nset rmargin 0\n\nset output \"run/" ps ".png\"\nset multiplot\n" > "run/" ps ".plt" ;
}

function displayMapHi() {
  # print "</pre>";
  print "<table cellpadding=\"5\">";
  print "<tr><td>&#160;</td><td align=\"center\"><a href=\"map?method=mapHi&amp;long=" f["long"] "&amp;lat=" f["lat"]+0.001 "\"><img src=\"img/U.png\" /></a></td><td>&#160;</td></tr>";
  print "<tr><td><a href=\"map?method=mapHi&amp;long=" f["long"] - 0.001 "&amp;lat=" f["lat"] "\"><img src=\"img/L.png\" /></a></td><td>" ;
  # print "<img src=\"run/" ps  ".jpg\" usemap=\"#trees\" />";
  print "<div id=\"base\"> \
           <img src=\"run/" ps ".jpg\" border=\"0\" alt=\"\" /> \
           <div id=\"mid\">											   \
             <canvas id=\"gps\" width=\"500\" height=\"500\"></canvas> \
           </div>													   \
           <div id=\"top\">												\
             <img src=\"img/blank.png\" width=\"500\" height=\"500\" usemap=\"#trees\" border=\"0\" alt=\"\" /> \
           </div> \
         </div> " ;
  print "</td><td><a href=\"map?method=mapHi&amp;long=" f["long"] + 0.001 "&amp;lat=" f["lat"] "\"><img src=\"img/R.png\" /></a></td></tr>" ;
  print "<tr><td>&#160;</td><td align=\"center\"><a href=\"map?method=mapHi&amp;long=" f["long"] "&amp;lat=" f["lat"]-0.001 "\"><img src=\"img/D.png\" /></a></td><td>&#160;</td></tr>";
  print "<tr><td colspan=\"3\" align=\"right\">[ <a href=\"map?method=search&amp;long=" f["long"] "&amp;lat=" f["lat"] "\">list taxa</a> | <a href=\"map\">zoom out</a> ]</td></tr>";
  print "</table>";

}

