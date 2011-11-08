function treeInfo()
{

  htmlHeader("Plant information", 600) ;

  apfam_load() ;

  FS="|";
  while ((getline < "data/aa-tree.csv") > 0)
	{
	  if ($1 == f["tag"])
		{
		  print "<h1>" $4 "</h1>";
		  print "<ul>" ;
		  if (apfam[$3] == "") print "<li>Family : " substr($3,1,1) tolower(substr($3,2)) "</li>" ;
		  else print "<li>Family : <a href=\"http://www.mobot.org/MOBOT/Research/APweb/orders/" apfam[$3] "\">" substr($3,1,1) tolower(substr($3,2)) "</a></li>" ;
		  if ($6 != "") print "<li>Common name : " $6 "</li>" ;
		  if ($10 != "") print "<li>Section : " $10 "</li>" ;
		  if ($11 != "") print "<li>Collection : " $11 "</li>" ;
		  if ($8 > 0) print "<li>Diameter : " int($8) " " $9 "</li>" ;
		  print "<li>Grid : " $12 "</li>" ;
		  print "<li>Tag : " $1 "</li>" ;
		  split($4,nam," ");
		  print "<li><a href=\"map?method=obsS&amp;tag=" $1 "\">Observations of this plant</a></li>" ;
		  print "<li><a href=\"http://google.com/m?q=" nam[1] "+" nam[2] "&site=images\">Images of this taxon</a></li>";
		  print "<li><a href=\"http://en.m.wikipedia.org/wiki/" nam[1] "_" nam[2] "\">More info...</a></li>"; 

		  print "</ul>";
		  print "<p>[ <a href=\"map?method=obs&amp;tag=" $1 "\">observe</a> | <a href=\"map?method=mapLo&amp;tag=" $1 "\">map it</a> | <a href=\"http://google.com/m?site=maps&q=" $13 "," $14 " (" $1 ", " $4 ")\">directions</a> | <a href=\"map\">home</a> ]</p>" ;

		  break;
		}
	}
}

function apfam_load ()
{
  fams = "lamialesweb.htm#Acanthaceae|Acanthaceae malpighialesweb.htm#Achariaceae|Achariaceae caryophyllalesweb.htm#Achatocarpaceae|Achatocarpaceae acoralesweb.htm#Acoraceae|Acoraceae ericalesweb.htm#Actinidiaceae|Actinidiaceae dipsacalesweb.htm#Adoxaceae|Adoxaceae berberidopsidalesweb.html#Aextoxicaceae|Aextoxicaceae caryophyllalesweb.htm#Aizoaceae|Aizoaceae brassicalesweb.htm#Akaniaceae|Akaniaceae alismatalesweb.htm#Alismataceae|Alismataceae asteralesweb.htm#Alseuosmiaceae|Alseuosmiaceae lilialesweb.htm#Alstroemeriaceae|Alstroemeriaceae saxifragalesweb.htm#Altingiaceae|Altingiaceae myrtalesweb2.htm#Alzateaceae|Alzateaceae caryophyllalesweb.htm#Amaranthaceae|Amaranthaceae asparagalesweb.htm#Amaryllidaceae|Amaryllidaceae amborellalesweb2.htm#Amborellaceae|Amborellaceae  caryophyllalesweb.htm#Anacampseros|Anacampserotaceae sapindalesweb.htm#Anacardiaceae|Anacardiaceae poalesweb.htm#Anarthriaceae|Anarthriaceae caryophyllalesweb.htm#Ancistrocladaceae|Ancistrocladaceae cucurbitalesweb.htm#Anisophylleaceae|Anisophylleaceae magnolialesweb.htm#Annonaceae|Annonaceae saxifragalesweb.htm#Aphanopetalaceae|Aphanopetalaceae crossosomatalesweb.htm#Aphloiaceae|Aphloiaceae apialesweb.htm#Apiaceae|Apiaceae gentianalesweb.htm#Apocynaceae|Apocynaceae cucurbitalesweb.htm#Apodanthaceae|Apodanthaceae alismatalesweb.htm#Aponogetonaceae|Aponogetonaceae santalalesweb2.htm#Aptandraceae|Aptandraceae aquifolialesweb2.htm#Aquifoliaceae|Aquifoliaceae alismatalesweb.htm#Araceae|Araceae apialesweb.htm#Araliaceae|Araliaceae conifers.html#Araucariaceae|Araucariaceae arecalesweb.htm#Arecaceae|Arecaceae asteralesweb.htm#Argophyllaceae|Argophyllaceae piperalesweb2.htm#Aristolochiaceae|Aristolochiaceae asparagalesweb.htm#Asparagaceae|Asparagaceae asparagalesweb.htm#Asteliaceae|Asteliaceae asteralesweb.htm#Asteraceae|Asteraceae caryophyllalesweb.htm#Asteropeiaceae|Asteropeiaceae lauralesweb.htm#Atherospermataceae|Atherospermataceae austrobaileyalesweb.htm#Austrobaileyaceae|Austrobaileyaceae santalalesweb2.htm#Balanophoraceae|Balanophoraceae ericalesweb.htm#Balsaminaceae|Balsaminaceae caryophyllalesweb.htm#Barbeuiaceae|Barbeuiaceae rosalesweb.htm#Barbeyaceae|Barbeyaceae caryophyllalesweb.htm#Basellaceae|Basellaceae brassicalesweb.htm#Bataceae|Bataceae cucurbitalesweb.htm#Begoniaceae|Begoniaceae ranunculalesweb.htm#Berberidaceae|Berberidaceae berberidopsidalesweb.html#Berberidopsidaceae|Berberidopsidaceae fagalesweb.htm#Betulaceae|Betulaceae sapindalesweb.htm#Biebersteiniaceae|Biebersteiniaceae lamialesweb.htm#Bignoniaceae|Bignoniaceae malvalesweb.htm#CocBixDie|Bixaceae asparagalesweb.htm#Blandfordiaceae|Blandfordiaceae malpighialesweb.htm#Bonnetiaceae|Bonnetiaceae gentianalesweb.htm#Boraginaceae|Boraginaceae asparagalesweb.htm#Boryaceae|Boryaceae brassicalesweb.htm#Brassicoideae|Brassicaceae poalesweb.htm#Bromeliaceae|Bromeliaceae oxalidalesweb.htm#Brunelliaceae|Brunelliaceae brunialesweb.htm#Bruniaceae|Bruniaceae dioscorealesweb.htm#Burmanniaceae|Burmanniaceae sapindalesweb.htm#Burseraceae|Burseraceae alismatalesweb.htm#Butomaceae|Butomaceae buxalesweb.htm#Buxaceae|Buxaceae lamialesweb.htm#Byblidaceae|Byblidaceae caryophyllalesweb.htm#Cactaceae|Cactaceae lamialesweb.htm#Calceolariaceae|Calceolariaceae malpighialesweb.htm#Calophyllaceae|Calophyllaceae lauralesweb.htm#Calycanthaceae|Calycanthaceae asteralesweb.htm#Calyceraceae|Calyceraceae asteralesweb.htm#Campanulaceae|Campanulaceae lilialesweb.htm#Campynemataceae|Campynemataceae canellalesweb.htm#Canellaceae|Canellaceae rosalesweb.htm#Cannabaceae|Cannabaceae zingiberalesweb.htm#Cannaceae|Cannaceae brassicalesweb.htm#Capparoideae|Capparaceae dipsacalesweb.htm#Caprifoliaceae|Caprifoliaceae aquifolialesweb2.htm#Cardiopteridaceae|Cardiopteridaceae brassicalesweb.htm#Caricaceae|Caricaceae lamialesweb.htm#Carlemanniaceae|Carlemanniaceae malpighialesweb.htm#Caryocaraceae|Caryocaraceae caryophyllalesweb.htm#Caryophyllaceae|Caryophyllaceae fagalesweb.htm#Casuarinaceae|Casuarinaceae celastralesweb.html#Celastraceae|Celastraceae poalesweb.htm#Centrolepidaceae|Centrolepidaceae malpighialesweb.htm#Centroplacaceae|Centroplacaceae oxalidalesweb.htm#Cephalotaceae|Cephalotaceae ceratophyllalesweb.htm#Ceratophyllaceae|Ceratophyllaceae saxifragalesweb.htm#Cercidiphyllaceae|Cercidiphyllaceae chloranthalesweb.htm#Chloranthaceae|Chloranthaceae malpighialesweb.htm#Chrysobalanaceae|Chrysobalanaceae ranunculalesweb.htm#Circaeasteraceae|Circaeasteraceae malvalesweb.htm#Cistaceae|Cistaceae brassicalesweb.htm#Cleomoideae|Cleomaceae ericalesweb.htm#Clethraceae|Clethraceae malpighialesweb.htm#Clusiaceae|Clusiaceae lilialesweb.htm#Colchicaceae|Colchicaceae brunialesweb.htm#Columelliaceae|Columelliaceae myrtalesweb2.htm#Combretaceae|Combretaceae commelinalesweb.htm#Commelinaceae|Commelinaceae oxalidalesweb.htm#Connaraceae|Connaraceae solanalesweb.htm#Convolvulaceae|Convolvulaceae cucurbitalesweb.htm#Coriariaceae|Coriariaceae cornalesweb.htm#Cornaceae|Cornaceae lilialesweb.htm#Corsiaceae|Corsiaceae cucurbitalesweb.htm#Corynocarpaceae|Corynocarpaceae zingiberalesweb.htm#Costaceae|Costaceae santalalesweb2.htm#Coulaceae|Coulaceae saxifragalesweb.htm#Crassulaceae|Crassulaceae crossosomatalesweb.htm#Crossosomataceae|Crossosomataceae myrtalesweb2.htm#Crypteroniaceae|Crypteroniaceae malpighialesweb.htm#Ctenolophonaceae|Ctenolophonaceae cucurbitalesweb.htm#Cucurbitaceae|Cucurbitaceae oxalidalesweb.htm#Cunoniaceae|Cunoniaceae conifers.html#Cupressaceae|Cupressaceae cornalesweb.htm#Curtisiaceae|Curtisiaceae Cycadales.html#Cycadaceae|Cycadaceae pandanalesweb.htm#Cyclanthaceae|Cyclanthaceae alismatalesweb.htm#Cymodoceaceae|Cymodoceaceae saxifragalesweb.htm#Cynomoriaceae|Cynomoriaceae poalesweb.htm#Cyperaceae|Cyperaceae ericalesweb.htm#Cyrillaceae|Cyrillaceae malvalesweb.htm#Cytinaceae|Cytinaceae saxifragalesweb.htm#Daphniphyllaceae|Daphniphyllaceae arecalesweb.htm#Dasypogonaceae|Dasypogonaceae  cucurbitalesweb.htm#Datiscaceae|Datiscaceae magnolialesweb.htm#Degeneriaceae|Degeneriaceae ericalesweb.htm#Diapensiaceae|Diapensiaceae malpighialesweb.htm#Dichapetalaceae|Dichapetalaceae caryophyllalesweb.htm#Didiereaceae|Didiereaceae buxalesweb.htm#Didymelaceae|Didymelaceae dipsacalesweb.htm#Diervillaceae|Diervillaceae dillenialesweb.html#Dilleniaceae|Dilleniaceae caryophyllalesweb.htm#Dioncophyllaceae|Dioncophyllaceae dioscorealesweb.htm#Dioscoreaceae|Dioscoreaceae huertealesweb.htm#Dipentodontaceae|Dipentodontaceae dipsacalesweb.htm#Dipsacaceae|Dipsacaceae malvalesweb.htm#Dipterocarpaceae|Dipterocarpaceae rosalesweb.htm#Dirachmaceae|Dirachmaceae asparagalesweb.htm#Doryanthaceae|Doryanthaceae caryophyllalesweb.htm#Droseraceae|Droseraceae caryophyllalesweb.htm#Drosophyllaceae|Drosophyllaceae poalesweb.htm#Ecdeiocoleaceae|Ecdeiocoleaceae rosalesweb.htm#Elaeagnaceae|Elaeagnaceae oxalidalesweb.htm#Elaeocarpaceae|Elaeocarpaceae malpighialesweb.htm#Elatinaceae|Elatinaceae brassicalesweb.htm#Emblingiaceae|Emblingiaceae gnetales.html#Ephedraceae|Ephedraceae ericalesweb.htm#Ericaceae|Ericaceae poalesweb.htm#Eriocaulaceae|Eriocaulaceae santalalesweb2.htm#Erythropalaceae|Erythropalaceae malpighialesweb.htm#Erythroxylaceae|Erythroxylaceae Escalloniales.html#Escalloniaceae|Escalloniaceae garryalesweb.htm#Eucommiaceae|Eucommiaceae malpighialesweb.htm#Euphorbiaceae|Euphorbiaceae malpighialesweb.htm#Euphroniaceae|Euphroniaceae magnolialesweb.htm#Eupomatiaceae|Eupomatiaceae ranunculalesweb.htm#Eupteleaceae|Eupteleaceae fagalesweb.htm#Fagaceae|Fagaceae poalesweb.htm#Flagellariaceae|Flagellariaceae ericalesweb.htm#Fouquieriaceae|Fouquieriaceae geranialesweb.htm#Francoaceae|Francoaceae caryophyllalesweb.htm#Frankeniaceae|Frankeniaceae garryalesweb.htm#Garryaceae|Garryaceae crossosomatalesweb.htm#Geissolomataceae|Geissolomataceae gentianalesweb.htm#Gelsemiaceae|Gelsemiaceae gentianalesweb.htm#Gentianaceae|Gentianaceae geranialesweb.htm#Geraniaceae|Geraniaceae huertealesweb.htm#Gerrardinaceae|Gerrardinaceae lamialesweb.htm#Gesneriaceae|Gesneriaceae ginkgoales.html#Ginkgoaceae|Ginkgoaceae caryophyllalesweb.htm#Gisekiaceae|Gisekiaceae gnetales.html#Gnetaceae|Gnetaceae lauralesweb.htm#Gomortegaceae|Gomortegaceae asteralesweb.htm#Goodeniaceae|Goodeniaceae malpighialesweb.htm#Goupiaceae|Goupiaceae apialesweb.htm#Griseliniaceae|Griseliniaceae saxifragalesweb.htm#Grossulariaceae|Grossulariaceae cornalesweb.htm#Grubbiaceae|Grubbiaceae crossosomatalesweb.htm#Guametalaceae|Guamatelaceae gunneralesweb.htm#Gunneraceae|Gunneraceae brassicalesweb.htm#Gyrostemonaceae|Gyrostemonaceae commelinalesweb.htm#Haemodoraceae|Haemodoraceae caryophyllalesweb.htm#Halophytaceae|Halophytaceae saxifragalesweb.htm#Haloragaceae|Haloragaceae saxifragalesweb.htm#Hamamelidaceae|Hamamelidaceae commelinalesweb.htm#Hanguanaceae|Hanguanaceae zingiberalesweb.htm#Heliconiaceae|Heliconiaceae aquifolialesweb2.htm#Helwingiaceae|Helwingiaceae lauralesweb.htm#Hernandiaceae|Hernandiaceae magnolialesweb.htm#Himantandraceae|Himantandraceae oxalidalesweb.htm#Huaceae|Huaceae malpighialesweb.htm#Humiriaceae|Humiriaceae nymphaealesweb.htm#Hydatellaceae|Hydatellaceae piperalesweb2.htm#Hydnoraceae|Hydnoraceae cornalesweb.htm#Hydrangeaceae|Hydrangeaceae alismatalesweb.htm#Hydrocharitaceae|Hydrocharitaceae solanalesweb.htm#Hydroleaceae|Hydroleaceae cornalesweb.htm#Hydrostachyaceae|Hydrostachyaceae malpighialesweb.htm#Hypericaceae|Hypericaceae asparagalesweb.htm#Hypoxidaceae|Hypoxidaceae asparagalesweb.htm#Iridaceae|Iridaceae malpighialesweb.htm#Irvingiaceae|Irvingiaceae saxifragalesweb.htm#Iteaceae|Iteaceae asparagalesweb.htm#Ixioliriaceae|Ixiolirionaceae malpighialesweb.htm#Ixonanthaceae|Ixonanthaceae poalesweb.htm#Joinvilleaceae|Joinvilleaceae fagalesweb.htm#Juglandaceae|Juglandaceae poalesweb.htm#Juncaceae|Juncaceae alismatalesweb.htm#Juncaginaceae|Juncaginaceae sapindalesweb.htm#Kirkiaceae|Kirkiaceae brassicalesweb.htm#Koeberliniaceae|Koeberliniaceae zygophyllalesweb.htm#Krameriaceae|Krameriaceae malpighialesweb.htm#Lacistemataceae|Lacistemataceae lamialesweb.htm#Lamiaceae|Lamiaceae asparagalesweb.htm#Lanariaceae|Lanariaceae ranunculalesweb.htm#Lardizabalaceae|Lardizabalaceae lauralesweb.htm#Lauraceae|Lauraceae ericalesweb.htm#Lecythidaceae|Lecythidaceae geranialesweb.htm#Ledocarpaceae|Ledocarpaceae lamialesweb.htm#Lentibulariaceae|Lentibulariaceae celastralesweb.html#Lepidobotryaceae|Lepidobotryaceae lilialesweb.htm#Liliaceae|Liliaceae Caryophyllalesweb.htm#Limeaceae|Limeaceae brassicalesweb.htm#Limnanthaceae|Limnanthaceae malpighialesweb.htm#Linaceae|Linaceae lamialesweb.htm#Linderniaceae|Linderniaceae dipsacalesweb.htm#Linnaeaceae|Linnaeaceae cornalesweb.htm#Loasaceae|Loasaceae gentianalesweb.htm#Loganiaceae|Loganiaceae caryophyllalesweb.htm#Lophiocarpaceae|Lophiocarpaceae malpighialesweb.htm#Lophopyxidaceae|Lophopyxidaceae santalalesweb2.htm#Loranthaceae|Loranthaceae zingiberalesweb.htm#Lowiaceae|Lowiaceae myrtalesweb2.htm#Lythraceae|Lythraceae magnolialesweb.htm#Magnoliaceae|Magnoliaceae malpighialesweb.htm#Malpighiaceae|Malpighiaceae malvalesweb.htm#Malvaceae|Malvaceae zingiberalesweb.htm#Marantaceae|Marantaceae ericalesweb.htm#Marcgraviaceae|Marcgraviaceae lamialesweb.htm#Martyniaceae|Martyniaceae alismatalesweb.htm#Maundiaceae|Maundiaceae poalesweb.htm#Mayacaceae|Mayacaceae lilialesweb.htm#Melanthiaceae|Melanthiaceae myrtalesweb2.htm#Melastomataceae|Melastomataceae sapindalesweb.htm#Meliaceae|Meliaceae geranialesweb.htm#Melianthaceae|Melianthaceae ranunculalesweb.htm#Menispermaceae|Menispermaceae asteralesweb.htm#Menyanthaceae|Menyanthaceae garryalesweb.htm#Metteniusaceae|Metteniusaceae caryophyllalesweb.htm#Microteaceae|Microteaceae santalalesweb2.htm#Misodendraceae|Misodendraceae ericalesweb.htm#Mitrastemonaceae|Mitrastemonaceae caryophyllalesweb.htm#Molluginaceae|Molluginaceae lauralesweb.htm#Monimiaceae|Monimiaceae caryophyllalesweb.htm#Montiaceae|Montiaceae solanalesweb.htm#Montiniaceae|Montiniaceae rosalesweb.htm#Moraceae|Moraceae dipsacalesweb.htm#Morinaceae|Morinaceae brassicalesweb.htm#Moringaceae|Moringaceae malvalesweb.htm#Muntingiaceae|Muntingiaceae zingiberalesweb.htm#Musaceae|Musaceae apialesweb.htm#Myodocarpaceae|Myodocarpaceae fagalesweb.htm#Myricaceae|Myricaceae magnolialesweb.htm#Myristicaceae|Myristicaceae gunneralesweb.htm#Myrothamnaceae|Myrothamnaceae myrtalesweb2.htm#Myrtaceae|Myrtaceae dioscorealesweb.htm#Nartheciaceae|Nartheciaceae protealesweb.html#Nelumbonaceae|Nelumbonaceae caryophyllalesweb.htm#Nepenthaceae|Nepenthaceae malvalesweb.htm#Neuradaceae|Neuradaceae sapindalesweb.htm#Nitrariaceae|Nitrariaceae fagalesweb.htm#Nothofagaceae|Nothofagaceae caryophyllalesweb.htm#Nyctaginaceae|Nyctaginaceae nymphaealesweb.htm#Nymphaeaceae|Nymphaeaceae malpighialesweb.htm#Ochnaceae|Ochnaceae santalalesweb2.htm#Octonemaceae|Octonemaceae santalalesweb2.htm#Olacaceae|Olacaceae lamialesweb.htm#Oleaceae|Oleaceae myrtalesweb2.htm#Onagraceae|Onagraceae garryalesweb.htm#Oncothecaceae|Oncothecaceae santalalesweb2.htm#Opiliaceae|Opiliaceae asparagalesweb.htm#Orchidaceae|Orchidaceae lamialesweb.htm#Orobanchaceae|Orobanchaceae oxalidalesweb.htm#Oxalidaceae|Oxalidaceae saxifragalesweb.htm#Paeoniaceae|Paeoniaceae malpighialesweb.htm#Pandaceae|Pandaceae pandanalesweb.htm#Pandanaceae|Pandanaceae ranunculalesweb.htm#Papaveraceae|Papaveraceae Paracryphiales.html#Paracryphiaceae|Paracryphiaceae malpighialesweb.htm#Passifloraceae|Passifloraceae lamialesweb.htm#Paulowniaceae |Paulowniaceae lamialesweb.htm#Pedaliaceae|Pedaliaceae myrtalesweb2.htm#Penaeaceae|Penaeaceae apialesweb.htm#Pennantiaceae|Pennantiaceae brassicalesweb.htm#Pentadiplandraceae|Pentadiplandraceae asteralesweb.htm#Pentaphragmataceae|Pentaphragmataceae ericalesweb.htm#Pentaphylacaceae|Pentaphylacaceae saxifragalesweb.htm#Penthoraceae|Penthoraceae malpighialesweb.htm#Peraceae|Peraceae saxifragalesweb.htm#Peridiscaceae|Peridiscaceae huertealesweb.htm#Petenaeaceae|Petenaeaceae lilialesweb.htm#Petermanniaceae|Petermanniaceae petrosavialesweb.htm#Petrosaviaceae|Petrosaviaceae asteralesweb.htm#Phellinaceae|Phellinaceae lilialesweb.htm#Philesiaceae|Philesiaceae commelinalesweb.htm#Philydraceae|Philydraceae lamialesweb.htm#Phrymaceae|Phrymaceae malpighialesweb.htm#Phyllanthaceae|Phyllanthaceae aquifolialesweb2.htm#Phyllonomaceae|Phyllonomaceae caryophyllalesweb.htm#Physenaceae|Physenaceae caryophyllalesweb.htm#Phytolaccaceae|Phytolaccaceae picramnialesweb.html#Picramniaceae|Picramniaceae malpighialesweb.htm#Picrodendraceae|Picrodendraceae conifers.html#Pinaceae|Pinaceae piperalesweb2.htm#Piperaceae|Piperaceae apialesweb.htm#Pittosporaceae|Pittosporaceae lamialesweb.htm#Plantaginaceae|Plantaginaceae protealesweb.html#Platanaceae|Platanaceae lamialesweb.htm#Plocospermataceae|Plocospermataceae caryophyllalesweb.htm#Plumbaginaceae|Plumbaginaceae poalesweb.htm#Poaceae|Poaceae conifers.html#Podocarpaceae|Podocarpaceae malpighialesweb.htm#Podostemaceae|Podostemaceae ericalesweb.htm#Polemoniaceae|Polemoniaceae fabalesweb.htm#Polygalaceae|Polygalaceae caryophyllalesweb.htm#Polygonaceae|Polygonaceae commelinalesweb.htm#Pontederiaceae|Pontederiaceae caryophyllalesweb.htm#Portulacaceae|Portulacaceae alismatalesweb.htm#Posidoniaceae|Posidoniaceae alismatalesweb.htm#Potamogetonaceae|Potamogetonaceae ericalesweb.htm#Primulaceae|Primulaceae protealesweb.html#Proteaceae|Proteaceae malpighialesweb.htm#Putranjivaceae|Putranjivaceae fabalesweb.htm#Quillajaceae|Quillajaceae ranunculalesweb.htm#Ranunculaceae|Ranunculaceae poalesweb.htm#Rapateaceae |Rapateaceae brassicalesweb.htm#Resedaceae|Resedaceae poalesweb.htm#Restionaceae|Restionaceae caryophyllalesweb.htm#Rhabdodendraceae|Rhabdodendraceae rosalesweb.htm#Rhamnaceae|Rhamnaceae lilialesweb.htm#Rhipogonaceae|Rhipogonaceae malpighialesweb.htm#Rhizophoraceae|Rhizophoraceae fagalesweb.htm#Rhoipteleaceae|Rhoipteleaceae ericalesweb.htm#Roridulaceae|Roridulaceae rosalesweb.htm#Rosaceae|Rosaceae asteralesweb.htm#Rousseaceae|Rousseaceae gentianalesweb.htm#Rubiaceae|Rubiaceae alismatalesweb.htm#Ruppiaceae|Ruppiaceae sapindalesweb.htm#Rutaceae|Rutaceae Sabiales.html#Sabiaceae|Sabiaceae malpighialesweb.htm#Salicaceae|Salicaceae brassicalesweb.htm#Salvadoraceae|Salvadoraceae santalalesweb2.htm#Santalaceae|Santalaceae sapindalesweb.htm#Sapindaceae|Sapindaceae ericalesweb.htm#Sapotaceae|Sapotaceae caryophyllalesweb.htm#Sarcobataceae|Sarcobataceae malvalesweb.htm#Sarcolaenaceae|Sarcolaenaceae ericalesweb.htm#Sarraceniaceae|Sarraceniaceae piperalesweb2.htm#Saururaceae|Saururaceae saxifragalesweb.htm#Saxifragaceae|Saxifragaceae alismatalesweb.htm#Scheuchzeriaceae|Scheuchzeriaceae austrobaileyalesweb.htm#Schisandraceae|Schisandraceae lamialesweb.htm#Schlegeliaceae|Schlegeliaceae santalalesweb2.htm#Schoepfiaceae|Schoepfiaceae conifers.html#Sciadopityaceae|Sciadopityaceae lamialesweb.htm#Scrophulariaceae|Scrophulariaceae brassicalesweb.htm#Setchellanthaceae|Setchellanthaceae sapindalesweb.htm#Simaroubaceae|Simaroubaceae caryophyllalesweb.htm#Simmondsiaceae|Simmondsiaceae lauralesweb.htm#Siparunaceae|Siparunaceae ericalesweb.htm#Sladeniaceae|Sladeniaceae lilialesweb.htm#Smilacaceae|Smilacaceae solanalesweb.htm#Solanaceae|Solanaceae malvalesweb.htm#Sphaerosepalaceae|Sphaerosepalaceae solanalesweb.htm#Sphenocleaceae|Sphenocleaceae crossosomatalesweb.htm#Stachyuraceae|Stachyuraceae crossosomatalesweb.htm#Staphyleaceae|Staphyleaceae caryophyllalesweb.htm#Stegnospermataceae|Stegnospermataceae pandanalesweb.htm#Stemonaceae|Stemonaceae aquifolialesweb2.htm#Stemonuraceae|Stemonuraceae lamialesweb.htm#Stilbaceae|Stilbaceae brassicalesweb.htm#Stixaceae|Stixaceae crossosomatalesweb.htm#Strasburgeriaceae|Strasburgeriaceae zingiberalesweb.htm#Strelitziaceae|Strelitziaceae santalalesweb2.htm#Strombosiaceae|Strombosiaceae asteralesweb.htm#Stylidiaceae|Stylidiaceae ericalesweb.htm#Styracaceae|Styracaceae fabalesweb.htm#Surianaceae|Surianaceae ericalesweb.htm#Symplocaceae|Symplocaceae caryophyllalesweb.htm#Talinaceae|Talinaceae caryophyllalesweb.htm#Tamaricaceae|Tamaricaceae huertealesweb.htm#Tapisciaceae|Tapisciaceae conifers.html#Taxaceae|Taxaceae asparagalesweb.htm#Tecophilaeaceae|Tecophilaeaceae saxifragalesweb.htm#Tetracarpaeaceae|Tetracarpaeaceae lamialesweb.htm#Tetrachondraceae|Tetrachondraceae cucurbitalesweb.htm#Tetramelaceae|Tetramelaceae ericalesweb.htm#Tetrameristaceae|Tetrameristaceae ericalesweb.htm#Theaceae|Theaceae dioscorealesweb.htm#Thismiaceae|Thismiaceae lamialesweb.htm#Thomandersiaceae|Thomandersiaceae poalesweb.htm#Thurniaceae|Thurniaceae malvalesweb.htm#Thymelaeaceae|Thymelaeaceae fagalesweb.htm#Ticodendraceae|Ticodendraceae alismatalesweb.htm#Tofieldiaceae|Tofieldiaceae apialesweb.htm#Torricelliaceae|Torricelliaceae brassicalesweb.htm#Tovariaceae|Tovariaceae malpighialesweb.htm#Trigoniaceae|Trigoniaceae austrobaileyalesweb.htm#Trimeniaceae|Trimeniaceae pandanalesweb.htm#Triuridaceae|Triuridaceae trochodendralesweb.html#Trochodendraceae|Trochodendraceae brassicalesweb.htm#Tropaeolaceae|Tropaeolaceae poalesweb.htm#Typhaceae|Typhaceae rosalesweb.htm#Ulmaceae|Ulmaceae rosalesweb.htm#Urticaceae|Urticaceae gentianalesweb.htm#Vahliaceae|Vahliaceae dipsacalesweb.htm#Valerianaceae|Valerianaceae pandanalesweb.htm#Velloziaceae|Velloziaceae lamialesweb.htm#Verbenaceae|Verbenaceae malpighialesweb.htm#Violaceae|Violaceae vitalesweb.html#Vitaceae|Vitaceae geranialesweb.htm#Vivianiaceae|Vivianiaceae myrtalesweb2.htm#Vochysiaceae|Vochysiaceae gnetales.html#Welwitschiaceae|Welwitschiaceae canellalesweb.htm#Winteraceae|Winteraceae asparagalesweb.htm#Xanthorrhoeaceae|Xanthorrhoeaceae asparagalesweb.htm#Xeronemataceae|Xeronemataceae santalalesweb2.htm#Ximeniaceae|Ximeniaceae poalesweb.htm#Xyridaceae|Xyridaceae zingiberalesweb.htm#Zingiberaceae|Zingiberaceae alismatalesweb.htm#Zosteraceae|Zosteraceae zygophyllalesweb.htm#Zygophyllaceae|Zygophyllaceae" ;

  split(fams, tmp, " ");
  for (i in tmp)
  {
      split(tmp[i], tmp2, "|");
      apfam[toupper(tmp2[2])] = tmp2[1];
  }
}