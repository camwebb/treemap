function obsForm()
{

  htmlHeader("Make an observation", 400);

  print "<h1>Make an observation</h1>";
  print "<p>for tree with tag <b>" f["tag"] "</b><br/> <b>(Please double check the tag code)</b></p>";
  print "<form enctype=\"multipart/form-data\" method=\"post\" action=\"map?method=obsD\">" ;
  print "<p><input type=\"hidden\" name=\"tag\" value=\"" f["tag"] "\" /><b>Type</b> of observation:<br /><select name=\"type\"><option value=\"bud\">Spring buds just breaking open</option><option value=\"flower\">In flower (any stage)</option><option value=\"fruit\">In fruit (any stage)</option><option value=\"fall\">Outstanding fall color</option><option value=\"fobs\">Feeding obs. (note animal and plant part)</option></select></p>";
  # <option value=\"damage\">Report plant damage</option></select></p>";
  print "<p>Upload a <b>photo</b> (optional)<br/><span style=\"font-size:12px;\"><i>(small please: &lt;2 MB; NB: iPhone does not support file uploads)</i></span><br/><input type=\"file\" name=\"photo\" /></p>";
  print "<p>Your <b>notes</b> (optional):<br/><textarea name=\"notes\" cols=\"30\" rows=\"2\"></textarea></p>";
  print "<p>Your <b>email</b> (optional)<br/><input type=\"text\" name=\"email\" size=\"30\"/></p>";
  
  print "<p><input type=\"submit\" value=\"Send observation\" /></p>";
  print "</form>";

  htmlFooter();

}

function obsCapture()
{

# Script to parse return from observation form

# Form template:

# -----------------------------1928954284948244595549659756
# Content-Disposition: form-data; name="type"
# 
# fall
# -----------------------------1928954284948244595549659756
# Content-Disposition: form-data; name="notes"
# 
# Notes
# -----------------------------1928954284948244595549659756
# Content-Disposition: form-data; name="photo"; filename="img.png"
# Content-Type: image/png
# 
# <image>
# -----------------------------1928954284948244595549659756--

  htmlHeader("Data stored",400);

  # View form data during testing with:
  #  RS = "\x04"; getline; print "<pre>" $0;
  #  print $0 > "tmp";
  #  print "</pre></body></html>"; exit;

  RS = "\r\n"; getline;
  # Use the first line as the multipart form delimiter
  # escape regexp chars (prob just `-'):
  gsub(/\-/,"\\-",$0); gsub(/\*/,"\\*",$0);
  gsub(/\./,"\\.",$0); gsub(/\?/,"\\?",$0);
  RS = $0 "[^\r]*" "\r?\n" ; 
  recdate = strftime("%Y-%m-%d"); rectime= strftime("%H%M%S") ;
  # had to add the extra regex return because webkit and mozilla use a 
  #   different last delimiter ( ----XYZ-- )
  while (getline > 0)
  	{
	  # print "<pre>" $0 "</pre>";
	  # split the dataparts
	  lines = split($0, line, "\r\n");
	  # if the media:
	  if ((line[2] ~ /Content\-Type/) && \
	      ("png|jpeg|jpg" ~ gensub(/[^/]*\/([a-z]+)/,"\\1","G",line[2])))
		{
		  ORS = "";
		  split (line[1], lineTmp2, ";");
		  filename = gensub(/ filename="([^"]*)"$/,"\\1","G",lineTmp2[3]);
		  mediatype = gensub(/[^/]*\/([a-z]+)/,"\\1","G",line[2]);
		  outfile = recdate "T" rectime "_" tag "." mediatype ;
		  # likely all to be in line 4, but there may be a \r\n in the 
		  #  file, so better to concatenate lines
		  for (x = 4 ; x < lines ; x++)
			{
			  # could add a rand component: srand(); substr(rand(),3,5)
			  # but chance of two uploads in same second very tiny
			  print line[x] "\r\n" >> "obsdata/" outfile;
			}
		  ORS = "\n";
		}
	  else if (line[1] ~ /Content\-Disposition/)
		{
		  split (line[1], lineTmp, ";");
		  name = gensub(/\ name="([^"]*)"$/,"\\1","G",lineTmp[2]);
		  if (name == "tag")  { tag = line[3] }
		  if (name == "type") { obstype = line[3] }
		  if (name == "email") { email = line[3] }
		  if (name == "notes")
			{
			  for (x = 3 ; x < lines ; x++)
				{
				  notes = notes line[x] "\\n" ;
				}
			}
		}
	}

  gsub(/|/,"",notes) ; gsub(/|/,"",filename); # just in case

  # WRITE TO FILE
  print "<date>" recdate \
	"</date><time>" rectime \
	"</time><tag>" tag \
	"</tag><obstype>" obstype \
	"</obstype><notes>" notes \
	"</notes><email>" email \
	"</email><oriname>"	filename \
	"</oriname><outfile>" outfile \
	"</outfile>" >> "obsdata/data.csv" ;

  # OUTPUT

  print "<h1>Data stored</h1>" ;
  print "<p>Thanks for your observation on plant <a href=\"map?method=info&amp;tag=" tag "\">" tag "</a></p>";
  print "<p align=\"right\">[ <a href=\"map\">home</a> ]</p>";

  # make thumb
  if (outfile != "")
  {
      system("convert 'obsdata/" outfile "' -resize 50x50 'obsdata/sm_" outfile "'");
  }

}

function obsReport()
{

  htmlHeader("Observations report", 420);

  stages["bud"] = "budding out";
  stages["flower"] = "in flower";
  stages["fruit"] = "in fruit";
  stages["fall"] = "Fall color";
  stages["fobs"] = "Feeding obs";
  
  FS="|";

  while ((getline < "data/aa-tree.csv") > 0)
  {
	sp[$1] = $4 ;
  }

  while ((getline < "obsdata/data.csv") > 0)
	{
	  parseXML(++n,$0);
	  if (XML[n,"tag"] == f["tag"]) 
		{
		  XML[n, "match"] = 1; tagDataFound = 1;
		}
	}

  if ((f["tag"] != "") && (tagDataFound != 1))
	{
	  print "<p>Sorry, no citizen science records for this plant.<br/>  Why not <a href=\"map?method=obs&amp;tag=" f["tag"] "\">make one?</a></p>" ;
	}
  else if (tagDataFound)
	{
	  print "<h1>Observations for " f["tag"] "</h1>" ;
	  print "<table cellpadding=\"5\" width=\"400\">";
	  print "<tr><td><i>Tag</i></td><td><i>Taxon</i></td><td><i>Info</i></td><td><i>Date</i></td><td><i>Notes</i></td><td><i>Photo</i></td></tr>";
	  for (i = 1; i <= n ; i++)
	  {
	      if (XML[i,"tag"] == f["tag"])
	      {
		  print "<tr><td><a href=\"map?method=mapLo&amp;tag=" XML[i,"tag"] "\">" XML[i,"tag"] "</td>" ;
		  print "<td><a href=\"map?method=mapLo&amp;sp=" sp[XML[i,"tag"]] "\">" sp[XML[i,"tag"]] "</td>" ;

			print "<td>" stages[XML[i,"obstype"]] "</td>" ;
			print "<td>" XML[i,"date"] "</td>" ;
			print "<td>" gensub(/\\n/,"\\&#160;", "G", XML[i,"notes"]) "</td>" ;
			if (XML[i,"outfile"] != "")
			{
			    print "<td><a href=\"obsdata/" XML[i,"outfile"] "\"><img src=\"obsdata/sm_" XML[i,"outfile"] "\" /></a></td></tr>" ;
			}
			else print "<td>&#160;</td></tr>" ;
		    }
		}
	  print "</table>";
	}
  else
	{
	    print "<h1>Recent observations</h1>" ;
	  print "<table cellpadding=\"5\" width=\"400\">";
	  print "<tr><td><i>Tag</i></td><td><i>Taxon</i></td><td><i>Info</i></td><td><i>Date</i></td><td><i>Notes</i></td><td><i>Photo</i></td></tr>";
	  if (n > 10) start = n-10 ;
	  else start = 1;
	  for (i = start; i <= n ; i++)
		{
		  print "<tr><td><a href=\"map?method=mapLo&amp;tag=" XML[i,"tag"] "\">" XML[i,"tag"] "</td>" ;
		  print "<td><a href=\"map?method=mapLo&amp;sp=" sp[XML[i,"tag"]] "\">" sp[XML[i,"tag"]] "</td>" ;

		  print "<td>" stages[XML[i,"obstype"]] "</td>" ;
		  print "<td>" XML[i,"date"] "</td>" ;
		  print "<td>" gensub(/\\n/,"\\&#160;", "G", XML[i,"notes"]) "</td>" ;
		  if (XML[i,"outfile"] != "")
			{
			  print "<td><a href=\"obsdata/" XML[i,"outfile"] "\"><img src=\"obsdata/sm_" XML[i,"outfile"] "\" /></a></td></tr>" ;
			}
		  else print "<td>&#160;</td></tr>" ;
		}
	  print "</table>";
	}

}
  
function parseXML(indx, string,    i) 
{
  # parse simple XML
  i = 1;
  while (i <= length(string))
	{
	  # skip leading blanks and check in case there are no `<' in line
	  while ((substr(string,i,1) != "<") && (i <= length(string))) i++ ;
	  tag = ""; i++;
	  # read tag name
	  while ((substr(string,i,1) != ">") && (i <= length(string))) 
		{
		  tag = tag substr(string,i,1) ; i++;
		}
	  # clean tag name of blanks
	  gsub(/\ /,"",tag);  data = ""; i++;
	  # read data, terminated by `</'
	  while ((substr(string,i,2) != "</") && (i <= length(string)))
		{
		  data = data substr(string,i,1) ; i++;
		}
	  # record
	  XML[indx, tag] = data ; i++;
	  # print tag, data;
	  # move to next tag, or finish
	  while ((substr(string,i+1,1) != "<") && (i <= length(string))) i++; 
	}
}