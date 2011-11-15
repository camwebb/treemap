function loadColors()
{
  # now using X11 colors
  
  # read colornames
  FS="|";
  while ((getline < "tools/x11_colors") > 0)
	{
	  colorcode[$2] = $1;
	}

  # READ phylo 
  while ((getline < "phylo/phylo.csv") > 0)
	{
	  if ($4 != "")
		{
		  # load color code onto synonomize family name
		  color[$4] = toupper(colorcode[$5]) ;
		  # default
		  if (color[$4] == "") color[$4] = "#000000"; 
		  # print "<pre>"synfam[$4] " " color[$4] "</pre>";
		}
	}
  color["UNKNOWN"] = "#000000";

  # synomyms
  while ((getline < "phylo/synonyms.csv") > 0)
	{
	  color[$1] = color[$2];
 	}

}

function colorkey(          i, j, c, n, famorder, nfamorder, syn)
{
  
  loadColors();

  # APG3 fam order
  FS="|";
  while ((getline < "tools/apg3_linear") > 0)
	{
	  ++nfamorder;
	  famorder[$2] = toupper($1);
 	}

  # synomyms
  while ((getline < "phylo/synonyms.csv") > 0)
	{
	  if (syn[$2] = "") syn[$2] = toupper(substr($1,1,1))	\
						  tolower(substr($1,2));
	  else syn[$2] = syn[$2] ", " toupper(substr($1,1,1))	\
			              tolower(substr($1,2));
 	}

  htmlHeader("Family colors", 400) ;
  print "<h1>Family colors</h1>";
  print "<table cellpadding=\"5\">";

  # note, counter must start negative for gymnosperms
  for (i = -20; i <= nfamorder; i++)
	{
	  if (color[famorder[i]] != "")
		{
		  famname = substr(famorder[i],1,1) tolower(substr(famorder[i],2));
		  if (syn[famorder[i]] != "") famname = famname "(" \
										syn[famorder[i]] ")" ;
		  print "<tr><td>" famname "</td><td style=\"background-color: " \
			color[famorder[i]] ";\">&#160;&#160;&#160;&#160;</td></tr>" ;
		}
	}

  print "</table>" ;

  htmlFooter();

}
