/********************************************************************************************************/
/*
	1.	Programmname: einleseroutine_sas.sas
    2.  Stand: 04.03.2016
  	3. 	Autor: Forschungsdatenzentrum des Statistischen Bundesamtes
  	4. 	Programmziel: Einlesen und Labeln des Public-Use-Files der Erhebung zur Zeitverwendung 2012/2013, 
		das als CSV-Datei mit Semikolons als Trennzeichen vorliegt.
	5. 	Programmstatus: Getestet mit SAS EG 4.3 for Unix unter Windows 7 Professional Version 2009, Service Pack 1, 13.03.2013
	6. 	Programmstruktur:
		(I) Verzeichnisse, in denen sich die CSV-Daten befinden, Benennen der Einlesedateien, Benennen der temporären Ausgabedateien
		(II) ZVE 13 HH
				(i) 	Einlesen CSV-Datei
				(ii)	Definition der Wertelabels, die temporär in WORK gespeichert werden
     			(iii)	Zuweisung der Werte- und Variablenlabels zu den Variablen und Speichern als SAS-Datei
				(iv)	Löschen nicht mehr benötigter temporärer Dateien
		(III) ZVE 13 pers
				(i) 	Einlesen CSV-Datei
				(ii)	Definition der Wertelabels, die temporär in WORK gespeichert werden
     			(iii)	Zuweisung der Werte- und Variablenlabels zu den Variablen und Speichern als SAS-Datei
				(iv)	Löschen nicht mehr benötigter temporärer Dateien
		(IV) ZVE 13 sum
				(i) 	Einlesen CSV-Datei
                (ii)	Definition der Wertelabels, die temporär in WORK gespeichert werden
     			(iii)	Zuweisung der Werte- und Variablenlabels zu den Variablen und Speichern als SAS-Datei
				(iv)	Löschen nicht mehr benötigter temporärer Dateien				
		(V) ZVE 13 takt
				(i) 	Einlesen CSV-Datei
				(ii)	Definition der Wertelabels, die temporär in WORK gespeichert werden
     			(iii)	Zuweisung der Werte- und Variablenlabels zu den Variablen und Speichern als SAS-Datei
				(iv)	Löschen nicht mehr benötigter temporärer Dateien
*/
/********************************************************************************************************/

/*	(I)		Verzeichnisse, in denen sich die CSV-Daten befinden, Benennen der Einlesedatei, Benennen der temporären Ausgabedatei	*/

/******************************************************************************/
/* Die Zeilen 42, 49, 56 und 63 müssen individuell an die eigene Pfadumgebung angepasst werden*/
/******************************************************************************/


/*	zve 13 hh	*/
%let pfad1		=	<PFAD, IN DEM DIE CSV-DATEN LIEGEN ANPASSEN>;
%let CSVdatei1	=	zve13_puf_hh.csv;
%let dateiname1	=	zve13_puf_hh;
libname ZVE1	"&pfad1."; 


/*	zve 13 pers	*/
%let pfad2		=	<PFAD, IN DEM DIE CSV-DATEN LIEGEN ANPASSEN>;
%let CSVdatei2	=	zve13_puf_pers.csv;
%let dateiname2	=	zve13_puf_pers;
libname ZVE2	"&pfad2."; 


/*	zve 13 sum	 */
%let pfad3		=	<PFAD, IN DEM DIE CSV-DATEN LIEGEN ANPASSEN>;
%let CSVdatei3	=	zve13_puf_sum.csv;
%let dateiname3	=	zve13_puf_sum;
libname ZVE3	"&pfad3."; 


/*	zve 13 takt */
%let pfad4		=	<PFAD, IN DEM DIE CSV-DATEN LIEGEN ANPASSEN>;
%let CSVdatei4	=	zve13_puf_takt.csv;
%let dateiname4	=	zve13_puf_takt;
libname ZVE4	"&pfad4.";


/*******************************************************************/
/* Ab dieser Zeile müssen keine Anpassungen mehr vorgenommen werden*/
/*******************************************************************/

/*  (II) ZVE 13 HH                      */
/*	(i)	 Einlesen der CSV-Datei		    */

proc import 
	datafile		=	"&pfad1./&CSVdatei1"	
	out				=	&dateiname1   
	dbms			=	dlm
	replace;
	delimiter		=	";";
 	getnames		=	yes;
run;

/*  (II) ZVE 13 HH                      */
/*	(ii) Definition der Wertelabels, die temporär in WORK gespeichert werden */

proc format lib=work;

value Wflaeche_w  			 30 = "30 qm und weniger"
							 200 = "200 qm und mehr";

value AnzahlR_w 		 	 8 = "8 oder mehr";
						
value EigenMietFrei_w 
							 1 = "Eigentümer/-in"
							 2 = "Mieter/-in"
							 3 = "Wohnung mietfrei überlassen";

value Auto_w				-1 = "keine Angabe"
 							 1 = "ja"
							 2 = "nein";

value AutoAnz_w				-1 = "keine Angabe"
 							 3 = "3 oder mehr";
value PC_w					
							-1 = "keine Angabe"
 							 1 = "ja"
 							 2 = "nein";

value PCAnz_w				-1 = "keine Angabe"
							 6 = "6 oder mehr";

value Inet_w				 1 = "ja"
							 2 = "nein";

value Kinderbetr_w			-1 = "keine Angabe"
 							 1 = "ja"
 							 2 = "nein";

value bezStuKindbet_w		-1 = "keine Angabe"
							 60 = "60 und mehr";

value unbezStuKindbet_w		-1 = "keine Angabe"
							 40 = "40 und mehr";

value ZubMahl_w				-1 = "keine Angabe"
 							 1 = "ja"
 							 2 = "nein";

value bezStuZubMahl_w		-1 = "keine Angabe"
							 10 = "10 und mehr";

value unbezStuZubMahl_w		-1 = "keine Angabe"
							 15 = "15 und mehr";

value PuAufWasch_w			-1 = "keine Angabe"
 							 1 = "ja"
 							 2 = "nein";

value bezPuAufWasch_w		-1 = "keine Angabe"
							 12 = "12 und mehr";

value unbezPuAufWasch_w		-1 = "keine Angabe"
							 20 = "20 und mehr";

value Aufsicht_w			-1 = "keine Angabe"
							 1 = "ja"
 							 2 = "nein";

value bezAufsicht_w			-1 = "keine Angabe"
							 3 = "3 und mehr";

value unbezAufsicht_w		-1 = "keine Angabe";

value Garten_w				-1 = "keine Angabe"
							 1 = "ja"
							 2 = "nein";

value bezGarten_w			-1 = "keine Angabe"
							 5 = "5 und mehr";

value unbezGarten_w			-1 = "keine Angabe"
							 20 = "20 und mehr";


value einkauf_w				-1 = "keine Angabe"
 							 1 = "ja"
							 2 = "nein";

value bezeinkauf_w			-1 = "keine Angabe"
							 5 = "5 und mehr";

value unbezeinkauf_w		-1 = "keine Angabe";

value Htierpflege_w			-1 = "keine Angabe"
 							 1 = "ja"
 							 2 = "nein";

value bezHtierpflege_w		-1 = "keine Angabe"
							 5 = "5 und mehr";

value unbezHtierpflege_w	-1 = "keine Angabe"
							 30 = "30 und mehr";

value RepFahrz_w			-1 = "keine Angabe"
							 1 = "ja"
 							 2 = "nein";

value bezRepFahrz_w			-1 = "keine Angabe";

value unbezRepFahrz_w		-1 = "keine Angabe";

value RepundBau_w			-1 = "keine Angabe"
							 1 = "ja"
							 2 = "nein";

value bezRepundBau_w		-1 = "keine Angabe"
							 4 = "4 und mehr";

value unbezRepundBau_w		-1 = "keine Angabe";

value VersuBehoer_w			-1 = "keine Angabe"
							 1 = "ja"
 							 2 = "nein";

value bezVersuBehoer_w		-1 = "keine Angabe"
						     2 = "2 und mehr";

value unbezVersuBehoer_w	-1 = "keine Angabe";

value Sonstige_w			-1 = "keine Angabe"
							 1 = "ja"
							 2 = "nein";

value bezSonstige_w			-1 = "keine Angabe";

value unbezSonstige_w		-1 = "keine Angabe"
							 40 = "40 und mehr";

value HHNetto_w				 1 = "unter 1100 Euro"
							 2 = "1100 bis unter 1700 Euro"
							 3 = "1700 bis unter 2300 Euro"
						 	 4 = "2300 bis unter 3600 Euro"
							 5 = "3600 Euro und mehr";

value Kindu10HH_w			 1 = "ja"
							 2 = "nein";

value HHTyp_w				 1 = "Einpersonenhaushalt"
							 2 = "Paare ohne Kinder"
							 3 = "Alleinerziehende mit mindestens einem Kind unter 18 Jahren und ledigen Kindern unter 27 Jahren"
							 4 = "Paare mit mindestens einem Kind unter 18 Jahren und ledigen Kindern unter 27 Jahren"
							 5 = "Sonstige Haushalte";

value ledu27_w				-2 = "trifft nicht zu"
							 1 = "1 Kind"
							 2 = "2 Kinder"
							 3 = "3 und mehr Kinder";

value AlterjKu18_w			-2 = "trifft nicht zu";

value AKjuengstesKind_w		-2 = "trifft nicht zu"
							 1 = "0 bis unter 3 Jahren"
							 2 = "3 bis unter 6 Jahren"
							 3 = "6 bis unter 10 Jahren"
							 4 = "10 bis unter 15 Jahren"
							 5 = "15 bis unter 18 Jahren";

value AnzPersHH_w			 1 = "1 Person"
							 2 = "2 Personen"
							 3 = "3 Personen"
							 4 = "4 Personen"
							 5 = "5 oder mehr Personen";

value SozStellHEB_w			 1 = "Selbstständiger"
							 2 = "Beamter"
							 3 = "Angestellter"
							 4 = "Arbeiter"
							 5 = "Rentner, Pensionär"
							 6 = "Sonstige Nichterwerbstätige";

value AnzErwerb_w			 1 = "keine Erwerbstätige"
							 2 = "1 Vollzeit"
							 3 = "1 Teilzeit"
							 4 = "2 Vollzeit"
							 5 = "1 Vollzeit, 1 Teilzeit"
							 6 = "3 Vollzeit"
							 7 = "Sonstige";

value PersNumHEB_w			-2 = "trifft nicht zu";

value Erwtpartn_w			-2 = "trifft nicht zu"
							 1 = "ein Partner erwerbstätig"
							 2 = "beide Partner erwerbstätig"
							 3 = "kein Partner erwerbstätig";

value Geb_w					 1 = "West (Alte Bundesländer)"
							 2 = "Ost (Neue Bundesländer einschließlich Berlin)";

run;


/*  (II)  ZVE 13 HH            */
/*	(iii) Zuweisung der Werte- und Variablenlabels zu den Variablen und Speichern als SAS-Datei		*/

data	ZVE1.&dateiname1;
set 	&dateiname1;

format 
	hb9x		Wflaeche_w.
	hb10x		AnzahlR_w.
	hb11		EigenMietFrei_w.
	hb121a		Auto_w.
	hb121bx		AutoAnz_w.
	hb122a		PC_w.
	hb122bx		PCAnz_w.
	hb13		Inet_w.
	hc141a		Kinderbetr_w.
	hc141bx		bezStuKindbet_w.
	hc141cx		unbezStuKindbet_w.
	hc142a		ZubMahl_w.
	hc142bx		bezStuZubMahl_w.
	hc142cx		unbezStuZubMahl_w.
	hc143a		PuAufWasch_w.
	hc143bx		bezPuAufWasch_w.
	hc143cx		unbezPuAufWasch_w.
	hc144a		Aufsicht_w.
	hc144bx		bezAufsicht_w.
	hc144cx		unbezAufsicht_w.
	hc145a		Garten_w.
	hc145bx		bezGarten_w.
	hc145cx		unbezGarten_w.
	hc146a		einkauf_w.
	hc146bx		bezeinkauf_w.
	hc146cx		unbezeinkauf_w.
	hc147a		Htierpflege_w.
	hc147bx		bezHtierpflege_w.
	hc147cx		unbezHtierpflege_w.
	hc148a		RepFahrz_w.
	hc148bx		bezRepFahrz_w.
	hc148cx		unbezRepFahrz_w.
	hc149a		RepundBau_w.
	hc149bx		bezRepundBau_w.
	hc149cx		unbezRepundBau_w.
	hc1410a		VersuBehoer_w.
	hc1410bx	bezVersuBehoer_w.	
	hc1410c		unbezVersuBehoer_w.
	hc1411a		Sonstige_w.
	hc1411b		bezSonstige_w.
	hc1411cx	unbezSonstige_w.
	hd15x		HHNetto_w.
	he16		Kindu10HH_w.
	hhtyp		HHTyp_w.
	anz_kind27	ledu27_w.
	juki		AlterjKu18_w.
	juki_gr		AKjuengstesKind_w.
	ha1_gr		AnzPersHH_w.
	soz_heb		SozStellHEB_w.
	anz_erw		AnzErwerb_w.
	pers_part_heb	PersNumHEB_w.
	anz_erwpart	Erwtpartn_w.
	gebiet		Geb_w.;


label

	id_hhx		=	"Haushalts-ID"
	berichtsjahr=	"Berichtsjahr"
	ha1x		=	"Anzahl der im Haushalt lebenden Personen"
	hb9x		=	"Wohnfläche Wohnung"
	hb10x		=	"Anzahl der Räume"
    hb11		=	"Eigentümer/Mieter/mietfrei"
    hb121a		=	"Auto"
    hb121bx		=	"Auto Anzahl"
    hb122a		=	"Computer"
    hb122bx		=	"Computer Anzahl"
    hb13		=	"Internetzugang"
    hc141a		=	"Unterstützung durch andere Personen: Kinderbetreuung"
    hc141bx		=	"Unterstützung durch andere Personen: bezahlte Stunden Kinderbetreuung"
    hc141cx		=	"Unterstützung durch andere Personen: unbezahlte Stunden Kinderbetreuung"
    hc142a		=	"Unterstützung durch andere Personen: Zubereitung von Mahlzeiten"
	hc142bx		=	"Unterstützung durch andere Personen: bezahlte Stunden Zubereitung von Mahlzeiten"
	hc142cx		=	"Unterstützung durch andere Personen: unbezahlte Stunden Zubereitung von Mahlzeiten"
	hc143a		=	"Unterstützung durch andere Personen: Putzen, Aufräumen, Waschen"
	hc143bx		=	"Unterstützung durch andere Personen: bezahlte Stunden Putzen, Aufräumen, Waschen"
	hc143cx		=	"Unterstützung durch andere Personen: unbezahlte Stunden Putzen, Aufräumen, Waschen"
	hc144a		=	"Unterstützung durch andere Personen: Nach dem Rechten sehen"
	hc144bx		=	"Unterstützung durch andere Personen: bezahlte Stunden nach dem Rechten sehen"
	hc144cx		=	"Unterstützung durch andere Personen: unbezahlte Stunden nach dem Rechten sehen"
	hc145a		=	"Unterstützung durch andere Personen: Gartenarbeit"
	hc145bx		=	"Unterstützung durch andere Personen: bezahlte Stunden Gartenarbeit"
	hc145cx		=	"Unterstützung durch andere Personen: unbezahlte Stunden Gartenarbeit"
	hc146a		=	"Unterstützung durch andere Personen: Einkaufen und Besorgungen"
	hc146bx		=	"Unterstützung durch andere Personen: bezahlte Stunden Einkaufen und Besorgungen"
	hc146cx		=	"Unterstützung durch andere Personen: unbezahlte Stunden Einkaufen und Besorgungen"
	hc147a		=	"Unterstützung durch andere Personen: Haustierpflege"
	hc147bx		=	"Unterstützung durch andere Personen: bezahlte Stunden Haustierpflege"
	hc147cx		=	"Unterstützung durch andere Personen: unbezahlte Stunden Haustierpflege"
    hc148a		=	"Unterstützung durch andere Personen: Reparatur von Fahrzeugen"
	hc148bx		=	"Unterstützung durch andere Personen: bezahlte Stunden Reparatur von Fahrzeugen"
	hc148cx		=	"Unterstützung durch andere Personen: unbezahlte Stunden Reparatur von Fahrzeugen"
	hc149a		=	"Unterstützung durch andere Personen: Reparieren und Bauen"
	hc149bx		=	"Unterstützung durch andere Personen: bezahlte Stunden Reparieren und Bauen"
	hc149cx		=	"Unterstützung durch andere Personen: unbezahlte Stunden Reparieren und Bauen"
	hc1410a		=	"Unterstützung durch andere Personen: Versicherungs-, Behördenangelegenheiten"
	hc1410bx	=	"Unterstützung durch andere Personen: bezahlte Stunden Versicherungs-, Behördenangelegenheiten"	
	hc1410c		=	"Unterstützung durch andere Personen: unbezahlte Stunden Versicherungs-, Behördenangelegenheiten"
	hc1411a		=	"Unterstützung durch andere Personen: Sonstige Unterstützung"
	hc1411b		=	"Unterstützung durch andere Personen: bezahlte Stunden Sonstige Unterstützung"
	hc1411cx	=	"Unterstützung durch andere Personen: unbezahlte Stunden Sonstige Unterstützung"	
	hd15x		=	"Monatliches Haushaltsnettoeinkommen"
	he16		=	"Kinder unter 10 Jahren im Haushalt"
	he17anzx	=	"Anzahl der Kinder unter 10 Jahren"
	hrfh95		=	"Hochrechnungsfaktor für den Haushalt multipliziert mit 100(ohne Nachkommastelle)"
	hhtyp		=	"Haushaltstyp"
	gebiet		=	"Gebiet"
	anz_kind27	=	"Anzahl der ledigen Kindern unter 27 Jahren"
	juki		=	"Alter des jüngsten Kindes in Haushalten mit Kindern unter 18 Jahren"
	juki_gr		=	"Altersklasse des jüngsten Kindes in Haushalten mit Kindern unter 18 Jahren"
	ha1_gr		=	"Anzahl der im Haushalt lebenden Personen"
	soz_heb		=	"Soziale Stellung des Haupteinkommensbeziehers"
	pers_part_heb	="Personennummer des Partners des Haupteinkommensbeziehers"
	anz_erwpart	=	"Anzahl der Erwerbstätigen innerhalb der Partnerschaft (Haupteinkommensbezieher/Lebenspartner)"
	anz_erw		=	"Anzahl der Erwerbstätigen im Haushalt"	
	;	
run;

/*  (II)  ZVE 13 HH                      */
/*	(iv)  Löschen nicht mehr benötigter temporärer Dateien	*/

proc datasets lib=work nolist;
	delete	&dateiname1;
run;


/********************************************************************************************************/
/********************************************************************************************************/
/********************************************************************************************************/


/* (III) ZVE 13 PERS                 */
/* (i)	 Einlesen der CSV-Datei		*/

proc import 
	datafile		=	"&pfad2./&CSVdatei2"	
	out				=	&dateiname2   
	dbms			=	dlm
	replace;
	delimiter		=	";";
 	getnames		=	yes;
run;


/* (III) ZVE 13 PERS                 */
/* (ii)	 Definition der Wertelabels, die temporär in WORK gespeichert werden */

proc format lib=work;

value Alter_w									0 = "0 bis unter 3 Jahren"
												3 = "3 bis unter 6 Jahren"
												6 = "6 Jahre"
												7 = "7 bis unter 10 Jahren"
												75 = "75 Jahre und älter";

value Geschlecht_w								1 = "männlich"
												2 = "weiblich";

value Familienstand_w						   -1 = "keine Angabe" 
												1 = "ledig "
												2 = "Verheiratet und Ehepartner lebt im Haushalt"
												3 = "Geschieden/Verheiratet und dauernd getrennt lebend"
												4 = "Verwitwet";
						
value Stellung_im_Haushalt_w					1 = "Haupteinkommensbezieher"
												2 = "Ehe-, Lebenspartner/-in"
												3 = "Kind"
												4 = "Bruder/Schwester"
												5 = "Enkelkind"
												6 = "Vater/Mutter"
												7 = "Großvater/Großmutter"
												8 = "Anders verwandt/verschwägert"
												9 = "Nicht verwandt/verschwägert";

value Erste_Staatsangehoerigkeit_w				1 = "Deutsche Staatsangehörigkeit"
												2 = "Sonstige Staatsangehörigkeit, staatenlos";

value Geburtsland_w							   -1 = "keine Angabe"
												1 = "Deutschland"
												2 = "Sonstiges Land";

value Eltern_betreut_w						   -2 = "trifft nicht zu"
												1 = "ja"
												2 = "nein";

value Kinderbetreuung1_w						-2 = "trifft nicht zu"
												 0 = "keine Betreuung durch Tagesmutter/Tagesvater, Krippe, Kindertagesstätte, vorschulische Einrichtungen, Hort"
												10 = "1-10 Stunden"
												15 = "11-15 Stunden"
												20 = "16-20 Stunden"
												25 = "21-25 Stunden"
												30 = "26-30 Stunden"
												40 = "31-40 Stunden"
												41 = "41 Stunden und mehr";
			
value VerwandteFreundeNachbarn_w				-2 = "trifft nicht zu"
												21 = "21 Stunden und mehr";

value BetreuungTage_w							-1 = "keine Angabe"
												-2 = "trifft nicht zu"
												 5 = "5 Tage und mehr";

value Schule_w									-2 = "trifft nicht zu"
												 1 = "Kind geht nicht zur Schule"
												 2 = "Kind geht zur Schule";

value Unterrichtsstunden_w						-2 = "trifft nicht zu"
												20 = "15-20 Stunden"
												40 = "31-40 Stunden";

value TeilnahmeAGs_w							-1 = "keine Angabe" 
												-2 = "trifft nicht zu"
												 1 = "Keine Teilnahme an AGs" 
												 2 = "Teilnahme an AGs";

value AGStunden_w								-1 = "keine Angabe" 
												-2 = "trifft nicht zu"
												 5 = "5 Stunden und mehr";

value Zeitstunden_w								-2 = "trifft nicht zu"
												50 = "41-50 Stunden";

value MittagesseninBetreu_w						-1 = "keine Angabe" 
												-2 = "trifft nicht zu" 
												 0 = "nein"
												 1 = "ja";

value Hausaufgabenbetreuung_w					-1 = "keine Angabe" 
												-2 = "trifft nicht zu"
												 0 = "nein"
												 1 = "ja";

value SprachfoerderunginDeutsch_w				-1 = "keine Angabe" 
												-2 = "trifft nicht zu"
												 0 = "nein"
												 1 = "ja";

value Nachhilfe_w								 -1 = "keine Angabe" 
												 -2 = "trifft nicht zu"
												  0 = "nein"
												  1 = "ja";

value MusikalischeFrueherziehung_w				-1 = "keine Angabe" 
												-2 = "trifft nicht zu" 
												 0 = "nein" 
												 1 = "ja";

value keineBetreu_w								-1 = "keine Angabe" 
												-2 = "trifft nicht zu"
												 1 = "ja" 
												 2 = "nein";

value Sonstige_Kurse_w							-1 = "keine Angabe" 
												-2 = "trifft nicht zu"
												 0 = "nein"
												 1 = "ja";

value SportausserhalbBetreu_w					-1 = "keine Angabe"
												-2 = "trifft nicht zu"
												 6 = "6 Stunden und mehr";

value Singen1_w									-1 = "keine Angabe"
												-2 = "trifft nicht zu"
												 3 = "3 Stunden und mehr";

value Malen_w									-1 = "keine Angabe"
												-2 = "trifft nicht zu"
												 3 = "3 Stunden und mehr";

value TheaterTanz12Monaten1_w					-1 = "keine Angabe"
												-2 = "trifft nicht zu"
												 2 = "2 Stunden und mehr";

value keineAngebotele_w							-1 = "keine Angabe" 
												-2 = "trifft nicht zu" 
												 1 = "ja" 
												 2 = "nein";

value SonstigesAngebotSchule_w					-1 = "keine Angabe"
												-2 = "trifft nicht zu";

value AusgefuellterPF_w							-2 = "trifft nicht zu"
												 1 = "ja"
												 2 = "nein";

value Lebenssituation_w							-1 = "keine Angabe" 
												-2 = "trifft nicht zu"
												 1 = "Selbstständiger, Freiberufler, Landwirt, mithelfender Familienangehöriger"
												 2 = "Angestellter, Arbeiter, Beamter, Richter, Zeit-/Berufssoldat, Freiwillig soziales/ökologisches/kulturelles Jahr, freiwilliger Wehrdienst, Bundesfreiwilligendienst"
												 3 = "Auszubildender (auch Praktikant,Volontär)" 
												 4 = "In Altersteilzeit (Arbeits- und Freistellungsphase)" 
												 5 = "In Elternzeit (mit ungekündigtem Arbeitsvertrag)"
												 6 = "Schüler, Student" 
												 7 = "Arbeitslos" 
												 8 = "Im Ruhestand oder Vorruhestand"
												 9 = "Dauerhaft erwerbsunfähig" 
												10 = "Hausfrau/Hausmann" 
												11 = "Aus anderen Gründen nicht erwerbstätig";

value StundeBezahlunggearbeitet_w				-1 = "keine Angabe" 
												-2 = "trifft nicht zu"
												 1 = "ja"
												 2 = "nein";

value Haupterwerbstaetigkeit_w					-1 = "keine Angabe"
												-2 = "trifft nicht zu"
												 1 = "Angestellter, freiwilliger Wehrdienst, Freiwilligendienst, Freiwilliges soziales/ökologisches/kulturelles Jahr"
												 2 = "Arbeiter"
												 3 = "Beamter"
												 4 = "Selbstständiger, Landwirt, Mithelf. Familienangehöriger";

value ARTBeschaeftiHBE_w						-1 = "keine Angabe" 
												-2 = "trifft nicht zu"
												 1 = "unbefristet" 
												 2 = "befristet";

value VollzeitTeilzeitHET_w						-1 = "keine Angabe" 
												-2 = "trifft nicht zu"
												 1 = "Vollzeit" 
												 2 = "Teilzeit";

value StundenHET_w								-1 = "keine Angabe" 
												-2 = "trifft nicht zu"
												 3 = "0 bis 3 Stunden"
												60 = "60 Stunden und mehr";

value WunschHET_w								-1 = "keine Angabe" 
												-2 = "trifft nicht zu"
												 3 = "0 bis 3 Stunden"
												60 = "60 Stunden und mehr";

value geringHET_w								-1 = "keine Angabe" 
												-2 = "trifft nicht zu"
												 1 = "ja" 
												 2 = "nein";

value zweigHET_w								-1 = "keine Angabe" 
												-2 = "trifft nicht zu"
												 1 = "Land- und Forstwirtschaft, Fischerei" 
												 2 = "Bergbau und Gewinnung von Erdöl, Erdgas, Steinen" 
												 3 = "Verarbeitendes Gewerbe/Herstellung von Waren" 
    											 4 = "Energieversorgung, Wasserversorgung, Abwasser, Abfallentsorgung, Bergbau und Gewinnung von Erdöl, Erdgas, Steinen"
												 6 = "Baugewerbe, Hoch- und Tiefbau"
												 7 = "Groß- und Einzelhandel Reparatur von Kraftfahrzeugen"
												 8 = "Personen- und Güterverkehr, Lagerei"
												 9 = "Gastgewerbe/Beherbergung und Gastronomie"
												10 = "Information und Kommunikation" 
												11 = "Banken/Finanz- und Versicherungsdienstleister"
												12 = "Grundstücks- und Wohnungswesen"
												13 = "Freiberufliche, wissenschaftl., technische Dienstleistungen"
												14 = "Sonstige wirtschaftliche Dienstleistungen"
												15 = "Öffentliche Verwaltung, Gerichte, Verteidigung, Sicherheit"
												16 = "Erziehung und Unterricht"
												17 = "Gesundheits- und Sozialwesen"
												18 = "Sonstige überwiegend personenbezogene Dienstleistungen"
												19 = "Kunst, Unterhaltung, Sport und Erholung" 
												20 = "Gewerkschaft, Verband, Partei, kirchliche Vereinigung"
												22 = "Privater Haushalt mit Beschäftigten";

value OrtHET_w									-1 = "keine Angabe" 
												-2 = "trifft nicht zu"
												 1 = "Kilometerangabe"
												 2 = "Ständig wechselnde Arbeitsstätte"
												 3 = "Arbeitsstätte im gleichen Gebäude";

value KMHET_w									-1 = "keine Angabe" 
												-2 = "trifft nicht zu"
												 1 = "bis 1 km"
												90 = "90 km und mehr";

value wegHET_w									 -1 = "keine Angabe" 
												 -2 = "trifft nicht zu"
												100 =  "100 min und mehr";

value ABZgestaltung_w							-1 = "keine Angabe" 
												-2 = "trifft nicht zu"
												 1 = "Feststehende Anfangs- und Schlusszeiten" 
												 2 = "Gleitzeit" 
												 3 = "Freie Arbeitszeitgestaltung";

 value SchichtarbeitHET_w						-1 = "keine Angabe"
												-2 = "trifft nicht zu"
												 1 = "ja" 
												 2 = "nein";

value  FruehschichtHET_w						-1 = "keine Angabe" 
												-2 = "trifft nicht zu"
												 0 = "nein" 
												 1 = "ja";

value SpaetschichtHET_w							-1 = "keine Angabe" 
												-2 = "trifft nicht zu"
												 0 = "nein" 
												 1 = "ja";

value HausHET_w									-1 = "keine Angabe"
												-2 = "trifft nicht zu"
												 1 = "ja" 
												 2 = "nein";

value WEHET_w									-1 = "keine Angabe" 
												-2 = "trifft nicht zu"
												 1 = "Jedes Wochenende" 
												 2 = "Jedes zweite Wochenende"
												 3 = "Jedes dritte oder vierte Wochenende" 
												 4 = "Seltener" 
												 5 = "Nie";
	
value  Nebenerwerbstaetig_w						-1 = "keine Angabe" 
												-2 = "trifft nicht zu"
												 1 = "ja" 
												 2 = "nein";

value  AnzNebenerwerbstaetigkeiten_w			-1 = "keine Angabe" 
												-2 = "trifft nicht zu"
												 2 = "2 oder mehr";

value MonNET_w									-1 = "keine Angabe" 
												-2 = "trifft nicht zu";

value  TagepMonNET_w							-1 = "keine Angabe" 
												-2 = "trifft nicht zu";

value  StproTagNET_w							-1 = "keine Angabe" 
												-2 = "trifft nicht zu";

value  EKausHET_w								-1 = "keine Angabe" 
												-2 = "trifft nicht zu"
												 1 = "Unter 900 Euro"
												 2 = "900 bis unter 1300 Euro"
												 3 = "1300 bis unter 1700 Euro"
												 4 = "1700 bis unter 2300 Euro"
												 5 = "2300 Euro oder mehr"; 

value Schulbesuch_w								-1 = "keine Angabe" 
												-2 = "trifft nicht zu"
												 1 = "ja" 
												 2 = "nein";

value ArtderSchule_w							-1 = "keine Angabe"
												-2 = "trifft nicht zu"
												 1 = "allgemeinbildende Schule"
												 2 = "berufliche Schule";

value UStdproWoche_w							-1 = "keine Angabe" 
												-2 = "trifft nicht zu"
												 7 = "unter 8 Stunden"
												41 = "41 bis 45 Stunden";

value TeilnahmeanAGs_w							-1 = "keine Angabe" 
												-2 = "trifft nicht zu"
												 1 = "Teilnahme an AGs" 
												 2 = "Keine Teilnahme an AGs";

value AGStundenpW_w								-1 = "keine Angabe" 
												-2 = "trifft nicht zu"
												 5 = "5 Stunden und mehr";

value Zeitins_w									-1 = "keine Angabe" 
												-2 = "trifft nicht zu"
												 7 = "unter 8 Stunden"
												45 = "45 Stunden und mehr";

value SportausserSchule_w						-1 = "keine Angabe" 
												-2 = "trifft nicht zu"
												 1 = "ja" 
												 2 = "nein";

value SportausserhalbderSchule_w				-1 = "keine Angabe" 
												-2 = "trifft nicht zu"
												11 = "11 Stunden und mehr";

value Sprachfoerderung_w						-1 = "keine Angabe" 
												-2 = "trifft nicht zu"
												 1 = "ja" 
												 2 = "nein";

value StundenSprachfoerderung_w					-1 = "keine Angabe" 
												-2 = "trifft nicht zu"
												 2 = "2 Stunden und mehr";


value SprachfoerderungandereSprache_w			-1 = "keine Angabe"
												-2 = "trifft nicht zu"
												 1 = "ja" 
												 2 = "nein";
													
value StundenSprachfoerderungandere_w			-1 = "keine Angabe" 
												-2 = "trifft nicht zu"
												 2 = "2 Stunden und mehr";

value Nachhilfeausserhalb_w						-1 = "keine Angabe"
												-2 = "trifft nicht zu"
												 1 = "ja" 
												 2 = "nein";

value StundenNachhilfeausserhal_w				-1 = "keine Angabe"
												-2 = "trifft nicht zu"
												 4 = "4 Stunden und mehr";

value Kino12Monaten_w							-1 = "keine Angabe" 
												-2 = "trifft nicht zu"
												 1 = "ja" 
												 2 = "nein";

value HaeufigkeitKin12Monaten_w					-1 = "keine Angabe" 
												-2 = "trifft nicht zu";

value TheaterTanz12Monaten_w					-1 = "keine Angabe"
												-2 = "trifft nicht zu"
												 1 = "ja"
												 2 = "nein";

value  TheaterTanz12Monaten2_w					-1 = "keine Angabe" 
												-2 = "trifft nicht zu";
	
value  KonzertOperMusica12Monaten_w				-1 = "keine Angabe" 
												-2 = "trifft nicht zu"
												 1 = "ja" 
												 2 = "nein";

value  HaeufigkeitKOM12Monaten_w				-1 = "keine Angabe" 
												-2 = "trifft nicht zu";

value  KunstMuseum12Monaten_w					-1 = "keine Angabe" 
												-2 = "trifft nicht zu"
												 1 = "ja" 
												 2 = "nein";

value  HaeufigkeitKunst12Monaten_w				-1 = "keine Angabe" 
												-2 = "trifft nicht zu";

value  BibliothekBuecherei12Monate_w			-1 = "keine Angabe" 
												-2 = "trifft nicht zu"
												 1 = "ja" 
												 2 = "nein";
		
value  HaeufigkeitBBMonate_w					-1 = "keine Angabe" 
												-2 = "trifft nicht zu";

value  Sonstigekultur_w							-1 = "keine Angabe" 
												-2 = "trifft nicht zu"
												 1 = "ja" 
												 2 = "nein";

value  Haeufigkeitsonstigekultur_w				-1 = "keine Angabe" 
												-2 = "trifft nicht zu";

value  Singen_w									-1 = "keine Angabe" 
												-2 = "trifft nicht zu"
												 1 = "ja" 
												 2 = "nein";

value  StundenSingen_w							-1 = "keine Angabe" 
												-2 = "trifft nicht zu";

value  Musikinstrument_w						-1 = "keine Angabe" 
												-2 = "trifft nicht zu"
												 1 = "ja" 
												 2 = "nein";

value  StundenMusikinstrument_w					-1 = "keine Angabe" 
												-2 = "trifft nicht zu";

value  MalenZeichnenDrucken_w					-1 = "keine Angabe" 
												-2 = "trifft nicht zu"
												 1 = "ja" 
												 2 = "nein";
												
value  StundenMalenZeichnenDrucken_w			-1 = "keine Angabe" 
												-2 = "trifft nicht zu";

value  TheaterTanz12Monaten_w					-1 = "keine Angabe"
												-2 = "trifft nicht zu"
												 3 = "3 Stunden und mehr";

value  WerkenNaehen_w							-1 = "keine Angabe" 
												-2 = "trifft nicht zu"
												 1 = "ja" 
												 2 = "nein";

value StundenWerkenNaehen_w						-1 = "keine Angabe" 
												-2 = "trifft nicht zu";


value  StundenTanzen_w							-1 = "keine Angabe"
												-2 = "trifft nicht zu";

value  Theater_w								-1 = "keine Angabe" 
												-2 = "trifft nicht zu"
												 1 = "ja" 
												 2 = "nein";

value  StundenTheater_w							-1 = "keine Angabe"
												-2 = "trifft nicht zu";

value  SchreibenDichten_w						-1 = "keine Angabe" 
												-2 = "trifft nicht zu"
												 1 = "ja" 
												 2 = "nein";


value  StundenSchreibenDichten_w				-1 = "keine Angabe"
												-2 = "trifft nicht zu";

value  FilmenFotografieren_w					-1 = "keine Angabe" 
												-2 = "trifft nicht zu"
												 1 = "ja" 
												 2 = "nein";

value  StundenFilmenFotografieren_w				-1 = "keine Angabe"
												-2 = "trifft nicht zu";

value  Literaturkreis_w							-1 = "keine Angabe" 
												-2 = "trifft nicht zu"
												 1 = "ja" 
												 2 = "nein";

value StundenLiteraturkreis_w					-1 = "keine Angabe"
												-2 = "trifft nicht zu";

value  SonstigekulturelleAktivitaeten_w			-1 = "keine Angabe" 
												-2 = "trifft nicht zu"
												 1 = "ja" 
												 2 = "nein";

value  StundensonstigekA_w						-1 = "keine Angabe"
												-2 = "trifft nicht zu";

value SportundBewegung12_w						-1 = "keine Angabe" 
												-2 = "trifft nicht zu"
												 1 = "ja" 
												 2 = "nein";

value KulturundMusik12_w						-1 = "keine Angabe" 
												-2 = "trifft nicht zu"
												 1 = "ja" 
												 2 = "nein";

value SchuleundKindergarten12_w					-1 = "keine Angabe" 
												-2 = "trifft nicht zu"
												 1 = "ja" 
												 2 = "nein";

value religioese12_w							-1 = "keine Angabe" 
												-2 = "trifft nicht zu"
												 1 = "ja" 
												 2 = "nein";

value SozialerBereich12_w						-1 = "keine Angabe" 
												-2 = "trifft nicht zu"
												 1 = "ja" 
												 2 = "nein";

value Politik12_w								-1 = "keine Angabe" 
												-2 = "trifft nicht zu"
												 1 = "ja" 
												 2 = "nein";

value BuergerschaftlicheAktivitaet12_w			-1 = "keine Angabe" 
												-2 = "trifft nicht zu"
												 1 = "ja" 
												 2 = "nein";

value BeruflicheInteressenBetrieb12_w			-1 = "keine Angabe" 
												-2 = "trifft nicht zu"
												 1 = "ja" 
												 2 = "nein";

value Umwelt12_w								-1 = "keine Angabe" 
												-2 = "trifft nicht zu"
												 1 = "ja" 
												 2 = "nein";

value Jugendarbeit12_w							-1 = "keine Angabe" 
												-2 = "trifft nicht zu"
												 1 = "ja" 
												 2 = "nein";

value UnfallRettungFeuerwehr12_w				-1 = "keine Angabe" 
												-2 = "trifft nicht zu"
												 1 = "ja" 
												 2 = "nein";

value Gesundheit12_w							-1 = "keine Angabe" 
												-2 = "trifft nicht zu"
												 1 = "ja" 
												 2 = "nein";

value Justiz12_w								-1 = "keine Angabe" 
												-2 = "trifft nicht zu"
												 1 = "ja" 
												 2 = "nein";

value Freizeit12_w								-1 = "keine Angabe" 
												-2 = "trifft nicht zu"
												 1 = "ja" 
												 2 = "nein";

value ZeitaufwandfE_w							-1 = "keine Angabe" 
												-2 = "trifft nicht zu"
												 1 = "unter 3 Std. pro Monat"
												 2 = "3 - 5 Std. pro Monat"
												 3 = "6 - 10 Std. pro Monat" 
												 4 = "11 - 20 Std. pro Monat"
												 5 = "21 - 40 Std. pro Monat"
												 6 = "über 40 Std. pro Monat"
												 7 = "Nicht freiwillig engagiert";

value Kinderbetreuung_w							-1 = "keine Angabe" 
												-2 = "trifft nicht zu"
												 1 = "ja" 
												 2 = "nein";

value SpWKinderbetreuung_w						-1 = "keine Angabe" 
												-2 = "trifft nicht zu";

value ZubereitungvMahlzeiten_w					-1 = "keine Angabe" 
												-2 = "trifft nicht zu"
												 1 = "ja" 
												 2 = "nein";

value SpWMahlzeiten_w							-1 = "keine Angabe" 
												-2 = "trifft nicht zu";

value Putzen_w									-1 = "keine Angabe" 
												-2 = "trifft nicht zu"
												 1 = "ja" 
												 2 = "nein";

value SpW_Putzen_w								-1 = "keine Angabe" 
												-2 = "trifft nicht zu";

value Aufsicht_w								-1 = "keine Angabe" 
												-2 = "trifft nicht zu"
												 1 = "ja" 
												 2 = "nein";

value SpW_Aufsicht_w							-1 = "keine Angabe"
												-2 = "trifft nicht zu";
									
value Gartenarbeit_w							-1 = "keine Angabe" 
												-2 = "trifft nicht zu"
												 1 = "ja" 
												 2 = "nein";

value SpW_Gartenarbeit_w						-1 = "keine Angabe" 
												-2 = "trifft nicht zu";

value Einkaufen_w								-1 = "keine Angabe" 
												-2 = "trifft nicht zu"
												 1 = "ja" 
												 2 = "nein";

value SpW_Einkaufen_w							-1 = "keine Angabe" 
												-2 = "trifft nicht zu";

value Haustierpflege_w							-1 = "keine Angabe" 
												-2 = "trifft nicht zu"
												 1 = "ja" 
												 2 = "nein";

value SpW_Haustierpflege_w						-1 = "keine Angabe" 
												-2 = "trifft nicht zu";

value Fahrzeuge_w								-1 = "keine Angabe" 
												-2 = "trifft nicht zu"
												 1 = "ja"
												 2 = "nein";

value SpW_Fahrzeuge_w							-1 = "keine Angabe" 
												-2 = "trifft nicht zu";

value ReparierenundBauen_w						-1 = "keine Angabe" 
												-2 = "trifft nicht zu"
												 1 = "ja" 
												 2 = "nein";

value SpW_ReparierenundBauen_w					-1 = "keine Angabe" 
												-2 = "trifft nicht zu";

value VersicherungsBa_w							-1 = "keine Angabe" 
												-2 = "trifft nicht zu"
												 1 = "ja" 
												 2 = "nein";

value SpW_VersicherungsBa_w						-1 = "keine Angabe" 
												-2 = "trifft nicht zu";

value SonstigeUnterstuetzung_w					-1 = "keine Angabe" 
												-2 = "trifft nicht zu"
												 1 = "ja" 
												 2 = "nein";

value SpW_sonstigeUnterstuetzung_w				-1 = "keine Angabe" 
												-2 = "trifft nicht zu";

value Zve4WochenKinder_w						-1 = "keine Angabe" 
												-2 = "trifft nicht zu"
												 1 = "Völlig ausreichend" 
												 2 = "Eher ausreichend" 
												 3 = "Teils/teils" 
												 4 = "Eher nicht ausreichend" 
												 5 = "Gar nicht ausreichend" 
												 9 = "für mich nicht zutreffend";

value Zve4WochenPartner_w						-1 = "keine Angabe" 
												-2 = "trifft nicht zu"
												 1 = "Völlig ausreichend"
												 2 = "Eher ausreichend" 
												 3 = "Teils/teils" 
												 4 = "Eher nicht ausreichend" 
												 5 = "Gar nicht ausreichend" 
												 9 = "für mich nicht zutreffend";

value Zve4WochenFamilienangehoerige_w			-1 = "keine Angabe" 
												-2 = "trifft nicht zu"
												 1 = "Völlig ausreichend"
												 2 = "Eher ausreichend" 
												 3 = "Teils/teils" 
												 4 = "Eher nicht ausreichend" 
												 5 = "Gar nicht ausreichend" 
												 9 = "für mich nicht zutreffend";

value Zve4WochenFreunde_w						-1 = "keine Angabe" 
												-2 = "trifft nicht zu"
												 1 = "Völlig ausreichend" 
												 2 = "Eher ausreichend" 
												 3 = "Teils/teils" 
												 4 = "Eher nicht ausreichend"
												 5 = "Gar nicht ausreichend" 
												 9 = "für mich nicht zutreffend";

value Zve4WochenHausarbeit_w					-1 = "keine Angabe" 
												-2 = "trifft nicht zu"
												 1 = "Völlig ausreichend" 
												 2 = "Eher ausreichend" 
												 3 = "Teils/teils" 
												 4 = "Eher nicht ausreichend" 
												 5 = "Gar nicht ausreichend" 
												 9 = "für mich nicht zutreffend";

value Zve4WochenErwerbsarbeit_w					-1 = "keine Angabe" 
												-2 = "trifft nicht zu"
												 1 = "Völlig ausreichend "
												 2 = "Eher ausreichend" 
												 3 = "Teils/teils"
												 4 = "Eher nicht ausreichend"
												 5 = "Gar nicht ausreichend" 
												 9 = "für mich nicht zutreffend";

value Zve4WochenAusbildung_w					-1 = "keine Angabe" 
												-2 = "trifft nicht zu"
												 1 = "Völlig ausreichend" 
												 2 = "Eher ausreichend" 
												 3 = "Teils/teils" 
												 4 = "Eher nicht ausreichend" 
												 5 = "Gar nicht ausreichend" 
												 9 = "für mich nicht zutreffend";

value Zve4WochenWeiterbildung_w					-1 = "keine Angabe" 
												-2 = "trifft nicht zu"
												 1 = "Völlig ausreichend" 
												 2 = "Eher ausreichend" 
												 3 = "Teils/teils" 
												 4 = "Eher nicht ausreichend" 
												 5 = "Gar nicht ausreichend" 
												 9 = "für mich nicht zutreffend";

value Zve4WochenEhrenamt_w						-1 = "keine Angabe" 
												-2 = "trifft nicht zu"
												 1 = "Völlig ausreichend" 
												 2 = "Eher ausreichend" 
												 3 = "Teils/teils" 
												 4 = "Eher nicht ausreichend" 
												 5 = "Gar nicht ausreichend" 
												 9 = "für mich nicht zutreffend";

value Zve4WochenAusruhen_w						-1 = "keine Angabe" 
												-2 = "trifft nicht zu"
												 1 = "Völlig ausreichend" 
												 2 = "Eher ausreichend" 
												 3 = "Teils/teils" 
												 4 = "Eher nicht ausreichend" 
												 5 = "Gar nicht ausreichend";

value Zve4WochenInteressen_w					-1 = "keine Angabe" 
												-2 = "trifft nicht zu"
												 1 = "Völlig ausreichend" 
												 2 = "Eher ausreichend" 
												 3 = "Teils/teils" 
												 4 = "Eher nicht ausreichend" 
												 5 = "Gar nicht ausreichend";

value Zve4WochenArztbesuche_w					-1 = "keine Angabe" 
												-2 = "trifft nicht zu"
												 1 = "Völlig ausreichend" 
												 2 = "Eher ausreichend" 
												 3 = "Teils/teils" 
												 4 = "Eher nicht ausreichend" 
												 5 = "Gar nicht ausreichend" 
												 9 = "für mich nicht zutreffend";

value Zve4WochenBesorgungen_w					-1 = "keine Angabe" 
												-2 = "trifft nicht zu"
												 1 = "Völlig ausreichend" 
												 2 = "Eher ausreichend" 
												 3 = "Teils/teils" 
												 4 = "Eher nicht ausreichend"
												 5 = "Gar nicht ausreichend"
												 9 = "für mich nicht zutreffend";
	
value Tag_planen_w								-1 = "keine Angabe" 
												-2 = "trifft nicht zu"
												 1 = "Stimme voll und ganz zu" 
												 2 = "Stimme eher zu" 
												 3 = "Teils/teils" 
												 4 = "Stimme eher nicht zu" 
												 5 = "Stimme ganz und gar nicht zu";

value HaeufigZeitdruck_w						-1 = "keine Angabe" 
												-2 = "trifft nicht zu"
												 1 = "Stimme voll und ganz zu" 
												 2 = "Stimme eher zu" 
												 3 = "Teils/teils" 
												 4 = "Stimme eher nicht zu" 
												 5 = "Stimme ganz und gar nicht zu";

value ausschlafen_w								-1 = "keine Angabe" 
												-2 = "trifft nicht zu"
												 1 = "Stimme voll und ganz zu" 
												 2 = "Stimme eher zu" 
												 3 = "Teils/teils" 
												 4 = "Stimme eher nicht zu" 
												 5 = "Stimme ganz und gar nicht zu";

value Zeit_fuer_sich_w							-1 = "keine Angabe" 
												-2 = "trifft nicht zu"
												 1 = "Stimme voll und ganz zu" 
												 2 = "Stimme eher zu" 
												 3 = "Teils/teils" 
												 4 = "Stimme eher nicht zu" 
												 5 = "Stimme ganz und gar nicht zu";

value Zeit_fuer_Familie_w						-1 = "keine Angabe" 
												-2 = "trifft nicht zu"
												 1 = "Stimme voll und ganz zu" 
												 2 = "Stimme eher zu"
												 3 = "Teils/teils" 
												 4 = "Stimme eher nicht zu" 
												 5 = "Stimme ganz und gar nicht zu";

value Zeit_fuer_Freunde_w						-1 = "keine Angabe" 
												-2 = "trifft nicht zu"
												 1 = "Stimme voll und ganz zu" 
												 2 = "Stimme eher zu" 
												 3 = "Teils/teils"
												 4 = "Stimme eher nicht zu" 
												 5 = "Stimme ganz und gar nicht zu";

value WunschZeitAnzAkti_w						-1 = "keine Angabe" 
												-2 = "trifft nicht zu";

value Aktivitaet1mehrZeit_w						-1 = "keine Angabe" 
												-2 = "trifft nicht zu";

value Aktivitaet2mehrZeit_w						-1 = "keine Angabe"
												-2 = "trifft nicht zu";

value Aktivitaet3mehrZeit_w						-1 = "keine Angabe" 
												-2 = "trifft nicht zu";

value Aktivitaet4mehrZeit_w						-1 = "keine Angabe"
												-2 = "trifft nicht zu";

value Aktivitaet5mehrZeit_w						-1 = "keine Angabe"
												-2 = "trifft nicht zu";

value Altersgruppen_w							1 = "0 bis unter 10 Jahren"
												2 = "10 bis unter 18 Jahren"
												3 = "18 bis unter 25 Jahren"
												4 = "25 bis unter 45 Jahren"
												5 = "45 bis unter 65 Jahren"
												6 = "65 Jahre und älter";

value Altersgruppen_ab10_w						-2 = "trifft nicht zu"
												 1 = "10 bis unter 12 Jahren"
												 2 = "12 bis unter 18 Jahren"
												 3 = "18 bis unter 25 Jahren"
												 4 = "25 bis unter 45 Jahren"
												 5 = "45 bis unter 65 Jahren"
												 6 = "65 Jahre und älter";

value SozialeStellung_w							-1 = "keine Angabe"
												-2 = "trifft nicht zu (Person unter 16 Jahren)"
												 1 = "Selbstständiger"
												 2 = "Beamter"
												 3 = "Angestellter, Auszubildender, Freiwilliger Wehrdienst, Freiwilligendienst, Freiwilliges soziales/ökologisches/kulturelles Jahr"
												 4 = "Arbeiter"
												 5 = "Schüler, Student"
												 6 = "Rentner, Pensionär"
												 7 = "Arbeitsloser"
												 8 = "sonstige Nichterwerbstätiger";

value Erwerbstaetigkeit_w						-1 = "keine Angabe"
												-2 = "trifft nicht zu (Person unter 16 Jahren)"
												 1 = "Vollzeit erwerbstätig"
												 2 = "Teilzeit erwerbstätig"
												 3 = "nicht erwerbstätig";

value ISCED97Level_w							-1 = "keine Angabe"
												-2 = "trifft nicht zu (Person unter 10 Jahren)"
												 1 = "ISCED 1"
												 2 = "ISCED 2"
												 3 = "ISCED 3"
												 4 = "ISCED 4"
												 5 = "ISCED 5"
												 6 = "ISCED 6";

value Bildung_typisiert_w						-1 = "keine Angabe"
												-2 = "trifft nicht zu (Person unter 16 Jahren)"
												 1 = "keine, niedrige Bildung (ISCED 1+2)"
												 2 = "mittlere Bildung (ISCED 3+4)"
												 3 = "hohe Bildung (ISCED 5+6)";

value Hoechster_Abschluss_typisiert_w			-1 = "keine Angabe"
												-2 = "trifft nicht zu (Person unter 10 Jahren)"
												 1 = "Kein (oder noch kein) beruflicher Ausbildungsabschluss, Hochschul- oder Fachhochschulabschluss"
												 2 = "Anlernausbildung, berufliches Praktikum, Berufsvorbereitungsjahr"
												 3 = "Lehre, Berufsausbildung, Vorbereitungsdienst für den mittleren Dienst in der öffentlichen Verwaltung, Berufsfachschule/Kollegschule, 1-jährige Schule des Gesundheitswesens"
												 4 = "2- oder 3-jährige Schule des Gesundheitswesens, Meister, Techniker oder gleichwertiger Fachschulabschluss, Fachakademie"
												 5 = "Fachschule der DDR"
												 6 = "Berufsakademie, Verwaltungs-Fachhochschule, Fachhochschule (auch Ingenieurschule), Universität, wissenschaftl. Abschluss, Kunsthochschule, Promotion";

value Erwerbstaetigkeit_Partner_w				-1 = "keine Angabe"
												-2 = "trifft nicht zu"
												 1 = "Vollzeit erwerbstätig"
												 2 = "Teilzeit erwerbstätig"
												 3 = "nicht erwerbstätig";
run;


/*  (III) ZVE 13 PERS                 */
/*	(iii) Zuweisung der Werte- und Variablenlabels zu den Variablen und Speichern als SAS-Datei		*/

data	ZVE2.&dateiname2;
set 	&dateiname2;

format 
alterx   	Alter_w.
ha3     	Geschlecht_w.
pa2x     	Familienstand_w.
ha6x     	Stellung_im_Haushalt_w.
ha71x     	Erste_Staatsangehoerigkeit_w.
ha8x         Geburtsland_w.
he181    	Eltern_betreut_w.
he18_kibetrx     Kinderbetreuung1_w.
he187x     	VerwandteFreundeNachbarn_w.
he19x     	BetreuungTage_w.
he201     	Schule_w.
he202x     	Unterrichtsstunden_w.
he211     	TeilnahmeAGs_w.
he212x     	AGStunden_w.
he22x     	Zeitstunden_w.
he231     	MittagesseninBetreu_w.
he232     	Hausaufgabenbetreuung_w.
he233     	SprachfoerderunginDeutsch_w.
he234     	Nachhilfe_w.
he235     	MusikalischeFrueherziehung_w.
he236     	keineBetreu_w.
he237     	Sonstige_Kurse_w.
he241x     	SportausserhalbBetreu_w.
he245x     	Singen1_w.
he246x     	Malen_w.
he247x     	TheaterTanz12Monaten1_w.
he248     	keineAngebotele_w.
he249x     	SonstigesAngebotSchule_w.
pfb_ausgef 	AusgefuellterPF_w.
pb3     	Lebenssituation_w.
pb4     	StundeBezahlunggearbeitet_w.
pc5x     	Haupterwerbstaetigkeit_w.
pc6     	ARTBeschaeftiHBE_w.
pc7     	VollzeitTeilzeitHET_w.
pc8x     	StundenHET_w.
pc9x     	WunschHET_w.
pc10     	geringHET_w.
pc11x     	zweigHET_w.
pc121     	OrtHET_w.
pc122x     	KMHET_w.
pc13x     	wegHET_w.
pc14     	ABZgestaltung_w.
pc15     	SchichtarbeitHET_w.
pc16_fruehsonstx   	FruehschichtHET_w.
pc16_spaetnachtx   	SpaetschichtHET_w.
pc17     	HausHET_w.
pc18     	WEHET_w.
pd191     	Nebenerwerbstaetig_w.
pd192x     	AnzNebenerwerbstaetigkeiten_w.
pd20     	MonNET_w.
pd21x     	TagepMonNET_w.
pd22x     	StproTagNET_w.
pe23x     	EKausHET_w.
pf24     	Schulbesuch_w.
pf25x     	ArtderSchule_w.
pf26x     	UStdproWoche_w.
pf271     	TeilnahmeanAGs_w.
pf272x     	AGStundenpW_w.
pf28x     	Zeitins_w.
pf291a     	SportausserSchule_w.
pf291bx    	SportausserhalbderSchule_w.
pf292a     	Sprachfoerderung_w.
pf292bx     StundenSprachfoerderung_w.
pf293a     	SprachfoerderungandereSprache_w.
pf293bx     StundenSprachfoerderungandere_w.
pf294a     	Nachhilfeausserhalb_w.
pf294bx     StundenNachhilfeausserhal_w.
pg321a     	Kino12Monaten_w.
pg321b     	HaeufigkeitKin12Monaten_w.
pg322a     	TheaterTanz12Monaten_w.
pg322b     	TheaterTanz12Monaten2_w.
pg323a     	KonzertOperMusica12Monaten_w.
pg323b     	HaeufigkeitKOM12Monaten_w.
pg324a     	KunstMuseum12Monaten_w.
pg324b     	HaeufigkeitKunst12Monaten_w.
pg325a     	BibliothekBuecherei12Monate_w.
pg325b     	HaeufigkeitBBMonate_w.
pg326a     	Sonstigekultur_w.
pg326b     	Haeufigkeitsonstigekultur_w.
pg331a     	Singen_w.
pg331b     	StundenSingen_w.
pg332a     	Musikinstrument_w.
pg332b     	StundenMusikinstrument_w.
pg333a     	MalenZeichnenDrucken_w.
pg333b     	StundenMalenZeichnenDrucken_w.
pg334a     	WerkenNaehen_w.
pg334b     	StundenWerkenNaehen_w.
pg335a     	TheaterTanz12Monaten_w.
pg335b     	StundenTanzen_w.
pg336a     	Theater_w.
pg336b     	StundenTheater_w.
pg337a     	SchreibenDichten_w.
pg337b     	StundenSchreibenDichten_w.
pg338a     	FilmenFotografieren_w.
pg338b     	StundenFilmenFotografieren_w.
pg339a     	Literaturkreis_w.
pg339b     	StundenLiteraturkreis_w.
pg3310a    	SonstigekulturelleAktivitaeten_w.
pg3310b     StundensonstigekA_w.
ph341     	SportundBewegung12_w.
ph342     	KulturundMusik12_w.
ph343     	SchuleundKindergarten12_w.
ph344     	religioese12_w.
ph345     	SozialerBereich12_w.
ph346     	Politik12_w.
ph347     	BuergerschaftlicheAktivitaet12_w.
ph348     	BeruflicheInteressenBetrieb12_w.
ph349     	Umwelt12_w.
ph3410     	Jugendarbeit12_w.
ph3411     	UnfallRettungFeuerwehr12_w.
ph3412     	Gesundheit12_w.
ph3413     	Justiz12_w.
ph3414     	Freizeit12_w.
ph35     	ZeitaufwandfE_w.
pi361a     	Kinderbetreuung_w.
pi361b     	SpWKinderbetreuung_w.
pi362a     	ZubereitungvMahlzeiten_w.
pi362b     	SpWMahlzeiten_w.
pi363a     	Putzen_w.
pi363b     	SpW_Putzen_w.
pi364a     	Aufsicht_w.
pi364b     	SpW_Aufsicht_w.
pi365a     	Gartenarbeit_w.
pi365b     	SpW_Gartenarbeit_w.
pi366a     	Einkaufen_w.
pi366b     	SpW_Einkaufen_w.
pi367a     	Haustierpflege_w.
pi367b     	SpW_Haustierpflege_w.
pi368a     	Fahrzeuge_w.
pi368b     	SpW_Fahrzeuge_w.
pi369a     	ReparierenundBauen_w.
pi369b     	SpW_ReparierenundBauen_w.
pi3610a     VersicherungsBa_w.
pi3610b     SpW_VersicherungsBa_w.
pi3611a     SonstigeUnterstuetzung_w.
pi3611b     SpW_sonstigeUnterstuetzung_w.
pk381     	Zve4WochenKinder_w.
pk382     	Zve4WochenPartner_w.
pk383     	Zve4WochenFamilienangehoerige_w.
pk384     	Zve4WochenFreunde_w.
pk385     	Zve4WochenHausarbeit_w.
pk386     	Zve4WochenErwerbsarbeit_w.
pk387     	Zve4WochenAusbildung_w.
pk388     	Zve4WochenWeiterbildung_w.
pk389     	Zve4WochenEhrenamt_w.
pk3810     	Zve4WochenAusruhen_w.
pk3811     	Zve4WochenInteressen_w.
pk3812     	Zve4WochenArztbesuche_w.
pk3813     	Zve4WochenBesorgungen_w.
pk391     	Tag_planen_w.
pk392     	HaeufigZeitdruck_w.
pk393     	ausschlafen_w.
pk394     	Zeit_fuer_sich_w.
pk395     	Zeit_fuer_Familie_w.
pk396     	Zeit_fuer_Freunde_w.
pk401x     	WunschZeitAnzAkti_w.
pk402ax    	Aktivitaet1mehrZeit_w.
pk402bx    	Aktivitaet2mehrZeit_w.
pk402cx    	Aktivitaet3mehrZeit_w.
pk402dx    	Aktivitaet4mehrZeit_w.
pk402ex     Aktivitaet5mehrZeit_w.
alter_gr1   Altersgruppen_w.
alter_gr2   Altersgruppen_ab10_w.
soz     	SozialeStellung_w.
erw_typ     Erwerbstaetigkeit_w.
isced    	ISCED97Level_w.
bildung_typ Bildung_typisiert_w.
pf31_typ    Hoechster_Abschluss_typisiert_w.
erw_part    Erwerbstaetigkeit_Partner_w.;


label

	id_hhx	=	"Haushalts-ID"
	id_persx=	"Personen-ID"
	persx	=	"Personennummer"
	berichtsjahr =	"Berichtsjahr"
	alterx   =   "Alter"
	ha3   =   "Geschlecht"
	pa2x   =   "Familienstand"
	ha6x   =   "Stellung im Haushalt"
	ha71x   =   "Erste Staatsangehörigkeit"
	ha8x   =   "Geburtsland"
	he181   =   "Kind wird ausschließlich durch Eltern betreut"
	he18_kibetrx   =   "Kinderbetreuung (Betreute Zeit insgesamt durch Tagesmutter/Tagesvater, Krippe, Kindertagesstätte, vorschulische Einrichtungen, Hort)"
	he187x   =   "Betreute Zeit durch Verwandte, Freunde, Nachbarn"
	he19x   =   "Betreuung Tage pro Woche"
	he201   =   "Kind geht/geht nicht zur Schule"
	he202x   =   "Unterrichtsstunden pro Woche (HFB)"
	he211   =   "Teilnahme an AGs (HFB)"
	he212x   =   "AG-Stunden pro Woche (HFB)"
	he22x   =   "Zeitstunden insgesamt in der Schule pro Woche (HFB)"
	he231   =   "Mittagessen in der Betreuungseinrichtung/Schule"
	he232   =   "Hausaufgabenbetreuung in der Betreuungseinrichtung/Schule"
	he233   =   "Sprachförderung in Deutsch in der Betreuungseinrichtung/Schule"
	he234   =   "Nachhilfe, Förderkurse in der Betreuungseinrichtung/Schule"
	he235   =   "Musikalische Früherziehung in der Betreuungseinrichtung/Schule"
	he236   =   "Kind nimmt keine Angebote wahr in der Betreuungseinrichtung/Schule"
	he237   =   "Sonstige Kurse in der Betreuungseinrichtung/Schule"
	he241x   =   "Stunden pro Woche: Sport und Bewegung außerhalb der Betreuungseinrichtung/Schule"
	he245x   =   "Stunden pro Woche: Singen, Musikinstrument spielen außerhalb der Betreuungseinrichtung/Schule"
	he246x   =   "Stunden pro Woche: Malen, Basteln außerhalb der Betreuungseinrichtung/Schule"
	he247x   =   "Stunden pro Woche: Tanzen, Theater spielen außerhalb der Betreuungseinrichtung/Schule"
	he248   =   "Kind nimmt keine Angebote wahr außerhalb der Betreuungseinrichtung/Schule"
	he249x   =   "Stunden pro Woche: Sonstiges Angebot außerhalb der Betreuungseinrichtung oder Schule"
	pfb_ausgef   =   "Ausgefüllter Personenfragebogen"
	pb3   =   "Lebenssituation"
	pb4   =   "In der letzten Woche mindestens 1 Stunde gegen Bezahlung gearbeitet"
	pc5x   =   "Berufliche Stellung in der Haupterwerbstätigkeit"
	pc6   =   "Art des Beschäftigungsverhältnisses in der Haupterwerbstätigkeit"
	pc7   =   "Vollzeit/Teilzeit in der Haupterwerbstätigkeit"
	pc8x   =   "Wochenstunden in der Haupterwerbstätigkeit"
	pc9x   =   "Wunscharbeitszeit in der Haupterwerbstätigkeit"
	pc10   =   "Geringfügige Beschäftigung in der Haupterwerbstätigkeit"
	pc11x   =   "Wirtschaftszweig in der Haupterwerbstätigkeit"
	pc121   =   "Ort der Arbeitsstätte in der Haupterwerbstätigkeit"
	pc122x   =   "Kilometer zur Arbeitsstätte in der Haupterwerbstätigkeit"
	pc13x   =   "Arbeitsweg in Minuten in der Haupterwerbstätigkeit"
	pc14   =   "Arbeitszeitgestaltung in der Haupterwerbstätigkeit"
	pc15   =   "Schichtarbeit in der Haupterwerbstätigkeit"
	pc16_fruehsonstx   =   "Früh-/ sonstige Schicht in der Haupterwerbstätigkeit"
	pc16_spaetnachtx   =   "Spät-/ Nachtschicht in der Haupterwerbstätigkeit"
	pc17   =   "Arbeit von zu Hause aus in der Haupterwerbstätigkeit"
	pc18   =   "Wochenendarbeit in der Haupterwerbstätigkeit"
	pd191   =   "Nebenerwerbstätig"
	pd192x   =   "Anzahl der Nebenerwerbstätigkeiten"
	pd20   =   "Monate pro Jahr, an denen Nebenerwerbstätigkeit ausgeübt wird"
	pd21x   =   "Tage pro Monat, an denen Nebenerwerbstätigkeit ausgeübt wird"
	pd22x   =   "Stunden pro Tag, an denen Nebenerwerbstätigkeit ausgeübt wird"
	pe23x   =   "Monatliches Nettoeinkommen aus Haupterwerbstätigkeit und Nebenerwerbstätigkeit(en)"
	pf24   =   "Schulbesuch"
	pf25x   =   "Art der Schule"
	pf26x   =   "Unterrichtsstunden pro Woche (PFB)"
	pf271   =   "Teilnahme an AGs (PFB)"
	pf272x   =   "AG-Stunden pro Woche (PFB)"
	pf28x   =   "Zeitstunden insgesamt in der Schule pro Woche (PFB)"
	pf291a   =   "Sport außerhalb der Schule"
	pf291bx   =   "Stunden pro Woche: Sport außerhalb der Schule"
	pf292a   =   "Sprachförderung in Deutsch außerhalb der Schule"
	pf292bx   =   "Stunden pro Woche: Sprachförderung in Deutsch außerhalb der Schule"
	pf293a   =   "Sprachförderung  andere Sprache außerhalb der Schule"
	pf293bx   =   "Stunden pro Woche: Sprachförderung andere Sprache außerhalb der Schule"
	pf294a   =   "Nachhilfe, Förderkurse außerhalb der Schule"
	pf294bx   =   "Stunden pro Woche: Nachhilfe, Förderkurse außerhalb der Schule"
	pg321a   =   "Kino in den letzten 12 Monaten"
	pg321b   =   "Häufigkeit Kino in den letzten 12 Monaten"
	pg322a   =   "Theater, Tanz in den letzten 12 Monaten"
	pg322b   =   "Häufigkeit Theater, Tanz in den letzten 12 Monaten"
	pg323a   =   "Konzert, Oper, Musical in den letzten 12 Monaten"
	pg323b   =   "Häufigkeit Konzert, Oper, Musical in den letzten 12 Monaten"
	pg324a   =   "Kunstausstellung, Museum in den letzten 12 Monaten"
	pg324b   =  "Häufigkeit Kunstausstellung, Museum in den letzten 12 Monaten"
	pg325a   =   "Bibliothek, Bücherei in den letzten 12 Monaten"
	pg325b   =   "Häufigkeit Bibliothek, Bücherei in den letzten 12 Monaten"
	pg326a   =  "Sonstige kulturelle Angebote in den letzten 12 Monaten"
	pg326b   =   "Häufigkeit sonstige kulturelle Angebote in den letzten 12 Monaten"
	pg331a   =   "Singen"
	pg331b   =   "Stunden pro Woche: Singen"
	pg332a   =   "Musikinstrument spielen"
	pg332b   =   "Stunden pro Woche: Musikinstrument spielen"
	pg333a   =   "Malen, Zeichnen, Drucken"
	pg333b   =   "Stunden pro Woche: Malen, Zeichnen, Drucken"
	pg334a   =   "Werken, Nähen, Töpfern, Goldschmieden, Basteln"
	pg334b   =   "Stunden pro Woche: Werken, Nähen, Töpfern, Goldschmieden, Basteln"
	pg335a   =   "Tanzen"
	pg335b   =   "Stunden pro Woche: Tanzen"
	pg336a   =   "Theater spielen"
	pg336b   =   "Stunden pro Woche: Theater spielen"
	pg337a   =   "Schreiben, Dichten"
	pg337b   =   "Stunden pro Woche: Schreiben, Dichten"
	pg338a   =   "Filmen, Fotografieren"
	pg338b   =   "Stunden pro Woche: Filmen, Fotografieren"
	pg339a   =   "Literaturkreis"
	pg339b   =   "Stunden pro Woche: Literaturkreis"
	pg3310a   =   "Sonstige kulturelle Aktivitäten"
	pg3310b   =   "Stunden pro Woche: sonstige kulturelle Aktivitäten"
	ph341   =   "Sport und Bewegung in den letzten 12 Monaten"
	ph342   =   "Kultur und Musik in den letzten 12 Monaten"
	ph343   =   "Schule und Kindergarten in den letzten 12 Monaten"
	ph344   =   "Kirchliche oder religiöse Gesellschaft in den letzten 12 Monaten"
	ph345   =   "Sozialer Bereich in den letzten 12 Monaten"
	ph346   =   "Politik und politische Interessenvertretung in den letzten 12 Monaten"
	ph347   =   "Bürgerschaftliche Aktivität an Ihrem Wohnortin den letzten 12 Monaten"
	ph348   =   "Berufliche Interessenvertretung außerhalb des Betriebes in den letzten 12 Monaten"
	ph349   =   "Umwelt, Naturschutz oder Tierschutz in den letzten 12 Monaten"
	ph3410   =   "Außerschulische Jugendarbeit, Bildungsarbeit für Erwachsene in den letzten 12 Monaten"
	ph3411   =   "Unfall- oder Rettungsdienst oder freiwillige Feuerwehr in den letzten 12 Monaten"
	ph3412   =   "Gesundheit in den letzten 12 Monaten"
	ph3413   =   "Justiz und Innere Sicherheit in den letzten 12 Monaten"
	ph3414   =   "Freizeit und Geselligkeit in den letzten 12 Monaten"
	ph35   =   "Zeitaufwand freiwilliges Engagement"
	pi361a   =   "Kinderbetreuung"
	pi361b   =   "Stunden pro Woche: Kinderbetreuung"
	pi362a   =   "Zubereitung von Mahlzeiten"
	pi362b   =   "Stunden pro Woche: Zubereitung von Mahlzeiten"
	pi363a   =   "Putzen, Aufräumen, Waschen und Bügeln, Straße fegen"
	pi363b   =   "Stunden pro Woche: Putzen, Aufräumen, Waschen und Bügeln, Straße fegen"
	pi364a   =   "Nach dem Rechten sehen"
	pi364b   =   "Stunden pro Woche: nach dem Rechten sehen"
	pi365a   =   "Gartenarbeit"
	pi365b   =   "Stunden pro Woche: Gartenarbeit"
	pi366a   =   "Einkaufen und Besorgungen"
	pi366b   =   "Stunden pro Woche: Einkaufen und Besorgungen"
	pi367a   =   "Haustierpflege"
	pi367b   =   "Stunden pro Woche: Haustierpflege"
	pi368a   =   "Reparatur und Wartung von Fahrzeugen"
	pi368b   =   "Stunden pro Woche: Reparatur und Wartung von Fahrzeugen"
	pi369a   =   "Reparieren und Bauen"
	pi369b   =   "Stunden pro Woche: Reparieren und Bauen"
	pi3610a   =   "Versicherungs-, Behördenangelegenheiten"
	pi3610b   =   "Stunden pro Woche: Versicherungs-, Behördenangelegenheiten"
	pi3611a   =   "Sonstige Unterstützung"
	pi3611b   =   "Stunden pro Woche: sonstige Unterstützung"
	pk381   =   "Zeitverwendung in den letzten 4 Wochen für Kinder"
	pk382   =   "Zeitverwendung in den letzten 4 Wochen für (Ehe-)Partner/-in"
	pk383   =   "Zeitverwendung in den letzten 4 Wochen für sonstige Familienangehörige"
	pk384   =   "Zeitverwendung in den letzten 4 Wochen für Freunde, Bekannte"
	pk385   =   "Zeitverwendung in den letzten 4 Wochen für Hausarbeit"
	pk386   =   "Zeitverwendung in den letzten 4 Wochen für Erwerbsarbeit"
	pk387   =   "Zeitverwendung in den letzten 4 Wochen für Ausbildung"
	pk388   =   "Zeitverwendung in den letzten 4 Wochen für Weiterbildung"
	pk389   =   "Zeitverwendung in den letzten 4 Wochen für ehrenamtliche/freiwillige Tätigkeit"
	pk3810   =   "Zeitverwendung in den letzten 4 Wochen für Ausruhen"
	pk3811   =   "Zeitverwendung in den letzten 4 Wochen für persönliche Interessen (Sport, Kultur)"
	pk3812   =   "Zeitverwendung in den letzten 4 Wochen für Arztbesuche"
	pk3813   =   "Zeitverwendung in den letzten 4 Wochen für Besorgungen"
	pk391   =   "Angewiesen, den Tag zu planen"
	pk392   =   "Häufig unter Zeitdruck"
	pk393   =   "Regelmäßig ausschlafen"
	pk394   =   "Mehr Zeit für sich"
	pk395   =   "Mehr Zeit für Familie"
	pk396   =   "Mehr Zeit für Freunde, Bekannte"
	pk401x   =   "Wunsch nach mehr Zeit, Anzahl der Aktivitäten"
	pk402ax   =   "Aktivität 1, für die mehr Zeit gewünscht wird"
	pk402bx   =   "Aktivität 2, für die mehr Zeit gewünscht wird"
	pk402cx   =   "Aktivität 3, für die mehr Zeit gewünscht wird"
	pk402dx   =   "Aktivität 4, für die mehr Zeit gewünscht wird"
	pk402ex   =   "Aktivität 5, für die mehr Zeit gewünscht wird"
	hrfp80	 =	 "Hochrechnungsfaktor * 100 für Personen ab 10 Jahren"
	hrfk80	 =	 "Hochrechnungsfaktor * 100 für Kinder unter 10 Jahren"
	alter_gr1   =   "6 Altersgruppen"
	alter_gr2   =   "6 Altersgruppen, Personen ab 10 Jahren"
	soz   =   "Soziale Stellung"
	erw_typ   =   "Erwerbstätigkeit"
	isced   =   "ISCED-97-Level"
	bildung_typ   =   "Bildung typisiert"
	pf31_typ   =   "Höchster beruflicher Ausbildungs- oder Hochschulabschluss typisiert"
	erw_part   =   "Erwerbstätigkeit des Partners des Haupteinkommensbeziehers/Lebenspartners";
run;

/*  (III) ZVE 13 PERS                 */
/*	(iv)  Löschen nicht mehr benötigter temporärer Dateien	*/

proc datasets lib=work nolist;
	delete	&dateiname2;
run;


/********************************************************************************************************/
/********************************************************************************************************/
/********************************************************************************************************/



/*  (IV) ZVE 13 SUM              */
/*	(i)	 Einlesen der CSV-Datei  */

proc import 
	datafile		=	"&pfad3./&CSVdatei3"	
	out				=	&dateiname3  
	dbms			=	dlm
	replace;
	delimiter		=	";";
 	getnames		=	yes;
run;


/*  (IV) ZVE 13 SUM              */
/*	(ii) Definition der Wertelabels, die temporär in WORK gespeichert werden*/

proc format lib=work;

value tc1ax_w				-2 = "trifft nicht zu";

value tc1bx_w				-2 = "trifft nicht zu";

value tc1cx_w				-2 = "trifft nicht zu";

value tc2ax_w				-2 = "trifft nicht zu";

value tc2bx_w				-2 = "trifft nicht zu";

value tc2cx_w				-2 = "trifft nicht zu";

value tc3ax_w				-2 = "trifft nicht zu";

value tc3bx_w				-2 = "trifft nicht zu";

value tc3cx_w				-2 = "trifft nicht zu";

value tc4_w					-1 = "keine Angabe"
							1 = "normal"
							2 = "ungewöhnlich";

value tc5_w					-1 = "keine Angabe"
							1 = "keine Reise"
							2 = "Tagesreise"
							3 = "Reise mit Übernachtung";

value tc6_w					-1 = "keine Angabe"
							1 = "über den Tag verteilt"
							2 = "am Ende des Tages"
							3 = "am Tag danach"
							4 = "mehrere Tage später";

value tc7_w					-1 = "keine Angabe"
							1 = "ja"
							2 = "nein";

value tc8_w					-2 = "trifft nicht zu"
							-1 = "keine Angabe"
							1 = "ja"
							2 = "nein";

value wtagfei_w				1 = "Montag"
							2 = "Dienstag"
							3 = "Mittwoch"
							4 = "Donnerstag"
							5 = "Freitag"
							6 = "Samstag/Heiligabend/Silvester"
							7 = "Sonntag/Feiertag";

value fehl_tag_w			0 = "Person hat 3 Tagebuchtage ausgefüllt"
							1 = "Tag 1 fehlt"
							2 = "Tag 2 fehlt"
							3 = "Tag 3 fehlt";


value quartal_w				1 = "1. Quartal"
							2 = "2. Quartal"
							3 = "3. Quartal"
							4 = "4. Quartal";

value selbtag_w				-2 = "trifft nicht zu"
							1 = "ja"
							2 = "nein";
run;


/*  (IV) ZVE 13 SUM              */
/*	(iii)Zuweisung der Werte- und Variablenlabels zu den Variablen und Speichern als SAS-Datei		*/


data	ZVE3.&dateiname3;
set 	&dateiname3;

format 

	tc1ax     			tc1ax_w.
	tc1bx      			tc1bx_w.
	tc1cx      			tc1cx_w.
	tc2ax      			tc2ax_w.
	tc2bx      			tc2bx_w.
	tc2cx      			tc2cx_w.
	tc3ax      			tc3ax_w.
	tc3bx     			tc3bx_w.
	tc3cx      			tc3cx_w.
	tc4      			tc4_w.
	tc5      			tc5_w.
	tc6      			tc6_w.
	tc7      			tc7_w.
	tc8      			tc8_w.
	wtagfei      		wtagfei_w.
	fehl_tag      		fehl_tag_w.
	quartal      		quartal_w.
	selbtag      		selbtag_w.;

label
	id_hhx        =        		"Haushalts-ID"
	id_persx        =        	"Personen-ID"
	id_tagx        =        	"Tag-ID"
	persx        =        		"Personennummer"
	tagnr        =        		"Anschreibetag"
	berichtsjahr        =       "Berichtsjahr"
	ha_1        =      			"1 Persönlicher Bereich/Physiologische Regeneration (HA)"
	ha_2        =        		"2 Erwerbstätigkeit (HA)"
	ha_3        =        		"3 Qualifikation/Bildung (HA)"
	ha_4        =        		"4 Haushaltsführung und Betreuung der Familie (HA)"
	ha_5        =        		"5 Ehrenamt/Freiwilligenarbeit etc. (HA)"
	ha_6        =        		"6 Soziales Leben/Unterhaltung (HA)"
	ha_7        =        		"7 Sport/Hobbys/Spiele (HA)"
	ha_8        =        		"8 Mediennutzung (HA)"
	ha_9        =        		"9 Zweckbestimmte Wegezeiten/Hilfscodes (HA)"
	hainklweg_1        =        "1 Persönlicher Bereich/Physiologische Regeneration inkl. Wegezeit (HA)"
	hainklweg_2        =        "2 Erwerbstätigkeit inkl. Wegezeit (HA)"
	hainklweg_3        =        "3 Qualifikation/Bildung inkl. Wegezeit (HA)"
	hainklweg_4        =        "4 Haushaltsführung und Betreuung der Familie inkl. Wegezeit (HA)"
	hainklweg_5        =        "5 Ehrenamt/Freiwilligenarbeit etc. inkl. Wegezeit (HA)"
	hainklweg_6        =        "6 Soziales Leben/Unterhaltung inkl. Wegezeit (HA)"
	hainklweg_7        =        "7 Sport/Hobbys/Spiele inkl. Wegezeit (HA)"
	hainklweg_8        =        "8 Mediennutzung inkl. Wegezeit (HA)"
	ha_11        =        		"11 Schlafen (HA)"
	ha_12        =        		"12 Essen und Trinken (HA)"
	ha_13        =        "13 Andere Tätigkeiten pers. Bereich (HA)"
	ha_21        =        "21 Haupterwerbstätigkeit (HA)"
	ha_22        =        "22 Nebenerwerbstätigkeit (HA)"
	ha_23        =        "23 Erwerbstätigkeit ohne Unterteilung (HA)"
	ha_24        =        "24 Andere Akt. Erwerbstätigkeit (HA)"
	ha_31        =        "31 Unterricht in der Schule (HA)"
	ha_32        =        "32 Betreuung in der Schule (HA)"
	ha_33        =        "33 AGs (HA)"
	ha_34        =        "34 Hochschule (HA)"
	ha_35        =        "35 Vor-/Nachbereitungen Lehrveranstaltungen (HA)"
	ha_36        =        "36 Andere Akt. Qualifikation/Bildung (HA)"
	ha_41        =        "41 Zubereitung von Mahlzeiten/Küche (HA)"
	ha_42        =        "42 Instanthaltung v. Haus/Wohnung (HA)"
	ha_43        =        "43 Textilien (HA)"
	ha_44        =        "44 Pflanzen-/Tierpflege (HA)"
	ha_45        =        "45 Bauen/Handwerk (HA)"
	ha_46        =        "46 Einkaufen/Fremdleistungen (HA)"
	ha_47        =        "47 Kinderbetreuung (HA)"
	ha_48        =        "48 Unterstützung/Pflege erw. HH-Mitglieder (HA)"
	ha_49        =        "49 Andere Akt. Haushaltsführung/Familie (HA)"
	ha_51        =        "51 Ehrenamt/Freiwilliges Engagement (HA)"
	ha_52        =        "52 Unterstützung für andere Haushalte (HA)"
	ha_53        =        "53 Teilnahme an Versammlungen (HA)"
	ha_61        =        "61 Soziale Kontakte (HA)"
	ha_62        =        "62 Unterhaltung und Kultur (HA)"
	ha_63        =        "63 Ausruhen/Auszeit/Zeit überbrücken (HA)"
	ha_64        =        "64 Andere Akt. Soziales Leben/Unterhaltung (HA)"
	ha_71        =        "71 Körperliche Bewegung (HA)"
	ha_73        =        "73 Rüstzeiten sportliche Aktivitäten (HA)"
	ha_74        =        "74 Kunst/Musizieren (HA)"
	ha_75        =        "75 Sonstige Hobbies (HA)"
	ha_76        =        "76 Spiele (HA)"
	ha_79x       =        "79 Sport ohne nähere Bezeichnung (HA)"
	ha_81        =        "81 Lesen (HA)"
	ha_82        =        "82 Fernsehen und Video/DVD (HA)"
	ha_83        =        "83 Radio/Musik hören (HA)"
	ha_84        =        "84 Computer/Smartphone (HA)"
	ha_92        =        "92 Wegezeiten Erwerbstätigkeit (HA)"
	ha_93        =        "93 Wegezeiten Qualifikation/Bildung (HA)"
	ha_94        =        "94 Wegezeiten Haushaltsführung/Familie (HA)"
	ha_95        =        "95 Wegezeiten Ehrenamt/Freiwilligenarbeit etc. (HA)"
	ha_96        =        "96 Wegezeiten Soziales Leben/Unterhaltung (HA)"
	ha_97        =        "97 Wegezeiten Sport/Hobbys/Spiele (HA)"
	ha_98        =        "98 Wegezeiten Mediennutzung (HA)"
	ha_99        =        "99 Andere Wegezeiten/Hilfscodes (HA)"
	ha_110        =        "110 Schlafen (HA)"
	ha_120        =        "120 Essen und Trinken (HA)"
	ha_131        =        "131 Waschen und anziehen (HA)"
	ha_132        =        "132 Krank im Bett/Krank (HA)"
	ha_139        =        "139 Sonstige Aktivitäten pers. Bereich (HA)"
	ha_210        =        "210 Haupterwerbstätigkeit (HA)"
	ha_220        =        "220 Nebenerwerbstätigkeit (HA)"
	ha_230        =        "230 Erwerbstätigkeit ohne Unterteilung (HA)"
	ha_241        =        "241 Qualifizierung/Weiterbildung für Beruf (HA)"
	ha_242        =        "242 Arbeitssuche (HA)"
	ha_243        =        "243 Erwerbstätigkeit anderer: unbezahlte Arbeit (HA)"
	ha_244        =        "244 Praktikum im Rahmen einer Erwerbstätigkeit (HA)"
	ha_245        =        "245 Pause während der Arbeit ohne Unterteilung (HA)"
	ha_249        =        "249 Sonstige Aktivitäten Erwerbstätigkeit (HA)"
	ha_311        =        "311 Deutsch (HA)"
	ha_312        =        "312 Fremdsprache (HA)"
	ha_313        =        "313 Mathematik/NatWi/etc (HA)"
	ha_314        =        "314 Kunst/Musik (HA)"
	ha_315        =        "315 Gesellschaftswissenschaften (HA)"
	ha_317        =        "317 Sport (HA)"
	ha_319x        =       "319 Sonstige Unterrichtsfächer (HA)"
	ha_321        =        "321 Angebote der Schule zur Vor-/Nachbereitung (HA)"
	ha_329        =        "329 Sonstige Betreuungsangebote Schule (HA)"
	ha_330x       =        "330 AGs (HA)"
	ha_341        =        "341 Lehrveranstaltungen Hochschule (HA)"
	ha_349        =        "349 Sonstige Aktivitäten im Bereich Hochschule (HA)"
	ha_353        =        "353 Vor-/Nachbereitung Lehrveranstaltungen (HA)"
	ha_354x		  =		   "354x Hausaufgaben/Selbstlernen für die Schule/Private Nachhilfe (HA)"
	ha_361        =        "361 Qualifikation außerhalb der Arbeitszeit (HA)"
	ha_362        =        "362 Pausen in der Schule (HA)"
	ha_363        =        "363 Freistunden/Leerlaufzeiten in der Schule (HA)"
	ha_364        =        "364 Pausen Hochschule (HA)"
	ha_369        =        "369 Sonstige Aktivitäten Qualifikation/Bildung (HA)"
	ha_411        =        "411 Mahlzeiten vor- und zubereiten (HA)"
	ha_412        =        "412 Backen (HA)"
	ha_413        =        "413 Geschirreinigung, Tisch decken/abräumen (HA)"
	ha_414        =        "414 Konservieren von Lebensmitteln (HA)"
	ha_419        =        "419 Sonstige Aktivitäten Zubereitung von Mahlzeiten (HA)"
	ha_421        =        "421 Reinigung/Aufräumen der Wohnung (HA)"
	ha_422        =        "422 Reinigung Hof/Keller/Garage, Abfallbeseitigung (HA)"
	ha_423        =        "423 Heizen (HA)"
	ha_429        =        "429 Sonstige Aktivitäten Instandhaltung Haus/Wohnung (HA)"
	ha_431        =        "431 Wäsche waschen (HA)"
	ha_432        =        "432 Bügeln und mangeln (HA)"
	ha_433        =        "433 Herstellung von Textilien (HA)"
	ha_434        =        "434 Ausbessern/Umändern Textilien (HA)"
	ha_439        =        "439 Sonstige Aktivitäten Textilien (HA)"
	ha_441        =        "441 Pflanzenpflege draußen (HA)"
	ha_442        =        "442 Pflanzenpflege drinnen (HA)"
	ha_443        =        "443 Pflanzenpflege ohne Ort (HA)"
	ha_444        =        "444 Nutztierpflege (HA)"
	ha_445        =        "445 Haustierpflege (HA)"
	ha_446        =        "446 Hund spazieren führen (HA)"
	ha_449        =        "449 Sonstige Pflanzen-/Tierpflege (HA)"
	ha_451        =        "451 Hausbau und Instandhaltung (HA)"
	ha_452        =        "452 Wohnungsreparaturen, Renovierung (HA)"
	ha_453        =        "453 Herstellung/Wartung/Repar. Ausstattungsgegenstände (HA)"
	ha_454        =        "454 Wartung/kl. Rep. Haushaltsgegenständen (HA)"
	ha_455        =        "455 Fahrzeugreparatur/-pflege (HA)"
	ha_459        =        "459 Sonstige Aktivitäten Bauen/Handwerk (HA)"
	ha_461        =        "461 Einkaufen (ohne Telefon/Internet) (HA)"
	ha_464        =        "464 Behördengang/Dienstleistung/ Verwaltung (HA)"
	ha_465        =        "465 personengebundene Dienstleistungen (HA)"
	ha_466        =        "466 Medizinische Dienste (HA)"
	ha_469        =        "469 Sonstige Aktivitäten Einkaufen/Fremdleistungen (HA)"
	ha_471        =        "471 Körperpflege/Beaufsichtigung Kind (HA)"
	ha_472        =        "472 Hausaufgabenbetreuung/Anleitungen Kind (HA)"
	ha_473        =        "473 Spielen/Sport Kind (HA)"
	ha_474        =        "474 Gespräche Kind (HA)"
	ha_475        =        "475 Begleiten/Termine mit Kind (HA)"
	ha_476        =        "476 Kind vorlesen/erzählen (HA)"
	ha_479        =        "479 Sonstige Aktivitäten Kinderbetreuung (HA)"
	ha_480        =        "480 Unterstützung/Pflege erw. HHmitglieder (HA)"
	ha_491        =        "491 Rüsttätigkeiten im Haushalt (HA)"
	ha_492        =        "492 Haushaltsplanung (auch Internet/Telefon) (HA)"
	ha_499        =        "499 Sonstige Aktivitäten Haushaltsführung/Familie (HA)"
	ha_510        =        "510 Ehrenamt/Freiwilliges Engagement (HA)"
	ha_520        =        "520 Unterstützung für andere Haushalte (HA)"
	ha_531        =        "531 Politische und soziale Versammlungen (HA)"
	ha_532        =        "532 religiöse Aktivitäten (HA)"
	ha_539        =        "539 Sonstige Aktivitäten Versammlungen (HA)"
	ha_611        =        "611 Gespräche (HA)"
	ha_612        =        "612 Telefonate (auch SMS) (HA)"
	ha_621        =        "621 Kino (HA)"
	ha_622        =        "622 Theater/Konzerte/Oper/Musical (HA)"
	ha_623        =        "623 Kunstausstellungen/Museen (HA)"
	ha_624        =        "624 Bibliotheken (HA)"
	ha_625        =        "625 Sportveranstaltungen (HA)"
	ha_626        =        "626 Ausflüge/Zoo/Vergnügungsparks (HA)"
	ha_627        =        "627 Ausgehen (HA)"
	ha_629        =        "629 Sonstige Unterhaltung/Kultur (HA)"
	ha_630        =        "630 Ausruhen/Auszeit/Zeit überbrücken (HA)"
	ha_641        =        "641 Besuch (HA)"
	ha_642        =        "642 Familienfeiern/Feste privater Art (HA)"
	ha_649        =        "649 Sonstige Aktivitäten Soziales Leben/ Unterhaltung (HA)"
	ha_711        =        "711 Spazieren gehen (HA)"
	ha_712        =        "712 Joggen/Nordic Walking/Wandern (HA)"
	ha_713        =        "713 Radsport und Skaten (HA)"
	ha_715        =        "715 Ballspiele (HA)"
	ha_716        =        "716 Gymnastik/Fitness/Tanzen (HA)"
	ha_717        =        "717 Wassersport (HA)"
	ha_719x       =        "719 Sonstige Körperliche Bewegung (HA)"
	ha_730        =        "730 Rüstzeiten für sportliche Aktivitäten (HA)"
	ha_740        =        "740 Kunst/Musizieren (HA)"
	ha_752        =        "752 Korrespondenz (außer Computer/Handy) (HA)"
	ha_759x       =        "759 Sonstige Hobbys (HA)"
	ha_761        =        "761 Gesellschaftsspiele/Spiel miteinander (HA)"
	ha_762        =        "762 Spiele allein, Glücksspiele (HA)"
	ha_763        =        "763 Computerspiele (HA)"
	ha_769        =        "769 Sonstige Spiele (HA)"
	ha_790x       =        "790 Sport ohne nähere Bezeichnung (HA)"
	ha_811        =        "811 Zeitungen lesen (auch elektronisch) (HA)"
	ha_812        =        "812 Zeitschriften lesen (auch elektronisch) (HA)"
	ha_813        =        "813 Bücher lesen (auch elektronisch) (HA)"
	ha_814        =        "814 Zuhören beim Vorlesen (HA)"
	ha_815        =        "815 Sonstiges lesen (auch elektronisch) (HA)"
	ha_819        =        "819 Lesen ohne nähere Bezeichnung (HA)"
	ha_820        =        "820 Fernsehen und Video/DVD (HA)"
	ha_830        =        "830 Radio, Musik hören (HA)"
	ha_841        =        "841 Programmierung/Reparatur Computer/ Smartphone (HA)"
	ha_842        =        "842 Informieren durch Computer/Smartphone (HA)"
	ha_843        =        "843 Kommunikation über Computer/ Smartphone (HA)"
	ha_844        =        "844 Sonstige Aktivitäten Computer/Smartphone (HA)"
	ha_849        =        "849 nicht näher bez. Akt. Computer/ Smartphone (HA)"
	ha_921        =        "921 Wegezeiten Haupterwerbstätigkeit (HA)"
	ha_922        =        "922 Wegezeiten Nebenerwerbstätigkeit (HA)"
	ha_923        =        "923 Wegezeiten Erwerbstätigkeit o. Unterteilung (HA)"
	ha_929        =        "929 Andere Wegezeiten Erwerbstätigkeit (24) (HA)"
	ha_931        =        "931 Wegezeiten Schule (31-33) (HA)"
	ha_934        =        "934 Wegezeiten Hochschule (34-35) (HA)"
	ha_939        =        "939 Andere Wegezeiten Qualifikation/Bildung (36) (HA)"
	ha_941        =        "941 Wegezeiten Haushalt, Pflanzen, Tiere (41-44) (HA)"
	ha_945        =        "945 Wegezeiten Bauen/handwerkliche Tätigkeiten (HA)"
	ha_946        =        "946 Wegezeiten Einkaufen, Fremdleistungen (HA)"
	ha_947        =        "947 Wegezeiten Kinderbetreuung (HA)"
	ha_948        =        "948 Wegezeiten Unterstützung erwachsener HH-Mitglieder (HA)"
	ha_949        =        "949 Wegezeiten Andere Akt. Haushalt/Familie (HA)"
	ha_951        =        "951 Wegezeiten Ehrenamt/Freiwilliges Engagement (HA)"
	ha_952        =        "952 Wegezeiten Unterstützung anderer Haushalte (HA)"
	ha_953        =        "953 Wegezeiten Teilnahme an Versammlungen (HA)"
	ha_959        =        "959 Andere Wege Engagement, Unterstützung, Versammlung (HA)"
	ha_961        =        "961 Wegezeiten Soziale Kontakte (HA)"
	ha_962        =        "962 Wegezeiten Unterhaltung/Kultur (HA)"
	ha_969        =        "969 Andere Wege Soz. Leben/Unterhaltung (63-64) (HA)"
	ha_970        =        "970 Wegezeiten Sport/Hobbys/Spiele (HA)"
	ha_980        =        "980 Wegezeiten Mediennutzung (HA)"
	ha_991        =        "991 Wegezeiten Reisen (HA)"
	ha_992        =        "992 Andere/unspezifizierte Wegezeiten (HA)"
	ha_997        =        "997 Ausfüllen des Tagebuchs (HA)"
	ha_998        =        "998 Nicht bestimmt verwendete Freizeit (HA)"
	ha_999        =        "999 Unbestimmte Zeitverwendung (keine Angabe) (HA)"
	tc1x          =        "Anzahl der Nennungen zu größte Freude"
	tc1ax         =        "Aktivitätscode größte Freude 1"
	tc1bx         =        "Aktivitätscode größte Freude 2"
	tc1cx         =        "Aktivitätscode größte Freude 3"
	tc2x          =        "Anzahl der Nennungen zu mehr Zeit"
	tc2ax         =        "Aktivitätscode mehr Zeit 1"
	tc2bx         =        "Aktivitätscode mehr Zeit 2"
	tc2cx         =        "Aktivitätscode mehr Zeit 3"
	tc3x          =        "Anzahl der Nennungen zu keine Freude"
	tc3ax         =        "Aktivitätscode keine Freude 1"
	tc3bx         =        "Aktivitätscode keine Freude 2"
	tc3cx         =        "Aktivitätscode keine Freude 3"
	tc4           =        "Besonderheiten des Tages"
	tc5           =        "Reise"
	tc6           =        "Häufigkeit der Anschreibungen"
	tc7           =        "Zu Hause zu Beginn des Tages"
	tc8           =        "Zu Hause am Ende des Tages"
	hrft80	      =        "Hochrechnungsfaktor für den Tag multipliziert mit 100"
	wtagfei       =        "Wochentag, Feiertage berücksichtigt"
	fehl_tag      =        "Fehlender Tag"
	quartal       =        "Kalenderquartal des Ausfülldatums"
	jahr          =        "Jahr des Ausfülldatums"
	selbtag       =        "Datum des Tagebuchtages ist für alle Personen des Haushalts";

	


run;

/*  (IV) ZVE 13 SUM              */
/*	(iv)	Löschen nicht mehr benötigter temporärer Dateien	*/

proc datasets lib=work nolist;
	delete	&dateiname3;
run;



/*  (V)  ZVE 13 TAKT               */
/*	(i)	 Einlesen der CSV-Datei	   */

proc import 
	datafile		=	"&pfad4./&CSVdatei4"	
	out				=	&dateiname4   
	dbms			=	dlm
	replace;
	delimiter		=	";";
 	getnames		=	yes;
run;


/*  (V)  ZVE 13 TAKT               */
/*	(ii) Definition der Wertelabels, die temporär in WORK gespeichert werden*/

proc format lib=work;

	value Hauptakt_w				 0 = "keine Hauptaktivität";

	value Nebenakt_w				 0 = "keine Nebenaktivität";

	value Verk_w					-1 = "keine Angabe"
									 0 = "keine Wegezeit"
									11 = "zu Fuß"
									12 = "Fahrrad"
									14 = "PKW"
									19 = "Sonst. privates Verkehrsmittel"
									22 = "Bus/Reisebus"
									23 = "Straßenbahn/U-Bahn"
									24 = "Zug/S-Bahn"
									29 = "Sonst. öffentliches Verkehrsmittel";

	value MitWemnichtausg_w			 0 = "nein"
									 1 = "ja";

	value WarAllein_w				 0 = "nein"
									 1 = "ja";

	value Partner_w					 0 = "nein"
									 1 = "ja";
 
	value Kinderu10_w				 0 = "nein"
									 1 = "ja";

	value AndereHHM_w				 0 = "nein"
									 1 = "ja";

	value Bekannte_w				 0 = "nein"
									 1 = "ja";

	value Nebenakt2_w				 0 = "keine Nebenaktivität";

	value Verk2_w					-1 = "keine Angabe"
									 0 = "keine Wegezeit"
									11 = "zu Fuß"
									12 = "Fahrrad"
									13 = "Moped, Motorrad"
									14 = "PKW"
									15 = "LKW/Kleinbus"
									19 = "Sonst. privates Verkehrsmittel"
									21 = "Taxi"
									22 = "Bus/Reisebus"
									23 = "Straßenbahn/U-Bahn"
									24 = "Zug/S-Bahn"
									25 = "Flugzeug"
									26 = "Boot/Schiff/Fähre"
									29 = "Sonst. öffentliches Verkehrsmittel";

	value MitWemnichtausg2_w		 0 = "nein"
									 1 = "ja";

	value WarAllein2_w				 0 = "nein"
									 1 = "ja";

	value Partner2_w				 0 = "nein"
									 1 = "ja";

	value Kinderu102_w				 0 = "nein"
									 1 = "ja";

	value AndereHHM2_w				 0 = "nein"
									 1 = "ja";

	value Bekannte2_w				 0 = "nein"
									 1 = "ja";

	value AktFreude1_w				-2 = "trifft nicht zu";

	value AktFreude2_w				-2 = "trifft nicht zu";

	value AktFreude3_w				-2 = "trifft nicht zu";

	value AktZeit1_w				-2 = "trifft nicht zu";

	value AktZeit2_w				-2 = "trifft nicht zu";

	value AktZeit3_w				-2 = "trifft nicht zu";

	value AktkFreude1_w				-2 = "trifft nicht zu";

	value AktkFreude2_w				-2 = "trifft nicht zu";

	value AktkFreude3_w				-2 = "trifft nicht zu";

	value BesonTag_w				-1 = "keine Angabe"
									 1 = "normal"
									 2 = "ungewöhnlich";

	value Reise_w					-1 = "keine Angabe"
									 1 = "keine Reise"
									 2 = "Tagesreise"
									 3 = "Reise mit Übernachtung";

	value HaeufigkeitAnschr_w		-1 = "keine Angabe"
									 1 = "über den Tag verteilt"
									 2 = "am Ende des Tages"
									 3 = "am Tag danach"
									 4 = "mehrere Tage später";

	value ZuHauseAnfangTag_w		-1 = "keine Angabe"
									 1 = "ja"
									 2 = "nein";

	value ZuHauseEndeTag_w			-2 = "trifft nicht zu"
									-1 = "keine Angabe"
									 1 = "ja"
									 2 = "nein";

	value Wochentag_w				 1 = "Montag"
									 2 = "Dienstag"
									 3 = "Mittwoch"
									 4 = "Donnerstag"
									 5 = "Freitag"
									 6 = "Samstag/Heiligabend/Silvester"
									 7 = "Sonntag/Feiertag";

	value FehlendTag_w				 0 = "Person hat 3 Tagebuchtage ausgefüllt"
									 1 = "Tag 1 fehlt"
									 2 = "Tag 2 fehlt"
									 3 = "Tag 3 fehlt";

	value Kalenderquartal_w			 1 = "1. Quartal"
									 2 = "2. Quartal"
									 3 = "3. Quartal"
									 4 = "4. Quartal";

	value DatumTagebuch2_w		    -2 = "trifft nicht zu"
									 1 = "ja"
									 2 = "nein";

run;


/*  (V)   ZVE 13 TAKT               */
/*	(iii) Zuweisung der Werte- und Variablenlabels zu den Variablen und Speichern als SAS-Datei		*/

data	ZVE4.&dateiname4;
set 	&dateiname4;

format 
	tb2_1      			Nebenakt_w.
	tb3_1      			Verk_w.
	tb4_1      			MitWemnichtausg_w.
	tb5_1      			WarAllein_w.
	tb6_1      			Partner_w.
	tb7_1      			Kinderu10_w.
	tb8_1      			AndereHHM_w.
	tb9_1      			Bekannte_w.
	tc1ax     			AktFreude1_w.
	tc1bx      			AktFreude2_w.
	tc1cx      			AktFreude3_w.
	tc2ax      			AktZeit1_w.
	tc2bx      			AktZeit2_w.
	tc2cx      			AktZeit3_w.
	tc3ax      			AktkFreude1_w.
	tc3bx      			AktkFreude2_w.
	tc3cx      			AktkFreude3_w.
	tc4      			BesonTag_w.
	tc5      			Reise_w.
	tc6      			HaeufigkeitAnschr_w.
	tc7      			ZuHauseAnfangTag_w.
	tc8      			ZuHauseEndeTag_w.
	wtagfei      		Wochentag_w.
	fehl_tag      		FehlendTag_w.
	quartal      		Kalenderquartal_w.
	selbtag      		DatumTagebuch2_w.;



	%macro wv;
format

%do i = 2 %to 144;

	tb1_&i	 Hauptakt_w.
	tb2_&i   Nebenakt2_w.
	tb3_&i   Verk2_w.
	tb4_&i   MitWemnichtausg2_w.
	tb5_&i    WarAllein2_w.
	tb6_&i   Partner2_w.
	tb7_&i   Kinderu102_w.
	tb8_&i    AndereHHM2_w.
	tb9_&i    Bekannte2_w.

	%end ;
;
	%mend wv;
	%wv;

label
	
	id_hhx			=	"Haushalts-ID"
	id_persx		=	"Personen-ID"
	id_tagx			=	"Tag-ID"
	persx			=	"Personennummer"
	tagnr			=	"Anschreibetag"
	berichtsjahr	=	"Berichtsjahr"
	tb1_1			=	"Hauptaktivität 4:00-4:10"
	tb2_1   		=   "Nebenaktivität 4:00-4:10"
	tb3_1  			=   "Verkehrsmittel 4:00-4:10"
	tb4_1   		=   "Mit-Wem-Spalte nicht ausgefüllt 4:00-4:10"
	tb5_1  			=   "War allein 4:00-4:10 "
	tb6_1   		=   "Partner 4:00-4:10"
	tb7_1   		=   "Kinder unter 10 Jahren 4:00-4:10"
	tb8_1   		=   "Andere Haushaltsmitglieder 4:00-4:10"
	tb9_1   		=   "Bekannte 4:00-4:10"
	tc1x			=	"Anzahl der Nennungen zu größte Freude"
	tc1ax   		=   "Aktivitätscode größte Freude 1"
	tc1bx  			=   "Aktivitätscode größte Freude 2"
	tc1cx   		=   "Aktivitätscode größte Freude 3"
	tc2ax   		=   "Aktivitätscode mehr Zeit 1"
	tc2bx   		=   "Aktivitätscode mehr Zeit 2"
	tc2cx   		=   "Aktivitätscode mehr Zeit 3"
	tc3ax   		=   "Aktivitätscode keine Freude 1"
	tc3bx   		=   "Aktivitätscode keine Freude 2"
	tc3cx   		=   "Aktivitätscode keine Freude 3"
	tc2x			=	"Anzahl der Nennungen zu mehr Zeit"
	tc3x			=	"Anzahl der Nennungen zu keine Freude"
	tc4   			=   "Besonderheiten des Tages"
	tc5   			=   "Reise"
	tc6   			=   "Häufigkeit der Anschreibungen"
	tc7  		 	=   "Zu Hause zu Beginn des Tages"
	tc8   			=   "Zu Hause am Ende des Tages"
	hrft80			=	"Hochrechnungsfaktor für den Tag multipliziert mit 100"
	wtagfei   		=   "Wochentag, Feiertage berücksichtigt"
	fehl_tag   		=   "Fehlender Tag"
	quartal   		=   "Kalenderquartal des Ausfülldatums"
	jahr			=	"Jahr des Ausfülldatums"
	selbtag   		=   "Datum des Tagebuchtages ist für alle Personen des Haushalts identisch"
	tb2_1   		=   "Nebenaktivität 04:00-04:10"
	tb2_2   		=   "Nebenaktivität 04:10-04:20"
	tb2_3   		=   "Nebenaktivität 04:20-04:30"
	tb2_4   		=   "Nebenaktivität 04:30-04:40"
	tb2_5   		=   "Nebenaktivität 04:40-04:50"
	tb2_6   		=   "Nebenaktivität 04:50-05:00"
	tb2_7   		=   "Nebenaktivität 05:00-05:10"
	tb2_8   		=   "Nebenaktivität 05:10-05:20"
	tb2_9   		=   "Nebenaktivität 05:20-05:30"
	tb2_10   		=   "Nebenaktivität 05:30-05:40"
	tb2_11   		=   "Nebenaktivität 05:40-05:50"
	tb2_12   		=   "Nebenaktivität 05:50-06:00"
	tb2_13   		=   "Nebenaktivität 06:00-06:10"
	tb2_14   		=   "Nebenaktivität 06:10-06:20"
	tb2_15   		=   "Nebenaktivität 06:20-06:30"
	tb2_16   		=   "Nebenaktivität 06:30-06:40"
	tb2_17   		=   "Nebenaktivität 06:40-06:50"
	tb2_18   		=   "Nebenaktivität 06:50-07:00"
	tb2_19   		=   "Nebenaktivität 07:00-07:10"
	tb2_20   		=   "Nebenaktivität 07:10-07:20"
	tb2_21   		=   "Nebenaktivität 07:20-07:30"
	tb2_22   		=   "Nebenaktivität 07:30-07:40"
	tb2_23   		=   "Nebenaktivität 07:40-07:50"
	tb2_24   		=   "Nebenaktivität 07:50-08:00"
	tb2_25   		=   "Nebenaktivität 08:00-08:10"
	tb2_26   		=   "Nebenaktivität 08:10-08:20"
	tb2_27   		=   "Nebenaktivität 08:20-08:30"
	tb2_28   		=   "Nebenaktivität 08:30-08:40"
	tb2_29   		=   "Nebenaktivität 08:40-08:50"
	tb2_30   		=   "Nebenaktivität 08:50-09:00"
	tb2_31   		=   "Nebenaktivität 09:00-09:10"
	tb2_32   		=   "Nebenaktivität 09:10-09:20"
	tb2_33   		=   "Nebenaktivität 09:20-09:30"
	tb2_34   		=   "Nebenaktivität 09:30-09:40"
	tb2_35   		=   "Nebenaktivität 09:40-09:50"
	tb2_36   		=   "Nebenaktivität 09:50-10:00"
	tb2_37   		=   "Nebenaktivität 10:00-10:10"
	tb2_38   		=   "Nebenaktivität 10:10-10:20"
	tb2_39   		=   "Nebenaktivität 10:20-10:30"
	tb2_40   		=   "Nebenaktivität 10:30-10:40"
	tb2_41   		=   "Nebenaktivität 10:40-10:50"
	tb2_42   		=   "Nebenaktivität 10:50-11:00"
	tb2_43   		=   "Nebenaktivität 11:00-11:10"
	tb2_44   		=   "Nebenaktivität 11:10-11:20"
	tb2_45   		=   "Nebenaktivität 11:20-11:30"
	tb2_46   		=   "Nebenaktivität 11:30-11:40"
	tb2_47   		=   "Nebenaktivität 11:40-11:50"
	tb2_48   		=   "Nebenaktivität 11:50-12:00"
	tb2_49   		=   "Nebenaktivität 12:00-12:10"
	tb2_50   		=   "Nebenaktivität 12:10-12:20"
	tb2_51   		=   "Nebenaktivität 12:20-12:30"
	tb2_52   		=   "Nebenaktivität 12:30-12:40"
	tb2_53   		=   "Nebenaktivität 12:40-12:50"
	tb2_54   		=   "Nebenaktivität 12:50-13:00"
	tb2_55   		=   "Nebenaktivität 13:00-13:10"
	tb2_56   		=   "Nebenaktivität 13:10-13:20"
	tb2_57   		=   "Nebenaktivität 13:20-13:30"
	tb2_58   		=   "Nebenaktivität 13:30-13:40"
	tb2_59   		=   "Nebenaktivität 13:40-13:50"
	tb2_60   		=   "Nebenaktivität 13:50-14:00"
	tb2_61   		=   "Nebenaktivität 14:00-14:10"
	tb2_62   		=   "Nebenaktivität 14:10-14:20"
	tb2_63   		=   "Nebenaktivität 14:20-14:30"
	tb2_64   		=   "Nebenaktivität 14:30-14:40"
	tb2_65   		=   "Nebenaktivität 14:40-14:50"
	tb2_66   		=   "Nebenaktivität 14:50-15:00"
	tb2_67   		=   "Nebenaktivität 15:00-15:10"
	tb2_68   		=   "Nebenaktivität 15:10-15:20"
	tb2_69   		=   "Nebenaktivität 15:20-15:30"
	tb2_70   		=   "Nebenaktivität 15:30-15:40"
	tb2_71   		=   "Nebenaktivität 15:40-15:50"
	tb2_72   		=   "Nebenaktivität 15:50-16:00"
	tb2_73   		=   "Nebenaktivität 16:00-16:10"
	tb2_74   		=   "Nebenaktivität 16:10-16:20"
	tb2_75   		=   "Nebenaktivität 16:20-16:30"
	tb2_76   		=   "Nebenaktivität 16:30-16:40"
	tb2_77   		=   "Nebenaktivität 16:40-16:50"
	tb2_78   		=   "Nebenaktivität 16:50-17:00"
	tb2_79   		=   "Nebenaktivität 17:00-17:10"
	tb2_80   		=   "Nebenaktivität 17:10-17:20"
	tb2_81   		=   "Nebenaktivität 17:20-17:30"
	tb2_82   		=   "Nebenaktivität 17:30-17:40"
	tb2_83   		=   "Nebenaktivität 17:40-17:50"
	tb2_84   		=   "Nebenaktivität 17:50-18:00"
	tb2_85   		=   "Nebenaktivität 18:00-18:10"
	tb2_86   		=   "Nebenaktivität 18:10-18:20"
	tb2_87   		=   "Nebenaktivität 18:20-18:30"
	tb2_88   		=   "Nebenaktivität 18:30-18:40"
	tb2_89   		=   "Nebenaktivität 18:40-18:50"
	tb2_90   		=   "Nebenaktivität 18:50-19:00"
	tb2_91   		=   "Nebenaktivität 19:00-19:10"
	tb2_92   		=   "Nebenaktivität 19:10-19:20"
	tb2_93   		=   "Nebenaktivität 19:20-19:30"
	tb2_94   		=   "Nebenaktivität 19:30-19:40"
	tb2_95   		=   "Nebenaktivität 19:40-19:50"
	tb2_96   		=   "Nebenaktivität 19:50-20:00"
	tb2_97   		=   "Nebenaktivität 20:00-20:10"
	tb2_98   		=   "Nebenaktivität 20:10-20:20"
	tb2_99   		=   "Nebenaktivität 20:20-20:30"
	tb2_100   		=   "Nebenaktivität 20:30-20:40"
	tb2_101   		=   "Nebenaktivität 20:40-20:50"
	tb2_102   		=   "Nebenaktivität 20:50-21:00"
	tb2_103   		=   "Nebenaktivität 21:00-21:10"
	tb2_104   		=   "Nebenaktivität 21:10-21:20"
	tb2_105   		=   "Nebenaktivität 21:20-21:30"
	tb2_106   		=   "Nebenaktivität 21:30-21:40"
	tb2_107   		=   "Nebenaktivität 21:40-21:50"
	tb2_108   		=   "Nebenaktivität 21:50-22:00"
	tb2_109   		=   "Nebenaktivität 22:00-22:10"
	tb2_110   		=   "Nebenaktivität 22:10-22:20"
	tb2_111   		=   "Nebenaktivität 22:20-22:30"
	tb2_112   		=   "Nebenaktivität 22:30-22:40"
	tb2_113   		=   "Nebenaktivität 22:40-22:50"
	tb2_114   		=   "Nebenaktivität 22:50-23:00"
	tb2_115   		=   "Nebenaktivität 23:00-23:10"
	tb2_116   		=   "Nebenaktivität 23:10-23:20"
	tb2_117   		=   "Nebenaktivität 23:20-23:30"
	tb2_118   		=   "Nebenaktivität 23:30-23:40"
	tb2_119   		=   "Nebenaktivität 23:40-23:50"
	tb2_120   		=   "Nebenaktivität 23:50-00:00"
	tb2_121   		=   "Nebenaktivität 00:00-00:10"
	tb2_122   		=   "Nebenaktivität 00:10-00:20"
	tb2_123   		=   "Nebenaktivität 00:20-00:30"
	tb2_124   		=   "Nebenaktivität 00:30-00:40"
	tb2_125   		=   "Nebenaktivität 00:40-00:50"
	tb2_126   		=   "Nebenaktivität 00:50-01:00"
	tb2_127   		=   "Nebenaktivität 01:00-01:10"
	tb2_128   		=   "Nebenaktivität 01:10-01:20"
	tb2_129   		=   "Nebenaktivität 01:20-01:30"
	tb2_130   		=   "Nebenaktivität 01:30-01:40"
	tb2_131   		=   "Nebenaktivität 01:40-01:50"
	tb2_132   		=   "Nebenaktivität 01:50-02:00"
	tb2_133   		=   "Nebenaktivität 02:00-02:10"
	tb2_134   		=   "Nebenaktivität 02:10-02:20"
	tb2_135   		=   "Nebenaktivität 02:20-02:30"
	tb2_136   		=   "Nebenaktivität 02:30-02:40"
	tb2_137   		=   "Nebenaktivität 02:40-02:50"
	tb2_138   		=   "Nebenaktivität 02:50-03:00"
	tb2_139   		=   "Nebenaktivität 03:00-03:10"
	tb2_140   		=   "Nebenaktivität 03:10-03:20"
	tb2_141   		=   "Nebenaktivität 03:20-03:30"
	tb2_142   		=   "Nebenaktivität 03:30-03:40"
	tb2_143   		=   "Nebenaktivität 03:40-03:50"
	tb2_144   		=   "Nebenaktivität 03:50-04:00"
	tb3_1   		=   "Verkehrsmittel 04:00-04:10"
	tb3_2   		=   "Verkehrsmittel 04:10-04:20"
	tb3_3   		=   "Verkehrsmittel 04:20-04:30"
	tb3_4   		=   "Verkehrsmittel 04:30-04:40"
	tb3_5   		=   "Verkehrsmittel 04:40-04:50"
	tb3_6   		=   "Verkehrsmittel 04:50-05:00"
	tb3_7   		=   "Verkehrsmittel 05:00-05:10"
	tb3_8   		=   "Verkehrsmittel 05:10-05:20"
	tb3_9   		=   "Verkehrsmittel 05:20-05:30"
	tb3_10   		=   "Verkehrsmittel 05:30-05:40"
	tb3_11   		=   "Verkehrsmittel 05:40-05:50"
	tb3_12   		=   "Verkehrsmittel 05:50-06:00"
	tb3_13   		=   "Verkehrsmittel 06:00-06:10"
	tb3_14   		=   "Verkehrsmittel 06:10-06:20"
	tb3_15   		=   "Verkehrsmittel 06:20-06:30"
	tb3_16   		=   "Verkehrsmittel 06:30-06:40"
	tb3_17   		=   "Verkehrsmittel 06:40-06:50"
	tb3_18   		=   "Verkehrsmittel 06:50-07:00"
	tb3_19   		=   "Verkehrsmittel 07:00-07:10"
	tb3_20   		=   "Verkehrsmittel 07:10-07:20"
	tb3_21   		=   "Verkehrsmittel 07:20-07:30"
	tb3_22   		=   "Verkehrsmittel 07:30-07:40"
	tb3_23   		=   "Verkehrsmittel 07:40-07:50"
	tb3_24   		=   "Verkehrsmittel 07:50-08:00"
	tb3_25   		=   "Verkehrsmittel 08:00-08:10"
	tb3_26   		=   "Verkehrsmittel 08:10-08:20"
	tb3_27   		=   "Verkehrsmittel 08:20-08:30"
	tb3_28   		=   "Verkehrsmittel 08:30-08:40"
	tb3_29   		=   "Verkehrsmittel 08:40-08:50"
	tb3_30   		=   "Verkehrsmittel 08:50-09:00"
	tb3_31   		=   "Verkehrsmittel 09:00-09:10"
	tb3_32   		=   "Verkehrsmittel 09:10-09:20"
	tb3_33   		=   "Verkehrsmittel 09:20-09:30"
	tb3_34   		=   "Verkehrsmittel 09:30-09:40"
	tb3_35   		=   "Verkehrsmittel 09:40-09:50"
	tb3_36   		=   "Verkehrsmittel 09:50-10:00"
	tb3_37   		=   "Verkehrsmittel 10:00-10:10"
	tb3_38   		=   "Verkehrsmittel 10:10-10:20"
	tb3_39   		=   "Verkehrsmittel 10:20-10:30"
	tb3_40   		=   "Verkehrsmittel 10:30-10:40"
	tb3_41   		=   "Verkehrsmittel 10:40-10:50"
	tb3_42   		=   "Verkehrsmittel 10:50-11:00"
	tb3_43   		=   "Verkehrsmittel 11:00-11:10"
	tb3_44   		=   "Verkehrsmittel 11:10-11:20"
	tb3_45   		=   "Verkehrsmittel 11:20-11:30"
	tb3_46   		=   "Verkehrsmittel 11:30-11:40"
	tb3_47   		=   "Verkehrsmittel 11:40-11:50"
	tb3_48   		=   "Verkehrsmittel 11:50-12:00"
	tb3_49   		=   "Verkehrsmittel 12:00-12:10"
	tb3_50   		=   "Verkehrsmittel 12:10-12:20"
	tb3_51   		=   "Verkehrsmittel 12:20-12:30"
	tb3_52   		=   "Verkehrsmittel 12:30-12:40"
	tb3_53   		=   "Verkehrsmittel 12:40-12:50"
	tb3_54   		=   "Verkehrsmittel 12:50-13:00"
	tb3_55   		=   "Verkehrsmittel 13:00-13:10"
	tb3_56   		=   "Verkehrsmittel 13:10-13:20"
	tb3_57   		=   "Verkehrsmittel 13:20-13:30"
	tb3_58   		=   "Verkehrsmittel 13:30-13:40"
	tb3_59   		=   "Verkehrsmittel 13:40-13:50"
	tb3_60   		=   "Verkehrsmittel 13:50-14:00"
	tb3_61   		=   "Verkehrsmittel 14:00-14:10"
	tb3_62   		=   "Verkehrsmittel 14:10-14:20"
	tb3_63   		=   "Verkehrsmittel 14:20-14:30"
	tb3_64   		=   "Verkehrsmittel 14:30-14:40"
	tb3_65   		=   "Verkehrsmittel 14:40-14:50"
	tb3_66   		=   "Verkehrsmittel 14:50-15:00"
	tb3_67   		=   "Verkehrsmittel 15:00-15:10"
	tb3_68   		=   "Verkehrsmittel 15:10-15:20"
	tb3_69   		=   "Verkehrsmittel 15:20-15:30"
	tb3_70   		=   "Verkehrsmittel 15:30-15:40"
	tb3_71   		=   "Verkehrsmittel 15:40-15:50"
	tb3_72   		=   "Verkehrsmittel 15:50-16:00"
	tb3_73   		=   "Verkehrsmittel 16:00-16:10"
	tb3_74   		=   "Verkehrsmittel 16:10-16:20"
	tb3_75   		=   "Verkehrsmittel 16:20-16:30"
	tb3_76   		=   "Verkehrsmittel 16:30-16:40"
	tb3_77   		=   "Verkehrsmittel 16:40-16:50"
	tb3_78   		=   "Verkehrsmittel 16:50-17:00"
	tb3_79   		=   "Verkehrsmittel 17:00-17:10"
	tb3_80   		=   "Verkehrsmittel 17:10-17:20"
	tb3_81   		=   "Verkehrsmittel 17:20-17:30"
	tb3_82   		=   "Verkehrsmittel 17:30-17:40"
	tb3_83   		=   "Verkehrsmittel 17:40-17:50"
	tb3_84   		=   "Verkehrsmittel 17:50-18:00"
	tb3_85   		=   "Verkehrsmittel 18:00-18:10"
	tb3_86   		=   "Verkehrsmittel 18:10-18:20"
	tb3_87   		=   "Verkehrsmittel 18:20-18:30"
	tb3_88   		=   "Verkehrsmittel 18:30-18:40"
	tb3_89   		=   "Verkehrsmittel 18:40-18:50"
	tb3_90   		=   "Verkehrsmittel 18:50-19:00"
	tb3_91   		=   "Verkehrsmittel 19:00-19:10"
	tb3_92   		=   "Verkehrsmittel 19:10-19:20"
	tb3_93   		=   "Verkehrsmittel 19:20-19:30"
	tb3_94   		=   "Verkehrsmittel 19:30-19:40"
	tb3_95   		=   "Verkehrsmittel 19:40-19:50"
	tb3_96   		=   "Verkehrsmittel 19:50-20:00"
	tb3_97   		=   "Verkehrsmittel 20:00-20:10"
	tb3_98   		=   "Verkehrsmittel 20:10-20:20"
	tb3_99   		=   "Verkehrsmittel 20:20-20:30"
	tb3_100   		=   "Verkehrsmittel 20:30-20:40"
	tb3_101   		=   "Verkehrsmittel 20:40-20:50"
	tb3_102   		=   "Verkehrsmittel 20:50-21:00"
	tb3_103   		=   "Verkehrsmittel 21:00-21:10"
	tb3_104   		=   "Verkehrsmittel 21:10-21:20"
	tb3_105   		=   "Verkehrsmittel 21:20-21:30"
	tb3_106   		=   "Verkehrsmittel 21:30-21:40"
	tb3_107   		=   "Verkehrsmittel 21:40-21:50"
	tb3_108   		=   "Verkehrsmittel 21:50-22:00"
	tb3_109   		=   "Verkehrsmittel 22:00-22:10"
	tb3_110   		=   "Verkehrsmittel 22:10-22:20"
	tb3_111   		=   "Verkehrsmittel 22:20-22:30"
	tb3_112   		=   "Verkehrsmittel 22:30-22:40"
	tb3_113   		=   "Verkehrsmittel 22:40-22:50"
	tb3_114   		=   "Verkehrsmittel 22:50-23:00"
	tb3_115   		=   "Verkehrsmittel 23:00-23:10"
	tb3_116   		=   "Verkehrsmittel 23:10-23:20"
	tb3_117   		=   "Verkehrsmittel 23:20-23:30"
	tb3_118   		=   "Verkehrsmittel 23:30-23:40"
	tb3_119   		=   "Verkehrsmittel 23:40-23:50"
	tb3_120   		=   "Verkehrsmittel 23:50-00:00"
	tb3_121   		=   "Verkehrsmittel 00:00-00:10"
	tb3_122   		=   "Verkehrsmittel 00:10-00:20"
	tb3_123   		=   "Verkehrsmittel 00:20-00:30"
	tb3_124   		=   "Verkehrsmittel 00:30-00:40"
	tb3_125   		=   "Verkehrsmittel 00:40-00:50"
	tb3_126   		=   "Verkehrsmittel 00:50-01:00"
	tb3_127   		=   "Verkehrsmittel 01:00-01:10"
	tb3_128   		=   "Verkehrsmittel 01:10-01:20"
	tb3_129   		=   "Verkehrsmittel 01:20-01:30"
	tb3_130   		=   "Verkehrsmittel 01:30-01:40"
	tb3_131   		=   "Verkehrsmittel 01:40-01:50"
	tb3_132   		=   "Verkehrsmittel 01:50-02:00"
	tb3_133   		=   "Verkehrsmittel 02:00-02:10"
	tb3_134   		=   "Verkehrsmittel 02:10-02:20"
	tb3_135   		=   "Verkehrsmittel 02:20-02:30"
	tb3_136   		=   "Verkehrsmittel 02:30-02:40"
	tb3_137   		=   "Verkehrsmittel 02:40-02:50"
	tb3_138   		=   "Verkehrsmittel 02:50-03:00"
	tb3_139   		=   "Verkehrsmittel 03:00-03:10"
	tb3_140   		=   "Verkehrsmittel 03:10-03:20"
	tb3_141   		=   "Verkehrsmittel 03:20-03:30"
	tb3_142   		=   "Verkehrsmittel 03:30-03:40"
	tb3_143   		=   "Verkehrsmittel 03:40-03:50"
	tb3_144   		=   "Verkehrsmittel 03:50-04:00"
	tb4_1   		=   "Mit-Wem-Spalte nicht ausgefüllt 04:00-04:10"
	tb4_2   		=   "Mit-Wem-Spalte nicht ausgefüllt 04:10-04:20"
	tb4_3   		=   "Mit-Wem-Spalte nicht ausgefüllt 04:20-04:30"
	tb4_4   		=   "Mit-Wem-Spalte nicht ausgefüllt 04:30-04:40"
	tb4_5   		=   "Mit-Wem-Spalte nicht ausgefüllt 04:40-04:50"
	tb4_6   		=   "Mit-Wem-Spalte nicht ausgefüllt 04:50-05:00"
	tb4_7   		=   "Mit-Wem-Spalte nicht ausgefüllt 05:00-05:10"
	tb4_8   		=   "Mit-Wem-Spalte nicht ausgefüllt 05:10-05:20"
	tb4_9   		=   "Mit-Wem-Spalte nicht ausgefüllt 05:20-05:30"
	tb4_10   		=   "Mit-Wem-Spalte nicht ausgefüllt 05:30-05:40"
	tb4_11   		=   "Mit-Wem-Spalte nicht ausgefüllt 05:40-05:50"
	tb4_12   		=   "Mit-Wem-Spalte nicht ausgefüllt 05:50-06:00"
	tb4_13   		=   "Mit-Wem-Spalte nicht ausgefüllt 06:00-06:10"
	tb4_14   		=   "Mit-Wem-Spalte nicht ausgefüllt 06:10-06:20"
	tb4_15   		=   "Mit-Wem-Spalte nicht ausgefüllt 06:20-06:30"
	tb4_16   		=   "Mit-Wem-Spalte nicht ausgefüllt 06:30-06:40"
	tb4_17   		=   "Mit-Wem-Spalte nicht ausgefüllt 06:40-06:50"
	tb4_18   		=   "Mit-Wem-Spalte nicht ausgefüllt 06:50-07:00"
	tb4_19   		=   "Mit-Wem-Spalte nicht ausgefüllt 07:00-07:10"
	tb4_20   		=   "Mit-Wem-Spalte nicht ausgefüllt 07:10-07:20"
	tb4_21   		=   "Mit-Wem-Spalte nicht ausgefüllt 07:20-07:30"
	tb4_22   		=   "Mit-Wem-Spalte nicht ausgefüllt 07:30-07:40"
	tb4_23   		=   "Mit-Wem-Spalte nicht ausgefüllt 07:40-07:50"
	tb4_24   		=   "Mit-Wem-Spalte nicht ausgefüllt 07:50-08:00"
	tb4_25   		=   "Mit-Wem-Spalte nicht ausgefüllt 08:00-08:10"
	tb4_26   		=   "Mit-Wem-Spalte nicht ausgefüllt 08:10-08:20"
	tb4_27   		=   "Mit-Wem-Spalte nicht ausgefüllt 08:20-08:30"
	tb4_28   		=   "Mit-Wem-Spalte nicht ausgefüllt 08:30-08:40"
	tb4_29   		=   "Mit-Wem-Spalte nicht ausgefüllt 08:40-08:50"
	tb4_30   		=   "Mit-Wem-Spalte nicht ausgefüllt 08:50-09:00"
	tb4_31   		=   "Mit-Wem-Spalte nicht ausgefüllt 09:00-09:10"
	tb4_32   		=   "Mit-Wem-Spalte nicht ausgefüllt 09:10-09:20"
	tb4_33   		=   "Mit-Wem-Spalte nicht ausgefüllt 09:20-09:30"
	tb4_34   		=   "Mit-Wem-Spalte nicht ausgefüllt 09:30-09:40"
	tb4_35   		=   "Mit-Wem-Spalte nicht ausgefüllt 09:40-09:50"
	tb4_36   		=   "Mit-Wem-Spalte nicht ausgefüllt 09:50-10:00"
	tb4_37   		=   "Mit-Wem-Spalte nicht ausgefüllt 10:00-10:10"
	tb4_38   		=   "Mit-Wem-Spalte nicht ausgefüllt 10:10-10:20"
	tb4_39   		=   "Mit-Wem-Spalte nicht ausgefüllt 10:20-10:30"
	tb4_40   		=   "Mit-Wem-Spalte nicht ausgefüllt 10:30-10:40"
	tb4_41   		=   "Mit-Wem-Spalte nicht ausgefüllt 10:40-10:50"
	tb4_42   		=   "Mit-Wem-Spalte nicht ausgefüllt 10:50-11:00"
	tb4_43   		=   "Mit-Wem-Spalte nicht ausgefüllt 11:00-11:10"
	tb4_44   		=   "Mit-Wem-Spalte nicht ausgefüllt 11:10-11:20"
	tb4_45   		=   "Mit-Wem-Spalte nicht ausgefüllt 11:20-11:30"
	tb4_46   		=   "Mit-Wem-Spalte nicht ausgefüllt 11:30-11:40"
	tb4_47   		=   "Mit-Wem-Spalte nicht ausgefüllt 11:40-11:50"
	tb4_48   		=   "Mit-Wem-Spalte nicht ausgefüllt 11:50-12:00"
	tb4_49   		=   "Mit-Wem-Spalte nicht ausgefüllt 12:00-12:10"
	tb4_50   		=   "Mit-Wem-Spalte nicht ausgefüllt 12:10-12:20"
	tb4_51   		=   "Mit-Wem-Spalte nicht ausgefüllt 12:20-12:30"
	tb4_52   		=   "Mit-Wem-Spalte nicht ausgefüllt 12:30-12:40"
	tb4_53   		=   "Mit-Wem-Spalte nicht ausgefüllt 12:40-12:50"
	tb4_54   		=   "Mit-Wem-Spalte nicht ausgefüllt 12:50-13:00"
	tb4_55   		=   "Mit-Wem-Spalte nicht ausgefüllt 13:00-13:10"
	tb4_56   		=   "Mit-Wem-Spalte nicht ausgefüllt 13:10-13:20"
	tb4_57   		=   "Mit-Wem-Spalte nicht ausgefüllt 13:20-13:30"
	tb4_58   		=   "Mit-Wem-Spalte nicht ausgefüllt 13:30-13:40"
	tb4_59   		=   "Mit-Wem-Spalte nicht ausgefüllt 13:40-13:50"
	tb4_60   		=   "Mit-Wem-Spalte nicht ausgefüllt 13:50-14:00"
	tb4_61   		=   "Mit-Wem-Spalte nicht ausgefüllt 14:00-14:10"
	tb4_62   		=   "Mit-Wem-Spalte nicht ausgefüllt 14:10-14:20"
	tb4_63   		=   "Mit-Wem-Spalte nicht ausgefüllt 14:20-14:30"
	tb4_64   		=   "Mit-Wem-Spalte nicht ausgefüllt 14:30-14:40"
	tb4_65   		=   "Mit-Wem-Spalte nicht ausgefüllt 14:40-14:50"
	tb4_66   		=   "Mit-Wem-Spalte nicht ausgefüllt 14:50-15:00"
	tb4_67   		=   "Mit-Wem-Spalte nicht ausgefüllt 15:00-15:10"
	tb4_68   		=   "Mit-Wem-Spalte nicht ausgefüllt 15:10-15:20"
	tb4_69   		=   "Mit-Wem-Spalte nicht ausgefüllt 15:20-15:30"
	tb4_70   		=   "Mit-Wem-Spalte nicht ausgefüllt 15:30-15:40"
	tb4_71   		=   "Mit-Wem-Spalte nicht ausgefüllt 15:40-15:50"
	tb4_72   		=   "Mit-Wem-Spalte nicht ausgefüllt 15:50-16:00"
	tb4_73   		=   "Mit-Wem-Spalte nicht ausgefüllt 16:00-16:10"
	tb4_74   		=   "Mit-Wem-Spalte nicht ausgefüllt 16:10-16:20"
	tb4_75   		=   "Mit-Wem-Spalte nicht ausgefüllt 16:20-16:30"
	tb4_76   		=   "Mit-Wem-Spalte nicht ausgefüllt 16:30-16:40"
	tb4_77   		=   "Mit-Wem-Spalte nicht ausgefüllt 16:40-16:50"
	tb4_78   		=   "Mit-Wem-Spalte nicht ausgefüllt 16:50-17:00"
	tb4_79   		=   "Mit-Wem-Spalte nicht ausgefüllt 17:00-17:10"
	tb4_80   		=   "Mit-Wem-Spalte nicht ausgefüllt 17:10-17:20"
	tb4_81   		=   "Mit-Wem-Spalte nicht ausgefüllt 17:20-17:30"
	tb4_82   		=   "Mit-Wem-Spalte nicht ausgefüllt 17:30-17:40"
	tb4_83   		=   "Mit-Wem-Spalte nicht ausgefüllt 17:40-17:50"
	tb4_84   		=   "Mit-Wem-Spalte nicht ausgefüllt 17:50-18:00"
	tb4_85   		=   "Mit-Wem-Spalte nicht ausgefüllt 18:00-18:10"
	tb4_86   		=   "Mit-Wem-Spalte nicht ausgefüllt 18:10-18:20"
	tb4_87   		=   "Mit-Wem-Spalte nicht ausgefüllt 18:20-18:30"
	tb4_88   		=   "Mit-Wem-Spalte nicht ausgefüllt 18:30-18:40"
	tb4_89   		=   "Mit-Wem-Spalte nicht ausgefüllt 18:40-18:50"
	tb4_90   		=   "Mit-Wem-Spalte nicht ausgefüllt 18:50-19:00"
	tb4_91   		=   "Mit-Wem-Spalte nicht ausgefüllt 19:00-19:10"
	tb4_92   		=   "Mit-Wem-Spalte nicht ausgefüllt 19:10-19:20"
	tb4_93   		=   "Mit-Wem-Spalte nicht ausgefüllt 19:20-19:30"
	tb4_94   		=   "Mit-Wem-Spalte nicht ausgefüllt 19:30-19:40"
	tb4_95   		=   "Mit-Wem-Spalte nicht ausgefüllt 19:40-19:50"
	tb4_96   		=   "Mit-Wem-Spalte nicht ausgefüllt 19:50-20:00"
	tb4_97   		=   "Mit-Wem-Spalte nicht ausgefüllt 20:00-20:10"
	tb4_98   		=   "Mit-Wem-Spalte nicht ausgefüllt 20:10-20:20"
	tb4_99   		=   "Mit-Wem-Spalte nicht ausgefüllt 20:20-20:30"
	tb4_100   		=   "Mit-Wem-Spalte nicht ausgefüllt 20:30-20:40"
	tb4_101   		=   "Mit-Wem-Spalte nicht ausgefüllt 20:40-20:50"
	tb4_102   		=   "Mit-Wem-Spalte nicht ausgefüllt 20:50-21:00"
	tb4_103   		=   "Mit-Wem-Spalte nicht ausgefüllt 21:00-21:10"
	tb4_104   		=   "Mit-Wem-Spalte nicht ausgefüllt 21:10-21:20"
	tb4_105   		=   "Mit-Wem-Spalte nicht ausgefüllt 21:20-21:30"
	tb4_106   		=   "Mit-Wem-Spalte nicht ausgefüllt 21:30-21:40"
	tb4_107   		=   "Mit-Wem-Spalte nicht ausgefüllt 21:40-21:50"
	tb4_108   		=   "Mit-Wem-Spalte nicht ausgefüllt 21:50-22:00"
	tb4_109   		=   "Mit-Wem-Spalte nicht ausgefüllt 22:00-22:10"
	tb4_110   		=   "Mit-Wem-Spalte nicht ausgefüllt 22:10-22:20"
	tb4_111   		=   "Mit-Wem-Spalte nicht ausgefüllt 22:20-22:30"
	tb4_112   		=   "Mit-Wem-Spalte nicht ausgefüllt 22:30-22:40"
	tb4_113   		=   "Mit-Wem-Spalte nicht ausgefüllt 22:40-22:50"
	tb4_114   		=   "Mit-Wem-Spalte nicht ausgefüllt 22:50-23:00"
	tb4_115   		=   "Mit-Wem-Spalte nicht ausgefüllt 23:00-23:10"
	tb4_116   		=   "Mit-Wem-Spalte nicht ausgefüllt 23:10-23:20"
	tb4_117   		=   "Mit-Wem-Spalte nicht ausgefüllt 23:20-23:30"
	tb4_118   		=   "Mit-Wem-Spalte nicht ausgefüllt 23:30-23:40"
	tb4_119   		=   "Mit-Wem-Spalte nicht ausgefüllt 23:40-23:50"
	tb4_120   		=   "Mit-Wem-Spalte nicht ausgefüllt 23:50-00:00"
	tb4_121   		=   "Mit-Wem-Spalte nicht ausgefüllt 00:00-00:10"
	tb4_122   		=   "Mit-Wem-Spalte nicht ausgefüllt 00:10-00:20"
	tb4_123   		=   "Mit-Wem-Spalte nicht ausgefüllt 00:20-00:30"
	tb4_124   		=   "Mit-Wem-Spalte nicht ausgefüllt 00:30-00:40"
	tb4_125   		=   "Mit-Wem-Spalte nicht ausgefüllt 00:40-00:50"
	tb4_126   		=   "Mit-Wem-Spalte nicht ausgefüllt 00:50-01:00"
	tb4_127   		=   "Mit-Wem-Spalte nicht ausgefüllt 01:00-01:10"
	tb4_128   		=   "Mit-Wem-Spalte nicht ausgefüllt 01:10-01:20"
	tb4_129   		=   "Mit-Wem-Spalte nicht ausgefüllt 01:20-01:30"
	tb4_130   		=   "Mit-Wem-Spalte nicht ausgefüllt 01:30-01:40"
	tb4_131   		=   "Mit-Wem-Spalte nicht ausgefüllt 01:40-01:50"
	tb4_132   		=   "Mit-Wem-Spalte nicht ausgefüllt 01:50-02:00"
	tb4_133   		=   "Mit-Wem-Spalte nicht ausgefüllt 02:00-02:10"
	tb4_134   		=   "Mit-Wem-Spalte nicht ausgefüllt 02:10-02:20"
	tb4_135   		=   "Mit-Wem-Spalte nicht ausgefüllt 02:20-02:30"
	tb4_136   		=   "Mit-Wem-Spalte nicht ausgefüllt 02:30-02:40"
	tb4_137   		=   "Mit-Wem-Spalte nicht ausgefüllt 02:40-02:50"
	tb4_138   		=   "Mit-Wem-Spalte nicht ausgefüllt 02:50-03:00"
	tb4_139   		=   "Mit-Wem-Spalte nicht ausgefüllt 03:00-03:10"
	tb4_140   		=   "Mit-Wem-Spalte nicht ausgefüllt 03:10-03:20"
	tb4_141   		=   "Mit-Wem-Spalte nicht ausgefüllt 03:20-03:30"
	tb4_142   		=   "Mit-Wem-Spalte nicht ausgefüllt 03:30-03:40"
	tb4_143   		=   "Mit-Wem-Spalte nicht ausgefüllt 03:40-03:50"
	tb4_144   		=   "Mit-Wem-Spalte nicht ausgefüllt 03:50-04:00"
	tb5_1   		=   "War allein 04:00-04:10"
	tb5_2   		=   "War allein 04:10-04:20"
	tb5_3   		=   "War allein 04:20-04:30"
	tb5_4   		=   "War allein 04:30-04:40"
	tb5_5   		=   "War allein 04:40-04:50"
	tb5_6   		=   "War allein 04:50-05:00"
	tb5_7   		=   "War allein 05:00-05:10"
	tb5_8   		=   "War allein 05:10-05:20"
	tb5_9   		=   "War allein 05:20-05:30"
	tb5_10   		=   "War allein 05:30-05:40"
	tb5_11   		=   "War allein 05:40-05:50"
	tb5_12   		=   "War allein 05:50-06:00"
	tb5_13   		=   "War allein 06:00-06:10"
	tb5_14   		=   "War allein 06:10-06:20"
	tb5_15   		=   "War allein 06:20-06:30"
	tb5_16   		=   "War allein 06:30-06:40"
	tb5_17   		=   "War allein 06:40-06:50"
	tb5_18   		=   "War allein 06:50-07:00"
	tb5_19   		=   "War allein 07:00-07:10"
	tb5_20   		=   "War allein 07:10-07:20"
	tb5_21   		=   "War allein 07:20-07:30"
	tb5_22   		=   "War allein 07:30-07:40"
	tb5_23   		=   "War allein 07:40-07:50"
	tb5_24   		=   "War allein 07:50-08:00"
	tb5_25   		=   "War allein 08:00-08:10"
	tb5_26   		=   "War allein 08:10-08:20"
	tb5_27   		=   "War allein 08:20-08:30"
	tb5_28   		=   "War allein 08:30-08:40"
	tb5_29   		=   "War allein 08:40-08:50"
	tb5_30   		=   "War allein 08:50-09:00"
	tb5_31   		=   "War allein 09:00-09:10"
	tb5_32   		=   "War allein 09:10-09:20"
	tb5_33   		=   "War allein 09:20-09:30"
	tb5_34   		=   "War allein 09:30-09:40"
	tb5_35   		=   "War allein 09:40-09:50"
	tb5_36   		=   "War allein 09:50-10:00"
	tb5_37   		=   "War allein 10:00-10:10"
	tb5_38   		=   "War allein 10:10-10:20"
	tb5_39   		=   "War allein 10:20-10:30"
	tb5_40   		=   "War allein 10:30-10:40"
	tb5_41   		=   "War allein 10:40-10:50"
	tb5_42   		=   "War allein 10:50-11:00"
	tb5_43   		=   "War allein 11:00-11:10"
	tb5_44   		=   "War allein 11:10-11:20"
	tb5_45   		=   "War allein 11:20-11:30"
	tb5_46   		=   "War allein 11:30-11:40"
	tb5_47   		=   "War allein 11:40-11:50"
	tb5_48   		=   "War allein 11:50-12:00"
	tb5_49   		=   "War allein 12:00-12:10"
	tb5_50   		=   "War allein 12:10-12:20"
	tb5_51   		=   "War allein 12:20-12:30"
	tb5_52   		=   "War allein 12:30-12:40"
	tb5_53   		=   "War allein 12:40-12:50"
	tb5_54   		=   "War allein 12:50-13:00"
	tb5_55   		=   "War allein 13:00-13:10"
	tb5_56   		=   "War allein 13:10-13:20"
	tb5_57   		=   "War allein 13:20-13:30"
	tb5_58   		=   "War allein 13:30-13:40"
	tb5_59   		=   "War allein 13:40-13:50"
	tb5_60   		=   "War allein 13:50-14:00"
	tb5_61   		=   "War allein 14:00-14:10"
	tb5_62   		=   "War allein 14:10-14:20"
	tb5_63   		=   "War allein 14:20-14:30"
	tb5_64   		=   "War allein 14:30-14:40"
	tb5_65   		=   "War allein 14:40-14:50"
	tb5_66   		=   "War allein 14:50-15:00"
	tb5_67   		=   "War allein 15:00-15:10"
	tb5_68   		=   "War allein 15:10-15:20"
	tb5_69   		=   "War allein 15:20-15:30"
	tb5_70   		=   "War allein 15:30-15:40"
	tb5_71   		=   "War allein 15:40-15:50"
	tb5_72   		=   "War allein 15:50-16:00"
	tb5_73   		=   "War allein 16:00-16:10"
	tb5_74   		=   "War allein 16:10-16:20"
	tb5_75   		=   "War allein 16:20-16:30"
	tb5_76   		=   "War allein 16:30-16:40"
	tb5_77   		=   "War allein 16:40-16:50"
	tb5_78   		=   "War allein 16:50-17:00"
	tb5_79   		=   "War allein 17:00-17:10"
	tb5_80   		=   "War allein 17:10-17:20"
	tb5_81   		=   "War allein 17:20-17:30"
	tb5_82   		=   "War allein 17:30-17:40"
	tb5_83   		=   "War allein 17:40-17:50"
	tb5_84   		=   "War allein 17:50-18:00"
	tb5_85   		=   "War allein 18:00-18:10"
	tb5_86   		=   "War allein 18:10-18:20"
	tb5_87   		=   "War allein 18:20-18:30"
	tb5_88   		=   "War allein 18:30-18:40"
	tb5_89   		=   "War allein 18:40-18:50"
	tb5_90   		=   "War allein 18:50-19:00"
	tb5_91   		=   "War allein 19:00-19:10"
	tb5_92   		=   "War allein 19:10-19:20"
	tb5_93   		=   "War allein 19:20-19:30"
	tb5_94   		=   "War allein 19:30-19:40"
	tb5_95   		=   "War allein 19:40-19:50"
	tb5_96   		=   "War allein 19:50-20:00"
	tb5_97   		=   "War allein 20:00-20:10"
	tb5_98   		=   "War allein 20:10-20:20"
	tb5_99   		=   "War allein 20:20-20:30"
	tb5_100   		=   "War allein 20:30-20:40"
	tb5_101   		=   "War allein 20:40-20:50"
	tb5_102   		=   "War allein 20:50-21:00"
	tb5_103   		=   "War allein 21:00-21:10"
	tb5_104   		=   "War allein 21:10-21:20"
	tb5_105   		=   "War allein 21:20-21:30"
	tb5_106   		=   "War allein 21:30-21:40"
	tb5_107   		=   "War allein 21:40-21:50"
	tb5_108   		=   "War allein 21:50-22:00"
	tb5_109   		=   "War allein 22:00-22:10"
	tb5_110   		=   "War allein 22:10-22:20"
	tb5_111   		=   "War allein 22:20-22:30"
	tb5_112   		=   "War allein 22:30-22:40"
	tb5_113   		=   "War allein 22:40-22:50"
	tb5_114   		=   "War allein 22:50-23:00"
	tb5_115   		=   "War allein 23:00-23:10"
	tb5_116   		=   "War allein 23:10-23:20"
	tb5_117   		=   "War allein 23:20-23:30"
	tb5_118   		=   "War allein 23:30-23:40"
	tb5_119   		=   "War allein 23:40-23:50"
	tb5_120   		=   "War allein 23:50-00:00"
	tb5_121   		=   "War allein 00:00-00:10"
	tb5_122   		=   "War allein 00:10-00:20"
	tb5_123   		=   "War allein 00:20-00:30"
	tb5_124   		=   "War allein 00:30-00:40"
	tb5_125   		=   "War allein 00:40-00:50"
	tb5_126   		=   "War allein 00:50-01:00"
	tb5_127   		=   "War allein 01:00-01:10"
	tb5_128   		=   "War allein 01:10-01:20"
	tb5_129   		=   "War allein 01:20-01:30"
	tb5_130   		=   "War allein 01:30-01:40"
	tb5_131   		=   "War allein 01:40-01:50"
	tb5_132   		=   "War allein 01:50-02:00"
	tb5_133   		=   "War allein 02:00-02:10"
	tb5_134   		=   "War allein 02:10-02:20"
	tb5_135   		=   "War allein 02:20-02:30"
	tb5_136   		=   "War allein 02:30-02:40"
	tb5_137   		=   "War allein 02:40-02:50"
	tb5_138   		=   "War allein 02:50-03:00"
	tb5_139   		=   "War allein 03:00-03:10"
	tb5_140   		=   "War allein 03:10-03:20"
	tb5_141   		=   "War allein 03:20-03:30"
	tb5_142   		=   "War allein 03:30-03:40"
	tb5_143   		=   "War allein 03:40-03:50"
	tb5_144   		=   "War allein 03:50-04:00"
	tb6_1   		=   "Partner 04:00-04:10"
	tb6_2   		=   "Partner 04:10-04:20"
	tb6_3   		=   "Partner 04:20-04:30"
	tb6_4   		=   "Partner 04:30-04:40"
	tb6_5   		=   "Partner 04:40-04:50"
	tb6_6   		=   "Partner 04:50-05:00"
	tb6_7   		=   "Partner 05:00-05:10"
	tb6_8   		=   "Partner 05:10-05:20"
	tb6_9   		=   "Partner 05:20-05:30"
	tb6_10   		=   "Partner 05:30-05:40"
	tb6_11   		=   "Partner 05:40-05:50"
	tb6_12   		=   "Partner 05:50-06:00"
	tb6_13   		=   "Partner 06:00-06:10"
	tb6_14   		=   "Partner 06:10-06:20"
	tb6_15   		=   "Partner 06:20-06:30"
	tb6_16   		=   "Partner 06:30-06:40"
	tb6_17   		=   "Partner 06:40-06:50"
	tb6_18   		=   "Partner 06:50-07:00"
	tb6_19   		=   "Partner 07:00-07:10"
	tb6_20   		=   "Partner 07:10-07:20"
	tb6_21   		=   "Partner 07:20-07:30"
	tb6_22   		=   "Partner 07:30-07:40"
	tb6_23   		=   "Partner 07:40-07:50"
	tb6_24   		=   "Partner 07:50-08:00"
	tb6_25   		=   "Partner 08:00-08:10"
	tb6_26   		=   "Partner 08:10-08:20"
	tb6_27   		=   "Partner 08:20-08:30"
	tb6_28   		=   "Partner 08:30-08:40"
	tb6_29   		=   "Partner 08:40-08:50"
	tb6_30   		=   "Partner 08:50-09:00"
	tb6_31   		=   "Partner 09:00-09:10"
	tb6_32   		=   "Partner 09:10-09:20"
	tb6_33   		=   "Partner 09:20-09:30"
	tb6_34   		=   "Partner 09:30-09:40"
	tb6_35   		=   "Partner 09:40-09:50"
	tb6_36   		=   "Partner 09:50-10:00"
	tb6_37   		=   "Partner 10:00-10:10"
	tb6_38   		=   "Partner 10:10-10:20"
	tb6_39   		=   "Partner 10:20-10:30"
	tb6_40   		=   "Partner 10:30-10:40"
	tb6_41   		=   "Partner 10:40-10:50"
	tb6_42   		=   "Partner 10:50-11:00"
	tb6_43   		=   "Partner 11:00-11:10"
	tb6_44   		=   "Partner 11:10-11:20"
	tb6_45   		=   "Partner 11:20-11:30"
	tb6_46   		=   "Partner 11:30-11:40"
	tb6_47   		=   "Partner 11:40-11:50"
	tb6_48   		=   "Partner 11:50-12:00"
	tb6_49   		=   "Partner 12:00-12:10"
	tb6_50   		=   "Partner 12:10-12:20"
	tb6_51   		=   "Partner 12:20-12:30"
	tb6_52   		=   "Partner 12:30-12:40"
	tb6_53   		=   "Partner 12:40-12:50"
	tb6_54   		=   "Partner 12:50-13:00"
	tb6_55   		=   "Partner 13:00-13:10"
	tb6_56   		=   "Partner 13:10-13:20"
	tb6_57   		=   "Partner 13:20-13:30"
	tb6_58   		=   "Partner 13:30-13:40"
	tb6_59   		=   "Partner 13:40-13:50"
	tb6_60   		=   "Partner 13:50-14:00"
	tb6_61   		=   "Partner 14:00-14:10"
	tb6_62   		=   "Partner 14:10-14:20"
	tb6_63   		=   "Partner 14:20-14:30"
	tb6_64   		=   "Partner 14:30-14:40"
	tb6_65   		=   "Partner 14:40-14:50"
	tb6_66   		=   "Partner 14:50-15:00"
	tb6_67   		=   "Partner 15:00-15:10"
	tb6_68   		=   "Partner 15:10-15:20"
	tb6_69   		=   "Partner 15:20-15:30"
	tb6_70   		=   "Partner 15:30-15:40"
	tb6_71   		=   "Partner 15:40-15:50"
	tb6_72   		=   "Partner 15:50-16:00"
	tb6_73   		=   "Partner 16:00-16:10"
	tb6_74   		=   "Partner 16:10-16:20"
	tb6_75   		=   "Partner 16:20-16:30"
	tb6_76   		=   "Partner 16:30-16:40"
	tb6_77   		=   "Partner 16:40-16:50"
	tb6_78   		=   "Partner 16:50-17:00"
	tb6_79   		=   "Partner 17:00-17:10"
	tb6_80   		=   "Partner 17:10-17:20"
	tb6_81   		=   "Partner 17:20-17:30"
	tb6_82   		=   "Partner 17:30-17:40"
	tb6_83   		=   "Partner 17:40-17:50"
	tb6_84   		=   "Partner 17:50-18:00"
	tb6_85   		=   "Partner 18:00-18:10"
	tb6_86   		=   "Partner 18:10-18:20"
	tb6_87   		=   "Partner 18:20-18:30"
	tb6_88   		=   "Partner 18:30-18:40"
	tb6_89   		=   "Partner 18:40-18:50"
	tb6_90   		=   "Partner 18:50-19:00"
	tb6_91   		=   "Partner 19:00-19:10"
	tb6_92   		=   "Partner 19:10-19:20"
	tb6_93   		=   "Partner 19:20-19:30"
	tb6_94   		=   "Partner 19:30-19:40"
	tb6_95   		=   "Partner 19:40-19:50"
	tb6_96   		=   "Partner 19:50-20:00"
	tb6_97   		=   "Partner 20:00-20:10"
	tb6_98   		=   "Partner 20:10-20:20"
	tb6_99   		=   "Partner 20:20-20:30"
	tb6_100   		=   "Partner 20:30-20:40"
	tb6_101   		=   "Partner 20:40-20:50"
	tb6_102   		=   "Partner 20:50-21:00"
	tb6_103   		=   "Partner 21:00-21:10"
	tb6_104   		=   "Partner 21:10-21:20"
	tb6_105   		=   "Partner 21:20-21:30"
	tb6_106   		=   "Partner 21:30-21:40"
	tb6_107   		=   "Partner 21:40-21:50"
	tb6_108   		=   "Partner 21:50-22:00"
	tb6_109   		=   "Partner 22:00-22:10"
	tb6_110   		=   "Partner 22:10-22:20"
	tb6_111   		=   "Partner 22:20-22:30"
	tb6_112   		=   "Partner 22:30-22:40"
	tb6_113   		=   "Partner 22:40-22:50"
	tb6_114   		=   "Partner 22:50-23:00"
	tb6_115   		=   "Partner 23:00-23:10"
	tb6_116   		=   "Partner 23:10-23:20"
	tb6_117   		=   "Partner 23:20-23:30"
	tb6_118   		=   "Partner 23:30-23:40"
	tb6_119   		=   "Partner 23:40-23:50"
	tb6_120   		=   "Partner 23:50-00:00"
	tb6_121   		=   "Partner 00:00-00:10"
	tb6_122   		=   "Partner 00:10-00:20"
	tb6_123   		=   "Partner 00:20-00:30"
	tb6_124   		=   "Partner 00:30-00:40"
	tb6_125   		=   "Partner 00:40-00:50"
	tb6_126   		=   "Partner 00:50-01:00"
	tb6_127   		=   "Partner 01:00-01:10"
	tb6_128   		=   "Partner 01:10-01:20"
	tb6_129   		=   "Partner 01:20-01:30"
	tb6_130   		=   "Partner 01:30-01:40"
	tb6_131   		=   "Partner 01:40-01:50"
	tb6_132   		=   "Partner 01:50-02:00"
	tb6_133   		=   "Partner 02:00-02:10"
	tb6_134   		=   "Partner 02:10-02:20"
	tb6_135   		=   "Partner 02:20-02:30"
	tb6_136   		=   "Partner 02:30-02:40"
	tb6_137   		=   "Partner 02:40-02:50"
	tb6_138   		=   "Partner 02:50-03:00"
	tb6_139   		=   "Partner 03:00-03:10"
	tb6_140   		=   "Partner 03:10-03:20"
	tb6_141   		=   "Partner 03:20-03:30"
	tb6_142   		=   "Partner 03:30-03:40"
	tb6_143   		=   "Partner 03:40-03:50"
	tb6_144   		=   "Partner 03:50-04:00"
	tb7_1   		=   "Kinder unter 10 Jahren 04:00-04:10"
	tb7_2   		=   "Kinder unter 10 Jahren 04:10-04:20"
	tb7_3   		=   "Kinder unter 10 Jahren 04:20-04:30"
	tb7_4   		=   "Kinder unter 10 Jahren 04:30-04:40"
	tb7_5   		=   "Kinder unter 10 Jahren 04:40-04:50"
	tb7_6   		=   "Kinder unter 10 Jahren 04:50-05:00"
	tb7_7   		=   "Kinder unter 10 Jahren 05:00-05:10"
	tb7_8   		=   "Kinder unter 10 Jahren 05:10-05:20"
	tb7_9   		=   "Kinder unter 10 Jahren 05:20-05:30"
	tb7_10   		=   "Kinder unter 10 Jahren 05:30-05:40"
	tb7_11   		=   "Kinder unter 10 Jahren 05:40-05:50"
	tb7_12   		=   "Kinder unter 10 Jahren 05:50-06:00"
	tb7_13   		=   "Kinder unter 10 Jahren 06:00-06:10"
	tb7_14   		=   "Kinder unter 10 Jahren 06:10-06:20"
	tb7_15   		=   "Kinder unter 10 Jahren 06:20-06:30"
	tb7_16   		=   "Kinder unter 10 Jahren 06:30-06:40"
	tb7_17   		=   "Kinder unter 10 Jahren 06:40-06:50"
	tb7_18   		=   "Kinder unter 10 Jahren 06:50-07:00"
	tb7_19   		=   "Kinder unter 10 Jahren 07:00-07:10"
	tb7_20   		=   "Kinder unter 10 Jahren 07:10-07:20"
	tb7_21   		=   "Kinder unter 10 Jahren 07:20-07:30"
	tb7_22   		=   "Kinder unter 10 Jahren 07:30-07:40"
	tb7_23   		=   "Kinder unter 10 Jahren 07:40-07:50"
	tb7_24   		=   "Kinder unter 10 Jahren 07:50-08:00"
	tb7_25   		=   "Kinder unter 10 Jahren 08:00-08:10"
	tb7_26   		=   "Kinder unter 10 Jahren 08:10-08:20"
	tb7_27   		=   "Kinder unter 10 Jahren 08:20-08:30"
	tb7_28   		=   "Kinder unter 10 Jahren 08:30-08:40"
	tb7_29   		=   "Kinder unter 10 Jahren 08:40-08:50"
	tb7_30   		=   "Kinder unter 10 Jahren 08:50-09:00"
	tb7_31   		=   "Kinder unter 10 Jahren 09:00-09:10"
	tb7_32   		=   "Kinder unter 10 Jahren 09:10-09:20"
	tb7_33   		=   "Kinder unter 10 Jahren 09:20-09:30"
	tb7_34   		=   "Kinder unter 10 Jahren 09:30-09:40"
	tb7_35   		=   "Kinder unter 10 Jahren 09:40-09:50"
	tb7_36   		=   "Kinder unter 10 Jahren 09:50-10:00"
	tb7_37   		=   "Kinder unter 10 Jahren 10:00-10:10"
	tb7_38   		=   "Kinder unter 10 Jahren 10:10-10:20"
	tb7_39   		=   "Kinder unter 10 Jahren 10:20-10:30"
	tb7_40   		=   "Kinder unter 10 Jahren 10:30-10:40"
	tb7_41   		=   "Kinder unter 10 Jahren 10:40-10:50"
	tb7_42   		=   "Kinder unter 10 Jahren 10:50-11:00"
	tb7_43   		=   "Kinder unter 10 Jahren 11:00-11:10"
	tb7_44   		=   "Kinder unter 10 Jahren 11:10-11:20"
	tb7_45   		=   "Kinder unter 10 Jahren 11:20-11:30"
	tb7_46   		=   "Kinder unter 10 Jahren 11:30-11:40"
	tb7_47   		=   "Kinder unter 10 Jahren 11:40-11:50"
	tb7_48   		=   "Kinder unter 10 Jahren 11:50-12:00"
	tb7_49   		=   "Kinder unter 10 Jahren 12:00-12:10"
	tb7_50   		=   "Kinder unter 10 Jahren 12:10-12:20"
	tb7_51   		=   "Kinder unter 10 Jahren 12:20-12:30"
	tb7_52   		=   "Kinder unter 10 Jahren 12:30-12:40"
	tb7_53   		=   "Kinder unter 10 Jahren 12:40-12:50"
	tb7_54   		=   "Kinder unter 10 Jahren 12:50-13:00"
	tb7_55   		=   "Kinder unter 10 Jahren 13:00-13:10"
	tb7_56   		=   "Kinder unter 10 Jahren 13:10-13:20"
	tb7_57   		=   "Kinder unter 10 Jahren 13:20-13:30"
	tb7_58   		=   "Kinder unter 10 Jahren 13:30-13:40"
	tb7_59   		=   "Kinder unter 10 Jahren 13:40-13:50"
	tb7_60   		=   "Kinder unter 10 Jahren 13:50-14:00"
	tb7_61   		=   "Kinder unter 10 Jahren 14:00-14:10"
	tb7_62   		=   "Kinder unter 10 Jahren 14:10-14:20"
	tb7_63   		=   "Kinder unter 10 Jahren 14:20-14:30"
	tb7_64   		=   "Kinder unter 10 Jahren 14:30-14:40"
	tb7_65   		=   "Kinder unter 10 Jahren 14:40-14:50"
	tb7_66   		=   "Kinder unter 10 Jahren 14:50-15:00"
	tb7_67   		=   "Kinder unter 10 Jahren 15:00-15:10"
	tb7_68   		=   "Kinder unter 10 Jahren 15:10-15:20"
	tb7_69   		=   "Kinder unter 10 Jahren 15:20-15:30"
	tb7_70   		=   "Kinder unter 10 Jahren 15:30-15:40"
	tb7_71   		=   "Kinder unter 10 Jahren 15:40-15:50"
	tb7_72   		=   "Kinder unter 10 Jahren 15:50-16:00"
	tb7_73   		=   "Kinder unter 10 Jahren 16:00-16:10"
	tb7_74   		=   "Kinder unter 10 Jahren 16:10-16:20"
	tb7_75   		=   "Kinder unter 10 Jahren 16:20-16:30"
	tb7_76   		=   "Kinder unter 10 Jahren 16:30-16:40"
	tb7_77   		=   "Kinder unter 10 Jahren 16:40-16:50"
	tb7_78   		=   "Kinder unter 10 Jahren 16:50-17:00"
	tb7_79   		=   "Kinder unter 10 Jahren 17:00-17:10"
	tb7_80   		=   "Kinder unter 10 Jahren 17:10-17:20"
	tb7_81   		=   "Kinder unter 10 Jahren 17:20-17:30"
	tb7_82   		=   "Kinder unter 10 Jahren 17:30-17:40"
	tb7_83   		=   "Kinder unter 10 Jahren 17:40-17:50"
	tb7_84   		=   "Kinder unter 10 Jahren 17:50-18:00"
	tb7_85   		=   "Kinder unter 10 Jahren 18:00-18:10"
	tb7_86   		=   "Kinder unter 10 Jahren 18:10-18:20"
	tb7_87   		=   "Kinder unter 10 Jahren 18:20-18:30"
	tb7_88   		=   "Kinder unter 10 Jahren 18:30-18:40"
	tb7_89   		=   "Kinder unter 10 Jahren 18:40-18:50"
	tb7_90   		=   "Kinder unter 10 Jahren 18:50-19:00"
	tb7_91   		=   "Kinder unter 10 Jahren 19:00-19:10"
	tb7_92   		=   "Kinder unter 10 Jahren 19:10-19:20"
	tb7_93   		=   "Kinder unter 10 Jahren 19:20-19:30"
	tb7_94   		=   "Kinder unter 10 Jahren 19:30-19:40"
	tb7_95   		=   "Kinder unter 10 Jahren 19:40-19:50"
	tb7_96   		=   "Kinder unter 10 Jahren 19:50-20:00"
	tb7_97   		=   "Kinder unter 10 Jahren 20:00-20:10"
	tb7_98   		=   "Kinder unter 10 Jahren 20:10-20:20"
	tb7_99   		=   "Kinder unter 10 Jahren 20:20-20:30"
	tb7_100   		=   "Kinder unter 10 Jahren 20:30-20:40"
	tb7_101   		=   "Kinder unter 10 Jahren 20:40-20:50"
	tb7_102   		=   "Kinder unter 10 Jahren 20:50-21:00"
	tb7_103   		=   "Kinder unter 10 Jahren 21:00-21:10"
	tb7_104   		=   "Kinder unter 10 Jahren 21:10-21:20"
	tb7_105   		=   "Kinder unter 10 Jahren 21:20-21:30"
	tb7_106   		=   "Kinder unter 10 Jahren 21:30-21:40"
	tb7_107   		=   "Kinder unter 10 Jahren 21:40-21:50"
	tb7_108   		=   "Kinder unter 10 Jahren 21:50-22:00"
	tb7_109   		=   "Kinder unter 10 Jahren 22:00-22:10"
	tb7_110   		=   "Kinder unter 10 Jahren 22:10-22:20"
	tb7_111   		=   "Kinder unter 10 Jahren 22:20-22:30"
	tb7_112   		=   "Kinder unter 10 Jahren 22:30-22:40"
	tb7_113   		=   "Kinder unter 10 Jahren 22:40-22:50"
	tb7_114   		=   "Kinder unter 10 Jahren 22:50-23:00"
	tb7_115   		=   "Kinder unter 10 Jahren 23:00-23:10"
	tb7_116   		=   "Kinder unter 10 Jahren 23:10-23:20"
	tb7_117   		=   "Kinder unter 10 Jahren 23:20-23:30"
	tb7_118   		=   "Kinder unter 10 Jahren 23:30-23:40"
	tb7_119   		=   "Kinder unter 10 Jahren 23:40-23:50"
	tb7_120   		=   "Kinder unter 10 Jahren 23:50-00:00"
	tb7_121   		=   "Kinder unter 10 Jahren 00:00-00:10"
	tb7_122   		=   "Kinder unter 10 Jahren 00:10-00:20"
	tb7_123   		=   "Kinder unter 10 Jahren 00:20-00:30"
	tb7_124   		=   "Kinder unter 10 Jahren 00:30-00:40"
	tb7_125   		=   "Kinder unter 10 Jahren 00:40-00:50"
	tb7_126   		=   "Kinder unter 10 Jahren 00:50-01:00"
	tb7_127   		=   "Kinder unter 10 Jahren 01:00-01:10"
	tb7_128   		=   "Kinder unter 10 Jahren 01:10-01:20"
	tb7_129   		=   "Kinder unter 10 Jahren 01:20-01:30"
	tb7_130   		=   "Kinder unter 10 Jahren 01:30-01:40"
	tb7_131   		=   "Kinder unter 10 Jahren 01:40-01:50"
	tb7_132   		=   "Kinder unter 10 Jahren 01:50-02:00"
	tb7_133   		=   "Kinder unter 10 Jahren 02:00-02:10"
	tb7_134   		=   "Kinder unter 10 Jahren 02:10-02:20"
	tb7_135   		=   "Kinder unter 10 Jahren 02:20-02:30"
	tb7_136   		=   "Kinder unter 10 Jahren 02:30-02:40"
	tb7_137   		=   "Kinder unter 10 Jahren 02:40-02:50"
	tb7_138   		=   "Kinder unter 10 Jahren 02:50-03:00"
	tb7_139   		=   "Kinder unter 10 Jahren 03:00-03:10"
	tb7_140   		=   "Kinder unter 10 Jahren 03:10-03:20"
	tb7_141   		=   "Kinder unter 10 Jahren 03:20-03:30"
	tb7_142   		=   "Kinder unter 10 Jahren 03:30-03:40"
	tb7_143   		=   "Kinder unter 10 Jahren 03:40-03:50"
	tb7_144   		=   "Kinder unter 10 Jahren 03:50-04:00"
	tb8_1   		=   "Andere Haushaltsmitglieder 04:00-04:10"
	tb8_2   		=   "Andere Haushaltsmitglieder 04:10-04:20"
	tb8_3   		=   "Andere Haushaltsmitglieder 04:20-04:30"
	tb8_4   		=   "Andere Haushaltsmitglieder 04:30-04:40"
	tb8_5   		=   "Andere Haushaltsmitglieder 04:40-04:50"
	tb8_6   		=   "Andere Haushaltsmitglieder 04:50-05:00"
	tb8_7   		=   "Andere Haushaltsmitglieder 05:00-05:10"
	tb8_8   		=   "Andere Haushaltsmitglieder 05:10-05:20"
	tb8_9   		=   "Andere Haushaltsmitglieder 05:20-05:30"
	tb8_10   		=   "Andere Haushaltsmitglieder 05:30-05:40"
	tb8_11   		=   "Andere Haushaltsmitglieder 05:40-05:50"
	tb8_12   		=   "Andere Haushaltsmitglieder 05:50-06:00"
	tb8_13   		=   "Andere Haushaltsmitglieder 06:00-06:10"
	tb8_14   		=   "Andere Haushaltsmitglieder 06:10-06:20"
	tb8_15   		=   "Andere Haushaltsmitglieder 06:20-06:30"
	tb8_16   		=   "Andere Haushaltsmitglieder 06:30-06:40"
	tb8_17   		=   "Andere Haushaltsmitglieder 06:40-06:50"
	tb8_18   		=   "Andere Haushaltsmitglieder 06:50-07:00"
	tb8_19   		=   "Andere Haushaltsmitglieder 07:00-07:10"
	tb8_20   		=   "Andere Haushaltsmitglieder 07:10-07:20"
	tb8_21   		=   "Andere Haushaltsmitglieder 07:20-07:30"
	tb8_22   		=   "Andere Haushaltsmitglieder 07:30-07:40"
	tb8_23   		=   "Andere Haushaltsmitglieder 07:40-07:50"
	tb8_24   		=   "Andere Haushaltsmitglieder 07:50-08:00"
	tb8_25   		=   "Andere Haushaltsmitglieder 08:00-08:10"
	tb8_26   		=   "Andere Haushaltsmitglieder 08:10-08:20"
	tb8_27   		=   "Andere Haushaltsmitglieder 08:20-08:30"
	tb8_28   		=   "Andere Haushaltsmitglieder 08:30-08:40"
	tb8_29   		=   "Andere Haushaltsmitglieder 08:40-08:50"
	tb8_30   		=   "Andere Haushaltsmitglieder 08:50-09:00"
	tb8_31   		=   "Andere Haushaltsmitglieder 09:00-09:10"
	tb8_32   		=   "Andere Haushaltsmitglieder 09:10-09:20"
	tb8_33   		=   "Andere Haushaltsmitglieder 09:20-09:30"
	tb8_34   		=   "Andere Haushaltsmitglieder 09:30-09:40"
	tb8_35   		=   "Andere Haushaltsmitglieder 09:40-09:50"
	tb8_36   		=   "Andere Haushaltsmitglieder 09:50-10:00"
	tb8_37   		=   "Andere Haushaltsmitglieder 10:00-10:10"
	tb8_38   		=   "Andere Haushaltsmitglieder 10:10-10:20"
	tb8_39   		=   "Andere Haushaltsmitglieder 10:20-10:30"
	tb8_40   		=   "Andere Haushaltsmitglieder 10:30-10:40"
	tb8_41   		=   "Andere Haushaltsmitglieder 10:40-10:50"
	tb8_42   		=   "Andere Haushaltsmitglieder 10:50-11:00"
	tb8_43   		=   "Andere Haushaltsmitglieder 11:00-11:10"
	tb8_44   		=   "Andere Haushaltsmitglieder 11:10-11:20"
	tb8_45   		=   "Andere Haushaltsmitglieder 11:20-11:30"
	tb8_46   		=   "Andere Haushaltsmitglieder 11:30-11:40"
	tb8_47   		=   "Andere Haushaltsmitglieder 11:40-11:50"
	tb8_48   		=   "Andere Haushaltsmitglieder 11:50-12:00"
	tb8_49   		=   "Andere Haushaltsmitglieder 12:00-12:10"
	tb8_50   		=   "Andere Haushaltsmitglieder 12:10-12:20"
	tb8_51   		=   "Andere Haushaltsmitglieder 12:20-12:30"
	tb8_52   		=   "Andere Haushaltsmitglieder 12:30-12:40"
	tb8_53   		=   "Andere Haushaltsmitglieder 12:40-12:50"
	tb8_54   		=   "Andere Haushaltsmitglieder 12:50-13:00"
	tb8_55   		=   "Andere Haushaltsmitglieder 13:00-13:10"
	tb8_56   		=   "Andere Haushaltsmitglieder 13:10-13:20"
	tb8_57   		=   "Andere Haushaltsmitglieder 13:20-13:30"
	tb8_58   		=   "Andere Haushaltsmitglieder 13:30-13:40"
	tb8_59   		=   "Andere Haushaltsmitglieder 13:40-13:50"
	tb8_60   		=   "Andere Haushaltsmitglieder 13:50-14:00"
	tb8_61   		=   "Andere Haushaltsmitglieder 14:00-14:10"
	tb8_62   		=   "Andere Haushaltsmitglieder 14:10-14:20"
	tb8_63   		=   "Andere Haushaltsmitglieder 14:20-14:30"
	tb8_64   		=   "Andere Haushaltsmitglieder 14:30-14:40"
	tb8_65   		=   "Andere Haushaltsmitglieder 14:40-14:50"
	tb8_66   		=   "Andere Haushaltsmitglieder 14:50-15:00"
	tb8_67   		=   "Andere Haushaltsmitglieder 15:00-15:10"
	tb8_68   		=   "Andere Haushaltsmitglieder 15:10-15:20"
	tb8_69   		=   "Andere Haushaltsmitglieder 15:20-15:30"
	tb8_70   		=   "Andere Haushaltsmitglieder 15:30-15:40"
	tb8_71   		=   "Andere Haushaltsmitglieder 15:40-15:50"
	tb8_72   		=   "Andere Haushaltsmitglieder 15:50-16:00"
	tb8_73   		=   "Andere Haushaltsmitglieder 16:00-16:10"
	tb8_74   		=   "Andere Haushaltsmitglieder 16:10-16:20"
	tb8_75   		=   "Andere Haushaltsmitglieder 16:20-16:30"
	tb8_76   		=   "Andere Haushaltsmitglieder 16:30-16:40"
	tb8_77   		=   "Andere Haushaltsmitglieder 16:40-16:50"
	tb8_78   		=   "Andere Haushaltsmitglieder 16:50-17:00"
	tb8_79   		=   "Andere Haushaltsmitglieder 17:00-17:10"
	tb8_80   		=   "Andere Haushaltsmitglieder 17:10-17:20"
	tb8_81   		=   "Andere Haushaltsmitglieder 17:20-17:30"
	tb8_82   		=   "Andere Haushaltsmitglieder 17:30-17:40"
	tb8_83   		=   "Andere Haushaltsmitglieder 17:40-17:50"
	tb8_84   		=   "Andere Haushaltsmitglieder 17:50-18:00"
	tb8_85   		=   "Andere Haushaltsmitglieder 18:00-18:10"
	tb8_86   		=   "Andere Haushaltsmitglieder 18:10-18:20"
	tb8_87   		=   "Andere Haushaltsmitglieder 18:20-18:30"
	tb8_88   		=   "Andere Haushaltsmitglieder 18:30-18:40"
	tb8_89   		=   "Andere Haushaltsmitglieder 18:40-18:50"
	tb8_90   		=   "Andere Haushaltsmitglieder 18:50-19:00"
	tb8_91   		=   "Andere Haushaltsmitglieder 19:00-19:10"
	tb8_92   		=   "Andere Haushaltsmitglieder 19:10-19:20"
	tb8_93   		=   "Andere Haushaltsmitglieder 19:20-19:30"
	tb8_94   		=   "Andere Haushaltsmitglieder 19:30-19:40"
	tb8_95   		=   "Andere Haushaltsmitglieder 19:40-19:50"
	tb8_96   		=   "Andere Haushaltsmitglieder 19:50-20:00"
	tb8_97   		=   "Andere Haushaltsmitglieder 20:00-20:10"
	tb8_98   		=   "Andere Haushaltsmitglieder 20:10-20:20"
	tb8_99   		=   "Andere Haushaltsmitglieder 20:20-20:30"
	tb8_100   		=   "Andere Haushaltsmitglieder 20:30-20:40"
	tb8_101   		=   "Andere Haushaltsmitglieder 20:40-20:50"
	tb8_102   		=   "Andere Haushaltsmitglieder 20:50-21:00"
	tb8_103   		=   "Andere Haushaltsmitglieder 21:00-21:10"
	tb8_104   		=   "Andere Haushaltsmitglieder 21:10-21:20"
	tb8_105   		=   "Andere Haushaltsmitglieder 21:20-21:30"
	tb8_106   		=   "Andere Haushaltsmitglieder 21:30-21:40"
	tb8_107   		=   "Andere Haushaltsmitglieder 21:40-21:50"
	tb8_108   		=   "Andere Haushaltsmitglieder 21:50-22:00"
	tb8_109   		=   "Andere Haushaltsmitglieder 22:00-22:10"
	tb8_110   		=   "Andere Haushaltsmitglieder 22:10-22:20"
	tb8_111   		=   "Andere Haushaltsmitglieder 22:20-22:30"
	tb8_112   		=   "Andere Haushaltsmitglieder 22:30-22:40"
	tb8_113   		=   "Andere Haushaltsmitglieder 22:40-22:50"
	tb8_114   		=   "Andere Haushaltsmitglieder 22:50-23:00"
	tb8_115   		=   "Andere Haushaltsmitglieder 23:00-23:10"
	tb8_116   		=   "Andere Haushaltsmitglieder 23:10-23:20"
	tb8_117   		=   "Andere Haushaltsmitglieder 23:20-23:30"
	tb8_118   		=   "Andere Haushaltsmitglieder 23:30-23:40"
	tb8_119   		=   "Andere Haushaltsmitglieder 23:40-23:50"
	tb8_120   		=   "Andere Haushaltsmitglieder 23:50-00:00"
	tb8_121   		=   "Andere Haushaltsmitglieder 00:00-00:10"
	tb8_122   		=   "Andere Haushaltsmitglieder 00:10-00:20"
	tb8_123   		=   "Andere Haushaltsmitglieder 00:20-00:30"
	tb8_124   		=   "Andere Haushaltsmitglieder 00:30-00:40"
	tb8_125   		=   "Andere Haushaltsmitglieder 00:40-00:50"
	tb8_126   		=   "Andere Haushaltsmitglieder 00:50-01:00"
	tb8_127   		=   "Andere Haushaltsmitglieder 01:00-01:10"
	tb8_128   		=   "Andere Haushaltsmitglieder 01:10-01:20"
	tb8_129   		=   "Andere Haushaltsmitglieder 01:20-01:30"
	tb8_130   		=   "Andere Haushaltsmitglieder 01:30-01:40"
	tb8_131   		=   "Andere Haushaltsmitglieder 01:40-01:50"
	tb8_132   		=   "Andere Haushaltsmitglieder 01:50-02:00"
	tb8_133   		=   "Andere Haushaltsmitglieder 02:00-02:10"
	tb8_134   		=   "Andere Haushaltsmitglieder 02:10-02:20"
	tb8_135   		=   "Andere Haushaltsmitglieder 02:20-02:30"
	tb8_136   		=   "Andere Haushaltsmitglieder 02:30-02:40"
	tb8_137   		=   "Andere Haushaltsmitglieder 02:40-02:50"
	tb8_138   		=   "Andere Haushaltsmitglieder 02:50-03:00"
	tb8_139   		=   "Andere Haushaltsmitglieder 03:00-03:10"
	tb8_140   		=   "Andere Haushaltsmitglieder 03:10-03:20"
	tb8_141   		=   "Andere Haushaltsmitglieder 03:20-03:30"
	tb8_142   		=   "Andere Haushaltsmitglieder 03:30-03:40"
	tb8_143   		=   "Andere Haushaltsmitglieder 03:40-03:50"
	tb8_144   		=   "Andere Haushaltsmitglieder 03:50-04:00"
	tb9_1   		=   "Bekannte 04:00-04:10"
	tb9_2   		=   "Bekannte 04:10-04:20"
	tb9_3   		=   "Bekannte 04:20-04:30"
	tb9_4   		=   "Bekannte 04:30-04:40"
	tb9_5   		=   "Bekannte 04:40-04:50"
	tb9_6   		=   "Bekannte 04:50-05:00"
	tb9_7   		=   "Bekannte 05:00-05:10"
	tb9_8   		=   "Bekannte 05:10-05:20"
	tb9_9   		=   "Bekannte 05:20-05:30"
	tb9_10   		=   "Bekannte 05:30-05:40"
	tb9_11   		=   "Bekannte 05:40-05:50"
	tb9_12   		=   "Bekannte 05:50-06:00"
	tb9_13   		=   "Bekannte 06:00-06:10"
	tb9_14   		=   "Bekannte 06:10-06:20"
	tb9_15   		=   "Bekannte 06:20-06:30"
	tb9_16   		=   "Bekannte 06:30-06:40"
	tb9_17   		=   "Bekannte 06:40-06:50"
	tb9_18   		=   "Bekannte 06:50-07:00"
	tb9_19   		=   "Bekannte 07:00-07:10"
	tb9_20   		=   "Bekannte 07:10-07:20"
	tb9_21   		=   "Bekannte 07:20-07:30"
	tb9_22   		=   "Bekannte 07:30-07:40"
	tb9_23   		=   "Bekannte 07:40-07:50"
	tb9_24   		=   "Bekannte 07:50-08:00"
	tb9_25   		=   "Bekannte 08:00-08:10"
	tb9_26   		=   "Bekannte 08:10-08:20"
	tb9_27   		=   "Bekannte 08:20-08:30"
	tb9_28   		=   "Bekannte 08:30-08:40"
	tb9_29   		=   "Bekannte 08:40-08:50"
	tb9_30   		=   "Bekannte 08:50-09:00"
	tb9_31   		=   "Bekannte 09:00-09:10"
	tb9_32   		=   "Bekannte 09:10-09:20"
	tb9_33   		=   "Bekannte 09:20-09:30"
	tb9_34   		=   "Bekannte 09:30-09:40"
	tb9_35   		=   "Bekannte 09:40-09:50"
	tb9_36   		=   "Bekannte 09:50-10:00"
	tb9_37   		=   "Bekannte 10:00-10:10"
	tb9_38   		=   "Bekannte 10:10-10:20"
	tb9_39   		=   "Bekannte 10:20-10:30"
	tb9_40   		=   "Bekannte 10:30-10:40"
	tb9_41   		=   "Bekannte 10:40-10:50"
	tb9_42   		=   "Bekannte 10:50-11:00"
	tb9_43   		=   "Bekannte 11:00-11:10"
	tb9_44   		=   "Bekannte 11:10-11:20"
	tb9_45   		=   "Bekannte 11:20-11:30"
	tb9_46   		=   "Bekannte 11:30-11:40"
	tb9_47   		=   "Bekannte 11:40-11:50"
	tb9_48   		=   "Bekannte 11:50-12:00"
	tb9_49   		=   "Bekannte 12:00-12:10"
	tb9_50   		=   "Bekannte 12:10-12:20"
	tb9_51   		=   "Bekannte 12:20-12:30"
	tb9_52   		=   "Bekannte 12:30-12:40"
	tb9_53   		=   "Bekannte 12:40-12:50"
	tb9_54   		=   "Bekannte 12:50-13:00"
	tb9_55   		=   "Bekannte 13:00-13:10"
	tb9_56   		=   "Bekannte 13:10-13:20"
	tb9_57   		=   "Bekannte 13:20-13:30"
	tb9_58   		=   "Bekannte 13:30-13:40"
	tb9_59   		=   "Bekannte 13:40-13:50"
	tb9_60   		=   "Bekannte 13:50-14:00"
	tb9_61   		=   "Bekannte 14:00-14:10"
	tb9_62   		=   "Bekannte 14:10-14:20"
	tb9_63   		=   "Bekannte 14:20-14:30"
	tb9_64   		=   "Bekannte 14:30-14:40"
	tb9_65   		=   "Bekannte 14:40-14:50"
	tb9_66   		=   "Bekannte 14:50-15:00"
	tb9_67   		=   "Bekannte 15:00-15:10"
	tb9_68   		=   "Bekannte 15:10-15:20"
	tb9_69   		=   "Bekannte 15:20-15:30"
	tb9_70   		=   "Bekannte 15:30-15:40"
	tb9_71   		=   "Bekannte 15:40-15:50"
	tb9_72   		=   "Bekannte 15:50-16:00"
	tb9_73   		=   "Bekannte 16:00-16:10"
	tb9_74   		=   "Bekannte 16:10-16:20"
	tb9_75   		=   "Bekannte 16:20-16:30"
	tb9_76   		=   "Bekannte 16:30-16:40"
	tb9_77   		=   "Bekannte 16:40-16:50"
	tb9_78   		=   "Bekannte 16:50-17:00"
	tb9_79   		=   "Bekannte 17:00-17:10"
	tb9_80   		=   "Bekannte 17:10-17:20"
	tb9_81   		=   "Bekannte 17:20-17:30"
	tb9_82   		=   "Bekannte 17:30-17:40"
	tb9_83   		=   "Bekannte 17:40-17:50"
	tb9_84   		=   "Bekannte 17:50-18:00"
	tb9_85   		=   "Bekannte 18:00-18:10"
	tb9_86   		=   "Bekannte 18:10-18:20"
	tb9_87   		=   "Bekannte 18:20-18:30"
	tb9_88   		=   "Bekannte 18:30-18:40"
	tb9_89   		=   "Bekannte 18:40-18:50"
	tb9_90   		=   "Bekannte 18:50-19:00"
	tb9_91   		=   "Bekannte 19:00-19:10"
	tb9_92   		=   "Bekannte 19:10-19:20"
	tb9_93   		=   "Bekannte 19:20-19:30"
	tb9_94   		=   "Bekannte 19:30-19:40"
	tb9_95   		=   "Bekannte 19:40-19:50"
	tb9_96   		=   "Bekannte 19:50-20:00"
	tb9_97   		=   "Bekannte 20:00-20:10"
	tb9_98   		=   "Bekannte 20:10-20:20"
	tb9_99   		=   "Bekannte 20:20-20:30"
	tb9_100   		=   "Bekannte 20:30-20:40"
	tb9_101   		=   "Bekannte 20:40-20:50"
	tb9_102   		=   "Bekannte 20:50-21:00"
	tb9_103   		=   "Bekannte 21:00-21:10"
	tb9_104   		=   "Bekannte 21:10-21:20"
	tb9_105   		=   "Bekannte 21:20-21:30"
	tb9_106   		=   "Bekannte 21:30-21:40"
	tb9_107   		=   "Bekannte 21:40-21:50"
	tb9_108   		=   "Bekannte 21:50-22:00"
	tb9_109   		=   "Bekannte 22:00-22:10"
	tb9_110   		=   "Bekannte 22:10-22:20"
	tb9_111   		=   "Bekannte 22:20-22:30"
	tb9_112   		=   "Bekannte 22:30-22:40"
	tb9_113   		=   "Bekannte 22:40-22:50"
	tb9_114   		=   "Bekannte 22:50-23:00"
	tb9_115   		=   "Bekannte 23:00-23:10"
	tb9_116   		=   "Bekannte 23:10-23:20"
	tb9_117   		=   "Bekannte 23:20-23:30"
	tb9_118   		=   "Bekannte 23:30-23:40"
	tb9_119   		=   "Bekannte 23:40-23:50"
	tb9_120   		=   "Bekannte 23:50-00:00"
	tb9_121   		=   "Bekannte 00:00-00:10"
	tb9_122   		=   "Bekannte 00:10-00:20"
	tb9_123   		=   "Bekannte 00:20-00:30"
	tb9_124   		=   "Bekannte 00:30-00:40"
	tb9_125   		=   "Bekannte 00:40-00:50"
	tb9_126   		=   "Bekannte 00:50-01:00"
	tb9_127   		=   "Bekannte 01:00-01:10"
	tb9_128   		=   "Bekannte 01:10-01:20"
	tb9_129   		=   "Bekannte 01:20-01:30"
	tb9_130   		=   "Bekannte 01:30-01:40"
	tb9_131   		=   "Bekannte 01:40-01:50"
	tb9_132   		=   "Bekannte 01:50-02:00"
	tb9_133   		=   "Bekannte 02:00-02:10"
	tb9_134   		=   "Bekannte 02:10-02:20"
	tb9_135   		=   "Bekannte 02:20-02:30"
	tb9_136   		=   "Bekannte 02:30-02:40"
	tb9_137   		=   "Bekannte 02:40-02:50"
	tb9_138   		=   "Bekannte 02:50-03:00"
	tb9_139   		=   "Bekannte 03:00-03:10"
	tb9_140   		=   "Bekannte 03:10-03:20"
	tb9_141   		=   "Bekannte 03:20-03:30"
	tb9_142   		=   "Bekannte 03:30-03:40"
	tb9_143   		=   "Bekannte 03:40-03:50"
	tb9_144   		=   "Bekannte 03:50-04:00"
	tb1_1   		=   "Hauptaktivität 04:00-04:10"
	tb1_2   		=   "Hauptaktivität 04:10-04:20"
	tb1_3   		=   "Hauptaktivität 04:20-04:30"
	tb1_4   		=   "Hauptaktivität 04:30-04:40"
	tb1_5   		=   "Hauptaktivität 04:40-04:50"
	tb1_6   		=   "Hauptaktivität 04:50-05:00"
	tb1_7   		=   "Hauptaktivität 05:00-05:10"
	tb1_8   		=   "Hauptaktivität 05:10-05:20"
	tb1_9   		=   "Hauptaktivität 05:20-05:30"
	tb1_10   		=   "Hauptaktivität 05:30-05:40"
	tb1_11   		=   "Hauptaktivität 05:40-05:50"
	tb1_12   		=   "Hauptaktivität 05:50-06:00"
	tb1_13   		=   "Hauptaktivität 06:00-06:10"
	tb1_14   		=   "Hauptaktivität 06:10-06:20"
	tb1_15   		=   "Hauptaktivität 06:20-06:30"
	tb1_16   		=   "Hauptaktivität 06:30-06:40"
	tb1_17   		=   "Hauptaktivität 06:40-06:50"
	tb1_18   		=   "Hauptaktivität 06:50-07:00"
	tb1_19   		=   "Hauptaktivität 07:00-07:10"
	tb1_20   		=   "Hauptaktivität 07:10-07:20"
	tb1_21   		=   "Hauptaktivität 07:20-07:30"
	tb1_22   		=   "Hauptaktivität 07:30-07:40"
	tb1_23   		=   "Hauptaktivität 07:40-07:50"
	tb1_24   		=   "Hauptaktivität 07:50-08:00"
	tb1_25   		=   "Hauptaktivität 08:00-08:10"
	tb1_26   		=   "Hauptaktivität 08:10-08:20"
	tb1_27   		=   "Hauptaktivität 08:20-08:30"
	tb1_28   		=   "Hauptaktivität 08:30-08:40"
	tb1_29   		=   "Hauptaktivität 08:40-08:50"
	tb1_30   		=   "Hauptaktivität 08:50-09:00"
	tb1_31   		=   "Hauptaktivität 09:00-09:10"
	tb1_32   		=   "Hauptaktivität 09:10-09:20"
	tb1_33   		=   "Hauptaktivität 09:20-09:30"
	tb1_34   		=   "Hauptaktivität 09:30-09:40"
	tb1_35   		=   "Hauptaktivität 09:40-09:50"
	tb1_36   		=   "Hauptaktivität 09:50-10:00"
	tb1_37   		=   "Hauptaktivität 10:00-10:10"
	tb1_38   		=   "Hauptaktivität 10:10-10:20"
	tb1_39   		=   "Hauptaktivität 10:20-10:30"
	tb1_40   		=   "Hauptaktivität 10:30-10:40"
	tb1_41   		=   "Hauptaktivität 10:40-10:50"
	tb1_42   		=   "Hauptaktivität 10:50-11:00"
	tb1_43   		=   "Hauptaktivität 11:00-11:10"
	tb1_44   		=   "Hauptaktivität 11:10-11:20"
	tb1_45   		=   "Hauptaktivität 11:20-11:30"
	tb1_46   		=   "Hauptaktivität 11:30-11:40"
	tb1_47   		=   "Hauptaktivität 11:40-11:50"
	tb1_48   		=   "Hauptaktivität 11:50-12:00"
	tb1_49   		=   "Hauptaktivität 12:00-12:10"
	tb1_50   		=   "Hauptaktivität 12:10-12:20"
	tb1_51   		=   "Hauptaktivität 12:20-12:30"
	tb1_52   		=   "Hauptaktivität 12:30-12:40"
	tb1_53   		=   "Hauptaktivität 12:40-12:50"
	tb1_54   		=   "Hauptaktivität 12:50-13:00"
	tb1_55   		=   "Hauptaktivität 13:00-13:10"
	tb1_56   		=   "Hauptaktivität 13:10-13:20"
	tb1_57   		=   "Hauptaktivität 13:20-13:30"
	tb1_58   		=   "Hauptaktivität 13:30-13:40"
	tb1_59   		=   "Hauptaktivität 13:40-13:50"
	tb1_60   		=   "Hauptaktivität 13:50-14:00"
	tb1_61   		=   "Hauptaktivität 14:00-14:10"
	tb1_62   		=   "Hauptaktivität 14:10-14:20"
	tb1_63   		=   "Hauptaktivität 14:20-14:30"
	tb1_64   		=   "Hauptaktivität 14:30-14:40"
	tb1_65   		=   "Hauptaktivität 14:40-14:50"
	tb1_66   		=   "Hauptaktivität 14:50-15:00"
	tb1_67   		=   "Hauptaktivität 15:00-15:10"
	tb1_68   		=   "Hauptaktivität 15:10-15:20"
	tb1_69   		=   "Hauptaktivität 15:20-15:30"
	tb1_70   		=   "Hauptaktivität 15:30-15:40"
	tb1_71   		=   "Hauptaktivität 15:40-15:50"
	tb1_72   		=   "Hauptaktivität 15:50-16:00"
	tb1_73   		=   "Hauptaktivität 16:00-16:10"
	tb1_74   		=   "Hauptaktivität 16:10-16:20"
	tb1_75   		=   "Hauptaktivität 16:20-16:30"
	tb1_76   		=   "Hauptaktivität 16:30-16:40"
	tb1_77   		=   "Hauptaktivität 16:40-16:50"
	tb1_78   		=   "Hauptaktivität 16:50-17:00"
	tb1_79   		=   "Hauptaktivität 17:00-17:10"
	tb1_80   		=   "Hauptaktivität 17:10-17:20"
	tb1_81   		=   "Hauptaktivität 17:20-17:30"
	tb1_82   		=   "Hauptaktivität 17:30-17:40"
	tb1_83   		=   "Hauptaktivität 17:40-17:50"
	tb1_84   		=   "Hauptaktivität 17:50-18:00"
	tb1_85   		=   "Hauptaktivität 18:00-18:10"
	tb1_86   		=   "Hauptaktivität 18:10-18:20"
	tb1_87   		=   "Hauptaktivität 18:20-18:30"
	tb1_88   		=   "Hauptaktivität 18:30-18:40"
	tb1_89   		=   "Hauptaktivität 18:40-18:50"
	tb1_90   		=   "Hauptaktivität 18:50-19:00"
	tb1_91   		=   "Hauptaktivität 19:00-19:10"
	tb1_92   		=   "Hauptaktivität 19:10-19:20"
	tb1_93   		=   "Hauptaktivität 19:20-19:30"
	tb1_94   		=   "Hauptaktivität 19:30-19:40"
	tb1_95   		=   "Hauptaktivität 19:40-19:50"
	tb1_96   		=   "Hauptaktivität 19:50-20:00"
	tb1_97   		=   "Hauptaktivität 20:00-20:10"
	tb1_98   		=   "Hauptaktivität 20:10-20:20"
	tb1_99   		=   "Hauptaktivität 20:20-20:30"
	tb1_100   		=   "Hauptaktivität 20:30-20:40"
	tb1_101   		=   "Hauptaktivität 20:40-20:50"
	tb1_102   		=   "Hauptaktivität 20:50-21:00"
	tb1_103   		=   "Hauptaktivität 21:00-21:10"
	tb1_104   		=   "Hauptaktivität 21:10-21:20"
	tb1_105   		=   "Hauptaktivität 21:20-21:30"
	tb1_106   		=   "Hauptaktivität 21:30-21:40"
	tb1_107   		=   "Hauptaktivität 21:40-21:50"
	tb1_108   		=   "Hauptaktivität 21:50-22:00"
	tb1_109   		=   "Hauptaktivität 22:00-22:10"
	tb1_110   		=   "Hauptaktivität 22:10-22:20"
	tb1_111   		=   "Hauptaktivität 22:20-22:30"
	tb1_112   		=   "Hauptaktivität 22:30-22:40"
	tb1_113   		=   "Hauptaktivität 22:40-22:50"
	tb1_114   		=   "Hauptaktivität 22:50-23:00"
	tb1_115   		=   "Hauptaktivität 23:00-23:10"
	tb1_116   		=   "Hauptaktivität 23:10-23:20"
	tb1_117   		=   "Hauptaktivität 23:20-23:30"
	tb1_118   		=   "Hauptaktivität 23:30-23:40"
	tb1_119   		=   "Hauptaktivität 23:40-23:50"
	tb1_120   		=   "Hauptaktivität 23:50-00:00"
	tb1_121   		=   "Hauptaktivität 00:00-00:10"
	tb1_122   		=   "Hauptaktivität 00:10-00:20"
	tb1_123   		=   "Hauptaktivität 00:20-00:30"
	tb1_124   		=   "Hauptaktivität 00:30-00:40"
	tb1_125   		=   "Hauptaktivität 00:40-00:50"
	tb1_126   		=   "Hauptaktivität 00:50-01:00"
	tb1_127   		=   "Hauptaktivität 01:00-01:10"
	tb1_128   		=   "Hauptaktivität 01:10-01:20"
	tb1_129   		=   "Hauptaktivität 01:20-01:30"
	tb1_130   		=   "Hauptaktivität 01:30-01:40"
	tb1_131   		=   "Hauptaktivität 01:40-01:50"
	tb1_132   		=   "Hauptaktivität 01:50-02:00"
	tb1_133   		=   "Hauptaktivität 02:00-02:10"
	tb1_134   		=   "Hauptaktivität 02:10-02:20"
	tb1_135   		=   "Hauptaktivität 02:20-02:30"
	tb1_136   		=   "Hauptaktivität 02:30-02:40"
	tb1_137   		=   "Hauptaktivität 02:40-02:50"
	tb1_138   		=   "Hauptaktivität 02:50-03:00"
	tb1_139   		=   "Hauptaktivität 03:00-03:10"
	tb1_140   		=   "Hauptaktivität 03:10-03:20"
	tb1_141   		=   "Hauptaktivität 03:20-03:30"
	tb1_142   		=   "Hauptaktivität 03:30-03:40"
	tb1_143   		=   "Hauptaktivität 03:40-03:50"
	tb1_144   		=   "Hauptaktivität 03:50-04:00"		
;



run;

/*  (V)  ZVE 13 TAKT               */
/*	(iv) Löschen nicht mehr benötigter temporärer Dateien	*/

proc datasets lib=work nolist;
	delete	&dateiname4;
run;


/********************************************************************************************************/
/********************************************************************************************************/
/********************************************************************************************************/
/********************************************************************************************************/
/********************************************************************************************************/
