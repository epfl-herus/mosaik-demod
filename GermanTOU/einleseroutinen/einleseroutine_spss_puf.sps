*	********************************************************************************************************				
*					
*		1.	Programmname: einleseroutine_spss.sps
* 2. Stand: 04.03.2016		
*	 3. 	Autor: Forschungsdatenzentrum des Statistischen Bundesamtes		
*	 4. 	Programmziel: Einlesen und Labeln des Public-Use-Files der Erhebung zur Zeitverwendung 2012/2013, 		
*		  das als CSV-Datei mit Semikolons als Trennzeichen vorliegt.		
*		5. 	Programmstatus: Getestet mit IBM SPSS Statistics 20
*		6. 	Programmstruktur:		
*			  (I) Verzeichnisse, in denen sich die CSV-Daten befinden, Benennen der Einlesedateien, Benennen der temporären Ausgabedateien		
*		  	(II) ZVE 13 HH		
*					   (i) Einlesen CSV-Datei
*			    (ii)	Zuweisen der Variablenlabels 
*	     (iii)	Zuweisen der Wertelabels
*					   (iv) Speichern als SPSS-Datei
*			  (III) ZVE 13 pers		
*					   (i) Einlesen CSV-Datei
*			    (ii)	Zuweisen der Variablenlabels 
*	     (iii)	Zuweisen der Wertelabels
*					   (iv) Speichern als SPSS-Datei
*			  (IV) ZVE 13 sum		
*					   (i) Einlesen CSV-Datei
*			    (ii)	Zuweisen der Variablenlabels 
*	     (iii)	Zuweisen der Wertelabels
*					   (iv) Speichern als SPSS-Datei
*			  (V) ZVE 13 takt		
*					   (i) Einlesen CSV-Datei
*			    (ii)	Zuweisen der Variablenlabels 
*	     (iii)	Zuweisen der Wertelabels
*					   (iv) Speichern als SPSS-Datei
*					  
*	********************************************************************************************************				


*	(I)		Verzeichnisse, in denen sich die CSV-Daten befinden, Benennen der Einlesedatei, Benennen der temporären Ausgabedatei.

***********************************************************************************************.
* Die Zeilen 41, 46, 51 und 56 müssen individuell an die eigene Pfadumgebung angepasst werden*.
**********************************************************************************************.
*	zve 13 hh	.
DEFINE !Pfad1 () '<PFAD, IN DEM DIE CSV-DATEN LIEGEN ANPASSEN, z.B. E:\daten\>' !ENDDEFINE.
DEFINE !CSVdatei1 () 'zve13_puf_hh.csv' !ENDDEFINE.
DEFINE !Dateiname1 () 'zve13_puf_hh.sav' !ENDDEFINE.  

*	zve 13 pers	.
DEFINE !Pfad2 () '<PFAD, IN DEM DIE CSV-DATEN LIEGEN ANPASSEN, z.B. E:\daten\>' !ENDDEFINE.
DEFINE !CSVdatei2 () 'zve13_puf_pers.csv' !ENDDEFINE.
DEFINE !Dateiname2 () 'zve13_puf_pers.sav' !ENDDEFINE.

*	zve 13 sum	.
DEFINE !Pfad3 () '<PFAD, IN DEM DIE CSV-DATEN LIEGEN ANPASSEN, z.B. E:\daten\>' !ENDDEFINE.
DEFINE !CSVdatei3 () 'zve13_puf_sum.csv' !ENDDEFINE.
DEFINE !Dateiname3 () 'zve13_puf_sum.sav' !ENDDEFINE.

*	zve 13 takt	.
DEFINE !Pfad4 () '<PFAD, IN DEM DIE CSV-DATEN LIEGEN ANPASSEN, z.B. E:\daten\>' !ENDDEFINE.
DEFINE !CSVdatei4 () 'zve13_puf_takt.csv' !ENDDEFINE.
DEFINE !Dateiname4 () 'zve13_puf_takt.sav' !ENDDEFINE.


/**************************************************************************************/
/* Ab dieser Zeile müssen keine Anpassungen mehr vorgenommen werden*/
/**************************************************************************************/


*		  	(II) ZVE 13 HH		
*					 (i) Einlesen CSV-Datei.
GET DATA
 /TYPE=TXT
 /FILE=!Pfad1+!CSVdatei1
 /DELCASE=LINE
 /DELIMITERS=";"
 /ARRANGEMENT=DELIMITED
 /FIRSTCASE=2
 /IMPORTCASE=ALL
 /VARIABLES=
 id_hhx F4.0
 berichtsjahr F4.0
 ha1x F1.0
 hb9x F3.0
 hb10x F1.0
 hb11 F1.0
 hb121a F2.0
 hb121bx F2.0
 hb122a F2.0
 hb122bx F2.0
 hb13 F1.0
 hc141a F2.0
 hc141bx F2.0
 hc141cx F2.0
 hc142a F2.0
 hc142bx F2.0
 hc142cx F2.0
 hc143a F2.0
 hc143bx F2.0
 hc143cx F2.0
 hc144a F2.0
 hc144bx F2.0
 hc144cx F2.0
 hc145a F2.0
 hc145bx F2.0
 hc145cx F2.0
 hc146a F2.0
 hc146bx F2.0
 hc146cx F2.0
 hc147a F2.0
 hc147bx F2.0
 hc147cx F2.0
 hc148a F2.0
 hc148bx F2.0
 hc148cx F2.0
 hc149a F2.0
 hc149bx F2.0
 hc149cx F2.0
 hc1410a F2.0
 hc1410bx F2.0
 hc1410c F2.0
 hc1411a F2.0
 hc1411b F2.0
 hc1411cx F2.0
 hd15x F1.0
 he16 F1.0
 he17anzx F1.0
 hhtyp F1.0
 anz_kind27 F2.0
 juki F2.0
 juki_gr F2.0
 ha1_gr F1.0
 soz_heb F1.0
 anz_erw F1.0
 pers_part_heb F2.0
 anz_erwpart F2.0
 gebiet F1.0
 hrfh80 F7.0.
CACHE.
EXECUTE.

*		  	(II) ZVE 13 HH		
*			  (ii)	Zuweisen der Variablenlabels .
VARIABLE LABELS
hb9x	 'Wohnfläche Wohnung'
hb10x	 'Anzahl der Räume'
hb11	 'Eigentümer/Mieter/mietfrei'
hb121a	 'Auto'
hb121bx	 'Auto Anzahl'
hb122a	 'Computer'
hb122bx	 'Computer Anzahl'
hb13	 'Internetzugang'
hc141a	 'Unterstützung durch andere Personen: Kinderbetreuung'
hc141bx	 'Unterstützung durch andere Personen: bezahlte Stunden Kinderbetreuung'
hc141cx	 'Unterstützung durch andere Personen: unbezahlte Stunden Kinderbetreuung'
hc142a	 'Unterstützung durch andere Personen: Zubereitung von Mahlzeiten'
hc142bx	 'Unterstützung durch andere Personen: bezahlte Stunden Zubereitung von Mahlzeiten'
hc142cx	 'Unterstützung durch andere Personen: unbezahlte Stunden Zubereitung von Mahlzeiten'
hc143a	 'Unterstützung durch andere Personen: Putzen, Aufräumen, Waschen'
hc143bx	 'Unterstützung durch andere Personen: bezahlte Stunden Putzen, Aufräumen, Waschen'
hc143cx	 'Unterstützung durch andere Personen: unbezahlte Stunden Putzen, Aufräumen, Waschen'
hc144a	 'Unterstützung durch andere Personen: Nach dem Rechten sehen'
hc144bx	 'Unterstützung durch andere Personen: bezahlte Stunden nach dem Rechten sehen'
hc144cx	 'Unterstützung durch andere Personen: unbezahlte Stunden nach dem Rechten sehen'
hc145a	 'Unterstützung durch andere Personen: Gartenarbeit'
hc145bx	 'Unterstützung durch andere Personen: bezahlte Stunden Gartenarbeit'
hc145cx	 'Unterstützung durch andere Personen: unbezahlte Stunden Gartenarbeit'
hc146a	 'Unterstützung durch andere Personen: Einkaufen und Besorgungen'
hc146bx	 'Unterstützung durch andere Personen: bezahlte Stunden Einkaufen und Besorgungen'
hc146cx	 'Unterstützung durch andere Personen: unbezahlte Stunden Einkaufen und Besorgungen'
hc147a	 'Unterstützung durch andere Personen: Haustierpflege'
hc147bx	 'Unterstützung durch andere Personen: bezahlte Stunden Haustierpflege'
hc147cx	 'Unterstützung durch andere Personen: unbezahlte Stunden Haustierpflege'
hc148a	 'Unterstützung durch andere Personen: Reparatur von Fahrzeugen'
hc148bx	 'Unterstützung durch andere Personen: bezahlte Stunden Reparatur von Fahrzeugen'
hc148cx	 'Unterstützung durch andere Personen: unbezahlte Stunden Reparatur von Fahrzeugen'
hc149a	 'Unterstützung durch andere Personen: Reparieren und Bauen'
hc149bx	 'Unterstützung durch andere Personen: bezahlte Stunden Reparieren und Bauen'
hc149cx	 'Unterstützung durch andere Personen: unbezahlte Stunden Reparieren und Bauen'
hc1410a	 'Unterstützung durch andere Personen: Versicherungs-, Behördenangelegenheiten'
hc1410bx	 'Unterstützung durch andere Personen: bezahlte Stunden Versicherungs-, Behördenangelegenheiten'
hc1410c	 'Unterstützung durch andere Personen: unbezahlte Stunden Versicherungs-, Behördenangelegenheiten'
hc1411a	 'Unterstützung durch andere Personen: Sonstige Unterstützung'
hc1411b	 'Unterstützung durch andere Personen: bezahlte Stunden Sonstige Unterstützung'
hc1411cx	 'Unterstützung durch andere Personen: unbezahlte Stunden Sonstige Unterstützung'
hd15x	 'Monatliches Haushaltsnettoeinkommen'
he16	 'Kinder unter 10 Jahren im Haushalt'
hhtyp	 'Haushaltstyp'
anz_kind27	 'Anzahl der ledigen Kindern unter 27 Jahren'
juki	 'Alter des jüngsten Kindes in Haushalten mit Kindern unter 18 Jahren'
juki_gr	 'Altersklasse des jüngsten Kindes in Haushalten mit Kindern unter 18 Jahren'
ha1_gr	 'Anzahl der im Haushalt lebenden Personen'
soz_heb	 'Soziale Stellung des Haupteinkommensbeziehers'
anz_erw	 'Anzahl der Erwerbstätigen im Haushalt'
pers_part_heb	 'Personennummer des Partners des Haupteinkommensbeziehers'
anz_erwpart	 'Anzahl der Erwerbstätigen innerhalb der Partnerschaft (Haupteinkommensbezieher/Lebenspartner)'
gebiet	 'Gebiet'
id_hhx 'Haushalts-ID'
berichtsjahr 'Berichtsjahr'
ha1x 'Anzahl der im Haushalt lebenden Personen'
hrfh80 'Hochrechnungsfaktor für den Haushalt multipliziert mit 100 (ohne Nachkommastelle)'
he17anzx 'Anzahl der Kinder unter 10 Jahren'.



*		  	(II) ZVE 13 HH		
*	   (iii)	Zuweisen der Wertelabels.

value labels hb9x
'30' '30 qm und weniger'
'200' '200 qm und mehr'.
value labels hb10x
'8' '8 oder mehr'.
value labels hb11
'1' 'Eigentümer/-in'
'2' 'Mieter/-in'
'3' 'Wohnung mietfrei überlassen'.
value labels hb121a
'-1' 'keine Angabe'
'1' 'ja'
'2' 'nein'.
value labels hb121bx
'-1' 'keine Angabe'
'3' '3 oder mehr'.
value labels hb122a
'-1' 'keine Angabe'
'1' 'ja'
'2' 'nein'.
value labels hb122bx
'-1' 'keine Angabe'
'6' '6 oder mehr'.
value labels hb13
'1' 'ja'
'2' 'nein'.
value labels hc141a
'-1' 'keine Angabe'
'1' 'ja'
'2' 'nein'.
value labels hc141bx
'-1' 'keine Angabe'
'60' '60 und mehr'.
value labels hc141cx
'-1' 'keine Angabe'
'40' '40 und mehr'.
value labels hc142a
'-1' 'keine Angabe'
'1' 'ja'
'2' 'nein'.
value labels hc142bx
'-1' 'keine Angabe'
'10' '10 und mehr'.
value labels hc142cx
'-1' 'keine Angabe'
'15' '15 und mehr'.
value labels hc143a
'-1' 'keine Angabe'
'1' 'ja'
'2' 'nein'.
value labels hc143bx
'-1' 'keine Angabe'
'12' '12 und mehr'.
value labels hc143cx
'-1' 'keine Angabe'
'20' '20 und mehr'.
value labels hc144a
'-1' 'keine Angabe'
'1' 'ja'
'2' 'nein'.
value labels hc144bx
'-1' 'keine Angabe'
'3' '3 und mehr'.
value labels hc144cx
'-1' 'keine Angabe'.
value labels hc145a
'-1' 'keine Angabe'
'1' 'ja'
'2' 'nein'.
value labels hc145bx
'-1' 'keine Angabe'
'5' '5 und mehr'.
value labels hc145cx
'-1' 'keine Angabe'
'20' '20 und mehr'.
value labels hc146a
'-1' 'keine Angabe'
'1' 'ja'
'2' 'nein'.
value labels hc146bx
'-1' 'keine Angabe'
'5' '5 und mehr'.
value labels hc146cx
'-1' 'keine Angabe'.
value labels hc147a
'-1' 'keine Angabe'
'1' 'ja'
'2' 'nein'.
value labels hc147bx
'-1' 'keine Angabe'
'5' '5 und mehr'.
value labels hc147cx
'-1' 'keine Angabe'
'30' '30 und mehr'.
value labels hc148a
'-1' 'keine Angabe'
'1' 'ja'
'2' 'nein'.
value labels hc148bx
'-1' 'keine Angabe'.
value labels hc148cx
'-1' 'keine Angabe'.
value labels hc149a
'-1' 'keine Angabe'
'1' 'ja'
'2' 'nein'.
value labels hc149bx
'-1' 'keine Angabe'
'4' '4 und mehr'.
value labels hc149cx
'-1' 'keine Angabe'.
value labels hc1410a
'-1' 'keine Angabe'
'1' 'ja'
'2' 'nein'.
value labels hc1410bx
'-1' 'keine Angabe'
'2' '2 und mehr'.
value labels hc1410c
'-1' 'keine Angabe'.
value labels hc1411a
'-1' 'keine Angabe'
'1' 'ja'
'2' 'nein'.
value labels hc1411b
'-1' 'keine Angabe'.
value labels hc1411cx
'-1' 'keine Angabe'
'40' '40 und mehr'.
value labels hd15x
'1' 'unter 1100 Euro'
'2' '1100 bis unter 1700 Euro'
'3' '1700 bis unter 2300 Euro'
'4' '2300 bis unter 3600 Euro'
'5' '3600 Euro und mehr'.
value labels he16
'1' 'ja'
'2' 'nein'.
value labels hhtyp
'1' 'Einpersonenhaushalt'
'2' 'Paare ohne Kinder'
'3' 'Alleinerziehende mit mindestens einem Kind unter 18 Jahren und ledigen Kindern unter 27 Jahren'
'4' 'Paare mit mindestens einem Kind unter 18 Jahren und ledigen Kindern unter 27 Jahren'
'5' 'Sonstige Haushalte'.
value labels anz_kind27
'-2' 'trifft nicht zu'
'1' '1 Kind'
'2' '2 Kinder'
'3' '3 und mehr Kinder'.
value labels juki
'-2' 'trifft nicht zu'.
value labels juki_gr
'-2' 'trifft nicht zu'
'1' '0 bis unter 3 Jahren'
'2' '3 bis unter 6 Jahren'
'3' '6 bis unter 10 Jahren'
'4' '10 bis unter 15 Jahren'
'5' '15 bis unter 18 Jahren'.
value labels ha1_gr
'1' '1 Person'
'2' '2 Personen'
'3' '3 Personen'
'4' '4 Personen'
'5' '5 oder mehr Personen'.
value labels soz_heb
'1' 'Selbstständiger'
'2' 'Beamter'
'3' 'Angestellter'
'4' 'Arbeiter'
'5' 'Rentner, Pensionär'
'6' 'Sonstige Nichterwerbstätige'.
value labels anz_erw
'1' 'keine Erwerbstätige'
'2' '1 Vollzeit'
'3' '1 Teilzeit'
'4' '2 Vollzeit'
'5' '1 Vollzeit, 1 Teilzeit'
'6' '3 Vollzeit'
'7' 'Sonstige'.
value labels pers_part_heb
'-2' 'trifft nicht zu'.
value labels anz_erwpart
'-2' 'trifft nicht zu'
'1' 'ein Partner erwerbstätig'
'2' 'beide Partner erwerbstätig'
'3' 'kein Partner erwerbstätig'.
value labels gebiet
'1' 'West (Alte Bundesländer)'
'2' 'Ost (Neue Bundesländer einschließlich Berlin)'.
.


*		  	(II) ZVE 13 HH		
*			  (iv) Speichern als SPSS-Datei

SAVE outfile=!Pfad1+!Dateiname1.



*			  (III) ZVE 13 pers		
*					 (i) Einlesen CSV-Datei

GET DATA
 /TYPE=TXT
 /FILE=!Pfad2+!CSVdatei2
 /DELCASE=LINE
 /DELIMITERS=";"
 /ARRANGEMENT=DELIMITED
 /FIRSTCASE=2
 /IMPORTCASE=ALL
 /VARIABLES=
 id_hhx F4.0
 id_persx F5.0
 persx F1.0
 berichtsjahr F4.0
 alterx F2.0
 ha3 F1.0
 pa2x F2.0
 ha6x F1.0
 ha71x F1.0
 ha8x F2.0
 he181 F2.0
 he18_kibetrx F2.0
 he187x F2.0
 he19x F2.0
 he201 F2.0
 he202x F2.0
 he211 F2.0
 he212x F2.0
 he22x F2.0
 he231 F2.0
 he232 F2.0
 he233 F2.0
 he234 F2.0
 he235 F2.0
 he236 F2.0
 he237 F2.0
 he241x F2.0
 he245x F2.0
 he246x F2.0
 he247x F2.0
 he248 F2.0
 he249x F2.0
 pfb_ausgef F2.0
 pb3 F2.0
 pb4 F2.0
 pc5x F2.0
 pc6 F2.0
 pc7 F2.0
 pc8x F2.0
 pc9x F2.0
 pc10 F2.0
 pc11x F2.0
 pc121 F2.0
 pc122x F2.0
 pc13x F2.0
 pc14 F2.0
 pc15 F2.0
 pc16_fruehsonstx F2.0
 pc16_spaetnachtx F2.0
 pc17 F2.0
 pc18 F2.0
 pd191 F2.0
 pd192x F2.0
 pd20 F2.0
 pd21x F2.0
 pd22x F2.0
 pe23x F2.0
 pf24 F2.0
 pf25x F2.0
 pf26x F2.0
 pf271 F2.0
 pf272x F2.0
 pf28x F2.0
 pf291a F2.0
 pf291bx F2.0
 pf292a F2.0
 pf292bx F2.0
 pf293a F2.0
 pf293bx F2.0
 pf294a F2.0
 pf294bx F2.0
 pg321a F2.0
 pg321b F2.0
 pg322a F2.0
 pg322b F2.0
 pg323a F2.0
 pg323b F2.0
 pg324a F2.0
 pg324b F2.0
 pg325a F2.0
 pg325b F2.0
 pg326a F2.0
 pg326b F2.0
 pg331a F2.0
 pg331b F2.0
 pg332a F2.0
 pg332b F2.0
 pg333a F2.0
 pg333b F2.0
 pg334a F2.0
 pg334b F2.0
 pg335a F2.0
 pg335b F2.0
 pg336a F2.0
 pg336b F2.0
 pg337a F2.0
 pg337b F2.0
 pg338a F2.0
 pg338b F2.0
 pg339a F2.0
 pg339b F2.0
 pg3310a F2.0
 pg3310b F2.0
 ph341 F2.0
 ph342 F2.0
 ph343 F2.0
 ph344 F2.0
 ph345 F2.0
 ph346 F2.0
 ph347 F2.0
 ph348 F2.0
 ph349 F2.0
 ph3410 F2.0
 ph3411 F2.0
 ph3412 F2.0
 ph3413 F2.0
 ph3414 F2.0
 ph35 F2.0
 pi361a F2.0
 pi361b F2.0
 pi362a F2.0
 pi362b F2.0
 pi363a F2.0
 pi363b F2.0
 pi364a F2.0
 pi364b F2.0
 pi365a F2.0
 pi365b F2.0
 pi366a F2.0
 pi366b F2.0
 pi367a F2.0
 pi367b F2.0
 pi368a F2.0
 pi368b F2.0
 pi369a F2.0
 pi369b F2.0
 pi3610a F2.0
 pi3610b F2.0
 pi3611a F2.0
 pi3611b F2.0
 pk381 F2.0
 pk382 F2.0
 pk383 F2.0
 pk384 F2.0
 pk385 F2.0
 pk386 F2.0
 pk387 F2.0
 pk388 F2.0
 pk389 F2.0
 pk3810 F2.0
 pk3811 F2.0
 pk3812 F2.0
 pk3813 F2.0
 pk391 F2.0
 pk392 F2.0
 pk393 F2.0
 pk394 F2.0
 pk395 F2.0
 pk396 F2.0
 pk401x F2.0
 pk402ax F3.0
 pk402bx F3.0
 pk402cx F3.0
 pk402dx F3.0
 pk402ex F3.0
 alter_gr1 F1.0
 alter_gr2 F2.0
 soz F2.0
 erw_typ F2.0
 isced F2.0
 bildung_typ F2.0
 pf31_typ F2.0
 erw_part F2.0
 hrfp80 F7.0
 hrfk80 F7.0.
CACHE.
EXECUTE.

*			  (III) ZVE 13 pers		
*			  (ii)	Zuweisen der Variablenlabels.
VARIABLE LABELS
alterx	 'Alter'
ha3	 'Geschlecht'
pa2x	 'Familienstand'
ha6x	 'Stellung im Haushalt'
ha71x	 'Erste Staatsangehörigkeit'
ha8x	 'Geburtsland'
he181	 'Kind wird ausschließlich durch Eltern betreut'
he18_kibetrx	 'Kinderbetreuung (Betreute Zeit insgesamt durch Tagesmutter/Tagesvater, Krippe, Kindertagesstätte, vorschulische Einrichtungen, Hort)'
he187x	 'Betreute Zeit durch Verwandte, Freunde, Nachbarn'
he19x	 'Betreuung Tage pro Woche'
he201	 'Kind geht/geht nicht zur Schule'
he202x	 'Unterrichtsstunden pro Woche (HFB)'
he211	 'Teilnahme an AGs (HFB)'
he212x	 'AG-Stunden pro Woche (HFB)'
he22x	 'Zeitstunden insgesamt in der Schule pro Woche (HFB)'
he231	 'Mittagessen in der Betreuungseinrichtung/Schule'
he232	 'Hausaufgabenbetreuung in der Betreuungseinrichtung/Schule'
he233	 'Sprachförderung in Deutsch in der Betreuungseinrichtung/Schule'
he234	 'Nachhilfe, Förderkurse in der Betreuungseinrichtung/Schule'
he235	 'Musikalische Früherziehung in der Betreuungseinrichtung/Schule'
he236	 'Kind nimmt keine Angebote wahr in der Betreuungseinrichtung/Schule'
he237	 'Sonstige Kurse in der Betreuungseinrichtung/Schule'
he241x	 'Stunden pro Woche: Sport und Bewegung außerhalb der Betreuungseinrichtung/Schule'
he245x	 'Stunden pro Woche: Singen, Musikinstrument spielen außerhalb der Betreuungseinrichtung/Schule'
he246x	 'Stunden pro Woche: Malen, Basteln außerhalb der Betreuungseinrichtung/Schule'
he247x	 'Stunden pro Woche: Tanzen, Theater spielen außerhalb der Betreuungseinrichtung/Schule'
he248	 'Kind nimmt keine Angebote wahr außerhalb der Betreuungseinrichtung/Schule'
he249x	 'Stunden pro Woche: Sonstiges Angebot außerhalb der Betreuungseinrichtung oder Schule'
pfb_ausgef	 'Ausgefüllter Personenfragebogen'
pb3	 'Lebenssituation'
pb4	 'In der letzten Woche mindestens 1 Stunde gegen Bezahlung gearbeitet'
pc5x	 'Berufliche Stellung in der Haupterwerbstätigkeit'
pc6	 'Art des Beschäftigungsverhältnisses in der Haupterwerbstätigkeit'
pc7	 'Vollzeit/Teilzeit in der Haupterwerbstätigkeit'
pc8x	 'Wochenstunden in der Haupterwerbstätigkeit'
pc9x	 'Wunscharbeitszeit in der Haupterwerbstätigkeit'
pc10	 'Geringfügige Beschäftigung in der Haupterwerbstätigkeit'
pc11x	 'Wirtschaftszweig in der Haupterwerbstätigkeit'
pc121	 'Ort der Arbeitsstätte in der Haupterwerbstätigkeit'
pc122x	 'Kilometer zur Arbeitsstätte in der Haupterwerbstätigkeit'
pc13x	 'Arbeitsweg in Minuten in der Haupterwerbstätigkeit'
pc14	 'Arbeitszeitgestaltung in der Haupterwerbstätigkeit'
pc15	 'Schichtarbeit in der Haupterwerbstätigkeit'
pc16_fruehsonstx	 'Früh- /sonstige Schicht in der Haupterwerbstätigkeit'
pc16_spaetnachtx	 'Spät-/Nachtschicht in der Haupterwerbstätigkeit'
pc17	 'Arbeit von zu Hause aus in der Haupterwerbstätigkeit'
pc18	 'Wochenendarbeit in der Haupterwerbstätigkeit'
pd191	 'Nebenerwerbstätig'
pd192x	 'Anzahl der Nebenerwerbstätigkeiten'
pd20	 'Monate pro Jahr, an denen Nebenerwerbstätigkeit ausgeübt wird'
pd21x	 'Tage pro Monat, an denen Nebenerwerbstätigkeit ausgeübt wird'
pd22x	 'Stunden pro Tag, an denen Nebenerwerbstätigkeit ausgeübt wird'
pe23x	 'Monatliches Nettoeinkommen aus Haupterwerbstätigkeit und Nebenerwerbstätigkeit(en)'
pf24	 'Schulbesuch'
pf25x	 'Art der Schule'
pf26x	 'Unterrichtsstunden pro Woche (PFB)'
pf271	 'Teilnahme an AGs (PFB)'
pf272x	 'AG-Stunden pro Woche (PFB)'
pf28x	 'Zeitstunden insgesamt in der Schule pro Woche (PFB)'
pf291a	 'Sport außerhalb der Schule'
pf291bx	 'Stunden pro Woche: Sport außerhalb der Schule'
pf292a	 'Sprachförderung in Deutsch außerhalb der Schule'
pf292bx	 'Stunden pro Woche: Sprachförderung in Deutsch außerhalb der Schule'
pf293a	 'Sprachförderung andere Sprache außerhalb der Schule'
pf293bx	 'Stunden pro Woche: Sprachförderung andere Sprache außerhalb der Schule'
pf294a	 'Nachhilfe, Förderkurse außerhalb der Schule'
pf294bx	 'Stunden pro Woche: Nachhilfe, Förderkurse außerhalb der Schule'
pg321a	 'Kino in den letzten 12 Monaten'
pg321b	 'Häufigkeit Kino in den letzten 12 Monaten'
pg322a	 'Theater, Tanz in den letzten 12 Monaten'
pg322b	 'Häufigkeit Theater, Tanz in den letzten 12 Monaten'
pg323a	 'Konzert, Oper, Musical in den letzten 12 Monaten'
pg323b	 'Häufigkeit Konzert, Oper, Musical in den letzten 12 Monaten'
pg324a	 'Kunstausstellung, Museum in den letzten 12 Monaten'
pg324b	 'Häufigkeit Kunstausstellung, Museum in den letzten 12 Monaten'
pg325a	 'Bibliothek, Bücherei in den letzten 12 Monaten'
pg325b	 'Häufigkeit Bibliothek, Bücherei in den letzten 12 Monaten'
pg326a	 'Sonstige kulturelle Angebote in den letzten 12 Monaten'
pg326b	 'Häufigkeit sonstige kulturelle Angebote in den letzten 12 Monaten'
pg331a	 'Singen'
pg331b	 'Stunden pro Woche: Singen'
pg332a	 'Musikinstrument spielen'
pg332b	 'Stunden pro Woche: Musikinstrument spielen'
pg333a	 'Malen, Zeichnen, Drucken'
pg333b	 'Stunden pro Woche: Malen, Zeichnen, Drucken'
pg334a	 'Werken, Nähen, Töpfern, Goldschmieden, Basteln'
pg334b	 'Stunden pro Woche: Werken, Nähen, Töpfern, Goldschmieden, Basteln'
pg335a	 'Tanzen'
pg335b	 'Stunden pro Woche: Tanzen'
pg336a	 'Theater spielen'
pg336b	 'Stunden pro Woche: Theater spielen'
pg337a	 'Schreiben, Dichten'
pg337b	 'Stunden pro Woche: Schreiben, Dichten'
pg338a	 'Filmen, Fotografieren'
pg338b	 'Stunden pro Woche: Filmen, Fotografieren'
pg339a	 'Literaturkreis'
pg339b	 'Stunden pro Woche: Literaturkreis'
pg3310a	 'Sonstige kulturelle Aktivitäten'
pg3310b	 'Stunden pro Woche: sonstige kulturelle Aktivitäten'
ph341	 'Sport und Bewegung in den letzten 12 Monaten'
ph342	 'Kultur und Musik in den letzten 12 Monaten'
ph343	 'Schule und Kindergarten in den letzten 12 Monaten'
ph344	 'Kirchliche oder religiöse Gesellschaft in den letzten 12 Monaten'
ph345	 'Sozialer Bereich in den letzten 12 Monaten'
ph346	 'Politik und politische Interessenvertretung in den letzten 12 Monaten'
ph347	 'Bürgerschaftliche Aktivität an Ihrem Wohnortin den letzten 12 Monaten'
ph348	 'Berufliche Interessenvertretung außerhalb des Betriebes in den letzten 12 Monaten'
ph349	 'Umwelt, Naturschutz oder Tierschutz in den letzten 12 Monaten'
ph3410	 'Außerschulische Jugendarbeit, Bildungsarbeit für Erwachsene in den letzten 12 Monaten'
ph3411	 'Unfall- oder Rettungsdienst oder freiwillige Feuerwehr in den letzten 12 Monaten'
ph3412	 'Gesundheit in den letzten 12 Monaten'
ph3413	 'Justiz und Innere Sicherheit in den letzten 12 Monaten'
ph3414	 'Freizeit und Geselligkeit in den letzten 12 Monaten'
ph35	 'Zeitaufwand freiwilliges Engagement'
pi361a	 'Kinderbetreuung'
pi361b	 'Stunden pro Woche: Kinderbetreuung'
pi362a	 'Zubereitung von Mahlzeiten'
pi362b	 'Stunden pro Woche: Zubereitung von Mahlzeiten'
pi363a	 'Putzen, Aufräumen, Waschen und Bügeln, Straße fegen'
pi363b	 'Stunden pro Woche: Putzen, Aufräumen, Waschen und Bügeln, Straße fegen'
pi364a	 'Nach dem Rechten sehen'
pi364b	 'Stunden pro Woche: nach dem Rechten sehen'
pi365a	 'Gartenarbeit'
pi365b	 'Stunden pro Woche: Gartenarbeit'
pi366a	 'Einkaufen und Besorgungen'
pi366b	 'Stunden pro Woche: Einkaufen und Besorgungen'
pi367a	 'Haustierpflege'
pi367b	 'Stunden pro Woche: Haustierpflege'
pi368a	 'Reparatur und Wartung von Fahrzeugen'
pi368b	 'Stunden pro Woche: Reparatur und Wartung von Fahrzeugen'
pi369a	 'Reparieren und Bauen'
pi369b	 'Stunden pro Woche: Reparieren und Bauen'
pi3610a	 'Versicherungs-, Behördenangelegenheiten'
pi3610b	 'Stunden pro Woche: Versicherungs-, Behördenangelegenheiten'
pi3611a	 'Sonstige Unterstützung'
pi3611b	 'Stunden pro Woche: sonstige Unterstützung'
pk381	 'Zeitverwendung in den letzten 4 Wochen für Kinder'
pk382	 'Zeitverwendung in den letzten 4 Wochen für (Ehe-)Partner/-in'
pk383	 'Zeitverwendung in den letzten 4 Wochen für sonstige Familienangehörige'
pk384	 'Zeitverwendung in den letzten 4 Wochen für Freunde, Bekannte'
pk385	 'Zeitverwendung in den letzten 4 Wochen für Hausarbeit'
pk386	 'Zeitverwendung in den letzten 4 Wochen für Erwerbsarbeit'
pk387	 'Zeitverwendung in den letzten 4 Wochen für Ausbildung'
pk388	 'Zeitverwendung in den letzten 4 Wochen für Weiterbildung'
pk389	 'Zeitverwendung in den letzten 4 Wochen für ehrenamtliche/freiwillige Tätigkeit'
pk3810	 'Zeitverwendung in den letzten 4 Wochen für Ausruhen'
pk3811	 'Zeitverwendung in den letzten 4 Wochen für persönliche Interessen (Sport, Kultur)'
pk3812	 'Zeitverwendung in den letzten 4 Wochen für Arztbesuche'
pk3813	 'Zeitverwendung in den letzten 4 Wochen für Besorgungen'
pk391	 'Angewiesen, den Tag zu planen'
pk392	 'Häufig unter Zeitdruck'
pk393	 'Regelmäßig ausschlafen'
pk394	 'Mehr Zeit für sich'
pk395	 'Mehr Zeit für Familie'
pk396	 'Mehr Zeit für Freunde, Bekannte'
pk401x	 'Wunsch nach mehr Zeit, Anzahl der Aktivitäten'
pk402ax	 'Aktivität 1, für die mehr Zeit gewünscht wird'
pk402bx 'Aktivität 2, für die mehr Zeit gewünscht wird'
pk402cx	 'Aktivität 3, für die mehr Zeit gewünscht wird'
pk402dx	 'Aktivität 4, für die mehr Zeit gewünscht wird'
pk402ex	 'Aktivität 5, für die mehr Zeit gewünscht wird'
alter_gr1	 '6 Altersgruppen'
alter_gr2	 '6 Altersgruppen, Personen ab 10 Jahren'
soz	 'Soziale Stellung'
erw_typ	 'Erwerbstätigkeit'
isced	 'ISCED-97-Level'
bildung_typ	 'Bildung typisiert'
pf31_typ	 'Höchster beruflicher Ausbildungs- oder Hochschulabschluss typisiert'
erw_part	 'Erwerbstätigkeit des Partners des Haupteinkommensbeziehers/Lebenspartners'
id_hhx 'Haushalts-ID'
id_persx 'Personen-ID'
persx 'Personennummer'
berichtsjahr 'Berichtsjahr'
hrfp80 'Hochrechnungsfaktor * 100 für Personen ab 10 Jahren'
hrfk80 'Hochrechnungsfaktor * 100 für Kinder unter 10 Jahren' .



*			  (III) ZVE 13 pers		
*	   (iii)	Zuweisen der Wertelabels

Value labels 	alterx				
'0' '0 bis unter 3 Jahren'
'3' '3 bis unter 6 Jahren'
'6' '6 Jahre'
'7' '7 bis unter 10 Jahren'
'75' '75 Jahre und älter'.
Value labels 	ha3				
	'1' 'männlich'
	'2' 'weiblich'.
Value labels 	pa2x				
	'-1' 'keine Angabe'
	'1' 'ledig'
	'2' 'Verheiratet und Ehepartner lebt im Haushalt'
	'3' 'Geschieden/Verheiratet und dauernd getrennt lebend'
	'4' 'Verwitwet'.
Value labels 	ha6x				
	'1' 'Haupteinkommensbezieher'
	'2' 'Ehe-, Lebenspartner/-in'
	'3' 'Kind'
	'4' 'Bruder/Schwester'
	'5' 'Enkelkind'
	'6' 'Vater/Mutter'
	'7' 'Großvater/Großmutter'
	'8' 'Anders verwandt/verschwägert'
	'9' 'Nicht verwandt/verschwägert'.
Value labels 	ha71x				
	'1' 'Deutsche Staatsangehörigkeit'
	'2' 'Sonstige Staatsangehörigkeit, staatenlos'.
Value labels 	ha8x				
	'-1' 'keine Angabe'
	'1' 'Deutschland'
	'2' 'Sonstiges Land'.
Value labels 	he181				
	'-2' 'trifft nicht zu'
	'1' 'ja'
	'2' 'nein'.
Value labels 	he18_kibetrx				
	'-2' 'trifft nicht zu'
	'0' 'keine Betreuung durch Tagesmutter/Tagesvater, Krippe, Kindertagesstätte, vorschulische Einrichtungen, Hort'
	'10' '1-10 Stunden'
	'15' '11-15 Stunden'
	'20' '16-20 Stunden'
	'25' '21-25 Stunden'
	'30' '26-30 Stunden'
	'40' '31-40 Stunden'
	'41' '41 Stunden und mehr'.
Value labels 	he187x				
	'-2' 'trifft nicht zu'
	'21' '21 Stunden und mehr'.
Value labels 	he19x				
	'-1' 'keine Angabe'
	'-2' 'trifft nicht zu'
	'5' '5 Tage und mehr'.
Value labels 	he201				
	'-2' 'trifft nicht zu'
	'1' 'Kind geht nicht zur Schule'
	'2' 'Kind geht zur Schule'.
Value labels 	he202x				
	'-2' 'trifft nicht zu'
	'20' '15-20 Stunden'
	'40' '31-40 Stunden'.
Value labels 	he211				
	'-1' 'keine Angabe'
	'-2' 'trifft nicht zu'
	'1' 'Keine Teilnahme an AGs'
	'2' 'Teilnahme an AGs'.
Value labels 	he212x				
	'-1' 'keine Angabe'
	'-2' 'trifft nicht zu'
	'5' '5 Stunden und mehr'.
Value labels 	he22x				
	'-2' 'trifft nicht zu'
	'50' '41-50 Stunden'.
Value labels 	he231				
	'-1' 'keine Angabe'
	'-2' 'trifft nicht zu'
	'0' 'nein'
	'1' 'ja'.
Value labels 	he232				
	'-1' 'keine Angabe'
	'-2' 'trifft nicht zu'
	'0' 'nein'
	'1' 'ja'.
Value labels 	he233					
	'-1' 'keine Angabe'
	'-2' 'trifft nicht zu'
	'0' 'nein'
	'1' 'ja'.
Value labels 	he234				
	'-1' 'keine Angabe'
	'-2' 'trifft nicht zu'
	'0' 'nein'
	'1' 'ja'.
Value labels 	he235				
	'-1' 'keine Angabe'
	'-2' 'trifft nicht zu'
	'0' 'nein'
	'1' 'ja'.
Value labels 	he236				
	'-1' 'keine Angabe'
	'-2' 'trifft nicht zu'
	'1' 'ja'
	'2' 'nein'.
Value labels 	he237				
	'-1' 'keine Angabe'
	'-2' 'trifft nicht zu'
	'0' 'nein'
	'1' 'ja'.
Value labels 	he241x				
	'-1' 'keine Angabe'
	'-2' 'trifft nicht zu'
	'6' '6 Stunden und mehr'.
Value labels 	he245x				
	'-1' 'keine Angabe'
	'-2' 'trifft nicht zu'
	'3' '3 Stunden und mehr'.
Value labels 	he246x				
	'-1' 'keine Angabe'
	'-2' 'trifft nicht zu'
	'3' '3 Stunden und mehr'.
Value labels 	he247x				
	'-1' 'keine Angabe'
	'-2' 'trifft nicht zu'
	'2' '2 Stunden und mehr'.
Value labels 	he248				
	'-1' 'keine Angabe'
	'-2' 'trifft nicht zu'
	'1' 'ja'
	'2' 'nein'.
Value labels 	he249x				
	'-1' 'keine Angabe'
	'-2' 'trifft nicht zu'.
Value labels 	pfb_ausgef				
	'-2' 'trifft nicht zu'
	'1' 'ja'
	'2' 'nein'.
Value labels 	pb3				
	'-1' 'keine Angabe'
	'-2' 'trifft nicht zu'
	'1' 'Selbstständiger, Freiberufler, Landwirt, mithelfender Familienangehöriger'
	'2' 'Angestellter, Arbeiter, Beamter, Richter, Zeit-/Berufssoldat, Freiwillig soziales/ökologisches/kulturelles Jahr, freiwilliger Wehrdienst, Bundesfreiwilligendienst'
	'3' 'Auszubildender (auch Praktikant,Volontär)'
	'4' 'In Altersteilzeit (Arbeits- und Freistellungsphase)'
	'5' 'In Elternzeit (mit ungekündigtem Arbeitsvertrag)'
	'6' 'Schüler, Student'
	'7' 'Arbeitslos'
	'8' 'Im Ruhestand oder Vorruhestand'
	'9' 'Dauerhaft erwerbsunfähig'
	'10' 'Hausfrau/Hausmann'
	'11' 'Aus anderen Gründen nicht erwerbstätig'.
Value labels 	pb4				
	'-1' 'keine Angabe'
	'-2' 'trifft nicht zu'
	'1' 'ja'
	'2' 'nein'.
Value labels 	pc5x				
	'-1' 'keine Angabe'
	'-2' 'trifft nicht zu'
	'1' 'Angestellter, freiwilliger Wehrdienst, Freiwilligendienst, Freiwilliges soziales/ökologisches/kulturelles Jahr'
	'2' 'Arbeiter'
	'3' 'Beamter'
	'4' 'Selbstständiger, Landwirt, Mithelf. Familienangehöriger'.
Value labels 	pc6				
	'-1' 'keine Angabe'
	'-2' 'trifft nicht zu'
	'1' 'unbefristet'
	'2' 'befristet'.
Value labels 	pc7				
	'-1' 'keine Angabe'
	'-2' 'trifft nicht zu'
	'1' 'Vollzeit'
	'2' 'Teilzeit'.
Value labels 	pc8x				
	'-1' 'keine Angabe'
	'-2' 'trifft nicht zu'
 '3' '0 bis 3 Stunden'
	'60' '60 Stunden und mehr'.
Value labels 	pc9x				
	'-1' 'keine Angabe'
	'-2' 'trifft nicht zu'
 '3' '0 bis 3 Stunden'
	'60' '60 Stunden und mehr'.
Value labels 	pc10				
	'-1' 'keine Angabe'
	'-2' 'trifft nicht zu'
	'1' 'ja'
	'2' 'nein'.
Value labels 	pc11x				
	'-1' 'keine Angabe'
	'-2' 'trifft nicht zu'
	'1' 'Land- und Forstwirtschaft, Fischerei'
	'2' 'Bergbau und Gewinnung von Erdöl, Erdgas, Steinen'
	'3' 'Verarbeitendes Gewerbe/Herstellung von Waren'
	'4' 'Energieversorgung,Wasserversorgung, Abwasser, Abfallentsorgung, Bergbau und Gewinnung von Erdöl, Erdgas, Steinen'
	'6' 'Baugewerbe, Hoch- und Tiefbau'
	'7' 'Groß- und Einzelhandel; Reparatur von Kraftfahrzeugen'
	'8' 'Personen- und Güterverkehr, Lagerei'
	'9' 'Gastgewerbe/Beherbergung und Gastronomie'
	'10' 'Information und Kommunikation'
	'11' 'Banken/Finanz- und Versicherungsdienstleister'
	'12' 'Grundstücks- und Wohnungswesen'
	'13' 'Freiberufliche, wissenschaftl., technische Dienstleistungen'
	'14' 'Sonstige wirtschaftliche Dienstleistungen'
	'15' 'Öffentliche Verwaltung, Gerichte, Verteidigung, Sicherheit'
	'16' 'Erziehung und Unterricht'
	'17' 'Gesundheits- und Sozialwesen'
	'18' 'Sonstige überwiegend personenbezogene Dienstleistungen'
	'19' 'Kunst, Unterhaltung, Sport und Erholung'
	'20' 'Gewerkschaft, Verband, Partei, kirchliche Vereinigung'
	'22' 'Privater Haushalt mit Beschäftigten'.
Value labels 	pc121				
	'-1' 'keine Angabe'
	'-2' 'trifft nicht zu'
	'1' 'Kilometerangabe'
	'2' 'Ständig wechselnde Arbeitsstätte'
	'3' 'Arbeitsstätte im gleichen Gebäude'.
Value labels 	pc122x				
	'-1' 'keine Angabe'
	'-2' 'trifft nicht zu'
 '1' 'bis 1 km'
	'90' '90 km und mehr'.
Value labels 	pc13x				
	'-1' 'keine Angabe'
	'-2' 'trifft nicht zu'
	'100' '100 min und mehr'.
Value labels 	pc14				
	'-1' 'keine Angabe'
	'-2' 'trifft nicht zu'
	'1' 'Feststehende Anfangs- und Schlusszeiten'
	'2' 'Gleitzeit'
	'3' 'Freie Arbeitszeitgestaltung'.
Value labels 	pc15				
	'-1' 'keine Angabe'
	'-2' 'trifft nicht zu'
	'1' 'ja'
	'2' 'nein'.
Value labels 	pc16_fruehsonstx				
	'-1' 'keine Angabe'
	'-2' 'trifft nicht zu'
	'0' 'nein'
	'1' 'ja'.
Value labels 	pc16_spaetnachtx				
	'-1' 'keine Angabe'
	'-2' 'trifft nicht zu'
	'0' 'nein'
	'1' 'ja'.
Value labels 	pc17				
	'-1' 'keine Angabe'
	'-2' 'trifft nicht zu'
	'1' 'ja'
	'2' 'nein'.
Value labels 	pc18				
	'-1' 'keine Angabe'
	'-2' 'trifft nicht zu'
	'1' 'Jedes Wochenende'
	'2' 'Jedes zweite Wochenende'
	'3' 'Jedes dritte oder vierte Wochenende'
	'4' 'Seltener'
	'5' 'Nie'.
Value labels 	pd191				
	'-1' 'keine Angabe'
	'-2' 'trifft nicht zu'
	'1' 'ja'
	'2' 'nein'.
Value labels 	pd192x				
	'-1' 'keine Angabe'
	'-2' 'trifft nicht zu'
	'2' '2 oder mehr'.
Value labels 	pd20				
	'-1' 'keine Angabe'
	'-2' 'trifft nicht zu'.
Value labels 	pd21x				
	'-1' 'keine Angabe'
	'-2' 'trifft nicht zu'.
Value labels 	pd22x				
	'-1' 'keine Angabe'
	'-2' 'trifft nicht zu'.
Value labels 	pe23x				
 '-1' 'keine Angabe'
 '-2' 'trifft nicht zu'
 '1' 'Unter 900 Euro'
 '2' '900 bis unter 1300 Euro'
 '3' '1300 bis unter 1700 Euro'
 '4' '1700 bis unter 2300 Euro'
 '5' '2300 Euro oder mehr'.
Value labels 	pf24				
	'-1' 'keine Angabe'
	'-2' 'trifft nicht zu'
	'1' 'ja'
	'2' 'nein'.
Value labels 	pf25x				
	'-1' 'keine Angabe'
	'-2' 'trifft nicht zu'
	'1' 'allgemeinbildende Schule'
	'2' 'berufliche Schule'.
Value labels 	pf26x				
	'-1' 'keine Angabe'
	'-2' 'trifft nicht zu'
	'7' 'unter 8 Stunden'
	'41' '41 bis 45 Stunden'.
Value labels 	pf271				
	'-1' 'keine Angabe'
	'-2' 'trifft nicht zu'
	'1' 'Teilnahme an AGs'
	'2' 'Keine Teilnahme an AGs'.
Value labels 	pf272x				
	'-1' 'keine Angabe'
	'-2' 'trifft nicht zu'
	'5' '5 Stunden und mehr'.
Value labels 	pf28x				
	'-1' 'keine Angabe'
	'-2' 'trifft nicht zu'
	'7' 'unter 8 Stunden'
	'45' '45 Stunden und mehr'.
Value labels 	pf291a				
	'-1' 'keine Angabe'
	'-2' 'trifft nicht zu'
	'1' 'ja'
	'2' 'nein'.
Value labels 	pf291bx				
	'-1' 'keine Angabe'
	'-2' 'trifft nicht zu'
 '11' '11 Stunden und mehr'.
Value labels 	pf292a				
	'-1' 'keine Angabe'
	'-2' 'trifft nicht zu'
	'1' 'ja'
	'2' 'nein'.
Value labels 	pf292bx				
	'-1' 'keine Angabe'
	'-2' 'trifft nicht zu'
	'2' '2 Stunden und mehr'.
Value labels 	pf293a				
	'-1' 'keine Angabe'
	'-2' 'trifft nicht zu'
	'1' 'ja'
	'2' 'nein'.
Value labels 	pf293bx				
	'-1' 'keine Angabe'
	'-2' 'trifft nicht zu'
	'2' '2 Stunden und mehr'.
Value labels 	pf294a				
	'-1' 'keine Angabe'
	'-2' 'trifft nicht zu'
	'1' 'ja'
	'2' 'nein'.
Value labels 	pf294bx				
	'-1' 'keine Angabe'
	'-2' 'trifft nicht zu'
	'4' '4 Stunden und mehr'.
Value labels 	pg321a				
	'-1' 'keine Angabe'
	'-2' 'trifft nicht zu'
	'1' 'ja'
	'2' 'nein'.
Value labels 	pg321b				
	'-1' 'keine Angabe'
	'-2' 'trifft nicht zu'.
Value labels 	pg322a				
	'-1' 'keine Angabe'
	'-2' 'trifft nicht zu'
	'1' 'ja'
	'2' 'nein'.
Value labels 	pg322b				
	'-1' 'keine Angabe'
	'-2' 'trifft nicht zu'.
Value labels 	pg323a				
	'-1' 'keine Angabe'
	'-2' 'trifft nicht zu'
	'1' 'ja'
	'2' 'nein'.
Value labels 	pg323b				
	'-1' 'keine Angabe'
	'-2' 'trifft nicht zu'.
Value labels 	pg324a				
	'-1' 'keine Angabe'
	'-2' 'trifft nicht zu'
	'1' 'ja'
	'2' 'nein'.
Value labels 	pg324b				
	'-1' 'keine Angabe'
	'-2' 'trifft nicht zu'.
Value labels 	pg325a				
	'-1' 'keine Angabe'
	'-2' 'trifft nicht zu'
	'1' 'ja'
	'2' 'nein'.
Value labels 	pg325b				
	'-1' 'keine Angabe'
	'-2' 'trifft nicht zu'.
Value labels 	pg326a				
	'-1' 'keine Angabe'
	'-2' 'trifft nicht zu'
	'1' 'ja'
	'2' 'nein'.
Value labels 	pg326b				
	'-1' 'keine Angabe'
	'-2' 'trifft nicht zu'.
Value labels 	pg331a				
	'-1' 'keine Angabe'
	'-2' 'trifft nicht zu'
	'1' 'ja'
	'2' 'nein'.
Value labels 	pg331b				
	'-1' 'keine Angabe'
	'-2' 'trifft nicht zu'.
Value labels 	pg332a				
	'-1' 'keine Angabe'
	'-2' 'trifft nicht zu'
	'1' 'ja'
	'2' 'nein'.
Value labels 	pg332b				
	'-1' 'keine Angabe'
	'-2' 'trifft nicht zu'.
Value labels 	pg333a				
	'-1' 'keine Angabe'
	'-2' 'trifft nicht zu'
	'1' 'ja'
	'2' 'nein'.
Value labels 	pg333b				
	'-1' 'keine Angabe'
	'-2' 'trifft nicht zu'.
Value labels 	pg334a				
	'-1' 'keine Angabe'
	'-2' 'trifft nicht zu'
	'1' 'ja'
	'2' 'nein'.
Value labels 	pg334b				
	'-1' 'keine Angabe'
	'-2' 'trifft nicht zu'.
Value labels 	pg335a				
	'-1' 'keine Angabe'
	'-2' 'trifft nicht zu'
	'1' 'ja'
	'2' 'nein'.
Value labels 	pg335b				
	'-1' 'keine Angabe'
	'-2' 'trifft nicht zu'.
Value labels 	pg336a				
	'-1' 'keine Angabe'
	'-2' 'trifft nicht zu'
	'1' 'ja'
	'2' 'nein'.
Value labels 	pg336b				
	'-1' 'keine Angabe'
	'-2' 'trifft nicht zu'.
Value labels 	pg337a				
	'-1' 'keine Angabe'
	'-2' 'trifft nicht zu'
	'1' 'ja'
	'2' 'nein'.
Value labels 	pg337b				
	'-1' 'keine Angabe'
	'-2' 'trifft nicht zu'.
Value labels 	pg338a				
	'-1' 'keine Angabe'
	'-2' 'trifft nicht zu'
	'1' 'ja'
	'2' 'nein'.
Value labels 	pg338b				
	'-1' 'keine Angabe'
	'-2' 'trifft nicht zu'.
Value labels 	pg339a				
	'-1' 'keine Angabe'
	'-2' 'trifft nicht zu'
	'1' 'ja'
	'2' 'nein'.
Value labels 	pg339b				
	'-1' 'keine Angabe'
	'-2' 'trifft nicht zu'.
Value labels 	pg3310a				
	'-1' 'keine Angabe'
	'-2' 'trifft nicht zu'
	'1' 'ja'
	'2' 'nein'.
Value labels 	pg3310b				
	'-1' 'keine Angabe'
	'-2' 'trifft nicht zu'.
Value labels 	ph341				
	'-1' 'keine Angabe'
	'-2' 'trifft nicht zu'
	'1' 'ja'
	'2' 'nein'.
Value labels 	ph342				
	'-1' 'keine Angabe'
	'-2' 'trifft nicht zu'
	'1' 'ja'
	'2' 'nein'.
Value labels 	ph343				
	'-1' 'keine Angabe'
	'-2' 'trifft nicht zu'
	'1' 'ja'
	'2' 'nein'.
Value labels 	ph344				
	'-1' 'keine Angabe'
	'-2' 'trifft nicht zu'
	'1' 'ja'
	'2' 'nein'.
Value labels 	ph345				
	'-1' 'keine Angabe'
	'-2' 'trifft nicht zu'
	'1' 'ja'
	'2' 'nein'.
Value labels 	ph346				
	'-2' 'trifft nicht zu'
	'-1' 'keine Angabe'
	'1' 'ja'
	'2' 'nein'.
Value labels 	ph347				
	'-1' 'keine Angabe'
	'-2' 'trifft nicht zu'
	'1' 'ja'
	'2' 'nein'.
Value labels 	ph348				
	'-1' 'keine Angabe'
	'-2' 'trifft nicht zu'
	'1' 'ja'
	'2' 'nein'.
Value labels 	ph349				
	'-1' 'keine Angabe'
	'-2' 'trifft nicht zu'
	'1' 'ja'
	'2' 'nein'.
Value labels 	ph3410				
	'-1' 'keine Angabe'
	'-2' 'trifft nicht zu'
	'1' 'ja'
	'2' 'nein'.
Value labels 	ph3411				
	'-1' 'keine Angabe'
	'-2' 'trifft nicht zu'
	'1' 'ja'
	'2' 'nein'.
Value labels 	ph3412				
	'-1' 'keine Angabe'
	'-2' 'trifft nicht zu'
	'1' 'ja'
	'2' 'nein'.
Value labels 	ph3413				
	'-1' 'keine Angabe'
	'-2' 'trifft nicht zu'
	'1' 'ja'
	'2' 'nein'.
Value labels 	ph3414				
	'-1' 'keine Angabe'
	'-2' 'trifft nicht zu'
	'1' 'ja'
	'2' 'nein'.
Value labels 	ph35				
	'-1' 'keine Angabe'
	'-2' 'trifft nicht zu'
	'1' 'unter 3 Std. pro Monat'
	'2' '3 - 5 Std. pro Monat'
	'3' '6 - 10 Std. pro Monat'
	'4' '11 - 20 Std. pro Monat'
	'5' '21 - 40 Std. pro Monat'
	'6' 'über 40 Std. pro Monat'
	'7' 'Nicht freiwillig engagiert'.
Value labels 	pi361a				
	'-1' 'keine Angabe'
	'-2' 'trifft nicht zu'
	'1' 'ja'
	'2' 'nein'.
Value labels 	pi361b				
	'-1' 'keine Angabe'
	'-2' 'trifft nicht zu'.
Value labels 	pi362a				
	'-1' 'keine Angabe'
	'-2' 'trifft nicht zu'
	'1' 'ja'
	'2' 'nein'.
Value labels 	pi362b				
	'-1' 'keine Angabe'
	'-2' 'trifft nicht zu'.
Value labels 	pi363a				
	'-1' 'keine Angabe'
	'-2' 'trifft nicht zu'
	'1' 'ja'
	'2' 'nein'.
Value labels 	pi363b				
	'-1' 'keine Angabe'
	'-2' 'trifft nicht zu'.
Value labels 	pi364a				
	'-1' 'keine Angabe'
	'-2' 'trifft nicht zu'
	'1' 'ja'
	'2' 'nein'.
Value labels 	pi364b				
	'-1' 'keine Angabe'
	'-2' 'trifft nicht zu'.
Value labels 	pi365a				
	'-1' 'keine Angabe'
	'-2' 'trifft nicht zu'
	'1' 'ja'
	'2' 'nein'.
Value labels 	pi365b				
	'-1' 'keine Angabe'
	'-2' 'trifft nicht zu'.
Value labels 	pi366a				
	'-1' 'keine Angabe'
	'-2' 'trifft nicht zu'
	'1' 'ja'
	'2' 'nein'.
Value labels 	pi366b				
	'-1' 'keine Angabe'
	'-2' 'trifft nicht zu'.
Value labels 	pi367a				
	'-1' 'keine Angabe'
	'-2' 'trifft nicht zu'
	'1' 'ja'
	'2' 'nein'.
Value labels 	pi367b				
	'-1' 'keine Angabe'
	'-2' 'trifft nicht zu'.
Value labels 	pi368a				
	'-1' 'keine Angabe'
	'-2' 'trifft nicht zu'
	'1' 'ja'
	'2' 'nein'.
Value labels 	pi368b				
	'-1' 'keine Angabe'
	'-2' 'trifft nicht zu'.
Value labels 	pi369a				
	'-1' 'keine Angabe'
	'-2' 'trifft nicht zu'
	'1' 'ja'
	'2' 'nein'.
Value labels 	pi369b				
	'-1' 'keine Angabe'
	'-2' 'trifft nicht zu'.
Value labels 	pi3610a				
	'-1' 'keine Angabe'
	'-2' 'trifft nicht zu'
	'1' 'ja'
	'2' 'nein'.
Value labels 	pi3610b				
	'-1' 'keine Angabe'
	'-2' 'trifft nicht zu'.
Value labels 	pi3611a				
	'-1' 'keine Angabe'
	'-2' 'trifft nicht zu'
	'1' 'ja'
	'2' 'nein'.
Value labels 	pi3611b				
	'-1' 'keine Angabe'
	'-2' 'trifft nicht zu'.
Value labels 	pk381				
	'-1' 'keine Angabe'
	'-2' 'trifft nicht zu'
	'1' 'Völlig ausreichend'
	'2' 'Eher ausreichend'
	'3' 'Teils/teils'
	'4' 'Eher nicht ausreichend'
	'5' 'Gar nicht ausreichend'
	'9' 'für mich nicht zutreffend'.
Value labels 	pk382				
	'-1' 'keine Angabe'
	'-2' 'trifft nicht zu'
	'1' 'Völlig ausreichend'
	'2' 'Eher ausreichend'
	'3' 'Teils/teils'
	'4' 'Eher nicht ausreichend'
	'5' 'Gar nicht ausreichend'
	'9' 'für mich nicht zutreffend'.
Value labels 	pk383				
	'-1' 'keine Angabe'
	'-2' 'trifft nicht zu'
	'1' 'Völlig ausreichend'
	'2' 'Eher ausreichend'
	'3' 'Teils/teils'
	'4' 'Eher nicht ausreichend'
	'5' 'Gar nicht ausreichend'
	'9' 'für mich nicht zutreffend'.
Value labels 	pk384				
	'-1' 'keine Angabe'
	'-2' 'trifft nicht zu'
	'1' 'Völlig ausreichend'
	'2' 'Eher ausreichend'
	'3' 'Teils/teils'
	'4' 'Eher nicht ausreichend'
	'5' 'Gar nicht ausreichend'
	'9' 'für mich nicht zutreffend'.
Value labels 	pk385				
	'-1' 'keine Angabe'
	'-2' 'trifft nicht zu'
	'1' 'Völlig ausreichend'
	'2' 'Eher ausreichend'
	'3' 'Teils/teils'
	'4' 'Eher nicht ausreichend'
	'5' 'Gar nicht ausreichend'
	'9' 'für mich nicht zutreffend'.
Value labels 	pk386				
	'-1' 'keine Angabe'
	'-2' 'trifft nicht zu'
	'1' 'Völlig ausreichend'
	'2' 'Eher ausreichend'
	'3' 'Teils/teils'
	'4' 'Eher nicht ausreichend'
	'5' 'Gar nicht ausreichend'
	'9' 'für mich nicht zutreffend'.
Value labels 	pk387				
	'-1' 'keine Angabe'
	'-2' 'trifft nicht zu'
	'1' 'Völlig ausreichend'
	'2' 'Eher ausreichend'
	'3' 'Teils/teils'
	'4' 'Eher nicht ausreichend'
	'5' 'Gar nicht ausreichend'
	'9' 'für mich nicht zutreffend'.
Value labels 	pk388				
	'-1' 'keine Angabe'
	'-2' 'trifft nicht zu'
	'1' 'Völlig ausreichend'
	'2' 'Eher ausreichend'
	'3' 'Teils/teils'
	'4' 'Eher nicht ausreichend'
	'5' 'Gar nicht ausreichend'
	'9' 'für mich nicht zutreffend'.
Value labels 	pk389				
	'-1' 'keine Angabe'
	'-2' 'trifft nicht zu'
	'1' 'Völlig ausreichend'
	'2' 'Eher ausreichend'
	'3' 'Teils/teils'
	'4' 'Eher nicht ausreichend'
	'5' 'Gar nicht ausreichend'
	'9' 'für mich nicht zutreffend'.
Value labels 	pk3810				
	'-1' 'keine Angabe'
	'-2' 'trifft nicht zu'
	'1' 'Völlig ausreichend'
	'2' 'Eher ausreichend'
	'3' 'Teils/teils'
	'4' 'Eher nicht ausreichend'
	'5' 'Gar nicht ausreichend'.
Value labels 	pk3811				
	'-1' 'keine Angabe'
	'-2' 'trifft nicht zu'
	'1' 'Völlig ausreichend'
	'2' 'Eher ausreichend'
	'3' 'Teils/teils'
	'4' 'Eher nicht ausreichend'
	'5' 'Gar nicht ausreichend'.
Value labels 	pk3812				
	'-1' 'keine Angabe'
	'-2' 'trifft nicht zu'
	'1' 'Völlig ausreichend'
	'2' 'Eher ausreichend'
	'3' 'Teils/teils'
	'4' 'Eher nicht ausreichend'
	'5' 'Gar nicht ausreichend'
	'9' 'für mich nicht zutreffend'.
Value labels 	pk3813				
	'-1' 'keine Angabe'
	'-2' 'trifft nicht zu'
	'1' 'Völlig ausreichend'
	'2' 'Eher ausreichend'
	'3' 'Teils/teils'
	'4' 'Eher nicht ausreichend'
	'5' 'Gar nicht ausreichend'
	'9' 'für mich nicht zutreffend'.
Value labels 	pk391				
	'-1' 'keine Angabe'
	'-2' 'trifft nicht zu'
	'1' 'Stimme voll und ganz zu'
	'2' 'Stimme eher zu'
	'3' 'Teils/teils'
	'4' 'Stimme eher nicht zu'
	'5' 'Stimme ganz und gar nicht zu'.
Value labels 	pk392				
	'-1' 'keine Angabe'
	'-2' 'trifft nicht zu'
	'1' 'Stimme voll und ganz zu'
	'2' 'Stimme eher zu'
	'3' 'Teils/teils'
	'4' 'Stimme eher nicht zu'
	'5' 'Stimme ganz und gar nicht zu'.
Value labels 	pk393				
	'-1' 'keine Angabe'
	'-2' 'trifft nicht zu'
	'1' 'Stimme voll und ganz zu'
	'2' 'Stimme eher zu'
	'3' 'Teils/teils'
	'4' 'Stimme eher nicht zu'
	'5' 'Stimme ganz und gar nicht zu'.
Value labels 	pk394				
	'-1' 'keine Angabe'
	'-2' 'trifft nicht zu'
	'1' 'Stimme voll und ganz zu'
	'2' 'Stimme eher zu'
	'3' 'Teils/teils'
	'4' 'Stimme eher nicht zu'
	'5' 'Stimme ganz und gar nicht zu'.
Value labels 	pk395				
	'-1' 'keine Angabe'
	'-2' 'trifft nicht zu'
	'1' 'Stimme voll und ganz zu'
	'2' 'Stimme eher zu'
	'3' 'Teils/teils'
	'4' 'Stimme eher nicht zu'
	'5' 'Stimme ganz und gar nicht zu'.
Value labels 	pk396				
	'-1' 'keine Angabe'
	'-2' 'trifft nicht zu'
	'1' 'Stimme voll und ganz zu'
	'2' 'Stimme eher zu'
	'3' 'Teils/teils'
	'4' 'Stimme eher nicht zu'
	'5' 'Stimme ganz und gar nicht zu'.
Value labels 	pk401x				
	'-1' 'keine Angabe'
	'-2' 'trifft nicht zu'.
Value labels 	pk402ax				
	'-1' 'keine Angabe'
	'-2' 'trifft nicht zu'.
Value labels 	pk402bx				
	'-1' 'keine Angabe'
	'-2' 'trifft nicht zu'.
Value labels 	pk402cx				
	'-1' 'keine Angabe'
	'-2' 'trifft nicht zu'.
Value labels 	pk402dx				
	'-1' 'keine Angabe'
	'-2' 'trifft nicht zu'.
Value labels 	pk402ex				
	'-1' 'keine Angabe'
	'-2' 'trifft nicht zu'.
Value labels 	alter_gr1				
	'1' '0 bis unter 10 Jahren'
	'2' '10 bis unter 18 Jahren'
	'3' '18 bis unter 25 Jahren'
	'4' '25 bis unter 45 Jahren'
	'5' '45 bis unter 65 Jahren'
	'6' '65 Jahre und älter'.
Value labels 	alter_gr2				
	'-2' 'trifft nicht zu'
	'1' '10 bis unter 12 Jahren'
	'2' '12 bis unter 18 Jahren'
	'3' '18 bis unter 25 Jahren'
	'4' '25 bis unter 45 Jahren'
	'5' '45 bis unter 65 Jahren'
	'6' '65 Jahre und älter'.
Value labels 	soz				
	'-1' 'keine Angabe'
	'-2' 'trifft nicht zu (Person unter 16 Jahren)'
	'1' 'Selbstständiger'
	'2' 'Beamter'
	'3' 'Angestellter, Auszubildender, Freiwilliger Wehrdienst, Freiwilligendienst, Freiwilliges soziales/ökologisches/kulturelles Jahr'
	'4' 'Arbeiter'
	'5' 'Schüler, Student'
	'6' 'Rentner, Pensionär'
	'7' 'Arbeitsloser'
	'8' 'sonstige Nichterwerbstätiger'.
Value labels 	erw_typ				
	'-1' 'keine Angabe'
	'-2' 'trifft nicht zu (Person unter 16 Jahren)'
	'1' 'Vollzeit erwerbstätig'
	'2' 'Teilzeit erwerbstätig'
	'3' 'nicht erwerbstätig'.
Value labels 	isced				
	'-1' 'keine Angabe'
	'-2' 'trifft nicht zu (Person unter 10 Jahren)'
	'1' 'ISCED 1'
	'2' 'ISCED 2'
	'3' 'ISCED 3'
	'4' 'ISCED 4'
	'5' 'ISCED 5'
	'6' 'ISCED 6'.
Value labels 	bildung_typ				
	'-1' 'keine Angabe'
	'-2' 'trifft nicht zu (Person unter 16 Jahren)'
	'1' 'keine, niedrige Bildung (ISCED 1+2)'
	'2' 'mittlere Bildung (ISCED 3+4)'
	'3' 'hohe Bildung (ISCED 5+6)'.
Value labels 	pf31_typ				
	'-1' 'keine Angabe'
	'-2' 'trifft nicht zu (Person unter 10 Jahren)'
	'1' 'Kein (oder noch kein) beruflicher Ausbildungsabschluss, Hochschul- oder Fachhochschulabschluss'
	'2' 'Anlernausbildung, berufliches Praktikum, Berufsvorbereitungsjahr'
	'3' 'Lehre, Berufsausbildung, Vorbereitungsdienst für den mittleren Dienst in der öffentlichen Verwaltung, Berufsfachschule/Kollegschule, 1-jährige Schule des Gesundheitswesens'
	'4' '2- oder 3-jährige Schule des Gesundheitswesens, Meister, Techniker oder gleichwertiger Fachschulabschluss, Fachakademie'
	'5' 'Fachschule der DDR'
	'6' 'Berufsakademie, Verwaltungs-Fachhochschule, Fachhochschule (auch Ingenieurschule), Universität, wissenschaftl. Abschluss, Kunsthochschule, Promotion'.
Value labels 	erw_part				
	'-1' 'keine Angabe'
	'-2' 'trifft nicht zu'
	'1' 'Vollzeit erwerbstätig'
	'2' 'Teilzeit erwerbstätig'
	'3' 'nicht erwerbstätig'.
 
*			  (III) ZVE 13 pers		
*					 (iv) Speichern als SPSS-Datei

SAVE outfile=!Pfad2+!Dateiname2.

 
*			  (IV) ZVE 13 sum		
*					 (i) Einlesen CSV-Datei

GET DATA
 /TYPE=TXT
 /FILE=!Pfad3+!CSVdatei3
 /DELCASE=LINE
 /DELIMITERS=";"
 /ARRANGEMENT=DELIMITED
 /FIRSTCASE=2
 /IMPORTCASE=ALL
 /VARIABLES=
 id_hhx F4.0
 id_persx F5.0
 id_tagx F6.0
 persx F1.0
 tagnr F1.0
 berichtsjahr F4.0
 ha_1 F5.0
 ha_2 F5.0
 ha_3 F5.0
 ha_4 F5.0
 ha_5 F5.0
 ha_6 F5.0
 ha_7 F5.0
 ha_8 F5.0
 ha_9 F5.0
 hainklweg_1 F5.0
 hainklweg_2 F5.0
 hainklweg_3 F5.0
 hainklweg_4 F5.0
 hainklweg_5 F5.0
 hainklweg_6 F5.0
 hainklweg_7 F5.0
 hainklweg_8 F5.0
 ha_11 F5.0
 ha_12 F5.0
 ha_13 F5.0
 ha_21 F5.0
 ha_22 F4.0
 ha_23 F1.0
 ha_24 F5.0
 ha_31 F5.0
 ha_32 F4.0
 ha_33 F4.0
 ha_34 F1.0
 ha_35 F5.0
 ha_36 F4.0
 ha_41 F5.0
 ha_42 F5.0
 ha_43 F5.0
 ha_44 F5.0
 ha_45 F5.0
 ha_46 F5.0
 ha_47 F5.0
 ha_48 F4.0
 ha_49 F5.0
 ha_51 F5.0
 ha_52 F5.0
 ha_53 F4.0
 ha_61 F5.0
 ha_62 F5.0
 ha_63 F5.0
 ha_64 F5.0
 ha_71 F5.0
 ha_73 F4.0
 ha_74 F4.0
 ha_75 F4.0
 ha_76 F5.0
 ha_79x F4.0
 ha_81 F5.0
 ha_82 F5.0
 ha_83 F4.0
 ha_84 F5.0
 ha_92 F4.0
 ha_93 F5.0
 ha_94 F5.0
 ha_95 F4.0
 ha_96 F5.0
 ha_97 F4.0
 ha_98 F1.0
 ha_99 F5.0
 ha_110 F5.0
 ha_120 F5.0
 ha_131 F5.0
 ha_132 F5.0
 ha_139 F4.0
 ha_210 F5.0
 ha_220 F4.0
 ha_230 F1.0
 ha_241 F1.0
 ha_242 F5.0
 ha_243 F1.0
 ha_244 F1.0
 ha_245 F4.0
 ha_249 F3.0
 ha_311 F5.0
 ha_312 F4.0
 ha_313 F5.0
 ha_314 F4.0
 ha_315 F4.0
 ha_317 F4.0
 ha_319x F5.0
 ha_321 F1.0
 ha_329 F4.0
 ha_330x F4.0
 ha_341 F1.0
 ha_349 F1.0
 ha_353 F1.0
 ha_354x F5.0
 ha_361 F4.0
 ha_362 F4.0
 ha_363 F1.0
 ha_364 F1.0
 ha_369 F4.0
 ha_411 F5.0
 ha_412 F5.0
 ha_413 F4.0
 ha_414 F4.0
 ha_419 F1.0
 ha_421 F5.0
 ha_422 F4.0
 ha_423 F4.0
 ha_429 F1.0
 ha_431 F4.0
 ha_432 F5.0
 ha_433 F4.0
 ha_434 F4.0
 ha_439 F4.0
 ha_441 F5.0
 ha_442 F4.0
 ha_443 F4.0
 ha_444 F4.0
 ha_445 F4.0
 ha_446 F5.0
 ha_449 F4.0
 ha_451 F1.0
 ha_452 F5.0
 ha_453 F4.0
 ha_454 F4.0
 ha_455 F4.0
 ha_459 F1.0
 ha_461 F5.0
 ha_464 F4.0
 ha_465 F5.0
 ha_466 F5.0
 ha_469 F1.0
 ha_471 F4.0
 ha_472 F4.0
 ha_473 F4.0
 ha_474 F4.0
 ha_475 F4.0
 ha_476 F4.0
 ha_479 F3.0
 ha_480 F4.0
 ha_491 F4.0
 ha_492 F4.0
 ha_499 F4.0
 ha_510 F5.0
 ha_520 F5.0
 ha_531 F1.0
 ha_532 F4.0
 ha_539 F1.0
 ha_611 F5.0
 ha_612 F5.0
 ha_621 F4.0
 ha_622 F5.0
 ha_623 F5.0
 ha_624 F1.0
 ha_625 F5.0
 ha_626 F5.0
 ha_627 F5.0
 ha_629 F1.0
 ha_630 F5.0
 ha_641 F5.0
 ha_642 F5.0
 ha_649 F1.0
 ha_711 F4.0
 ha_712 F4.0
 ha_713 F5.0
 ha_715 F5.0
 ha_716 F4.0
 ha_717 F4.0
 ha_719x F4.0
 ha_730 F4.0
 ha_740 F4.0
 ha_752 F3.0
 ha_759x F4.0
 ha_761 F5.0
 ha_762 F4.0
 ha_763 F5.0
 ha_769 F5.0
 ha_790x F4.0
 ha_811 F5.0
 ha_812 F4.0
 ha_813 F5.0
 ha_814 F1.0
 ha_815 F4.0
 ha_819 F5.0
 ha_820 F5.0
 ha_830 F4.0
 ha_841 F4.0
 ha_842 F5.0
 ha_843 F4.0
 ha_844 F5.0
 ha_849 F5.0
 ha_921 F4.0
 ha_922 F3.0
 ha_923 F1.0
 ha_929 F1.0
 ha_931 F5.0
 ha_934 F4.0
 ha_939 F4.0
 ha_941 F4.0
 ha_945 F1.0
 ha_946 F5.0
 ha_947 F4.0
 ha_948 F4.0
 ha_949 F1.0
 ha_951 F4.0
 ha_952 F4.0
 ha_953 F4.0
 ha_959 F4.0
 ha_961 F5.0
 ha_962 F5.0
 ha_969 F5.0
 ha_970 F4.0
 ha_980 F1.0
 ha_991 F5.0
 ha_992 F4.0
 ha_997 F4.0
 ha_998 F4.0
 ha_999 F1.0
 tc1x F1.0
 tc1ax F3.0
 tc1bx F3.0
 tc1cx F2.0
 tc2x F1.0
 tc2ax F3.0
 tc2bx F3.0
 tc2cx F2.0
 tc3x F1.0
 tc3ax F3.0
 tc3bx F3.0
 tc3cx F2.0
 tc4 F1.0
 tc5 F1.0
 tc6 F2.0
 tc7 F2.0
 tc8 F2.0
 wtagfei F1.0
 fehl_tag F1.0
 quartal F1.0
 jahr F4.0
 selbtag F2.0
 hrft80 F7.0.
CACHE.
 
*			  (IV) ZVE 13 sum		
*			  (ii)	Zuweisen der Variablenlabels.
VARIABLE LABELS
id_hhx	 'Haushalts-ID'
id_persx	 'Personen-ID'
id_tagx	 'Tag-ID'
persx	 'Personennummer'
tagnr	 'Anschreibetag'
berichtsjahr	 'Berichtsjahr'
ha_1	 '1 Persönlicher Bereich/Physiologische Regeneration (HA)'
ha_2	 '2 Erwerbstätigkeit (HA)'
ha_3	 '3 Qualifikation/Bildung (HA)'
ha_4	 '4 Haushaltsführung und Betreuung der Familie (HA)'
ha_5	 '5 Ehrenamt/Freiwilligenarbeit etc. (HA)'
ha_6	 '6 Soziales Leben/Unterhaltung (HA)'
ha_7	 '7 Sport/Hobbys/Spiele (HA)'
ha_8	 '8 Mediennutzung (HA)'
ha_9	 '9 Zweckbestimmte Wegezeiten/Hilfscodes (HA)'
hainklweg_1	 '1 Persönlicher Bereich/Physiologische Regeneration inkl. Wegezeit (HA)'
hainklweg_2	 '2 Erwerbstätigkeit inkl. Wegezeit (HA)'
hainklweg_3	 '3 Qualifikation/Bildung inkl. Wegezeit (HA)'
hainklweg_4	 '4 Haushaltsführung und Betreuung der Familie inkl. Wegezeit (HA)'
hainklweg_5	 '5 Ehrenamt/Freiwilligenarbeit etc. inkl. Wegezeit (HA)'
hainklweg_6	 '6 Soziales Leben/Unterhaltung inkl. Wegezeit (HA)'
hainklweg_7	 '7 Sport/Hobbys/Spiele inkl. Wegezeit (HA)'
hainklweg_8	 '8 Mediennutzung inkl. Wegezeit (HA)'
ha_11	 '11 Schlafen (HA)'
ha_12	 '12 Essen und Trinken (HA)'
ha_13	 '13 Andere Tätigkeiten pers. Bereich (HA)'
ha_21	 '21 Haupterwerbstätigkeit (HA)'
ha_22	 '22 Nebenerwerbstätigkeit (HA)'
ha_23	 '23 Erwerbstätigkeit ohne Unterteilung (HA)'
ha_24	 '24 Andere Akt. Erwerbstätigkeit (HA)'
ha_31	 '31 Unterricht in der Schule (HA)'
ha_32	 '32 Betreuung in der Schule (HA)'
ha_33	 '33 AGs (HA)'
ha_34	 '34 Hochschule (HA)'
ha_35	 '35 Vor-/Nachbereitungen Lehrveranstaltungen (HA)'
ha_36	 '36 Andere Akt. Qualifikation/Bildung (HA)'
ha_41	 '41 Zubereitung von Mahlzeiten/Küche (HA)'
ha_42	 '42 Instanthaltung v. Haus/Wohnung (HA)'
ha_43	 '43 Textilien (HA)'
ha_44	 '44 Pflanzen-/Tierpflege (HA)'
ha_45	 '45 Bauen/Handwerk (HA)'
ha_46	 '46 Einkaufen/Fremdleistungen (HA)'
ha_47	 '47 Kinderbetreuung (HA)'
ha_48	 '48 Unterstützung/Pflege erw. HH-Mitglieder (HA)'
ha_49	 '49 Andere Akt. Haushaltsführung/Familie (HA)'
ha_51	 '51 Ehrenamt/Freiwilliges Engagement (HA)'
ha_52	 '52 Unterstützung für andere Haushalte (HA)'
ha_53	 '53 Teilnahme an Versammlungen (HA)'
ha_61	 '61 Soziale Kontakte (HA)'
ha_62	 '62 Unterhaltung und Kultur (HA)'
ha_63	 '63 Ausruhen/Auszeit/Zeit überbrücken (HA)'
ha_64	 '64 Andere Akt. Soziales Leben/Unterhaltung (HA)'
ha_71	 '71 Körperliche Bewegung (HA)'
ha_73	 '73 Rüstzeiten sportliche Aktivitäten (HA)'
ha_74	 '74 Kunst/Musizieren (HA)'
ha_75	 '75 Sonstige Hobbies (HA)'
ha_76	 '76 Spiele (HA)'
ha_79x	 '79 Sport ohne nähere Bezeichnung (HA)'
ha_81	 '81 Lesen (HA)'
ha_82	 '82 Fernsehen und Video/DVD (HA)'
ha_83	 '83 Radio/Musik hören (HA)'
ha_84	 '84 Computer/Smartphone (HA)'
ha_92	 '92 Wegezeiten Erwerbstätigkeit (HA)'
ha_93	 '93 Wegezeiten Qualifikation/Bildung (HA)'
ha_94	 '94 Wegezeiten Haushaltsführung/Familie (HA)'
ha_95	 '95 Wegezeiten Ehrenamt/Freiwilligenarbeit etc. (HA)'
ha_96	 '96 Wegezeiten Soziales Leben/Unterhaltung (HA)'
ha_97	 '97 Wegezeiten Sport/Hobbys/Spiele (HA)'
ha_98	 '98 Wegezeiten Mediennutzung (HA)'
ha_99	 '99 Andere Wegezeiten/Hilfscodes (HA)'
ha_110	 '110 Schlafen (HA)'
ha_120	 '120 Essen und Trinken (HA)'
ha_131	 '131 Waschen und anziehen (HA)'
ha_132	 '132 Krank im Bett/Krank (HA)'
ha_139	 '139 Sonstige Aktivitäten pers. Bereich (HA)'
ha_210	 '210 Haupterwerbstätigkeit (HA)'
ha_220	 '220 Nebenerwerbstätigkeit (HA)'
ha_230	 '230 Erwerbstätigkeit ohne Unterteilung (HA)'
ha_241	 '241 Qualifizierung/Weiterbildung für Beruf (HA)'
ha_242	 '242 Arbeitssuche (HA)'
ha_243	 '243 Erwerbstätigkeit anderer: unbezahlte Arbeit (HA)'
ha_244	 '244 Praktikum im Rahmen einer Erwerbstätigkeit (HA)'
ha_245	 '245 Pause während der Arbeit ohne Unterteilung (HA)'
ha_249	 '249 Sonstige Aktivitäten Erwerbstätigkeit (HA)'
ha_311	 '311 Deutsch (HA)'
ha_312	 '312 Fremdsprache (HA)'
ha_313	 '313 Mathematik/NatWi/etc (HA)'
ha_314	 '314 Kunst/Musik (HA)'
ha_315	 '315 Gesellschaftswissenschaften (HA)'
ha_317	 '317 Sport (HA)'
ha_319x	 '319 Sonstige Unterrichtsfächer (HA)'
ha_321	 '321 Angebote der Schule zur Vor-/Nachbereitung (HA)'
ha_329	 '329 Sonstige Betreuungsangebote Schule (HA)'
ha_330x '330 AGs (HA)'
ha_341	 '341 Lehrveranstaltungen Hochschule (HA)'
ha_349	 '349 Sonstige Aktivitäten im Bereich Hochschule (HA)'
ha_353	 '353 Vor-/Nachbereitung Lehrveranstaltungen (HA)'
ha_354x '354x Hausaufgaben/Selbstlernen für die Schule/Private Nachhilfe (HA)'
ha_361	 '361 Qualifikation außerhalb der Arbeitszeit (HA)'
ha_362	 '362 Pausen in der Schule (HA)'
ha_363	 '363 Freistunden/Leerlaufzeiten in der Schule (HA)'
ha_364	 '364 Pausen Hochschule (HA)'
ha_369	 '369 Sonstige Aktivitäten Qualifikation/Bildung (HA)'
ha_411	 '411 Mahlzeiten vor- und zubereiten (HA)'
ha_412	 '412 Backen (HA)'
ha_413	 '413 Geschirreinigung, Tisch decken/abräumen (HA)'
ha_414	 '414 Konservieren von Lebensmitteln (HA)'
ha_419	 '419 Sonstige Aktivitäten Zubereitung von Mahlzeiten (HA)'
ha_421	 '421 Reinigung/Aufräumen der Wohnung (HA)'
ha_422	 '422 Reinigung Hof/Keller/Garage, Abfallbeseitigung (HA)'
ha_423	 '423 Heizen (HA)'
ha_429	 '429 Sonstige Aktivitäten Instandhaltung Haus/Wohnung (HA)'
ha_431	 '431 Wäsche waschen (HA)'
ha_432	 '432 Bügeln und mangeln (HA)'
ha_433	 '433 Herstellung von Textilien (HA)'
ha_434	 '434 Ausbessern/Umändern Textilien (HA)'
ha_439	 '439 Sonstige Aktivitäten Textilien (HA)'
ha_441	 '441 Pflanzenpflege draußen (HA)'
ha_442	 '442 Pflanzenpflege drinnen (HA)'
ha_443	 '443 Pflanzenpflege ohne Ort (HA)'
ha_444	 '444 Nutztierpflege (HA)'
ha_445	 '445 Haustierpflege (HA)'
ha_446	 '446 Hund spazieren führen (HA)'
ha_449	 '449 Sonstige Pflanzen-/Tierpflege (HA)'
ha_451	 '451 Hausbau und Instandhaltung (HA)'
ha_452	 '452 Wohnungsreparaturen, Renovierung (HA)'
ha_453	 '453 Herstellung/Wartung/Repar. Ausstattungsgegenstände (HA)'
ha_454	 '454 Wartung/kl. Rep. Haushaltsgegenständen (HA)'
ha_455	 '455 Fahrzeugreparatur/-pflege (HA)'
ha_459	 '459 Sonstige Aktivitäten Bauen/Handwerk (HA)'
ha_461	 '461 Einkaufen (ohne Telefon/Internet) (HA)'
ha_464	 '464 Behördengang/Dienstleistung/ Verwaltung (HA)'
ha_465	 '465 personengebundene Dienstleistungen (HA)'
ha_466	 '466 Medizinische Dienste (HA)'
ha_469	 '469 Sonstige Aktivitäten Einkaufen/Fremdleistungen (HA)'
ha_471	 '471 Körperpflege/Beaufsichtigung Kind (HA)'
ha_472	 '472 Hausaufgabenbetreuung/Anleitungen Kind (HA)'
ha_473	 '473 Spielen/Sport Kind (HA)'
ha_474	 '474 Gespräche Kind (HA)'
ha_475	 '475 Begleiten/Termine mit Kind (HA)'
ha_476	 '476 Kind vorlesen/erzählen (HA)'
ha_479	 '479 Sonstige Aktivitäten Kinderbetreuung (HA)'
ha_480	 '480 Unterstützung/Pflege erw. HHmitglieder (HA)'
ha_491	 '491 Rüsttätigkeiten im Haushalt (HA)'
ha_492	 '492 Haushaltsplanung (auch Internet/Telefon) (HA)'
ha_499	 '499 Sonstige Aktivitäten Haushaltsführung/Familie (HA)'
ha_510	 '510 Ehrenamt/Freiwilliges Engagement (HA)'
ha_520	 '520 Unterstützung für andere Haushalte (HA)'
ha_531	 '531 Politische und soziale Versammlungen (HA)'
ha_532	 '532 religiöse Aktivitäten (HA)'
ha_539	 '539 Sonstige Aktivitäten Versammlungen (HA)'
ha_611	 '611 Gespräche (HA)'
ha_612	 '612 Telefonate (auch SMS) (HA)'
ha_621	 '621 Kino (HA)'
ha_622	 '622 Theater/Konzerte/Oper/Musical (HA)'
ha_623	 '623 Kunstausstellungen/Museen (HA)'
ha_624	 '624 Bibliotheken (HA)'
ha_625	 '625 Sportveranstaltungen (HA)'
ha_626	 '626 Ausflüge/Zoo/Vergnügungsparks (HA)'
ha_627	 '627 Ausgehen (HA)'
ha_629	 '629 Sonstige Unterhaltung/Kultur (HA)'
ha_630	 '630 Ausruhen/Auszeit/Zeit überbrücken (HA)'
ha_641	 '641 Besuch (HA)'
ha_642	 '642 Familienfeiern/Feste privater Art (HA)'
ha_649	 '649 Sonstige Aktivitäten Soziales Leben/ Unterhaltung (HA)'
ha_711	 '711 Spazieren gehen (HA)'
ha_712	 '712 Joggen/Nordic Walking/Wandern (HA)'
ha_713	 '713 Radsport und Skaten (HA)'
ha_715	 '715 Ballspiele (HA)'
ha_716	 '716 Gymnastik/Fitness/Tanzen (HA)'
ha_717	 '717 Wassersport (HA)'
ha_719x	 '719 Sonstige Körperliche Bewegung (HA)'
ha_730	 '730 Rüstzeiten für sportliche Aktivitäten (HA)'
ha_740	 '740 Kunst/Musizieren (HA)'
ha_752	 '752 Korrespondenz (außer Computer/Handy) (HA)'
ha_759x	 '759 Sonstige Hobbys (HA)'
ha_761	 '761 Gesellschaftsspiele/Spiel miteinander (HA)'
ha_762	 '762 Spiele allein, Glücksspiele (HA)'
ha_763	 '763 Computerspiele (HA)'
ha_769	 '769 Sonstige Spiele (HA)'
ha_790x	 '790 Sport ohne nähere Bezeichnung (HA)'
ha_811	 '811 Zeitungen lesen (auch elektronisch) (HA)'
ha_812	 '812 Zeitschriften lesen (auch elektronisch) (HA)'
ha_813	 '813 Bücher lesen (auch elektronisch) (HA)'
ha_814	 '814 Zuhören beim Vorlesen (HA)'
ha_815	 '815 Sonstiges lesen (auch elektronisch) (HA)'
ha_819	 '819 Lesen ohne nähere Bezeichnung (HA)'
ha_820	 '820 Fernsehen und Video/DVD (HA)'
ha_830	 '830 Radio, Musik hören (HA)'
ha_841	 '841 Programmierung/Reparatur Computer/ Smartphone (HA)'
ha_842	 '842 Informieren durch Computer/Smartphone (HA)'
ha_843	 '843 Kommunikation über Computer/ Smartphone (HA)'
ha_844	 '844 Sonstige Aktivitäten Computer/Smartphone (HA)'
ha_849	 '849 nicht näher bez. Akt. Computer/ Smartphone (HA)'
ha_921	 '921 Wegezeiten Haupterwerbstätigkeit (HA)'
ha_922	 '922 Wegezeiten Nebenerwerbstätigkeit (HA)'
ha_923	 '923 Wegezeiten Erwerbstätigkeit o. Unterteilung (HA)'
ha_929	 '929 Andere Wegezeiten Erwerbstätigkeit (24) (HA)'
ha_931	 '931 Wegezeiten Schule (31-33) (HA)'
ha_934	 '934 Wegezeiten Hochschule (34-35) (HA)'
ha_939	 '939 Andere Wegezeiten Qualifikation/Bildung (36) (HA)'
ha_941	 '941 Wegezeiten Haushalt, Pflanzen, Tiere (41-44) (HA)'
ha_945	 '945 Wegezeiten Bauen/handwerkliche Tätigkeiten (HA)'
ha_946	 '946 Wegezeiten Einkaufen, Fremdleistungen (HA)'
ha_947	 '947 Wegezeiten Kinderbetreuung (HA)'
ha_948	 '948 Wegezeiten Unterstützung erwachsener HH-Mitglieder (HA)'
ha_949	 '949 Wegezeiten Andere Akt. Haushalt/Familie (HA)'
ha_951	 '951 Wegezeiten Ehrenamt/Freiwilliges Engagement (HA)'
ha_952	 '952 Wegezeiten Unterstützung anderer Haushalte (HA)'
ha_953	 '953 Wegezeiten Teilnahme an Versammlungen (HA)'
ha_959	 '959 Andere Wege Engagement, Unterstützung, Versammlung (HA)'
ha_961	 '961 Wegezeiten Soziale Kontakte (HA)'
ha_962	 '962 Wegezeiten Unterhaltung/Kultur (HA)'
ha_969	 '969 Andere Wege Soz. Leben/Unterhaltung (63-64) (HA)'
ha_970	 '970 Wegezeiten Sport/Hobbys/Spiele (HA)'
ha_980	 '980 Wegezeiten Mediennutzung (HA)'
ha_991	 '991 Wegezeiten Reisen (HA)'
ha_992	 '992 Andere/unspezifizierte Wegezeiten (HA)'
ha_997	 '997 Ausfüllen des Tagebuchs (HA)'
ha_998	 '998 Nicht bestimmt verwendete Freizeit (HA)'
ha_999	 '999 Unbestimmte Zeitverwendung (keine Angabe) (HA)'
tc1x	 'Anzahl der Nennungen zu größte Freude'
tc1ax	 'Aktivitätscode größte Freude 1'
tc1bx	 'Aktivitätscode größte Freude 2'
tc1cx	 'Aktivitätscode größte Freude 3'
tc2x	 'Anzahl der Nennungen zu mehr Zeit'
tc2ax	 'Aktivitätscode mehr Zeit 1'
tc2bx	 'Aktivitätscode mehr Zeit 2'
tc2cx	 'Aktivitätscode mehr Zeit 3'
tc3x	 'Anzahl der Nennungen zu keine Freude'
tc3ax	 'Aktivitätscode keine Freude 1'
tc3bx	 'Aktivitätscode keine Freude 2'
tc3cx	 'Aktivitätscode keine Freude 3'
tc4	 'Besonderheiten des Tages'
tc5	 'Reise'
tc6	 'Häufigkeit der Anschreibungen'
tc7	 'Zu Hause zu Beginn des Tages'
tc8	 'Zu Hause am Ende des Tages'
wtagfei	 'Wochentag, Feiertage berücksichtigt'
fehl_tag	 'Fehlender Tag'
quartal	 'Kalenderquartal des Ausfülldatums'
jahr	 'Jahr des Ausfülldatums'
selbtag	 'Datum des Tagebuchtages ist für alle Personen des Haushalts'
hrft80 'Hochrechnungsfaktor für den Tag multipliziert mit 100'.


*			  (IV) ZVE 13 sum		
*					 (iii)	Zuweisen der Wertelabels.
value labels tc1ax
'-2' 'trifft nicht zu'	.
value labels tc1bx
'-2' 'trifft nicht zu'	.
value labels tc1cx
'-2' 'trifft nicht zu'	.
value labels tc2ax
'-2' 'trifft nicht zu'	.
value labels tc2bx
'-2' 'trifft nicht zu'	.
value labels tc2cx
'-2' 'trifft nicht zu'	.
value labels tc3ax
'-2' 'trifft nicht zu'	.
value labels tc3bx
'-2' 'trifft nicht zu'	.
value labels tc3cx
'-2' 'trifft nicht zu'	.
value labels 	tc4				
	'-1' 'keine Angabe'
	'1' 'normal'
	'2' 'ungewöhnlich'.
value labels 	tc5				
	'-1' 'keine Angabe'
	'1' 'keine Reise'
	'2' 'Tagesreise'
	'3' 'Reise mit Übernachtung'.
value labels 	tc6				
	'-1' 'keine Angabe'
	'1' 'über den Tag verteilt'
	'2' 'am Ende des Tages'
	'3' 'am Tag danach'
	'4' 'mehrere Tage später'.
value labels 	tc7				
	'-1' 'keine Angabe'
	'1' 'ja'
	'2' 'nein'.
value labels 	tc8
'-2' 'trifft nicht zu'				
	'-1' 'keine Angabe'
	'1' 'ja'
	'2' 'nein'.
value labels 	wtagfei				
	'1' 'Montag'
	'2' 'Dienstag'
	'3' 'Mittwoch'
	'4' 'Donnerstag'
	'5' 'Freitag'
	'6' 'Samstag/Heiligabend/Silvester'
	'7' 'Sonntag/Feiertag'.
value labels 	fehl_tag				
	'0' 'Person hat 3 Tagebuchtage ausgefüllt'
	'1' 'Tag 1 fehlt'
	'2' 'Tag 2 fehlt'
	'3' 'Tag 3 fehlt'.
value labels 	quartal				
	'1' '1. Quartal'
	'2' '2. Quartal'
	'3' '3. Quartal'
	'4' '4. Quartal'.
value labels 	selbtag				
	'-2' 'trifft nicht zu'
	'1' 'ja'
	'2' 'nein'.

*			  (III) ZVE 13 sum		
*					 (iv) Speichern als SPSS-Datei.

SAVE outfile=!Pfad3+!Dateiname3.


*			  (V) ZVE 13 takt		
*					 (i) Einlesen CSV-Datei

GET DATA
 /TYPE=TXT
 /FILE=!Pfad4+!CSVdatei4
 /DELCASE=LINE
 /DELIMITERS=";"
 /ARRANGEMENT=DELIMITED
 /FIRSTCASE=2
 /IMPORTCASE=ALL
 /VARIABLES=
 id_hhx F4.0
 id_persx F5.0
 id_tagx F6.0
 persx F1.0
 tagnr F1.0
 berichtsjahr F4.0
 tb1_1 F3.0
 tb2_1 F3.0
 tb3_1 F2.0
 tb4_1 F1.0
 tb5_1 F1.0
 tb6_1 F1.0
 tb7_1 F1.0
 tb8_1 F1.0
 tb9_1 F1.0
 tb1_2 F3.0
 tb2_2 F3.0
 tb3_2 F2.0
 tb4_2 F1.0
 tb5_2 F1.0
 tb6_2 F1.0
 tb7_2 F1.0
 tb8_2 F1.0
 tb9_2 F1.0
 tb1_3 F3.0
 tb2_3 F3.0
 tb3_3 F2.0
 tb4_3 F1.0
 tb5_3 F1.0
 tb6_3 F1.0
 tb7_3 F1.0
 tb8_3 F1.0
 tb9_3 F1.0
 tb1_4 F3.0
 tb2_4 F3.0
 tb3_4 F2.0
 tb4_4 F1.0
 tb5_4 F1.0
 tb6_4 F1.0
 tb7_4 F1.0
 tb8_4 F1.0
 tb9_4 F1.0
 tb1_5 F3.0
 tb2_5 F3.0
 tb3_5 F2.0
 tb4_5 F1.0
 tb5_5 F1.0
 tb6_5 F1.0
 tb7_5 F1.0
 tb8_5 F1.0
 tb9_5 F1.0
 tb1_6 F3.0
 tb2_6 F3.0
 tb3_6 F2.0
 tb4_6 F1.0
 tb5_6 F1.0
 tb6_6 F1.0
 tb7_6 F1.0
 tb8_6 F1.0
 tb9_6 F1.0
 tb1_7 F3.0
 tb2_7 F3.0
 tb3_7 F2.0
 tb4_7 F1.0
 tb5_7 F1.0
 tb6_7 F1.0
 tb7_7 F1.0
 tb8_7 F1.0
 tb9_7 F1.0
 tb1_8 F3.0
 tb2_8 F3.0
 tb3_8 F2.0
 tb4_8 F1.0
 tb5_8 F1.0
 tb6_8 F1.0
 tb7_8 F1.0
 tb8_8 F1.0
 tb9_8 F1.0
 tb1_9 F3.0
 tb2_9 F3.0
 tb3_9 F2.0
 tb4_9 F1.0
 tb5_9 F1.0
 tb6_9 F1.0
 tb7_9 F1.0
 tb8_9 F1.0
 tb9_9 F1.0
 tb1_10 F3.0
 tb2_10 F3.0
 tb3_10 F2.0
 tb4_10 F1.0
 tb5_10 F1.0
 tb6_10 F1.0
 tb7_10 F1.0
 tb8_10 F1.0
 tb9_10 F1.0
 tb1_11 F3.0
 tb2_11 F3.0
 tb3_11 F2.0
 tb4_11 F1.0
 tb5_11 F1.0
 tb6_11 F1.0
 tb7_11 F1.0
 tb8_11 F1.0
 tb9_11 F1.0
 tb1_12 F3.0
 tb2_12 F3.0
 tb3_12 F2.0
 tb4_12 F1.0
 tb5_12 F1.0
 tb6_12 F1.0
 tb7_12 F1.0
 tb8_12 F1.0
 tb9_12 F1.0
 tb1_13 F3.0
 tb2_13 F3.0
 tb3_13 F2.0
 tb4_13 F1.0
 tb5_13 F1.0
 tb6_13 F1.0
 tb7_13 F1.0
 tb8_13 F1.0
 tb9_13 F1.0
 tb1_14 F3.0
 tb2_14 F3.0
 tb3_14 F2.0
 tb4_14 F1.0
 tb5_14 F1.0
 tb6_14 F1.0
 tb7_14 F1.0
 tb8_14 F1.0
 tb9_14 F1.0
 tb1_15 F3.0
 tb2_15 F3.0
 tb3_15 F2.0
 tb4_15 F1.0
 tb5_15 F1.0
 tb6_15 F1.0
 tb7_15 F1.0
 tb8_15 F1.0
 tb9_15 F1.0
 tb1_16 F3.0
 tb2_16 F3.0
 tb3_16 F2.0
 tb4_16 F1.0
 tb5_16 F1.0
 tb6_16 F1.0
 tb7_16 F1.0
 tb8_16 F1.0
 tb9_16 F1.0
 tb1_17 F3.0
 tb2_17 F3.0
 tb3_17 F2.0
 tb4_17 F1.0
 tb5_17 F1.0
 tb6_17 F1.0
 tb7_17 F1.0
 tb8_17 F1.0
 tb9_17 F1.0
 tb1_18 F3.0
 tb2_18 F3.0
 tb3_18 F2.0
 tb4_18 F1.0
 tb5_18 F1.0
 tb6_18 F1.0
 tb7_18 F1.0
 tb8_18 F1.0
 tb9_18 F1.0
 tb1_19 F3.0
 tb2_19 F3.0
 tb3_19 F2.0
 tb4_19 F1.0
 tb5_19 F1.0
 tb6_19 F1.0
 tb7_19 F1.0
 tb8_19 F1.0
 tb9_19 F1.0
 tb1_20 F3.0
 tb2_20 F3.0
 tb3_20 F2.0
 tb4_20 F1.0
 tb5_20 F1.0
 tb6_20 F1.0
 tb7_20 F1.0
 tb8_20 F1.0
 tb9_20 F1.0
 tb1_21 F3.0
 tb2_21 F3.0
 tb3_21 F2.0
 tb4_21 F1.0
 tb5_21 F1.0
 tb6_21 F1.0
 tb7_21 F1.0
 tb8_21 F1.0
 tb9_21 F1.0
 tb1_22 F3.0
 tb2_22 F3.0
 tb3_22 F2.0
 tb4_22 F1.0
 tb5_22 F1.0
 tb6_22 F1.0
 tb7_22 F1.0
 tb8_22 F1.0
 tb9_22 F1.0
 tb1_23 F3.0
 tb2_23 F3.0
 tb3_23 F2.0
 tb4_23 F1.0
 tb5_23 F1.0
 tb6_23 F1.0
 tb7_23 F1.0
 tb8_23 F1.0
 tb9_23 F1.0
 tb1_24 F3.0
 tb2_24 F3.0
 tb3_24 F2.0
 tb4_24 F1.0
 tb5_24 F1.0
 tb6_24 F1.0
 tb7_24 F1.0
 tb8_24 F1.0
 tb9_24 F1.0
 tb1_25 F3.0
 tb2_25 F3.0
 tb3_25 F2.0
 tb4_25 F1.0
 tb5_25 F1.0
 tb6_25 F1.0
 tb7_25 F1.0
 tb8_25 F1.0
 tb9_25 F1.0
 tb1_26 F3.0
 tb2_26 F3.0
 tb3_26 F2.0
 tb4_26 F1.0
 tb5_26 F1.0
 tb6_26 F1.0
 tb7_26 F1.0
 tb8_26 F1.0
 tb9_26 F1.0
 tb1_27 F3.0
 tb2_27 F3.0
 tb3_27 F2.0
 tb4_27 F1.0
 tb5_27 F1.0
 tb6_27 F1.0
 tb7_27 F1.0
 tb8_27 F1.0
 tb9_27 F1.0
 tb1_28 F3.0
 tb2_28 F3.0
 tb3_28 F2.0
 tb4_28 F1.0
 tb5_28 F1.0
 tb6_28 F1.0
 tb7_28 F1.0
 tb8_28 F1.0
 tb9_28 F1.0
 tb1_29 F3.0
 tb2_29 F3.0
 tb3_29 F2.0
 tb4_29 F1.0
 tb5_29 F1.0
 tb6_29 F1.0
 tb7_29 F1.0
 tb8_29 F1.0
 tb9_29 F1.0
 tb1_30 F3.0
 tb2_30 F3.0
 tb3_30 F2.0
 tb4_30 F1.0
 tb5_30 F1.0
 tb6_30 F1.0
 tb7_30 F1.0
 tb8_30 F1.0
 tb9_30 F1.0
 tb1_31 F3.0
 tb2_31 F3.0
 tb3_31 F2.0
 tb4_31 F1.0
 tb5_31 F1.0
 tb6_31 F1.0
 tb7_31 F1.0
 tb8_31 F1.0
 tb9_31 F1.0
 tb1_32 F3.0
 tb2_32 F3.0
 tb3_32 F2.0
 tb4_32 F1.0
 tb5_32 F1.0
 tb6_32 F1.0
 tb7_32 F1.0
 tb8_32 F1.0
 tb9_32 F1.0
 tb1_33 F3.0
 tb2_33 F3.0
 tb3_33 F2.0
 tb4_33 F1.0
 tb5_33 F1.0
 tb6_33 F1.0
 tb7_33 F1.0
 tb8_33 F1.0
 tb9_33 F1.0
 tb1_34 F3.0
 tb2_34 F3.0
 tb3_34 F2.0
 tb4_34 F1.0
 tb5_34 F1.0
 tb6_34 F1.0
 tb7_34 F1.0
 tb8_34 F1.0
 tb9_34 F1.0
 tb1_35 F3.0
 tb2_35 F3.0
 tb3_35 F2.0
 tb4_35 F1.0
 tb5_35 F1.0
 tb6_35 F1.0
 tb7_35 F1.0
 tb8_35 F1.0
 tb9_35 F1.0
 tb1_36 F3.0
 tb2_36 F3.0
 tb3_36 F2.0
 tb4_36 F1.0
 tb5_36 F1.0
 tb6_36 F1.0
 tb7_36 F1.0
 tb8_36 F1.0
 tb9_36 F1.0
 tb1_37 F3.0
 tb2_37 F3.0
 tb3_37 F2.0
 tb4_37 F1.0
 tb5_37 F1.0
 tb6_37 F1.0
 tb7_37 F1.0
 tb8_37 F1.0
 tb9_37 F1.0
 tb1_38 F3.0
 tb2_38 F3.0
 tb3_38 F2.0
 tb4_38 F1.0
 tb5_38 F1.0
 tb6_38 F1.0
 tb7_38 F1.0
 tb8_38 F1.0
 tb9_38 F1.0
 tb1_39 F3.0
 tb2_39 F3.0
 tb3_39 F2.0
 tb4_39 F1.0
 tb5_39 F1.0
 tb6_39 F1.0
 tb7_39 F1.0
 tb8_39 F1.0
 tb9_39 F1.0
 tb1_40 F3.0
 tb2_40 F3.0
 tb3_40 F2.0
 tb4_40 F1.0
 tb5_40 F1.0
 tb6_40 F1.0
 tb7_40 F1.0
 tb8_40 F1.0
 tb9_40 F1.0
 tb1_41 F3.0
 tb2_41 F3.0
 tb3_41 F2.0
 tb4_41 F1.0
 tb5_41 F1.0
 tb6_41 F1.0
 tb7_41 F1.0
 tb8_41 F1.0
 tb9_41 F1.0
 tb1_42 F3.0
 tb2_42 F3.0
 tb3_42 F2.0
 tb4_42 F1.0
 tb5_42 F1.0
 tb6_42 F1.0
 tb7_42 F1.0
 tb8_42 F1.0
 tb9_42 F1.0
 tb1_43 F3.0
 tb2_43 F3.0
 tb3_43 F2.0
 tb4_43 F1.0
 tb5_43 F1.0
 tb6_43 F1.0
 tb7_43 F1.0
 tb8_43 F1.0
 tb9_43 F1.0
 tb1_44 F3.0
 tb2_44 F3.0
 tb3_44 F2.0
 tb4_44 F1.0
 tb5_44 F1.0
 tb6_44 F1.0
 tb7_44 F1.0
 tb8_44 F1.0
 tb9_44 F1.0
 tb1_45 F3.0
 tb2_45 F3.0
 tb3_45 F2.0
 tb4_45 F1.0
 tb5_45 F1.0
 tb6_45 F1.0
 tb7_45 F1.0
 tb8_45 F1.0
 tb9_45 F1.0
 tb1_46 F3.0
 tb2_46 F3.0
 tb3_46 F2.0
 tb4_46 F1.0
 tb5_46 F1.0
 tb6_46 F1.0
 tb7_46 F1.0
 tb8_46 F1.0
 tb9_46 F1.0
 tb1_47 F3.0
 tb2_47 F3.0
 tb3_47 F2.0
 tb4_47 F1.0
 tb5_47 F1.0
 tb6_47 F1.0
 tb7_47 F1.0
 tb8_47 F1.0
 tb9_47 F1.0
 tb1_48 F3.0
 tb2_48 F3.0
 tb3_48 F2.0
 tb4_48 F1.0
 tb5_48 F1.0
 tb6_48 F1.0
 tb7_48 F1.0
 tb8_48 F1.0
 tb9_48 F1.0
 tb1_49 F3.0
 tb2_49 F3.0
 tb3_49 F2.0
 tb4_49 F1.0
 tb5_49 F1.0
 tb6_49 F1.0
 tb7_49 F1.0
 tb8_49 F1.0
 tb9_49 F1.0
 tb1_50 F3.0
 tb2_50 F3.0
 tb3_50 F2.0
 tb4_50 F1.0
 tb5_50 F1.0
 tb6_50 F1.0
 tb7_50 F1.0
 tb8_50 F1.0
 tb9_50 F1.0
 tb1_51 F3.0
 tb2_51 F3.0
 tb3_51 F2.0
 tb4_51 F1.0
 tb5_51 F1.0
 tb6_51 F1.0
 tb7_51 F1.0
 tb8_51 F1.0
 tb9_51 F1.0
 tb1_52 F3.0
 tb2_52 F3.0
 tb3_52 F2.0
 tb4_52 F1.0
 tb5_52 F1.0
 tb6_52 F1.0
 tb7_52 F1.0
 tb8_52 F1.0
 tb9_52 F1.0
 tb1_53 F3.0
 tb2_53 F3.0
 tb3_53 F2.0
 tb4_53 F1.0
 tb5_53 F1.0
 tb6_53 F1.0
 tb7_53 F1.0
 tb8_53 F1.0
 tb9_53 F1.0
 tb1_54 F3.0
 tb2_54 F3.0
 tb3_54 F2.0
 tb4_54 F1.0
 tb5_54 F1.0
 tb6_54 F1.0
 tb7_54 F1.0
 tb8_54 F1.0
 tb9_54 F1.0
 tb1_55 F3.0
 tb2_55 F3.0
 tb3_55 F2.0
 tb4_55 F1.0
 tb5_55 F1.0
 tb6_55 F1.0
 tb7_55 F1.0
 tb8_55 F1.0
 tb9_55 F1.0
 tb1_56 F3.0
 tb2_56 F3.0
 tb3_56 F2.0
 tb4_56 F1.0
 tb5_56 F1.0
 tb6_56 F1.0
 tb7_56 F1.0
 tb8_56 F1.0
 tb9_56 F1.0
 tb1_57 F3.0
 tb2_57 F3.0
 tb3_57 F2.0
 tb4_57 F1.0
 tb5_57 F1.0
 tb6_57 F1.0
 tb7_57 F1.0
 tb8_57 F1.0
 tb9_57 F1.0
 tb1_58 F3.0
 tb2_58 F3.0
 tb3_58 F2.0
 tb4_58 F1.0
 tb5_58 F1.0
 tb6_58 F1.0
 tb7_58 F1.0
 tb8_58 F1.0
 tb9_58 F1.0
 tb1_59 F3.0
 tb2_59 F3.0
 tb3_59 F2.0
 tb4_59 F1.0
 tb5_59 F1.0
 tb6_59 F1.0
 tb7_59 F1.0
 tb8_59 F1.0
 tb9_59 F1.0
 tb1_60 F3.0
 tb2_60 F3.0
 tb3_60 F2.0
 tb4_60 F1.0
 tb5_60 F1.0
 tb6_60 F1.0
 tb7_60 F1.0
 tb8_60 F1.0
 tb9_60 F1.0
 tb1_61 F3.0
 tb2_61 F3.0
 tb3_61 F2.0
 tb4_61 F1.0
 tb5_61 F1.0
 tb6_61 F1.0
 tb7_61 F1.0
 tb8_61 F1.0
 tb9_61 F1.0
 tb1_62 F3.0
 tb2_62 F3.0
 tb3_62 F2.0
 tb4_62 F1.0
 tb5_62 F1.0
 tb6_62 F1.0
 tb7_62 F1.0
 tb8_62 F1.0
 tb9_62 F1.0
 tb1_63 F3.0
 tb2_63 F3.0
 tb3_63 F2.0
 tb4_63 F1.0
 tb5_63 F1.0
 tb6_63 F1.0
 tb7_63 F1.0
 tb8_63 F1.0
 tb9_63 F1.0
 tb1_64 F3.0
 tb2_64 F3.0
 tb3_64 F2.0
 tb4_64 F1.0
 tb5_64 F1.0
 tb6_64 F1.0
 tb7_64 F1.0
 tb8_64 F1.0
 tb9_64 F1.0
 tb1_65 F3.0
 tb2_65 F3.0
 tb3_65 F2.0
 tb4_65 F1.0
 tb5_65 F1.0
 tb6_65 F1.0
 tb7_65 F1.0
 tb8_65 F1.0
 tb9_65 F1.0
 tb1_66 F3.0
 tb2_66 F3.0
 tb3_66 F2.0
 tb4_66 F1.0
 tb5_66 F1.0
 tb6_66 F1.0
 tb7_66 F1.0
 tb8_66 F1.0
 tb9_66 F1.0
 tb1_67 F3.0
 tb2_67 F3.0
 tb3_67 F2.0
 tb4_67 F1.0
 tb5_67 F1.0
 tb6_67 F1.0
 tb7_67 F1.0
 tb8_67 F1.0
 tb9_67 F1.0
 tb1_68 F3.0
 tb2_68 F3.0
 tb3_68 F2.0
 tb4_68 F1.0
 tb5_68 F1.0
 tb6_68 F1.0
 tb7_68 F1.0
 tb8_68 F1.0
 tb9_68 F1.0
 tb1_69 F3.0
 tb2_69 F3.0
 tb3_69 F2.0
 tb4_69 F1.0
 tb5_69 F1.0
 tb6_69 F1.0
 tb7_69 F1.0
 tb8_69 F1.0
 tb9_69 F1.0
 tb1_70 F3.0
 tb2_70 F3.0
 tb3_70 F2.0
 tb4_70 F1.0
 tb5_70 F1.0
 tb6_70 F1.0
 tb7_70 F1.0
 tb8_70 F1.0
 tb9_70 F1.0
 tb1_71 F3.0
 tb2_71 F3.0
 tb3_71 F2.0
 tb4_71 F1.0
 tb5_71 F1.0
 tb6_71 F1.0
 tb7_71 F1.0
 tb8_71 F1.0
 tb9_71 F1.0
 tb1_72 F3.0
 tb2_72 F3.0
 tb3_72 F2.0
 tb4_72 F1.0
 tb5_72 F1.0
 tb6_72 F1.0
 tb7_72 F1.0
 tb8_72 F1.0
 tb9_72 F1.0
 tb1_73 F3.0
 tb2_73 F3.0
 tb3_73 F2.0
 tb4_73 F1.0
 tb5_73 F1.0
 tb6_73 F1.0
 tb7_73 F1.0
 tb8_73 F1.0
 tb9_73 F1.0
 tb1_74 F3.0
 tb2_74 F3.0
 tb3_74 F2.0
 tb4_74 F1.0
 tb5_74 F1.0
 tb6_74 F1.0
 tb7_74 F1.0
 tb8_74 F1.0
 tb9_74 F1.0
 tb1_75 F3.0
 tb2_75 F3.0
 tb3_75 F2.0
 tb4_75 F1.0
 tb5_75 F1.0
 tb6_75 F1.0
 tb7_75 F1.0
 tb8_75 F1.0
 tb9_75 F1.0
 tb1_76 F3.0
 tb2_76 F3.0
 tb3_76 F2.0
 tb4_76 F1.0
 tb5_76 F1.0
 tb6_76 F1.0
 tb7_76 F1.0
 tb8_76 F1.0
 tb9_76 F1.0
 tb1_77 F3.0
 tb2_77 F3.0
 tb3_77 F2.0
 tb4_77 F1.0
 tb5_77 F1.0
 tb6_77 F1.0
 tb7_77 F1.0
 tb8_77 F1.0
 tb9_77 F1.0
 tb1_78 F3.0
 tb2_78 F3.0
 tb3_78 F2.0
 tb4_78 F1.0
 tb5_78 F1.0
 tb6_78 F1.0
 tb7_78 F1.0
 tb8_78 F1.0
 tb9_78 F1.0
 tb1_79 F3.0
 tb2_79 F3.0
 tb3_79 F2.0
 tb4_79 F1.0
 tb5_79 F1.0
 tb6_79 F1.0
 tb7_79 F1.0
 tb8_79 F1.0
 tb9_79 F1.0
 tb1_80 F3.0
 tb2_80 F3.0
 tb3_80 F2.0
 tb4_80 F1.0
 tb5_80 F1.0
 tb6_80 F1.0
 tb7_80 F1.0
 tb8_80 F1.0
 tb9_80 F1.0
 tb1_81 F3.0
 tb2_81 F3.0
 tb3_81 F2.0
 tb4_81 F1.0
 tb5_81 F1.0
 tb6_81 F1.0
 tb7_81 F1.0
 tb8_81 F1.0
 tb9_81 F1.0
 tb1_82 F3.0
 tb2_82 F3.0
 tb3_82 F2.0
 tb4_82 F1.0
 tb5_82 F1.0
 tb6_82 F1.0
 tb7_82 F1.0
 tb8_82 F1.0
 tb9_82 F1.0
 tb1_83 F3.0
 tb2_83 F3.0
 tb3_83 F2.0
 tb4_83 F1.0
 tb5_83 F1.0
 tb6_83 F1.0
 tb7_83 F1.0
 tb8_83 F1.0
 tb9_83 F1.0
 tb1_84 F3.0
 tb2_84 F3.0
 tb3_84 F2.0
 tb4_84 F1.0
 tb5_84 F1.0
 tb6_84 F1.0
 tb7_84 F1.0
 tb8_84 F1.0
 tb9_84 F1.0
 tb1_85 F3.0
 tb2_85 F3.0
 tb3_85 F2.0
 tb4_85 F1.0
 tb5_85 F1.0
 tb6_85 F1.0
 tb7_85 F1.0
 tb8_85 F1.0
 tb9_85 F1.0
 tb1_86 F3.0
 tb2_86 F3.0
 tb3_86 F2.0
 tb4_86 F1.0
 tb5_86 F1.0
 tb6_86 F1.0
 tb7_86 F1.0
 tb8_86 F1.0
 tb9_86 F1.0
 tb1_87 F3.0
 tb2_87 F3.0
 tb3_87 F2.0
 tb4_87 F1.0
 tb5_87 F1.0
 tb6_87 F1.0
 tb7_87 F1.0
 tb8_87 F1.0
 tb9_87 F1.0
 tb1_88 F3.0
 tb2_88 F3.0
 tb3_88 F2.0
 tb4_88 F1.0
 tb5_88 F1.0
 tb6_88 F1.0
 tb7_88 F1.0
 tb8_88 F1.0
 tb9_88 F1.0
 tb1_89 F3.0
 tb2_89 F3.0
 tb3_89 F2.0
 tb4_89 F1.0
 tb5_89 F1.0
 tb6_89 F1.0
 tb7_89 F1.0
 tb8_89 F1.0
 tb9_89 F1.0
 tb1_90 F3.0
 tb2_90 F3.0
 tb3_90 F2.0
 tb4_90 F1.0
 tb5_90 F1.0
 tb6_90 F1.0
 tb7_90 F1.0
 tb8_90 F1.0
 tb9_90 F1.0
 tb1_91 F3.0
 tb2_91 F3.0
 tb3_91 F2.0
 tb4_91 F1.0
 tb5_91 F1.0
 tb6_91 F1.0
 tb7_91 F1.0
 tb8_91 F1.0
 tb9_91 F1.0
 tb1_92 F3.0
 tb2_92 F3.0
 tb3_92 F2.0
 tb4_92 F1.0
 tb5_92 F1.0
 tb6_92 F1.0
 tb7_92 F1.0
 tb8_92 F1.0
 tb9_92 F1.0
 tb1_93 F3.0
 tb2_93 F3.0
 tb3_93 F2.0
 tb4_93 F1.0
 tb5_93 F1.0
 tb6_93 F1.0
 tb7_93 F1.0
 tb8_93 F1.0
 tb9_93 F1.0
 tb1_94 F3.0
 tb2_94 F3.0
 tb3_94 F2.0
 tb4_94 F1.0
 tb5_94 F1.0
 tb6_94 F1.0
 tb7_94 F1.0
 tb8_94 F1.0
 tb9_94 F1.0
 tb1_95 F3.0
 tb2_95 F3.0
 tb3_95 F2.0
 tb4_95 F1.0
 tb5_95 F1.0
 tb6_95 F1.0
 tb7_95 F1.0
 tb8_95 F1.0
 tb9_95 F1.0
 tb1_96 F3.0
 tb2_96 F3.0
 tb3_96 F2.0
 tb4_96 F1.0
 tb5_96 F1.0
 tb6_96 F1.0
 tb7_96 F1.0
 tb8_96 F1.0
 tb9_96 F1.0
 tb1_97 F3.0
 tb2_97 F3.0
 tb3_97 F2.0
 tb4_97 F1.0
 tb5_97 F1.0
 tb6_97 F1.0
 tb7_97 F1.0
 tb8_97 F1.0
 tb9_97 F1.0
 tb1_98 F3.0
 tb2_98 F3.0
 tb3_98 F2.0
 tb4_98 F1.0
 tb5_98 F1.0
 tb6_98 F1.0
 tb7_98 F1.0
 tb8_98 F1.0
 tb9_98 F1.0
 tb1_99 F3.0
 tb2_99 F3.0
 tb3_99 F2.0
 tb4_99 F1.0
 tb5_99 F1.0
 tb6_99 F1.0
 tb7_99 F1.0
 tb8_99 F1.0
 tb9_99 F1.0
 tb1_100 F3.0
 tb2_100 F3.0
 tb3_100 F2.0
 tb4_100 F1.0
 tb5_100 F1.0
 tb6_100 F1.0
 tb7_100 F1.0
 tb8_100 F1.0
 tb9_100 F1.0
 tb1_101 F3.0
 tb2_101 F3.0
 tb3_101 F2.0
 tb4_101 F1.0
 tb5_101 F1.0
 tb6_101 F1.0
 tb7_101 F1.0
 tb8_101 F1.0
 tb9_101 F1.0
 tb1_102 F3.0
 tb2_102 F3.0
 tb3_102 F2.0
 tb4_102 F1.0
 tb5_102 F1.0
 tb6_102 F1.0
 tb7_102 F1.0
 tb8_102 F1.0
 tb9_102 F1.0
 tb1_103 F3.0
 tb2_103 F3.0
 tb3_103 F2.0
 tb4_103 F1.0
 tb5_103 F1.0
 tb6_103 F1.0
 tb7_103 F1.0
 tb8_103 F1.0
 tb9_103 F1.0
 tb1_104 F3.0
 tb2_104 F3.0
 tb3_104 F2.0
 tb4_104 F1.0
 tb5_104 F1.0
 tb6_104 F1.0
 tb7_104 F1.0
 tb8_104 F1.0
 tb9_104 F1.0
 tb1_105 F3.0
 tb2_105 F3.0
 tb3_105 F2.0
 tb4_105 F1.0
 tb5_105 F1.0
 tb6_105 F1.0
 tb7_105 F1.0
 tb8_105 F1.0
 tb9_105 F1.0
 tb1_106 F3.0
 tb2_106 F3.0
 tb3_106 F2.0
 tb4_106 F1.0
 tb5_106 F1.0
 tb6_106 F1.0
 tb7_106 F1.0
 tb8_106 F1.0
 tb9_106 F1.0
 tb1_107 F3.0
 tb2_107 F3.0
 tb3_107 F2.0
 tb4_107 F1.0
 tb5_107 F1.0
 tb6_107 F1.0
 tb7_107 F1.0
 tb8_107 F1.0
 tb9_107 F1.0
 tb1_108 F3.0
 tb2_108 F3.0
 tb3_108 F2.0
 tb4_108 F1.0
 tb5_108 F1.0
 tb6_108 F1.0
 tb7_108 F1.0
 tb8_108 F1.0
 tb9_108 F1.0
 tb1_109 F3.0
 tb2_109 F3.0
 tb3_109 F2.0
 tb4_109 F1.0
 tb5_109 F1.0
 tb6_109 F1.0
 tb7_109 F1.0
 tb8_109 F1.0
 tb9_109 F1.0
 tb1_110 F3.0
 tb2_110 F3.0
 tb3_110 F2.0
 tb4_110 F1.0
 tb5_110 F1.0
 tb6_110 F1.0
 tb7_110 F1.0
 tb8_110 F1.0
 tb9_110 F1.0
 tb1_111 F3.0
 tb2_111 F3.0
 tb3_111 F2.0
 tb4_111 F1.0
 tb5_111 F1.0
 tb6_111 F1.0
 tb7_111 F1.0
 tb8_111 F1.0
 tb9_111 F1.0
 tb1_112 F3.0
 tb2_112 F3.0
 tb3_112 F2.0
 tb4_112 F1.0
 tb5_112 F1.0
 tb6_112 F1.0
 tb7_112 F1.0
 tb8_112 F1.0
 tb9_112 F1.0
 tb1_113 F3.0
 tb2_113 F3.0
 tb3_113 F2.0
 tb4_113 F1.0
 tb5_113 F1.0
 tb6_113 F1.0
 tb7_113 F1.0
 tb8_113 F1.0
 tb9_113 F1.0
 tb1_114 F3.0
 tb2_114 F3.0
 tb3_114 F2.0
 tb4_114 F1.0
 tb5_114 F1.0
 tb6_114 F1.0
 tb7_114 F1.0
 tb8_114 F1.0
 tb9_114 F1.0
 tb1_115 F3.0
 tb2_115 F3.0
 tb3_115 F2.0
 tb4_115 F1.0
 tb5_115 F1.0
 tb6_115 F1.0
 tb7_115 F1.0
 tb8_115 F1.0
 tb9_115 F1.0
 tb1_116 F3.0
 tb2_116 F3.0
 tb3_116 F2.0
 tb4_116 F1.0
 tb5_116 F1.0
 tb6_116 F1.0
 tb7_116 F1.0
 tb8_116 F1.0
 tb9_116 F1.0
 tb1_117 F3.0
 tb2_117 F3.0
 tb3_117 F2.0
 tb4_117 F1.0
 tb5_117 F1.0
 tb6_117 F1.0
 tb7_117 F1.0
 tb8_117 F1.0
 tb9_117 F1.0
 tb1_118 F3.0
 tb2_118 F3.0
 tb3_118 F2.0
 tb4_118 F1.0
 tb5_118 F1.0
 tb6_118 F1.0
 tb7_118 F1.0
 tb8_118 F1.0
 tb9_118 F1.0
 tb1_119 F3.0
 tb2_119 F3.0
 tb3_119 F2.0
 tb4_119 F1.0
 tb5_119 F1.0
 tb6_119 F1.0
 tb7_119 F1.0
 tb8_119 F1.0
 tb9_119 F1.0
 tb1_120 F3.0
 tb2_120 F3.0
 tb3_120 F2.0
 tb4_120 F1.0
 tb5_120 F1.0
 tb6_120 F1.0
 tb7_120 F1.0
 tb8_120 F1.0
 tb9_120 F1.0
 tb1_121 F3.0
 tb2_121 F3.0
 tb3_121 F2.0
 tb4_121 F1.0
 tb5_121 F1.0
 tb6_121 F1.0
 tb7_121 F1.0
 tb8_121 F1.0
 tb9_121 F1.0
 tb1_122 F3.0
 tb2_122 F3.0
 tb3_122 F2.0
 tb4_122 F1.0
 tb5_122 F1.0
 tb6_122 F1.0
 tb7_122 F1.0
 tb8_122 F1.0
 tb9_122 F1.0
 tb1_123 F3.0
 tb2_123 F3.0
 tb3_123 F2.0
 tb4_123 F1.0
 tb5_123 F1.0
 tb6_123 F1.0
 tb7_123 F1.0
 tb8_123 F1.0
 tb9_123 F1.0
 tb1_124 F3.0
 tb2_124 F3.0
 tb3_124 F2.0
 tb4_124 F1.0
 tb5_124 F1.0
 tb6_124 F1.0
 tb7_124 F1.0
 tb8_124 F1.0
 tb9_124 F1.0
 tb1_125 F3.0
 tb2_125 F3.0
 tb3_125 F2.0
 tb4_125 F1.0
 tb5_125 F1.0
 tb6_125 F1.0
 tb7_125 F1.0
 tb8_125 F1.0
 tb9_125 F1.0
 tb1_126 F3.0
 tb2_126 F3.0
 tb3_126 F2.0
 tb4_126 F1.0
 tb5_126 F1.0
 tb6_126 F1.0
 tb7_126 F1.0
 tb8_126 F1.0
 tb9_126 F1.0
 tb1_127 F3.0
 tb2_127 F3.0
 tb3_127 F2.0
 tb4_127 F1.0
 tb5_127 F1.0
 tb6_127 F1.0
 tb7_127 F1.0
 tb8_127 F1.0
 tb9_127 F1.0
 tb1_128 F3.0
 tb2_128 F3.0
 tb3_128 F2.0
 tb4_128 F1.0
 tb5_128 F1.0
 tb6_128 F1.0
 tb7_128 F1.0
 tb8_128 F1.0
 tb9_128 F1.0
 tb1_129 F3.0
 tb2_129 F3.0
 tb3_129 F2.0
 tb4_129 F1.0
 tb5_129 F1.0
 tb6_129 F1.0
 tb7_129 F1.0
 tb8_129 F1.0
 tb9_129 F1.0
 tb1_130 F3.0
 tb2_130 F3.0
 tb3_130 F2.0
 tb4_130 F1.0
 tb5_130 F1.0
 tb6_130 F1.0
 tb7_130 F1.0
 tb8_130 F1.0
 tb9_130 F1.0
 tb1_131 F3.0
 tb2_131 F3.0
 tb3_131 F2.0
 tb4_131 F1.0
 tb5_131 F1.0
 tb6_131 F1.0
 tb7_131 F1.0
 tb8_131 F1.0
 tb9_131 F1.0
 tb1_132 F3.0
 tb2_132 F3.0
 tb3_132 F2.0
 tb4_132 F1.0
 tb5_132 F1.0
 tb6_132 F1.0
 tb7_132 F1.0
 tb8_132 F1.0
 tb9_132 F1.0
 tb1_133 F3.0
 tb2_133 F3.0
 tb3_133 F2.0
 tb4_133 F1.0
 tb5_133 F1.0
 tb6_133 F1.0
 tb7_133 F1.0
 tb8_133 F1.0
 tb9_133 F1.0
 tb1_134 F3.0
 tb2_134 F3.0
 tb3_134 F2.0
 tb4_134 F1.0
 tb5_134 F1.0
 tb6_134 F1.0
 tb7_134 F1.0
 tb8_134 F1.0
 tb9_134 F1.0
 tb1_135 F3.0
 tb2_135 F3.0
 tb3_135 F2.0
 tb4_135 F1.0
 tb5_135 F1.0
 tb6_135 F1.0
 tb7_135 F1.0
 tb8_135 F1.0
 tb9_135 F1.0
 tb1_136 F3.0
 tb2_136 F3.0
 tb3_136 F2.0
 tb4_136 F1.0
 tb5_136 F1.0
 tb6_136 F1.0
 tb7_136 F1.0
 tb8_136 F1.0
 tb9_136 F1.0
 tb1_137 F3.0
 tb2_137 F3.0
 tb3_137 F2.0
 tb4_137 F1.0
 tb5_137 F1.0
 tb6_137 F1.0
 tb7_137 F1.0
 tb8_137 F1.0
 tb9_137 F1.0
 tb1_138 F3.0
 tb2_138 F3.0
 tb3_138 F2.0
 tb4_138 F1.0
 tb5_138 F1.0
 tb6_138 F1.0
 tb7_138 F1.0
 tb8_138 F1.0
 tb9_138 F1.0
 tb1_139 F3.0
 tb2_139 F3.0
 tb3_139 F2.0
 tb4_139 F1.0
 tb5_139 F1.0
 tb6_139 F1.0
 tb7_139 F1.0
 tb8_139 F1.0
 tb9_139 F1.0
 tb1_140 F3.0
 tb2_140 F3.0
 tb3_140 F2.0
 tb4_140 F1.0
 tb5_140 F1.0
 tb6_140 F1.0
 tb7_140 F1.0
 tb8_140 F1.0
 tb9_140 F1.0
 tb1_141 F3.0
 tb2_141 F3.0
 tb3_141 F2.0
 tb4_141 F1.0
 tb5_141 F1.0
 tb6_141 F1.0
 tb7_141 F1.0
 tb8_141 F1.0
 tb9_141 F1.0
 tb1_142 F3.0
 tb2_142 F3.0
 tb3_142 F2.0
 tb4_142 F1.0
 tb5_142 F1.0
 tb6_142 F1.0
 tb7_142 F1.0
 tb8_142 F1.0
 tb9_142 F1.0
 tb1_143 F3.0
 tb2_143 F3.0
 tb3_143 F2.0
 tb4_143 F1.0
 tb5_143 F1.0
 tb6_143 F1.0
 tb7_143 F1.0
 tb8_143 F1.0
 tb9_143 F1.0
 tb1_144 F3.0
 tb2_144 F3.0
 tb3_144 F2.0
 tb4_144 F1.0
 tb5_144 F1.0
 tb6_144 F1.0
 tb7_144 F1.0
 tb8_144 F1.0
 tb9_144 F1.0
 tc1x F1.0
 tc1ax F3.0
 tc1bx F3.0
 tc1cx F2.0
 tc2x F1.0
 tc2ax F3.0
 tc2bx F3.0
 tc2cx F2.0
 tc3x F1.0
 tc3ax F3.0
 tc3bx F3.0
 tc3cx F2.0
 tc4 F1.0
 tc5 F1.0
 tc6 F2.0
 tc7 F2.0
 tc8 F2.0
 wtagfei F1.0
 fehl_tag F1.0
 quartal F1.0
 jahr F4.0
 selbtag F2.0
 hrft80 F7.0.
CACHE.
EXECUTE.


****(ii) Zuweisen der Variablenlabels.
VARIABLE LABELS
 tb1_1	 'Hauptaktivität 04:00-04:10'
 tb1_2	 'Hauptaktivität 04:10-04:20'
 tb1_3	 'Hauptaktivität 04:20-04:30'
 tb1_4	 'Hauptaktivität 04:30-04:40'
 tb1_5	 'Hauptaktivität 04:40-04:50'
 tb1_6	 'Hauptaktivität 04:50-05:00'
 tb1_7	 'Hauptaktivität 05:00-05:10'
 tb1_8	 'Hauptaktivität 05:10-05:20'
 tb1_9	 'Hauptaktivität 05:20-05:30'
 tb1_10	 'Hauptaktivität 05:30-05:40'
 tb1_11	 'Hauptaktivität 05:40-05:50'
 tb1_12	 'Hauptaktivität 05:50-06:00'
 tb1_13	 'Hauptaktivität 06:00-06:10'
 tb1_14	 'Hauptaktivität 06:10-06:20'
 tb1_15	 'Hauptaktivität 06:20-06:30'
 tb1_16	 'Hauptaktivität 06:30-06:40'
 tb1_17	 'Hauptaktivität 06:40-06:50'
 tb1_18	 'Hauptaktivität 06:50-07:00'
 tb1_19	 'Hauptaktivität 07:00-07:10'
 tb1_20	 'Hauptaktivität 07:10-07:20'
 tb1_21	 'Hauptaktivität 07:20-07:30'
 tb1_22	 'Hauptaktivität 07:30-07:40'
 tb1_23	 'Hauptaktivität 07:40-07:50'
 tb1_24	 'Hauptaktivität 07:50-08:00'
 tb1_25	 'Hauptaktivität 08:00-08:10'
 tb1_26	 'Hauptaktivität 08:10-08:20'
 tb1_27	 'Hauptaktivität 08:20-08:30'
 tb1_28	 'Hauptaktivität 08:30-08:40'
 tb1_29	 'Hauptaktivität 08:40-08:50'
 tb1_30	 'Hauptaktivität 08:50-09:00'
 tb1_31	 'Hauptaktivität 09:00-09:10'
 tb1_32	 'Hauptaktivität 09:10-09:20'
 tb1_33	 'Hauptaktivität 09:20-09:30'
 tb1_34	 'Hauptaktivität 09:30-09:40'
 tb1_35	 'Hauptaktivität 09:40-09:50'
 tb1_36	 'Hauptaktivität 09:50-10:00'
 tb1_37	 'Hauptaktivität 10:00-10:10'
 tb1_38	 'Hauptaktivität 10:10-10:20'
 tb1_39	 'Hauptaktivität 10:20-10:30'
 tb1_40	 'Hauptaktivität 10:30-10:40'
 tb1_41	 'Hauptaktivität 10:40-10:50'
 tb1_42	 'Hauptaktivität 10:50-11:00'
 tb1_43	 'Hauptaktivität 11:00-11:10'
 tb1_44	 'Hauptaktivität 11:10-11:20'
 tb1_45	 'Hauptaktivität 11:20-11:30'
 tb1_46	 'Hauptaktivität 11:30-11:40'
 tb1_47	 'Hauptaktivität 11:40-11:50'
 tb1_48	 'Hauptaktivität 11:50-12:00'
 tb1_49	 'Hauptaktivität 12:00-12:10'
 tb1_50	 'Hauptaktivität 12:10-12:20'
 tb1_51	 'Hauptaktivität 12:20-12:30'
 tb1_52	 'Hauptaktivität 12:30-12:40'
 tb1_53	 'Hauptaktivität 12:40-12:50'
 tb1_54	 'Hauptaktivität 12:50-13:00'
 tb1_55	 'Hauptaktivität 13:00-13:10'
 tb1_56	 'Hauptaktivität 13:10-13:20'
 tb1_57	 'Hauptaktivität 13:20-13:30'
 tb1_58	 'Hauptaktivität 13:30-13:40'
 tb1_59	 'Hauptaktivität 13:40-13:50'
 tb1_60	 'Hauptaktivität 13:50-14:00'
 tb1_61	 'Hauptaktivität 14:00-14:10'
 tb1_62	 'Hauptaktivität 14:10-14:20'
 tb1_63	 'Hauptaktivität 14:20-14:30'
 tb1_64	 'Hauptaktivität 14:30-14:40'
 tb1_65	 'Hauptaktivität 14:40-14:50'
 tb1_66	 'Hauptaktivität 14:50-15:00'
 tb1_67	 'Hauptaktivität 15:00-15:10'
 tb1_68	 'Hauptaktivität 15:10-15:20'
 tb1_69	 'Hauptaktivität 15:20-15:30'
 tb1_70	 'Hauptaktivität 15:30-15:40'
 tb1_71	 'Hauptaktivität 15:40-15:50'
 tb1_72	 'Hauptaktivität 15:50-16:00'
 tb1_73	 'Hauptaktivität 16:00-16:10'
 tb1_74	 'Hauptaktivität 16:10-16:20'
 tb1_75	 'Hauptaktivität 16:20-16:30'
 tb1_76	 'Hauptaktivität 16:30-16:40'
 tb1_77	 'Hauptaktivität 16:40-16:50'
 tb1_78	 'Hauptaktivität 16:50-17:00'
 tb1_79	 'Hauptaktivität 17:00-17:10'
 tb1_80	 'Hauptaktivität 17:10-17:20'
 tb1_81	 'Hauptaktivität 17:20-17:30'
 tb1_82	 'Hauptaktivität 17:30-17:40'
 tb1_83	 'Hauptaktivität 17:40-17:50'
 tb1_84	 'Hauptaktivität 17:50-18:00'
 tb1_85	 'Hauptaktivität 18:00-18:10'
 tb1_86	 'Hauptaktivität 18:10-18:20'
 tb1_87	 'Hauptaktivität 18:20-18:30'
 tb1_88	 'Hauptaktivität 18:30-18:40'
 tb1_89	 'Hauptaktivität 18:40-18:50'
 tb1_90	 'Hauptaktivität 18:50-19:00'
 tb1_91	 'Hauptaktivität 19:00-19:10'
 tb1_92	 'Hauptaktivität 19:10-19:20'
 tb1_93	 'Hauptaktivität 19:20-19:30'
 tb1_94	 'Hauptaktivität 19:30-19:40'
 tb1_95	 'Hauptaktivität 19:40-19:50'
 tb1_96	 'Hauptaktivität 19:50-20:00'
 tb1_97	 'Hauptaktivität 20:00-20:10'
 tb1_98	 'Hauptaktivität 20:10-20:20'
 tb1_99	 'Hauptaktivität 20:20-20:30'
 tb1_100	 'Hauptaktivität 20:30-20:40'
 tb1_101	 'Hauptaktivität 20:40-20:50'
 tb1_102	 'Hauptaktivität 20:50-21:00'
 tb1_103	 'Hauptaktivität 21:00-21:10'
 tb1_104	 'Hauptaktivität 21:10-21:20'
 tb1_105	 'Hauptaktivität 21:20-21:30'
 tb1_106	 'Hauptaktivität 21:30-21:40'
 tb1_107	 'Hauptaktivität 21:40-21:50'
 tb1_108	 'Hauptaktivität 21:50-22:00'
 tb1_109	 'Hauptaktivität 22:00-22:10'
 tb1_110	 'Hauptaktivität 22:10-22:20'
 tb1_111	 'Hauptaktivität 22:20-22:30'
 tb1_112	 'Hauptaktivität 22:30-22:40'
 tb1_113	 'Hauptaktivität 22:40-22:50'
 tb1_114	 'Hauptaktivität 22:50-23:00'
 tb1_115	 'Hauptaktivität 23:00-23:10'
 tb1_116	 'Hauptaktivität 23:10-23:20'
 tb1_117	 'Hauptaktivität 23:20-23:30'
 tb1_118	 'Hauptaktivität 23:30-23:40'
 tb1_119	 'Hauptaktivität 23:40-23:50'
 tb1_120	 'Hauptaktivität 23:50-00:00'
 tb1_121	 'Hauptaktivität 00:00-00:10'
 tb1_122	 'Hauptaktivität 00:10-00:20'
 tb1_123	 'Hauptaktivität 00:20-00:30'
 tb1_124	 'Hauptaktivität 00:30-00:40'
 tb1_125	 'Hauptaktivität 00:40-00:50'
 tb1_126	 'Hauptaktivität 00:50-01:00'
 tb1_127	 'Hauptaktivität 01:00-01:10'
 tb1_128	 'Hauptaktivität 01:10-01:20'
 tb1_129	 'Hauptaktivität 01:20-01:30'
 tb1_130	 'Hauptaktivität 01:30-01:40'
 tb1_131	 'Hauptaktivität 01:40-01:50'
 tb1_132	 'Hauptaktivität 01:50-02:00'
 tb1_133	 'Hauptaktivität 02:00-02:10'
 tb1_134	 'Hauptaktivität 02:10-02:20'
 tb1_135	 'Hauptaktivität 02:20-02:30'
 tb1_136	 'Hauptaktivität 02:30-02:40'
 tb1_137	 'Hauptaktivität 02:40-02:50'
 tb1_138	 'Hauptaktivität 02:50-03:00'
 tb1_139	 'Hauptaktivität 03:00-03:10'
 tb1_140	 'Hauptaktivität 03:10-03:20'
 tb1_141	 'Hauptaktivität 03:20-03:30'
 tb1_142	 'Hauptaktivität 03:30-03:40'
 tb1_143	 'Hauptaktivität 03:40-03:50'
 tb1_144	 'Hauptaktivität 03:50-04:00'
 tb2_1 'Nebenaktivität 04:00-04:10'
 tb2_2 'Nebenaktivität 04:10-04:20'
 tb2_3 'Nebenaktivität 04:20-04:30'
 tb2_4 'Nebenaktivität 04:30-04:40'
 tb2_5 'Nebenaktivität 04:40-04:50'
 tb2_6 'Nebenaktivität 04:50-05:00'
 tb2_7 'Nebenaktivität 05:00-05:10'
 tb2_8 'Nebenaktivität 05:10-05:20'
 tb2_9 'Nebenaktivität 05:20-05:30'
 tb2_10 'Nebenaktivität 05:30-05:40'
 tb2_11 'Nebenaktivität 05:40-05:50'
 tb2_12 'Nebenaktivität 05:50-06:00'
 tb2_13 'Nebenaktivität 06:00-06:10'
 tb2_14 'Nebenaktivität 06:10-06:20'
 tb2_15 'Nebenaktivität 06:20-06:30'
 tb2_16 'Nebenaktivität 06:30-06:40'
 tb2_17 'Nebenaktivität 06:40-06:50'
 tb2_18 'Nebenaktivität 06:50-07:00'
 tb2_19 'Nebenaktivität 07:00-07:10'
 tb2_20 'Nebenaktivität 07:10-07:20'
 tb2_21 'Nebenaktivität 07:20-07:30'
 tb2_22 'Nebenaktivität 07:30-07:40'
 tb2_23 'Nebenaktivität 07:40-07:50'
 tb2_24 'Nebenaktivität 07:50-08:00'
 tb2_25 'Nebenaktivität 08:00-08:10'
 tb2_26 'Nebenaktivität 08:10-08:20'
 tb2_27 'Nebenaktivität 08:20-08:30'
 tb2_28 'Nebenaktivität 08:30-08:40'
 tb2_29 'Nebenaktivität 08:40-08:50'
 tb2_30 'Nebenaktivität 08:50-09:00'
 tb2_31 'Nebenaktivität 09:00-09:10'
 tb2_32 'Nebenaktivität 09:10-09:20'
 tb2_33 'Nebenaktivität 09:20-09:30'
 tb2_34 'Nebenaktivität 09:30-09:40'
 tb2_35 'Nebenaktivität 09:40-09:50'
 tb2_36 'Nebenaktivität 09:50-10:00'
 tb2_37 'Nebenaktivität 10:00-10:10'
 tb2_38 'Nebenaktivität 10:10-10:20'
 tb2_39 'Nebenaktivität 10:20-10:30'
 tb2_40 'Nebenaktivität 10:30-10:40'
 tb2_41 'Nebenaktivität 10:40-10:50'
 tb2_42 'Nebenaktivität 10:50-11:00'
 tb2_43 'Nebenaktivität 11:00-11:10'
 tb2_44 'Nebenaktivität 11:10-11:20'
 tb2_45 'Nebenaktivität 11:20-11:30'
 tb2_46 'Nebenaktivität 11:30-11:40'
 tb2_47 'Nebenaktivität 11:40-11:50'
 tb2_48 'Nebenaktivität 11:50-12:00'
 tb2_49 'Nebenaktivität 12:00-12:10'
 tb2_50 'Nebenaktivität 12:10-12:20'
 tb2_51 'Nebenaktivität 12:20-12:30'
 tb2_52 'Nebenaktivität 12:30-12:40'
 tb2_53 'Nebenaktivität 12:40-12:50'
 tb2_54 'Nebenaktivität 12:50-13:00'
 tb2_55 'Nebenaktivität 13:00-13:10'
 tb2_56 'Nebenaktivität 13:10-13:20'
 tb2_57 'Nebenaktivität 13:20-13:30'
 tb2_58 'Nebenaktivität 13:30-13:40'
 tb2_59 'Nebenaktivität 13:40-13:50'
 tb2_60 'Nebenaktivität 13:50-14:00'
 tb2_61 'Nebenaktivität 14:00-14:10'
 tb2_62 'Nebenaktivität 14:10-14:20'
 tb2_63 'Nebenaktivität 14:20-14:30'
 tb2_64 'Nebenaktivität 14:30-14:40'
 tb2_65 'Nebenaktivität 14:40-14:50'
 tb2_66 'Nebenaktivität 14:50-15:00'
 tb2_67 'Nebenaktivität 15:00-15:10'
 tb2_68 'Nebenaktivität 15:10-15:20'
 tb2_69 'Nebenaktivität 15:20-15:30'
 tb2_70 'Nebenaktivität 15:30-15:40'
 tb2_71 'Nebenaktivität 15:40-15:50'
 tb2_72 'Nebenaktivität 15:50-16:00'
 tb2_73 'Nebenaktivität 16:00-16:10'
 tb2_74 'Nebenaktivität 16:10-16:20'
 tb2_75 'Nebenaktivität 16:20-16:30'
 tb2_76 'Nebenaktivität 16:30-16:40'
 tb2_77 'Nebenaktivität 16:40-16:50'
 tb2_78 'Nebenaktivität 16:50-17:00'
 tb2_79 'Nebenaktivität 17:00-17:10'
 tb2_80 'Nebenaktivität 17:10-17:20'
 tb2_81 'Nebenaktivität 17:20-17:30'
 tb2_82 'Nebenaktivität 17:30-17:40'
 tb2_83 'Nebenaktivität 17:40-17:50'
 tb2_84 'Nebenaktivität 17:50-18:00'
 tb2_85 'Nebenaktivität 18:00-18:10'
 tb2_86 'Nebenaktivität 18:10-18:20'
 tb2_87 'Nebenaktivität 18:20-18:30'
 tb2_88 'Nebenaktivität 18:30-18:40'
 tb2_89 'Nebenaktivität 18:40-18:50'
 tb2_90 'Nebenaktivität 18:50-19:00'
 tb2_91 'Nebenaktivität 19:00-19:10'
 tb2_92 'Nebenaktivität 19:10-19:20'
 tb2_93 'Nebenaktivität 19:20-19:30'
 tb2_94 'Nebenaktivität 19:30-19:40'
 tb2_95 'Nebenaktivität 19:40-19:50'
 tb2_96 'Nebenaktivität 19:50-20:00'
 tb2_97 'Nebenaktivität 20:00-20:10'
 tb2_98 'Nebenaktivität 20:10-20:20'
 tb2_99 'Nebenaktivität 20:20-20:30'
 tb2_100 'Nebenaktivität 20:30-20:40'
 tb2_101 'Nebenaktivität 20:40-20:50'
 tb2_102 'Nebenaktivität 20:50-21:00'
 tb2_103 'Nebenaktivität 21:00-21:10'
 tb2_104 'Nebenaktivität 21:10-21:20'
 tb2_105 'Nebenaktivität 21:20-21:30'
 tb2_106 'Nebenaktivität 21:30-21:40'
 tb2_107 'Nebenaktivität 21:40-21:50'
 tb2_108 'Nebenaktivität 21:50-22:00'
 tb2_109 'Nebenaktivität 22:00-22:10'
 tb2_110 'Nebenaktivität 22:10-22:20'
 tb2_111 'Nebenaktivität 22:20-22:30'
 tb2_112 'Nebenaktivität 22:30-22:40'
 tb2_113 'Nebenaktivität 22:40-22:50'
 tb2_114 'Nebenaktivität 22:50-23:00'
 tb2_115 'Nebenaktivität 23:00-23:10'
 tb2_116 'Nebenaktivität 23:10-23:20'
 tb2_117 'Nebenaktivität 23:20-23:30'
 tb2_118 'Nebenaktivität 23:30-23:40'
 tb2_119 'Nebenaktivität 23:40-23:50'
 tb2_120 'Nebenaktivität 23:50-00:00'
 tb2_121 'Nebenaktivität 00:00-00:10'
 tb2_122 'Nebenaktivität 00:10-00:20'
 tb2_123 'Nebenaktivität 00:20-00:30'
 tb2_124 'Nebenaktivität 00:30-00:40'
 tb2_125 'Nebenaktivität 00:40-00:50'
 tb2_126 'Nebenaktivität 00:50-01:00'
 tb2_127 'Nebenaktivität 01:00-01:10'
 tb2_128 'Nebenaktivität 01:10-01:20'
 tb2_129 'Nebenaktivität 01:20-01:30'
 tb2_130 'Nebenaktivität 01:30-01:40'
 tb2_131 'Nebenaktivität 01:40-01:50'
 tb2_132 'Nebenaktivität 01:50-02:00'
 tb2_133 'Nebenaktivität 02:00-02:10'
 tb2_134 'Nebenaktivität 02:10-02:20'
 tb2_135 'Nebenaktivität 02:20-02:30'
 tb2_136 'Nebenaktivität 02:30-02:40'
 tb2_137 'Nebenaktivität 02:40-02:50'
 tb2_138 'Nebenaktivität 02:50-03:00'
 tb2_139 'Nebenaktivität 03:00-03:10'
 tb2_140 'Nebenaktivität 03:10-03:20'
 tb2_141 'Nebenaktivität 03:20-03:30'
 tb2_142 'Nebenaktivität 03:30-03:40'
 tb2_143 'Nebenaktivität 03:40-03:50'
 tb2_144 'Nebenaktivität 03:50-04:00'
 tb3_1 'Verkehrsmittel 04:00-04:10'
 tb3_2 'Verkehrsmittel 04:10-04:20'
 tb3_3 'Verkehrsmittel 04:20-04:30'
 tb3_4 'Verkehrsmittel 04:30-04:40'
 tb3_5 'Verkehrsmittel 04:40-04:50'
 tb3_6 'Verkehrsmittel 04:50-05:00'
 tb3_7 'Verkehrsmittel 05:00-05:10'
 tb3_8 'Verkehrsmittel 05:10-05:20'
 tb3_9 'Verkehrsmittel 05:20-05:30'
 tb3_10 'Verkehrsmittel 05:30-05:40'
 tb3_11 'Verkehrsmittel 05:40-05:50'
 tb3_12 'Verkehrsmittel 05:50-06:00'
 tb3_13 'Verkehrsmittel 06:00-06:10'
 tb3_14 'Verkehrsmittel 06:10-06:20'
 tb3_15 'Verkehrsmittel 06:20-06:30'
 tb3_16 'Verkehrsmittel 06:30-06:40'
 tb3_17 'Verkehrsmittel 06:40-06:50'
 tb3_18 'Verkehrsmittel 06:50-07:00'
 tb3_19 'Verkehrsmittel 07:00-07:10'
 tb3_20 'Verkehrsmittel 07:10-07:20'
 tb3_21 'Verkehrsmittel 07:20-07:30'
 tb3_22 'Verkehrsmittel 07:30-07:40'
 tb3_23 'Verkehrsmittel 07:40-07:50'
 tb3_24 'Verkehrsmittel 07:50-08:00'
 tb3_25 'Verkehrsmittel 08:00-08:10'
 tb3_26 'Verkehrsmittel 08:10-08:20'
 tb3_27 'Verkehrsmittel 08:20-08:30'
 tb3_28 'Verkehrsmittel 08:30-08:40'
 tb3_29 'Verkehrsmittel 08:40-08:50'
 tb3_30 'Verkehrsmittel 08:50-09:00'
 tb3_31 'Verkehrsmittel 09:00-09:10'
 tb3_32 'Verkehrsmittel 09:10-09:20'
 tb3_33 'Verkehrsmittel 09:20-09:30'
 tb3_34 'Verkehrsmittel 09:30-09:40'
 tb3_35 'Verkehrsmittel 09:40-09:50'
 tb3_36 'Verkehrsmittel 09:50-10:00'
 tb3_37 'Verkehrsmittel 10:00-10:10'
 tb3_38 'Verkehrsmittel 10:10-10:20'
 tb3_39 'Verkehrsmittel 10:20-10:30'
 tb3_40 'Verkehrsmittel 10:30-10:40'
 tb3_41 'Verkehrsmittel 10:40-10:50'
 tb3_42 'Verkehrsmittel 10:50-11:00'
 tb3_43 'Verkehrsmittel 11:00-11:10'
 tb3_44 'Verkehrsmittel 11:10-11:20'
 tb3_45 'Verkehrsmittel 11:20-11:30'
 tb3_46 'Verkehrsmittel 11:30-11:40'
 tb3_47 'Verkehrsmittel 11:40-11:50'
 tb3_48 'Verkehrsmittel 11:50-12:00'
 tb3_49 'Verkehrsmittel 12:00-12:10'
 tb3_50 'Verkehrsmittel 12:10-12:20'
 tb3_51 'Verkehrsmittel 12:20-12:30'
 tb3_52 'Verkehrsmittel 12:30-12:40'
 tb3_53 'Verkehrsmittel 12:40-12:50'
 tb3_54 'Verkehrsmittel 12:50-13:00'
 tb3_55 'Verkehrsmittel 13:00-13:10'
 tb3_56 'Verkehrsmittel 13:10-13:20'
 tb3_57 'Verkehrsmittel 13:20-13:30'
 tb3_58 'Verkehrsmittel 13:30-13:40'
 tb3_59 'Verkehrsmittel 13:40-13:50'
 tb3_60 'Verkehrsmittel 13:50-14:00'
 tb3_61 'Verkehrsmittel 14:00-14:10'
 tb3_62 'Verkehrsmittel 14:10-14:20'
 tb3_63 'Verkehrsmittel 14:20-14:30'
 tb3_64 'Verkehrsmittel 14:30-14:40'
 tb3_65 'Verkehrsmittel 14:40-14:50'
 tb3_66 'Verkehrsmittel 14:50-15:00'
 tb3_67 'Verkehrsmittel 15:00-15:10'
 tb3_68 'Verkehrsmittel 15:10-15:20'
 tb3_69 'Verkehrsmittel 15:20-15:30'
 tb3_70 'Verkehrsmittel 15:30-15:40'
 tb3_71 'Verkehrsmittel 15:40-15:50'
 tb3_72 'Verkehrsmittel 15:50-16:00'
 tb3_73 'Verkehrsmittel 16:00-16:10'
 tb3_74 'Verkehrsmittel 16:10-16:20'
 tb3_75 'Verkehrsmittel 16:20-16:30'
 tb3_76 'Verkehrsmittel 16:30-16:40'
 tb3_77 'Verkehrsmittel 16:40-16:50'
 tb3_78 'Verkehrsmittel 16:50-17:00'
 tb3_79 'Verkehrsmittel 17:00-17:10'
 tb3_80 'Verkehrsmittel 17:10-17:20'
 tb3_81 'Verkehrsmittel 17:20-17:30'
 tb3_82 'Verkehrsmittel 17:30-17:40'
 tb3_83 'Verkehrsmittel 17:40-17:50'
 tb3_84 'Verkehrsmittel 17:50-18:00'
 tb3_85 'Verkehrsmittel 18:00-18:10'
 tb3_86 'Verkehrsmittel 18:10-18:20'
 tb3_87 'Verkehrsmittel 18:20-18:30'
 tb3_88 'Verkehrsmittel 18:30-18:40'
 tb3_89 'Verkehrsmittel 18:40-18:50'
 tb3_90 'Verkehrsmittel 18:50-19:00'
 tb3_91 'Verkehrsmittel 19:00-19:10'
 tb3_92 'Verkehrsmittel 19:10-19:20'
 tb3_93 'Verkehrsmittel 19:20-19:30'
 tb3_94 'Verkehrsmittel 19:30-19:40'
 tb3_95 'Verkehrsmittel 19:40-19:50'
 tb3_96 'Verkehrsmittel 19:50-20:00'
 tb3_97 'Verkehrsmittel 20:00-20:10'
 tb3_98 'Verkehrsmittel 20:10-20:20'
 tb3_99 'Verkehrsmittel 20:20-20:30'
 tb3_100 'Verkehrsmittel 20:30-20:40'
 tb3_101 'Verkehrsmittel 20:40-20:50'
 tb3_102 'Verkehrsmittel 20:50-21:00'
 tb3_103 'Verkehrsmittel 21:00-21:10'
 tb3_104 'Verkehrsmittel 21:10-21:20'
 tb3_105 'Verkehrsmittel 21:20-21:30'
 tb3_106 'Verkehrsmittel 21:30-21:40'
 tb3_107 'Verkehrsmittel 21:40-21:50'
 tb3_108 'Verkehrsmittel 21:50-22:00'
 tb3_109 'Verkehrsmittel 22:00-22:10'
 tb3_110 'Verkehrsmittel 22:10-22:20'
 tb3_111 'Verkehrsmittel 22:20-22:30'
 tb3_112 'Verkehrsmittel 22:30-22:40'
 tb3_113 'Verkehrsmittel 22:40-22:50'
 tb3_114 'Verkehrsmittel 22:50-23:00'
 tb3_115 'Verkehrsmittel 23:00-23:10'
 tb3_116 'Verkehrsmittel 23:10-23:20'
 tb3_117 'Verkehrsmittel 23:20-23:30'
 tb3_118 'Verkehrsmittel 23:30-23:40'
 tb3_119 'Verkehrsmittel 23:40-23:50'
 tb3_120 'Verkehrsmittel 23:50-00:00'
 tb3_121 'Verkehrsmittel 00:00-00:10'
 tb3_122 'Verkehrsmittel 00:10-00:20'
 tb3_123 'Verkehrsmittel 00:20-00:30'
 tb3_124 'Verkehrsmittel 00:30-00:40'
 tb3_125 'Verkehrsmittel 00:40-00:50'
 tb3_126 'Verkehrsmittel 00:50-01:00'
 tb3_127 'Verkehrsmittel 01:00-01:10'
 tb3_128 'Verkehrsmittel 01:10-01:20'
 tb3_129 'Verkehrsmittel 01:20-01:30'
 tb3_130 'Verkehrsmittel 01:30-01:40'
 tb3_131 'Verkehrsmittel 01:40-01:50'
 tb3_132 'Verkehrsmittel 01:50-02:00'
 tb3_133 'Verkehrsmittel 02:00-02:10'
 tb3_134 'Verkehrsmittel 02:10-02:20'
 tb3_135 'Verkehrsmittel 02:20-02:30'
 tb3_136 'Verkehrsmittel 02:30-02:40'
 tb3_137 'Verkehrsmittel 02:40-02:50'
 tb3_138 'Verkehrsmittel 02:50-03:00'
 tb3_139 'Verkehrsmittel 03:00-03:10'
 tb3_140 'Verkehrsmittel 03:10-03:20'
 tb3_141 'Verkehrsmittel 03:20-03:30'
 tb3_142 'Verkehrsmittel 03:30-03:40'
 tb3_143 'Verkehrsmittel 03:40-03:50'
 tb3_144 'Verkehrsmittel 03:50-04:00'
 tb4_1 'Mit-Wem-Spalte nicht ausgefüllt 04:00-04:10'
 tb4_2 'Mit-Wem-Spalte nicht ausgefüllt 04:10-04:20'
 tb4_3 'Mit-Wem-Spalte nicht ausgefüllt 04:20-04:30'
 tb4_4 'Mit-Wem-Spalte nicht ausgefüllt 04:30-04:40'
 tb4_5 'Mit-Wem-Spalte nicht ausgefüllt 04:40-04:50'
 tb4_6 'Mit-Wem-Spalte nicht ausgefüllt 04:50-05:00'
 tb4_7 'Mit-Wem-Spalte nicht ausgefüllt 05:00-05:10'
 tb4_8 'Mit-Wem-Spalte nicht ausgefüllt 05:10-05:20'
 tb4_9 'Mit-Wem-Spalte nicht ausgefüllt 05:20-05:30'
 tb4_10 'Mit-Wem-Spalte nicht ausgefüllt 05:30-05:40'
 tb4_11 'Mit-Wem-Spalte nicht ausgefüllt 05:40-05:50'
 tb4_12 'Mit-Wem-Spalte nicht ausgefüllt 05:50-06:00'
 tb4_13 'Mit-Wem-Spalte nicht ausgefüllt 06:00-06:10'
 tb4_14 'Mit-Wem-Spalte nicht ausgefüllt 06:10-06:20'
 tb4_15 'Mit-Wem-Spalte nicht ausgefüllt 06:20-06:30'
 tb4_16 'Mit-Wem-Spalte nicht ausgefüllt 06:30-06:40'
 tb4_17 'Mit-Wem-Spalte nicht ausgefüllt 06:40-06:50'
 tb4_18 'Mit-Wem-Spalte nicht ausgefüllt 06:50-07:00'
 tb4_19 'Mit-Wem-Spalte nicht ausgefüllt 07:00-07:10'
 tb4_20 'Mit-Wem-Spalte nicht ausgefüllt 07:10-07:20'
 tb4_21 'Mit-Wem-Spalte nicht ausgefüllt 07:20-07:30'
 tb4_22 'Mit-Wem-Spalte nicht ausgefüllt 07:30-07:40'
 tb4_23 'Mit-Wem-Spalte nicht ausgefüllt 07:40-07:50'
 tb4_24 'Mit-Wem-Spalte nicht ausgefüllt 07:50-08:00'
 tb4_25 'Mit-Wem-Spalte nicht ausgefüllt 08:00-08:10'
 tb4_26 'Mit-Wem-Spalte nicht ausgefüllt 08:10-08:20'
 tb4_27 'Mit-Wem-Spalte nicht ausgefüllt 08:20-08:30'
 tb4_28 'Mit-Wem-Spalte nicht ausgefüllt 08:30-08:40'
 tb4_29 'Mit-Wem-Spalte nicht ausgefüllt 08:40-08:50'
 tb4_30 'Mit-Wem-Spalte nicht ausgefüllt 08:50-09:00'
 tb4_31 'Mit-Wem-Spalte nicht ausgefüllt 09:00-09:10'
 tb4_32 'Mit-Wem-Spalte nicht ausgefüllt 09:10-09:20'
 tb4_33 'Mit-Wem-Spalte nicht ausgefüllt 09:20-09:30'
 tb4_34 'Mit-Wem-Spalte nicht ausgefüllt 09:30-09:40'
 tb4_35 'Mit-Wem-Spalte nicht ausgefüllt 09:40-09:50'
 tb4_36 'Mit-Wem-Spalte nicht ausgefüllt 09:50-10:00'
 tb4_37 'Mit-Wem-Spalte nicht ausgefüllt 10:00-10:10'
 tb4_38 'Mit-Wem-Spalte nicht ausgefüllt 10:10-10:20'
 tb4_39 'Mit-Wem-Spalte nicht ausgefüllt 10:20-10:30'
 tb4_40 'Mit-Wem-Spalte nicht ausgefüllt 10:30-10:40'
 tb4_41 'Mit-Wem-Spalte nicht ausgefüllt 10:40-10:50'
 tb4_42 'Mit-Wem-Spalte nicht ausgefüllt 10:50-11:00'
 tb4_43 'Mit-Wem-Spalte nicht ausgefüllt 11:00-11:10'
 tb4_44 'Mit-Wem-Spalte nicht ausgefüllt 11:10-11:20'
 tb4_45 'Mit-Wem-Spalte nicht ausgefüllt 11:20-11:30'
 tb4_46 'Mit-Wem-Spalte nicht ausgefüllt 11:30-11:40'
 tb4_47 'Mit-Wem-Spalte nicht ausgefüllt 11:40-11:50'
 tb4_48 'Mit-Wem-Spalte nicht ausgefüllt 11:50-12:00'
 tb4_49 'Mit-Wem-Spalte nicht ausgefüllt 12:00-12:10'
 tb4_50 'Mit-Wem-Spalte nicht ausgefüllt 12:10-12:20'
 tb4_51 'Mit-Wem-Spalte nicht ausgefüllt 12:20-12:30'
 tb4_52 'Mit-Wem-Spalte nicht ausgefüllt 12:30-12:40'
 tb4_53 'Mit-Wem-Spalte nicht ausgefüllt 12:40-12:50'
 tb4_54 'Mit-Wem-Spalte nicht ausgefüllt 12:50-13:00'
 tb4_55 'Mit-Wem-Spalte nicht ausgefüllt 13:00-13:10'
 tb4_56 'Mit-Wem-Spalte nicht ausgefüllt 13:10-13:20'
 tb4_57 'Mit-Wem-Spalte nicht ausgefüllt 13:20-13:30'
 tb4_58 'Mit-Wem-Spalte nicht ausgefüllt 13:30-13:40'
 tb4_59 'Mit-Wem-Spalte nicht ausgefüllt 13:40-13:50'
 tb4_60 'Mit-Wem-Spalte nicht ausgefüllt 13:50-14:00'
 tb4_61 'Mit-Wem-Spalte nicht ausgefüllt 14:00-14:10'
 tb4_62 'Mit-Wem-Spalte nicht ausgefüllt 14:10-14:20'
 tb4_63 'Mit-Wem-Spalte nicht ausgefüllt 14:20-14:30'
 tb4_64 'Mit-Wem-Spalte nicht ausgefüllt 14:30-14:40'
 tb4_65 'Mit-Wem-Spalte nicht ausgefüllt 14:40-14:50'
 tb4_66 'Mit-Wem-Spalte nicht ausgefüllt 14:50-15:00'
 tb4_67 'Mit-Wem-Spalte nicht ausgefüllt 15:00-15:10'
 tb4_68 'Mit-Wem-Spalte nicht ausgefüllt 15:10-15:20'
 tb4_69 'Mit-Wem-Spalte nicht ausgefüllt 15:20-15:30'
 tb4_70 'Mit-Wem-Spalte nicht ausgefüllt 15:30-15:40'
 tb4_71 'Mit-Wem-Spalte nicht ausgefüllt 15:40-15:50'
 tb4_72 'Mit-Wem-Spalte nicht ausgefüllt 15:50-16:00'
 tb4_73 'Mit-Wem-Spalte nicht ausgefüllt 16:00-16:10'
 tb4_74 'Mit-Wem-Spalte nicht ausgefüllt 16:10-16:20'
 tb4_75 'Mit-Wem-Spalte nicht ausgefüllt 16:20-16:30'
 tb4_76 'Mit-Wem-Spalte nicht ausgefüllt 16:30-16:40'
 tb4_77 'Mit-Wem-Spalte nicht ausgefüllt 16:40-16:50'
 tb4_78 'Mit-Wem-Spalte nicht ausgefüllt 16:50-17:00'
 tb4_79 'Mit-Wem-Spalte nicht ausgefüllt 17:00-17:10'
 tb4_80 'Mit-Wem-Spalte nicht ausgefüllt 17:10-17:20'
 tb4_81 'Mit-Wem-Spalte nicht ausgefüllt 17:20-17:30'
 tb4_82 'Mit-Wem-Spalte nicht ausgefüllt 17:30-17:40'
 tb4_83 'Mit-Wem-Spalte nicht ausgefüllt 17:40-17:50'
 tb4_84 'Mit-Wem-Spalte nicht ausgefüllt 17:50-18:00'
 tb4_85 'Mit-Wem-Spalte nicht ausgefüllt 18:00-18:10'
 tb4_86 'Mit-Wem-Spalte nicht ausgefüllt 18:10-18:20'
 tb4_87 'Mit-Wem-Spalte nicht ausgefüllt 18:20-18:30'
 tb4_88 'Mit-Wem-Spalte nicht ausgefüllt 18:30-18:40'
 tb4_89 'Mit-Wem-Spalte nicht ausgefüllt 18:40-18:50'
 tb4_90 'Mit-Wem-Spalte nicht ausgefüllt 18:50-19:00'
 tb4_91 'Mit-Wem-Spalte nicht ausgefüllt 19:00-19:10'
 tb4_92 'Mit-Wem-Spalte nicht ausgefüllt 19:10-19:20'
 tb4_93 'Mit-Wem-Spalte nicht ausgefüllt 19:20-19:30'
 tb4_94 'Mit-Wem-Spalte nicht ausgefüllt 19:30-19:40'
 tb4_95 'Mit-Wem-Spalte nicht ausgefüllt 19:40-19:50'
 tb4_96 'Mit-Wem-Spalte nicht ausgefüllt 19:50-20:00'
 tb4_97 'Mit-Wem-Spalte nicht ausgefüllt 20:00-20:10'
 tb4_98 'Mit-Wem-Spalte nicht ausgefüllt 20:10-20:20'
 tb4_99 'Mit-Wem-Spalte nicht ausgefüllt 20:20-20:30'
 tb4_100 'Mit-Wem-Spalte nicht ausgefüllt 20:30-20:40'
 tb4_101 'Mit-Wem-Spalte nicht ausgefüllt 20:40-20:50'
 tb4_102 'Mit-Wem-Spalte nicht ausgefüllt 20:50-21:00'
 tb4_103 'Mit-Wem-Spalte nicht ausgefüllt 21:00-21:10'
 tb4_104 'Mit-Wem-Spalte nicht ausgefüllt 21:10-21:20'
 tb4_105 'Mit-Wem-Spalte nicht ausgefüllt 21:20-21:30'
 tb4_106 'Mit-Wem-Spalte nicht ausgefüllt 21:30-21:40'
 tb4_107 'Mit-Wem-Spalte nicht ausgefüllt 21:40-21:50'
 tb4_108 'Mit-Wem-Spalte nicht ausgefüllt 21:50-22:00'
 tb4_109 'Mit-Wem-Spalte nicht ausgefüllt 22:00-22:10'
 tb4_110 'Mit-Wem-Spalte nicht ausgefüllt 22:10-22:20'
 tb4_111 'Mit-Wem-Spalte nicht ausgefüllt 22:20-22:30'
 tb4_112 'Mit-Wem-Spalte nicht ausgefüllt 22:30-22:40'
 tb4_113 'Mit-Wem-Spalte nicht ausgefüllt 22:40-22:50'
 tb4_114 'Mit-Wem-Spalte nicht ausgefüllt 22:50-23:00'
 tb4_115 'Mit-Wem-Spalte nicht ausgefüllt 23:00-23:10'
 tb4_116 'Mit-Wem-Spalte nicht ausgefüllt 23:10-23:20'
 tb4_117 'Mit-Wem-Spalte nicht ausgefüllt 23:20-23:30'
 tb4_118 'Mit-Wem-Spalte nicht ausgefüllt 23:30-23:40'
 tb4_119 'Mit-Wem-Spalte nicht ausgefüllt 23:40-23:50'
 tb4_120 'Mit-Wem-Spalte nicht ausgefüllt 23:50-00:00'
 tb4_121 'Mit-Wem-Spalte nicht ausgefüllt 00:00-00:10'
 tb4_122 'Mit-Wem-Spalte nicht ausgefüllt 00:10-00:20'
 tb4_123 'Mit-Wem-Spalte nicht ausgefüllt 00:20-00:30'
 tb4_124 'Mit-Wem-Spalte nicht ausgefüllt 00:30-00:40'
 tb4_125 'Mit-Wem-Spalte nicht ausgefüllt 00:40-00:50'
 tb4_126 'Mit-Wem-Spalte nicht ausgefüllt 00:50-01:00'
 tb4_127 'Mit-Wem-Spalte nicht ausgefüllt 01:00-01:10'
 tb4_128 'Mit-Wem-Spalte nicht ausgefüllt 01:10-01:20'
 tb4_129 'Mit-Wem-Spalte nicht ausgefüllt 01:20-01:30'
 tb4_130 'Mit-Wem-Spalte nicht ausgefüllt 01:30-01:40'
 tb4_131 'Mit-Wem-Spalte nicht ausgefüllt 01:40-01:50'
 tb4_132 'Mit-Wem-Spalte nicht ausgefüllt 01:50-02:00'
 tb4_133 'Mit-Wem-Spalte nicht ausgefüllt 02:00-02:10'
 tb4_134 'Mit-Wem-Spalte nicht ausgefüllt 02:10-02:20'
 tb4_135 'Mit-Wem-Spalte nicht ausgefüllt 02:20-02:30'
 tb4_136 'Mit-Wem-Spalte nicht ausgefüllt 02:30-02:40'
 tb4_137 'Mit-Wem-Spalte nicht ausgefüllt 02:40-02:50'
 tb4_138 'Mit-Wem-Spalte nicht ausgefüllt 02:50-03:00'
 tb4_139 'Mit-Wem-Spalte nicht ausgefüllt 03:00-03:10'
 tb4_140 'Mit-Wem-Spalte nicht ausgefüllt 03:10-03:20'
 tb4_141 'Mit-Wem-Spalte nicht ausgefüllt 03:20-03:30'
 tb4_142 'Mit-Wem-Spalte nicht ausgefüllt 03:30-03:40'
 tb4_143 'Mit-Wem-Spalte nicht ausgefüllt 03:40-03:50'
 tb4_144 'Mit-Wem-Spalte nicht ausgefüllt 03:50-04:00'
 tb5_1 'War allein 04:00-04:10'
 tb5_2 'War allein 04:10-04:20'
 tb5_3 'War allein 04:20-04:30'
 tb5_4 'War allein 04:30-04:40'
 tb5_5 'War allein 04:40-04:50'
 tb5_6 'War allein 04:50-05:00'
 tb5_7 'War allein 05:00-05:10'
 tb5_8 'War allein 05:10-05:20'
 tb5_9 'War allein 05:20-05:30'
 tb5_10 'War allein 05:30-05:40'
 tb5_11 'War allein 05:40-05:50'
 tb5_12 'War allein 05:50-06:00'
 tb5_13 'War allein 06:00-06:10'
 tb5_14 'War allein 06:10-06:20'
 tb5_15 'War allein 06:20-06:30'
 tb5_16 'War allein 06:30-06:40'
 tb5_17 'War allein 06:40-06:50'
 tb5_18 'War allein 06:50-07:00'
 tb5_19 'War allein 07:00-07:10'
 tb5_20 'War allein 07:10-07:20'
 tb5_21 'War allein 07:20-07:30'
 tb5_22 'War allein 07:30-07:40'
 tb5_23 'War allein 07:40-07:50'
 tb5_24 'War allein 07:50-08:00'
 tb5_25 'War allein 08:00-08:10'
 tb5_26 'War allein 08:10-08:20'
 tb5_27 'War allein 08:20-08:30'
 tb5_28 'War allein 08:30-08:40'
 tb5_29 'War allein 08:40-08:50'
 tb5_30 'War allein 08:50-09:00'
 tb5_31 'War allein 09:00-09:10'
 tb5_32 'War allein 09:10-09:20'
 tb5_33 'War allein 09:20-09:30'
 tb5_34 'War allein 09:30-09:40'
 tb5_35 'War allein 09:40-09:50'
 tb5_36 'War allein 09:50-10:00'
 tb5_37 'War allein 10:00-10:10'
 tb5_38 'War allein 10:10-10:20'
 tb5_39 'War allein 10:20-10:30'
 tb5_40 'War allein 10:30-10:40'
 tb5_41 'War allein 10:40-10:50'
 tb5_42 'War allein 10:50-11:00'
 tb5_43 'War allein 11:00-11:10'
 tb5_44 'War allein 11:10-11:20'
 tb5_45 'War allein 11:20-11:30'
 tb5_46 'War allein 11:30-11:40'
 tb5_47 'War allein 11:40-11:50'
 tb5_48 'War allein 11:50-12:00'
 tb5_49 'War allein 12:00-12:10'
 tb5_50 'War allein 12:10-12:20'
 tb5_51 'War allein 12:20-12:30'
 tb5_52 'War allein 12:30-12:40'
 tb5_53 'War allein 12:40-12:50'
 tb5_54 'War allein 12:50-13:00'
 tb5_55 'War allein 13:00-13:10'
 tb5_56 'War allein 13:10-13:20'
 tb5_57 'War allein 13:20-13:30'
 tb5_58 'War allein 13:30-13:40'
 tb5_59 'War allein 13:40-13:50'
 tb5_60 'War allein 13:50-14:00'
 tb5_61 'War allein 14:00-14:10'
 tb5_62 'War allein 14:10-14:20'
 tb5_63 'War allein 14:20-14:30'
 tb5_64 'War allein 14:30-14:40'
 tb5_65 'War allein 14:40-14:50'
 tb5_66 'War allein 14:50-15:00'
 tb5_67 'War allein 15:00-15:10'
 tb5_68 'War allein 15:10-15:20'
 tb5_69 'War allein 15:20-15:30'
 tb5_70 'War allein 15:30-15:40'
 tb5_71 'War allein 15:40-15:50'
 tb5_72 'War allein 15:50-16:00'
 tb5_73 'War allein 16:00-16:10'
 tb5_74 'War allein 16:10-16:20'
 tb5_75 'War allein 16:20-16:30'
 tb5_76 'War allein 16:30-16:40'
 tb5_77 'War allein 16:40-16:50'
 tb5_78 'War allein 16:50-17:00'
 tb5_79 'War allein 17:00-17:10'
 tb5_80 'War allein 17:10-17:20'
 tb5_81 'War allein 17:20-17:30'
 tb5_82 'War allein 17:30-17:40'
 tb5_83 'War allein 17:40-17:50'
 tb5_84 'War allein 17:50-18:00'
 tb5_85 'War allein 18:00-18:10'
 tb5_86 'War allein 18:10-18:20'
 tb5_87 'War allein 18:20-18:30'
 tb5_88 'War allein 18:30-18:40'
 tb5_89 'War allein 18:40-18:50'
 tb5_90 'War allein 18:50-19:00'
 tb5_91 'War allein 19:00-19:10'
 tb5_92 'War allein 19:10-19:20'
 tb5_93 'War allein 19:20-19:30'
 tb5_94 'War allein 19:30-19:40'
 tb5_95 'War allein 19:40-19:50'
 tb5_96 'War allein 19:50-20:00'
 tb5_97 'War allein 20:00-20:10'
 tb5_98 'War allein 20:10-20:20'
 tb5_99 'War allein 20:20-20:30'
 tb5_100 'War allein 20:30-20:40'
 tb5_101 'War allein 20:40-20:50'
 tb5_102 'War allein 20:50-21:00'
 tb5_103 'War allein 21:00-21:10'
 tb5_104 'War allein 21:10-21:20'
 tb5_105 'War allein 21:20-21:30'
 tb5_106 'War allein 21:30-21:40'
 tb5_107 'War allein 21:40-21:50'
 tb5_108 'War allein 21:50-22:00'
 tb5_109 'War allein 22:00-22:10'
 tb5_110 'War allein 22:10-22:20'
 tb5_111 'War allein 22:20-22:30'
 tb5_112 'War allein 22:30-22:40'
 tb5_113 'War allein 22:40-22:50'
 tb5_114 'War allein 22:50-23:00'
 tb5_115 'War allein 23:00-23:10'
 tb5_116 'War allein 23:10-23:20'
 tb5_117 'War allein 23:20-23:30'
 tb5_118 'War allein 23:30-23:40'
 tb5_119 'War allein 23:40-23:50'
 tb5_120 'War allein 23:50-00:00'
 tb5_121 'War allein 00:00-00:10'
 tb5_122 'War allein 00:10-00:20'
 tb5_123 'War allein 00:20-00:30'
 tb5_124 'War allein 00:30-00:40'
 tb5_125 'War allein 00:40-00:50'
 tb5_126 'War allein 00:50-01:00'
 tb5_127 'War allein 01:00-01:10'
 tb5_128 'War allein 01:10-01:20'
 tb5_129 'War allein 01:20-01:30'
 tb5_130 'War allein 01:30-01:40'
 tb5_131 'War allein 01:40-01:50'
 tb5_132 'War allein 01:50-02:00'
 tb5_133 'War allein 02:00-02:10'
 tb5_134 'War allein 02:10-02:20'
 tb5_135 'War allein 02:20-02:30'
 tb5_136 'War allein 02:30-02:40'
 tb5_137 'War allein 02:40-02:50'
 tb5_138 'War allein 02:50-03:00'
 tb5_139 'War allein 03:00-03:10'
 tb5_140 'War allein 03:10-03:20'
 tb5_141 'War allein 03:20-03:30'
 tb5_142 'War allein 03:30-03:40'
 tb5_143 'War allein 03:40-03:50'
 tb5_144 'War allein 03:50-04:00'
 tb6_1 'Partner 04:00-04:10'
 tb6_2 'Partner 04:10-04:20'
 tb6_3 'Partner 04:20-04:30'
 tb6_4 'Partner 04:30-04:40'
 tb6_5 'Partner 04:40-04:50'
 tb6_6 'Partner 04:50-05:00'
 tb6_7 'Partner 05:00-05:10'
 tb6_8 'Partner 05:10-05:20'
 tb6_9 'Partner 05:20-05:30'
 tb6_10 'Partner 05:30-05:40'
 tb6_11 'Partner 05:40-05:50'
 tb6_12 'Partner 05:50-06:00'
 tb6_13 'Partner 06:00-06:10'
 tb6_14 'Partner 06:10-06:20'
 tb6_15 'Partner 06:20-06:30'
 tb6_16 'Partner 06:30-06:40'
 tb6_17 'Partner 06:40-06:50'
 tb6_18 'Partner 06:50-07:00'
 tb6_19 'Partner 07:00-07:10'
 tb6_20 'Partner 07:10-07:20'
 tb6_21 'Partner 07:20-07:30'
 tb6_22 'Partner 07:30-07:40'
 tb6_23 'Partner 07:40-07:50'
 tb6_24 'Partner 07:50-08:00'
 tb6_25 'Partner 08:00-08:10'
 tb6_26 'Partner 08:10-08:20'
 tb6_27 'Partner 08:20-08:30'
 tb6_28 'Partner 08:30-08:40'
 tb6_29 'Partner 08:40-08:50'
 tb6_30 'Partner 08:50-09:00'
 tb6_31 'Partner 09:00-09:10'
 tb6_32 'Partner 09:10-09:20'
 tb6_33 'Partner 09:20-09:30'
 tb6_34 'Partner 09:30-09:40'
 tb6_35 'Partner 09:40-09:50'
 tb6_36 'Partner 09:50-10:00'
 tb6_37 'Partner 10:00-10:10'
 tb6_38 'Partner 10:10-10:20'
 tb6_39 'Partner 10:20-10:30'
 tb6_40 'Partner 10:30-10:40'
 tb6_41 'Partner 10:40-10:50'
 tb6_42 'Partner 10:50-11:00'
 tb6_43 'Partner 11:00-11:10'
 tb6_44 'Partner 11:10-11:20'
 tb6_45 'Partner 11:20-11:30'
 tb6_46 'Partner 11:30-11:40'
 tb6_47 'Partner 11:40-11:50'
 tb6_48 'Partner 11:50-12:00'
 tb6_49 'Partner 12:00-12:10'
 tb6_50 'Partner 12:10-12:20'
 tb6_51 'Partner 12:20-12:30'
 tb6_52 'Partner 12:30-12:40'
 tb6_53 'Partner 12:40-12:50'
 tb6_54 'Partner 12:50-13:00'
 tb6_55 'Partner 13:00-13:10'
 tb6_56 'Partner 13:10-13:20'
 tb6_57 'Partner 13:20-13:30'
 tb6_58 'Partner 13:30-13:40'
 tb6_59 'Partner 13:40-13:50'
 tb6_60 'Partner 13:50-14:00'
 tb6_61 'Partner 14:00-14:10'
 tb6_62 'Partner 14:10-14:20'
 tb6_63 'Partner 14:20-14:30'
 tb6_64 'Partner 14:30-14:40'
 tb6_65 'Partner 14:40-14:50'
 tb6_66 'Partner 14:50-15:00'
 tb6_67 'Partner 15:00-15:10'
 tb6_68 'Partner 15:10-15:20'
 tb6_69 'Partner 15:20-15:30'
 tb6_70 'Partner 15:30-15:40'
 tb6_71 'Partner 15:40-15:50'
 tb6_72 'Partner 15:50-16:00'
 tb6_73 'Partner 16:00-16:10'
 tb6_74 'Partner 16:10-16:20'
 tb6_75 'Partner 16:20-16:30'
 tb6_76 'Partner 16:30-16:40'
 tb6_77 'Partner 16:40-16:50'
 tb6_78 'Partner 16:50-17:00'
 tb6_79 'Partner 17:00-17:10'
 tb6_80 'Partner 17:10-17:20'
 tb6_81 'Partner 17:20-17:30'
 tb6_82 'Partner 17:30-17:40'
 tb6_83 'Partner 17:40-17:50'
 tb6_84 'Partner 17:50-18:00'
 tb6_85 'Partner 18:00-18:10'
 tb6_86 'Partner 18:10-18:20'
 tb6_87 'Partner 18:20-18:30'
 tb6_88 'Partner 18:30-18:40'
 tb6_89 'Partner 18:40-18:50'
 tb6_90 'Partner 18:50-19:00'
 tb6_91 'Partner 19:00-19:10'
 tb6_92 'Partner 19:10-19:20'
 tb6_93 'Partner 19:20-19:30'
 tb6_94 'Partner 19:30-19:40'
 tb6_95 'Partner 19:40-19:50'
 tb6_96 'Partner 19:50-20:00'
 tb6_97 'Partner 20:00-20:10'
 tb6_98 'Partner 20:10-20:20'
 tb6_99 'Partner 20:20-20:30'
 tb6_100 'Partner 20:30-20:40'
 tb6_101 'Partner 20:40-20:50'
 tb6_102 'Partner 20:50-21:00'
 tb6_103 'Partner 21:00-21:10'
 tb6_104 'Partner 21:10-21:20'
 tb6_105 'Partner 21:20-21:30'
 tb6_106 'Partner 21:30-21:40'
 tb6_107 'Partner 21:40-21:50'
 tb6_108 'Partner 21:50-22:00'
 tb6_109 'Partner 22:00-22:10'
 tb6_110 'Partner 22:10-22:20'
 tb6_111 'Partner 22:20-22:30'
 tb6_112 'Partner 22:30-22:40'
 tb6_113 'Partner 22:40-22:50'
 tb6_114 'Partner 22:50-23:00'
 tb6_115 'Partner 23:00-23:10'
 tb6_116 'Partner 23:10-23:20'
 tb6_117 'Partner 23:20-23:30'
 tb6_118 'Partner 23:30-23:40'
 tb6_119 'Partner 23:40-23:50'
 tb6_120 'Partner 23:50-00:00'
 tb6_121 'Partner 00:00-00:10'
 tb6_122 'Partner 00:10-00:20'
 tb6_123 'Partner 00:20-00:30'
 tb6_124 'Partner 00:30-00:40'
 tb6_125 'Partner 00:40-00:50'
 tb6_126 'Partner 00:50-01:00'
 tb6_127 'Partner 01:00-01:10'
 tb6_128 'Partner 01:10-01:20'
 tb6_129 'Partner 01:20-01:30'
 tb6_130 'Partner 01:30-01:40'
 tb6_131 'Partner 01:40-01:50'
 tb6_132 'Partner 01:50-02:00'
 tb6_133 'Partner 02:00-02:10'
 tb6_134 'Partner 02:10-02:20'
 tb6_135 'Partner 02:20-02:30'
 tb6_136 'Partner 02:30-02:40'
 tb6_137 'Partner 02:40-02:50'
 tb6_138 'Partner 02:50-03:00'
 tb6_139 'Partner 03:00-03:10'
 tb6_140 'Partner 03:10-03:20'
 tb6_141 'Partner 03:20-03:30'
 tb6_142 'Partner 03:30-03:40'
 tb6_143 'Partner 03:40-03:50'
 tb6_144 'Partner 03:50-04:00'
 tb7_1 'Kinder unter 10 Jahren 04:00-04:10'
 tb7_2 'Kinder unter 10 Jahren 04:10-04:20'
 tb7_3 'Kinder unter 10 Jahren 04:20-04:30'
 tb7_4 'Kinder unter 10 Jahren 04:30-04:40'
 tb7_5 'Kinder unter 10 Jahren 04:40-04:50'
 tb7_6 'Kinder unter 10 Jahren 04:50-05:00'
 tb7_7 'Kinder unter 10 Jahren 05:00-05:10'
 tb7_8 'Kinder unter 10 Jahren 05:10-05:20'
 tb7_9 'Kinder unter 10 Jahren 05:20-05:30'
 tb7_10 'Kinder unter 10 Jahren 05:30-05:40'
 tb7_11 'Kinder unter 10 Jahren 05:40-05:50'
 tb7_12 'Kinder unter 10 Jahren 05:50-06:00'
 tb7_13 'Kinder unter 10 Jahren 06:00-06:10'
 tb7_14 'Kinder unter 10 Jahren 06:10-06:20'
 tb7_15 'Kinder unter 10 Jahren 06:20-06:30'
 tb7_16 'Kinder unter 10 Jahren 06:30-06:40'
 tb7_17 'Kinder unter 10 Jahren 06:40-06:50'
 tb7_18 'Kinder unter 10 Jahren 06:50-07:00'
 tb7_19 'Kinder unter 10 Jahren 07:00-07:10'
 tb7_20 'Kinder unter 10 Jahren 07:10-07:20'
 tb7_21 'Kinder unter 10 Jahren 07:20-07:30'
 tb7_22 'Kinder unter 10 Jahren 07:30-07:40'
 tb7_23 'Kinder unter 10 Jahren 07:40-07:50'
 tb7_24 'Kinder unter 10 Jahren 07:50-08:00'
 tb7_25 'Kinder unter 10 Jahren 08:00-08:10'
 tb7_26 'Kinder unter 10 Jahren 08:10-08:20'
 tb7_27 'Kinder unter 10 Jahren 08:20-08:30'
 tb7_28 'Kinder unter 10 Jahren 08:30-08:40'
 tb7_29 'Kinder unter 10 Jahren 08:40-08:50'
 tb7_30 'Kinder unter 10 Jahren 08:50-09:00'
 tb7_31 'Kinder unter 10 Jahren 09:00-09:10'
 tb7_32 'Kinder unter 10 Jahren 09:10-09:20'
 tb7_33 'Kinder unter 10 Jahren 09:20-09:30'
 tb7_34 'Kinder unter 10 Jahren 09:30-09:40'
 tb7_35 'Kinder unter 10 Jahren 09:40-09:50'
 tb7_36 'Kinder unter 10 Jahren 09:50-10:00'
 tb7_37 'Kinder unter 10 Jahren 10:00-10:10'
 tb7_38 'Kinder unter 10 Jahren 10:10-10:20'
 tb7_39 'Kinder unter 10 Jahren 10:20-10:30'
 tb7_40 'Kinder unter 10 Jahren 10:30-10:40'
 tb7_41 'Kinder unter 10 Jahren 10:40-10:50'
 tb7_42 'Kinder unter 10 Jahren 10:50-11:00'
 tb7_43 'Kinder unter 10 Jahren 11:00-11:10'
 tb7_44 'Kinder unter 10 Jahren 11:10-11:20'
 tb7_45 'Kinder unter 10 Jahren 11:20-11:30'
 tb7_46 'Kinder unter 10 Jahren 11:30-11:40'
 tb7_47 'Kinder unter 10 Jahren 11:40-11:50'
 tb7_48 'Kinder unter 10 Jahren 11:50-12:00'
 tb7_49 'Kinder unter 10 Jahren 12:00-12:10'
 tb7_50 'Kinder unter 10 Jahren 12:10-12:20'
 tb7_51 'Kinder unter 10 Jahren 12:20-12:30'
 tb7_52 'Kinder unter 10 Jahren 12:30-12:40'
 tb7_53 'Kinder unter 10 Jahren 12:40-12:50'
 tb7_54 'Kinder unter 10 Jahren 12:50-13:00'
 tb7_55 'Kinder unter 10 Jahren 13:00-13:10'
 tb7_56 'Kinder unter 10 Jahren 13:10-13:20'
 tb7_57 'Kinder unter 10 Jahren 13:20-13:30'
 tb7_58 'Kinder unter 10 Jahren 13:30-13:40'
 tb7_59 'Kinder unter 10 Jahren 13:40-13:50'
 tb7_60 'Kinder unter 10 Jahren 13:50-14:00'
 tb7_61 'Kinder unter 10 Jahren 14:00-14:10'
 tb7_62 'Kinder unter 10 Jahren 14:10-14:20'
 tb7_63 'Kinder unter 10 Jahren 14:20-14:30'
 tb7_64 'Kinder unter 10 Jahren 14:30-14:40'
 tb7_65 'Kinder unter 10 Jahren 14:40-14:50'
 tb7_66 'Kinder unter 10 Jahren 14:50-15:00'
 tb7_67 'Kinder unter 10 Jahren 15:00-15:10'
 tb7_68 'Kinder unter 10 Jahren 15:10-15:20'
 tb7_69 'Kinder unter 10 Jahren 15:20-15:30'
 tb7_70 'Kinder unter 10 Jahren 15:30-15:40'
 tb7_71 'Kinder unter 10 Jahren 15:40-15:50'
 tb7_72 'Kinder unter 10 Jahren 15:50-16:00'
 tb7_73 'Kinder unter 10 Jahren 16:00-16:10'
 tb7_74 'Kinder unter 10 Jahren 16:10-16:20'
 tb7_75 'Kinder unter 10 Jahren 16:20-16:30'
 tb7_76 'Kinder unter 10 Jahren 16:30-16:40'
 tb7_77 'Kinder unter 10 Jahren 16:40-16:50'
 tb7_78 'Kinder unter 10 Jahren 16:50-17:00'
 tb7_79 'Kinder unter 10 Jahren 17:00-17:10'
 tb7_80 'Kinder unter 10 Jahren 17:10-17:20'
 tb7_81 'Kinder unter 10 Jahren 17:20-17:30'
 tb7_82 'Kinder unter 10 Jahren 17:30-17:40'
 tb7_83 'Kinder unter 10 Jahren 17:40-17:50'
 tb7_84 'Kinder unter 10 Jahren 17:50-18:00'
 tb7_85 'Kinder unter 10 Jahren 18:00-18:10'
 tb7_86 'Kinder unter 10 Jahren 18:10-18:20'
 tb7_87 'Kinder unter 10 Jahren 18:20-18:30'
 tb7_88 'Kinder unter 10 Jahren 18:30-18:40'
 tb7_89 'Kinder unter 10 Jahren 18:40-18:50'
 tb7_90 'Kinder unter 10 Jahren 18:50-19:00'
 tb7_91 'Kinder unter 10 Jahren 19:00-19:10'
 tb7_92 'Kinder unter 10 Jahren 19:10-19:20'
 tb7_93 'Kinder unter 10 Jahren 19:20-19:30'
 tb7_94 'Kinder unter 10 Jahren 19:30-19:40'
 tb7_95 'Kinder unter 10 Jahren 19:40-19:50'
 tb7_96 'Kinder unter 10 Jahren 19:50-20:00'
 tb7_97 'Kinder unter 10 Jahren 20:00-20:10'
 tb7_98 'Kinder unter 10 Jahren 20:10-20:20'
 tb7_99 'Kinder unter 10 Jahren 20:20-20:30'
 tb7_100 'Kinder unter 10 Jahren 20:30-20:40'
 tb7_101 'Kinder unter 10 Jahren 20:40-20:50'
 tb7_102 'Kinder unter 10 Jahren 20:50-21:00'
 tb7_103 'Kinder unter 10 Jahren 21:00-21:10'
 tb7_104 'Kinder unter 10 Jahren 21:10-21:20'
 tb7_105 'Kinder unter 10 Jahren 21:20-21:30'
 tb7_106 'Kinder unter 10 Jahren 21:30-21:40'
 tb7_107 'Kinder unter 10 Jahren 21:40-21:50'
 tb7_108 'Kinder unter 10 Jahren 21:50-22:00'
 tb7_109 'Kinder unter 10 Jahren 22:00-22:10'
 tb7_110 'Kinder unter 10 Jahren 22:10-22:20'
 tb7_111 'Kinder unter 10 Jahren 22:20-22:30'
 tb7_112 'Kinder unter 10 Jahren 22:30-22:40'
 tb7_113 'Kinder unter 10 Jahren 22:40-22:50'
 tb7_114 'Kinder unter 10 Jahren 22:50-23:00'
 tb7_115 'Kinder unter 10 Jahren 23:00-23:10'
 tb7_116 'Kinder unter 10 Jahren 23:10-23:20'
 tb7_117 'Kinder unter 10 Jahren 23:20-23:30'
 tb7_118 'Kinder unter 10 Jahren 23:30-23:40'
 tb7_119 'Kinder unter 10 Jahren 23:40-23:50'
 tb7_120 'Kinder unter 10 Jahren 23:50-00:00'
 tb7_121 'Kinder unter 10 Jahren 00:00-00:10'
 tb7_122 'Kinder unter 10 Jahren 00:10-00:20'
 tb7_123 'Kinder unter 10 Jahren 00:20-00:30'
 tb7_124 'Kinder unter 10 Jahren 00:30-00:40'
 tb7_125 'Kinder unter 10 Jahren 00:40-00:50'
 tb7_126 'Kinder unter 10 Jahren 00:50-01:00'
 tb7_127 'Kinder unter 10 Jahren 01:00-01:10'
 tb7_128 'Kinder unter 10 Jahren 01:10-01:20'
 tb7_129 'Kinder unter 10 Jahren 01:20-01:30'
 tb7_130 'Kinder unter 10 Jahren 01:30-01:40'
 tb7_131 'Kinder unter 10 Jahren 01:40-01:50'
 tb7_132 'Kinder unter 10 Jahren 01:50-02:00'
 tb7_133 'Kinder unter 10 Jahren 02:00-02:10'
 tb7_134 'Kinder unter 10 Jahren 02:10-02:20'
 tb7_135 'Kinder unter 10 Jahren 02:20-02:30'
 tb7_136 'Kinder unter 10 Jahren 02:30-02:40'
 tb7_137 'Kinder unter 10 Jahren 02:40-02:50'
 tb7_138 'Kinder unter 10 Jahren 02:50-03:00'
 tb7_139 'Kinder unter 10 Jahren 03:00-03:10'
 tb7_140 'Kinder unter 10 Jahren 03:10-03:20'
 tb7_141 'Kinder unter 10 Jahren 03:20-03:30'
 tb7_142 'Kinder unter 10 Jahren 03:30-03:40'
 tb7_143 'Kinder unter 10 Jahren 03:40-03:50'
 tb7_144 'Kinder unter 10 Jahren 03:50-04:00'
 tb8_1 'Andere Haushaltsmitglieder 04:00-04:10'
 tb8_2 'Andere Haushaltsmitglieder 04:10-04:20'
 tb8_3 'Andere Haushaltsmitglieder 04:20-04:30'
 tb8_4 'Andere Haushaltsmitglieder 04:30-04:40'
 tb8_5 'Andere Haushaltsmitglieder 04:40-04:50'
 tb8_6 'Andere Haushaltsmitglieder 04:50-05:00'
 tb8_7 'Andere Haushaltsmitglieder 05:00-05:10'
 tb8_8 'Andere Haushaltsmitglieder 05:10-05:20'
 tb8_9 'Andere Haushaltsmitglieder 05:20-05:30'
 tb8_10 'Andere Haushaltsmitglieder 05:30-05:40'
 tb8_11 'Andere Haushaltsmitglieder 05:40-05:50'
 tb8_12 'Andere Haushaltsmitglieder 05:50-06:00'
 tb8_13 'Andere Haushaltsmitglieder 06:00-06:10'
 tb8_14 'Andere Haushaltsmitglieder 06:10-06:20'
 tb8_15 'Andere Haushaltsmitglieder 06:20-06:30'
 tb8_16 'Andere Haushaltsmitglieder 06:30-06:40'
 tb8_17 'Andere Haushaltsmitglieder 06:40-06:50'
 tb8_18 'Andere Haushaltsmitglieder 06:50-07:00'
 tb8_19 'Andere Haushaltsmitglieder 07:00-07:10'
 tb8_20 'Andere Haushaltsmitglieder 07:10-07:20'
 tb8_21 'Andere Haushaltsmitglieder 07:20-07:30'
 tb8_22 'Andere Haushaltsmitglieder 07:30-07:40'
 tb8_23 'Andere Haushaltsmitglieder 07:40-07:50'
 tb8_24 'Andere Haushaltsmitglieder 07:50-08:00'
 tb8_25 'Andere Haushaltsmitglieder 08:00-08:10'
 tb8_26 'Andere Haushaltsmitglieder 08:10-08:20'
 tb8_27 'Andere Haushaltsmitglieder 08:20-08:30'
 tb8_28 'Andere Haushaltsmitglieder 08:30-08:40'
 tb8_29 'Andere Haushaltsmitglieder 08:40-08:50'
 tb8_30 'Andere Haushaltsmitglieder 08:50-09:00'
 tb8_31 'Andere Haushaltsmitglieder 09:00-09:10'
 tb8_32 'Andere Haushaltsmitglieder 09:10-09:20'
 tb8_33 'Andere Haushaltsmitglieder 09:20-09:30'
 tb8_34 'Andere Haushaltsmitglieder 09:30-09:40'
 tb8_35 'Andere Haushaltsmitglieder 09:40-09:50'
 tb8_36 'Andere Haushaltsmitglieder 09:50-10:00'
 tb8_37 'Andere Haushaltsmitglieder 10:00-10:10'
 tb8_38 'Andere Haushaltsmitglieder 10:10-10:20'
 tb8_39 'Andere Haushaltsmitglieder 10:20-10:30'
 tb8_40 'Andere Haushaltsmitglieder 10:30-10:40'
 tb8_41 'Andere Haushaltsmitglieder 10:40-10:50'
 tb8_42 'Andere Haushaltsmitglieder 10:50-11:00'
 tb8_43 'Andere Haushaltsmitglieder 11:00-11:10'
 tb8_44 'Andere Haushaltsmitglieder 11:10-11:20'
 tb8_45 'Andere Haushaltsmitglieder 11:20-11:30'
 tb8_46 'Andere Haushaltsmitglieder 11:30-11:40'
 tb8_47 'Andere Haushaltsmitglieder 11:40-11:50'
 tb8_48 'Andere Haushaltsmitglieder 11:50-12:00'
 tb8_49 'Andere Haushaltsmitglieder 12:00-12:10'
 tb8_50 'Andere Haushaltsmitglieder 12:10-12:20'
 tb8_51 'Andere Haushaltsmitglieder 12:20-12:30'
 tb8_52 'Andere Haushaltsmitglieder 12:30-12:40'
 tb8_53 'Andere Haushaltsmitglieder 12:40-12:50'
 tb8_54 'Andere Haushaltsmitglieder 12:50-13:00'
 tb8_55 'Andere Haushaltsmitglieder 13:00-13:10'
 tb8_56 'Andere Haushaltsmitglieder 13:10-13:20'
 tb8_57 'Andere Haushaltsmitglieder 13:20-13:30'
 tb8_58 'Andere Haushaltsmitglieder 13:30-13:40'
 tb8_59 'Andere Haushaltsmitglieder 13:40-13:50'
 tb8_60 'Andere Haushaltsmitglieder 13:50-14:00'
 tb8_61 'Andere Haushaltsmitglieder 14:00-14:10'
 tb8_62 'Andere Haushaltsmitglieder 14:10-14:20'
 tb8_63 'Andere Haushaltsmitglieder 14:20-14:30'
 tb8_64 'Andere Haushaltsmitglieder 14:30-14:40'
 tb8_65 'Andere Haushaltsmitglieder 14:40-14:50'
 tb8_66 'Andere Haushaltsmitglieder 14:50-15:00'
 tb8_67 'Andere Haushaltsmitglieder 15:00-15:10'
 tb8_68 'Andere Haushaltsmitglieder 15:10-15:20'
 tb8_69 'Andere Haushaltsmitglieder 15:20-15:30'
 tb8_70 'Andere Haushaltsmitglieder 15:30-15:40'
 tb8_71 'Andere Haushaltsmitglieder 15:40-15:50'
 tb8_72 'Andere Haushaltsmitglieder 15:50-16:00'
 tb8_73 'Andere Haushaltsmitglieder 16:00-16:10'
 tb8_74 'Andere Haushaltsmitglieder 16:10-16:20'
 tb8_75 'Andere Haushaltsmitglieder 16:20-16:30'
 tb8_76 'Andere Haushaltsmitglieder 16:30-16:40'
 tb8_77 'Andere Haushaltsmitglieder 16:40-16:50'
 tb8_78 'Andere Haushaltsmitglieder 16:50-17:00'
 tb8_79 'Andere Haushaltsmitglieder 17:00-17:10'
 tb8_80 'Andere Haushaltsmitglieder 17:10-17:20'
 tb8_81 'Andere Haushaltsmitglieder 17:20-17:30'
 tb8_82 'Andere Haushaltsmitglieder 17:30-17:40'
 tb8_83 'Andere Haushaltsmitglieder 17:40-17:50'
 tb8_84 'Andere Haushaltsmitglieder 17:50-18:00'
 tb8_85 'Andere Haushaltsmitglieder 18:00-18:10'
 tb8_86 'Andere Haushaltsmitglieder 18:10-18:20'
 tb8_87 'Andere Haushaltsmitglieder 18:20-18:30'
 tb8_88 'Andere Haushaltsmitglieder 18:30-18:40'
 tb8_89 'Andere Haushaltsmitglieder 18:40-18:50'
 tb8_90 'Andere Haushaltsmitglieder 18:50-19:00'
 tb8_91 'Andere Haushaltsmitglieder 19:00-19:10'
 tb8_92 'Andere Haushaltsmitglieder 19:10-19:20'
 tb8_93 'Andere Haushaltsmitglieder 19:20-19:30'
 tb8_94 'Andere Haushaltsmitglieder 19:30-19:40'
 tb8_95 'Andere Haushaltsmitglieder 19:40-19:50'
 tb8_96 'Andere Haushaltsmitglieder 19:50-20:00'
 tb8_97 'Andere Haushaltsmitglieder 20:00-20:10'
 tb8_98 'Andere Haushaltsmitglieder 20:10-20:20'
 tb8_99 'Andere Haushaltsmitglieder 20:20-20:30'
 tb8_100 'Andere Haushaltsmitglieder 20:30-20:40'
 tb8_101 'Andere Haushaltsmitglieder 20:40-20:50'
 tb8_102 'Andere Haushaltsmitglieder 20:50-21:00'
 tb8_103 'Andere Haushaltsmitglieder 21:00-21:10'
 tb8_104 'Andere Haushaltsmitglieder 21:10-21:20'
 tb8_105 'Andere Haushaltsmitglieder 21:20-21:30'
 tb8_106 'Andere Haushaltsmitglieder 21:30-21:40'
 tb8_107 'Andere Haushaltsmitglieder 21:40-21:50'
 tb8_108 'Andere Haushaltsmitglieder 21:50-22:00'
 tb8_109 'Andere Haushaltsmitglieder 22:00-22:10'
 tb8_110 'Andere Haushaltsmitglieder 22:10-22:20'
 tb8_111 'Andere Haushaltsmitglieder 22:20-22:30'
 tb8_112 'Andere Haushaltsmitglieder 22:30-22:40'
 tb8_113 'Andere Haushaltsmitglieder 22:40-22:50'
 tb8_114 'Andere Haushaltsmitglieder 22:50-23:00'
 tb8_115 'Andere Haushaltsmitglieder 23:00-23:10'
 tb8_116 'Andere Haushaltsmitglieder 23:10-23:20'
 tb8_117 'Andere Haushaltsmitglieder 23:20-23:30'
 tb8_118 'Andere Haushaltsmitglieder 23:30-23:40'
 tb8_119 'Andere Haushaltsmitglieder 23:40-23:50'
 tb8_120 'Andere Haushaltsmitglieder 23:50-00:00'
 tb8_121 'Andere Haushaltsmitglieder 00:00-00:10'
 tb8_122 'Andere Haushaltsmitglieder 00:10-00:20'
 tb8_123 'Andere Haushaltsmitglieder 00:20-00:30'
 tb8_124 'Andere Haushaltsmitglieder 00:30-00:40'
 tb8_125 'Andere Haushaltsmitglieder 00:40-00:50'
 tb8_126 'Andere Haushaltsmitglieder 00:50-01:00'
 tb8_127 'Andere Haushaltsmitglieder 01:00-01:10'
 tb8_128 'Andere Haushaltsmitglieder 01:10-01:20'
 tb8_129 'Andere Haushaltsmitglieder 01:20-01:30'
 tb8_130 'Andere Haushaltsmitglieder 01:30-01:40'
 tb8_131 'Andere Haushaltsmitglieder 01:40-01:50'
 tb8_132 'Andere Haushaltsmitglieder 01:50-02:00'
 tb8_133 'Andere Haushaltsmitglieder 02:00-02:10'
 tb8_134 'Andere Haushaltsmitglieder 02:10-02:20'
 tb8_135 'Andere Haushaltsmitglieder 02:20-02:30'
 tb8_136 'Andere Haushaltsmitglieder 02:30-02:40'
 tb8_137 'Andere Haushaltsmitglieder 02:40-02:50'
 tb8_138 'Andere Haushaltsmitglieder 02:50-03:00'
 tb8_139 'Andere Haushaltsmitglieder 03:00-03:10'
 tb8_140 'Andere Haushaltsmitglieder 03:10-03:20'
 tb8_141 'Andere Haushaltsmitglieder 03:20-03:30'
 tb8_142 'Andere Haushaltsmitglieder 03:30-03:40'
 tb8_143 'Andere Haushaltsmitglieder 03:40-03:50'
 tb8_144 'Andere Haushaltsmitglieder 03:50-04:00'
 tb9_1 'Bekannte 04:00-04:10'
 tb9_2 'Bekannte 04:10-04:20'
 tb9_3 'Bekannte 04:20-04:30'
 tb9_4 'Bekannte 04:30-04:40'
 tb9_5 'Bekannte 04:40-04:50'
 tb9_6 'Bekannte 04:50-05:00'
 tb9_7 'Bekannte 05:00-05:10'
 tb9_8 'Bekannte 05:10-05:20'
 tb9_9 'Bekannte 05:20-05:30'
 tb9_10 'Bekannte 05:30-05:40'
 tb9_11 'Bekannte 05:40-05:50'
 tb9_12 'Bekannte 05:50-06:00'
 tb9_13 'Bekannte 06:00-06:10'
 tb9_14 'Bekannte 06:10-06:20'
 tb9_15 'Bekannte 06:20-06:30'
 tb9_16 'Bekannte 06:30-06:40'
 tb9_17 'Bekannte 06:40-06:50'
 tb9_18 'Bekannte 06:50-07:00'
 tb9_19 'Bekannte 07:00-07:10'
 tb9_20 'Bekannte 07:10-07:20'
 tb9_21 'Bekannte 07:20-07:30'
 tb9_22 'Bekannte 07:30-07:40'
 tb9_23 'Bekannte 07:40-07:50'
 tb9_24 'Bekannte 07:50-08:00'
 tb9_25 'Bekannte 08:00-08:10'
 tb9_26 'Bekannte 08:10-08:20'
 tb9_27 'Bekannte 08:20-08:30'
 tb9_28 'Bekannte 08:30-08:40'
 tb9_29 'Bekannte 08:40-08:50'
 tb9_30 'Bekannte 08:50-09:00'
 tb9_31 'Bekannte 09:00-09:10'
 tb9_32 'Bekannte 09:10-09:20'
 tb9_33 'Bekannte 09:20-09:30'
 tb9_34 'Bekannte 09:30-09:40'
 tb9_35 'Bekannte 09:40-09:50'
 tb9_36 'Bekannte 09:50-10:00'
 tb9_37 'Bekannte 10:00-10:10'
 tb9_38 'Bekannte 10:10-10:20'
 tb9_39 'Bekannte 10:20-10:30'
 tb9_40 'Bekannte 10:30-10:40'
 tb9_41 'Bekannte 10:40-10:50'
 tb9_42 'Bekannte 10:50-11:00'
 tb9_43 'Bekannte 11:00-11:10'
 tb9_44 'Bekannte 11:10-11:20'
 tb9_45 'Bekannte 11:20-11:30'
 tb9_46 'Bekannte 11:30-11:40'
 tb9_47 'Bekannte 11:40-11:50'
 tb9_48 'Bekannte 11:50-12:00'
 tb9_49 'Bekannte 12:00-12:10'
 tb9_50 'Bekannte 12:10-12:20'
 tb9_51 'Bekannte 12:20-12:30'
 tb9_52 'Bekannte 12:30-12:40'
 tb9_53 'Bekannte 12:40-12:50'
 tb9_54 'Bekannte 12:50-13:00'
 tb9_55 'Bekannte 13:00-13:10'
 tb9_56 'Bekannte 13:10-13:20'
 tb9_57 'Bekannte 13:20-13:30'
 tb9_58 'Bekannte 13:30-13:40'
 tb9_59 'Bekannte 13:40-13:50'
 tb9_60 'Bekannte 13:50-14:00'
 tb9_61 'Bekannte 14:00-14:10'
 tb9_62 'Bekannte 14:10-14:20'
 tb9_63 'Bekannte 14:20-14:30'
 tb9_64 'Bekannte 14:30-14:40'
 tb9_65 'Bekannte 14:40-14:50'
 tb9_66 'Bekannte 14:50-15:00'
 tb9_67 'Bekannte 15:00-15:10'
 tb9_68 'Bekannte 15:10-15:20'
 tb9_69 'Bekannte 15:20-15:30'
 tb9_70 'Bekannte 15:30-15:40'
 tb9_71 'Bekannte 15:40-15:50'
 tb9_72 'Bekannte 15:50-16:00'
 tb9_73 'Bekannte 16:00-16:10'
 tb9_74 'Bekannte 16:10-16:20'
 tb9_75 'Bekannte 16:20-16:30'
 tb9_76 'Bekannte 16:30-16:40'
 tb9_77 'Bekannte 16:40-16:50'
 tb9_78 'Bekannte 16:50-17:00'
 tb9_79 'Bekannte 17:00-17:10'
 tb9_80 'Bekannte 17:10-17:20'
 tb9_81 'Bekannte 17:20-17:30'
 tb9_82 'Bekannte 17:30-17:40'
 tb9_83 'Bekannte 17:40-17:50'
 tb9_84 'Bekannte 17:50-18:00'
 tb9_85 'Bekannte 18:00-18:10'
 tb9_86 'Bekannte 18:10-18:20'
 tb9_87 'Bekannte 18:20-18:30'
 tb9_88 'Bekannte 18:30-18:40'
 tb9_89 'Bekannte 18:40-18:50'
 tb9_90 'Bekannte 18:50-19:00'
 tb9_91 'Bekannte 19:00-19:10'
 tb9_92 'Bekannte 19:10-19:20'
 tb9_93 'Bekannte 19:20-19:30'
 tb9_94 'Bekannte 19:30-19:40'
 tb9_95 'Bekannte 19:40-19:50'
 tb9_96 'Bekannte 19:50-20:00'
 tb9_97 'Bekannte 20:00-20:10'
 tb9_98 'Bekannte 20:10-20:20'
 tb9_99 'Bekannte 20:20-20:30'
 tb9_100 'Bekannte 20:30-20:40'
 tb9_101 'Bekannte 20:40-20:50'
 tb9_102 'Bekannte 20:50-21:00'
 tb9_103 'Bekannte 21:00-21:10'
 tb9_104 'Bekannte 21:10-21:20'
 tb9_105 'Bekannte 21:20-21:30'
 tb9_106 'Bekannte 21:30-21:40'
 tb9_107 'Bekannte 21:40-21:50'
 tb9_108 'Bekannte 21:50-22:00'
 tb9_109 'Bekannte 22:00-22:10'
 tb9_110 'Bekannte 22:10-22:20'
 tb9_111 'Bekannte 22:20-22:30'
 tb9_112 'Bekannte 22:30-22:40'
 tb9_113 'Bekannte 22:40-22:50'
 tb9_114 'Bekannte 22:50-23:00'
 tb9_115 'Bekannte 23:00-23:10'
 tb9_116 'Bekannte 23:10-23:20'
 tb9_117 'Bekannte 23:20-23:30'
 tb9_118 'Bekannte 23:30-23:40'
 tb9_119 'Bekannte 23:40-23:50'
 tb9_120 'Bekannte 23:50-00:00'
 tb9_121 'Bekannte 00:00-00:10'
 tb9_122 'Bekannte 00:10-00:20'
 tb9_123 'Bekannte 00:20-00:30'
 tb9_124 'Bekannte 00:30-00:40'
 tb9_125 'Bekannte 00:40-00:50'
 tb9_126 'Bekannte 00:50-01:00'
 tb9_127 'Bekannte 01:00-01:10'
 tb9_128 'Bekannte 01:10-01:20'
 tb9_129 'Bekannte 01:20-01:30'
 tb9_130 'Bekannte 01:30-01:40'
 tb9_131 'Bekannte 01:40-01:50'
 tb9_132 'Bekannte 01:50-02:00'
 tb9_133 'Bekannte 02:00-02:10'
 tb9_134 'Bekannte 02:10-02:20'
 tb9_135 'Bekannte 02:20-02:30'
 tb9_136 'Bekannte 02:30-02:40'
 tb9_137 'Bekannte 02:40-02:50'
 tb9_138 'Bekannte 02:50-03:00'
 tb9_139 'Bekannte 03:00-03:10'
 tb9_140 'Bekannte 03:10-03:20'
 tb9_141 'Bekannte 03:20-03:30'
 tb9_142 'Bekannte 03:30-03:40'
 tb9_143 'Bekannte 03:40-03:50'
 tb9_144 'Bekannte 03:50-04:00'
tc1x 'Anzahl der Nennungen zu größte Freude'
tc1ax	 'Aktivitätscode größte Freude 1'
tc1bx	 'Aktivitätscode größte Freude 2'
tc1cx	 'Aktivitätscode größte Freude 3'
tc2x 'Anzahl der Nennungen zu mehr Zeit'
tc2ax	 'Aktivitätscode mehr Zeit 1'
tc2bx	 'Aktivitätscode mehr Zeit 2'
tc2cx	 'Aktivitätscode mehr Zeit 3'
tc3ax	 'Aktivitätscode keine Freude 1'
tc3bx	 'Aktivitätscode keine Freude 2'
tc3cx	 'Aktivitätscode keine Freude 3'
tc4	 'Besonderheiten des Tages'
tc5	 'Reise'
tc6	 'Häufigkeit der Anschreibungen'
tc7	 'Zu Hause zu Beginn des Tages'
tc8	 'Zu Hause am Ende des Tages'
wtagfei	 'Wochentag, Feiertage berücksichtigt'
fehl_tag	 'Fehlender Tag'
quartal	 'Kalenderquartal des Ausfülldatums'
selbtag	 'Datum des Tagebuchtages ist für alle Personen des Haushalts identisch'
id_hhx 'Haushalts-ID'
id_persx 'Personen-ID'
id_tagx 'Tag-ID'
persx 'Personennummer'
tagnr 'Anschreibetag'
berichtsjahr 'Berichtsjahr'
hrft80 'Hochrechnungsfaktor für den Tag multipliziert mit 100'
jahr 'Jahr des Ausfülldatums'.


*			  (V) ZVE 13 takt.		
*			  (ii)	Zuweisen der Variablenlabels. 

value labels 	 tb2_1 tb2_2 tb2_3 tb2_4 tb2_5 tb2_6 tb2_7 tb2_8 tb2_9 tb2_10 tb2_11 tb2_12 tb2_13
tb2_14 tb2_15 tb2_16 tb2_17 tb2_18 tb2_19 tb2_20 tb2_21 tb2_22 tb2_23 tb2_24 tb2_25 tb2_26 tb2_27
tb2_28 tb2_29 tb2_30 tb2_31 tb2_32 tb2_33 tb2_34 tb2_35 tb2_36 tb2_37 tb2_38 tb2_39 tb2_40 tb2_41
tb2_42 tb2_43 tb2_44 tb2_45 tb2_46 tb2_47 tb2_48 tb2_49 tb2_50 tb2_51 tb2_52 tb2_53 tb2_54 tb2_55
tb2_56 tb2_57 tb2_58 tb2_59 tb2_60 tb2_61 tb2_62 tb2_63 tb2_64 tb2_65 tb2_66 tb2_67 tb2_68 tb2_69
tb2_70 tb2_71 tb2_72 tb2_73 tb2_74 tb2_75 tb2_76 tb2_77 tb2_78 tb2_79 tb2_80 tb2_81 tb2_82 tb2_83
tb2_84 tb2_85 tb2_86 tb2_87 tb2_88 tb2_89 tb2_90 tb2_91 tb2_92 tb2_93 tb2_94 tb2_95 tb2_96 tb2_97 
tb2_98 tb2_99 tb2_100 tb2_101 tb2_102 tb2_103 tb2_104 tb2_105 tb2_106 tb2_107 tb2_108 tb2_109 tb2_110
tb2_111 tb2_112 tb2_113 tb2_114 tb2_115 tb2_116 tb2_117 tb2_118 tb2_119 tb2_120 tb2_121 tb2_122 tb2_123
tb2_124 tb2_125 tb2_126 tb2_127 tb2_128 tb2_129 tb2_130 tb2_131 tb2_132 tb2_133 tb2_134 tb2_135 tb2_136
tb2_137 tb2_138 tb2_139 tb2_140 tb2_141 tb2_142 tb2_143 tb2_144							
		'0'	 	'keine Nebenaktivität'	.

value labels tb3_1 tb3_2 tb3_3 tb3_4 tb3_5 tb3_6 tb3_7 tb3_8 tb3_9 tb3_10 tb3_11 tb3_12 tb3_13 tb3_14 
tb3_15 tb3_16 tb3_17 tb3_18 tb3_19 tb3_20 tb3_21 tb3_22 tb3_23 tb3_24 tb3_25 tb3_26 tb3_27 tb3_28 tb3_29 
tb3_30 tb3_31 tb3_32 tb3_33 tb3_34 tb3_35 tb3_36 tb3_37 tb3_38 tb3_39 tb3_40 tb3_41 tb3_42 tb3_43 tb3_44 
tb3_45 tb3_46 tb3_47 tb3_48 tb3_49 tb3_50 tb3_51 tb3_52 tb3_53 tb3_54 tb3_55 tb3_56 tb3_57 tb3_58 tb3_59 
tb3_60 tb3_61 tb3_62 tb3_63 tb3_64 tb3_65 tb3_66 tb3_67 tb3_68 tb3_69 tb3_70 tb3_71 tb3_72 tb3_73 tb3_74 
tb3_75 tb3_76 tb3_77 tb3_78 tb3_79 tb3_80 tb3_81 tb3_82 tb3_83 tb3_84 tb3_85 tb3_86 tb3_87 tb3_88 tb3_89 
tb3_90 tb3_91 tb3_92 tb3_93 tb3_94 tb3_95 tb3_96 tb3_97 tb3_98 tb3_99 tb3_100 tb3_101 tb3_102 tb3_103 
tb3_104 tb3_105 tb3_106 tb3_107 tb3_108 tb3_109 tb3_110 tb3_111 tb3_112 tb3_113 tb3_114 tb3_115 tb3_116 
tb3_117 tb3_118 tb3_119 tb3_120 tb3_121 tb3_122 tb3_123 tb3_124 tb3_125 tb3_126 tb3_127 tb3_128 tb3_129 
tb3_130 tb3_131 tb3_132 tb3_133 tb3_134 tb3_135 tb3_136 tb3_137 tb3_138 tb3_139 tb3_140 tb3_141 tb3_142 
tb3_143 tb3_144						
'-1' 'keine Angabe'
'0' 'keine Wegezeit'
'11' 'zu Fuß'
'12' 'Fahrrad'
'14' 'PKW'
'19' 'Sonst. privates Verkehrsmittel'
'22' 'Bus/Reisebus'
'23' 'Straßenbahn/U-Bahn'
'24' 'Zug/S-Bahn'
'29' 'Sonst. öffentliches Verkehrsmittel'.

value labels 	tb4_1 tb4_2 tb4_3 tb4_4 tb4_5 tb4_6 tb4_7 tb4_8 tb4_9 tb4_10 tb4_11 tb4_12 tb4_13 tb4_14 tb4_15
tb4_16 tb4_17 tb4_18 tb4_19 tb4_20 tb4_21 tb4_22 tb4_23 tb4_24 tb4_25 tb4_26 tb4_27 tb4_28 tb4_29 tb4_30 tb4_31
tb4_32 tb4_33 tb4_34 tb4_35 tb4_36 tb4_37 tb4_38 tb4_39 tb4_40 tb4_41 tb4_42 tb4_43 tb4_44 tb4_45 tb4_46 tb4_47
tb4_48 tb4_49 tb4_50 tb4_51 tb4_52 tb4_53 tb4_54 tb4_55 tb4_56 tb4_57 tb4_58 tb4_59 tb4_60 tb4_61 tb4_62 tb4_63
tb4_64 tb4_65 tb4_66 tb4_67 tb4_68 tb4_69 tb4_70 tb4_71 tb4_72 tb4_73 tb4_74 tb4_75 tb4_76 tb4_77 tb4_78 tb4_79
tb4_80 tb4_81 tb4_82 tb4_83 tb4_84 tb4_85 tb4_86 tb4_87 tb4_88 tb4_89 tb4_90 tb4_91 tb4_92 tb4_93 tb4_94 tb4_95
tb4_96 tb4_97 tb4_98 tb4_99 tb4_100 tb4_101 tb4_102 tb4_103 tb4_104 tb4_105 tb4_106 tb4_107 tb4_108 tb4_109 tb4_110
tb4_111 tb4_112 tb4_113 tb4_114 tb4_115 tb4_116 tb4_117 tb4_118 tb4_119 tb4_120 tb4_121 tb4_122 tb4_123 tb4_124 tb4_125
tb4_126 tb4_127 tb4_128 tb4_129 tb4_130 tb4_131 tb4_132 tb4_133 tb4_134 tb4_135 tb4_136 tb4_137 tb4_138 tb4_139 tb4_140
tb4_141 tb4_142 tb4_143 tb4_144 tb5_1 tb5_2 tb5_3 tb5_4 tb5_5 tb5_6 tb5_7 tb5_8 tb5_9 tb5_10 tb5_11 tb5_12 tb5_13 tb5_14 tb5_15
tb5_16 tb5_17 tb5_18 tb5_19 tb5_20 tb5_21 tb5_22 tb5_23 tb5_24 tb5_25 tb5_26 tb5_27 tb5_28 tb5_29 tb5_30 tb5_31 tb5_32 tb5_33
tb5_34 tb5_35 tb5_36 tb5_37 tb5_38 tb5_39 tb5_40 tb5_41 tb5_42 tb5_43 tb5_44 tb5_45 tb5_46 tb5_47 tb5_48 tb5_49 tb5_50 tb5_51
tb5_52 tb5_53 tb5_54 tb5_55 tb5_56 tb5_57 tb5_58 tb5_59 tb5_60 tb5_61 tb5_62 tb5_63 tb5_64 tb5_65 tb5_66 tb5_67 tb5_68 tb5_69
tb5_70 tb5_71 tb5_72 tb5_73 tb5_74 tb5_75 tb5_76 tb5_77 tb5_78 tb5_79 tb5_80 tb5_81 tb5_82 tb5_83 tb5_84 tb5_85 tb5_86 tb5_87
tb5_88 tb5_89 tb5_90 tb5_91 tb5_92 tb5_93 tb5_94 tb5_95 tb5_96 tb5_97 tb5_98 tb5_99 tb5_100 tb5_101 tb5_102 tb5_103 tb5_104
tb5_105 tb5_106 tb5_107 tb5_108 tb5_109 tb5_110 tb5_111 tb5_112 tb5_113 tb5_114 tb5_115 tb5_116 tb5_117 tb5_118 tb5_119 tb5_120
tb5_121 tb5_122 tb5_123 tb5_124 tb5_125 tb5_126 tb5_127 tb5_128 tb5_129 tb5_130 tb5_131 tb5_132 tb5_133 tb5_134 tb5_135 tb5_136
tb5_137 tb5_138 tb5_139 tb5_140 tb5_141 tb5_142 tb5_143 tb5_144 tb6_1 tb6_2 tb6_3 tb6_4 tb6_5 tb6_6 tb6_7 tb6_8 tb6_9 tb6_10 tb6_11
tb6_12 tb6_13 tb6_14 tb6_15 tb6_16 tb6_17 tb6_18 tb6_19 tb6_20 tb6_21 tb6_22 tb6_23 tb6_24 tb6_25 tb6_26 tb6_27 tb6_28 tb6_29 tb6_30
tb6_31 tb6_32 tb6_33 tb6_34 tb6_35 tb6_36 tb6_37 tb6_38 tb6_39 tb6_40 tb6_41 tb6_42 tb6_43 tb6_44 tb6_45 tb6_46 tb6_47 tb6_48 tb6_49
tb6_50 tb6_51 tb6_52 tb6_53 tb6_54 tb6_55 tb6_56 tb6_57 tb6_58 tb6_59 tb6_60 tb6_61 tb6_62 tb6_63 tb6_64 tb6_65 tb6_66 tb6_67 tb6_68
tb6_69 tb6_70 tb6_71 tb6_72 tb6_73 tb6_74 tb6_75 tb6_76 tb6_77 tb6_78 tb6_79 tb6_80 tb6_81 tb6_82 tb6_83 tb6_84 tb6_85 tb6_86 tb6_87
tb6_88 tb6_89 tb6_90 tb6_91 tb6_92 tb6_93 tb6_94 tb6_95 tb6_96 tb6_97 tb6_98 tb6_99 tb6_100 tb6_101 tb6_102 tb6_103 tb6_104 tb6_105
tb6_106 tb6_107 tb6_108 tb6_109 tb6_110 tb6_111 tb6_112 tb6_113 tb6_114 tb6_115 tb6_116 tb6_117 tb6_118 tb6_119 tb6_120 tb6_121
tb6_122 tb6_123 tb6_124 tb6_125 tb6_126 tb6_127 tb6_128 tb6_129 tb6_130 tb6_131 tb6_132 tb6_133 tb6_134 tb6_135 tb6_136 tb6_137
tb6_138 tb6_139 tb6_140 tb6_141 tb6_142 tb6_143 tb6_144 tb7_1 tb7_2 tb7_3 tb7_4 tb7_5 tb7_6 tb7_7 tb7_8 tb7_9 tb7_10 tb7_11 tb7_12
tb7_13 tb7_14 tb7_15 tb7_16 tb7_17 tb7_18 tb7_19 tb7_20 tb7_21 tb7_22 tb7_23 tb7_24 tb7_25 tb7_26 tb7_27 tb7_28 tb7_29 tb7_30 tb7_31
tb7_32 tb7_33 tb7_34 tb7_35 tb7_36 tb7_37 tb7_38 tb7_39 tb7_40 tb7_41 tb7_42 tb7_43 tb7_44 tb7_45 tb7_46 tb7_47 tb7_48 tb7_49 tb7_50
tb7_51 tb7_52 tb7_53 tb7_54 tb7_55 tb7_56 tb7_57 tb7_58 tb7_59 tb7_60 tb7_61 tb7_62 tb7_63 tb7_64 tb7_65 tb7_66 tb7_67 tb7_68 tb7_69
tb7_70 tb7_71 tb7_72 tb7_73 tb7_74 tb7_75 tb7_76 tb7_77 tb7_78 tb7_79 tb7_80 tb7_81 tb7_82 tb7_83 tb7_84 tb7_85 tb7_86 tb7_87 tb7_88
tb7_89 tb7_90 tb7_91 tb7_92 tb7_93 tb7_94 tb7_95 tb7_96 tb7_97 tb7_98 tb7_99 tb7_100 tb7_101 tb7_102 tb7_103 tb7_104 tb7_105 tb7_106
tb7_107 tb7_108 tb7_109 tb7_110 tb7_111 tb7_112 tb7_113 tb7_114 tb7_115 tb7_116 tb7_117 tb7_118 tb7_119 tb7_120 tb7_121 tb7_122 tb7_123
tb7_124 tb7_125 tb7_126 tb7_127 tb7_128 tb7_129 tb7_130 tb7_131 tb7_132 tb7_133 tb7_134 tb7_135 tb7_136 tb7_137 tb7_138 tb7_139 tb7_140
tb7_141 tb7_142 tb7_143 tb7_144 tb8_1 tb8_2 tb8_3 tb8_4 tb8_5 tb8_6 tb8_7 tb8_8 tb8_9 tb8_10 tb8_11 tb8_12 tb8_13 tb8_14 tb8_15 tb8_16 tb8_17
tb8_18 tb8_19 tb8_20 tb8_21 tb8_22 tb8_23 tb8_24 tb8_25 tb8_26 tb8_27 tb8_28 tb8_29 tb8_30 tb8_31 tb8_32 tb8_33 tb8_34 tb8_35 tb8_36 tb8_37
tb8_38 tb8_39 tb8_40 tb8_41 tb8_42 tb8_43 tb8_44 tb8_45 tb8_46 tb8_47 tb8_48 tb8_49 tb8_50 tb8_51 tb8_52 tb8_53 tb8_54 tb8_55 tb8_56 tb8_57
tb8_58 tb8_59 tb8_60 tb8_61 tb8_62 tb8_63 tb8_64 tb8_65 tb8_66 tb8_67 tb8_68 tb8_69 tb8_70 tb8_71 tb8_72 tb8_73 tb8_74 tb8_75 tb8_76 tb8_77
tb8_78 tb8_79 tb8_80 tb8_81 tb8_82 tb8_83 tb8_84 tb8_85 tb8_86 tb8_87 tb8_88 tb8_89 tb8_90 tb8_91 tb8_92 tb8_93 tb8_94 tb8_95 tb8_96 tb8_97
tb8_98 tb8_99 tb8_100 tb8_101 tb8_102 tb8_103 tb8_104 tb8_105 tb8_106 tb8_107 tb8_108 tb8_109 tb8_110 tb8_111 tb8_112 tb8_113 tb8_114 tb8_115
tb8_116 tb8_117 tb8_118 tb8_119 tb8_120 tb8_121 tb8_122 tb8_123 tb8_124 tb8_125 tb8_126 tb8_127 tb8_128 tb8_129 tb8_130 tb8_131 tb8_132 tb8_133
tb8_134 tb8_135 tb8_136 tb8_137 tb8_138 tb8_139 tb8_140 tb8_141 tb8_142 tb8_143 tb8_144 tb9_1 tb9_2 tb9_3 tb9_4 tb9_5 tb9_6 tb9_7 tb9_8 tb9_9
tb9_10 tb9_11 tb9_12 tb9_13 tb9_14 tb9_15 tb9_16 tb9_17 tb9_18 tb9_19 tb9_20 tb9_21 tb9_22 tb9_23 tb9_24 tb9_25 tb9_26 tb9_27 tb9_28 tb9_29
tb9_30 tb9_31 tb9_32 tb9_33 tb9_34 tb9_35 tb9_36 tb9_37 tb9_38 tb9_39 tb9_40 tb9_41 tb9_42 tb9_43 tb9_44 tb9_45 tb9_46 tb9_47 tb9_48 tb9_49
tb9_50 tb9_51 tb9_52 tb9_53 tb9_54 tb9_55 tb9_56 tb9_57 tb9_58 tb9_59 tb9_60 tb9_61 tb9_62 tb9_63 tb9_64 tb9_65 tb9_66 tb9_67 tb9_68 tb9_69
tb9_70 tb9_71 tb9_72 tb9_73 tb9_74 tb9_75 tb9_76 tb9_77 tb9_78 tb9_79 tb9_80 tb9_81 tb9_82 tb9_83 tb9_84 tb9_85 tb9_86 tb9_87 tb9_88 tb9_89
tb9_90 tb9_91 tb9_92 tb9_93 tb9_94 tb9_95 tb9_96 tb9_97 tb9_98 tb9_99 tb9_100 tb9_101 tb9_102 tb9_103 tb9_104 tb9_105 tb9_106 tb9_107 tb9_108
tb9_109 tb9_110 tb9_111 tb9_112 tb9_113 tb9_114 tb9_115 tb9_116 tb9_117 tb9_118 tb9_119 tb9_120 tb9_121 tb9_122 tb9_123 tb9_124 tb9_125
tb9_126 tb9_127 tb9_128 tb9_129 tb9_130 tb9_131 tb9_132 tb9_133 tb9_134 tb9_135 tb9_136 tb9_137 tb9_138 tb9_139 tb9_140 tb9_141 tb9_142 tb9_143 tb9_144							
'0'	 	'nein'	
'1'	 	'ja'	.
value labels tc1ax
'-2' 'trifft nicht zu'	.
value labels tc1bx
'-2' 'trifft nicht zu'	.
value labels tc1cx
'-2' 'trifft nicht zu'	.
value labels tc2ax
'-2' 'trifft nicht zu'	.
value labels tc2bx
'-2' 'trifft nicht zu'	.
value labels tc2cx
'-2' 'trifft nicht zu'	.
value labels tc3ax
'-2' 'trifft nicht zu'	.
value labels tc3bx
'-2' 'trifft nicht zu'	.
value labels tc3cx
'-2' 'trifft nicht zu'	.
value labels 	tc4		
	'-1' 'keine Angabe'
	'1' 'normal'
	'2' 'ungewöhnlich'.
value labels 	tc5				
	'-1' 'keine Angabe'
	'1' 'keine Reise'
	'2' 'Tagesreise'
	'3' 'Reise mit Übernachtung'.
value labels 	tc6				
	'-1' 'keine Angabe'
	'1' 'über den Tag verteilt'
	'2' 'am Ende des Tages'
	'3' 'am Tag danach'
	'4' 'mehrere Tage später'.
value labels 	tc7				
	'-1' 'keine Angabe'
	'1' 'ja'
	'2' 'nein'.
value labels 	tc8				
'-2' 'trifft nicht zu'	
	'-1' 'keine Angabe'
	'1' 'ja'
	'2' 'nein'.
value labels 	wtagfei				
	'1' 'Montag'
	'2' 'Dienstag'
	'3' 'Mittwoch'
	'4' 'Donnerstag'
	'5' 'Freitag'
	'6' 'Samstag/Heiligabend/Silvester'
	'7' 'Sonntag/Feiertag'.
value labels 	fehl_tag				
	'0' 'Person hat 3 Tagebuchtage ausgefüllt'
	'1' 'Tag 1 fehlt'
	'2' 'Tag 2 fehlt'
	'3' 'Tag 3 fehlt'.
value labels 	quartal				
	'1' '1. Quartal'
	'2' '2. Quartal'
	'3' '3. Quartal'
	'4' '4. Quartal'.
value labels 	selbtag				
	'-2' 'trifft nicht zu'
	'1' 'ja'
	'2' 'nein'.

*			  (V) ZVE 13 takt		
*					 (iv) Speichern als SPSS-Datei.

SAVE outfile=!Pfad4+!Dateiname4.

EXECUTE.


