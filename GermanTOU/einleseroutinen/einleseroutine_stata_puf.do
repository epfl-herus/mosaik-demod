/* ---------------------------------------------------------------------------------------------------------------------------------------

   1. Programmname: einleseroutine_stata.do
   2. Stand: 04.03.2016
   3. Autor: FDZ des Statistischen Bundesamtes 
   4. Programmziel:  Einlesen und Labeln des Public-Use-Files der Erhebung zur Zeitverwendung 2012/2013, 
		das als CSV-Datei mit Semikolons als Trennzeichen vorliegt.
   5. Programmstatus: 
   6. Programmstruktur:
        (I) Verzeichnisse, in denen sich die CSV-Daten befinden, Benennen der Einlesedateien, Benennen der temporären Ausgabedateien
		(II) ZVE 13 HH
				(i) 	Einlesen CSV-Datei
				(ii)	Definition der Wertelabels, die temporär in WORK gespeichert werden
     			(iii)	Zuweisung der Werte- und Variablenlabels zu den Variablen
				(iv)	Speichern
		(III) ZVE 13 pers
				(i) 	Einlesen CSV-Datei
				(ii)	Definition der Wertelabels, die temporär in WORK gespeichert werden
     			(iii)	Zuweisung der Werte- und Variablenlabels zu den Variablen
				(iv)	Speichern
		(IV) ZVE 13 sum
				(i) 	Einlesen CSV-Datei
				(ii)	Definition der Wertelabels, die temporär in WORK gespeichert werden
     			(iii)	Zuweisung der Werte- und Variablenlabels zu den Variablen
				(iv)	Speichern					
		(V) ZVE 13 takt
				(i) 	Einlesen CSV-Datei
				(ii)	Definition der Wertelabels, die temporär in WORK gespeichert werden
     			(iii)	Zuweisung der Werte- und Variablenlabels zu den Variablen
				(iv)	Speichern
    
------------------------------------------------------------------------------------------------------------------------------------------- */

/*(I) Verzeichnisse, in denen sich die CSV-Daten befinden, Benennen der Einlesedateien, Benennen der temporären Ausgabedateien*/

clear
capture log close

**********************************************************************************************.
* Die Zeilen 44, 49, 54 und 59 müssen individuell an die eigene Pfadumgebung angepasst werden*.
**********************************************************************************************.

*	zve 13 hh	
global pfad1		"<PFAD, IN DEM DIE CSV-DATEN LIEGEN ANPASSEN, z.B. E:\daten\>"
global CSVdatei1 	"zve13_puf_hh.csv"
global dateiname1   zve13_puf_hh.dta
 
 *	zve 13 pers	
global pfad2		"<PFAD, IN DEM DIE CSV-DATEN LIEGEN ANPASSEN, z.B. E:\daten\>"
global CSVdatei2 	"zve13_puf_pers.csv"
global dateiname2   zve13_puf_pers.dta

*	zve 13 sum	
global pfad3		"<PFAD, IN DEM DIE CSV-DATEN LIEGEN ANPASSEN, z.B. E:\daten\>"
global CSVdatei3 	"zve13_puf_sum.csv"
global dateiname3   zve13_puf_sum.dta

*	zve 13 takt	
global pfad4		"<PFAD, IN DEM DIE CSV-DATEN LIEGEN ANPASSEN, z.B. E:\daten\>"
global CSVdatei4 	"zve13_puf_takt.csv"
global dateiname4   zve13_puf_takt.dta

/* STATA-Version angeben */
global stata_version=<13>

/**************************************************************************************/
/* Ab dieser Zeile müssen keine Anpassungen mehr vorgenommen werden*/
/**************************************************************************************/

*********************************************************************************************************************************
*********************************************************************************************************************************		


*(II) ZVE 13 HH

		*(i) 	Einlesen CSV-Datei
clear		
/* Einlesen für STATA 12 und darunter */
if ${stata_version} < 13 {
	insheet using "${pfad1}\${CSVdatei1}", names delimiter(";")
	}
	
/* Einlesen für STATA 13 */
if ${stata_version} >= 13 {
	import delimited "${pfad1}\${CSVdatei1}", delimiter(";") varnames(1)
	}

		
		*(ii)	Definition der Wertelabels
#delimit ;		
label define hb9x_label
30 "30 qm und weniger"
200 "200 qm und mehr", replace;
label define hb10x_label 
8 "8 oder mehr", replace;
label define hb11_label 
1 "Eigentümer/-in"
2 "Mieter/-in"
3 "Wohnung mietfrei überlassen", replace;
label define hb121a_label 
-1 "keine Angabe"
1 "ja"
2 "nein", replace;
label define hb121bx_label 
-1 "keine Angabe"
3 "3 oder mehr", replace;
label define hb122a_label 
-1 "keine Angabe"
1 "ja"
2 "nein", replace;
label define hb122bx_label 
-1 "keine Angabe"
6 "6 oder mehr", replace;
label define hb13_label 
1 "ja"
2 "nein", replace;
label define hc141a_label 
-1 "keine Angabe"
1 "ja"
2 "nein", replace;
label define hc141bx_label 
-1 "keine Angabe"
60 "60 und mehr", replace;
label define hc141cx_label 
-1 "keine Angabe"
40 "40 und mehr", replace;
label define hc142a_label 
-1 "keine Angabe"
1 "ja"
2 "nein", replace;
label define hc142bx_label 
-1 "keine Angabe"
10 "10 und mehr", replace;
label define hc142cx_label 
-1 "keine Angabe"
15 "15 und mehr", replace;
label define hc143a_label 
-1 "keine Angabe"
1 "ja"
2 "nein", replace;
label define hc143bx_label 
-1 "keine Angabe"
12 "12 und mehr", replace;
label define hc143cx_label 
-1 "keine Angabe"
20 "20 und mehr", replace;
label define hc144a_label 
-1 "keine Angabe"
1 "ja"
2 "nein", replace;
label define hc144bx_label 
-1 "keine Angabe"
3 "3 und mehr", replace;
label define hc144cx_label 
-1 "keine Angabe", replace;
label define hc145a_label 
-1 "keine Angabe"
1 "ja"
2 "nein", replace;
label define hc145bx_label 
-1 "keine Angabe"
5 "5 und mehr", replace;
label define hc145cx_label 
-1 "keine Angabe"
20 "20 und mehr", replace;
label define hc146a_label 
-1 "keine Angabe"
1 "ja"
2 "nein", replace;
label define hc146bx_label 
-1 "keine Angabe"
5 "5 und mehr", replace;
label define hc146cx_label 
-1 "keine Angabe", replace;
label define hc147a_label 
-1 "keine Angabe"
1 "ja"
2 "nein", replace;
label define hc147bx_label 
-1 "keine Angabe"
5 "5 und mehr", replace;
label define hc147cx_label 
-1 "keine Angabe"
30 "30 und mehr", replace;
label define hc148a_label 
-1 "keine Angabe"
1 "ja"
2 "nein", replace;
label define hc148bx_label 
-1 "keine Angabe", replace;
label define hc148cx_label 
-1 "keine Angabe", replace;
label define hc149a_label 
-1 "keine Angabe"
1 "ja"
2 "nein", replace;
label define hc149bx_label 
-1 "keine Angabe"
4 "4 und mehr", replace;
label define hc149cx_label 
-1 "keine Angabe", replace;
label define hc1410a_label 
-1 "keine Angabe"
1 "ja"
2 "nein", replace;
label define hc1410bx_label 
-1 "keine Angabe"
2 "2 und mehr", replace;
label define hc1410c_label 
-1 "keine Angabe"
6 "6 und mehr", replace;
label define hc1411a_label 
-1 "keine Angabe"
1 "ja"
2 "nein", replace;
label define hc1411b_label 
-1 "keine Angabe", replace;
label define hc1411c_label 
-1 "keine Angabe"
40 "40 und mehr", replace;
label define hd15x_label 
1 "unter 1100 Euro"
2 "1100 bis unter 1700 Euro"
3 "1700 bis unter 2300 Euro"
4 "2300 bis unter 3600 Euro"
5 "3600 Euro und mehr", replace;
label define he16_label 
1 "ja"
2 "nein", replace;
label define hhtyp_label 
1 "Einpersonenhaushalt"
2 "Paare ohne Kinder"
3 "Alleinerziehende mit mindestens einem Kind unter 18 Jahren und ledigen Kindern unter 27 Jahren"
4 "Paare mit mindestens einem Kind unter 18 Jahren und ledigen Kindern unter 27 Jahren"
5 "Sonstige Haushalte", replace;
label define anz_kind27_label 
-2 "trifft nicht zu"
1 "1 Kind"
2 "2 Kinder"
3 "3 und mehr Kinder", replace;
label define juki_label 
-2 "trifft nicht zu", replace;
label define juki_gr_label 
-2 "trifft nicht zu"
1 "0 bis unter 3 Jahren"
2 "3 bis unter 6 Jahren"
3 "6 bis unter 10 Jahren"
4 "10 bis unter 15 Jahren"
5 "15 bis unter 18 Jahren", replace;
label define ha1_gr_label 
1 "1 Person"
2 "2 Personen"
3 "3 Personen"
4 "4 Personen"
5 "5 oder mehr Personen", replace;
label define soz_heb_label 
1 "Selbstständiger"
2 "Beamter"
3 "Angestellter"
4 "Arbeiter"
5 "Rentner, Pensionär"
6 "Sonstige Nichterwerbstätige", replace;
label define anz_erw_label 
1 "keine Erwerbstätige"
2 "1 Vollzeit"
3 "1 Teilzeit"
4 "2 Vollzeit"
5 "1 Vollzeit, 1 Teilzeit"
6 "3 Vollzeit"
7 "Sonstige", replace;
label define pers_part_heb_label 
-2 "trifft nicht zu", replace;
label define anz_erwpart_label 
-2 "trifft nicht zu"
1 "ein Partner erwerbstätig"
2 "beide Partner erwerbstätig"
3 "kein Partner erwerbstätig", replace;
label define gebiet_label 
1 "West (Alte Bundesländer)"
2 "Ost (Neue Bundesländer einschließlich Berlin)", replace;
		

#delimit cr
 		

     	*(iii)	Zuweisung der Werte- und Variablenlabels zu den Variablen
		
label variable id_hhx "Haushalts-ID"
label variable berichtsjahr "Berichtsjahr"
label variable ha1x "Anzahl der im Haushalt lebenden Personen"
label variable hb9x "Wohnfläche Wohnung"
label variable hb10x "Anzahl der Räume"
label variable hb11 "Eigentümer/Mieter/mietfrei"
label variable hb121a "Auto"
label variable hb121bx "Auto Anzahl"
label variable hb122a "Computer"
label variable hb122bx "Computer Anzahl"
label variable hb13 "Internetzugang"
label variable hc141a "Unterstützung durch andere Personen: Kinderbetreuung"
label variable hc141bx "Unterstützung durch andere Personen: bezahlte Stunden Kinderbetreuung"
label variable hc141cx "Unterstützung durch andere Personen: unbezahlte Stunden Kinderbetreuung"
label variable hc142a "Unterstützung durch andere Personen: Zubereitung von Mahlzeiten"
label variable hc142bx "Unterstützung durch andere Personen: bezahlte Stunden Zubereitung von Mahlzeiten"
label variable hc142cx "Unterstützung durch andere Personen: unbezahlte Stunden Zubereitung von Mahlzeiten"
label variable hc143a "Unterstützung durch andere Personen: Putzen, Aufräumen, Waschen"
label variable hc143bx "Unterstützung durch andere Personen: bezahlte Stunden Putzen, Aufräumen, Waschen"
label variable hc143cx "Unterstützung durch andere Personen: unbezahlte Stunden Putzen, Aufräumen, Waschen"
label variable hc144a "Unterstützung durch andere Personen: Nach dem Rechten sehen"
label variable hc144bx "Unterstützung durch andere Personen: bezahlte Stunden nach dem Rechten sehen"
label variable hc144cx "Unterstützung durch andere Personen: unbezahlte Stunden nach dem Rechten sehen"
label variable hc145a "Unterstützung durch andere Personen: Gartenarbeit"
label variable hc145bx "Unterstützung durch andere Personen: bezahlte Stunden Gartenarbeit"
label variable hc145cx "Unterstützung durch andere Personen: unbezahlte Stunden Gartenarbeit"
label variable hc146a "Unterstützung durch andere Personen: Einkaufen und Besorgungen"
label variable hc146bx "Unterstützung durch andere Personen: bezahlte Stunden Einkaufen und Besorgungen"
label variable hc146cx "Unterstützung durch andere Personen: unbezahlte Stunden Einkaufen und Besorgungen"
label variable hc147a "Unterstützung durch andere Personen: Haustierpflege"
label variable hc147bx "Unterstützung durch andere Personen: bezahlte Stunden Haustierpflege"
label variable hc147cx "Unterstützung durch andere Personen: unbezahlte Stunden Haustierpflege"
label variable hc148a "Unterstützung durch andere Personen: Reparatur von Fahrzeugen"
label variable hc148bx "Unterstützung durch andere Personen: bezahlte Stunden Reparatur von Fahrzeugen"
label variable hc148cx "Unterstützung durch andere Personen: unbezahlte Stunden Reparatur von Fahrzeugen"
label variable hc149a "Unterstützung durch andere Personen: Reparieren und Bauen"
label variable hc149bx "Unterstützung durch andere Personen: bezahlte Stunden Reparieren und Bauen"
label variable hc149cx "Unterstützung durch andere Personen: unbezahlte Stunden Reparieren und Bauen"
label variable hc1410a "Unterstützung durch andere Personen: Versicherungs-, Behördenangelegenheiten"
label variable hc1410bx "Unterstützung durch andere Personen: bezahlte Stunden Versicherungs-, Behördenangelegenheiten"
label variable hc1410c "Unterstützung durch andere Personen: unbezahlte Stunden Versicherungs-, Behördenangelegenheiten"
label variable hc1411a "Unterstützung durch andere Personen: Sonstige Unterstützung"
label variable hc1411b "Unterstützung durch andere Personen: bezahlte Stunden Sonstige Unterstützung"
label variable hc1411c "Unterstützung durch andere Personen: unbezahlte Stunden Sonstige Unterstützung"
label variable hd15x "Monatliches Haushaltsnettoeinkommen"
label variable he16 "Kinder unter 10 Jahren im Haushalt"
label variable he17anzx "Anzahl der Kinder unter 10 Jahren"
label variable hrfh80 "Hochrechnungsfaktor für den Haushalt multipliziert mit 100 (ohne Nachkommastelle)"
label variable hhtyp "Haushaltstyp"
label variable anz_kind27 "Anzahl der ledigen Kindern unter 27 Jahren"
label variable juki "Alter des jüngsten Kindes in Haushalten mit Kindern unter 18 Jahren"
label variable juki_gr "Altersklasse des jüngsten Kindes in Haushalten mit Kindern unter 18 Jahren"
label variable ha1_gr "Anzahl der im Haushalt lebenden Personen"
label variable soz_heb "Soziale Stellung des Haupteinkommensbeziehers"
label variable anz_erw "Anzahl der Erwerbstätigen im Haushalt"
label variable pers_part_heb "Personennummer des Partners des Haupteinkommensbeziehers"
label variable anz_erwpart "Anzahl der Erwerbstätigen innerhalb der Partnerschaft (Haupteinkommensbezieher/Lebenspartner)"
label variable gebiet "Gebiet"


label value hb9x hb9x_label
label value hb10x hb10x_label
label value hb11 hb11_label
label value hb121a hb121a_label
label value hb121bx hb121bx_label
label value hb122a hb122a_label
label value hb122bx hb122bx_label
label value hb13 hb13_label
label value hc141a hc141a_label
label value hc141bx hc141bx_label
label value hc141cx hc141cx_label
label value hc142a hc142a_label
label value hc142bx hc142bx_label
label value hc142cx hc142cx_label
label value hc143a hc143a_label
label value hc143bx hc143bx_label
label value hc143cx hc143cx_label
label value hc144a hc144a_label
label value hc144bx hc144bx_label
label value hc144cx hc144cx_label
label value hc145a hc145a_label
label value hc145bx hc145bx_label
label value hc145cx hc145cx_label
label value hc146a hc146a_label
label value hc146bx hc146bx_label
label value hc146cx hc146cx_label
label value hc147a hc147a_label
label value hc147bx hc147bx_label
label value hc147cx hc147cx_label
label value hc148a hc148a_label
label value hc148bx hc148bx_label
label value hc148cx hc148cx_label
label value hc149a hc149a_label
label value hc149bx hc149bx_label
label value hc149cx hc149cx_label
label value hc1410a hc1410a_label
label value hc1410bx hc1410bx_label
label value hc1410c hc1410c_label
label value hc1411a hc1411a_label
label value hc1411b hc1411b_label
label value hc1411c hc1411c_label
label value hd15x hd15x_label
label value he16 he16_label
label value hhtyp hhtyp_label
label value anz_kind27 anz_kind27_label
label value juki juki_label
label value juki_gr juki_gr_label
label value ha1_gr ha1_gr_label
label value soz_heb soz_heb_label
label value anz_erw anz_erw_label
label value pers_part_heb pers_part_heb_label
label value anz_erwpart anz_erwpart_label
label value gebiet gebiet_label

/* (iv): Speichern */

compress
save "${pfad1}\${dateiname1}", replace
clear


*********************************************************************************************************************************
*********************************************************************************************************************************		


*(III) ZVE 13 pers


		*(i) 	Einlesen CSV-Datei
clear
/* Einlesen für STATA 12 und darunter */
if ${stata_version} < 13 {
	insheet using "${pfad2}\${CSVdatei2}", names delimiter(";")
	}
	
/* Einlesen für STATA 13 */
if ${stata_version} >= 13 {
	import delimited "${pfad2}\${CSVdatei2}", delimiter(";") varnames(1)		
	}
	

		*(ii)	Definition der Wertelabels
#delimit;
		
label define alterx_label
0  "0 bis unter 3 Jahren"
3  "3 bis unter 6 Jahren"
6  "6 Jahre"
7  "7 bis unter 10 Jahren"
75  "75 Jahre und älter", replace;
label define ha3_label
1 "männlich"
2 "weiblich", replace;
label define pa2x_label
-1 "keine Angabe"
1 "ledig"
2 "Verheiratet und Ehepartner lebt im Haushalt"
3 "Geschieden/Verheiratet und dauernd getrennt lebend"
4 "Verwitwet", replace;
label define ha6x_label
1 "Haupteinkommensbezieher"
2 "Ehe-, Lebenspartner/-in"
3 "Kind"
4 "Bruder/Schwester"
5 "Enkelkind"
6 "Vater/Mutter"
7 "Großvater/Großmutter"
8 "Anders verwandt/verschwägert"
9 "Nicht verwandt/verschwägert", replace;
label define ha71_label
1 "Deutsche Staatsangehörigkeit"
2 "Sonstige Staatsangehörigkeit, staatenlos", replace;
label define ha8x_label
-1 "keine Angabe"
1 "Deutschland"
2 "Sonstiges Land", replace;
label define he181_label
-2 "trifft nicht zu"
1 "ja"
2 "nein", replace;
label define he18_kibetrx_label
-2 "trifft nicht zu"
0 "keine Betreuung durch Tagesmutter/Tagesvater, Krippe, Kindertagesstätte, vorschulische Einrichtungen, Hort"
10 "1-10 Stunden"
15 "11-15 Stunden"
20 "16-20 Stunden"
25 "21-25 Stunden"
30 "26-30 Stunden"
40 "31-40 Stunden"
41 "41 Stunden und mehr", replace;
label define he187x_label
-2 "trifft nicht zu"
21 "21 Stunden und mehr", replace;
label define he19x_label
-1 "keine Angabe"
-2 "trifft nicht zu"
5 "5 Tage und mehr", replace;
label define he201_label
-2 "trifft nicht zu"
1 "Kind geht nicht zur Schule"
2 "Kind geht zur Schule", replace;
label define he202x_label
-2 "trifft nicht zu"
20 "15-20 Stunden"
40 "31-40 Stunden", replace;
label define he211_label
-1 "keine Angabe"
-2 "trifft nicht zu"
1 "Keine Teilnahme an AGs"
2 "Teilnahme an AGs", replace;
label define he212x_label
-1 "keine Angabe"
-2 "trifft nicht zu"
5  "5 Stunden und mehr", replace;
label define he22x_label
-2 "trifft nicht zu"
50 "41-50 Stunden", replace;
label define he231_label
-1 "keine Angabe"
-2 "trifft nicht zu"
0 "nein"
1 "ja", replace;
label define he232_label
-1 "keine Angabe"
-2 "trifft nicht zu"
0 "nein"
1 "ja", replace;
label define he233_label
-1 "keine Angabe"
-2 "trifft nicht zu"
0 "nein"
1 "ja", replace;
label define he234_label
-1 "keine Angabe"
-2 "trifft nicht zu"
0 "nein"
1 "ja", replace;
label define he235_label
-1 "keine Angabe"
-2 "trifft nicht zu"
0 "nein"
1 "ja", replace;
label define he236_label
-1 "keine Angabe"
-2 "trifft nicht zu"
1 "ja"
2 "nein", replace;
label define he237_label
-1 "keine Angabe"
-2 "trifft nicht zu"
0 "nein"
1 "ja", replace;
label define he241x_label
-1 "keine Angabe"
-2 "trifft nicht zu"
6 "6 Stunden und mehr", replace;
label define he245x_label
-1 "keine Angabe"
-2 "trifft nicht zu"
3 "3 Stunden und mehr", replace;
label define he246x_label
-1 "keine Angabe"
-2 "trifft nicht zu"
3 "3 Stunden und mehr", replace;
label define he247x_label
-1 "keine Angabe"
-2 "trifft nicht zu"
2 "2 Stunden und mehr", replace;
label define he248_label
-1 "keine Angabe"
-2 "trifft nicht zu"
1 "ja"
2 "nein", replace;
label define he249_label
-1 "keine Angabe"
-2 "trifft nicht zu", replace;
label define pfb_ausgef_label
-2 "trifft nicht zu"
1 "ja"
2 "nein", replace;
label define pb3_label
-1 "keine Angabe"
-2 "trifft nicht zu"
1 "Selbstständiger, Freiberufler, Landwirt, mithelfender Familienangehöriger"
2 "Angestellter, Arbeiter, Beamter, Richter, Zeit-/Berufssoldat, Freiwillig soziales/ökologisches/kulturelles Jahr, freiwilliger Wehrdienst, Bundesfreiwilligendienst"
3 "Auszubildender (auch Praktikant,Volontär)"
4 "In Altersteilzeit (Arbeits- und Freistellungsphase)"
5 "In Elternzeit (mit ungekündigtem Arbeitsvertrag)"
6 "Schüler, Student"
7 "Arbeitslos"
8 "Im Ruhestand oder Vorruhestand"
9 "Dauerhaft erwerbsunfähig"
10 "Hausfrau/Hausmann"
11 "Aus anderen Gründen nicht erwerbstätig", replace;
label define pb4_label
-1 "keine Angabe"
-2 "trifft nicht zu"
1 "ja"
2 "nein", replace;
label define pc5x_label
-1 "keine Angabe"
-2 "trifft nicht zu"
1 "Angestellter, freiwilliger Wehrdienst, Freiwilligendienst, Freiwilliges soziales/ökologisches/kulturelles Jahr"
2 "Arbeiter"
3 "Beamter"
4 "Selbstständiger, Landwirt, Mithelf. Familienangehöriger", replace;
label define pc6_label
-1 "keine Angabe"
-2 "trifft nicht zu"
1 "unbefristet"
2 "befristet", replace;
label define pc7_label
-1 "keine Angabe"
-2 "trifft nicht zu"
1 "Vollzeit"
2 "Teilzeit", replace;
label define pc8x_label
-1 "keine Angabe"
-2 "trifft nicht zu"
3  "0 bis 3 Stunden"
60 "60 Stunden und mehr", replace;
label define pc9x_label
-1 "keine Angabe"
-2 "trifft nicht zu"
3  "0 bis 3 Stunden"
60 "60 Stunden und mehr", replace;
label define pc10_label
-1 "keine Angabe"
-2 "trifft nicht zu"
1 "ja"
2 "nein", replace;
label define pc11x_label
-1 "keine Angabe"
-2 "trifft nicht zu"
1 "Land- und Forstwirtschaft, Fischerei"
2 "Bergbau und Gewinnung von Erdöl, Erdgas, Steinen"
3 "Verarbeitendes Gewerbe/Herstellung von Waren"
4 "Energieversorgung, Wasserversorgung, Abwasser, Abfallentsorgung, Bergbau und Gewinnung von Erdöl, Erdgas, Steinen"
6 "Baugewerbe, Hoch- und Tiefbau"
7 "Groß- und Einzelhandel; Reparatur von Kraftfahrzeugen"
8 "Personen- und Güterverkehr, Lagerei"
9 "Gastgewerbe/Beherbergung und Gastronomie"
10 "Information und Kommunikation"
11 "Banken/Finanz- und Versicherungsdienstleister"
12 "Grundstücks- und Wohnungswesen"
13 "Freiberufliche, wissenschaftl., technische Dienstleistungen"
14 "Sonstige wirtschaftliche Dienstleistungen"
15 "Öffentliche Verwaltung, Gerichte, Verteidigung, Sicherheit"
16 "Erziehung und Unterricht"
17 "Gesundheits- und Sozialwesen"
18 "Sonstige überwiegend personenbezogene Dienstleistungen"
19 "Kunst, Unterhaltung, Sport und Erholung"
20 "Gewerkschaft, Verband, Partei, kirchliche Vereinigung"
21 "Konsulat, Botschaft, inter- und supranat. Organisation"
22 "Privater Haushalt mit Beschäftigten", replace;
label define pc121_label
-1 "keine Angabe"
-2 "trifft nicht zu"
1 "Kilometerangabe"
2 "Ständig wechselnde Arbeitsstätte"
3 "Arbeitsstätte im gleichen Gebäude", replace;
label define pc122x_label
-1 "keine Angabe"
-2 "trifft nicht zu"
1  "bis 1 km"
90 "90 km und mehr", replace;
label define pc13x_label
-1 "keine Angabe"
-2 "trifft nicht zu"
100 "100 min und mehr", replace;
label define pc14_label
-1 "keine Angabe"
-2 "trifft nicht zu"
1 "Feststehende Anfangs- und Schlusszeiten"
2 "Gleitzeit"
3 "Freie Arbeitszeitgestaltung", replace;
label define pc15_label
-1 "keine Angabe"
-2 "trifft nicht zu"
1 "ja"
2 "nein", replace;
label define pc161_label
-1 "keine Angabe"
-2 "trifft nicht zu"
0 "nein"
1 "ja", replace;
label define pc162_label
-1 "keine Angabe"
-2 "trifft nicht zu"
0 "nein"
1 "ja", replace;
label define pc17_label
-1 "keine Angabe"
-2 "trifft nicht zu"
1 "ja"
2 "nein", replace;
label define pc18_label
-1 "keine Angabe"
-2 "trifft nicht zu"
1 "Jedes Wochenende"
2 "Jedes zweite Wochenende"
3 "Jedes dritte oder vierte Wochenende"
4 "Seltener"
5 "Nie", replace;
label define pd191_label
-1 "keine Angabe"
-2 "trifft nicht zu"
1 "ja"
2 "nein", replace;
label define pd192x_label
-1 "keine Angabe"
-2 "trifft nicht zu"
2 "2 oder mehr", replace;
label define pd20_label
-1 "keine Angabe"
-2 "trifft nicht zu", replace;
label define pd21x_label
-1 "keine Angabe"
-2 "trifft nicht zu", replace;
label define pd22x_label
-1 "keine Angabe"
-2 "trifft nicht zu", replace;
label define pe23x_label
-1 "keine Angabe"
-2 "trifft nicht zu"
1  "Unter 900 Euro"
2 "900 bis unter 1300 Euro"
3 "1300 bis unter 1700 Euro"
4 "1700 bis unter 2300 Euro"
5 "2300 Euro oder mehr", replace;
label define pf24_label
-1 "keine Angabe"
-2 "trifft nicht zu"
1 "ja"
2 "nein", replace;
label define pf25x_label
-1 "keine Angabe"
-2 "trifft nicht zu"
1 "allgemeinbildende Schule"
2 "berufliche Schule", replace;
label define pf26x_label
-1 "keine Angabe"
-2 "trifft nicht zu"
7 "unter 8 Stunden"
41 "41 bis 45 Stunden", replace;
label define pf271_label
-1 "keine Angabe"
-2 "trifft nicht zu"
1 "Teilnahme an AGs"
2 "Keine Teilnahme an AGs", replace;
label define pf272x_label
-1 "keine Angabe"
-2 "trifft nicht zu"
5 "5 Stunden und mehr", replace;
label define pf28x_label
-1 "keine Angabe"
-2 "trifft nicht zu"
7 "unter 8 Stunden"
45 "45 Stunden und mehr", replace;
label define pf291a_label
-1 "keine Angabe"
-2 "trifft nicht zu"
1 "ja"
2 "nein", replace;
label define pf291b_label
-1 "keine Angabe"
-2 "trifft nicht zu"
11 "11 Stunden und mehr", replace;
label define pf292a_label
-1 "keine Angabe"
-2 "trifft nicht zu"
1 "ja"
2 "nein", replace;
label define pf292bx_label
-1 "keine Angabe"
-2 "trifft nicht zu"
2 "2 Stunden und mehr", replace;
label define pf293a_label
-1 "keine Angabe"
-2 "trifft nicht zu"
1 "ja"
2 "nein", replace;
label define pf293bx_label
-1 "keine Angabe"
-2 "trifft nicht zu"
2 "2 Stunden und mehr", replace;
label define pf294a_label
-1 "keine Angabe"
-2 "trifft nicht zu"
1 "ja"
2 "nein", replace;
label define pf294bx_label
-1 "keine Angabe"
-2 "trifft nicht zu"
4 "4 Stunden und mehr", replace;
label define pg321a_label
-1 "keine Angabe"
-2 "trifft nicht zu"
1 "ja"
2 "nein", replace;
label define pg321b_label
-1 "keine Angabe"
-2 "trifft nicht zu", replace;
label define pg322a_label
-1 "keine Angabe"
-2 "trifft nicht zu"
1 "ja"
2 "nein", replace;
label define pg322b_label
-1 "keine Angabe"
-2 "trifft nicht zu", replace;
label define pg323a_label
-1 "keine Angabe"
-2 "trifft nicht zu"
1 "ja"
2 "nein", replace;
label define pg323b_label
-1 "keine Angabe"
-2 "trifft nicht zu", replace;
label define pg324a_label
-1 "keine Angabe"
-2 "trifft nicht zu"
1 "ja"
2 "nein", replace;
label define pg324b_label
-1 "keine Angabe"
-2 "trifft nicht zu", replace;
label define pg325a_label
-1 "keine Angabe"
-2 "trifft nicht zu"
1 "ja"
2 "nein", replace;
label define pg325b_label
-1 "keine Angabe"
-2 "trifft nicht zu", replace;
label define pg326a_label
-1 "keine Angabe"
-2 "trifft nicht zu"
1 "ja"
2 "nein", replace;
label define pg326b_label
-1 "keine Angabe"
-2 "trifft nicht zu", replace;
label define pg331a_label
-1 "keine Angabe"
-2 "trifft nicht zu"
1 "ja"
2 "nein", replace;
label define pg331b_label
-1 "keine Angabe"
-2 "trifft nicht zu", replace;
label define pg332a_label
-1 "keine Angabe"
-2 "trifft nicht zu"
1 "ja"
2 "nein", replace;
label define pg332b_label
-1 "keine Angabe"
-2 "trifft nicht zu", replace;
label define pg333a_label
-1 "keine Angabe"
-2 "trifft nicht zu"
1 "ja"
2 "nein", replace;
label define pg333b_label
-1 "keine Angabe"
-2 "trifft nicht zu", replace;
label define pg334a_label
-1 "keine Angabe"
-2 "trifft nicht zu"
1 "ja"
2 "nein", replace;
label define pg334b_label
-1 "keine Angabe"
-2 "trifft nicht zu", replace;
label define pg335a_label
-1 "keine Angabe"
-2 "trifft nicht zu"
1 "ja"
2 "nein", replace;
label define pg335b_label
-1 "keine Angabe"
-2 "trifft nicht zu", replace;
label define pg336a_label
-1 "keine Angabe"
-2 "trifft nicht zu"
1 "ja"
2 "nein", replace;
label define pg336b_label
-1 "keine Angabe"
-2 "trifft nicht zu", replace;
label define pg337a_label
-1 "keine Angabe"
-2 "trifft nicht zu"
1 "ja"
2 "nein", replace;
label define pg337b_label
-1 "keine Angabe"
-2 "trifft nicht zu", replace;
label define pg338a_label
-1 "keine Angabe"
-2 "trifft nicht zu"
1 "ja"
2 "nein", replace;
label define pg338b_label
-1 "keine Angabe"
-2 "trifft nicht zu", replace;
label define pg339a_label
-1 "keine Angabe"
-2 "trifft nicht zu"
1 "ja"
2 "nein", replace;
label define pg339b_label
-1 "keine Angabe"
-2 "trifft nicht zu", replace;
label define pg3310a_label
-1 "keine Angabe"
-2 "trifft nicht zu"
1 "ja"
2 "nein", replace;
label define pg3310b_label
-1 "keine Angabe"
-2 "trifft nicht zu", replace;
label define ph341_label
-1 "keine Angabe"
-2 "trifft nicht zu"
1 "ja"
2 "nein", replace;
label define ph342_label
-1 "keine Angabe"
-2 "trifft nicht zu"
1 "ja"
2 "nein", replace;
label define ph343_label
-1 "keine Angabe"
-2 "trifft nicht zu"
1 "ja"
2 "nein", replace;
label define ph344_label
-1 "keine Angabe"
-2 "trifft nicht zu"
1 "ja"
2 "nein", replace;
label define ph345_label
-1 "keine Angabe"
-2 "trifft nicht zu"
1 "ja"
2 "nein", replace;
label define ph346_label
-1 "keine Angabe"
-2 "trifft nicht zu"
1 "ja"
2 "nein", replace;
label define ph347_label
-1 "keine Angabe"
-2 "trifft nicht zu"
1 "ja"
2 "nein", replace;
label define ph348_label
-1 "keine Angabe"
-2 "trifft nicht zu"
1 "ja"
2 "nein", replace;
label define ph349_label
-1 "keine Angabe"
-2 "trifft nicht zu"
1 "ja"
2 "nein", replace;
label define ph3410_label
-1 "keine Angabe"
-2 "trifft nicht zu"
1 "ja"
2 "nein", replace;
label define ph3411_label
-1 "keine Angabe"
-2 "trifft nicht zu"
1 "ja"
2 "nein", replace;
label define ph3412_label
-1 "keine Angabe"
-2 "trifft nicht zu"
1 "ja"
2 "nein", replace;
label define ph3413_label
-1 "keine Angabe"
-2 "trifft nicht zu"
1 "ja"
2 "nein", replace;
label define ph3414_label
-1 "keine Angabe"
-2 "trifft nicht zu"
1 "ja"
2 "nein", replace;
label define ph35_label
-1 "keine Angabe"
-2 "trifft nicht zu"
1 "unter 3 Std. pro Monat"
2 "3 - 5 Std. pro Monat"
3 "6 - 10 Std. pro Monat"
4 "11 - 20 Std. pro Monat"
5 "21 - 40 Std. pro Monat"
6 "über 40 Std. pro Monat"
7 "Nicht freiwillig engagiert", replace;
label define pi361a_label
-1 "keine Angabe"
-2 "trifft nicht zu"
1 "ja"
2 "nein", replace;
label define pi361b_label
-1 "keine Angabe"
-2 "trifft nicht zu", replace;
label define pi362a_label
-1 "keine Angabe"
-2 "trifft nicht zu"
1 "ja"
2 "nein", replace;
label define pi362b_label
-1 "keine Angabe"
-2 "trifft nicht zu", replace;
label define pi363a_label
-1 "keine Angabe"
-2 "trifft nicht zu"
1 "ja"
2 "nein", replace;
label define pi363b_label
-1 "keine Angabe"
-2 "trifft nicht zu", replace;
label define pi364a_label
-1 "keine Angabe"
-2 "trifft nicht zu"
1 "ja"
2 "nein", replace;
label define pi364b_label
-1 "keine Angabe"
-2 "trifft nicht zu", replace;
label define pi365a_label
-1 "keine Angabe"
-2 "trifft nicht zu"
1 "ja"
2 "nein", replace;
label define pi365b_label
-1 "keine Angabe"
-2 "trifft nicht zu", replace;
label define pi366a_label
-1 "keine Angabe"
-2 "trifft nicht zu"
1 "ja"
2 "nein", replace;
label define pi366b_label
-1 "keine Angabe"
-2 "trifft nicht zu", replace;
label define pi367a_label
-1 "keine Angabe"
-2 "trifft nicht zu"
1 "ja"
2 "nein", replace;
label define pi367b_label
-1 "keine Angabe"
-2 "trifft nicht zu", replace;
label define pi368a_label
-1 "keine Angabe"
-2 "trifft nicht zu"
1 "ja"
2 "nein", replace;
label define pi368b_label
-1 "keine Angabe"
-2 "trifft nicht zu", replace;
label define pi369a_label
-1 "keine Angabe"
-2 "trifft nicht zu"
1 "ja"
2 "nein", replace;
label define pi369b_label
-1 "keine Angabe"
-2 "trifft nicht zu", replace;
label define pi3610a_label
-1 "keine Angabe"
-2 "trifft nicht zu"
1 "ja"
2 "nein", replace;
label define pi3610b_label
-1 "keine Angabe"
-2 "trifft nicht zu", replace;
label define pi3611a_label
-1 "keine Angabe"
-2 "trifft nicht zu"
1 "ja"
2 "nein", replace;
label define pi3611b_label
-1 "keine Angabe"
-2 "trifft nicht zu", replace;
label define pk381_label
-1 "keine Angabe"
-2 "trifft nicht zu"
1 "Völlig ausreichend"
2 "Eher ausreichend"
3 "Teils/teils"
4 "Eher nicht ausreichend"
5 "Gar nicht ausreichend"
9 "für mich nicht zutreffend", replace;
label define pk382_label
-1 "keine Angabe"
-2 "trifft nicht zu"
1 "Völlig ausreichend"
2 "Eher ausreichend"
3 "Teils/teils"
4 "Eher nicht ausreichend"
5 "Gar nicht ausreichend"
9 "für mich nicht zutreffend", replace;
label define pk383_label
-1 "keine Angabe"
-2 "trifft nicht zu"
1 "Völlig ausreichend"
2 "Eher ausreichend"
3 "Teils/teils"
4 "Eher nicht ausreichend"
5 "Gar nicht ausreichend"
9 "für mich nicht zutreffend", replace;
label define pk384_label
-1 "keine Angabe"
-2 "trifft nicht zu"
1 "Völlig ausreichend"
2 "Eher ausreichend"
3 "Teils/teils"
4 "Eher nicht ausreichend"
5 "Gar nicht ausreichend"
9 "für mich nicht zutreffend", replace;
label define pk385_label
-1 "keine Angabe"
-2 "trifft nicht zu"
1 "Völlig ausreichend"
2 "Eher ausreichend"
3 "Teils/teils"
4 "Eher nicht ausreichend"
5 "Gar nicht ausreichend"
9 "für mich nicht zutreffend", replace;
label define pk386_label
-1 "keine Angabe"
-2 "trifft nicht zu"
1 "Völlig ausreichend"
2 "Eher ausreichend"
3 "Teils/teils"
4 "Eher nicht ausreichend"
5 "Gar nicht ausreichend"
9 "für mich nicht zutreffend", replace;
label define pk387_label
-1 "keine Angabe"
-2 "trifft nicht zu"
1 "Völlig ausreichend"
2 "Eher ausreichend"
3 "Teils/teils"
4 "Eher nicht ausreichend"
5 "Gar nicht ausreichend"
9 "für mich nicht zutreffend", replace;
label define pk388_label
-1 "keine Angabe"
-2 "trifft nicht zu"
1 "Völlig ausreichend"
2 "Eher ausreichend"
3 "Teils/teils"
4 "Eher nicht ausreichend"
5 "Gar nicht ausreichend"
9 "für mich nicht zutreffend", replace;
label define pk389_label
-1 "keine Angabe"
-2 "trifft nicht zu"
1 "Völlig ausreichend"
2 "Eher ausreichend"
3 "Teils/teils"
4 "Eher nicht ausreichend"
5 "Gar nicht ausreichend"
9 "für mich nicht zutreffend", replace;
label define pk3810_label
-1 "keine Angabe"
-2 "trifft nicht zu"
1 "Völlig ausreichend"
2 "Eher ausreichend"
3 "Teils/teils"
4 "Eher nicht ausreichend"
5 "Gar nicht ausreichend", replace;
label define pk3811_label
-1 "keine Angabe"
-2 "trifft nicht zu"
1 "Völlig ausreichend"
2 "Eher ausreichend"
3 "Teils/teils"
4 "Eher nicht ausreichend"
5 "Gar nicht ausreichend", replace;
label define pk3812_label
-1 "keine Angabe"
-2 "trifft nicht zu"
1 "Völlig ausreichend"
2 "Eher ausreichend"
3 "Teils/teils"
4 "Eher nicht ausreichend"
5 "Gar nicht ausreichend"
9 "für mich nicht zutreffend", replace;
label define pk3813_label
-1 "keine Angabe"
-2 "trifft nicht zu"
1 "Völlig ausreichend"
2 "Eher ausreichend"
3 "Teils/teils"
4 "Eher nicht ausreichend"
5 "Gar nicht ausreichend"
9 "für mich nicht zutreffend", replace;
label define pk391_label
-1 "keine Angabe"
-2 "trifft nicht zu"
1 "Stimme voll und ganz zu"
2 "Stimme eher zu"
3 "Teils/teils"
4 "Stimme eher nicht zu"
5 "Stimme ganz und gar nicht zu", replace;
label define pk392_label
-1 "keine Angabe"
-2 "trifft nicht zu"
1 "Stimme voll und ganz zu"
2 "Stimme eher zu"
3 "Teils/teils"
4 "Stimme eher nicht zu"
5 "Stimme ganz und gar nicht zu", replace;
label define pk393_label
-1 "keine Angabe"
-2 "trifft nicht zu"
1 "Stimme voll und ganz zu"
2 "Stimme eher zu"
3 "Teils/teils"
4 "Stimme eher nicht zu"
5 "Stimme ganz und gar nicht zu", replace;
label define pk394_label
-1 "keine Angabe"
-2 "trifft nicht zu"
1 "Stimme voll und ganz zu"
2 "Stimme eher zu"
3 "Teils/teils"
4 "Stimme eher nicht zu"
5 "Stimme ganz und gar nicht zu", replace;
label define pk395_label
-1 "keine Angabe"
-2 "trifft nicht zu"
1 "Stimme voll und ganz zu"
2 "Stimme eher zu"
3 "Teils/teils"
4 "Stimme eher nicht zu"
5 "Stimme ganz und gar nicht zu", replace;
label define pk396_label
-1 "keine Angabe"
-2 "trifft nicht zu"
1 "Stimme voll und ganz zu"
2 "Stimme eher zu"
3 "Teils/teils"
4 "Stimme eher nicht zu"
5 "Stimme ganz und gar nicht zu", replace;
label define pk401_label
-1 "keine Angabe"
-2 "trifft nicht zu", replace;
label define pk402a_label
-1 "keine Angabe"
-2 "trifft nicht zu", replace;
label define pk402b_label
-1 "keine Angabe"
-2 "trifft nicht zu", replace;
label define pk402c_label
-1 "keine Angabe"
-2 "trifft nicht zu", replace;
label define pk402d_label
-1 "keine Angabe"
-2 "trifft nicht zu", replace;
label define pk402e_label
-1 "keine Angabe"
-2 "trifft nicht zu", replace;
label define alter_gr1_label
1 "0 bis unter 10 Jahren"
2 "10 bis unter 18 Jahren"
3 "18 bis unter 25 Jahren"
4 "25 bis unter 45 Jahren"
5 "45 bis unter 65 Jahren"
6 "65 Jahre und älter", replace;
label define alter_gr2_label
-2 "trifft nicht zu"
1 "10 bis unter 12 Jahren"
2 "12 bis unter 18 Jahren"
3 "18 bis unter 25 Jahren"
4 "25 bis unter 45 Jahren"
5 "45 bis unter 65 Jahren"
6 "65 Jahre und älter", replace;
label define soz_label
-1 "keine Angabe"
-2 "trifft nicht zu (Person unter 16 Jahren)"
1 "Selbstständiger"
2 "Beamter"
3 "Angestellter, Auszubildender, Freiwilliger Wehrdienst, Freiwilligendienst, Freiwilliges soziales/ökologisches/kulturelles Jahr"
4 "Arbeiter"
5 "Schüler, Student"
6 "Rentner, Pensionär"
7 "Arbeitsloser"
8 "sonstige Nichterwerbstätiger", replace;
label define erw_typ_label
-1 "keine Angabe"
-2 "trifft nicht zu (Person unter 16 Jahren)"
1 "Vollzeit erwerbstätig"
2 "Teilzeit erwerbstätig"
3 "nicht erwerbstätig", replace;
label define isced_label
-1 "keine Angabe"
-2 "trifft nicht zu (Person unter 10 Jahren)"
1 "ISCED 1"
2 "ISCED 2"
3 "ISCED 3"
4 "ISCED 4"
5 "ISCED 5"
6 "ISCED 6", replace;
label define bildung_typ_label
-1 "keine Angabe"
-2 "trifft nicht zu (Person unter 16 Jahren)"
1 "keine, niedrige Bildung (ISCED 1+2)"
2 "mittlere Bildung (ISCED 3+4)"
3 "hohe Bildung (ISCED 5+6)", replace;
label define pf31_typ_label
-1 "keine Angabe"
-2 "trifft nicht zu (Person unter 10 Jahren)"
1 "Kein (oder noch kein) beruflicher Ausbildungsabschluss, Hochschul- oder Fachhochschulabschluss"
2 "Anlernausbildung, berufliches Praktikum, Berufsvorbereitungsjahr"
3 "Lehre, Berufsausbildung, Vorbereitungsdienst für den mittleren Dienst in der öffentlichen Verwaltung,  Berufsfachschule/Kollegschule, 1-jährige Schule des Gesundheitswesens"
4 "2- oder 3-jährige Schule des Gesundheitswesens, Meister, Techniker oder gleichwertiger Fachschulabschluss, Fachakademie"
5 "Fachschule der DDR"
6 "Berufsakademie, Verwaltungs-Fachhochschule, Fachhochschule (auch Ingenieurschule), Universität, wissenschaftl. Abschluss, Kunsthochschule, Promotion", replace;
label define erw_part_label
-1 "keine Angabe"
-2 "trifft nicht zu"
1 "Vollzeit erwerbstätig"
2 "Teilzeit erwerbstätig"
3 "nicht erwerbstätig", replace;

#delimit cr	
   
   
   
*(iii)	Zuweisung der Werte- und Variablenlabels zu den Variablen
	
		
label variable alterx "Alter"
label variable ha3 "Geschlecht"
label variable pa2x "Familienstand"
label variable ha6x "Stellung im Haushalt"
label variable ha71 "Erste Staatsangehörigkeit"
label variable ha8x "Geburtsland"
label variable he181 "Kind wird ausschließlich durch Eltern betreut"
label variable he18_kibetrx "Kinderbetreuung (Betreute Zeit insgesamt durch Tagesmutter/Tagesvater, Krippe, Kindertagesstätte, vorschulische Einrichtungen, Hort)"
label variable he187x "Betreute Zeit durch Verwandte, Freunde, Nachbarn"
label variable he19x "Betreuung Tage pro Woche"
label variable he201 "Kind geht/geht nicht zur Schule"
label variable he202x "Unterrichtsstunden pro Woche (HFB)"
label variable he211 "Teilnahme an AGs (HFB)"
label variable he212x "AG-Stunden pro Woche (HFB)"
label variable he22x "Zeitstunden insgesamt in der Schule pro Woche (HFB)"
label variable he231 "Mittagessen in der Betreuungseinrichtung/Schule"
label variable he232 "Hausaufgabenbetreuung in der Betreuungseinrichtung/Schule"
label variable he233 "Sprachförderung in Deutsch in der Betreuungseinrichtung/"
label variable he234 "Nachhilfe, Förderkurse in der Betreuungseinrichtung/Schule"
label variable he235 "Musikalische Früherziehung in der Betreuungseinrichtung/Schule"
label variable he236 "Kind nimmt keine Angebote wahr in der Betreuungseinrichtung/Schule"
label variable he237 "Sonstige Kurse in der Betreuungseinrichtung/Schule"
label variable he241x "Stunden pro Woche: Sport und Bewegung außerhalb der Betreuungseinrichtung/Schule"
label variable he245x "Stunden pro Woche: Singen, Musikinstrument spielen außerhalb der Betreuungseinrichtung/Schule"
label variable he246x "Stunden pro Woche: Malen, Basteln außerhalb der Betreuungseinrichtung/Schule"
label variable he247x "Stunden pro Woche: Tanzen, Theater spielen außerhalb der Betreuungseinrichtung/Schule"
label variable he248 "Kind nimmt keine Angebote wahr außerhalb der Betreuungseinrichtung/Schule"
label variable he249 "Stunden pro Woche: Sonstiges Angebot außerhalb der Betreuungseinrichtung oder Schule"
label variable pfb_ausgef "Ausgefüllter Personenfragebogen"
label variable pb3 "Lebenssituation"
label variable pb4 "In der letzten Woche mindestens 1 Stunde gegen Bezahlung gearbeitet"
label variable pc5x "Berufliche Stellung in der Haupterwerbstätigkeit"
label variable pc6 "Art des Beschäftigungsverhältnisses in der Haupterwerbstätigkeit"
label variable pc7 "Vollzeit/Teilzeit in der Haupterwerbstätigkeit"
label variable pc8x "Wochenstunden in der Haupterwerbstätigkeit"
label variable pc9x "Wunscharbeitszeit in der Haupterwerbstätigkeit"
label variable pc10 "Geringfügige Beschäftigung in der Haupterwerbstätigkeit"
label variable pc11x "Wirtschaftszweig in der Haupterwerbstätigkeit"
label variable pc121 "Ort der Arbeitsstätte in der Haupterwerbstätigkeit"
label variable pc122x "Kilometer zur Arbeitsstätte in der Haupterwerbstätigkeit"
label variable pc13x "Arbeitsweg in Minuten in der Haupterwerbstätigkeit"
label variable pc14 "Arbeitszeitgestaltung in der Haupterwerbstätigkeit"
label variable pc15 "Schichtarbeit in der Haupterwerbstätigkeit"
label variable pc16_fruehsonstx "Früh-/sonstige Schicht in der Haupterwerbstätigkeit"
label variable pc16_spaetnachtx "Spät-/Nachtschicht in der Haupterwerbstätigkeit"
label variable pc17 "Arbeit von zu Hause aus in der Haupterwerbstätigkeit"
label variable pc18 "Wochenendarbeit in der Haupterwerbstätigkeit"
label variable pd191 "Nebenerwerbstätig"
label variable pd192x "Anzahl der Nebenerwerbstätigkeiten"
label variable pd20 "Monate pro Jahr, an denen Nebenerwerbstätigkeit ausgeübt wird"
label variable pd21x "Tage pro Monat, an denen Nebenerwerbstätigkeit ausgeübt wird"
label variable pd22x "Stunden pro Tag, an denen Nebenerwerbstätigkeit ausgeübt wird"
label variable pe23x "Monatliches Nettoeinkommen aus Haupterwerbstätigkeit und"
label variable pf24 "Schulbesuch"
label variable pf25x "Art der Schule"
label variable pf26x "Unterrichtsstunden pro Woche (PFB)"
label variable pf271 "Teilnahme an AGs (PFB)"
label variable pf272x "AG-Stunden pro Woche (PFB)"
label variable pf28x "Zeitstunden insgesamt in der Schule pro Woche (PFB)"
label variable pf291a "Sport außerhalb der Schule"
label variable pf291bx "Stunden pro Woche: Sport außerhalb der Schule"
label variable pf292a "Sprachförderung in Deutsch außerhalb der Schule"
label variable pf292bx "Stunden pro Woche: Sprachförderung in Deutsch außerhalb der Schule"
label variable pf293a "Sprachförderung  andere Sprache außerhalb der Schule"
label variable pf293bx "Stunden pro Woche: Sprachförderung andere Sprache außerhalb der Schule"
label variable pf294a "Nachhilfe, Förderkurse außerhalb der Schule"
label variable pf294bx "Stunden pro Woche: Nachhilfe, Förderkurse außerhalb der Schule"
label variable pg321a "Kino in den letzten 12 Monaten"
label variable pg321b "Häufigkeit Kino in den letzten 12 Monaten"
label variable pg322a "Theater, Tanz in den letzten 12 Monaten"
label variable pg322b "Häufigkeit Theater, Tanz in den letzten 12 Monaten"
label variable pg323a "Konzert, Oper, Musical in den letzten 12 Monaten"
label variable pg323b "Häufigkeit Konzert, Oper, Musical in den letzten 12 Monaten"
label variable pg324a "Kunstausstellung, Museum in den letzten 12 Monaten"
label variable pg324b "Häufigkeit Kunstausstellung, Museum in den letzten 12 Monaten"
label variable pg325a "Bibliothek, Bücherei in den letzten 12 Monaten"
label variable pg325b "Häufigkeit Bibliothek, Bücherei in den letzten 12 Monaten"
label variable pg326a "Sonstige kulturelle Angebote in den letzten 12 Monaten"
label variable pg326b "Häufigkeit sonstige kulturelle Angebote in den letzten 12 Monaten"
label variable pg331a "Singen"
label variable pg331b "Stunden pro Woche: Singen"
label variable pg332a "Musikinstrument spielen"
label variable pg332b "Stunden pro Woche: Musikinstrument spielen"
label variable pg333a "Malen, Zeichnen, Drucken"
label variable pg333b "Stunden pro Woche: Malen, Zeichnen, Drucken"
label variable pg334a "Werken, Nähen, Töpfern, Goldschmieden, Basteln"
label variable pg334b "Stunden pro Woche: Werken, Nähen, Töpfern, Goldschmieden, Basteln"
label variable pg335a "Tanzen"
label variable pg335b "Stunden pro Woche: Tanzen"
label variable pg336a "Theater spielen"
label variable pg336b "Stunden pro Woche: Theater spielen"
label variable pg337a "Schreiben, Dichten"
label variable pg337b "Stunden pro Woche: Schreiben, Dichten"
label variable pg338a "Filmen, Fotografieren"
label variable pg338b "Stunden pro Woche: Filmen, Fotografieren"
label variable pg339a "Literaturkreis"
label variable pg339b "Stunden pro Woche: Literaturkreis"
label variable pg3310a "Sonstige kulturelle Aktivitäten"
label variable pg3310b "Stunden pro Woche: sonstige kulturelle Aktivitäten"
label variable ph341 "Sport und Bewegung in den letzten 12 Monaten"
label variable ph342 "Kultur und Musik in den letzten 12 Monaten"
label variable ph343 "Schule und Kindergarten in den letzten 12 Monaten"
label variable ph344 "Kirchliche oder religiöse Gesellschaft in den letzten 12 Monaten"
label variable ph345 "Sozialer Bereich in den letzten 12 Monaten"
label variable ph346 "Politik und politische Interessenvertretung in den letzten 12 Monaten"
label variable ph347 "Bürgerschaftliche Aktivität an Ihrem Wohnortin den letzten 12 Monaten"
label variable ph348 "Berufliche Interessenvertretung außerhalb des Betriebes in den letzten 12 Monaten"
label variable ph349 "Umwelt, Naturschutz oder Tierschutz in den letzten 12 Monaten"
label variable ph3410 "Außerschulische Jugendarbeit, Bildungsarbeit für Erwachsene in den letzten 12 Monaten"
label variable ph3411 "Unfall- oder Rettungsdienst oder freiwillige Feuerwehr in den letzten 12 Monaten"
label variable ph3412 "Gesundheit in den letzten 12 Monaten"
label variable ph3413 "Justiz und Innere Sicherheit in den letzten 12 Monaten"
label variable ph3414 "Freizeit und Geselligkeit in den letzten 12 Monaten"
label variable ph35 "Zeitaufwand freiwilliges Engagement"
label variable pi361a "Kinderbetreuung"
label variable pi361b "Stunden pro Woche: Kinderbetreuung"
label variable pi362a "Zubereitung von Mahlzeiten"
label variable pi362b "Stunden pro Woche: Zubereitung von Mahlzeiten"
label variable pi363a "Putzen, Aufräumen, Waschen und Bügeln, Straße fegen"
label variable pi363b "Stunden pro Woche: Putzen, Aufräumen, Waschen und Bügeln, Straße fegen"
label variable pi364a "Nach dem Rechten sehen"
label variable pi364b "Stunden pro Woche: nach dem Rechten sehen"
label variable pi365a "Gartenarbeit"
label variable pi365b "Stunden pro Woche: Gartenarbeit"
label variable pi366a "Einkaufen und Besorgungen"
label variable pi366b "Stunden pro Woche: Einkaufen und Besorgungen"
label variable pi367a "Haustierpflege"
label variable pi367b "Stunden pro Woche: Haustierpflege"
label variable pi368a "Reparatur und Wartung von Fahrzeugen"
label variable pi368b "Stunden pro Woche: Reparatur und Wartung von Fahrzeugen"
label variable pi369a "Reparieren und Bauen"
label variable pi369b "Stunden pro Woche: Reparieren und Bauen"
label variable pi3610a "Versicherungs-, Behördenangelegenheiten"
label variable pi3610b "Stunden pro Woche: Versicherungs-, Behördenangelegenheiten"
label variable pi3611a "Sonstige Unterstützung"
label variable pi3611b "Stunden pro Woche: sonstige Unterstützung"
label variable pk381 "Zeitverwendung in den letzten 4 Wochen für Kinder"
label variable pk382 "Zeitverwendung in den letzten 4 Wochen für (Ehe-)Partner/-in"
label variable pk383 "Zeitverwendung in den letzten 4 Wochen für sonstige Familienangehörige"
label variable pk384 "Zeitverwendung in den letzten 4 Wochen für Freunde, Bekannte"
label variable pk385 "Zeitverwendung in den letzten 4 Wochen für Hausarbeit"
label variable pk386 "Zeitverwendung in den letzten 4 Wochen für Erwerbsarbeit"
label variable pk387 "Zeitverwendung in den letzten 4 Wochen für Ausbildung"
label variable pk388 "Zeitverwendung in den letzten 4 Wochen für Weiterbildung"
label variable pk389 "Zeitverwendung in den letzten 4 Wochen für ehrenamtliche/freiwillige Tätigkeit"
label variable pk3810 "Zeitverwendung in den letzten 4 Wochen für Ausruhen"
label variable pk3811 "Zeitverwendung in den letzten 4 Wochen für persönliche Interessen (Sport, Kultur)"
label variable pk3812 "Zeitverwendung in den letzten 4 Wochen für Arztbesuche"
label variable pk3813 "Zeitverwendung in den letzten 4 Wochen für Besorgungen"
label variable pk391 "Angewiesen, den Tag zu planen"
label variable pk392 "Häufig unter Zeitdruck"
label variable pk393 "Regelmäßig ausschlafen"
label variable pk394 "Mehr Zeit für sich"
label variable pk395 "Mehr Zeit für Familie"
label variable pk396 "Mehr Zeit für Freunde, Bekannte"
label variable pk401 "Wunsch nach mehr Zeit, Anzahl der Aktivitäten"
label variable pk402a "Aktivität 1, für die mehr Zeit gewünscht wird"
label variable pk402b "Aktivität 2, für die mehr Zeit gewünscht wird"
label variable pk402c "Aktivität 3, für die mehr Zeit gewünscht wird"
label variable pk402d "Aktivität 4, für die mehr Zeit gewünscht wird"
label variable pk402e "Aktivität 5, für die mehr Zeit gewünscht wird"
label variable alter_gr1 "6 Altersgruppen"
label variable alter_gr2 "6 Altersgruppen, Personen ab 10 Jahren"
label variable soz "Soziale Stellung"
label variable erw_typ "Erwerbstätigkeit"
label variable isced "ISCED-97-Level"
label variable bildung_typ "Bildung typisiert"
label variable pf31_typ "Höchster beruflicher Ausbildungs- oder Hochschulabschluss typisiert"
label variable erw_part "Erwerbstätigkeit des Partners des Haupteinkommensbeziehers/Lebenspartners"
label variable id_hhx "Haushalts-ID"
label variable id_persx "Personen-ID"
label variable persx "Personennummer"
label variable berichtsjahr "Berichtsjahr"
label variable hrfp80 "Hochrechnungsfaktor * 100 für Personen ab 10 Jahren"
label variable hrfk80 "Hochrechnungsfaktor * 100 für Personen unter 10 Jahren"

label value alterx alterx_label
label value ha3 ha3_label
label value pa2x pa2x_label
label value ha6x ha6x_label
label value ha71 ha71_label
label value ha8x ha8x_label
label value he181 he181_label
label value he18_kibetrx he18_kibetrx_label
label value he187x he187x_label
label value he19x he19x_label
label value he201 he201_label
label value he202x he202x_label
label value he211 he211_label
label value he212x he212x_label
label value he22x he22x_label
label value he231 he231_label
label value he232 he232_label
label value he233 he233_label
label value he234 he234_label
label value he235 he235_label
label value he236 he236_label
label value he237 he237_label
label value he241x he241x_label
label value he245x he245x_label
label value he246x he246x_label
label value he247x he247x_label
label value he248 he248_label
label value he249 he249_label
label value pfb_ausgef pfb_ausgef_label
label value pb3 pb3_label
label value pb4 pb4_label
label value pc5x pc5x_label
label value pc6 pc6_label
label value pc7 pc7_label
label value pc8x pc8x_label
label value pc9x pc9x_label
label value pc10 pc10_label
label value pc11x pc11x_label
label value pc121 pc121_label
label value pc122x pc122x_label
label value pc13x pc13x_label
label value pc14 pc14_label
label value pc15 pc15_label
label value pc16_fruehsonstx pc161_label
label value pc16_spaetnachtx pc162_label
label value pc17 pc17_label
label value pc18 pc18_label
label value pd191 pd191_label
label value pd192x pd192x_label
label value pd20 pd20_label
label value pd21x pd21x_label
label value pd22x pd22x_label
label value pe23x pe23x_label
label value pf24 pf24_label
label value pf25x pf25x_label
label value pf26x pf26x_label
label value pf271 pf271_label
label value pf272x pf272x_label
label value pf28x pf28x_label
label value pf291a pf291a_label
label value pf291bx pf291b_label
label value pf292a pf292a_label
label value pf292bx pf292bx_label
label value pf293a pf293a_label
label value pf293bx pf293bx_label
label value pf294a pf294a_label
label value pf294bx pf294bx_label
label value pg321a pg321a_label
label value pg321b pg321b_label
label value pg322a pg322a_label
label value pg322b pg322b_label
label value pg323a pg323a_label
label value pg323b pg323b_label
label value pg324a pg324a_label
label value pg324b pg324b_label
label value pg325a pg325a_label
label value pg325b pg325b_label
label value pg326a pg326a_label
label value pg326b pg326b_label
label value pg331a pg331a_label
label value pg331b pg331b_label
label value pg332a pg332a_label
label value pg332b pg332b_label
label value pg333a pg333a_label
label value pg333b pg333b_label
label value pg334a pg334a_label
label value pg334b pg334b_label
label value pg335a pg335a_label
label value pg335b pg335b_label
label value pg336a pg336a_label
label value pg336b pg336b_label
label value pg337a pg337a_label
label value pg337b pg337b_label
label value pg338a pg338a_label
label value pg338b pg338b_label
label value pg339a pg339a_label
label value pg339b pg339b_label
label value pg3310a pg3310a_label
label value pg3310b pg3310b_label
label value ph341 ph341_label
label value ph342 ph342_label
label value ph343 ph343_label
label value ph344 ph344_label
label value ph345 ph345_label
label value ph346 ph346_label
label value ph347 ph347_label
label value ph348 ph348_label
label value ph349 ph349_label
label value ph3410 ph3410_label
label value ph3411 ph3411_label
label value ph3412 ph3412_label
label value ph3413 ph3413_label
label value ph3414 ph3414_label
label value ph35 ph35_label
label value pi361a pi361a_label
label value pi361b pi361b_label
label value pi362a pi362a_label
label value pi362b pi362b_label
label value pi363a pi363a_label
label value pi363b pi363b_label
label value pi364a pi364a_label
label value pi364b pi364b_label
label value pi365a pi365a_label
label value pi365b pi365b_label
label value pi366a pi366a_label
label value pi366b pi366b_label
label value pi367a pi367a_label
label value pi367b pi367b_label
label value pi368a pi368a_label
label value pi368b pi368b_label
label value pi369a pi369a_label
label value pi369b pi369b_label
label value pi3610a pi3610a_label
label value pi3610b pi3610b_label
label value pi3611a pi3611a_label
label value pi3611b pi3611b_label
label value pk381 pk381_label
label value pk382 pk382_label
label value pk383 pk383_label
label value pk384 pk384_label
label value pk385 pk385_label
label value pk386 pk386_label
label value pk387 pk387_label
label value pk388 pk388_label
label value pk389 pk389_label
label value pk3810 pk3810_label
label value pk3811 pk3811_label
label value pk3812 pk3812_label
label value pk3813 pk3813_label
label value pk391 pk391_label
label value pk392 pk392_label
label value pk393 pk393_label
label value pk394 pk394_label
label value pk395 pk395_label
label value pk396 pk396_label
label value pk401 pk401_label
label value pk402a pk402a_label
label value pk402b pk402b_label
label value pk402c pk402c_label
label value pk402d pk402d_label
label value pk402e pk402e_label
label value alter_gr1 alter_gr1_label
label value alter_gr2 alter_gr2_label
label value soz soz_label
label value erw_typ erw_typ_label
label value isced isced_label
label value bildung_typ bildung_typ_label
label value pf31_typ pf31_typ_label
label value erw_part erw_part_label	


/* (iv): Speichern */

compress
save "${pfad2}\${dateiname2}", replace
clear

*********************************************************************************************************************************
*********************************************************************************************************************************		

*********************************************************************************************************************************
*********************************************************************************************************************************		

		
*(IV) ZVE 13 sum


		*(i) 	Einlesen CSV-Datei
clear
		
/* Einlesen für STATA 12 und darunter */
if ${stata_version} < 13 {
	insheet using "${pfad3}\${CSVdatei3}", names delimiter(";")
	}
	
/* Einlesen für STATA 13 */
if ${stata_version} >= 13 {
	import delimited "${pfad3}\${CSVdatei3}", delimiter(";") varnames(1)
	}
	
        * (ii)	Definition der Wertelabels, die temporär in WORK gespeichert werden
#delimit;
		
label define tc1ax_label
-2 "trifft nicht zu", replace;

label define tc1bx_label
-2 "trifft nicht zu", replace;

label define tc1cx_label
-2 "trifft nicht zu", replace;

label define tc1cx_label
-2 "trifft nicht zu", replace;

label define tc2ax_label
-2 "trifft nicht zu", replace;

label define tc2bx_label
-2 "trifft nicht zu", replace;

label define tc2cx_label
-2 "trifft nicht zu", replace;	

label define tc3ax_label
-2 "trifft nicht zu", replace;

label define tc3bx_label
-2 "trifft nicht zu", replace;

label define tc3cx_label
-2 "trifft nicht zu", replace;	
				
label define tc4_label
-1 "keine Angabe"
1  "normal"
2  "ungewöhnlich", replace;				

label define tc5_label
-1 "keine Angabe"
1 "keine Reise"
2 "Tagesreise"
3 "Reise mit Übernachtung", replace;

label define tc6_label
-1 "keine Angabe"
1 "über den Tag verteilt"
2 "am Ende des Tages"
3 "am Tag danach"
4 "mehrere Tage später", replace;

label define tc7_label
-1 "keine Angabe"
1 "ja"
2 "nein", replace;				

label define tc8_label
-2 "trifft nicht zu"
-1 "keine Angabe"
1 "ja"
2 "nein", replace;

label define wtagfei
1 "Montag"
2 "Dienstag"
3 "Mittwoch"
4 "Donnerstag"
5 "Freitag"
6 "Samstag/Heiligabend/Silvester"
7 "Sonntag/Feiertag", replace;

label define fehl_tag_label
0 "Person hat 3 Tagebuchtage ausgefüllt"
1 "Tag 1 fehlt"
2 "Tag 2 fehlt"
3 "Tag 3 fehlt", replace;

label define quartal_label
1 "1. Quartal"
2 "2. Quartal"
3 "3. Quartal"
4 "4. Quartal", replace;

label define selbtag_label
-2 "trifft nicht zu"
1 "ja"
2 "nein", replace;

#delimit cr	


     	* (iii)	Zuweisung der Werte- und Variablenlabels zu den Variablen
	
label variable id_hhx "Haushalts-ID"
label variable id_persx "Personen-ID"
label variable id_tagx "Tag-ID"
label variable persx "Personennummer"
label variable tagnr "Anschreibetag"
label variable berichtsjahr "Berichtsjahr"
label variable ha_1 "1 Persönlicher Bereich/Physiologische Regeneration (HA)"
label variable ha_2 "2 Erwerbstätigkeit (HA)"
label variable ha_3 "3 Qualifikation/Bildung (HA)"
label variable ha_4 "4 Haushaltsführung und Betreuung der Familie (HA)"
label variable ha_5 "5 Ehrenamt/Freiwilligenarbeit etc. (HA)"
label variable ha_6 "6 Soziales Leben/Unterhaltung (HA)"
label variable ha_7 "7 Sport/Hobbys/Spiele (HA)"
label variable ha_8 "8 Mediennutzung (HA)"
label variable ha_9 "9 Zweckbestimmte Wegezeiten/Hilfscodes (HA)"
label variable hainklweg_1 "1 Persönlicher Bereich/Physiologische Regeneration inkl. Wegezeit (HA)"
label variable hainklweg_2 "2 Erwerbstätigkeit inkl. Wegezeit (HA)"
label variable hainklweg_3 "3 Qualifikation/Bildung inkl. Wegezeit (HA)"
label variable hainklweg_4 "4 Haushaltsführung und Betreuung der Familie inkl. Wegezeit (HA)"
label variable hainklweg_5 "5 Ehrenamt/Freiwilligenarbeit etc. inkl. Wegezeit (HA)"
label variable hainklweg_6 "6 Soziales Leben/Unterhaltung inkl. Wegezeit (HA)"
label variable hainklweg_7 "7 Sport/Hobbys/Spiele inkl. Wegezeit (HA)"
label variable hainklweg_8 "8 Mediennutzung inkl. Wegezeit (HA)"
label variable ha_11 "11 Schlafen (HA)"
label variable ha_12 "12 Essen und Trinken (HA)"
label variable ha_13 "13 Andere Tätigkeiten pers. Bereich (HA)"
label variable ha_21 "21 Haupterwerbstätigkeit (HA)"
label variable ha_22 "22 Nebenerwerbstätigkeit (HA)"
label variable ha_23 "23 Erwerbstätigkeit ohne Unterteilung (HA)"
label variable ha_24 "24 Andere Akt. Erwerbstätigkeit (HA)"
label variable ha_31 "31 Unterricht in der Schule (HA)"
label variable ha_32 "32 Betreuung in der Schule (HA)"
label variable ha_33 "33 AGs (HA)"
label variable ha_34 "34 Hochschule (HA)"
label variable ha_35 "35 Vor-/Nachbereitungen Lehrveranstaltungen (HA)"
label variable ha_36 "36 Andere Akt. Qualifikation/Bildung (HA)"
label variable ha_41 "41 Zubereitung von Mahlzeiten/Küche (HA)"
label variable ha_42 "42 Instanthaltung v. Haus/Wohnung (HA)"
label variable ha_43 "43 Textilien (HA)"
label variable ha_44 "44 Pflanzen-/Tierpflege (HA)"
label variable ha_45 "45 Bauen/Handwerk (HA)"
label variable ha_46 "46 Einkaufen/Fremdleistungen (HA)"
label variable ha_47 "47 Kinderbetreuung (HA)"
label variable ha_48 "48 Unterstützung/Pflege erw. HH-Mitglieder (HA)"
label variable ha_49 "49 Andere Akt. Haushaltsführung/Familie (HA)"
label variable ha_51 "51 Ehrenamt/Freiwilliges Engagement (HA)"
label variable ha_52 "52 Unterstützung für andere Haushalte (HA)"
label variable ha_53 "53 Teilnahme an Versammlungen (HA)"
label variable ha_61 "61 Soziale Kontakte (HA)"
label variable ha_62 "62 Unterhaltung und Kultur (HA)"
label variable ha_63 "63 Ausruhen/Auszeit/Zeit überbrücken (HA)"
label variable ha_64 "64 Andere Akt. Soziales Leben/Unterhaltung (HA)"
label variable ha_71 "71 Körperliche Bewegung (HA)"
label variable ha_73 "73 Rüstzeiten sportliche Aktivitäten (HA)"
label variable ha_74 "74 Kunst/Musizieren (HA)"
label variable ha_75 "75 Sonstige Hobbies (HA)"
label variable ha_76 "76 Spiele (HA)"
label variable ha_79x "79x Sport ohne nähere Bezeichnung (HA)"
label variable ha_81 "81 Lesen (HA)"
label variable ha_82 "82 Fernsehen und Video/DVD (HA)"
label variable ha_83 "83 Radio/Musik hören (HA)"
label variable ha_84 "84 Computer/Smartphone (HA)"
label variable ha_92 "92 Wegezeiten Erwerbstätigkeit (HA)"
label variable ha_93 "93 Wegezeiten Qualifikation/Bildung (HA)"
label variable ha_94 "94 Wegezeiten Haushaltsführung/Familie (HA)"
label variable ha_95 "95 Wegezeiten Ehrenamt/Freiwilligenarbeit etc. (HA)"
label variable ha_96 "96 Wegezeiten Soziales Leben/Unterhaltung (HA)"
label variable ha_97 "97 Wegezeiten Sport/Hobbys/Spiele (HA)"
label variable ha_98 "98 Wegezeiten Mediennutzung (HA)"
label variable ha_99 "99 Andere Wegezeiten/Hilfscodes (HA)"
label variable ha_110 "110 Schlafen (HA)"
label variable ha_120 "120 Essen und Trinken (HA)"
label variable ha_131 "131 Waschen und anziehen (HA)"
label variable ha_132 "132 Krank im Bett/Krank (HA)"
label variable ha_139 "139 Sonstige Aktivitäten pers. Bereich (HA)"
label variable ha_210 "210 Haupterwerbstätigkeit (HA)"
label variable ha_220 "220 Nebenerwerbstätigkeit (HA)"
label variable ha_230 "230 Erwerbstätigkeit ohne Unterteilung (HA)"
label variable ha_241 "241 Qualifizierung/Weiterbildung für Beruf (HA)"
label variable ha_242 "242 Arbeitssuche (HA)"
label variable ha_243 "243 Erwerbstätigkeit anderer: unbezahlte Arbeit (HA)"
label variable ha_244 "244 Praktikum im Rahmen einer Erwerbstätigkeit (HA)"
label variable ha_245 "245 Pause während der Arbeit ohne Unterteilung (HA)"
label variable ha_249 "249 Sonstige Aktivitäten Erwerbstätigkeit (HA)"
label variable ha_311 "311 Deutsch (HA)"
label variable ha_312 "312 Fremdsprache (HA)"
label variable ha_313 "313 Mathematik/NatWi/etc (HA)"
label variable ha_314 "314 Kunst/Musik (HA)"
label variable ha_315 "315 Gesellschaftswissenschaften (HA)"
label variable ha_317 "317 Sport (HA)"
label variable ha_319x "319 Sonstige Unterrichtsfächer (HA)"
label variable ha_321 "321 Angebote der Schule zur Vor-/Nachbereitung (HA)"
label variable ha_329 "329 Sonstige Betreuungsangebote Schule (HA)"
label variable ha_330x "330 AGs (HA) "
label variable ha_341 "341 Lehrveranstaltungen Hochschule (HA)"
label variable ha_349 "349 Sonstige Aktivitäten im Bereich Hochschule (HA)"
label variable ha_353 "353 Vor-/Nachbereitung Lehrveranstaltungen (HA)"
label variable ha_354x "354 Hausaufgaben/Selbstlernen für die Schule/Private Nachhilfe (HA)"
label variable ha_361 "361 Qualifikation außerhalb der Arbeitszeit (HA)"
label variable ha_362 "362 Pausen in der Schule (HA)"
label variable ha_363 "363 Freistunden/Leerlaufzeiten in der Schule (HA)"
label variable ha_364 "364 Pausen Hochschule (HA)"
label variable ha_369 "369 Sonstige Aktivitäten Qualifikation/Bildung (HA)"
label variable ha_411 "411 Mahlzeiten vor- und zubereiten (HA)"
label variable ha_412 "412 Backen (HA)"
label variable ha_413 "413 Geschirreinigung, Tisch decken/abräumen (HA)"
label variable ha_414 "414 Konservieren von Lebensmitteln (HA)"
label variable ha_419 "419 Sonstige Aktivitäten Zubereitung von Mahlzeiten (HA)"
label variable ha_421 "421 Reinigung/Aufräumen der Wohnung (HA)"
label variable ha_422 "422 Reinigung Hof/Keller/Garage, Abfallbeseitigung (HA)"
label variable ha_423 "423 Heizen (HA)"
label variable ha_429 "429 Sonstige Aktivitäten Instandhaltung Haus/Wohnung (HA)"
label variable ha_431 "431 Wäsche waschen (HA)"
label variable ha_432 "432 Bügeln und mangeln (HA)"
label variable ha_433 "433 Herstellung von Textilien (HA)"
label variable ha_434 "434 Ausbessern/Umändern Textilien (HA)"
label variable ha_439 "439 Sonstige Aktivitäten Textilien (HA)"
label variable ha_441 "441 Pflanzenpflege draußen (HA)"
label variable ha_442 "442 Pflanzenpflege drinnen (HA)"
label variable ha_443 "443 Pflanzenpflege ohne Ort (HA)"
label variable ha_444 "444 Nutztierpflege (HA)"
label variable ha_445 "445 Haustierpflege (HA)"
label variable ha_446 "446 Hund spazieren führen (HA)"
label variable ha_449 "449 Sonstige Pflanzen-/Tierpflege (HA)"
label variable ha_451 "451 Hausbau und Instandhaltung (HA)"
label variable ha_452 "452 Wohnungsreparaturen, Renovierung (HA)"
label variable ha_453 "453 Herstellung/Wartung/Repar. Ausstattungsgegenstände (HA)"
label variable ha_454 "454 Wartung/kl. Rep. Haushaltsgegenständen (HA)"
label variable ha_455 "455 Fahrzeugreparatur/-pflege (HA)"
label variable ha_459 "459 Sonstige Aktivitäten Bauen/Handwerk (HA)"
label variable ha_461 "461 Einkaufen (ohne Telefon/Internet) (HA)"
label variable ha_464 "464 Behördengang/Dienstleistung/ Verwaltung (HA)"
label variable ha_465 "465 personengebundene Dienstleistungen (HA)"
label variable ha_466 "466 Medizinische Dienste (HA)"
label variable ha_469 "469 Sonstige Aktivitäten Einkaufen/Fremdleistungen (HA)"
label variable ha_471 "471 Körperpflege/Beaufsichtigung Kind (HA)"
label variable ha_472 "472 Hausaufgabenbetreuung/Anleitungen Kind (HA)"
label variable ha_473 "473 Spielen/Sport Kind (HA)"
label variable ha_474 "474 Gespräche Kind (HA)"
label variable ha_475 "475 Begleiten/Termine mit Kind (HA)"
label variable ha_476 "476 Kind vorlesen/erzählen (HA)"
label variable ha_479 "479 Sonstige Aktivitäten Kinderbetreuung (HA)"
label variable ha_480 "480 Unterstützung/Pflege erw. HHmitglieder (HA)"
label variable ha_491 "491 Rüsttätigkeiten im Haushalt (HA)"
label variable ha_492 "492 Haushaltsplanung (auch Internet/Telefon) (HA)"
label variable ha_499 "499 Sonstige Aktivitäten Haushaltsführung/Familie (HA)"
label variable ha_510 "510 Ehrenamt/Freiwilliges Engagement (HA)"
label variable ha_520 "520 Unterstützung für andere Haushalte (HA)"
label variable ha_531 "531 Politische und soziale Versammlungen (HA)"
label variable ha_532 "532 religiöse Aktivitäten (HA)"
label variable ha_539 "539 Sonstige Aktivitäten Versammlungen (HA)"
label variable ha_611 "611 Gespräche (HA)"
label variable ha_612 "612 Telefonate (auch SMS) (HA)"
label variable ha_621 "621 Kino (HA)"
label variable ha_622 "622 Theater/Konzerte/Oper/Musical (HA)"
label variable ha_623 "623 Kunstausstellungen/Museen (HA)"
label variable ha_624 "624 Bibliotheken (HA)"
label variable ha_625 "625 Sportveranstaltungen (HA)"
label variable ha_626 "626 Ausflüge/Zoo/Vergnügungsparks (HA)"
label variable ha_627 "627 Ausgehen (HA)"
label variable ha_629 "629 Sonstige Unterhaltung/Kultur (HA)"
label variable ha_630 "630 Ausruhen/Auszeit/Zeit überbrücken (HA)"
label variable ha_641 "641 Besuch (HA)"
label variable ha_642 "642 Familienfeiern/Feste privater Art (HA)"
label variable ha_649 "649 Sonstige Aktivitäten Soziales Leben/ Unterhaltung (HA)"
label variable ha_711 "711 Spazieren gehen (HA)"
label variable ha_712 "712 Joggen/Nordic Walking/Wandern (HA)"
label variable ha_713 "713 Radsport und Skaten (HA)"
label variable ha_715 "715 Ballspiele (HA)"
label variable ha_716 "716 Gymnastik/Fitness/Tanzen (HA)"
label variable ha_717 "717 Wassersport (HA)"
label variable ha_719x "719 Sonstige Körperliche Bewegung (HA)"
label variable ha_730 "730 Rüstzeiten für sportliche Aktivitäten (HA)"
label variable ha_740 "740 Kunst/Musizieren (HA)"
label variable ha_752 "752 Korrespondenz (außer Computer/Handy) (HA)"
label variable ha_759x "759 Sonstige Hobbys (HA)"
label variable ha_761 "761 Gesellschaftsspiele/Spiel miteinander (HA)"
label variable ha_762 "762 Spiele allein, Glücksspiele (HA)"
label variable ha_763 "763 Computerspiele (HA)"
label variable ha_769 "769 Sonstige Spiele (HA)"
label variable ha_790x "790 Sport ohne nähere Bezeichnung (HA)"
label variable ha_811 "811 Zeitungen lesen (auch elektronisch) (HA)"
label variable ha_812 "812 Zeitschriften lesen (auch elektronisch) (HA)"
label variable ha_813 "813 Bücher lesen (auch elektronisch) (HA)"
label variable ha_814 "814 Zuhören beim Vorlesen (HA)"
label variable ha_815 "815 Sonstiges lesen (auch elektronisch) (HA)"
label variable ha_819 "819 Lesen ohne nähere Bezeichnung (HA)"
label variable ha_820 "820 Fernsehen und Video/DVD (HA)"
label variable ha_830 "830 Radio, Musik hören (HA)"
label variable ha_841 "841 Programmierung/Reparatur Computer/ Smartphone (HA)"
label variable ha_842 "842 Informieren durch Computer/Smartphone (HA)"
label variable ha_843 "843 Kommunikation über Computer/ Smartphone (HA)"
label variable ha_844 "844 Sonstige Aktivitäten Computer/Smartphone (HA)"
label variable ha_849 "849 nicht näher bez. Akt. Computer/ Smartphone (HA)"
label variable ha_921 "921 Wegezeiten Haupterwerbstätigkeit (HA)"
label variable ha_922 "922 Wegezeiten Nebenerwerbstätigkeit (HA)"
label variable ha_923 "923 Wegezeiten Erwerbstätigkeit o. Unterteilung (HA)"
label variable ha_929 "929 Andere Wegezeiten Erwerbstätigkeit (24) (HA)"
label variable ha_931 "931 Wegezeiten Schule (31-33) (HA)"
label variable ha_934 "934 Wegezeiten Hochschule (34-35) (HA)"
label variable ha_939 "939 Andere Wegezeiten Qualifikation/Bildung (36) (HA)"
label variable ha_941 "941 Wegezeiten Haushalt, Pflanzen, Tiere (41-44) (HA)"
label variable ha_945 "945 Wegezeiten Bauen/handwerkliche Tätigkeiten (HA)"
label variable ha_946 "946 Wegezeiten Einkaufen, Fremdleistungen (HA)"
label variable ha_947 "947 Wegezeiten Kinderbetreuung (HA)"
label variable ha_948 "948 Wegezeiten Unterstützung erwachsener HH-Mitglieder (HA)"
label variable ha_949 "949 Wegezeiten Andere Akt. Haushalt/Familie (HA)"
label variable ha_951 "951 Wegezeiten Ehrenamt/Freiwilliges Engagement (HA)"
label variable ha_952 "952 Wegezeiten Unterstützung anderer Haushalte (HA)"
label variable ha_953 "953 Wegezeiten Teilnahme an Versammlungen (HA)"
label variable ha_959 "959 Andere Wege Engagement, Unterstützung, Versammlung (HA)"
label variable ha_961 "961 Wegezeiten Soziale Kontakte (HA)"
label variable ha_962 "962 Wegezeiten Unterhaltung/Kultur (HA)"
label variable ha_969 "969 Andere Wege Soz. Leben/Unterhaltung (63-64) (HA)"
label variable ha_970 "970 Wegezeiten Sport/Hobbys/Spiele (HA)"
label variable ha_980 "980 Wegezeiten Mediennutzung (HA)"
label variable ha_991 "991 Wegezeiten Reisen (HA)"
label variable ha_992 "992 Andere/unspezifizierte Wegezeiten (HA)"
label variable ha_997 "997 Ausfüllen des Tagebuchs (HA)"
label variable ha_998 "998 Nicht bestimmt verwendete Freizeit (HA)"
label variable ha_999 "999 Unbestimmte Zeitverwendung (keine Angabe) (HA)"
label variable tc1x "Anzahl der Nennungen zu größte Freude"
label variable tc1ax "Aktivitätscode größte Freude 1"
label variable tc1bx "Aktivitätscode größte Freude 2"
label variable tc1cx "Aktivitätscode größte Freude 3"
label variable tc2x "Anzahl der Nennungen zu mehr Zeit"
label variable tc2ax "Aktivitätscode mehr Zeit 1"
label variable tc2bx "Aktivitätscode mehr Zeit 2"
label variable tc2cx "Aktivitätscode mehr Zeit 3"
label variable tc3x "Anzahl der Nennungen zu keine Freude"
label variable tc3ax "Aktivitätscode keine Freude 1"
label variable tc3bx "Aktivitätscode keine Freude 2"
label variable tc3cx "Aktivitätscode keine Freude 3"
label variable tc4 "Besonderheiten des Tages"
label variable tc5 "Reise"
label variable tc6 "Häufigkeit der Anschreibungen"
label variable tc7 "Zu Hause zu Beginn des Tages"
label variable tc8 "Zu Hause am Ende des Tages"
label variable wtagfei "Wochentag, Feiertage berücksichtigt"
label variable fehl_tag "Fehlender Tag"
label variable quartal "Kalenderquartal des Ausfülldatums"
label variable jahr "Jahr des Ausfülldatums"
label variable selbtag "Datum des Tagebuchtages ist für alle Personen des Haushalts identisch"
label variable hrft80 "Hochrechnungsfaktor für den Tag multipliziert mit 100"

label value tc1ax tc1ax_label
label value tc1bx tc1bx_label
label value tc1cx tc1cx_label
label value tc2ax tc2ax_label
label value tc2bx tc2bx_label
label value tc2cx tc2cx_label
label value tc3ax tc3ax_label
label value tc3bx tc3bx_label
label value tc3cx tc3cx_label
label value tc4 tc4_label
label value tc5 tc5_label
label value tc6 tc6_label
label value tc7 tc7_label
label value tc8 tc8_label
label value wtagfei wtagfei_label
label value fehl_tag fehl_tag_label
label value quartal quartal_label
label value selbtag selbtag_label
	
/* (iv): Speichern */

compress
save "${pfad3}\${dateiname3}", replace
clear

*********************************************************************************************************************************
*********************************************************************************************************************************

*(V) ZVE 13 takt


		*(i) 	Einlesen CSV-Datei
clear

/* Einlesen für STATA 12 und darunter */
if ${stata_version} < 13 {
	insheet using "${pfad4}\${CSVdatei4}", names delimiter(";")
	}
	
/* Einlesen für STATA 13 */
if ${stata_version} >= 13 {
	import delimited "${pfad4}\${CSVdatei4}", delimiter(";") varnames(1)		
	}
	

*(ii)	Definition der Wertelabels
#delimit;
		
label define tb2_1_label
0 "keine Nebenaktivität", replace;
label define tb3_1_label
-1 "keine Angabe"
0 "keine Wegezeit"
11 "zu Fuß"
12 "Fahrrad"
14 "PKW"
15 "LKW/Kleinbus"
19 "Sonst. privates Verkehrsmittel"
22 "Bus/Reisebus"
23 "Straßenbahn/U-Bahn"
24 "Zug/S-Bahn"
29 "Sonst. öffentliches Verkehrsmittel", replace;
label define tb4_1_label
0 "nein"
1 "ja", replace;
label define tb5_1_label
0 "nein"
1 "ja", replace;
label define tb6_1_label
0 "nein"
1 "ja", replace;
label define tb7_1_label
0 "nein"
1 "ja", replace;
label define tb8_1_label
0 "nein"
1 "ja", replace;
label define tb9_1_label
0 "nein"
1 "ja", replace;
label define tc1ax_label
-2 "trifft nicht zu", replace;
label define tc1bx_label
-2 "trifft nicht zu", replace;
label define tc1cx_label
-2"trifft nicht zu", replace;
label define tc2ax_label
-2"trifft nicht zu", replace;
label define tc2bx_label
-2"trifft nicht zu", replace;
label define tc2cx_label
-2"trifft nicht zu", replace;
label define tc3ax_label
-2"trifft nicht zu", replace;
label define tc3bx_label
-2"trifft nicht zu", replace;
label define tc3cx_label
-2"trifft nicht zu", replace;
label define tc4_label
-1 "keine Angabe"
1 "normal"
2 "ungewöhnlich", replace;
label define tc5_label
-1 "keine Angabe"
1 "keine Reise"
2 "Tagesreise"
3 "Reise mit Übernachtung", replace;
label define tc6_label
-1 "keine Angabe"
1 "über den Tag verteilt"
2 "am Ende des Tages"
3 "am Tag danach"
4 "mehrere Tage später", replace;
label define tc7_label
-1 "keine Angabe"
1 "ja"
2 "nein", replace;
label define tc8_label
-2 "trifft nicht zu"
-1 "keine Angabe"
1 "ja"
2 "nein", replace;
label define wtagfei_label
1 "Montag"
2 "Dienstag"
3 "Mittwoch"
4 "Donnerstag"
5 "Freitag"
6 "Samstag/Heiligabend/Silvester"
7 "Sonntag/Feiertag", replace;
label define fehl_tag_label
0 "Person hat 3 Tagebuchtage ausgefüllt"
1 "Tag 1 fehlt"
2 "Tag 2 fehlt"
3 "Tag 3 fehlt", replace;
label define quartal_label
1 "1. Quartal"
2 "2. Quartal"
3 "3. Quartal"
4 "4. Quartal", replace;
label define selbtag_label
-2 "trifft nicht zu"
1 "ja"
2 "nein", replace;

#delimit cr
     			
	
*(iii)	Zuweisung der Werte- und Variablenlabels zu den Variablen
	
label variable   tb1_1 "Hauptaktivität 04:00-04:10"
label variable   tb1_2 "Hauptaktivität 04:10-04:20"
label variable   tb1_3 "Hauptaktivität 04:20-04:30"
label variable   tb1_4 "Hauptaktivität 04:30-04:40"
label variable   tb1_5 "Hauptaktivität 04:40-04:50"
label variable   tb1_6 "Hauptaktivität 04:50-05:00"
label variable   tb1_7 "Hauptaktivität 05:00-05:10"
label variable   tb1_8 "Hauptaktivität 05:10-05:20"
label variable   tb1_9 "Hauptaktivität 05:20-05:30"
label variable   tb1_10 "Hauptaktivität 05:30-05:40"
label variable   tb1_11 "Hauptaktivität 05:40-05:50"
label variable   tb1_12 "Hauptaktivität 05:50-06:00"
label variable   tb1_13 "Hauptaktivität 06:00-06:10"
label variable   tb1_14 "Hauptaktivität 06:10-06:20"
label variable   tb1_15 "Hauptaktivität 06:20-06:30"
label variable   tb1_16 "Hauptaktivität 06:30-06:40"
label variable   tb1_17 "Hauptaktivität 06:40-06:50"
label variable   tb1_18 "Hauptaktivität 06:50-07:00"
label variable   tb1_19 "Hauptaktivität 07:00-07:10"
label variable   tb1_20 "Hauptaktivität 07:10-07:20"
label variable   tb1_21 "Hauptaktivität 07:20-07:30"
label variable   tb1_22 "Hauptaktivität 07:30-07:40"
label variable   tb1_23 "Hauptaktivität 07:40-07:50"
label variable   tb1_24 "Hauptaktivität 07:50-08:00"
label variable   tb1_25 "Hauptaktivität 08:00-08:10"
label variable   tb1_26 "Hauptaktivität 08:10-08:20"
label variable   tb1_27 "Hauptaktivität 08:20-08:30"
label variable   tb1_28 "Hauptaktivität 08:30-08:40"
label variable   tb1_29 "Hauptaktivität 08:40-08:50"
label variable   tb1_30 "Hauptaktivität 08:50-09:00"
label variable   tb1_31 "Hauptaktivität 09:00-09:10"
label variable   tb1_32 "Hauptaktivität 09:10-09:20"
label variable   tb1_33 "Hauptaktivität 09:20-09:30"
label variable   tb1_34 "Hauptaktivität 09:30-09:40"
label variable   tb1_35 "Hauptaktivität 09:40-09:50"
label variable   tb1_36 "Hauptaktivität 09:50-10:00"
label variable   tb1_37 "Hauptaktivität 10:00-10:10"
label variable   tb1_38 "Hauptaktivität 10:10-10:20"
label variable   tb1_39 "Hauptaktivität 10:20-10:30"
label variable   tb1_40 "Hauptaktivität 10:30-10:40"
label variable   tb1_41 "Hauptaktivität 10:40-10:50"
label variable   tb1_42 "Hauptaktivität 10:50-11:00"
label variable   tb1_43 "Hauptaktivität 11:00-11:10"
label variable   tb1_44 "Hauptaktivität 11:10-11:20"
label variable   tb1_45 "Hauptaktivität 11:20-11:30"
label variable   tb1_46 "Hauptaktivität 11:30-11:40"
label variable   tb1_47 "Hauptaktivität 11:40-11:50"
label variable   tb1_48 "Hauptaktivität 11:50-12:00"
label variable   tb1_49 "Hauptaktivität 12:00-12:10"
label variable   tb1_50 "Hauptaktivität 12:10-12:20"
label variable   tb1_51 "Hauptaktivität 12:20-12:30"
label variable   tb1_52 "Hauptaktivität 12:30-12:40"
label variable   tb1_53 "Hauptaktivität 12:40-12:50"
label variable   tb1_54 "Hauptaktivität 12:50-13:00"
label variable   tb1_55 "Hauptaktivität 13:00-13:10"
label variable   tb1_56 "Hauptaktivität 13:10-13:20"
label variable   tb1_57 "Hauptaktivität 13:20-13:30"
label variable   tb1_58 "Hauptaktivität 13:30-13:40"
label variable   tb1_59 "Hauptaktivität 13:40-13:50"
label variable   tb1_60 "Hauptaktivität 13:50-14:00"
label variable   tb1_61 "Hauptaktivität 14:00-14:10"
label variable   tb1_62 "Hauptaktivität 14:10-14:20"
label variable   tb1_63 "Hauptaktivität 14:20-14:30"
label variable   tb1_64 "Hauptaktivität 14:30-14:40"
label variable   tb1_65 "Hauptaktivität 14:40-14:50"
label variable   tb1_66 "Hauptaktivität 14:50-15:00"
label variable   tb1_67 "Hauptaktivität 15:00-15:10"
label variable   tb1_68 "Hauptaktivität 15:10-15:20"
label variable   tb1_69 "Hauptaktivität 15:20-15:30"
label variable   tb1_70 "Hauptaktivität 15:30-15:40"
label variable   tb1_71 "Hauptaktivität 15:40-15:50"
label variable   tb1_72 "Hauptaktivität 15:50-16:00"
label variable   tb1_73 "Hauptaktivität 16:00-16:10"
label variable   tb1_74 "Hauptaktivität 16:10-16:20"
label variable   tb1_75 "Hauptaktivität 16:20-16:30"
label variable   tb1_76 "Hauptaktivität 16:30-16:40"
label variable   tb1_77 "Hauptaktivität 16:40-16:50"
label variable   tb1_78 "Hauptaktivität 16:50-17:00"
label variable   tb1_79 "Hauptaktivität 17:00-17:10"
label variable   tb1_80 "Hauptaktivität 17:10-17:20"
label variable   tb1_81 "Hauptaktivität 17:20-17:30"
label variable   tb1_82 "Hauptaktivität 17:30-17:40"
label variable   tb1_83 "Hauptaktivität 17:40-17:50"
label variable   tb1_84 "Hauptaktivität 17:50-18:00"
label variable   tb1_85 "Hauptaktivität 18:00-18:10"
label variable   tb1_86 "Hauptaktivität 18:10-18:20"
label variable   tb1_87 "Hauptaktivität 18:20-18:30"
label variable   tb1_88 "Hauptaktivität 18:30-18:40"
label variable   tb1_89 "Hauptaktivität 18:40-18:50"
label variable   tb1_90 "Hauptaktivität 18:50-19:00"
label variable   tb1_91 "Hauptaktivität 19:00-19:10"
label variable   tb1_92 "Hauptaktivität 19:10-19:20"
label variable   tb1_93 "Hauptaktivität 19:20-19:30"
label variable   tb1_94 "Hauptaktivität 19:30-19:40"
label variable   tb1_95 "Hauptaktivität 19:40-19:50"
label variable   tb1_96 "Hauptaktivität 19:50-20:00"
label variable   tb1_97 "Hauptaktivität 20:00-20:10"
label variable   tb1_98 "Hauptaktivität 20:10-20:20"
label variable   tb1_99 "Hauptaktivität 20:20-20:30"
label variable   tb1_100 "Hauptaktivität 20:30-20:40"
label variable   tb1_101 "Hauptaktivität 20:40-20:50"
label variable   tb1_102 "Hauptaktivität 20:50-21:00"
label variable   tb1_103 "Hauptaktivität 21:00-21:10"
label variable   tb1_104 "Hauptaktivität 21:10-21:20"
label variable   tb1_105 "Hauptaktivität 21:20-21:30"
label variable   tb1_106 "Hauptaktivität 21:30-21:40"
label variable   tb1_107 "Hauptaktivität 21:40-21:50"
label variable   tb1_108 "Hauptaktivität 21:50-22:00"
label variable   tb1_109 "Hauptaktivität 22:00-22:10"
label variable   tb1_110 "Hauptaktivität 22:10-22:20"
label variable   tb1_111 "Hauptaktivität 22:20-22:30"
label variable   tb1_112 "Hauptaktivität 22:30-22:40"
label variable   tb1_113 "Hauptaktivität 22:40-22:50"
label variable   tb1_114 "Hauptaktivität 22:50-23:00"
label variable   tb1_115 "Hauptaktivität 23:00-23:10"
label variable   tb1_116 "Hauptaktivität 23:10-23:20"
label variable   tb1_117 "Hauptaktivität 23:20-23:30"
label variable   tb1_118 "Hauptaktivität 23:30-23:40"
label variable   tb1_119 "Hauptaktivität 23:40-23:50"
label variable   tb1_120 "Hauptaktivität 23:50-00:00"
label variable   tb1_121 "Hauptaktivität 00:00-00:10"
label variable   tb1_122 "Hauptaktivität 00:10-00:20"
label variable   tb1_123 "Hauptaktivität 00:20-00:30"
label variable   tb1_124 "Hauptaktivität 00:30-00:40"
label variable   tb1_125 "Hauptaktivität 00:40-00:50"
label variable   tb1_126 "Hauptaktivität 00:50-01:00"
label variable   tb1_127 "Hauptaktivität 01:00-01:10"
label variable   tb1_128 "Hauptaktivität 01:10-01:20"
label variable   tb1_129 "Hauptaktivität 01:20-01:30"
label variable   tb1_130 "Hauptaktivität 01:30-01:40"
label variable   tb1_131 "Hauptaktivität 01:40-01:50"
label variable   tb1_132 "Hauptaktivität 01:50-02:00"
label variable   tb1_133 "Hauptaktivität 02:00-02:10"
label variable   tb1_134 "Hauptaktivität 02:10-02:20"
label variable   tb1_135 "Hauptaktivität 02:20-02:30"
label variable   tb1_136 "Hauptaktivität 02:30-02:40"
label variable   tb1_137 "Hauptaktivität 02:40-02:50"
label variable   tb1_138 "Hauptaktivität 02:50-03:00"
label variable   tb1_139 "Hauptaktivität 03:00-03:10"
label variable   tb1_140 "Hauptaktivität 03:10-03:20"
label variable   tb1_141 "Hauptaktivität 03:20-03:30"
label variable   tb1_142 "Hauptaktivität 03:30-03:40"
label variable   tb1_143 "Hauptaktivität 03:40-03:50"
label variable   tb1_144 "Hauptaktivität 03:50-04:00"
label variable   tb2_1 "Nebenaktivität 04:00-04:10"
label variable   tb2_2 "Nebenaktivität 04:10-04:20"
label variable   tb2_3 "Nebenaktivität 04:20-04:30"
label variable   tb2_4 "Nebenaktivität 04:30-04:40"
label variable   tb2_5 "Nebenaktivität 04:40-04:50"
label variable   tb2_6 "Nebenaktivität 04:50-05:00"
label variable   tb2_7 "Nebenaktivität 05:00-05:10"
label variable   tb2_8 "Nebenaktivität 05:10-05:20"
label variable   tb2_9 "Nebenaktivität 05:20-05:30"
label variable   tb2_10 "Nebenaktivität 05:30-05:40"
label variable   tb2_11 "Nebenaktivität 05:40-05:50"
label variable   tb2_12 "Nebenaktivität 05:50-06:00"
label variable   tb2_13 "Nebenaktivität 06:00-06:10"
label variable   tb2_14 "Nebenaktivität 06:10-06:20"
label variable   tb2_15 "Nebenaktivität 06:20-06:30"
label variable   tb2_16 "Nebenaktivität 06:30-06:40"
label variable   tb2_17 "Nebenaktivität 06:40-06:50"
label variable   tb2_18 "Nebenaktivität 06:50-07:00"
label variable   tb2_19 "Nebenaktivität 07:00-07:10"
label variable   tb2_20 "Nebenaktivität 07:10-07:20"
label variable   tb2_21 "Nebenaktivität 07:20-07:30"
label variable   tb2_22 "Nebenaktivität 07:30-07:40"
label variable   tb2_23 "Nebenaktivität 07:40-07:50"
label variable   tb2_24 "Nebenaktivität 07:50-08:00"
label variable   tb2_25 "Nebenaktivität 08:00-08:10"
label variable   tb2_26 "Nebenaktivität 08:10-08:20"
label variable   tb2_27 "Nebenaktivität 08:20-08:30"
label variable   tb2_28 "Nebenaktivität 08:30-08:40"
label variable   tb2_29 "Nebenaktivität 08:40-08:50"
label variable   tb2_30 "Nebenaktivität 08:50-09:00"
label variable   tb2_31 "Nebenaktivität 09:00-09:10"
label variable   tb2_32 "Nebenaktivität 09:10-09:20"
label variable   tb2_33 "Nebenaktivität 09:20-09:30"
label variable   tb2_34 "Nebenaktivität 09:30-09:40"
label variable   tb2_35 "Nebenaktivität 09:40-09:50"
label variable   tb2_36 "Nebenaktivität 09:50-10:00"
label variable   tb2_37 "Nebenaktivität 10:00-10:10"
label variable   tb2_38 "Nebenaktivität 10:10-10:20"
label variable   tb2_39 "Nebenaktivität 10:20-10:30"
label variable   tb2_40 "Nebenaktivität 10:30-10:40"
label variable   tb2_41 "Nebenaktivität 10:40-10:50"
label variable   tb2_42 "Nebenaktivität 10:50-11:00"
label variable   tb2_43 "Nebenaktivität 11:00-11:10"
label variable   tb2_44 "Nebenaktivität 11:10-11:20"
label variable   tb2_45 "Nebenaktivität 11:20-11:30"
label variable   tb2_46 "Nebenaktivität 11:30-11:40"
label variable   tb2_47 "Nebenaktivität 11:40-11:50"
label variable   tb2_48 "Nebenaktivität 11:50-12:00"
label variable   tb2_49 "Nebenaktivität 12:00-12:10"
label variable   tb2_50 "Nebenaktivität 12:10-12:20"
label variable   tb2_51 "Nebenaktivität 12:20-12:30"
label variable   tb2_52 "Nebenaktivität 12:30-12:40"
label variable   tb2_53 "Nebenaktivität 12:40-12:50"
label variable   tb2_54 "Nebenaktivität 12:50-13:00"
label variable   tb2_55 "Nebenaktivität 13:00-13:10"
label variable   tb2_56 "Nebenaktivität 13:10-13:20"
label variable   tb2_57 "Nebenaktivität 13:20-13:30"
label variable   tb2_58 "Nebenaktivität 13:30-13:40"
label variable   tb2_59 "Nebenaktivität 13:40-13:50"
label variable   tb2_60 "Nebenaktivität 13:50-14:00"
label variable   tb2_61 "Nebenaktivität 14:00-14:10"
label variable   tb2_62 "Nebenaktivität 14:10-14:20"
label variable   tb2_63 "Nebenaktivität 14:20-14:30"
label variable   tb2_64 "Nebenaktivität 14:30-14:40"
label variable   tb2_65 "Nebenaktivität 14:40-14:50"
label variable   tb2_66 "Nebenaktivität 14:50-15:00"
label variable   tb2_67 "Nebenaktivität 15:00-15:10"
label variable   tb2_68 "Nebenaktivität 15:10-15:20"
label variable   tb2_69 "Nebenaktivität 15:20-15:30"
label variable   tb2_70 "Nebenaktivität 15:30-15:40"
label variable   tb2_71 "Nebenaktivität 15:40-15:50"
label variable   tb2_72 "Nebenaktivität 15:50-16:00"
label variable   tb2_73 "Nebenaktivität 16:00-16:10"
label variable   tb2_74 "Nebenaktivität 16:10-16:20"
label variable   tb2_75 "Nebenaktivität 16:20-16:30"
label variable   tb2_76 "Nebenaktivität 16:30-16:40"
label variable   tb2_77 "Nebenaktivität 16:40-16:50"
label variable   tb2_78 "Nebenaktivität 16:50-17:00"
label variable   tb2_79 "Nebenaktivität 17:00-17:10"
label variable   tb2_80 "Nebenaktivität 17:10-17:20"
label variable   tb2_81 "Nebenaktivität 17:20-17:30"
label variable   tb2_82 "Nebenaktivität 17:30-17:40"
label variable   tb2_83 "Nebenaktivität 17:40-17:50"
label variable   tb2_84 "Nebenaktivität 17:50-18:00"
label variable   tb2_85 "Nebenaktivität 18:00-18:10"
label variable   tb2_86 "Nebenaktivität 18:10-18:20"
label variable   tb2_87 "Nebenaktivität 18:20-18:30"
label variable   tb2_88 "Nebenaktivität 18:30-18:40"
label variable   tb2_89 "Nebenaktivität 18:40-18:50"
label variable   tb2_90 "Nebenaktivität 18:50-19:00"
label variable   tb2_91 "Nebenaktivität 19:00-19:10"
label variable   tb2_92 "Nebenaktivität 19:10-19:20"
label variable   tb2_93 "Nebenaktivität 19:20-19:30"
label variable   tb2_94 "Nebenaktivität 19:30-19:40"
label variable   tb2_95 "Nebenaktivität 19:40-19:50"
label variable   tb2_96 "Nebenaktivität 19:50-20:00"
label variable   tb2_97 "Nebenaktivität 20:00-20:10"
label variable   tb2_98 "Nebenaktivität 20:10-20:20"
label variable   tb2_99 "Nebenaktivität 20:20-20:30"
label variable   tb2_100 "Nebenaktivität 20:30-20:40"
label variable   tb2_101 "Nebenaktivität 20:40-20:50"
label variable   tb2_102 "Nebenaktivität 20:50-21:00"
label variable   tb2_103 "Nebenaktivität 21:00-21:10"
label variable   tb2_104 "Nebenaktivität 21:10-21:20"
label variable   tb2_105 "Nebenaktivität 21:20-21:30"
label variable   tb2_106 "Nebenaktivität 21:30-21:40"
label variable   tb2_107 "Nebenaktivität 21:40-21:50"
label variable   tb2_108 "Nebenaktivität 21:50-22:00"
label variable   tb2_109 "Nebenaktivität 22:00-22:10"
label variable   tb2_110 "Nebenaktivität 22:10-22:20"
label variable   tb2_111 "Nebenaktivität 22:20-22:30"
label variable   tb2_112 "Nebenaktivität 22:30-22:40"
label variable   tb2_113 "Nebenaktivität 22:40-22:50"
label variable   tb2_114 "Nebenaktivität 22:50-23:00"
label variable   tb2_115 "Nebenaktivität 23:00-23:10"
label variable   tb2_116 "Nebenaktivität 23:10-23:20"
label variable   tb2_117 "Nebenaktivität 23:20-23:30"
label variable   tb2_118 "Nebenaktivität 23:30-23:40"
label variable   tb2_119 "Nebenaktivität 23:40-23:50"
label variable   tb2_120 "Nebenaktivität 23:50-00:00"
label variable   tb2_121 "Nebenaktivität 00:00-00:10"
label variable   tb2_122 "Nebenaktivität 00:10-00:20"
label variable   tb2_123 "Nebenaktivität 00:20-00:30"
label variable   tb2_124 "Nebenaktivität 00:30-00:40"
label variable   tb2_125 "Nebenaktivität 00:40-00:50"
label variable   tb2_126 "Nebenaktivität 00:50-01:00"
label variable   tb2_127 "Nebenaktivität 01:00-01:10"
label variable   tb2_128 "Nebenaktivität 01:10-01:20"
label variable   tb2_129 "Nebenaktivität 01:20-01:30"
label variable   tb2_130 "Nebenaktivität 01:30-01:40"
label variable   tb2_131 "Nebenaktivität 01:40-01:50"
label variable   tb2_132 "Nebenaktivität 01:50-02:00"
label variable   tb2_133 "Nebenaktivität 02:00-02:10"
label variable   tb2_134 "Nebenaktivität 02:10-02:20"
label variable   tb2_135 "Nebenaktivität 02:20-02:30"
label variable   tb2_136 "Nebenaktivität 02:30-02:40"
label variable   tb2_137 "Nebenaktivität 02:40-02:50"
label variable   tb2_138 "Nebenaktivität 02:50-03:00"
label variable   tb2_139 "Nebenaktivität 03:00-03:10"
label variable   tb2_140 "Nebenaktivität 03:10-03:20"
label variable   tb2_141 "Nebenaktivität 03:20-03:30"
label variable   tb2_142 "Nebenaktivität 03:30-03:40"
label variable   tb2_143 "Nebenaktivität 03:40-03:50"
label variable   tb2_144 "Nebenaktivität 03:50-04:00"
label variable   tb3_1 "Verkehrsmittel 04:00-04:10"
label variable   tb3_2 "Verkehrsmittel 04:10-04:20"
label variable   tb3_3 "Verkehrsmittel 04:20-04:30"
label variable   tb3_4 "Verkehrsmittel 04:30-04:40"
label variable   tb3_5 "Verkehrsmittel 04:40-04:50"
label variable   tb3_6 "Verkehrsmittel 04:50-05:00"
label variable   tb3_7 "Verkehrsmittel 05:00-05:10"
label variable   tb3_8 "Verkehrsmittel 05:10-05:20"
label variable   tb3_9 "Verkehrsmittel 05:20-05:30"
label variable   tb3_10 "Verkehrsmittel 05:30-05:40"
label variable   tb3_11 "Verkehrsmittel 05:40-05:50"
label variable   tb3_12 "Verkehrsmittel 05:50-06:00"
label variable   tb3_13 "Verkehrsmittel 06:00-06:10"
label variable   tb3_14 "Verkehrsmittel 06:10-06:20"
label variable   tb3_15 "Verkehrsmittel 06:20-06:30"
label variable   tb3_16 "Verkehrsmittel 06:30-06:40"
label variable   tb3_17 "Verkehrsmittel 06:40-06:50"
label variable   tb3_18 "Verkehrsmittel 06:50-07:00"
label variable   tb3_19 "Verkehrsmittel 07:00-07:10"
label variable   tb3_20 "Verkehrsmittel 07:10-07:20"
label variable   tb3_21 "Verkehrsmittel 07:20-07:30"
label variable   tb3_22 "Verkehrsmittel 07:30-07:40"
label variable   tb3_23 "Verkehrsmittel 07:40-07:50"
label variable   tb3_24 "Verkehrsmittel 07:50-08:00"
label variable   tb3_25 "Verkehrsmittel 08:00-08:10"
label variable   tb3_26 "Verkehrsmittel 08:10-08:20"
label variable   tb3_27 "Verkehrsmittel 08:20-08:30"
label variable   tb3_28 "Verkehrsmittel 08:30-08:40"
label variable   tb3_29 "Verkehrsmittel 08:40-08:50"
label variable   tb3_30 "Verkehrsmittel 08:50-09:00"
label variable   tb3_31 "Verkehrsmittel 09:00-09:10"
label variable   tb3_32 "Verkehrsmittel 09:10-09:20"
label variable   tb3_33 "Verkehrsmittel 09:20-09:30"
label variable   tb3_34 "Verkehrsmittel 09:30-09:40"
label variable   tb3_35 "Verkehrsmittel 09:40-09:50"
label variable   tb3_36 "Verkehrsmittel 09:50-10:00"
label variable   tb3_37 "Verkehrsmittel 10:00-10:10"
label variable   tb3_38 "Verkehrsmittel 10:10-10:20"
label variable   tb3_39 "Verkehrsmittel 10:20-10:30"
label variable   tb3_40 "Verkehrsmittel 10:30-10:40"
label variable   tb3_41 "Verkehrsmittel 10:40-10:50"
label variable   tb3_42 "Verkehrsmittel 10:50-11:00"
label variable   tb3_43 "Verkehrsmittel 11:00-11:10"
label variable   tb3_44 "Verkehrsmittel 11:10-11:20"
label variable   tb3_45 "Verkehrsmittel 11:20-11:30"
label variable   tb3_46 "Verkehrsmittel 11:30-11:40"
label variable   tb3_47 "Verkehrsmittel 11:40-11:50"
label variable   tb3_48 "Verkehrsmittel 11:50-12:00"
label variable   tb3_49 "Verkehrsmittel 12:00-12:10"
label variable   tb3_50 "Verkehrsmittel 12:10-12:20"
label variable   tb3_51 "Verkehrsmittel 12:20-12:30"
label variable   tb3_52 "Verkehrsmittel 12:30-12:40"
label variable   tb3_53 "Verkehrsmittel 12:40-12:50"
label variable   tb3_54 "Verkehrsmittel 12:50-13:00"
label variable   tb3_55 "Verkehrsmittel 13:00-13:10"
label variable   tb3_56 "Verkehrsmittel 13:10-13:20"
label variable   tb3_57 "Verkehrsmittel 13:20-13:30"
label variable   tb3_58 "Verkehrsmittel 13:30-13:40"
label variable   tb3_59 "Verkehrsmittel 13:40-13:50"
label variable   tb3_60 "Verkehrsmittel 13:50-14:00"
label variable   tb3_61 "Verkehrsmittel 14:00-14:10"
label variable   tb3_62 "Verkehrsmittel 14:10-14:20"
label variable   tb3_63 "Verkehrsmittel 14:20-14:30"
label variable   tb3_64 "Verkehrsmittel 14:30-14:40"
label variable   tb3_65 "Verkehrsmittel 14:40-14:50"
label variable   tb3_66 "Verkehrsmittel 14:50-15:00"
label variable   tb3_67 "Verkehrsmittel 15:00-15:10"
label variable   tb3_68 "Verkehrsmittel 15:10-15:20"
label variable   tb3_69 "Verkehrsmittel 15:20-15:30"
label variable   tb3_70 "Verkehrsmittel 15:30-15:40"
label variable   tb3_71 "Verkehrsmittel 15:40-15:50"
label variable   tb3_72 "Verkehrsmittel 15:50-16:00"
label variable   tb3_73 "Verkehrsmittel 16:00-16:10"
label variable   tb3_74 "Verkehrsmittel 16:10-16:20"
label variable   tb3_75 "Verkehrsmittel 16:20-16:30"
label variable   tb3_76 "Verkehrsmittel 16:30-16:40"
label variable   tb3_77 "Verkehrsmittel 16:40-16:50"
label variable   tb3_78 "Verkehrsmittel 16:50-17:00"
label variable   tb3_79 "Verkehrsmittel 17:00-17:10"
label variable   tb3_80 "Verkehrsmittel 17:10-17:20"
label variable   tb3_81 "Verkehrsmittel 17:20-17:30"
label variable   tb3_82 "Verkehrsmittel 17:30-17:40"
label variable   tb3_83 "Verkehrsmittel 17:40-17:50"
label variable   tb3_84 "Verkehrsmittel 17:50-18:00"
label variable   tb3_85 "Verkehrsmittel 18:00-18:10"
label variable   tb3_86 "Verkehrsmittel 18:10-18:20"
label variable   tb3_87 "Verkehrsmittel 18:20-18:30"
label variable   tb3_88 "Verkehrsmittel 18:30-18:40"
label variable   tb3_89 "Verkehrsmittel 18:40-18:50"
label variable   tb3_90 "Verkehrsmittel 18:50-19:00"
label variable   tb3_91 "Verkehrsmittel 19:00-19:10"
label variable   tb3_92 "Verkehrsmittel 19:10-19:20"
label variable   tb3_93 "Verkehrsmittel 19:20-19:30"
label variable   tb3_94 "Verkehrsmittel 19:30-19:40"
label variable   tb3_95 "Verkehrsmittel 19:40-19:50"
label variable   tb3_96 "Verkehrsmittel 19:50-20:00"
label variable   tb3_97 "Verkehrsmittel 20:00-20:10"
label variable   tb3_98 "Verkehrsmittel 20:10-20:20"
label variable   tb3_99 "Verkehrsmittel 20:20-20:30"
label variable   tb3_100 "Verkehrsmittel 20:30-20:40"
label variable   tb3_101 "Verkehrsmittel 20:40-20:50"
label variable   tb3_102 "Verkehrsmittel 20:50-21:00"
label variable   tb3_103 "Verkehrsmittel 21:00-21:10"
label variable   tb3_104 "Verkehrsmittel 21:10-21:20"
label variable   tb3_105 "Verkehrsmittel 21:20-21:30"
label variable   tb3_106 "Verkehrsmittel 21:30-21:40"
label variable   tb3_107 "Verkehrsmittel 21:40-21:50"
label variable   tb3_108 "Verkehrsmittel 21:50-22:00"
label variable   tb3_109 "Verkehrsmittel 22:00-22:10"
label variable   tb3_110 "Verkehrsmittel 22:10-22:20"
label variable   tb3_111 "Verkehrsmittel 22:20-22:30"
label variable   tb3_112 "Verkehrsmittel 22:30-22:40"
label variable   tb3_113 "Verkehrsmittel 22:40-22:50"
label variable   tb3_114 "Verkehrsmittel 22:50-23:00"
label variable   tb3_115 "Verkehrsmittel 23:00-23:10"
label variable   tb3_116 "Verkehrsmittel 23:10-23:20"
label variable   tb3_117 "Verkehrsmittel 23:20-23:30"
label variable   tb3_118 "Verkehrsmittel 23:30-23:40"
label variable   tb3_119 "Verkehrsmittel 23:40-23:50"
label variable   tb3_120 "Verkehrsmittel 23:50-00:00"
label variable   tb3_121 "Verkehrsmittel 00:00-00:10"
label variable   tb3_122 "Verkehrsmittel 00:10-00:20"
label variable   tb3_123 "Verkehrsmittel 00:20-00:30"
label variable   tb3_124 "Verkehrsmittel 00:30-00:40"
label variable   tb3_125 "Verkehrsmittel 00:40-00:50"
label variable   tb3_126 "Verkehrsmittel 00:50-01:00"
label variable   tb3_127 "Verkehrsmittel 01:00-01:10"
label variable   tb3_128 "Verkehrsmittel 01:10-01:20"
label variable   tb3_129 "Verkehrsmittel 01:20-01:30"
label variable   tb3_130 "Verkehrsmittel 01:30-01:40"
label variable   tb3_131 "Verkehrsmittel 01:40-01:50"
label variable   tb3_132 "Verkehrsmittel 01:50-02:00"
label variable   tb3_133 "Verkehrsmittel 02:00-02:10"
label variable   tb3_134 "Verkehrsmittel 02:10-02:20"
label variable   tb3_135 "Verkehrsmittel 02:20-02:30"
label variable   tb3_136 "Verkehrsmittel 02:30-02:40"
label variable   tb3_137 "Verkehrsmittel 02:40-02:50"
label variable   tb3_138 "Verkehrsmittel 02:50-03:00"
label variable   tb3_139 "Verkehrsmittel 03:00-03:10"
label variable   tb3_140 "Verkehrsmittel 03:10-03:20"
label variable   tb3_141 "Verkehrsmittel 03:20-03:30"
label variable   tb3_142 "Verkehrsmittel 03:30-03:40"
label variable   tb3_143 "Verkehrsmittel 03:40-03:50"
label variable   tb3_144 "Verkehrsmittel 03:50-04:00"
label variable   tb4_1 "Mit-Wem-Spalte nicht ausgefüllt 04:00-04:10"
label variable   tb4_2 "Mit-Wem-Spalte nicht ausgefüllt 04:10-04:20"
label variable   tb4_3 "Mit-Wem-Spalte nicht ausgefüllt 04:20-04:30"
label variable   tb4_4 "Mit-Wem-Spalte nicht ausgefüllt 04:30-04:40"
label variable   tb4_5 "Mit-Wem-Spalte nicht ausgefüllt 04:40-04:50"
label variable   tb4_6 "Mit-Wem-Spalte nicht ausgefüllt 04:50-05:00"
label variable   tb4_7 "Mit-Wem-Spalte nicht ausgefüllt 05:00-05:10"
label variable   tb4_8 "Mit-Wem-Spalte nicht ausgefüllt 05:10-05:20"
label variable   tb4_9 "Mit-Wem-Spalte nicht ausgefüllt 05:20-05:30"
label variable   tb4_10 "Mit-Wem-Spalte nicht ausgefüllt 05:30-05:40"
label variable   tb4_11 "Mit-Wem-Spalte nicht ausgefüllt 05:40-05:50"
label variable   tb4_12 "Mit-Wem-Spalte nicht ausgefüllt 05:50-06:00"
label variable   tb4_13 "Mit-Wem-Spalte nicht ausgefüllt 06:00-06:10"
label variable   tb4_14 "Mit-Wem-Spalte nicht ausgefüllt 06:10-06:20"
label variable   tb4_15 "Mit-Wem-Spalte nicht ausgefüllt 06:20-06:30"
label variable   tb4_16 "Mit-Wem-Spalte nicht ausgefüllt 06:30-06:40"
label variable   tb4_17 "Mit-Wem-Spalte nicht ausgefüllt 06:40-06:50"
label variable   tb4_18 "Mit-Wem-Spalte nicht ausgefüllt 06:50-07:00"
label variable   tb4_19 "Mit-Wem-Spalte nicht ausgefüllt 07:00-07:10"
label variable   tb4_20 "Mit-Wem-Spalte nicht ausgefüllt 07:10-07:20"
label variable   tb4_21 "Mit-Wem-Spalte nicht ausgefüllt 07:20-07:30"
label variable   tb4_22 "Mit-Wem-Spalte nicht ausgefüllt 07:30-07:40"
label variable   tb4_23 "Mit-Wem-Spalte nicht ausgefüllt 07:40-07:50"
label variable   tb4_24 "Mit-Wem-Spalte nicht ausgefüllt 07:50-08:00"
label variable   tb4_25 "Mit-Wem-Spalte nicht ausgefüllt 08:00-08:10"
label variable   tb4_26 "Mit-Wem-Spalte nicht ausgefüllt 08:10-08:20"
label variable   tb4_27 "Mit-Wem-Spalte nicht ausgefüllt 08:20-08:30"
label variable   tb4_28 "Mit-Wem-Spalte nicht ausgefüllt 08:30-08:40"
label variable   tb4_29 "Mit-Wem-Spalte nicht ausgefüllt 08:40-08:50"
label variable   tb4_30 "Mit-Wem-Spalte nicht ausgefüllt 08:50-09:00"
label variable   tb4_31 "Mit-Wem-Spalte nicht ausgefüllt 09:00-09:10"
label variable   tb4_32 "Mit-Wem-Spalte nicht ausgefüllt 09:10-09:20"
label variable   tb4_33 "Mit-Wem-Spalte nicht ausgefüllt 09:20-09:30"
label variable   tb4_34 "Mit-Wem-Spalte nicht ausgefüllt 09:30-09:40"
label variable   tb4_35 "Mit-Wem-Spalte nicht ausgefüllt 09:40-09:50"
label variable   tb4_36 "Mit-Wem-Spalte nicht ausgefüllt 09:50-10:00"
label variable   tb4_37 "Mit-Wem-Spalte nicht ausgefüllt 10:00-10:10"
label variable   tb4_38 "Mit-Wem-Spalte nicht ausgefüllt 10:10-10:20"
label variable   tb4_39 "Mit-Wem-Spalte nicht ausgefüllt 10:20-10:30"
label variable   tb4_40 "Mit-Wem-Spalte nicht ausgefüllt 10:30-10:40"
label variable   tb4_41 "Mit-Wem-Spalte nicht ausgefüllt 10:40-10:50"
label variable   tb4_42 "Mit-Wem-Spalte nicht ausgefüllt 10:50-11:00"
label variable   tb4_43 "Mit-Wem-Spalte nicht ausgefüllt 11:00-11:10"
label variable   tb4_44 "Mit-Wem-Spalte nicht ausgefüllt 11:10-11:20"
label variable   tb4_45 "Mit-Wem-Spalte nicht ausgefüllt 11:20-11:30"
label variable   tb4_46 "Mit-Wem-Spalte nicht ausgefüllt 11:30-11:40"
label variable   tb4_47 "Mit-Wem-Spalte nicht ausgefüllt 11:40-11:50"
label variable   tb4_48 "Mit-Wem-Spalte nicht ausgefüllt 11:50-12:00"
label variable   tb4_49 "Mit-Wem-Spalte nicht ausgefüllt 12:00-12:10"
label variable   tb4_50 "Mit-Wem-Spalte nicht ausgefüllt 12:10-12:20"
label variable   tb4_51 "Mit-Wem-Spalte nicht ausgefüllt 12:20-12:30"
label variable   tb4_52 "Mit-Wem-Spalte nicht ausgefüllt 12:30-12:40"
label variable   tb4_53 "Mit-Wem-Spalte nicht ausgefüllt 12:40-12:50"
label variable   tb4_54 "Mit-Wem-Spalte nicht ausgefüllt 12:50-13:00"
label variable   tb4_55 "Mit-Wem-Spalte nicht ausgefüllt 13:00-13:10"
label variable   tb4_56 "Mit-Wem-Spalte nicht ausgefüllt 13:10-13:20"
label variable   tb4_57 "Mit-Wem-Spalte nicht ausgefüllt 13:20-13:30"
label variable   tb4_58 "Mit-Wem-Spalte nicht ausgefüllt 13:30-13:40"
label variable   tb4_59 "Mit-Wem-Spalte nicht ausgefüllt 13:40-13:50"
label variable   tb4_60 "Mit-Wem-Spalte nicht ausgefüllt 13:50-14:00"
label variable   tb4_61 "Mit-Wem-Spalte nicht ausgefüllt 14:00-14:10"
label variable   tb4_62 "Mit-Wem-Spalte nicht ausgefüllt 14:10-14:20"
label variable   tb4_63 "Mit-Wem-Spalte nicht ausgefüllt 14:20-14:30"
label variable   tb4_64 "Mit-Wem-Spalte nicht ausgefüllt 14:30-14:40"
label variable   tb4_65 "Mit-Wem-Spalte nicht ausgefüllt 14:40-14:50"
label variable   tb4_66 "Mit-Wem-Spalte nicht ausgefüllt 14:50-15:00"
label variable   tb4_67 "Mit-Wem-Spalte nicht ausgefüllt 15:00-15:10"
label variable   tb4_68 "Mit-Wem-Spalte nicht ausgefüllt 15:10-15:20"
label variable   tb4_69 "Mit-Wem-Spalte nicht ausgefüllt 15:20-15:30"
label variable   tb4_70 "Mit-Wem-Spalte nicht ausgefüllt 15:30-15:40"
label variable   tb4_71 "Mit-Wem-Spalte nicht ausgefüllt 15:40-15:50"
label variable   tb4_72 "Mit-Wem-Spalte nicht ausgefüllt 15:50-16:00"
label variable   tb4_73 "Mit-Wem-Spalte nicht ausgefüllt 16:00-16:10"
label variable   tb4_74 "Mit-Wem-Spalte nicht ausgefüllt 16:10-16:20"
label variable   tb4_75 "Mit-Wem-Spalte nicht ausgefüllt 16:20-16:30"
label variable   tb4_76 "Mit-Wem-Spalte nicht ausgefüllt 16:30-16:40"
label variable   tb4_77 "Mit-Wem-Spalte nicht ausgefüllt 16:40-16:50"
label variable   tb4_78 "Mit-Wem-Spalte nicht ausgefüllt 16:50-17:00"
label variable   tb4_79 "Mit-Wem-Spalte nicht ausgefüllt 17:00-17:10"
label variable   tb4_80 "Mit-Wem-Spalte nicht ausgefüllt 17:10-17:20"
label variable   tb4_81 "Mit-Wem-Spalte nicht ausgefüllt 17:20-17:30"
label variable   tb4_82 "Mit-Wem-Spalte nicht ausgefüllt 17:30-17:40"
label variable   tb4_83 "Mit-Wem-Spalte nicht ausgefüllt 17:40-17:50"
label variable   tb4_84 "Mit-Wem-Spalte nicht ausgefüllt 17:50-18:00"
label variable   tb4_85 "Mit-Wem-Spalte nicht ausgefüllt 18:00-18:10"
label variable   tb4_86 "Mit-Wem-Spalte nicht ausgefüllt 18:10-18:20"
label variable   tb4_87 "Mit-Wem-Spalte nicht ausgefüllt 18:20-18:30"
label variable   tb4_88 "Mit-Wem-Spalte nicht ausgefüllt 18:30-18:40"
label variable   tb4_89 "Mit-Wem-Spalte nicht ausgefüllt 18:40-18:50"
label variable   tb4_90 "Mit-Wem-Spalte nicht ausgefüllt 18:50-19:00"
label variable   tb4_91 "Mit-Wem-Spalte nicht ausgefüllt 19:00-19:10"
label variable   tb4_92 "Mit-Wem-Spalte nicht ausgefüllt 19:10-19:20"
label variable   tb4_93 "Mit-Wem-Spalte nicht ausgefüllt 19:20-19:30"
label variable   tb4_94 "Mit-Wem-Spalte nicht ausgefüllt 19:30-19:40"
label variable   tb4_95 "Mit-Wem-Spalte nicht ausgefüllt 19:40-19:50"
label variable   tb4_96 "Mit-Wem-Spalte nicht ausgefüllt 19:50-20:00"
label variable   tb4_97 "Mit-Wem-Spalte nicht ausgefüllt 20:00-20:10"
label variable   tb4_98 "Mit-Wem-Spalte nicht ausgefüllt 20:10-20:20"
label variable   tb4_99 "Mit-Wem-Spalte nicht ausgefüllt 20:20-20:30"
label variable   tb4_100 "Mit-Wem-Spalte nicht ausgefüllt 20:30-20:40"
label variable   tb4_101 "Mit-Wem-Spalte nicht ausgefüllt 20:40-20:50"
label variable   tb4_102 "Mit-Wem-Spalte nicht ausgefüllt 20:50-21:00"
label variable   tb4_103 "Mit-Wem-Spalte nicht ausgefüllt 21:00-21:10"
label variable   tb4_104 "Mit-Wem-Spalte nicht ausgefüllt 21:10-21:20"
label variable   tb4_105 "Mit-Wem-Spalte nicht ausgefüllt 21:20-21:30"
label variable   tb4_106 "Mit-Wem-Spalte nicht ausgefüllt 21:30-21:40"
label variable   tb4_107 "Mit-Wem-Spalte nicht ausgefüllt 21:40-21:50"
label variable   tb4_108 "Mit-Wem-Spalte nicht ausgefüllt 21:50-22:00"
label variable   tb4_109 "Mit-Wem-Spalte nicht ausgefüllt 22:00-22:10"
label variable   tb4_110 "Mit-Wem-Spalte nicht ausgefüllt 22:10-22:20"
label variable   tb4_111 "Mit-Wem-Spalte nicht ausgefüllt 22:20-22:30"
label variable   tb4_112 "Mit-Wem-Spalte nicht ausgefüllt 22:30-22:40"
label variable   tb4_113 "Mit-Wem-Spalte nicht ausgefüllt 22:40-22:50"
label variable   tb4_114 "Mit-Wem-Spalte nicht ausgefüllt 22:50-23:00"
label variable   tb4_115 "Mit-Wem-Spalte nicht ausgefüllt 23:00-23:10"
label variable   tb4_116 "Mit-Wem-Spalte nicht ausgefüllt 23:10-23:20"
label variable   tb4_117 "Mit-Wem-Spalte nicht ausgefüllt 23:20-23:30"
label variable   tb4_118 "Mit-Wem-Spalte nicht ausgefüllt 23:30-23:40"
label variable   tb4_119 "Mit-Wem-Spalte nicht ausgefüllt 23:40-23:50"
label variable   tb4_120 "Mit-Wem-Spalte nicht ausgefüllt 23:50-00:00"
label variable   tb4_121 "Mit-Wem-Spalte nicht ausgefüllt 00:00-00:10"
label variable   tb4_122 "Mit-Wem-Spalte nicht ausgefüllt 00:10-00:20"
label variable   tb4_123 "Mit-Wem-Spalte nicht ausgefüllt 00:20-00:30"
label variable   tb4_124 "Mit-Wem-Spalte nicht ausgefüllt 00:30-00:40"
label variable   tb4_125 "Mit-Wem-Spalte nicht ausgefüllt 00:40-00:50"
label variable   tb4_126 "Mit-Wem-Spalte nicht ausgefüllt 00:50-01:00"
label variable   tb4_127 "Mit-Wem-Spalte nicht ausgefüllt 01:00-01:10"
label variable   tb4_128 "Mit-Wem-Spalte nicht ausgefüllt 01:10-01:20"
label variable   tb4_129 "Mit-Wem-Spalte nicht ausgefüllt 01:20-01:30"
label variable   tb4_130 "Mit-Wem-Spalte nicht ausgefüllt 01:30-01:40"
label variable   tb4_131 "Mit-Wem-Spalte nicht ausgefüllt 01:40-01:50"
label variable   tb4_132 "Mit-Wem-Spalte nicht ausgefüllt 01:50-02:00"
label variable   tb4_133 "Mit-Wem-Spalte nicht ausgefüllt 02:00-02:10"
label variable   tb4_134 "Mit-Wem-Spalte nicht ausgefüllt 02:10-02:20"
label variable   tb4_135 "Mit-Wem-Spalte nicht ausgefüllt 02:20-02:30"
label variable   tb4_136 "Mit-Wem-Spalte nicht ausgefüllt 02:30-02:40"
label variable   tb4_137 "Mit-Wem-Spalte nicht ausgefüllt 02:40-02:50"
label variable   tb4_138 "Mit-Wem-Spalte nicht ausgefüllt 02:50-03:00"
label variable   tb4_139 "Mit-Wem-Spalte nicht ausgefüllt 03:00-03:10"
label variable   tb4_140 "Mit-Wem-Spalte nicht ausgefüllt 03:10-03:20"
label variable   tb4_141 "Mit-Wem-Spalte nicht ausgefüllt 03:20-03:30"
label variable   tb4_142 "Mit-Wem-Spalte nicht ausgefüllt 03:30-03:40"
label variable   tb4_143 "Mit-Wem-Spalte nicht ausgefüllt 03:40-03:50"
label variable   tb4_144 "Mit-Wem-Spalte nicht ausgefüllt 03:50-04:00"
label variable   tb5_1 "War allein 04:00-04:10"
label variable   tb5_2 "War allein 04:10-04:20"
label variable   tb5_3 "War allein 04:20-04:30"
label variable   tb5_4 "War allein 04:30-04:40"
label variable   tb5_5 "War allein 04:40-04:50"
label variable   tb5_6 "War allein 04:50-05:00"
label variable   tb5_7 "War allein 05:00-05:10"
label variable   tb5_8 "War allein 05:10-05:20"
label variable   tb5_9 "War allein 05:20-05:30"
label variable   tb5_10 "War allein 05:30-05:40"
label variable   tb5_11 "War allein 05:40-05:50"
label variable   tb5_12 "War allein 05:50-06:00"
label variable   tb5_13 "War allein 06:00-06:10"
label variable   tb5_14 "War allein 06:10-06:20"
label variable   tb5_15 "War allein 06:20-06:30"
label variable   tb5_16 "War allein 06:30-06:40"
label variable   tb5_17 "War allein 06:40-06:50"
label variable   tb5_18 "War allein 06:50-07:00"
label variable   tb5_19 "War allein 07:00-07:10"
label variable   tb5_20 "War allein 07:10-07:20"
label variable   tb5_21 "War allein 07:20-07:30"
label variable   tb5_22 "War allein 07:30-07:40"
label variable   tb5_23 "War allein 07:40-07:50"
label variable   tb5_24 "War allein 07:50-08:00"
label variable   tb5_25 "War allein 08:00-08:10"
label variable   tb5_26 "War allein 08:10-08:20"
label variable   tb5_27 "War allein 08:20-08:30"
label variable   tb5_28 "War allein 08:30-08:40"
label variable   tb5_29 "War allein 08:40-08:50"
label variable   tb5_30 "War allein 08:50-09:00"
label variable   tb5_31 "War allein 09:00-09:10"
label variable   tb5_32 "War allein 09:10-09:20"
label variable   tb5_33 "War allein 09:20-09:30"
label variable   tb5_34 "War allein 09:30-09:40"
label variable   tb5_35 "War allein 09:40-09:50"
label variable   tb5_36 "War allein 09:50-10:00"
label variable   tb5_37 "War allein 10:00-10:10"
label variable   tb5_38 "War allein 10:10-10:20"
label variable   tb5_39 "War allein 10:20-10:30"
label variable   tb5_40 "War allein 10:30-10:40"
label variable   tb5_41 "War allein 10:40-10:50"
label variable   tb5_42 "War allein 10:50-11:00"
label variable   tb5_43 "War allein 11:00-11:10"
label variable   tb5_44 "War allein 11:10-11:20"
label variable   tb5_45 "War allein 11:20-11:30"
label variable   tb5_46 "War allein 11:30-11:40"
label variable   tb5_47 "War allein 11:40-11:50"
label variable   tb5_48 "War allein 11:50-12:00"
label variable   tb5_49 "War allein 12:00-12:10"
label variable   tb5_50 "War allein 12:10-12:20"
label variable   tb5_51 "War allein 12:20-12:30"
label variable   tb5_52 "War allein 12:30-12:40"
label variable   tb5_53 "War allein 12:40-12:50"
label variable   tb5_54 "War allein 12:50-13:00"
label variable   tb5_55 "War allein 13:00-13:10"
label variable   tb5_56 "War allein 13:10-13:20"
label variable   tb5_57 "War allein 13:20-13:30"
label variable   tb5_58 "War allein 13:30-13:40"
label variable   tb5_59 "War allein 13:40-13:50"
label variable   tb5_60 "War allein 13:50-14:00"
label variable   tb5_61 "War allein 14:00-14:10"
label variable   tb5_62 "War allein 14:10-14:20"
label variable   tb5_63 "War allein 14:20-14:30"
label variable   tb5_64 "War allein 14:30-14:40"
label variable   tb5_65 "War allein 14:40-14:50"
label variable   tb5_66 "War allein 14:50-15:00"
label variable   tb5_67 "War allein 15:00-15:10"
label variable   tb5_68 "War allein 15:10-15:20"
label variable   tb5_69 "War allein 15:20-15:30"
label variable   tb5_70 "War allein 15:30-15:40"
label variable   tb5_71 "War allein 15:40-15:50"
label variable   tb5_72 "War allein 15:50-16:00"
label variable   tb5_73 "War allein 16:00-16:10"
label variable   tb5_74 "War allein 16:10-16:20"
label variable   tb5_75 "War allein 16:20-16:30"
label variable   tb5_76 "War allein 16:30-16:40"
label variable   tb5_77 "War allein 16:40-16:50"
label variable   tb5_78 "War allein 16:50-17:00"
label variable   tb5_79 "War allein 17:00-17:10"
label variable   tb5_80 "War allein 17:10-17:20"
label variable   tb5_81 "War allein 17:20-17:30"
label variable   tb5_82 "War allein 17:30-17:40"
label variable   tb5_83 "War allein 17:40-17:50"
label variable   tb5_84 "War allein 17:50-18:00"
label variable   tb5_85 "War allein 18:00-18:10"
label variable   tb5_86 "War allein 18:10-18:20"
label variable   tb5_87 "War allein 18:20-18:30"
label variable   tb5_88 "War allein 18:30-18:40"
label variable   tb5_89 "War allein 18:40-18:50"
label variable   tb5_90 "War allein 18:50-19:00"
label variable   tb5_91 "War allein 19:00-19:10"
label variable   tb5_92 "War allein 19:10-19:20"
label variable   tb5_93 "War allein 19:20-19:30"
label variable   tb5_94 "War allein 19:30-19:40"
label variable   tb5_95 "War allein 19:40-19:50"
label variable   tb5_96 "War allein 19:50-20:00"
label variable   tb5_97 "War allein 20:00-20:10"
label variable   tb5_98 "War allein 20:10-20:20"
label variable   tb5_99 "War allein 20:20-20:30"
label variable   tb5_100 "War allein 20:30-20:40"
label variable   tb5_101 "War allein 20:40-20:50"
label variable   tb5_102 "War allein 20:50-21:00"
label variable   tb5_103 "War allein 21:00-21:10"
label variable   tb5_104 "War allein 21:10-21:20"
label variable   tb5_105 "War allein 21:20-21:30"
label variable   tb5_106 "War allein 21:30-21:40"
label variable   tb5_107 "War allein 21:40-21:50"
label variable   tb5_108 "War allein 21:50-22:00"
label variable   tb5_109 "War allein 22:00-22:10"
label variable   tb5_110 "War allein 22:10-22:20"
label variable   tb5_111 "War allein 22:20-22:30"
label variable   tb5_112 "War allein 22:30-22:40"
label variable   tb5_113 "War allein 22:40-22:50"
label variable   tb5_114 "War allein 22:50-23:00"
label variable   tb5_115 "War allein 23:00-23:10"
label variable   tb5_116 "War allein 23:10-23:20"
label variable   tb5_117 "War allein 23:20-23:30"
label variable   tb5_118 "War allein 23:30-23:40"
label variable   tb5_119 "War allein 23:40-23:50"
label variable   tb5_120 "War allein 23:50-00:00"
label variable   tb5_121 "War allein 00:00-00:10"
label variable   tb5_122 "War allein 00:10-00:20"
label variable   tb5_123 "War allein 00:20-00:30"
label variable   tb5_124 "War allein 00:30-00:40"
label variable   tb5_125 "War allein 00:40-00:50"
label variable   tb5_126 "War allein 00:50-01:00"
label variable   tb5_127 "War allein 01:00-01:10"
label variable   tb5_128 "War allein 01:10-01:20"
label variable   tb5_129 "War allein 01:20-01:30"
label variable   tb5_130 "War allein 01:30-01:40"
label variable   tb5_131 "War allein 01:40-01:50"
label variable   tb5_132 "War allein 01:50-02:00"
label variable   tb5_133 "War allein 02:00-02:10"
label variable   tb5_134 "War allein 02:10-02:20"
label variable   tb5_135 "War allein 02:20-02:30"
label variable   tb5_136 "War allein 02:30-02:40"
label variable   tb5_137 "War allein 02:40-02:50"
label variable   tb5_138 "War allein 02:50-03:00"
label variable   tb5_139 "War allein 03:00-03:10"
label variable   tb5_140 "War allein 03:10-03:20"
label variable   tb5_141 "War allein 03:20-03:30"
label variable   tb5_142 "War allein 03:30-03:40"
label variable   tb5_143 "War allein 03:40-03:50"
label variable   tb5_144 "War allein 03:50-04:00"
label variable   tb6_1 "Partner 04:00-04:10"
label variable   tb6_2 "Partner 04:10-04:20"
label variable   tb6_3 "Partner 04:20-04:30"
label variable   tb6_4 "Partner 04:30-04:40"
label variable   tb6_5 "Partner 04:40-04:50"
label variable   tb6_6 "Partner 04:50-05:00"
label variable   tb6_7 "Partner 05:00-05:10"
label variable   tb6_8 "Partner 05:10-05:20"
label variable   tb6_9 "Partner 05:20-05:30"
label variable   tb6_10 "Partner 05:30-05:40"
label variable   tb6_11 "Partner 05:40-05:50"
label variable   tb6_12 "Partner 05:50-06:00"
label variable   tb6_13 "Partner 06:00-06:10"
label variable   tb6_14 "Partner 06:10-06:20"
label variable   tb6_15 "Partner 06:20-06:30"
label variable   tb6_16 "Partner 06:30-06:40"
label variable   tb6_17 "Partner 06:40-06:50"
label variable   tb6_18 "Partner 06:50-07:00"
label variable   tb6_19 "Partner 07:00-07:10"
label variable   tb6_20 "Partner 07:10-07:20"
label variable   tb6_21 "Partner 07:20-07:30"
label variable   tb6_22 "Partner 07:30-07:40"
label variable   tb6_23 "Partner 07:40-07:50"
label variable   tb6_24 "Partner 07:50-08:00"
label variable   tb6_25 "Partner 08:00-08:10"
label variable   tb6_26 "Partner 08:10-08:20"
label variable   tb6_27 "Partner 08:20-08:30"
label variable   tb6_28 "Partner 08:30-08:40"
label variable   tb6_29 "Partner 08:40-08:50"
label variable   tb6_30 "Partner 08:50-09:00"
label variable   tb6_31 "Partner 09:00-09:10"
label variable   tb6_32 "Partner 09:10-09:20"
label variable   tb6_33 "Partner 09:20-09:30"
label variable   tb6_34 "Partner 09:30-09:40"
label variable   tb6_35 "Partner 09:40-09:50"
label variable   tb6_36 "Partner 09:50-10:00"
label variable   tb6_37 "Partner 10:00-10:10"
label variable   tb6_38 "Partner 10:10-10:20"
label variable   tb6_39 "Partner 10:20-10:30"
label variable   tb6_40 "Partner 10:30-10:40"
label variable   tb6_41 "Partner 10:40-10:50"
label variable   tb6_42 "Partner 10:50-11:00"
label variable   tb6_43 "Partner 11:00-11:10"
label variable   tb6_44 "Partner 11:10-11:20"
label variable   tb6_45 "Partner 11:20-11:30"
label variable   tb6_46 "Partner 11:30-11:40"
label variable   tb6_47 "Partner 11:40-11:50"
label variable   tb6_48 "Partner 11:50-12:00"
label variable   tb6_49 "Partner 12:00-12:10"
label variable   tb6_50 "Partner 12:10-12:20"
label variable   tb6_51 "Partner 12:20-12:30"
label variable   tb6_52 "Partner 12:30-12:40"
label variable   tb6_53 "Partner 12:40-12:50"
label variable   tb6_54 "Partner 12:50-13:00"
label variable   tb6_55 "Partner 13:00-13:10"
label variable   tb6_56 "Partner 13:10-13:20"
label variable   tb6_57 "Partner 13:20-13:30"
label variable   tb6_58 "Partner 13:30-13:40"
label variable   tb6_59 "Partner 13:40-13:50"
label variable   tb6_60 "Partner 13:50-14:00"
label variable   tb6_61 "Partner 14:00-14:10"
label variable   tb6_62 "Partner 14:10-14:20"
label variable   tb6_63 "Partner 14:20-14:30"
label variable   tb6_64 "Partner 14:30-14:40"
label variable   tb6_65 "Partner 14:40-14:50"
label variable   tb6_66 "Partner 14:50-15:00"
label variable   tb6_67 "Partner 15:00-15:10"
label variable   tb6_68 "Partner 15:10-15:20"
label variable   tb6_69 "Partner 15:20-15:30"
label variable   tb6_70 "Partner 15:30-15:40"
label variable   tb6_71 "Partner 15:40-15:50"
label variable   tb6_72 "Partner 15:50-16:00"
label variable   tb6_73 "Partner 16:00-16:10"
label variable   tb6_74 "Partner 16:10-16:20"
label variable   tb6_75 "Partner 16:20-16:30"
label variable   tb6_76 "Partner 16:30-16:40"
label variable   tb6_77 "Partner 16:40-16:50"
label variable   tb6_78 "Partner 16:50-17:00"
label variable   tb6_79 "Partner 17:00-17:10"
label variable   tb6_80 "Partner 17:10-17:20"
label variable   tb6_81 "Partner 17:20-17:30"
label variable   tb6_82 "Partner 17:30-17:40"
label variable   tb6_83 "Partner 17:40-17:50"
label variable   tb6_84 "Partner 17:50-18:00"
label variable   tb6_85 "Partner 18:00-18:10"
label variable   tb6_86 "Partner 18:10-18:20"
label variable   tb6_87 "Partner 18:20-18:30"
label variable   tb6_88 "Partner 18:30-18:40"
label variable   tb6_89 "Partner 18:40-18:50"
label variable   tb6_90 "Partner 18:50-19:00"
label variable   tb6_91 "Partner 19:00-19:10"
label variable   tb6_92 "Partner 19:10-19:20"
label variable   tb6_93 "Partner 19:20-19:30"
label variable   tb6_94 "Partner 19:30-19:40"
label variable   tb6_95 "Partner 19:40-19:50"
label variable   tb6_96 "Partner 19:50-20:00"
label variable   tb6_97 "Partner 20:00-20:10"
label variable   tb6_98 "Partner 20:10-20:20"
label variable   tb6_99 "Partner 20:20-20:30"
label variable   tb6_100 "Partner 20:30-20:40"
label variable   tb6_101 "Partner 20:40-20:50"
label variable   tb6_102 "Partner 20:50-21:00"
label variable   tb6_103 "Partner 21:00-21:10"
label variable   tb6_104 "Partner 21:10-21:20"
label variable   tb6_105 "Partner 21:20-21:30"
label variable   tb6_106 "Partner 21:30-21:40"
label variable   tb6_107 "Partner 21:40-21:50"
label variable   tb6_108 "Partner 21:50-22:00"
label variable   tb6_109 "Partner 22:00-22:10"
label variable   tb6_110 "Partner 22:10-22:20"
label variable   tb6_111 "Partner 22:20-22:30"
label variable   tb6_112 "Partner 22:30-22:40"
label variable   tb6_113 "Partner 22:40-22:50"
label variable   tb6_114 "Partner 22:50-23:00"
label variable   tb6_115 "Partner 23:00-23:10"
label variable   tb6_116 "Partner 23:10-23:20"
label variable   tb6_117 "Partner 23:20-23:30"
label variable   tb6_118 "Partner 23:30-23:40"
label variable   tb6_119 "Partner 23:40-23:50"
label variable   tb6_120 "Partner 23:50-00:00"
label variable   tb6_121 "Partner 00:00-00:10"
label variable   tb6_122 "Partner 00:10-00:20"
label variable   tb6_123 "Partner 00:20-00:30"
label variable   tb6_124 "Partner 00:30-00:40"
label variable   tb6_125 "Partner 00:40-00:50"
label variable   tb6_126 "Partner 00:50-01:00"
label variable   tb6_127 "Partner 01:00-01:10"
label variable   tb6_128 "Partner 01:10-01:20"
label variable   tb6_129 "Partner 01:20-01:30"
label variable   tb6_130 "Partner 01:30-01:40"
label variable   tb6_131 "Partner 01:40-01:50"
label variable   tb6_132 "Partner 01:50-02:00"
label variable   tb6_133 "Partner 02:00-02:10"
label variable   tb6_134 "Partner 02:10-02:20"
label variable   tb6_135 "Partner 02:20-02:30"
label variable   tb6_136 "Partner 02:30-02:40"
label variable   tb6_137 "Partner 02:40-02:50"
label variable   tb6_138 "Partner 02:50-03:00"
label variable   tb6_139 "Partner 03:00-03:10"
label variable   tb6_140 "Partner 03:10-03:20"
label variable   tb6_141 "Partner 03:20-03:30"
label variable   tb6_142 "Partner 03:30-03:40"
label variable   tb6_143 "Partner 03:40-03:50"
label variable   tb6_144 "Partner 03:50-04:00"
label variable   tb7_1 "Kinder unter 10 Jahren 04:00-04:10"
label variable   tb7_2 "Kinder unter 10 Jahren 04:10-04:20"
label variable   tb7_3 "Kinder unter 10 Jahren 04:20-04:30"
label variable   tb7_4 "Kinder unter 10 Jahren 04:30-04:40"
label variable   tb7_5 "Kinder unter 10 Jahren 04:40-04:50"
label variable   tb7_6 "Kinder unter 10 Jahren 04:50-05:00"
label variable   tb7_7 "Kinder unter 10 Jahren 05:00-05:10"
label variable   tb7_8 "Kinder unter 10 Jahren 05:10-05:20"
label variable   tb7_9 "Kinder unter 10 Jahren 05:20-05:30"
label variable   tb7_10 "Kinder unter 10 Jahren 05:30-05:40"
label variable   tb7_11 "Kinder unter 10 Jahren 05:40-05:50"
label variable   tb7_12 "Kinder unter 10 Jahren 05:50-06:00"
label variable   tb7_13 "Kinder unter 10 Jahren 06:00-06:10"
label variable   tb7_14 "Kinder unter 10 Jahren 06:10-06:20"
label variable   tb7_15 "Kinder unter 10 Jahren 06:20-06:30"
label variable   tb7_16 "Kinder unter 10 Jahren 06:30-06:40"
label variable   tb7_17 "Kinder unter 10 Jahren 06:40-06:50"
label variable   tb7_18 "Kinder unter 10 Jahren 06:50-07:00"
label variable   tb7_19 "Kinder unter 10 Jahren 07:00-07:10"
label variable   tb7_20 "Kinder unter 10 Jahren 07:10-07:20"
label variable   tb7_21 "Kinder unter 10 Jahren 07:20-07:30"
label variable   tb7_22 "Kinder unter 10 Jahren 07:30-07:40"
label variable   tb7_23 "Kinder unter 10 Jahren 07:40-07:50"
label variable   tb7_24 "Kinder unter 10 Jahren 07:50-08:00"
label variable   tb7_25 "Kinder unter 10 Jahren 08:00-08:10"
label variable   tb7_26 "Kinder unter 10 Jahren 08:10-08:20"
label variable   tb7_27 "Kinder unter 10 Jahren 08:20-08:30"
label variable   tb7_28 "Kinder unter 10 Jahren 08:30-08:40"
label variable   tb7_29 "Kinder unter 10 Jahren 08:40-08:50"
label variable   tb7_30 "Kinder unter 10 Jahren 08:50-09:00"
label variable   tb7_31 "Kinder unter 10 Jahren 09:00-09:10"
label variable   tb7_32 "Kinder unter 10 Jahren 09:10-09:20"
label variable   tb7_33 "Kinder unter 10 Jahren 09:20-09:30"
label variable   tb7_34 "Kinder unter 10 Jahren 09:30-09:40"
label variable   tb7_35 "Kinder unter 10 Jahren 09:40-09:50"
label variable   tb7_36 "Kinder unter 10 Jahren 09:50-10:00"
label variable   tb7_37 "Kinder unter 10 Jahren 10:00-10:10"
label variable   tb7_38 "Kinder unter 10 Jahren 10:10-10:20"
label variable   tb7_39 "Kinder unter 10 Jahren 10:20-10:30"
label variable   tb7_40 "Kinder unter 10 Jahren 10:30-10:40"
label variable   tb7_41 "Kinder unter 10 Jahren 10:40-10:50"
label variable   tb7_42 "Kinder unter 10 Jahren 10:50-11:00"
label variable   tb7_43 "Kinder unter 10 Jahren 11:00-11:10"
label variable   tb7_44 "Kinder unter 10 Jahren 11:10-11:20"
label variable   tb7_45 "Kinder unter 10 Jahren 11:20-11:30"
label variable   tb7_46 "Kinder unter 10 Jahren 11:30-11:40"
label variable   tb7_47 "Kinder unter 10 Jahren 11:40-11:50"
label variable   tb7_48 "Kinder unter 10 Jahren 11:50-12:00"
label variable   tb7_49 "Kinder unter 10 Jahren 12:00-12:10"
label variable   tb7_50 "Kinder unter 10 Jahren 12:10-12:20"
label variable   tb7_51 "Kinder unter 10 Jahren 12:20-12:30"
label variable   tb7_52 "Kinder unter 10 Jahren 12:30-12:40"
label variable   tb7_53 "Kinder unter 10 Jahren 12:40-12:50"
label variable   tb7_54 "Kinder unter 10 Jahren 12:50-13:00"
label variable   tb7_55 "Kinder unter 10 Jahren 13:00-13:10"
label variable   tb7_56 "Kinder unter 10 Jahren 13:10-13:20"
label variable   tb7_57 "Kinder unter 10 Jahren 13:20-13:30"
label variable   tb7_58 "Kinder unter 10 Jahren 13:30-13:40"
label variable   tb7_59 "Kinder unter 10 Jahren 13:40-13:50"
label variable   tb7_60 "Kinder unter 10 Jahren 13:50-14:00"
label variable   tb7_61 "Kinder unter 10 Jahren 14:00-14:10"
label variable   tb7_62 "Kinder unter 10 Jahren 14:10-14:20"
label variable   tb7_63 "Kinder unter 10 Jahren 14:20-14:30"
label variable   tb7_64 "Kinder unter 10 Jahren 14:30-14:40"
label variable   tb7_65 "Kinder unter 10 Jahren 14:40-14:50"
label variable   tb7_66 "Kinder unter 10 Jahren 14:50-15:00"
label variable   tb7_67 "Kinder unter 10 Jahren 15:00-15:10"
label variable   tb7_68 "Kinder unter 10 Jahren 15:10-15:20"
label variable   tb7_69 "Kinder unter 10 Jahren 15:20-15:30"
label variable   tb7_70 "Kinder unter 10 Jahren 15:30-15:40"
label variable   tb7_71 "Kinder unter 10 Jahren 15:40-15:50"
label variable   tb7_72 "Kinder unter 10 Jahren 15:50-16:00"
label variable   tb7_73 "Kinder unter 10 Jahren 16:00-16:10"
label variable   tb7_74 "Kinder unter 10 Jahren 16:10-16:20"
label variable   tb7_75 "Kinder unter 10 Jahren 16:20-16:30"
label variable   tb7_76 "Kinder unter 10 Jahren 16:30-16:40"
label variable   tb7_77 "Kinder unter 10 Jahren 16:40-16:50"
label variable   tb7_78 "Kinder unter 10 Jahren 16:50-17:00"
label variable   tb7_79 "Kinder unter 10 Jahren 17:00-17:10"
label variable   tb7_80 "Kinder unter 10 Jahren 17:10-17:20"
label variable   tb7_81 "Kinder unter 10 Jahren 17:20-17:30"
label variable   tb7_82 "Kinder unter 10 Jahren 17:30-17:40"
label variable   tb7_83 "Kinder unter 10 Jahren 17:40-17:50"
label variable   tb7_84 "Kinder unter 10 Jahren 17:50-18:00"
label variable   tb7_85 "Kinder unter 10 Jahren 18:00-18:10"
label variable   tb7_86 "Kinder unter 10 Jahren 18:10-18:20"
label variable   tb7_87 "Kinder unter 10 Jahren 18:20-18:30"
label variable   tb7_88 "Kinder unter 10 Jahren 18:30-18:40"
label variable   tb7_89 "Kinder unter 10 Jahren 18:40-18:50"
label variable   tb7_90 "Kinder unter 10 Jahren 18:50-19:00"
label variable   tb7_91 "Kinder unter 10 Jahren 19:00-19:10"
label variable   tb7_92 "Kinder unter 10 Jahren 19:10-19:20"
label variable   tb7_93 "Kinder unter 10 Jahren 19:20-19:30"
label variable   tb7_94 "Kinder unter 10 Jahren 19:30-19:40"
label variable   tb7_95 "Kinder unter 10 Jahren 19:40-19:50"
label variable   tb7_96 "Kinder unter 10 Jahren 19:50-20:00"
label variable   tb7_97 "Kinder unter 10 Jahren 20:00-20:10"
label variable   tb7_98 "Kinder unter 10 Jahren 20:10-20:20"
label variable   tb7_99 "Kinder unter 10 Jahren 20:20-20:30"
label variable   tb7_100 "Kinder unter 10 Jahren 20:30-20:40"
label variable   tb7_101 "Kinder unter 10 Jahren 20:40-20:50"
label variable   tb7_102 "Kinder unter 10 Jahren 20:50-21:00"
label variable   tb7_103 "Kinder unter 10 Jahren 21:00-21:10"
label variable   tb7_104 "Kinder unter 10 Jahren 21:10-21:20"
label variable   tb7_105 "Kinder unter 10 Jahren 21:20-21:30"
label variable   tb7_106 "Kinder unter 10 Jahren 21:30-21:40"
label variable   tb7_107 "Kinder unter 10 Jahren 21:40-21:50"
label variable   tb7_108 "Kinder unter 10 Jahren 21:50-22:00"
label variable   tb7_109 "Kinder unter 10 Jahren 22:00-22:10"
label variable   tb7_110 "Kinder unter 10 Jahren 22:10-22:20"
label variable   tb7_111 "Kinder unter 10 Jahren 22:20-22:30"
label variable   tb7_112 "Kinder unter 10 Jahren 22:30-22:40"
label variable   tb7_113 "Kinder unter 10 Jahren 22:40-22:50"
label variable   tb7_114 "Kinder unter 10 Jahren 22:50-23:00"
label variable   tb7_115 "Kinder unter 10 Jahren 23:00-23:10"
label variable   tb7_116 "Kinder unter 10 Jahren 23:10-23:20"
label variable   tb7_117 "Kinder unter 10 Jahren 23:20-23:30"
label variable   tb7_118 "Kinder unter 10 Jahren 23:30-23:40"
label variable   tb7_119 "Kinder unter 10 Jahren 23:40-23:50"
label variable   tb7_120 "Kinder unter 10 Jahren 23:50-00:00"
label variable   tb7_121 "Kinder unter 10 Jahren 00:00-00:10"
label variable   tb7_122 "Kinder unter 10 Jahren 00:10-00:20"
label variable   tb7_123 "Kinder unter 10 Jahren 00:20-00:30"
label variable   tb7_124 "Kinder unter 10 Jahren 00:30-00:40"
label variable   tb7_125 "Kinder unter 10 Jahren 00:40-00:50"
label variable   tb7_126 "Kinder unter 10 Jahren 00:50-01:00"
label variable   tb7_127 "Kinder unter 10 Jahren 01:00-01:10"
label variable   tb7_128 "Kinder unter 10 Jahren 01:10-01:20"
label variable   tb7_129 "Kinder unter 10 Jahren 01:20-01:30"
label variable   tb7_130 "Kinder unter 10 Jahren 01:30-01:40"
label variable   tb7_131 "Kinder unter 10 Jahren 01:40-01:50"
label variable   tb7_132 "Kinder unter 10 Jahren 01:50-02:00"
label variable   tb7_133 "Kinder unter 10 Jahren 02:00-02:10"
label variable   tb7_134 "Kinder unter 10 Jahren 02:10-02:20"
label variable   tb7_135 "Kinder unter 10 Jahren 02:20-02:30"
label variable   tb7_136 "Kinder unter 10 Jahren 02:30-02:40"
label variable   tb7_137 "Kinder unter 10 Jahren 02:40-02:50"
label variable   tb7_138 "Kinder unter 10 Jahren 02:50-03:00"
label variable   tb7_139 "Kinder unter 10 Jahren 03:00-03:10"
label variable   tb7_140 "Kinder unter 10 Jahren 03:10-03:20"
label variable   tb7_141 "Kinder unter 10 Jahren 03:20-03:30"
label variable   tb7_142 "Kinder unter 10 Jahren 03:30-03:40"
label variable   tb7_143 "Kinder unter 10 Jahren 03:40-03:50"
label variable   tb7_144 "Kinder unter 10 Jahren 03:50-04:00"
label variable   tb8_1 "Andere Haushaltsmitglieder 04:00-04:10"
label variable   tb8_2 "Andere Haushaltsmitglieder 04:10-04:20"
label variable   tb8_3 "Andere Haushaltsmitglieder 04:20-04:30"
label variable   tb8_4 "Andere Haushaltsmitglieder 04:30-04:40"
label variable   tb8_5 "Andere Haushaltsmitglieder 04:40-04:50"
label variable   tb8_6 "Andere Haushaltsmitglieder 04:50-05:00"
label variable   tb8_7 "Andere Haushaltsmitglieder 05:00-05:10"
label variable   tb8_8 "Andere Haushaltsmitglieder 05:10-05:20"
label variable   tb8_9 "Andere Haushaltsmitglieder 05:20-05:30"
label variable   tb8_10 "Andere Haushaltsmitglieder 05:30-05:40"
label variable   tb8_11 "Andere Haushaltsmitglieder 05:40-05:50"
label variable   tb8_12 "Andere Haushaltsmitglieder 05:50-06:00"
label variable   tb8_13 "Andere Haushaltsmitglieder 06:00-06:10"
label variable   tb8_14 "Andere Haushaltsmitglieder 06:10-06:20"
label variable   tb8_15 "Andere Haushaltsmitglieder 06:20-06:30"
label variable   tb8_16 "Andere Haushaltsmitglieder 06:30-06:40"
label variable   tb8_17 "Andere Haushaltsmitglieder 06:40-06:50"
label variable   tb8_18 "Andere Haushaltsmitglieder 06:50-07:00"
label variable   tb8_19 "Andere Haushaltsmitglieder 07:00-07:10"
label variable   tb8_20 "Andere Haushaltsmitglieder 07:10-07:20"
label variable   tb8_21 "Andere Haushaltsmitglieder 07:20-07:30"
label variable   tb8_22 "Andere Haushaltsmitglieder 07:30-07:40"
label variable   tb8_23 "Andere Haushaltsmitglieder 07:40-07:50"
label variable   tb8_24 "Andere Haushaltsmitglieder 07:50-08:00"
label variable   tb8_25 "Andere Haushaltsmitglieder 08:00-08:10"
label variable   tb8_26 "Andere Haushaltsmitglieder 08:10-08:20"
label variable   tb8_27 "Andere Haushaltsmitglieder 08:20-08:30"
label variable   tb8_28 "Andere Haushaltsmitglieder 08:30-08:40"
label variable   tb8_29 "Andere Haushaltsmitglieder 08:40-08:50"
label variable   tb8_30 "Andere Haushaltsmitglieder 08:50-09:00"
label variable   tb8_31 "Andere Haushaltsmitglieder 09:00-09:10"
label variable   tb8_32 "Andere Haushaltsmitglieder 09:10-09:20"
label variable   tb8_33 "Andere Haushaltsmitglieder 09:20-09:30"
label variable   tb8_34 "Andere Haushaltsmitglieder 09:30-09:40"
label variable   tb8_35 "Andere Haushaltsmitglieder 09:40-09:50"
label variable   tb8_36 "Andere Haushaltsmitglieder 09:50-10:00"
label variable   tb8_37 "Andere Haushaltsmitglieder 10:00-10:10"
label variable   tb8_38 "Andere Haushaltsmitglieder 10:10-10:20"
label variable   tb8_39 "Andere Haushaltsmitglieder 10:20-10:30"
label variable   tb8_40 "Andere Haushaltsmitglieder 10:30-10:40"
label variable   tb8_41 "Andere Haushaltsmitglieder 10:40-10:50"
label variable   tb8_42 "Andere Haushaltsmitglieder 10:50-11:00"
label variable   tb8_43 "Andere Haushaltsmitglieder 11:00-11:10"
label variable   tb8_44 "Andere Haushaltsmitglieder 11:10-11:20"
label variable   tb8_45 "Andere Haushaltsmitglieder 11:20-11:30"
label variable   tb8_46 "Andere Haushaltsmitglieder 11:30-11:40"
label variable   tb8_47 "Andere Haushaltsmitglieder 11:40-11:50"
label variable   tb8_48 "Andere Haushaltsmitglieder 11:50-12:00"
label variable   tb8_49 "Andere Haushaltsmitglieder 12:00-12:10"
label variable   tb8_50 "Andere Haushaltsmitglieder 12:10-12:20"
label variable   tb8_51 "Andere Haushaltsmitglieder 12:20-12:30"
label variable   tb8_52 "Andere Haushaltsmitglieder 12:30-12:40"
label variable   tb8_53 "Andere Haushaltsmitglieder 12:40-12:50"
label variable   tb8_54 "Andere Haushaltsmitglieder 12:50-13:00"
label variable   tb8_55 "Andere Haushaltsmitglieder 13:00-13:10"
label variable   tb8_56 "Andere Haushaltsmitglieder 13:10-13:20"
label variable   tb8_57 "Andere Haushaltsmitglieder 13:20-13:30"
label variable   tb8_58 "Andere Haushaltsmitglieder 13:30-13:40"
label variable   tb8_59 "Andere Haushaltsmitglieder 13:40-13:50"
label variable   tb8_60 "Andere Haushaltsmitglieder 13:50-14:00"
label variable   tb8_61 "Andere Haushaltsmitglieder 14:00-14:10"
label variable   tb8_62 "Andere Haushaltsmitglieder 14:10-14:20"
label variable   tb8_63 "Andere Haushaltsmitglieder 14:20-14:30"
label variable   tb8_64 "Andere Haushaltsmitglieder 14:30-14:40"
label variable   tb8_65 "Andere Haushaltsmitglieder 14:40-14:50"
label variable   tb8_66 "Andere Haushaltsmitglieder 14:50-15:00"
label variable   tb8_67 "Andere Haushaltsmitglieder 15:00-15:10"
label variable   tb8_68 "Andere Haushaltsmitglieder 15:10-15:20"
label variable   tb8_69 "Andere Haushaltsmitglieder 15:20-15:30"
label variable   tb8_70 "Andere Haushaltsmitglieder 15:30-15:40"
label variable   tb8_71 "Andere Haushaltsmitglieder 15:40-15:50"
label variable   tb8_72 "Andere Haushaltsmitglieder 15:50-16:00"
label variable   tb8_73 "Andere Haushaltsmitglieder 16:00-16:10"
label variable   tb8_74 "Andere Haushaltsmitglieder 16:10-16:20"
label variable   tb8_75 "Andere Haushaltsmitglieder 16:20-16:30"
label variable   tb8_76 "Andere Haushaltsmitglieder 16:30-16:40"
label variable   tb8_77 "Andere Haushaltsmitglieder 16:40-16:50"
label variable   tb8_78 "Andere Haushaltsmitglieder 16:50-17:00"
label variable   tb8_79 "Andere Haushaltsmitglieder 17:00-17:10"
label variable   tb8_80 "Andere Haushaltsmitglieder 17:10-17:20"
label variable   tb8_81 "Andere Haushaltsmitglieder 17:20-17:30"
label variable   tb8_82 "Andere Haushaltsmitglieder 17:30-17:40"
label variable   tb8_83 "Andere Haushaltsmitglieder 17:40-17:50"
label variable   tb8_84 "Andere Haushaltsmitglieder 17:50-18:00"
label variable   tb8_85 "Andere Haushaltsmitglieder 18:00-18:10"
label variable   tb8_86 "Andere Haushaltsmitglieder 18:10-18:20"
label variable   tb8_87 "Andere Haushaltsmitglieder 18:20-18:30"
label variable   tb8_88 "Andere Haushaltsmitglieder 18:30-18:40"
label variable   tb8_89 "Andere Haushaltsmitglieder 18:40-18:50"
label variable   tb8_90 "Andere Haushaltsmitglieder 18:50-19:00"
label variable   tb8_91 "Andere Haushaltsmitglieder 19:00-19:10"
label variable   tb8_92 "Andere Haushaltsmitglieder 19:10-19:20"
label variable   tb8_93 "Andere Haushaltsmitglieder 19:20-19:30"
label variable   tb8_94 "Andere Haushaltsmitglieder 19:30-19:40"
label variable   tb8_95 "Andere Haushaltsmitglieder 19:40-19:50"
label variable   tb8_96 "Andere Haushaltsmitglieder 19:50-20:00"
label variable   tb8_97 "Andere Haushaltsmitglieder 20:00-20:10"
label variable   tb8_98 "Andere Haushaltsmitglieder 20:10-20:20"
label variable   tb8_99 "Andere Haushaltsmitglieder 20:20-20:30"
label variable   tb8_100 "Andere Haushaltsmitglieder 20:30-20:40"
label variable   tb8_101 "Andere Haushaltsmitglieder 20:40-20:50"
label variable   tb8_102 "Andere Haushaltsmitglieder 20:50-21:00"
label variable   tb8_103 "Andere Haushaltsmitglieder 21:00-21:10"
label variable   tb8_104 "Andere Haushaltsmitglieder 21:10-21:20"
label variable   tb8_105 "Andere Haushaltsmitglieder 21:20-21:30"
label variable   tb8_106 "Andere Haushaltsmitglieder 21:30-21:40"
label variable   tb8_107 "Andere Haushaltsmitglieder 21:40-21:50"
label variable   tb8_108 "Andere Haushaltsmitglieder 21:50-22:00"
label variable   tb8_109 "Andere Haushaltsmitglieder 22:00-22:10"
label variable   tb8_110 "Andere Haushaltsmitglieder 22:10-22:20"
label variable   tb8_111 "Andere Haushaltsmitglieder 22:20-22:30"
label variable   tb8_112 "Andere Haushaltsmitglieder 22:30-22:40"
label variable   tb8_113 "Andere Haushaltsmitglieder 22:40-22:50"
label variable   tb8_114 "Andere Haushaltsmitglieder 22:50-23:00"
label variable   tb8_115 "Andere Haushaltsmitglieder 23:00-23:10"
label variable   tb8_116 "Andere Haushaltsmitglieder 23:10-23:20"
label variable   tb8_117 "Andere Haushaltsmitglieder 23:20-23:30"
label variable   tb8_118 "Andere Haushaltsmitglieder 23:30-23:40"
label variable   tb8_119 "Andere Haushaltsmitglieder 23:40-23:50"
label variable   tb8_120 "Andere Haushaltsmitglieder 23:50-00:00"
label variable   tb8_121 "Andere Haushaltsmitglieder 00:00-00:10"
label variable   tb8_122 "Andere Haushaltsmitglieder 00:10-00:20"
label variable   tb8_123 "Andere Haushaltsmitglieder 00:20-00:30"
label variable   tb8_124 "Andere Haushaltsmitglieder 00:30-00:40"
label variable   tb8_125 "Andere Haushaltsmitglieder 00:40-00:50"
label variable   tb8_126 "Andere Haushaltsmitglieder 00:50-01:00"
label variable   tb8_127 "Andere Haushaltsmitglieder 01:00-01:10"
label variable   tb8_128 "Andere Haushaltsmitglieder 01:10-01:20"
label variable   tb8_129 "Andere Haushaltsmitglieder 01:20-01:30"
label variable   tb8_130 "Andere Haushaltsmitglieder 01:30-01:40"
label variable   tb8_131 "Andere Haushaltsmitglieder 01:40-01:50"
label variable   tb8_132 "Andere Haushaltsmitglieder 01:50-02:00"
label variable   tb8_133 "Andere Haushaltsmitglieder 02:00-02:10"
label variable   tb8_134 "Andere Haushaltsmitglieder 02:10-02:20"
label variable   tb8_135 "Andere Haushaltsmitglieder 02:20-02:30"
label variable   tb8_136 "Andere Haushaltsmitglieder 02:30-02:40"
label variable   tb8_137 "Andere Haushaltsmitglieder 02:40-02:50"
label variable   tb8_138 "Andere Haushaltsmitglieder 02:50-03:00"
label variable   tb8_139 "Andere Haushaltsmitglieder 03:00-03:10"
label variable   tb8_140 "Andere Haushaltsmitglieder 03:10-03:20"
label variable   tb8_141 "Andere Haushaltsmitglieder 03:20-03:30"
label variable   tb8_142 "Andere Haushaltsmitglieder 03:30-03:40"
label variable   tb8_143 "Andere Haushaltsmitglieder 03:40-03:50"
label variable   tb8_144 "Andere Haushaltsmitglieder 03:50-04:00"
label variable   tb9_1 "Bekannte 04:00-04:10"
label variable   tb9_2 "Bekannte 04:10-04:20"
label variable   tb9_3 "Bekannte 04:20-04:30"
label variable   tb9_4 "Bekannte 04:30-04:40"
label variable   tb9_5 "Bekannte 04:40-04:50"
label variable   tb9_6 "Bekannte 04:50-05:00"
label variable   tb9_7 "Bekannte 05:00-05:10"
label variable   tb9_8 "Bekannte 05:10-05:20"
label variable   tb9_9 "Bekannte 05:20-05:30"
label variable   tb9_10 "Bekannte 05:30-05:40"
label variable   tb9_11 "Bekannte 05:40-05:50"
label variable   tb9_12 "Bekannte 05:50-06:00"
label variable   tb9_13 "Bekannte 06:00-06:10"
label variable   tb9_14 "Bekannte 06:10-06:20"
label variable   tb9_15 "Bekannte 06:20-06:30"
label variable   tb9_16 "Bekannte 06:30-06:40"
label variable   tb9_17 "Bekannte 06:40-06:50"
label variable   tb9_18 "Bekannte 06:50-07:00"
label variable   tb9_19 "Bekannte 07:00-07:10"
label variable   tb9_20 "Bekannte 07:10-07:20"
label variable   tb9_21 "Bekannte 07:20-07:30"
label variable   tb9_22 "Bekannte 07:30-07:40"
label variable   tb9_23 "Bekannte 07:40-07:50"
label variable   tb9_24 "Bekannte 07:50-08:00"
label variable   tb9_25 "Bekannte 08:00-08:10"
label variable   tb9_26 "Bekannte 08:10-08:20"
label variable   tb9_27 "Bekannte 08:20-08:30"
label variable   tb9_28 "Bekannte 08:30-08:40"
label variable   tb9_29 "Bekannte 08:40-08:50"
label variable   tb9_30 "Bekannte 08:50-09:00"
label variable   tb9_31 "Bekannte 09:00-09:10"
label variable   tb9_32 "Bekannte 09:10-09:20"
label variable   tb9_33 "Bekannte 09:20-09:30"
label variable   tb9_34 "Bekannte 09:30-09:40"
label variable   tb9_35 "Bekannte 09:40-09:50"
label variable   tb9_36 "Bekannte 09:50-10:00"
label variable   tb9_37 "Bekannte 10:00-10:10"
label variable   tb9_38 "Bekannte 10:10-10:20"
label variable   tb9_39 "Bekannte 10:20-10:30"
label variable   tb9_40 "Bekannte 10:30-10:40"
label variable   tb9_41 "Bekannte 10:40-10:50"
label variable   tb9_42 "Bekannte 10:50-11:00"
label variable   tb9_43 "Bekannte 11:00-11:10"
label variable   tb9_44 "Bekannte 11:10-11:20"
label variable   tb9_45 "Bekannte 11:20-11:30"
label variable   tb9_46 "Bekannte 11:30-11:40"
label variable   tb9_47 "Bekannte 11:40-11:50"
label variable   tb9_48 "Bekannte 11:50-12:00"
label variable   tb9_49 "Bekannte 12:00-12:10"
label variable   tb9_50 "Bekannte 12:10-12:20"
label variable   tb9_51 "Bekannte 12:20-12:30"
label variable   tb9_52 "Bekannte 12:30-12:40"
label variable   tb9_53 "Bekannte 12:40-12:50"
label variable   tb9_54 "Bekannte 12:50-13:00"
label variable   tb9_55 "Bekannte 13:00-13:10"
label variable   tb9_56 "Bekannte 13:10-13:20"
label variable   tb9_57 "Bekannte 13:20-13:30"
label variable   tb9_58 "Bekannte 13:30-13:40"
label variable   tb9_59 "Bekannte 13:40-13:50"
label variable   tb9_60 "Bekannte 13:50-14:00"
label variable   tb9_61 "Bekannte 14:00-14:10"
label variable   tb9_62 "Bekannte 14:10-14:20"
label variable   tb9_63 "Bekannte 14:20-14:30"
label variable   tb9_64 "Bekannte 14:30-14:40"
label variable   tb9_65 "Bekannte 14:40-14:50"
label variable   tb9_66 "Bekannte 14:50-15:00"
label variable   tb9_67 "Bekannte 15:00-15:10"
label variable   tb9_68 "Bekannte 15:10-15:20"
label variable   tb9_69 "Bekannte 15:20-15:30"
label variable   tb9_70 "Bekannte 15:30-15:40"
label variable   tb9_71 "Bekannte 15:40-15:50"
label variable   tb9_72 "Bekannte 15:50-16:00"
label variable   tb9_73 "Bekannte 16:00-16:10"
label variable   tb9_74 "Bekannte 16:10-16:20"
label variable   tb9_75 "Bekannte 16:20-16:30"
label variable   tb9_76 "Bekannte 16:30-16:40"
label variable   tb9_77 "Bekannte 16:40-16:50"
label variable   tb9_78 "Bekannte 16:50-17:00"
label variable   tb9_79 "Bekannte 17:00-17:10"
label variable   tb9_80 "Bekannte 17:10-17:20"
label variable   tb9_81 "Bekannte 17:20-17:30"
label variable   tb9_82 "Bekannte 17:30-17:40"
label variable   tb9_83 "Bekannte 17:40-17:50"
label variable   tb9_84 "Bekannte 17:50-18:00"
label variable   tb9_85 "Bekannte 18:00-18:10"
label variable   tb9_86 "Bekannte 18:10-18:20"
label variable   tb9_87 "Bekannte 18:20-18:30"
label variable   tb9_88 "Bekannte 18:30-18:40"
label variable   tb9_89 "Bekannte 18:40-18:50"
label variable   tb9_90 "Bekannte 18:50-19:00"
label variable   tb9_91 "Bekannte 19:00-19:10"
label variable   tb9_92 "Bekannte 19:10-19:20"
label variable   tb9_93 "Bekannte 19:20-19:30"
label variable   tb9_94 "Bekannte 19:30-19:40"
label variable   tb9_95 "Bekannte 19:40-19:50"
label variable   tb9_96 "Bekannte 19:50-20:00"
label variable   tb9_97 "Bekannte 20:00-20:10"
label variable   tb9_98 "Bekannte 20:10-20:20"
label variable   tb9_99 "Bekannte 20:20-20:30"
label variable   tb9_100 "Bekannte 20:30-20:40"
label variable   tb9_101 "Bekannte 20:40-20:50"
label variable   tb9_102 "Bekannte 20:50-21:00"
label variable   tb9_103 "Bekannte 21:00-21:10"
label variable   tb9_104 "Bekannte 21:10-21:20"
label variable   tb9_105 "Bekannte 21:20-21:30"
label variable   tb9_106 "Bekannte 21:30-21:40"
label variable   tb9_107 "Bekannte 21:40-21:50"
label variable   tb9_108 "Bekannte 21:50-22:00"
label variable   tb9_109 "Bekannte 22:00-22:10"
label variable   tb9_110 "Bekannte 22:10-22:20"
label variable   tb9_111 "Bekannte 22:20-22:30"
label variable   tb9_112 "Bekannte 22:30-22:40"
label variable   tb9_113 "Bekannte 22:40-22:50"
label variable   tb9_114 "Bekannte 22:50-23:00"
label variable   tb9_115 "Bekannte 23:00-23:10"
label variable   tb9_116 "Bekannte 23:10-23:20"
label variable   tb9_117 "Bekannte 23:20-23:30"
label variable   tb9_118 "Bekannte 23:30-23:40"
label variable   tb9_119 "Bekannte 23:40-23:50"
label variable   tb9_120 "Bekannte 23:50-00:00"
label variable   tb9_121 "Bekannte 00:00-00:10"
label variable   tb9_122 "Bekannte 00:10-00:20"
label variable   tb9_123 "Bekannte 00:20-00:30"
label variable   tb9_124 "Bekannte 00:30-00:40"
label variable   tb9_125 "Bekannte 00:40-00:50"
label variable   tb9_126 "Bekannte 00:50-01:00"
label variable   tb9_127 "Bekannte 01:00-01:10"
label variable   tb9_128 "Bekannte 01:10-01:20"
label variable   tb9_129 "Bekannte 01:20-01:30"
label variable   tb9_130 "Bekannte 01:30-01:40"
label variable   tb9_131 "Bekannte 01:40-01:50"
label variable   tb9_132 "Bekannte 01:50-02:00"
label variable   tb9_133 "Bekannte 02:00-02:10"
label variable   tb9_134 "Bekannte 02:10-02:20"
label variable   tb9_135 "Bekannte 02:20-02:30"
label variable   tb9_136 "Bekannte 02:30-02:40"
label variable   tb9_137 "Bekannte 02:40-02:50"
label variable   tb9_138 "Bekannte 02:50-03:00"
label variable   tb9_139 "Bekannte 03:00-03:10"
label variable   tb9_140 "Bekannte 03:10-03:20"
label variable   tb9_141 "Bekannte 03:20-03:30"
label variable   tb9_142 "Bekannte 03:30-03:40"
label variable   tb9_143 "Bekannte 03:40-03:50"
label variable   tb9_144 "Bekannte 03:50-04:00"
label variable tc1x "Anzahl der Nennungen zu größte Freude"
label variable tc1ax "Aktivitätscode größte Freude 1"
label variable tc1bx "Aktivitätscode größte Freude 2"
label variable tc1cx "Aktivitätscode größte Freude 3"
label variable tc2x "Anzahl der Nennungen zu mehr Zeit"
label variable tc2ax "Aktivitätscode mehr Zeit 1"
label variable tc2bx "Aktivitätscode mehr Zeit 2"
label variable tc2cx "Aktivitätscode mehr Zeit 3"
label variable tc3x "Anzahl der Nennungen zu keine Freude"
label variable tc3ax "Aktivitätscode keine Freude 1"
label variable tc3bx "Aktivitätscode keine Freude 2"
label variable tc3cx "Aktivitätscode keine Freude 3"
label variable tc4 "Besonderheiten des Tages"
label variable tc5 "Reise"
label variable tc6 "Häufigkeit der Anschreibungen"
label variable tc7 "Zu Hause zu Beginn des Tages"
label variable tc8 "Zu Hause am Ende des Tages"
label variable wtagfei "Wochentag, Feiertage berücksichtigt"
label variable fehl_tag "Fehlender Tag"
label variable jahr "Jahr des Ausfülldatums"
label variable quartal "Kalenderquartal des Ausfülldatums"
label variable selbtag "Datum des Tagebuchtages ist für alle Personen des Haushalts identisch"
label variable berichtsjahr "Berichtsjahr"
label variable tagnr "Anschreibetag"
label variable persx "Personennummer"
label variable id_tagx "Tag-ID"
label variable id_persx "Personen-ID"
label variable id_hhx "Haushalts-ID"
label variable hrft80 "Hochrechnungsfaktor für den Tag multipliziert mit 100"

label value tc1ax tc1ax_label
label value tc1bx tc1bx_label
label value tc1cx tc1cx_label
label value tc2ax tc2ax_label
label value tc2bx tc2bx_label
label value tc2cx tc2cx_label
label value tc3ax tc3ax_label
label value tc3bx tc3bx_label
label value tc3cx tc3cx_label
label value tc4 tc4_label
label value tc5 tc5_label
label value tc6 tc6_label
label value tc7 tc7_label
label value tc8 tc8_label
label value wtagfei wtagfei_label
label value fehl_tag fehl_tag_label
label value quartal quartal_label
label value selbtag selbtag_label	

foreach var of varlist tb2_* {	
	label values `var' tb2_1_label
}	
	
foreach var of varlist tb3_* {	
	label values `var' tb3_1_label
}	
	
foreach var of varlist tb4_* {	
	label values `var' tb4_1_label
}	
	
foreach var of varlist tb5_* {	
	label values `var' tb5_1_label
}	
	
foreach var of varlist tb6_* {	
	label values `var' tb6_1_label
}	
	
foreach var of varlist tb7_* {	
	label values `var' tb7_1_label
}	
	
foreach var of varlist tb8_* {	
	label values `var' tb8_1_label
}	
	
foreach var of varlist tb9_* {	
	label values `var' tb9_1_label
}


/* (iv): Speichern */

save "${pfad4}\${dateiname4}", replace
		



