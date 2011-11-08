function search()
{

  htmlHeader("Search results", 420);

  	print "<h1>Search results</h1>";

	FS="|";
 while ((getline < "data/aa-tree.csv") > 0)
   {
       famN[$3]++ ; spN[$4]++ ; famOfSp[$4] = $3;
	 if (gensub(/\*/,"-","G",tolower($1)) == gensub(/\*/,"-","G",tolower(f["q"])))
	   {
		 print "<p>Tag match found: <a href=\"map?method=info&amp;tag=" $1 "\">" $1 "</a> (<a href=\"map?method=mapLo&amp;tag=" $1 "\">map</a>)</p>" ;
		 return ;
	   }

	 if ((f["long"] != "") && \
	     ($14 <= f["long"]) && ($14 < (f["long"]+0.001)) &&	\
	     ($13 >= f["lat"]) && ($13 < (f["lat"]+0.001)))
	 {
	   famspN[substr($3,1,5) "|" $4]++; Lsp = 1;
	 }
   }

 print "<table width=\"400\" cellpadding=\"3\">";
 print "<tr><td><i>Fam</i></td><td><i>Taxon</i></td><td><i>N</i></td></tr>";

 # Hi res species search from mapHi
 if (Lsp)
   {
	 for (i in famspN) famspI[++j] = i ;
	 nsp = asort(famspI);

	 for (i = 1; i <= nsp; i++)
	   {
		 split (famspI[i],famspTmp,"|");
		 print "<tr><td>" famspTmp[1] "</td><td><a href=\"map?method=mapHi&amp;long=" f["long"] "&amp;lat=" f["lat"] "&amp;sp=" famspTmp[2] "\">" famspTmp[2] "</a></td><td>" famspN[famspI[i]] "</td></tr>";

     }
     print "</table>";
	 print "<p align=\"right\">[ <a href=\"map\">home</a> ]</p>" ;
	 return ;
 }

 if (length(f["q"]) < 4) error("Please use more that 3 search characters.");

 results = 0;
 # fam match
 # sort fams
 for (i in famN) famName[j++] = i ; nfam = asort(famName) ;

 for (i = 1; i <= nfam; i++)
   {
	 if (tolower(famName[i]) ~ tolower(f["q"]))
	   {
		 print "<tr><td><a href=\"map?method=mapLo&amp;fam=" famName[i] "\">" famName[i] "</a></td><td>&#160;</td><td>" famN[famName[i]] "</td></tr>";
		 results++;
	   }
   }

 # sp match
 # sort sp
 for (i in spN) spName[j++] = i ; nsp = asort(spName) ;

 for (i = 1; i <= nsp; i++)
   {
	 if ((tolower(spName[i]) ~ tolower(f["q"])) && (results <= 50))
	   {
		 print "<tr><td>" famOfSp[spName[i]] "</td><td><a href=\"map?method=mapLo&amp;sp=" spName[i] "\">" spName[i] "</a></td><td>" spN[spName[i]] "</td></tr>";
		 results++;
	   }
   }

 print "</table>";

 return ;
}

