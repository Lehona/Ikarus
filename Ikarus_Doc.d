//######################################################
//
//  Dokumentation zum Skriptpaket "Ikarus"
//      Autor   : Sektenspinner
//      Version : 1.1.4
//
//######################################################
    
/*
    Inhalt
        I.   ) Abgrenzung
        II.  ) Voraussetzungen / Setup
                1. Ikarus unter Gothic 2
                2. Ikarus unter Gothic 1
                3. Setup
        III. ) Zu Grunde liegende Konzepte
                1. Der Speicher, Adressen und Zeiger
                2. Klassen
                3. Nicht darstellbare primitive Datentypen
        IV.  ) Klassen
        V.   ) Funktionen
                1. Elementarer Speicherzugriff
                2. Parser Zeug
                3. Sprünge
                4. String Funktionen
                5. Menü-Funktionen
                6. Globale Instanzen initialisieren
                7. Ini Zugriff
                  * 7.1. Tastenzuordnungen
                8. Tastendrücke erkennen
                9. Maschinencode ausführen
               10. Enginefunktionen aufrufen
               11. Externe Biblioteken
               12. Verschiedenes
               13. "Obskure" Funktionen
        VI.  ) Gefahren
        VII. ) Beispiele
*/

//######################################
// I. Abgrenzung
//######################################

"Ikarus" ist eine Sammlung von Engine Klassen (bzw. ihrem Speicherbild) 
und einigen Funktionen, die helfen mit diesen Klassen umzugehen. Ikarus 
ist nützlich um jenseits der Grenzen von Daedalus aber innerhalb der 
Grenzen der ZenGin zu arbeiten. Dadurch können einige sonst 
unerreichbare Daten und Objekte ausgewertet und verändert werden, 
darunter einige, die für Modder durchaus interessant sind. Ferner können 
mit fortgesschrittenen Methoden auch Engine Funktionen aus den Skripten 
heraus aufgerufen werden.
Ikarus eröffnet nur sehr begrenzte Möglichkeiten das Verhalten der 
ZenGin selbst zu verändern.

//######################################
// II. Voraussetzungen / Setup
//######################################

Dieses Skriptpaket setzt ein Verständnis grundlegender 
Programmierkonzepte und eine gute Portion Ausdauer und Forschungsgeist 
voraus. Die meisten Klasseneigenschaften sind nicht dokumentiert, das 
heißt oft muss man ausprobieren ob sie das tun, was man erwartet.
Das WoG-Editing Forum ist ein guter Ort um Erfahrungen mit den Klassen 
und Eigenschaften auszutauschen, damit das Rad nicht ständig neu 
erfunden werden muss.

//--------------------------------------
// 1.) Ikarus unter Gothic 2
//--------------------------------------

Dieses Skriptpaket ist nur auf einer Gothic 2 Reportversion lauffähig. 
Auf anderen Gothic Versionen wird die Nutzung dieser Skripte zu 
Abstürzen führen. Wer sich also dazu entscheidet, dieses Skriptpaket zu 
verwenden, muss dafür sorgen, dass die Spieler der Mod ebenfalls die 
Reportversion nutzen.
Neuere Reportversionen als 2.6.0.0 (zur Zeit bei Nico in Planung) werden 
KEINE Probleme bereiten und werden voll mit diesem Paket kompatibel sein.

//--------------------------------------
// 2.) Ikarus unter Gothic 1
//--------------------------------------

Ikarus wurde ursprünglich nur für Gothic 2 erstellt. Mittlerweile ist 
Ikarus aber relativ gut mit Gothic 1 in der Version 1.08k_mod (neuste 
Playerkit-Version) lauffähig. Allerdings sind noch nicht alle Klassen an 
Gothic 1 angepasst. Nicht angepasste Klassen tragen ein ".unverified" im 
Namen. Zur Zeit (Stand September 2010) ist insbesondere zCMenuItem 
fehlerhaft, weshalb auch diesbetreffende Ikarus Funktionen abstürzen 
werden. oCAIHuman und zCCamera sind ebenfalls noch nicht angepasst.
Abgesehen davon sind mir keine Fehler bekannt.

//--------------------------------------
// 3.) Setup
//--------------------------------------

Ikarus besteht aus drei Teilen, Konstanten, Klassen und dem Ikarus-Kern, 
die in genau dieser Reihenfolge geparst werden müssen. Der Ikarus-Kern 
ist für Gothic 1 und 2 identisch und besteht aus der einzigen Datei 
Ikarus.d. Für die Konstanten und Klassen gibt es dagegen jeweils eine 
Gothic 1 und eine Gothic 2 Version von der natürlich jeweils genau die 
richtige geparst werden muss. Ikarus nutzt einen C_NPC und muss daher 
nach der C_NPC Klasse (nach der Datei classes.d) geparst werden. Andere 
Abhängigkeiten gibt es nicht.

In der Konstantendatei gibt es ein paar Nutzervariablen mit denen unter 
anderem die Debugausgabe von Ikarus geregelt wird.

Beispielsweise könnte man in einer Gothic 2 Installation die 
Ikarus-Dateien in das Verzeichnis _intern packen und die Gothic.src so 
verändern, dass sie folgendermaßen beginnt:

//******************

_INTERN\CONSTANTS.D
_INTERN\CLASSES.D

_INTERN\Ikarus_Const_G2.d
_INTERN\EngineClasses_G2\*.d
_INTERN\Ikarus.d

AI\AI_INTERN\AI_CONSTANTS.D
[...]

//******************

//######################################
// III. Zu Grunde liegende Konzepte
//######################################

Ich habe versucht den folgenden Text so zu schreiben, dass auch 
programmiertechnisch Unbedarfte sich ein Bild davon machen können, worum 
es hier geht. Das soll nicht heißen, dass programmiertechnisch 
Unbedarfte das Paket nach lesen dieses Textes sofort effektiv nutzen 
können. Aber ich wollte lieber etwas zu viel schreiben, als zu wenig.
Wer sich mit Programmieren auskennt sollte mindestens Punkt 1 und 2 
problemlos überspringen können.

//--------------------------------------
// 1.) Der Speicher, Adressen und Zeiger

Der Speicher ist eine große Tabelle von Daten. Die Positionen in der 
Tabelle werden durch Adressen benannt, also positive ganze Zahlen. An 
jeder so identifizierten Speicherzelle steht ein Byte mit Daten (also 
ein Wort, das aus 8 binären Ziffern (0 oder 1) besteht, zum Beispiel 
00101010). Meistens erstreckt sich ein Datum (also eine Dateneinheit) 
über mehrere zusammenhängende Speicherzellen, oft 4 Stück.

Wenn Gothic ausgeführt wird, liegt Gothic im Speicher herum. "Gothic" 
ist im dem Fall sowohl das Programm selbst (der Maschinencode) als auch 
die Daten auf denen Gothic arbeitet. Programm und Daten sind in 
getrennten Bereichen (Segmenten), für die getrennte 
Zugriffsberechtigungen gelten. Auf das Datensegment darf lesend und 
schreibend zugegriffen werden und das ist auch das Segment mit dem sich 
dieses Skriptpaket beschäftigt.
Während Gothic arbeitet, werden immer wieder neue Objekte angelegt und 
nicht mehr benötigte Objekte zerstört, was es schwierig machen kann, ein 
bestimmtes Objekt, sagen wir eine bestimmte Truhe zu finden, da man 
nicht von vorneherein wissen kann, wo die Daten zu dieser Truhe im 
Speicher aufbewahrt werden.
Ganz bestimmte Objekte kann man aber sehr leicht finden. Das sind 
meistens sehr wichtige Objekte, die es nur einmal gibt (und irgendetwas 
muss ja leicht zu finden sein, sonst könnte die Engine selbst ja gar 
nicht arbeiten). Oft ist vereinbahrt, dass ein solches wichtiges Objekt 
immer an einer ganz bestimmten Speicherstelle zu finden ist (man weiß 
schon, wo man suchen muss, bevor man das Programm ausführt). In diesem 
Fall, muss man nur auf die passende Speicherstelle zugreifen und hat die 
Daten gefunden, die man will.
Wenn die Position des Objekts im Speicher nicht bekannt ist, gibt es 
manchmal eine Stelle im Speicher, an der man die aktuelle Adresse des 
Objekts nachschauen kann. Dann kann man das Objekt indirekt finden, in 
dem man zunächst an einem wohlbekannten Ort nachschlägt, wo das Objekt 
liegt und mit diesem Wissen anschließend darauf zugreift.

Vergleichbar ist das mit einem Buch: Angenommen wir suchen Kapitel 5. 
Wenn wir wissen, dass Kapitel 5 auf Seite 42 anfängt, können wir das 
Buch direkt richtig aufschlagen.
Im Allgemeinen wird es aber so sein, dass wir das nicht wissen (denn bei 
verschiedenen Büchern sind die Kapitelanfänge im Allgemeinen auf 
verschiedenen Seiten). Zum Glück gibt es die Vereinbahrung, dass das 
Inhaltsverzeichnis immer am Anfang des Buches ist, das heißt wir können 
das Inhaltsverzeichnis finden und dort nachschauen wo Kapitel 5 anfängt. 
Mit diesem Wissen ist dann Kapitel 5 leicht zu finden.

Navigation im Speicher ist im Grunde genau dies: Von wenigen Objekten 
ist bekannt, wo sie herumliegen. Sie dienen als eine Art 
Inhaltsverzeichnis und beinhalten Verweise auf andere Objekte. Diese 
Verweise nennt man auch Zeiger oder Pointer.

Beispiel:
An Speicherstelle 0xAB0884 (das ist hexadezimal für 11208836, also auch 
nur eine Zahl) steht immer die Adresse das aktuellen oGame (das ist eine 
Datensammlung, die wichtige Informationen zur aktuellen Spielsitzung 
enthält). Wenn man diesem Verweis folgt, findet man also ein Objekt vom 
Typ oCGame. Dieses Objekt beinhaltet verschiedene Eigenschaften, unter 
anderem die Eigenschaft "world". Hier findet sich abermals eine Adresse, 
die diesmal auf ein Objekt vom Typ oWorld zeigt. Hier findet sich 
widerum ein Verweis auf einen zCSkyController_Outdoor, der hat unter 
anderem eine Textur, die widerum Daten hat... So kann man sich nach und 
nach vom großen Ganzen auf einen einzelnen Pixel am Himmel vorhangeln.

//--------------------------------------
// 2.) Klassen

Ich habe bereits von Objekten gesprochen, die Eigenschaften haben. Es 
ist aber so, dass Speicher im Computer etwas unstrukturiertes, 
"untypisiertes" ist. Man sieht einem Speicherbereich nicht an, ob es 
sich bei seinem Inhalt zum Beispiel um eine Kommazahl, eine Zeichenkette 
oder um Farbwerte handelt. Das heißt, selbst wenn man sich überlegt, was 
man unter einem Baum, einer Truhe oder einem Npc versteht, muss man 
genau festlegen in welcher Reihenfolge welche Daten abgelegt werden. Das 
nennt man auch das Speicherlayout eines Objekts und wird in Daedalus als 
Klasse notiert. Beispiel:

class cSandwich {
    var cToast oben;
    var cKäse käse;
    var cToast unten;
};

Dies beschreibt eine Klasse, die drei Unterobjekte beinhaltet. Direkt am 
Anfang der Klasse steht ein Objekt vom Typ cToast, dann kommt ein Objekt 
vom Typ cKäse und dann noch ein Objekt vom Typ cToast. Leider kann man 
das in Daedalus nicht so hinschreiben, sondern die Unterobjekte müssen 
in primitive Typen heruntergebrochen werden. Wenn man verfolgt, was ein 
cToast und cKäse ist, könnte man das Speicherbild von cSandwich 
vielleicht so beschreiben:

class cSandwich {
    //var cToast oben;
        var int oben_bräunungsgrad;
        var int oben_Gebuttert;
    //var cKäse käse;
        var string käse_name;
        var int käse_fettgehalt;
    //var cToast unten;
        var int unten_bräunungsgrad;
        var int unten_Gebuttert;
};

Wenn man ein konkretes Sandwich sw vorliegen hätte, könnte sw.käse_name 
zum Beispiel "Edammer" sein und sw.unten_gebuttert könnte 1 sein, das 
heißt der untere Toast wäre mit Butter bestrichen.

Mit dem Wissen, dass eine Ganzzahl (int) immer 4 Byte groß ist und ein 
string immer 20 Byte, weiß man schon viel über die Klasse.

Angenommen, ein cSandwich stünde an Speicherposition 123452 (das heißt, 
das Objekt beginnt dort), dann findet man an Position 123452 den Wert 
"oben_bräunungsgrad", an Position 123456 den wert "oben_Gebuttert", an 
Position 123460 die Zeichenkette "käse_name", an Position 123480 den 
Wert "käse_fettgehalt" usw..

Auch wenn dieser Hintergrund nicht unbedingt notwendig ist, um dieses 
Paket zu benutzen, halte ich es für nützlich dies zu verstehen.

//--------------------------------------
// 3.) Nicht darstellbare primitive Datentypen

Nicht alle primitiven Datentypen ("primitiv" heißt nicht weiter sinnvoll 
zerteilbar) die die ZenGin kennt, sind in Daedalus auch verfügbar. 
Deadalus kennt nur Ganzzahlen (int) und Zeichenketten (string). Das 
heißt aber nicht, dass man mit anderen Datentypen nicht auch arbeiten 
könnte, aber man muss darauf achten die Datentypen korrekt zu behandeln.

Ein bisschen ist das, als hätte man einen Chemieschrank und auf jeder 
Flasche steht "Destilliertes Wasser", obwohl sich in bei weitem nicht 
allen Flaschen genau das verbirgt. Die Chemikalien funktionieren 
natürlich noch genauso gut, solange man weiß, was wirklich hinter den 
Ettiketten steckt. Wenn man aber eine Säure behandelt, als wäre sie 
Wasser, wird einen das Ettikett nicht eines besseren belehren und es 
knallt (unter Umständen).

Das "Destillierte Wasser" ist in unserem Fall eine Ganzzahl, also ein 
integer der Größe 32 bit. Alles was nicht gerade Zeichenkette ist, ist 
in den Klassen dieses Pakets als solche Ganzzahl deklariert. Was sich 
wirklich dahinter verbirgt, geht aus den Kommentaren hervor.

Einige wichtige Datentypen sind:

//##### int ######
Wenn es nicht nur als int deklariert ist, sondern auch im Kommentar 
steht, dass es ein int ist, dann ist es ein int! Also eine gewöhnliche 4 
Byte große Ganzzahl mit Vorzeichen.

//##### zREAL ####
Ein zREAL ist ein 4 Byte IEEE Float, oft mit "single" bezeichnet. Das 
ist eine Gleitkommazahl mit der man in Daedalus normalerweise nicht 
rechnen kann. Ich habe aber mal Funktionen geschrieben, die solche 
Zahlen verarbeiten können:
http://forum.worldofplayers.de/forum/showthread.php?t=500080
Zum Beispiel bietet diese Skriptsammlung eine Funktion roundf, die einen 
solchen zREAL in eine Ganzzahl umwandelt (rundet).

//##### zBOOL ####
(Sinnloserweise) auch 4 Byte groß. Ein zBOOL ist wie eine Ganzzahl, aber 
mit der Vereinbahrung, dass nur zwischen "der Wert ist 0" und "der Wert 
ist nicht 0" unterschieden wird. Ein zBOOL hat also die Bedeutung eines 
Wahrheitswerts. 0 steht für falsch/unzutreffend, 1 steht für 
wahr/zutreffend.

//##### zDWORD ####

Eine 4 Byte große Zahl ohne Vorzeichen. Das heißt die 
Vergleichsoperationen <, <=, >, >= liefern mitunter falsche Ergebnisse, 
da ein sehr großes zDWORD als negative Zahl interpretiert wird, obwohl 
eine positive Zahl gemeint ist. Das sollte aber nur in Außnahmefällen 
von Bedeutung sein, im Regelfall kann ein zDWORD behandelt werden wie 
ein Integer, solange man nicht versucht negative Werte hineinzuschreiben.

//#### zCOLOR ####

Ein 4 Byte großes Speicherwort, bei dem jedes Byte für einen Farbkanal 
steht: blau, grün, rot und alpha. Jeder Kanal ist also mit 8 bit 
aufgelöst. Die Farbe "orange" würde als Hexadezimalzahl interpretiert so 
aussehen:

0xFFFF7F00

blauer Kanal: 00, es ist kein Blauanteil in der Farbe.
grüner Kanal: 7F, also mittelstark vertreten
roter Kanal: FF, also so rot als möglich.
alpha Kanal: FF, also volle Opazität.

Die scheinbar umgekehrte Reihenfolge kommt daher, dass die 
niederwertigen Bytes auch an den kleineren Adressen steht. Im Speicher 
sieht die Farbe so aus:

Byte0: 00
Byte1: 7F
Byte2: FF
Byte3: FF

Siehe dazu auch "little Endian" z.B. in der Wikipedia.

//##### zVEC3 #####

Dies ist kein primitiver Datentyp, wird aber oft verwendet: Es ist ein 
Trippel aus drei zREALs und stellt einen Vektor im dreidimensionalen 
Raum dar. Deklariert habe ich solche zVEC3 in der Regel als integer 
Arrays der Länge 3.

//## Zeigertypen ###

Ein Zeiger ist ein vier Byte großes Speicherwort und enthält die Adresse 
eines anderen Objekts. In aller Regel weiß man von welchem Typ das 
Objekt ist, auf das der Zeiger zeigt. Als Datentyp des Zeigers gibt man 
den Datentyp des Objekts an, auf das gezeigt wird und versieht diesen 
mit einem *. Nehmen wir mal an, wir treffen auf folgendes:

var int ptr; //cSandwich*

Dass ptr als Integer deklariert ist, soll uns nicht weiter stören, der 
wahre Datentyp steht im Kommentar: Es ist (kein cSandwich aber) ein 
Zeiger auf ein cSandwich (die Klasse aus dem vorherigen Abschnitt). Das 
heißt, nimmt man den Wert von ptr her und interpretiert ihn als Adresse, 
wird man an dieser Adresse ein cSandwich im Speicher vorfinden. An 
folgenden Adressen ist also folgendes zu finden:

ptr + 0     : int oben_bräunungsgrad
ptr + 4     : int oben_Gebuttert
ptr + 8     : string käse_name
ptr + 28    : int käse_fettgehalt
ptr + 32    : int unten_bräunungsgrad
ptr + 36    : int unten_Gebuttert     

(man beachte, dass ein Integer 4 Byte und ein String 20 Byte groß ist)

Es kann auch sein, dass ein Zeiger auf gar kein Objekt zeigt. Dann ist 
sein Wert (als Zahl interpretiert) 0. Man spricht von einem Null-Zeiger. 
Zum Beispiel könnte ein Zeiger auf die aktuelle Spielsitzung Null sein, 
solange der Spieler noch im Hauptmenü ist und gar keine Sitzung 
existiert.

Natürlich gibt es auch Zeiger auf Zeiger. Diese sind dann entsprechend 
mit zusätzlichen Sternen gekennzeichnet.

//######################################
// IV. Die Klassen
//######################################

Die Klassen, die ich herausgesucht habe, sind bei weitem nicht alle 
Klassen der Engine (es gibt viel mehr). Aber es sind die Klassen, von 
denen ich glaube, dass sie für Modder am interessantesten sein können.

Ich habe versucht zu jeder Klasse unter dem Punkt "nützlich für" ein 
Beispiel zu nennen, wofür man das Wissen über und den Zugriff auf diese 
Klassen nutzen könnte. Vielleicht sind manche der genannten Sachen 
schwieriger als ich vermute. Ich habe das meiste nämlich nicht 
ausprobiert.

//########### oCGame #############

Hält Eigenschaften der Session und Referenzen auf zahlreiche globalen 
Objekte, zum Beispiel die Welt oder den InfoManager. Einige 
Einstellungen sind auch interessant.

Nützlich für:
-Marvin Modus an und ausschalten (game_testmode)
-Spiel pausieren (singleStep)
-Interface ausschalten wie mit toggle Desktop (game_drawall)
-uvm.

//##### oCInformationManager #####

Das Objekt, dass die Anzeige von Dialogen übernimmt. Kümmert sich zum 
Beispiel darum, dass in den Views die passenden Dinge angezeigt werden.

Nützlich für:
-Diry Hacks mit isDone, z.B. um während eines Dialogs ein Dokument 
anzuzeigen
-herausfinden, was im Dialog gerade passiert, z.B ob der Spieler gerade 
eine Auswahl treffen muss.
-?

//######## oCInfoManager #########

Hält eine Liste aller Skript-Infos (oCInfo).

Nützlich für:
-?

//########## oCInfo ##############

In weiten Teilen schon in Daedalus bekannt. Zusätzlich ist eine Liste 
von Choices erreichbar sowieso die Eigenschaft "told", die in Daedalus 
über Npc_KnowsInfo gelesen werden kann.

Nützlich für:
-Choiceliste bearbeiten. Man könnte eine Funktion implementieren, die 
nur selektiv eine Choice aus der Liste entfernt.
-Nach Choicewahl durch den Nutzer entscheiden, welche Choice gewählt 
wurde, selbst wenn alle Choices die selbe Funktion benutzen (man kann 
sich unbegrenzt viele Dialogoptionen zur Laufzeit überlegen).
-Einen nicht permanenten, schon erhaltenen Dialog wieder freischalten.

//######## oCInfoChoice ##########

Hält einen Beschreibungstext und den Symbolindex der Funktion, die 
aufgerufen werden soll.

//#### oCMob und Unterklassen ####

Die verschiedenen Mobs sind aus dem Spacer bekannt. Besonders die 
verschließbaren Mobs sind interessant.

Nützlich für:
-Das vom Spieler fokussierte Mob (oCNpc.focus_vob) bearbeiten, zum 
Beispiel Truhen durch Zauber öffnen.
-Von Npc geöffnete Tür wieder verschließen.

//######## zCVob und oCNpc #######

Sind vollständig von Nico übernommen. Einen oCNpc vollständig zu kennen 
hat dieses Skriptpaket erst möglich gemacht!

Nützlich für:
-Positionsdaten auslesen und verändern.
-Heldenfokus analysieren
-Zugriff auf einen ganzen Haufen anderer Dinge

//############ oCItem ############

Vobs mit bekannten Skripteigenschaften. Zusätzlich lässt die Eigenschaft 
"instanz" auf die Skriptinstanz des Items schließen. "amount" (für 
fallengelassenen Itemstapel) sollte nicht vergessen werden zu 
berücksichtigen, wo nötig.

Nützlich für:
-Items für den Helden beim Tauchen aufheben
-Telekinese?

//######### zCCamera #############

Die Kamera eben. :-)
Aber Vorsicht: Die zCCamera ist kein zCVob. Sie hält aber eine Referenz 
auf ein Hilfsvob (connectedVob).

Nützlich für:
-Positionsdaten ermitteln
-Screenblende einbauen (i.d.R. aber über VFX leichter möglich).

//##### zCMenu / zCMenuItem ######

Das Hauptmenü ist ein Menü. Der "Spiel starten" Button ist ein 
Menüelement. Es gibt aber noch mehr Menüs (zum Beispiel das Statusmenü) 
die ihrerseits Menüitems beinhalten.

Vorsicht: Zum Teil werden diese Objekte nur beim ersten mal erstellt und 
dann im Speicher behalten (auch beim Laden eines anderen Savegames!) zum 
Teil werden sie bei jeder Benutzung neu erzeugt.

Nützlich für:
-Charaktermenü überarbeiten (ziemlich fummlig)
-Speichern Menü-Item unter bestimmten Umständen deaktivieren 
(Realisierung von Speicherpunkten / Speicherzonen).

//########## zCOption ############

Kapselt die Informationen der Gothic.ini und der [ModName].ini. 
Funktionen um die Daten zu lesen und zu verändern stehen in Ikarus 
bereit.

Nützlich für:
-Daten Sessionübergreifend festhalten (Lade / Speicherverhalten, 
Schwierigkeitsgrad...)
-Einstellungen des Spielers lesen (zum Beispiel Sichtweite)

//########## zCParser ############

Der Parser ist nicht nur die Klasse, die beim Kompilieren der Skripte 
meckert sondern auch eine virtuelle Maschine, die den kompilierten Code 
ausführt. Der Parser hält zudem die Symboltabelle.

Nützlich für:
-Daedalus Code zur Laufzeit bearbeiten (Parser Stack).

//######## zCPar_Symbol ##########

Jedes logische Konstrukt (Variable, Instanz, Funktion, Klasse) wird über 
ein Symbol identifiziert. Im Grunde sind alle diese Objekte der Reihe 
nach durchnummeriert. Mit dieser Nummer erreicht man über die 
Symboltabelle des Parsers diese Symbole. Ein Symbol hat einen Namen und 
seinen Inhalt, der verschiedenen Typs sein kann.

Nützlich für:
-"call by reference"
-Funktionen anhand ihres Namens aufrufen
-Instance-Offsets bearbeiten.

//#### zCSkyController_Outdoor ####

Beinhaltet alles, was mit dem Himmel zu tun hat. Insbesondere die 
Planeten (Sonne und Mond), eine Farbtabelle zur Beleuchtung (je nach 
Tageszeit verschieden) (nicht aber die Lightmap selbst, die ist auf die 
Polys verteilt) sowie aktuelle Regeneinstellungen.

Nützlich für:
-Regen starten
-Das Sonnenlicht umfärben
-Aussehen der Planeten (Sonne / Mond) ändern

//## zCTrigger und Unterklassen ###

zCTrigger, oCTriggerScript, oCTriggerChangeLevel und oCMover sind aus 
dem Spacer bekannt. Jetzt kann man auch auf sie zugreifen.

Nützlich für:
-Ziel eines oCTriggerScripts verändern
-Triggerschleife bauen, die jeden Frame feuert, indem nach einem 
Wld_SendTrigger die Eigenschaft _zCVob_nextOnTimer auf die aktuelle Zeit 
gesetzt wird (siehe zTimer).

//####### zCWaynet und Co #########

Das zCWaynet beinhaltet eine Liste von allen zCWaypoints und allen 
oCWays (das sind die roten Linien zwischen den Waypoints). zCWaypoints 
sind keine Vobs, aber jeder zCWaypoint hat ein Hilfsvob in der Welt 
(einen zCVobWaypoint), der auch wirklich ein Vob ist, aber sonst nichts 
kann.
Jeder oCWay kennt die beiden beteiligten zCWaypoints zwischen denen er 
verläuft und jeder zCWaypoints kennt alle oCWays, die von ihm ausgehen. 

Nützlich für:
-?

//########### oWorld ##############

Hält neben dem Vobbaum, in dem alle Vobs enthalten sind auch Dinge wie 
SkyController und Waynet. Außerdem gibt es neben dem sehr technischen 
Bsp-Tree noch die activeVobList, die alle Vobs enthält die auf 
irgendeine Art selbst aktiv sind. Das sind Npcs, Trigger usw. In jedem 
Frame wird die activeVobList in die walkList kopiert. Die walkList wird 
dann sequenziell durchlaufen. 

Nützlich für:
-Objekte in der Welt suchen, zum Beispiel Npcs (voblist_npcs), items 
(voblist_items), alle Vobs mit AI, z.B. auch Trigger (activeVobList)
-Mir ist es mit rumgehacke an activeVobList und walklist gelungen alles 
außer den Helden einzufrieren und später zu reaktivieren

//######## zCZoneZFog #############

Fogzones sind Gebiete mit (möglicherweise farbigem) Nebel, der die 
Sichtweite beeinflusst.

Nützlich für:
-evtl. mysteriöse Orte mit obskuren Farbwechseln
-möglicherweise automatische Sichtweiten Korrektur abhängig von der 
Framerate

//####### VERSCHIEDENES ###########

//zCTree
Ein Knoten in einem Baum. Das kann ein innerer Knoten oder ein 
Blattknoten sein.
Es gibt Zeiger auf das erste Kind, den linken und rechten 
Geschwisterknoten sowie den Elternknoten.
Natürlich gibt es auch einen Zeiger auf die Daten.
Der Vobtree ist aus zCTrees aufgebaut.

//zCArray
Ein zCArray dient zur Verwaltung eines Felds von Daten. Das zCArray hat 
einen Zeiger auf die Speicherzelle in der das Feld beginnt.
Die Daten sind in diesem Feld einfach aneinandergereit. Das zCArray 
kennt zudem die Anzahl der Objekte im Feld (wichtig um nicht jenseits 
des Feldendes zu lesen). Unter Umständen ist mehr Speicher alloziert als 
das Feld gerade groß ist, daher kennt das zCArray neben der Größe des 
Feldes auch die Größe des reservierten Speichers.

//zCArraySort
Wie ein Array, nur dass die Objekte immer auf bestimmte Art und Weise 
geordnet sind (es sei denn, du machst diese Ordnung kaputt).

//zList
Sehr gewöhnungsbedürftige generische Liste, die mit der Eigenschaft 
"next" des generischen Typs arbeitet. Kaum verwendet.

//zCList
Ein Listenelement. Beinhaltet den Zeiger auf genau ein Objekt (die 
Daten) und einen Zeiger auf das nächste Listenelement.

//zCListSort
Wie ein Listenelement, nur dass die Gesamtheit der Listenelemente auf 
bestimmte Art und Weise geordnet ist (es sei denn du machst diese 
Ordnung kaputt).

//zCTimer
Man kann ablesen wie lange ein Frame braucht und es gibt Tuning 
Parameter für minimale und maximale Framerate. Vorsicht. Hieran drehen, 
kann dazu führen, dass das Spiel einfriert!

//oCWorldTimer
Enthält die Weltzeit (0 = 0:00, 6000000 = 24:00) und den aktuellen Tag.

//oCSpawnManager
Enthält ein Array aller im Moment gespawnter Npcs. Das Spawnen kann 
ausgeschaltet werden (spawningEnabled). Die eigentlich interessanten 
Werte, die insert und remove Reichweite sind statisch, ich habe die 
Adressen dieser Werte über der Klasse angegeben.

//oCPortalRoom und oCPortalRoomManager
Der einzige oCPortalRoomManager der Welt kennt alle oCPortalRooms. Zudem 
wird festgehalten in welchem Raum der Spieler gerade ist (curPlayerRoom) 
und wo er vorher war (oldPlayerRoom).
Jeder oCPortalRoom hat einen Besitzer, eine Besitzergilde und einen 
Namen.

//zCVobLight
Ein Licht. Es ist zu erwarten, dass der Bsp-Tree wissen muss, welche 
Lichter welches Weltsegment betreffen. Daher ist nicht ganz klar, in 
welchen Grenzen man zum Beispiel Lichter verschieben oder den 
Leuchtradius vergrößern kann. Die Farbe des Lichtes lässt sich aber zum 
Beispiel problemlos verändern.

//oCMag_Book
Wird genutzt um den Kreis über dem Spieler bei der Zauberauswahl 
anzuzeigen. Außerdem enthält diese Klasse Zuordnungen von Zaubern <-> 
Items <-> Tasten.

//zString
Ein String. Da diese Klasse ein Daedalus-Primitiv ist, ist es in aller 
Regel nicht nötig, auf die einzelnen Eigenschaften zuzugreifen. Ich habe 
diese Eigenschaften allerdings gebraucht um Speicherallokation zu 
implementieren.

//######################################
// V. Die Funktionen
//######################################

Ikarusfunktionen beginnen mit dem Präfix "MEM_". Das soll eine Kurzform 
von "Memory" sein und neben der Zugehörigkeit zu Ikarus auch andeuten, 
dass Eingriffe in den Speicher von Gothic stattfinden (und evtl. 
entsprechende Vorsicht geboten ist).
Funktionen mit dem Präfix "MEMINT_" sind interne ("private") Funktionen 
von Ikarus die nach außen hin keine sinnvolle Anwendungen haben oder 
zumindest undokumentiert sind. Es ist nicht garantiert, dass solche 
Funktionen in späteren Ikarus Versionen in dieser Form enthalten sein 
werden.
Eine Ausnahme bilden Stringbearbeitungsfunktionen, die ein eigenes 
Präfix "STR_" besitzen.

//######################################
// 1.) Elementarer Speicherzugriff

Lesen und schreiben von strings und integern ist mit folgenden 
Funktionen möglich:

func int    MEM_ReadInt     (var int address)
func void   MEM_WriteInt    (var int address, var int val)
func string MEM_ReadString  (var int address)
func void   MEM_WriteString (var int address, var string val)

Wenn address <= 0 ist, wird ein Fehler ausgegeben. Andernfalls wird 
versucht an dieser Adresse zu lesen bzw. zu schreiben.
Liegt die Adresse in einem ungültigen Bereich, zum Beispiel in einem 
Codesegment, gibt es eine Zugriffsverletzung (Gothic stürzt ab).
Bei Stringoperationen ist es zudem nötig, dass an der angegebene Stelle 
bereits ein gültiger zString steht. Wenn dort Unsinn steht, kann lesen 
und schreiben gleichmaßen Gothic zum Absturz bringen.

Ein Beispiel für die Benutzung von MEM_WriteInt ist zum Beispiel 
folgende Ikarus Funktion, mit der Debugmeldungen an und ausgeschaltet 
werden können:

//******************
func void MEM_SetShowDebug (var int on) {
    MEM_WriteInt (showDebugAddress, on);
};
//******************

Zudem sind zwei Bequemlichkeitsfunktionen implementiert:

func int MEM_ReadIntArray  (var int arrayAddress, var int offset)
func int MEM_WriteIntArray (var int arrayAddress, var int offset, var 
int value)

Diese Funktionen lesen / schreiben den Wert an Stelle arrayAddress + 4 * 
offset. Beispielsweise könnte man folgendermaßen den i-ten Eintrag in 
der activeVoblist der Welt lesen:

//----------------------
func int GetActiveVob (var int i) {
    MEM_InitGlobalInst(); //MEM_World muss initialisiert sein
    
    if (i >= MEM_World.activeVobList_numInArray)
    || (i < 0) {
        //jenseits der Array Grenze
        MEM_Error ("GetActiveVob: Lesen jenseits der Array Grenze!");
        return 0;
    };
    
    //Den i-ten Eintrag aus der activeVobList holen:
    return MEM_ReadIntArray (MEM_World.activeVobList_array, i);
};
//----------------------

Um auf einzelne Bytes zuzugreifen gibt es außerdem noch:

func int  MEM_ReadByte  (var int adr)
func void MEM_WriteByte (var int adr, var int val)

Hierbei wird nur das Byte an Adresse adr verändert, nicht etwa ein 
ganzes vier Byte Wort. Das heißt, die drei Folgebytes bleiben unberührt. 
Falls in MEM_WriteByte nicht 0 <= val < 256 gilt wird eine Warnung 
ausgegeben, und val entsprechend zugeschnitten. Insbesondere sollten 
keine negativen Zahlen übergeben werden.

//######################################
// 2.) Parser Zeug

Mit der Adresse eines Objekts allein kann man nur sehr unbequem auf die 
Objekteigenschaften zugreifen.
Besser ist es, wenn eine Instanz auf das Objekt zeigt, und dann mit 
"instanz.eigenschaft" auf eine beliebige Eigenschaft zugegriffen werden 
kann.
Dazu gibt es folgende Funktionen:

func instance MEM_PtrToInst  (var int ptr)
func void     MEM_AssignInst (var int inst, var int ptr)

Im Prinzip sind beide für den selben Zweck geschaffen.
MEM_PtrToInst nimmt einen Zeiger entgegen und gibt eine Instanz zurück, 
die in einer Zuweisung genutzt werden kann.
MEM_AssignInst nimmt eine Instanz (eigentlich den Symbolindex) und eine 
Adresse entgegen und sorgt dafür, dass die Instanz auf ptr zeigt.

Als Merkregel: Folgende Formulierungen ist äquivalent:
1.) inst = MEM_PtrToInst (ptr);
2.) MEM_AssignInst (inst, ptr);

Dabei kann inst von beliebigem Objekttyp sein. ptr ist ein Adresse (als 
integer).

Beispiel zur Benutzung:

//----------------------

func void somefunc() {
    //Hole Helden
    var oCNpc her;
    her = Hlp_GetNpc (PC_HERO); 
    
    //Hat der Held ein Vob im Fokus?
    if (!her.focus_vob) { return; };
    
    //Lasse meinFocusVob auf her.focus_vob zeigen
    var zCVob meinFocusVob;
    meinFocusVob = MEM_PtrToInst (her.focus_vob);
    
    //Nutze meinFocusVob, z.B. um Vobnamen auszugeben
    Print (meinFocusVob._zCObject_objectName);
};

//----------------------

Die umgekehrte Funktion zu MEM_PtrToInst ist MEM_InstToPtr. Diese 
Funktion gibt die Adresse des Objekts zurück, auf das die übergebene 
Instanz zeigt.

func int MEM_InstToPtr (var instance inst)

Zum Beispiel liefert MEM_InstToPtr (hero) die Adresse des Helden im 
Speicher.

Eine Funktion um eine Instanz auf das selbe Ziel wie eine andere Instanz 
zeigen zu lassen ist folgende:

func instance MEM_CpyInst (var int inst)

Folgender Code ist äquivalent:
1.) selfCopy = MEM_CpyInst (self);
2.) selfCopy = MEM_PtrToInst (MEM_InstToPtr (self));

Anmerkung: Es gibt ein alias zu MEM_InstToPtr unter dem Namen 
MEM_InstGetOffset.

Anmerkung: Instanzen eines Typs und "Variablen" eines Typs sind 
gleichwertig. Im obigen Beispiel wäre es möglich gewesen "meinFocusVob" 
außerhalb der Funktion als "instance meinFocusVob (zCVob);" zu 
deklarieren.

Anmerkung: MEM_AssignInst und MEM_PtrToInst geben eine Warnung aus, 
falls ptr == 0, weil eine Zuweisung eines Nullzeigers in vielen Fällen 
nicht absichtlich passieren wird. Um ganz bewusst 0 zuzuweisen gibt es 
MEM_AssignInstNull bzw. MEM_NullToInst. Die Benutzung dieser Funktionen 
ist analog, der ptr Parameter entfällt allerdings.

Anmerkung: MEM_AssignInst kann im Gegensatz zu MEM_PtrToInst genutzt 
werden um Instanzen in anderen Parsern zu verändern. In aller Regel ist 
dies aber nicht nötig.

//******************

Nicht immer weiß man zur Kompilierzeit, wann man welche Funktion 
aufrufen will. Wenn man zum Beispiel die Condition-Funktion eines Mobs 
aufrufen will, das der Spieler im Fokus hat, ist man zur Kompilierzeit 
ratlos, weil man nicht ahnen kann, welches Mob sich der Spieler 
aussuchen wird. Ikarus stellt eine Möglichkeit zur Verfügung mit deren 
Hilfe Funktionen anhand ihres Namens oder ihres Symbolindexes aufgerufen 
werden können. Im Beispiel des Mobs, kann der Name der 
Condition-Funktion einfach im Mob nachgeschaut werden.

Die Funktionen sind leicht zu benutzen und leicht zu erklären:

func void MEM_CallByString (var string fnc)
func void MEM_CallByID (var int ID)

MEM_CallByString ruft die Funktion mit Namen fnc auf, hierbei muss der 
Name GROSSGESCHRIEBEN sein. MEM_CallByID ruft die Funktion mit 
Symbolindex ID auf. An den Symbolindex einer Funktion kommt man mit zum 
Beispiel mit MEM_FindParserSymbol oder MEM_GetFuncID (siehe unten). 
MEM_CallByID ist schneller als MEM_CallByString und sollte bevorzugt 
werden, wenn die selbe Funktion sehr oft aufgerufen werden muss.

Falls die aufzurufende Funktion Parameter hat, müssen diese zuvor auf 
den Datenstack gelegt werden. Das geht mit den Funktionen: 

func void MEM_PushIntParam (var int param)
func void MEM_PushStringParam (var string strParam)
func void MEM_PushInstParam (var int instance)

Die Parameter müssen in der richtigen Reihenfolge gepusht werden, von 
links nach rechts.
Hat eine Funktion einen Rückgabewert sollte dieser nach Aufruf vom 
Datenstack heruntergeholt werden, sonst können unter ungünstigen 
Umständen Stacküberläufe entstehen (abgesehen davon will man den 
Rückgabewert vielleicht einfach haben, weil er wichtige Informationen 
enthält).
Dies geht mit den Funktionen:

func int      MEM_PopIntResult()
func string   MEM_PopStringResult()
func instance MEM_PopInstResult()

Siehe dazu Beispiel 5.

Anmerkung: Die genannten Funktionen funktionieren ohne Einschränkung 
auch für Externals.

//******************

Ergänzend zum letzten Abschnitt: 

func int MEM_GetFuncID(var func function)

Gibt den Symbolindex einer Funktion zurück, der zum Beispiel in 
MEM_CallByID verwendet werden kann. Eine Funktion muss (bzgl der Parsing 
Reihenfolge) noch nicht deklariert sein um an MEM_GetFuncID übergeben 
werden zu können.

func void MEM_Call(var func function)

Äquivalent zu MEM_CallByID(MEM_GetFuncID(function)). Dies ermöglicht 
zweierlei interessante Dinge: Zum einen ist es möglich dass sich zwei 
Funktionen gegenseitig aufrufen (was sonst problematisch ist, weil 
normalerweise eine Funktion deklariert sein muss, bevor sie aufgerufen 
werden kann), zum anderen ist es möglich var func parameter sinnvoll zu 
verwenden und somit modulare Algorithmen zu gestalten. Hier ein Beispiel:

//----------------------

func void DoTwice(var func f) {
    /* Wir könnten direkt MEM_Call(f) verwenden.
     * zu Demonstrationszwecken hier aber nochmal
     * eine Zuweisung von Funktionen: */
    var func g; g = f; //(*)
    MEM_Call(g);
    MEM_Call(g);
};

func void bar() {
    DoTwice(foo); //gibt zwei mal "Hello" aus.
};

func void foo() {
    Print("Hello");
};

//----------------------

Beachte:
- Klassenvariablen machen erhebliche Probleme. MEM_Call erlaubt es 
nicht, beispielsweise die on_equip Funktion eines Items aufzurufen. Nur 
gewöhnliche "var func" außerhalb von Klassen funktionieren.
- Gothic legt ein recht unsinniges Verhalten bei der Zuweisung von 
Funktionen an den Tag. An Stelle (*) des obigen Beispiels wird nicht 
etwa der Inhalt von f in g übertragen. Stattdessen wird der Symbolindex 
von f in g geschrieben, das heißt, g verweist nun sozusagen auf f. Mit 
diesem Verhalten kommt MEM_Call klar, MEM_Call wird folgende "Kette" von 
Referenzen vorfinden und zurückverfolgen: MEM_Call.fnc -> DoTwice.g -> 
DoTwice.f -> foo und wird schließlich foo aufrufen. Würden wir an Stelle 
(*) allerdings ein "f = g;" einfügen wäre diese Kette zerstört und f und 
g würden zyklisch aufeinander verweisen. MEM_Call würde in einer 
Endlosschleife gefangen sein. Ich habe das hier an Beispielen diskutiert:

http://forum.worldofplayers.de/forum/threads/
969446-Skriptpaket-Ikarus-3/page11?p=17243175&viewfull=0#post17243175

//******************

func int MEM_FindParserSymbol (var string inst)

Kleines Nebenprodukt: Liefert den Index des Parsersymbols mit Namen inst 
zurück, falls ein solches Symbol existiert. Falls keines existiert wird 
eine Warnung ausgegeben und -1 zurückgegeben. Einen Schritt weiter geht 
die Funktion:

func int MEM_GetParserSymbol (var string inst)

Sie sucht ebenfalls das Parsersymbol mit Namen inst, gibt aber nicht den 
Index zurück sondern direkt einen Zeiger auf das passende zCPar_Symbol. 
Existiert kein solches Symbol wird eine Warnung ausgegeben und 0 
zurückgegeben.

So kann man Variablen anhand ihres Namens finden und bearbeiten. 
Beispiel:

//----------------------

func void SetVarTo (var string variableName, var int value) {
    var int symPtr;
    symPtr = MEM_GetParserSymbol (variableName);
    
    if (symPtr) { //!= 0 
        var zCPar_Symbol sym;
        sym = MEM_PtrToInst (symPtr);
        
        if ((sym.bitfield & zCPar_Symbol_bitfield_type)
                                      == zPAR_TYPE_INT) {
            sym.content = value;
        } else {
            MEM_Error ("SetVarTo: Die Variable ist kein Integer!");
        };
    } else {
        MEM_Error ("SetVarTo: Das Symbol existiert nicht!");
    };
};

func void foo() {
    var int myVar;
    SetVarTo ("FOO.MYVAR", 42); //äquivalent zu myVar = 42;
};

//----------------------

//######################################
// 3.) Sprünge

Rücksprünge sind sehr elegant möglich. Mithilfe zweier einfacher Zeilen 
kann die aktuelle Position im Parserstack (darunter versteht man einen 
maschinennahen Code der beim Kompilieren der Skripte erzeugt wird) 
abgefragt und gesetzt werden. Wird die Position im Parserstack 
verändert, so wird die Ausführung an dieser neuen Stelle fortgesetzt.

Beispiel: Folgender Code gibt die Zahlen von 0 bis 42 aus:

//----------------------

func void foo() {
    /* Initialisierung */
    MEM_InitLabels();
    var int count; count = 0;
    
    /* In label die Ausführungsposition festhalten. */
    var int label;
    label = MEM_StackPos.position;
    /* <---- label zeigt jetzt hierhin,
     * also auf die Stelle NACH der Zuweisung von label. */
    
    Print (ConcatStrings ("COUNT: ", IntToString (count)));
    count += 1;
    
    if (count <= 42) {
        /* Die Ausführungsposition ersetzen,
         * bei dem "<-----" wird dann weitergemacht */
        MEM_StackPos.position = label;
    };
    
    /* Ist 43 erreicht, wird die "Schleife" verlassen. */
};

//----------------------

Wichtig: MEM_InitLabels() muss nach dem Laden eines Spielstandes einmal 
ausgeführt werden. Am einfachsten ist es, diese Funktion aus INIT_GLOBAL 
aufzurufen. Erst nachdem diese Funktion aufgerufen wurde, kann korrekt 
auf MEM_StackPos.position zugegriffen werden!

Anmerkung: MEM_InitLabels wird auch von der Funktion MEM_InitAll 
aufgerufen.

Wichtig: Eigentlich selbstverständlich: Ein Label muss initialisiert 
sein, bevor dorthin gesprungen werden kann! Vorwärtssprünge sind daher 
im Allgemeinen schwierig, weil die Sprungstelle passiert wird, bevor das 
Sprungziel passiert wird.

Wichtig: Labels sind nach Speichern und Laden ungültig. Das heißt ein 
Label muss "sofort" verwendet werden. Ich wüsste aber sowieso keinen 
Grund, weshalb man sich Labels für längere Zeit aufheben sollte.

Wichtig: Wer zwischen verschiedenen Funktionen hin und herspringt und 
nicht weiß, was er tut, wird auf die Nase fallen. Wer mit Labels rechnet 
und nicht weiß was er tut ebenfalls. Allgemeiner: Wer etwas anderes 
macht als Zuweisungen der obigen Art, könnte auf die Nase fallen.

//######################################
// 4.) String Funktionen

//******************

func int STR_GetCharAt (var string str, var int pos)

Liefert das Zeichen am Offset pos im String str zurück (das heißt den 
Zahlwert dieses Zeichens, wie man ihn in der ASCII-Tabelle findet). Die 
Zählung beginnt bei 0. Zum Beispiel ist STR_GetCharAt ("Hello", 1) == 
101, weil 'e' an Position 1 ist und an Stelle 101 in der ASCII-Tabelle 
steht.

//******************

func int STR_Len (var string str)

Liefert die Länge des Strings in Zeichen.

//******************

const int STR_GREATER =  1;
const int STR_EQUAL   =  0;
const int STR_SMALLER = -1;

func int STR_Compare (var string str1, var string str2) {
    
Liefert STR_GREATER, wenn str1 lexikographisch nach str2 kommt und 
entsprechend STR_SMALLER oder STR_EQUAL in den anderen Fällen. Beispiele:

STR_Compare ("A", "B")      -> STR_SMALLER
STR_Compare ("ABC", "ABC")  -> STR_EQUAL
STR_Compare ("AA","A")      -> STR_GREATER
STR_Compare ("BA", "BB")    -> STR_SMALLER
STR_Compare ("B", "a")      -> STR_SMALLER
STR_Compare ("A", "")       -> STR_GREATER

(zum vorletzen Beispiel ist zu bemerken, dass Großbuchstaben 
ironischerweise "kleiner" als Kleinbuchstaben sind, so ist nunmal die 
Reihenfolge in der ASCII-Tabelle)

//******************

func int STR_ToInt (var string str)

Konvertiert die String-Repräsentation einer Ganzzahl in einen Integer. 
Etwa wird "42" in den Integer 42 umgewandelt.

Beispiele für gültige Strings:
1.) 42
2.) +42
3.) -42

Beispiele für ungültige Strings:
1.) ++42
2.) 42+
3.) 4.2
4.) HelloWorld

Im Fehlerfall wird eine Warnung ausgegeben und 0 zurückgegeben.

//******************

func string STR_SubStr (var string str, var int start, var int count)

Gibt den Teilstring von str zurück, der an Index start beginnt und count 
Zeichen lang ist.

Beispiele:
STR_SubStr ("Hello World!", 0, 5): "Hello"
STR_SubStr ("Hello World!", 6, 5): "World"

Als Spezialfall davon ist folgende Funktion implementiert:

func string STR_Prefix (var string str, var int count)

STR_Prefix gibt den String zurück, der aus den ersten count Zeichen von 
str besteht.
Dies entspricht dem Verhalten von STR_SubStr, mit start == 0.

//******************

func string STR_Upper(var string str)

Gibt eine Kopie von str zurück, bei der alle Kleinbuchstaben in die 
entsprechenden Großbuchstaben verwandelt wurden. Die Behandlung ist 
mindestens bei Umlauten fehlerhaft, entspricht aber dem Engineverhalten 
(verwendet wird zString::ToUpper). ASCII Zeichen werden korrekt 
behandelt.

//*********************

func int    STR_SplitCount(var string str,
                           var string Seperator)
func string STR_Split     (var string str,
                           var string Separator, var int index)

STR_Split ist dazu da, einen String dort in mehrere Strings aufzuteilen 
wo ein bestimmtes Zeichen (der Separator) vorkommt.
Der Parameter Index gibt an, der wievielte String nach dieser Aufteilung 
zurückgegeben werden soll.

Zum Beispiel lässt sich ein deutscher Satz in Worte aufteilen, in dem 
der String an Leerzeichen aufgetrennt wird:

//----------------------
func void foo() {
    var string str;  str  = "Das ist ein Satz.";
    var string tok1; tok1 = STR_Split(str, " ", 0);
    var string tok2; tok2 = STR_Split(str, " ", 1);
    var string tok3; tok3 = STR_Split(str, " ", 2);
    var string tok4; tok4 = STR_Split(str, " ", 3);
};
//----------------------

Am Ende der Funktion ist tok1 == "Das", tok2 == "ist", tok3 == "ein" und 
tok4 == "Satz.".

Die Funktion STR_SplitCount gibt an, in wieviele Teile der String 
zerfällt. Im Kontext der Funktion foo wäre STR_SplitCount(str, " ") == 4.

Beachte: Bei der Aufteilung können auch leere Strings entstehen. Zum 
Beispiel zerfällt der String "..abc" in drei Strings, wenn als Separator 
"." gewählt wird, nämlich in "", "" und "abc". Analog zerfällt der leere 
String "" über jedem Separator in einen String, nämlich den leeren 
String.

//*********************

func int STR_IndexOf(var string str, var string tok)

STR_IndexOf sucht den String tok im String str und gibt, falls tok in 
str enthalten ist, den Index zurück bei dem das erste Auftreten von tok 
beginnt und -1, falls tok nicht in str auftaucht.

Groß- und Kleinschreibung wird beachtet.

Beispiele:

//----------
STR_IndexOf("Hello World!", "Hell")  ==  0
STR_IndexOf("Hello World!", "World") ==  6
STR_IndexOf("Hello World!", "Cake")  == -1
STR_IndexOf("Hello World!", "")      ==  0
STR_IndexOf("Hello", "Hello World!") == -1
STR_IndexOf("hello Hell!", "Hell")   ==  6
STR_IndexOf("", "")                  ==  0
//----------



//######################################
// 5.) Menü-Funktionen

Diese Funktionen sollen den Zugriff auf Menüelemente (zum Beispiel im 
Charaktermenü) vereinfachen. Leider werden manche Menüs jedesmal neu 
erzeugt (vom Skript aus), andere dagegen werden einmal erzeugt und dann 
behalten. Problem: Ein Charaktermenü gibt es zum Beispiel erst, nachdem 
es das erste mal geöffnet wurde, danach liegt es im Speicher.
Abhängig davon und von dem, was man eigentlich tun will, kann es 
sinnvoll sein in den Menüskripten Änderungen einzubringen oder sich das 
Menü als Objekt zu holen und in dem fertigen Objekt selbst 
herumzuschmieren. Für letzteres gibt es hier eine Hilfestellung:

func int MEM_GetMenuByString (var string menu)
func int MEM_GetMenuItemByString (var string menuItem)

Liefert die Adresse des Menüs bzw. des Menüitems falls ein Menü bzw. 
Menüitem mit diesem Namen existiert, Null sonst.

//######################################
// 6.) Globale Instanzen initialisieren

Das Skriptpaket führt folgende Instanzen ein:

instance MEM_Game           (oCGame);
instance MEM_World          (oWorld);
instance MEM_Timer          (zCTimer);
instance MEM_WorldTimer     (oCWorldTimer);
instance MEM_Vobtree        (zCTree);
instance MEM_InfoMan        (oCInfoManager);
instance MEM_InformationMan (oCInformationManager);
instance MEM_Waynet         (zCWaynet);
instance MEM_Camera         (zCCamera);
instance MEM_SkyController  (zCSkyController_Outdoor);
instance MEM_SpawnManager   (oCSpawnManager);

Die hier benutzten Klassen haben alle eines gemeinsam: Es gibt stehts 
maximal ein Objekt von ihnen zur gleichen Zeit (es gibt z.B. nicht 
gleichzeitig zwei Welten oder zwei Himmel).

Ich stelle eine Funktion zur Verfügung, die die Offsets dieser Instanzen 
auf das entsprechende eindeutige Objekt setzt.

func void MEM_InitGlobalInst()

Nachdem MEM_InitGlobalInst aufgerufen wurde, können alle oben genannten 
Instanzen genutzt werden. Nach dem Laden eines neue Spielstandes muss 
MEM_InitGlobalInst() erneut aufgerufen werden!

Anmerkung: MEM_InitGlobalInst wird auch von der Funktion MEM_InitAll 
aufgerufen.

//######################################
// 7.) Ini Zugriff

Ini Dateien haben folgende Form:

//----------------------
[mySection1]
myOption1=myValue1
myOption2=myValue2
[mySection2]
myOption1=myValue1
myOption2=myValue2
//----------------------

Literale in eckigen Klammern identifizieren Sektionen eindeutig. 
Innerhalb von Sektionen werden Optionen mit eindeutigen Namen 
identifiziert. Jede Option nimmt einen Wert an, der nach dem "="-Zeichen 
steht. Da .ini Dateien keine Binärdateien sind, sind Sektionsnamen, 
Optionsnamen und Werte alle vom Typ string.

In diesem Skriptpaket gibt es Funktionen, um lesend und schreibend auf 
die Gothic.ini zuzugreifen, sowie um lesend auf die .ini Datei der Mod 
zuzugreifen. Zum Lesen gibt es:

func string MEM_GetGothOpt (var string sectionname,
                            var string optionname)
func string MEM_GetModOpt  (var string sectionname,
                            var string optionname)

MEM_GetGothOpt durchsucht die Gothic.ini, MEM_GetModOpt die .ini Datei 
der Mod. Gesucht wird nach der Option optionname in der Sektion 
sectionname. Falls eine solche Sektion mit einer solchen Option 
existiert, wird der Wert dieser Option zurückgegeben. Ein leerer String 
sonst.

Zudem habe ich Funktionen geschrieben, die die Existenz von Sektionen 
und Optionen prüfen. Sie sollten selbsterklärend sein:

func int MEM_GothOptSectionExists (var string sectionname)
func int MEM_GothOptExists (var string sectionname,
                            var string optionname)
func int MEM_ModOptSectionExists (var string sectionname)
func int MEM_ModOptExists (var string sectionname,
                           var string optionname)

Um schreibend auf die Gothic.ini zuzugreifen, gibt es folgende Funktion:

func void MEM_SetGothOpt (var string section,
                          var string option,
                          var string value)

Dabei wird die Option option in der Sektion section auf den Wert value 
gesetzt. Falls die Sektion und/oder Option nicht existiert, werden beide 
im Zweifelsfall angelegt.

Die .ini Datei der Mod kann leider nicht beschrieben werden, da Gothic 
Änderungen daran niemals auf die Festplatte zurückschreibt.

//BEACHTE:
-Falls du neue Optionen einführst gebietet der gute Stil, dass du dies 
in einer eigenen Sektion tust und die Optionen verständlich benennst! 
Als Norm schlage ich vor, dass eine Mod mit Namen "myMod" nur in der 
Sektion "myMod" oder "MOD_mymod" neue Eigenschaften einführt (und nicht 
etwa in der Sektion "GAME" oder "PERFORMANCE").
-Die Gothic.ini wird erst beim Verlassen von Gothic physikalisch 
beschrieben. Falls Gothic abstürzt, kann es also sein, dass Änderungen 
verloren gehen.
-Manche Änderungen werden erst nach einem Neustart von Gothic oder dem 
Betreten/Verlassen des Menüs Wirkung zeigen.

//Nutzungsmöglichkeiten:
-In der .ini Datei der Mod könnten dem Spieler zusätzliche 
Konfigurationsmöglichkeiten gegeben werden, etwa könnte man dort ein 
bestimmtes Features abschalten können, falls absehbar ist, dass nicht 
jeder Spieler es mögen wird.
-In der Gothic.ini könnte zum Beispiel der Schwierigkeitsgrad der Mod 
hinterlegt sein, der sich dadurch auf alle Savegames auswirkt, und nicht 
für jedes Savegame neu festgelegt werden muss.
-In der Gothic.ini könnte gespeichert sein, ob die Mod bereits 
mindestens einmal durchgespielt wurde. So könnte das zweite mal 
Durchspielen verschieden gestaltet werden.
-In der Gothic.ini könnten Highscores (evtl. zusammen mit idComputerName 
gehasht zur Verifikation) hinterlegt sein.
-In der Gothic.ini könnten statistische Informationen festgehalten 
werden, etwa wie oft ein Spieler (insgesamt oder in der letzten Zeit) 
geladen hat. Denkbar wäre ein System, dass den Schwierigkeitsgrad 
drosselt, falls der Spieler sehr oft in kurzen Abständen stirbt.
-uvm.

//Anmerkung:
-Menüelemente bringen von Haus aus die Möglichkeit mit Änderungen an 
Gothic.ini Eigenschaften vorzunehmen. Es ist daher leicht eine weitere 
Einstellungsmöglichkeit ins Gothic Menü aufzunehmen und Änderungen 
direkt aus der Gothic.ini (und nicht etwa aus dem Menüitem) auszulesen.

//********************************
// 7.1.) Tastenzuordnungen

In der Gothic.ini steht die Zuordnung von physikalischen Tasten (zum 
Beispiel "W") zu logischen Tasten (zum Beispiel "keyUp", also nach vorne 
laufen).

Es ist etwas trickreich die Information in der dortigen Formatierung zu 
verstehen, daher gibt es folgende Funktionen:

func int MEM_GetKey         (var string name)
func int MEM_GetSecondaryKey(var string name)

Beide erwarten den Namen einer logischen Taste (zum Beispiel "keyUp" 
oder "keyInventory"). Zurückgegeben wird die Erst- bzw. Zweitbelegung 
der Taste. Falls die logische Taste nicht bzw. nicht ein zweites mal 
zugewiesen wurde, wird entsprechend 0 zurückgegeben, sonst der 
entsprechende Tastencode, wie er in Ikarus_Const.d zu finden ist. Dieser 
Tastencode kann dann zum Beispiel als Parameter für MEM_KeyPressed oder 
MEM_KeyState dienen.

Beispiel: Um zu erkennen, dass der Spieler die Inventartaste drückt, 
würde es genügen, sehr häufig (am besten jeden Frame) zu prüfen:
     MEM_KeyPressed(MEM_GetKey         ("keyInventory"))
  || MEM_KeyPressed(MEM_GetSecondaryKey("keyInventory"))

//######################################
// 8.) Tastendrücke erkennen

Eine einfache Funktion ist folgende:

func int MEM_KeyPressed(var int key)

Liefert 1, falls die Taste gedrückt ist, die zu dem virtuellen 
Tastencode key gehört. Die Tastencodes sind in Ikarus_Const.d zu finden.

Mit MEM_KeyPressed(KEY_RETURN) kann man zum Beispiel abfragen ob die 
ENTER Taste gedrückt ist.

//######################

Häufig wird man in einer Triggerschleife einem Tastendruck auflauern 
wollen. Oft möchte man dabei nur einmal auf einen Tastendruck reagieren, 
auch wenn der Spieler die Taste für eine bestimmt Zeitspanne festhält. 
Dann ist es nötig zu unterscheiden, ob die Taste gerade neu gedrückt 
wurde oder bloß noch gehalten wird. Dafür gibt es die Funktion:

func int MEM_KeyState(var int key)

Sie zieht neben der Tatsache, ob eine Taste tatsächlich gedrückt ist 
oder nicht, auch noch in Betracht, was das letzte mal für diese Taste 
zurückgegeben wurde. Es gibt die folgende Rückgabewerte:

KEY_UP: Die Taste ist nicht gedrückt und war auch vorher nicht gedrückt. 
("nicht gedrückt")
KEY_PRESSED: Die Taste ist gedrückt und war vorher nicht gedrückt. ("neu 
gedrückt")
KEY_HOLD: Die Taste ist gedrückt und war auch vorher gedrückt. ("immer 
noch gedrückt")
KEY_RELEASED: Die Taste ist nicht gedrückt und war vorher gedrückt. 
("losgelassen")

KEY_PRESSED oder KEY_RELEASED werden also zurückgeben, wenn sich der 
Zustand der Taste seit der letzten Abfrage geändert hat.
KEY_UP oder KEY_HOLD werden zurückgegeben, wenn sich der Zustand nicht 
geändert hat.

Beachte: Wenn sich der Tastenzustand zwischen zwei Abfragen zweimal 
ändert (zum Beispiel die Taste ganz schnell gedrückt und wieder 
losgelassen wird), dann wird MEM_KeyState das nicht bemerken. Die 
Funktion kann nur zu den Zeitpunkten an denen sie aufgerufen wird den 
Tastenzustand überprüfen.

Beachte auch: Die Funktion wird nie zweimal direkt hintereinander 
KEY_PRESSED zurückgeben. Ein Aufruf von MEM_KeyState wird also die 
Rückgabewerte von späteren Aufrufen verändern. Folgendes ist zum 
Beispiel FALSCH FALSCH FALSCH:

//------ SO NICHT! -----
if (MEM_KeyState (KEY_RETURN) == KEY_UP) {
    Print ("Die Taste ist oben!");
} else if (MEM_KeyState (KEY_RETURN) == KEY_PRESSED) {
    Print ("Die Taste wurde gerade gedrückt!");
};
//----------------------

Der else if Block wird niemals betreten werden. Wenn die Taste gerade 
gedrückt wird, wird KEY_PRESSED nur in der ersten if-Abfrage auftauchen 
und ist dann "verbraucht". Die zweite if-Abfrage bekommt dann nur noch 
KEY_HOLD ab.

So ist es besser:

//----------------------

var int returnState;
returnState = MEM_KeyState (KEY_RETURN);

if (returnState == KEY_UP) {
    Print ("Die Taste ist oben!");
} else if (returnState == KEY_PRESSED) {
    Print ("Die Taste wurde gerade gedrückt!");
};

//----------------------

Wenn mehrere Events auf die gleiche Taste hören, konkurrieren sie also 
auch um die KEY_PRESSED Rückgabewerte!

//######################

Eine Funktion zum simulieren von Tastendrücken ist:
func void MEM_InsertKeyEvent(var int key)

In manchen Fällen wird die Engine (im nächsten Frame) so reagieren, als 
wäre die Taste gedrückt, die mit dem virtuellen Tastencode key in 
Verbindung steht. Zum Beispiel öffnet MEM_InsertKeyEvent(KEY_ESC) das 
Hauptmenü oder schließt geöffnete Dokumente und 
MEM_InsertKeyEvent(KEY_TAB) öffnet das Inventar, falls die Einstellungen 
des Spielers TAB als Taste für das Inventar vorsieht.
In anderen Fällen funktioniert diese Funktion nicht, zum Beispiel ist es 
nicht möglich das Inventar auf diese Weise zu schließen.

Das klingt nicht nur willkürlich sondern ist auch so. Das Problem ist, 
dass die Engine auf verschiedene Arten und Weise abfragen kann ob eine 
Taste gedrückt wurde und nur eine dieser Varianten auf 
MEM_InsertKeyEvent "hereinfällt". Was zum Beispiel funktioniert hat:

-Inventar öffnen. (TAB)
-Charaktermenü öffnen (C)
-Pause togglen / Quickload (F9)
-Tagebuch-Öffnen (L)
-Hauptmenü öffnen / Dokument schließen (ESC)

Beachte: Verschiedene Spieler nutzen verschiedene Tasten für bestimmte 
Aktionen! Es ist aber möglich mit MEM_GetGothOpt an die Einstellungen 
(Gothic.ini) heranzukommen. Hier sind ein oder zwei Tasten als 
Hexadezimalstring (Vorsicht: Little Endian!) für die einzelnen Aktionen 
registriert.

//######################################
// 9.) Maschinencode ausführen

Unter Maschinencode versteht man ein Programm oder ein Programmstück, 
dass in Maschinensprache vorliegt, das heißt ohne weiteren 
Übersetzungsschritt direkt von einem Prozessor ausgeführt werden kann. 
Die für uns relevante Maschinensprache ist die zur x86 
Prozessorarchitektur gehörige. Alle Maschinenbefehle, was sie tun und 
wie sie in Maschinensprache kodiert sind, kann man in den Intel 
Handbüchern nachlesen.

http://www.intel.com/products/processor/manuals/index.htm

In der Praxis wird man mit sehr wenigen Befehlen auskommen und nur in 
seltenen Fällen (abstrakte) Maschinenbefehle von Hand in (konkreten) 
Maschinencode übersetzen wollen, weil das sehr mühseelig ist.

Um technische Dinge zu tun, die sich in Daedalus nicht hinschreiben 
lassen, kann aber Maschinencode nützlich sein. Zum Beispiel nutzen die 
CALL Funktionen (siehe unten) als Basis den ASM Funktionensatz.

Bemerkung: Die Funktionen tragen das Präfix "ASM_" für 
Assembler(sprache). Assemblersprache ist eine menschenlesbare Sprache 
mit eins-zu-eins Entsprechungen zur Maschinensprache. Strenggenommen ist 
das "ASM_" Präfix daher fehlleitend, da es hier um Maschinencode und 
nicht um Assemblersprache geht. Gedanklich ist beides aber nah verwandt.

Hinweis: Ich empfehle jedem, der nicht plant, die Funktionen aus diesem 
Kapitel zu nutzen, dieses Kapitel zu überspringen. Die Funktionen in 
diesem Kapitel sind sehr speziell und sehr technisch.
Wer nur Engine Funktionen aufrufen will, kann sich direkt den "CALL_" 
Funktionen zuwenden. Die "ASM_" Funktionen sind sehr unhandlich, und nur 
mit Intel Referenz oder einer anderen Wissensquelle über Maschinencode 
sinnvoll benutzbar.

//Grundlegende Funktionsweise

Über die Funktion

func void ASM (var int data, var int length)

ist es möglich nach und nach Maschinencode zu diktieren. Die ersten 
length Bytes von data (maximal aber 4!) werden an den bereits zuvor 
diktierten Teil angehängt. So entsteht Stück für Stück ein vom Prozessor 
ausführbares Programmstück.

Es stehen als kompaktere Schreibweise die Funktionen 

func void ASM_1 (var int data) { ASM (data, 1); };
func void ASM_2 (var int data) { ASM (data, 2); };
func void ASM_3 (var int data) { ASM (data, 3); };
func void ASM_4 (var int data) { ASM (data, 4); };

zur Verfügung. Einzelne Maschinenbefehle können durchaus eine Kodierung 
besitzen, die länger als 4 Byte ist, in diesen Fällen muss diese eben 
Stück für Stück diktiert werden. In der Regel gibt es aber eine logische 
Aufteilung in Blöcke die höchstens 4 Byte groß sind (und damit in einen 
Integer hineinpassen).

Um ein fertig diktiertes Stück Maschinencode auszuführen gibt es die 
Funktion

func void ASM_RunOnce()

Diese führt den bis zu diesem Zeitpunkt diktierten Code aus, ähnlich wie 
eine externe Funktion ausgeführt wird. Der ausgeführte Code wird danach 
freigegeben, und neuer Code kann diktiert werden.

Anmerkung: Der diktierte Code wird im Datensegment ausgeführt. Falls die 
Datenausführungsverhinderung von Windows für Gothic aktiv ist (das wäre 
äußerst ungewöhnlich) wird eine Schutzverletzung auftreten und Windows 
wird Gothic beenden.

Anmerkung: Wie man sieht kann es zu jedem Zeitpunkt nur maximal ein 
angefangenes Diktat von Maschinencode geben. Es ist nicht möglich zwei 
verschiedene Sequenzen von Maschinencode gleichzeitig aufzubauen.

Anmerkung: Das System ist nicht robust gegenüber Lade und 
Speicheroperationen. Es ist daher nicht nur unsinnig sondern auch 
unzulässig ein angefangenes Diktat über einen oder mehrere Frames hinweg 
liegen zu lassen. Ein Diktat ist abgeschlossen, wenn es durch einen 
Aufruf von ASM_RunOnce oder ASM_Close beendet wurde.

//aktuelle Codeposition

Zum Beispiel bei Jumps und Calls kann es notwendig sein die Adresse des 
gerade ausgeführten Codes zu kennen. Die Funktion

func int ASM_Here()

liefert sozusagen die Adresse des Cursors, das heißt die Adresse der 
Stelle, die als nächtes durch einen Aufruf von ASM beschrieben werden 
wird. Es ist garantiert, dass die Stelle an der der Code geschrieben 
wird auch die Stelle ist, an der er ausgeführt wird.

//allozierter Speicher

Der Speicher in dem der Maschinencode steht, wird zu Beginn des Diktats 
alloziert. Falls keine spezielle Größe spezifiziert wird, das heißt, 
falls das Diktat direkt mit ASM oder ASM_Here beginnt, so werden 256 
Bytes alloziert. Für einfache Anwendungen ist dies oft ausreichend.
Wird mehr Speicher benötigt, muss dies explizit zu Beginn des Diktats 
angekündigt werden. Dazu wird das Diktat mit dem speziellen Befehl

func void ASM_Open(var int space)

eingeleitet. space soll hierbei die Größe des zu reservierenden 
Speicherbereichs in Byte behinhalten.

//Performance

Falls eine Funktion mehrmals in kurzer zeitlicher Abfolge benötigt wird, 
kann es sinnvoll sein, sie nicht für jeden Aufruf von neuem zu 
diktieren. Es ist möglich ein Diktat von Maschinencode nicht mit 
ASM_RunOnce sondern stattdessen mit 

func int ASM_Close()

zu beenden. Diese Funktion beendet das Diktat (sodass ein neues beginnen 
kann) und gibt einen Zeiger auf einen Speicherbereich zurück, der den 
diktierten Maschinencode enthält. Dieser Zeiger kann nun jederzeit und 
beliebig oft an

func void ASM_Run(var int ptr)

übergeben werden, damit der Maschinencode ausgeführt wird.

Doch Vorsicht: Der durch ASM_Close erhaltene Speicherbereich muss über 
MEM_Free manuell freigegeben werden um Speicherlecks zu vermeiden.
Vermutlich ist es für fast alle praktischen Belange ausreichend 
ASM_RunOnce zu verwenden und Code immer wieder von neuem zu diktieren, 
sobald er benötigt wird.

Anmerkung: ASM_Run kann auch benutzt werden, um Engine Funktionen ohne 
Parameter und ohne relevanten Rückgabewert aufzurufen. In diesem Fall 
müsste ptr einfach auf die auszuführende Funktion im Codesegment zeigen.

//Beispiel:

Folgende Funktion setzt den als slf übergebenen Npc als den Spieler, so 
als hätte man mit diesem Npc im Fokus im Marvin Modus "o" gedrückt.
Das ist deshalb so kurz, weil es genau zu diesem Zweck bereits eine 
Funktion gibt, sie ist nur normalerweise aus den Skripten heraus nicht 
erreichbar.
Es genügt daher Assemblercode zu schreiben, der den Parameter der 
Funktion (den "this"-Pointer) in das entsprechende Register schiebt und 
dann die Funktion aufruft.

func void SetAsPlayer (var C_NPC slf) {
    /* Adresse der Funktion */
    const int oCNpc__SetAsPlayer = 7612064; //0x7426A0 (Gothic2.exe)
    
    var int slfPtr;
    slfPtr = MEM_InstToPtr (slf);
    
    //mov ecx slfPtr
    ASM_1 (ASMINT_OP_movImToECX); /* move immediate value to ecx */
    ASM_4 (slfPtr); /* eine Konstante (immediate) */
    
    //call oCNpc__SetAsPlayer
    ASM_1 (ASMINT_OP_call);
    ASM_4 (oCNpc__SetAsPlayer - ASM_Here() - 4);
    
    ASM_RunOnce(); /* retn wird automatisch hinzugefügt */
};

Bemerkung: Callziele werden relativ zu derjenigen Instruktion angegeben, 
die nach der eigentlichen Call-Instruktion ausgeführt worden wäre. Daher 
ist sowohl ASM_Here() als auch die Subtraktion von 4 im Parameter von 
call nötig.

Bemerkung: Die Opcodes ASMINT_OP_movImToECX und ASMINT_OP_call sind in 
Ikarus.d als Konstanten enthalten. Dort sind allerdings nur die Opcodes 
verfügbar, die auch direkt von den Call-Skripten benötigt werden. 
Opcodes herauszufinden ist mühseelig.

Bemerkung: Das folgende Unterkapitel beschreibt unter anderem 
CALL__thiscall, eine Funktionen, mit deren Hilfe sich SetAsPlayer auch 
so implementieren lässt:

func void SetAsPlayer (var C_NPC slf) {
    const int oCNpc__SetAsPlayer = 7612064;
    CALL__thiscall (MEM_InstToPtr (slf), oCNpc__SetAsPlayer);
};

//######################################
// 10. Enginefunktionen aufrufen

Um eine Funktion benutzen zu können, muss man ihre Schnittstelle kennen, 
das heißt Anzahl und Art der Parameter (was will die Funktion wissen?) 
und die Art des Rückgabewerts (was sagt mir die Funktion?). Das kennt 
man ja.
Was in einer maschinennahen Situation hinzukommt, ist die 
Aufrufkonvention (wie hätte die Funktion ihre Parameter gerne und wer 
räumt auf?) und die Adresse der Funktion (wo steht sie überhaupt im 
Speicher?).

An dieses Wissen über Engine Funktionen kann man zum Beispiel mit IDA 
herankommen, einem Werkzeug, das die GothicMod.exe / Gothic2.exe 
analysieren und in eine für Menschen besser (aber immer noch sehr 
schwer) lesbare Ansicht überführen kann.
Wie man eine gute Ansicht der GothicMod.exe / Gothic2.exe bekommt, hat 
Nico hier beschrieben:

http://forum.worldofplayers.de/forum/showpost.php?p=12395375

Mit diesem Wissen ausgestattet, kümmern sich die folgenden Funktionen um 
den Rest der noch fehlt um Enginefunktionen aufzurufen.
Und so funktioniert's:

//Schritt 1: Parameter von rechts nach links

Zunächst müssen die Parameter, die die Funktion erwartet in umgekehrter 
Reihenfolge, das heißt vom Parameter ganz rechts bis zum Parameter ganz 
links auf den Maschinenstack.
Dazu gibt es folgende Funktionen:

func void CALL_IntParam        (var int    param) /* int32          */
func void CALL_FloatParam      (var int    param) /* single / zREAL */
func void CALL_PtrParam        (var int    param) /* void*          */
func void CALL_zStringPtrParam (var string param) /* zString*       */
func void CALL_cStringPtrParam (var string param) /* char **        */
func void CALL_StructParam (var int ptr, var int words) /* struct   */

Die meisten Parameter sind Zahlen oder Zeiger.
Da es in Daedalus nicht ganz leicht ist, an den Zeiger auf einen String 
zu kommen, sind die Spezialfälle "Zeiger auf zString" und "Zeiger auf 
cString" implementiert. Dabei wird ein zString* bzw. ein char** erzeugt, 
jeweils mit den Daten wie sie im übergebenen Daedalus String enthalten 
waren. Der so gewonnene Wert wird dann als Parameter auf den Stack 
gelegt.

Dass ein komplexer Parameter, also ein Objekt oder eine Struktur direkt 
auf dem Stack liegt (kein Zeiger sondern alle Daten) ist selten. In 
diesem Fall ist CALL_StructParam ein Zeiger auf das Objekt und die Größe 
des Objekts in Worten (1 Wort = 32 bit) zu übergeben. CALL_StructParam 
legt es dann in seiner Gesamtheit auf den Stack.

Anmerkung: CALL_IntParam, CALL_FloatParam und CALL_PtrParam sind 
identisch. Die Unterscheidung soll lediglich helfen Code gut lesbar zu 
halten.

Spitzfindigkeit: Diese Funktionen legen keine Parameter auf den 
Maschinenstack. Genau müsste es heißen: Sie erzeugen den Maschinencode, 
der Parameter auf den Maschinenstack legen wird, wenn er denn ausgeführt 
wird. Und ausgeführt wird er erst im zweiten Schritt mit der Bekanntgabe 
der Aufrufkonvention.

//Schritt 2: Der Aufruf

Es sind vier Aufrufkonventionen implementiert:

func void CALL__stdcall  (var int adr                           )
func void CALL__thiscall (var int this, var int adr             )
func void CALL__cdecl    (var int adr                           )
func void CALL__fastcall (var int ecx,  var int edx, var int adr)

__stdcall steht für "Standard Call" und hat sich neben __cdecl als eine 
der wichtigsten Aufrufkonvention durchgesetzt. CALL__stdcall benötigt 
als Parameter lediglich die Adresse der Funktion. Die Windows API 
benutzt sehr konsequent __stdcall als Aufrufkonvention.
__thiscall ist eine Abwandlung von __stdcall für Klassenfunktionen. 
Hierbei wird der this-Pointer, also der Zeiger auf das Objekt, auf dem 
die Funktion aufgerufen werden soll als versteckter Parameter im 
Register ecx übergeben. CALL__thiscall erwartet neben der Adresse daher 
zusätzlich einen Objektzeiger. Da Gothic durchgängig objektorientiert 
programmiert wurde, ist der __thiscall die häufigste anzutreffende 
Aufrufkonvention.

Funktionen, die nicht aus der Windows API sind und keine 
Klassenfunktionen sind, benutzen häufig __cdecl als Aufrufkonvention. 
Benutzt wird CALL__cdecl genau wie CALL__stdcall. Der Unterschied liegt 
intern in der Verantwortlichkeit für das anpassen des Stackpointers.

__fastcall ist nicht standardisiert. Manche Compiler, darunter auch der 
Compiler des Microsoft Visual Studio mit dem Gothic compiliert wurde, 
bieten eine solche Aufrufkonvention an, die potenziell etwas 
performanter ist.  
Im Falle von Microsoft Visual Studio werden die ersten zwei Parameter 
auf dem Stack übergeben (in ecx und edx). __fastcall wird selten 
verwendet.

Welche Aufrufkonvention eine konkrete Enginefunktion nutzt, lässt sich 
mit IDA (oder einem anderen Disassembler) herausfinden.

Die Bekanntgabe der Aufrufkonvention, also der Aufruf einer der drei 
oben genannten Funktionen) ist gleichzeitig der Zeitpunkt des Aufrufs 
der Funktion. Zu diesem Zeitpunkt müssen insbesondere schon alle 
Parameter spezifiziert sein.

//Schritt 3: Der Rückgabewert

Sobald der Funktionsaufruf stattgefunden hat, also nach Schritt 2, kann 
der Rückgabewert abgefragt werden.
Die folgenden Funktionen interpretieren den Rückgabewert (in aller Regel 
ist das der Inhalt von EAX unmittelbar nach dem Aufruf) in der im 
Funktionsnamen suggerierten Art und Weise. Das Ergebnis wird dann in 
einer in Daedalus brauchbaren Art und Weise zurückgeliefert.

func int      CALL_RetValAsInt       () /* Ganzzahl */
func int      CALL_RetValAsPtr       () /* Zeiger   */
func instance CALL_RetValAsStructPtr () /* struct*  */
func string   CALL_RetValAszStringPtr() /* zString* */

CALL_RetValAsInt und CALL_RetValAsPtr liefern den Rückgabewert einfach 
als Zahl zurück.

CALL_RetValAsStructPtr kann genutzt werden um eine Zuweisung an eine 
Instanz zu machen, zum Beispiel eine Zuweisung an ein var zCVob, falls 
der Rückgabewert ein Zeiger auf ein zCVob ist.

Ist der Rückgabewert ein zString* so kann CALL_RetValAszStringPtr 
benutzt werden um den Rückgabewert in handlicher Form als Daedalusstring 
zu erhalten.

Einen Spezialfall stellen Floats dar (sie werden nicht in EAX 
zurückgegeben). Vor der Bekanntgabe der Aufrufkonvention (und damit der 
Ausführung des Calls) muss daher die Funktion:

func void CALL_RetValIsFloat()

aufgerufen werden um diesen Umstand zu melden. Nach dem Call an den 
Rückgabewert zu kommen ist dann nicht weiter problematisch.

func int      CALL_RetValAsFloat     () /* Gleitkommazahl */

Anmerkung: CALL_RetValAsInt, CALL_RetValAsPtr und CALL_RetValAsFloat 
sind identisch und geben einfach eine interne Ergebnisvariable zurück. 
Die Unterscheidung erfolgt hier abermals aus Lesbarkeitsgründen.

//Komplexe Rückgabewerte

In seltenen Fällen ist ein Rückgabewert ein großes Objekt (kein Zeiger, 
sondern das gesamte Objekt), zum Beispiel ein zVEC3. Dies stellt einen 
Sonderfall dar. Er muss mit 

func void CALL_RetValIsStruct (var int words)

unmittelbar vor Bekanntgabe der Aufrufkonvention (und damit der 
Ausführung des Calls) angekündigt werden. Die Größe der Struktur ist 
hier in Worten (1 Wort = 32 bit) anzugeben. Ein zVEC3 hat zum Beispiel 
eine Größe von drei Worten.
Intern wird dann Speicher für den Rückgabewert reserviert und ein Zeiger 
auf den reservierten Speicherbereich als versteckter letzter Parameter 
auf den Stack geschoben. Die aufgerufene Funktion befüllt dann diesen 
Speicher und gibt (eigentlich überflüssigerweise, weil der Aufrufer sie 
schon kennt) die Adresse des Rückgabewerts zurück.
Der Rückgabewert ist also über CALL_RetValAsPtr oder 
CALL_RetValAsStructPtr zugänglich, als wäre der Rückgabewert kein 
komplexes Objekt, sondern ein Zeiger auf ein komplexes Objekt.

Hinweis: Im Falle eines komplexen Rückgabewertes wurde das 
zurückgegebene Objekt speziell für den Aufrufer konstruiert. Es muss 
also auch von ihm freigegeben werden, wenn es nicht mehr benötigt wird. 
Im Falle eines zVEC3 würde es genügen den Speicherbereich mit MEM_Free 
freizugeben.

//Spezialfall: Rückgabewert zString

Ein Spezialfall eines komplexen Rückgabewerts ist ein zString. Da es 
nicht ganz einfach ist, einen zString Unfall- und Speicherleckfrei in 
einen Daedalusstring hinüberzuretten, gibt es hierfür spezielle 
Funktionen:

func void   CALL_RetValIszString()
func string CALL_RetValAszString()

Hierbei ersetzt CALL_RetValIszString den Aufruf von CALL_RetValIsStruct.
CALL_RetValAszString kopiert den zurückgegebenen String in einen 
Daedalusstring und gibt anschließend den zurückgegebenen String frei.

Anmerkung: CALL_RetValAszStringPtr und CALL_RetValAszString sind 
durchaus verschieden und sollten nicht verwechselt werden. Bei einer 
Verwendung von CALL_RetValAszString anstelle von CALL_RetValAszStringPtr 
wird Speicher freigegeben, der evtl noch benötigt wird. Bei einer 
umgekehrten Verwechslung wird Speicher nicht freigegeben, der nicht mehr 
benötigt wird (-> Speicherleck).

//Beispiel:

MessageBox ist eine Funktion aus der WinAPI, die in Gothic2 an Stelle 
0x7B48E8 herumliegt. Wie sie funktioniert ist hier dokumentiert:

http://msdn.microsoft.com/en-us/library/ms645505%28v=vs.85%29.aspx

Um sie bequem aus Gothic heraus aufrufen zu können schreiben wir eine 
Daedalusfunktion, die sich um Parameter und Aufrufkonvention kümmert.

In IDA (oder einem anderen Disassembler) finden wir folgende Zeile:

int __stdcall MessageBoxA (HWND hWnd, LPCSTR lpText,
                           LPCSTR lpCaption,UINT uType)
                           
sie sagt uns, dass es sich um einen __stdcall handelt. Zudem ist Anzahl 
und Art der Parameter, sowie die Art des Rückgabewerts ersichtlich, 
(alles stimmt mit der Spezifikation auf der MSDN Seite überein). Ein 
LPCSTR ist ein "Long Pointer to a c String", ein UINT ein "unsigned 
Integer" und HWND ein Zeigertyp.

//----------------------

func int MEM_MessageBox (var string txt,
                         var string caption, var int type) {
    /* Hier liegt die MessageBox Funktion */
    const int WinAPI__MessageBox = 8079592; //0x7B48E8
    
    /* Parameter in umgekehrter Reihenfolge */
    CALL_IntParam (type);           // int
    CALL_cStringPtrParam (caption); // char **
    CALL_cStringPtrParam (txt);     // char **
    CALL_PtrParam (0);              // owner Window; darf Null sein
    
    /* als __stdcall ausführen */
    CALL__stdcall (WinAPI__MessageBox);
    
    return CALL_RetValAsInt();
};

//----------------------

Anmerkung: Dies ist ein besonders einfacher Fall. Für Funktionen von 
Gothic besitzt man keine Dokumentation. Die Bedeutung der Parameter ist 
im Allgemeinen unklar, und nur zu erraten oder zu erforschen. Adresse 
und Signatur der Funktion sind allerdings Problemlos mit IDA (oder einem 
anderen Disassembler) in Erfahrung zu bringen.

//Weitere Beispiele:

Die folgenden Beispiele gehen davon aus, dass MEM_InitAll oder 
MEM_InitGlobalInst aufgerufen wurde, das heißt dass bestimmte globale 
Instanzen initialisiert sind.

1.) Erhalte den Spieler mithilfe von

.text:006C2C60:
class oCNpc * __thiscall oCGame::GetSelfPlayerVob(void)

//----------------------
{
    const int oCGame__GetSelfPlayerVob = 7089248; //0x6C2C60
    
    CALL__thiscall (MEM_InstToPtr (MEM_Game),
                    oCGame__GetSelfPlayerVob);
    
    var oCNpc player;
    player = CALL_RetValAsStructPtr();
    
    PrintDebug (player.name);
}
//----------------------

2.) Gib dem Spieler eine Overlay-Animation mit Hilfe von

.text:0072D2C0:
int __thiscall oCNpc::ApplyOverlay(class zSTRING const &)

//----------------------
{
    const int oCNpc__ApplyOverlay = 7525056; //0x72D2C0
    CALL_zStringPtrParam ("HUMANS_MILITIA.MDS");
    CALL__thiscall (MEM_InstToPtr (hero), oCNpc__ApplyOverlay);
    //Rückgabewert interessiert uns hier nicht.
}
//----------------------

3.) Hole eine Stringrepräsentation der Zeit, das heißt zum Beispiel 
"7:30" für halb acht Uhr morgens mit Hilfe von 

.text:00780EC0:
class zSTRING __thiscall oCWorldTimer::GetTimeString(void)

//----------------------
{
    const int oCWorldTimer__GetTimeString = 7868096; //780EC0
    CALL_RetValIszString();
    CALL__thiscall (MEM_InstToPtr (MEM_WorldTimer),
                    oCWorldTimer__GetTimeString     );
    PrintDebug (CALL_RetValAszString());
}
//----------------------

Beachte: Der Rückgabewert ist hier ein zString also ein 20 Byte großes 
Objekt. Das muss mit CALL_RetValIszString angekündigt werden, damit der 
Speicher für den Rückgabewert im Vorfeld angelegt werden kann.
CALL_RetValAszString sorgt dafür, dass der angelegte Speicher auch 
wieder freigegeben wird. Bei anderen Strukturen als zString gibt es 
diesen Automatismus nicht.

4.) Hole die "Himmelszeit", ein Gleitkommawert zwischen 0 und 1, der 
Mittags um 12 von 1 auf 0 zurückspringt. Nutze dazu:

.text:00781240:
float __thiscall oCWorldTimer::GetSkyTime(void)

//----------------------
func int GetSkyTime() {
    const int oCWorldTimer__GetSkyTime = 7868992; //0x781240
    CALL_RetValIsFloat();
    CALL__thiscall (MEM_InstToPtr (MEM_WorldTimer),
                    oCWorldTimer__GetSkyTime);
    
    return CALL_RetValAsFloat();
};
//----------------------

Beachte: Da der Rückgabewert eine Gleitkommazahl ist, muss 
CALL_RetValIsFloat aufgerufen werden.

//######################################
// 11.) Externe Bibliotheken

Zum Laden von DLLs bietet Windows die Funktion LoadLibrary an.
Zudem gibt es GetProcAddress zum Finden einer Funktion innerhalb einer 
bereits geladenen DLL.

Die Dokumentation der beiden Funktion sind hier zu finden:

http://msdn.microsoft.com/en-us/library/ms684175%28v=vs.85%29.aspx
http://msdn.microsoft.com/en-us/library/ms683212%28v=vs.85%29.aspx

Ikarus bietet die Funktionen genau wie in MSDN beschrieben an, also 
folgendermaßen:

func int LoadLibrary    (var string lpFileName)
func int GetProcAddress (var int hModule, var string lpProcName)

Die mit GetProcAddress erhaltenen Funktionsadressen können mit Hilfe der 
CALL_ Funktionen verwendet werden um die Funktionen auch wirklich 
aufzurufen. Beispielsweise könnte folgendermaßen die Sleep Funktion aus 
der Kernel32.dll aufgerufen werden:

//----------------------
func void Sleep(var int ms) {
    var int adr;
    adr = GetProcAddress (LoadLibrary ("KERNEL32.DLL"), "Sleep");
    
    CALL_IntParam(ms);
    CALL__stdcall(adr); //0x007B47E6
};
//----------------------

Eine Dokumentation der Sleep Funktion findet sich wieder in MSDN, und 
zwar hier:
http://msdn.microsoft.com/en-us/library/ms686298%28v=vs.85%29.aspx

Da die Kernel32.dll eine wichtige Bibliothek ist, stellt Ikarus 
abkürzend folgende Funktion zur Verfügung:

func int FindKernelDllFunction (var string name)

FindKernelDllFunction ist äqivalent zu GetProcAddress mit der Adresse 
von Kernel32.dll als fixem erstem Parameter.

//######################################
// 12.) Verschiedenes

func int MEM_SearchVobByName (var string str)

Liefert die Adresse eines zCVobs mit dem Namen str, falls ein solches 
Vob existiert. Andernfalls wird 0 zurückgegeben.

Als Abwandlung davon gibt es

func int MEM_SearchAllVobsByName (var string str)

Diese Funktion erzeugt ein zCArray in dem alle Zeiger auf Vobs mit dem 
Namen str stehen. Falls kein Vob mit dem Namen existiert wird ein leeres 
zCArray erzeugt. Ein Zeiger auf das erzeugte zCArray wird dann 
zurückgegeben. Dieses kann ausgewertet werden, sollte aber noch vor Ende 
des Frames (bevor der Spieler Laden kann) wieder mit MEM_ArrayFree 
freigegeben werden um Speicherlecks zu vermeiden. 
Die Klasse zCArray ist in Misc.d zu finden.

//******************

func int MEM_InsertVob(var string vis, var string wp)

Fügt ein Vob mit dem Visual vis am Waypoint wp ein. Hierbei muss vis der 
Name eines Visuals mit Dateierweiterung sein, zum Beispiel 
"FAKESCROLL.3DS", "FIRE.PFX", "SNA_BODY.ASC", 
"CHESTSMALL_NW_POOR_LOCKED.MDS", oder "ADD_PIRATEFLAG.MMS".

Zurückgegeben wird ein Pointer auf das erzeugte Objekt.
Falls das Visual oder der Waypoint nicht existiert ist das Verhalten 
dieser Funktion undefiniert.

Anmerkung: Das eingefügt Vob ist sogar ein oCMob, kann also zum Beispiel 
einen Fokusnamen bekommen. Man kann es aber wie ein zCVob behandeln, 
wenn man die zusätzlichen Eigenschaften nicht benötigt.

//******************

func void MEM_TriggerVob   (var int vobPtr)
func void MEM_UntriggerVob (var int vobPtr)

Diese beide Funktionen nehmen jeweils einen Pointer auf ein zCVob 
entgegen und senden eine Triggernachricht beziehungsweise 
Untriggernachricht an das Vob. Dafür wird das Vob temporär umbenannt. 
Falls das Triggern des Vobs also unmittelbare Auswirkungen hat (noch 
bevor MEM_TriggerVob verlassen wird) ist der Name des Vobs in dieser 
Zeit verfälscht. Es ist nicht ratsam das Objekt in diesem Moment 
umzubenennen, nochmal zu triggern oder zu zerstören, das Verhalten in 
solchen Fällen ist ungetestet.

//******************

func void MEM_RenameVob (var int vobPtr, var string newName)

Nimmt einen Zeiger auf ein Vob entgegen und benennt das Vob in den 
ebenfalls zu übergebenden Namen newName um. Das Objekt wird dazu 
zunächst aus der Vobhashtabelle entfernt, dann unbenannt und dann wieder 
unter neuem Namen in die Vobhashtabelle eingefügt.

//******************

func int Hlp_Is_oCMob(var int ptr)
func int Hlp_Is_oCMobInter(var int ptr)
func int Hlp_Is_oCMobLockable(var int ptr)
func int Hlp_Is_oCMobContainer(var int ptr)
func int Hlp_Is_oCMobDoor(var int ptr)
func int Hlp_Is_oCNpc(var int ptr)
func int Hlp_Is_oCItem(var int ptr)
func int Hlp_Is_zCMover(var int ptr)
func int Hlp_Is_oCMobFire(var int ptr)

Diese Funktionen können u.a. nützlich sein, wenn es darum geht den Fokus 
des Helden auszuwerten. Die Funktionen geben 1 zurück, falls der 
übergebene Zeiger auf ein Objekt der angegebenen Klasse oder eine 
Unterklasse dieser Klasse zeigt.

Für einen Stuhl würden zum Beispiel Hlp_Is_oCMob und Hlp_Is_oCMobInter 1 
zurückgeben, die anderen Funktionen 0.

Natürlich kann man diese Funktionen noch für andere Objekttypen als Mobs 
schreiben, wenn das nötig ist.

//******************

func void MEM_SetShowDebug (var int on)

Setzt die Variable, die auch von "toggle debug" getoggelt wird. Dadurch 
landen mit PrintDebug ausgegebenen Meldungen im Spy (wenn dort 
Informationen geloggt werden). Es empfielt sich als Filter "Skript" im 
Spy einzustellen, sonst gehen die Meldungen meist unter einem Haufen 
nutzlosem Enginezeug unter.

//******************

func string MEM_GetCommandLine ()

Gibt den Inhalt der Kommandozeile zurück, die an Gothic Übergeben wurde. 
Diese könnte zum Beispiel so aussehen:

"-TIME:7:35 -GAME:TEST_IKARUS.INI -ZREPARSE -ZWINDOW -ZLOG:5,S -DEVMODE 
-ZMAXFRAMERATE:30"

//******************

func int MEM_MessageBox (var string txt,
                         var string caption,
                         var int type)

Erzeugt ein kleines Fenster mit Überschrift caption und Inhalt txt.
Die möglichen Werte für type sowie die Rückgabewerte entsprechen der 
Beschreibung auf:

http://msdn.microsoft.com/en-us/library/ms645505%28v=vs.85%29.aspx

Alle sinnvoll anwendbaren Konstanten von dieser Seite stehen zur 
Verfügung.

Beispiel:

//----------------------
func void panic() {
    if (MEM_MessageBox (
          "The Computer will Explode. Continue anyway?",
          "Warning!",
          MB_YESNO | MB_ICONWARNING)
                                         == IDYES) {
        Print ("BAM! You're dead!");
    } else {
        Print ("Wise decision.");
    };
};
//----------------------

Als Spezialfall von MEM_MessageBox ist MEM_InfoBox verfügbar:

func void MEM_InfoBox (var string txt)

Auf einer Infobox gibt es nur einen OK-Knopf und ein Informationssymbol.

Message Boxen beenden den Vollbildmodus und sind daher wohl nur für 
Debugzwecke sinnvoll zu gebrauchen.

//******************

func int MEM_GetSystemTime()

Gibt die seit dem Start von Gothic verstrichene Zeit in Millisekunden 
zurück.

//******************

func int MEM_BenchmarkMS(var func f)

MEM_BenchmarkMS führt die übergebene parameterlose Funktion aus und gibt 
zurück, wie lange die Ausführung gedauert hat und zwar in Millisekunden, 
daher das MS.
Zeitmessung kann sinnvoll sein, um festzustellen ob und in welchem Maße 
eine Funktion die Leistung beeinträchtigt.

Millisekunden ist allerdings oft eine zu grobe Einheit, mit anderen 
Worten, eine Millisekunde ist für Prozessorverhältnisse eine sehr lange 
Zeit. 
Besser geeignet ist daher der sogenannte Performancecounter, der 
allerdings je nach System verschieden schnell zählt.

Die Anzahl der Performancecounter Ticks, die eine Funktion braucht, kann 
mit folgender Abwandlung der Benchmarkfunktion gemessen werden:

func int MEM_BenchmarkPC(var func f)

Der Performancecounter ist gut geeignet um die Geschwindigkeit 
verschiedener Funktionen zu vergleichen.
Umrechnung in Millisekunden ist möglich, die Anzahl der 
Performancecounter Ticks pro Millisekunde steht an der Addresse 
PC_TicksPerMS_Address.
Auf meinem System sind es 2741 Ticks pro Millisekunde. Umrechnung in 
Nanosekunden könnte schnell an die Grenzen von 32 bit Ganzzahlen kommen, 
also vorsicht!

Um ein verlässliches Ergebnis zu erhalten ist es sehr zu empfehlen nicht 
einen einzigen Durchlauf einer Funktion zu messen, sondern die 
Gesamtdauer vieler Durchläufe (zum Beispiel 1000).
Besonders bei recht schnellen Funktionen wird sonst das Ergebnis durch 
die Messung selbst zu stark verfälscht. Daher gibt es noch Abwandlungen 
der Benchmark-Funktionen, die einen Parameter entgegennehmen, der 
besagt, wieviele Durchläufe der Funktion f durchgeführt werden sollen.
Zurückgegeben wird dann die aufsummierte Dauer aller Durchläufe (kein 
Mittelwert) in der entsprechenden Einheit:

func int MEM_BenchmarkMS_N(var func f, var int n)
func int MEM_BenchmarkPC_N(var func f, var int n)

Anmerkungen zur Konditionierung der Messung:
-Der Paramter n ist so zu wählen, dass das Ergebnis in einem geeigneten 
Bereich zu erwarten ist. Wenn n Ausführungen der Funktion nicht einmal 
eine Millisekunde dauern, ist natürlich ein Rückgabewert in 
Millisekunden nicht aussagekräftig.
-Bei *sehr* schnellen Funktion f wird die Zeit, die in der 
Benchmark-Funktion aufgewendet wird (und nicht in f) signifikant zur 
Messung beitragen (was das Ergebnis verfälscht). Nur Funktionen, die 
hinreichend langsam sind, können sinnvoll gemessen werden.

Zur Orientierung, hier eine Zeitmessung für einige Operationen (in 
Nanosekunden, also milliardstel Sekunden):

- Funktionsaufruf (hin und zurückspringen)  :     30ns
- Elementare Rechnung (z.B: i = i + 1)      :    130ns
- Wld_IsTime                                :    200ns
- MEM_ReadInt, MEM_WriteInt                 :    350ns
- Hlp_StrCmp("Hello", "Hello")              :    500ns
- MEM_InstToPtr                             :   1400ns
- (wenig) Speicher allozieren und freigeben :   9700ns
- CALL__stdcall (in leere Funktion)         :  29000ns
- MEM_GetParserSymb                         : 280000ns

- Iteration der Benchmark-Funktion          :    300ns

//******************

Der Zugriff auf statische Arrays ist in Daedalus sehr mühsam. Unter 
einem statischen Array verstehe ich ein gewöhnliches Skriptarray, zum 
Beispiel:

var int myStaticArray[42];

Es ist nicht möglich mit einem variablen Index i auf myStaticArray[i] 
zuzugreifen, sondern stehts nur mit einer Konstanten. Das ändert sich 
mit folgenden Funktionen:

func int  MEM_ReadStatArr  (var int array, var int offset)
func void MEM_WriteStatArr (var int array, var int offset, var int value)

Der Befehl:

MEM_WriteStatArr (myStaticArray, i, 23);

wird Beispielsweise an Position i der Wert 23 geschrieben. Hierbei 
spielt es keine Rolle ob i eine Konstante oder eine Variable ist. Vor 
der ersten Nutzung einer der obigen beiden Funktionen muss allerdings 
die Funktion:

func void MEM_InitStatArrs()

aufgerufen werden. Nach jedem Laden eines Spielstands sollte 
MEM_InitStatArrs() erneut aufgerufen werden.

Anmerkung: MEM_InitStatArrs wird auch von der Funktion MEM_InitAll 
aufgerufen.

Vorsicht: Keine der beiden Funktionen führt irgendeine Art von 
Gültigkeitsprüfung durch. Falls es sich beim übergebenen Wert nicht um 
ein Array handelt oder offset jenseits der Grenzen des übergebenen 
Arrays liegen ist das Verhalten undefiniert.

//******************

Manchmal ist es hilfreich, die Speicheradresse einer Variable zu 
erfahren. Dies ist in Daedalus nicht vorgesehen. Folgende Funktionen 
schaffen Abhilfe:

func int MEM_GetStringAddress(var string s)
func int MEM_GetFloatAddress (var float  f)
func int MEM_GetIntAddress   (var int    i)

Der Rückgabewert ist jeweils die Addresse der übergebenen Variable. Wird 
anstatt einer Variable, ein arithmetischer Ausdruck übergeben (zum 
Beispiel MEM_GetIntAddress(x + 1)), wird kein sinnvolles Verhalten 
garantiert.

Beispiel:

//----------------------
func void foo() {
    MEM_GetAddress_Init();
    
    //Beispiel für MEM_GetIntAddress
      var int i;    i   = 0;
      var int ptr;  ptr = MEM_GetIntAddress(i);
        
      MEM_WriteInt(ptr, 42);
      Print(IntToString(i)); //gibt "42" aus.
        
    //Beispiel für MEM_GetStringAddress
      var string str;   str  = "Hello";
      var zString zStr; zStr = MEM_PtrToInst(MEM_GetStringAddress(str));
    
      MEM_WriteByte(zStr.ptr, 66); //66 = B im ASCII Zeichensatz
      Print(str); //<-gibt Bello aus. 
    
    //Zwei Sonderfälle:
      /* (1) */
      ptr = MEM_GetStringAddress("Hello?");
      
      /* (2) */
      ptr = MEM_GetStringAddress(ConcatStrings("Hello", " World!"));
};
//----------------------

Zu den Sonderfällen im Beispiel:
Nach (1) steht in ptr die Adresse des Strings "Hello?", der in 
irgendeiner Stringtabelle des Parsers liegt.

Nach (2) steht in ptr die Adresse eines statischen zStrings der von der 
Enginefunktion ConcatStrings benutzt wird (und gerade "Hello World!" 
enthält).

Wichtig: Diese Funktionen setzen voraus, dass MEM_InitAll oder 
MEM_GetAddress_Init aufgerufen wurde.

//******************
func int  MEM_ArrayCreate ()
func void MEM_ArrayFree   (var int zCArray_ptr)
func void MEM_ArrayClear  (var int zCArray_ptr)
func void MEM_ArrayInsert (var int zCArray_ptr, var int value)

func void MEM_ArrayRemoveIndex     (var int zCArray_ptr, var int index)
func void MEM_ArrayRemoveValue     (var int zCArray_ptr, var int value)
func void MEM_ArrayRemoveValueOnce (var int zCArray_ptr, var int value)

zCArrays sind eine sehr einfache Feld-Datenstruktur, die exzessiv von 
der Engine verwedet wird.

Arrays dieser Art können aber auch Skriptintern sinnvoll zur Übergabe 
von großen Datenmengen dienen. Zum Beispiel nutzt 
MEM_SearchAllVobsByName Arrays um gleich eine große Menge von Vobs 
zurückzugeben. Dabei wird verlangt, dass der Nutzer das Array noch im 
selben Frame (bevor der Spieler Laden oder Speichern könnte) wieder 
freigibt (mit MEM_ArrayFree).

Das Einfügen eines Elements in ein Array ist nicht einfach, da eventuell 
der Platz im Array nicht ausreicht und das Array vergrößert werden muss. 
Daher habe ich diese Funktion zur Verfügung gestellt. Die anderen 
Funktionen sind sozusagen Beiwerk und leisten einfachere Dinge.
zCArray_ptr ist in allen Funktionen ein Zeiger auf ein zCArray (siehe 
auch Misc.d).

MEM_ArrayCreate: Erzeuge ein leeres zCArray und gebe seine Adresse 
zurück.
MEM_ArrayFree:   Gebe sowohl das zCArray als auch seine Daten frei.
MEM_ArrayClear:  Gibt die Daten des zCArray frei. Es wird zu einem 
leeren Array.
MEM_ArrayInsert: Fügt value ans Ende des Arrays an. Das Array wird 
automatisch vergrößert falls es zu klein ist.

Entfernen von Elementen passiert durch auffüllen der Lücke mit dem 
letzten Element. Wird zum Beispiel aus einem Array (1,2,3,4,5) die 3 
entfernt, wird das Ergebnis so aussehen: (1,2,5,4). Die 5 ist in die 
entstehende Lücke gewandert.

MEM_ArrayRemoveIndex: Entfernt das Element an Position index.
MEM_ArrayRemoveValue: Sucht alle Vorkommen von value im Array und 
entfernt diese.
MEM_ArrayRemoveValueOnce: Sucht das erste Vorkommen von value im Array 
und entfernt dies. Wird value nicht gefunden wird eine Warnung 
ausgegeben.

Hinweis: Diese Funktionen erwarten Pointer auf ein zCArray! Nicht 
verwechseln mit der Adresse des ersten Datenelements oder dem 
Symbolindex irgendeines "var zCArray"! Manchmal wird man sich die 
Adresse eines zCArrays erst ausrechnen müssen und zwar aus der Adresse 
des Objekts, das dieses zCArray beinhaltet und dem Offset des zCArrays 
in der entsprechenden Klasse (Bytes zählen!).

Lesen und Schreiben auf Indizes ist selbst zu organisieren, zum Beispiel 
mit MEM_ReadIntArray, MEM_WriteIntArray angewendet auf zCArray.array. 

//******************

func void MEM_CopyBytes (var int src, var int dst, var int byteCount)
func void MEM_CopyWords (var int src, var int dst, var int wordcount)

func void MEM_SwapBytes (var int ptr1, var int ptr2, var int byteCount)
func void MEM_SwapWords (var int ptr1, var int ptr2, var int wordcount)

func int MEM_CompareBytes (var int ptr1, var int ptr2, var int byteCount)
func int MEM_CompareWords (var int ptr1, var int ptr2, var int wordcount)

Die hier aufgeführten Funktionen arbeiten jeweils auf zwei 
Speicherbereichen gleicher Größe, wobei die ersten zwei Parameter 
angeben wo die Speicherbereiche beginnen. Der dritte Parameter gibt die 
Größe beider Speicherbereiche an. Es gibt jeweils eine Version, die die 
Größe in Bytes entgegennimmt und eine Version, die die Größe in 
Speicherworten entgegenimmt (1 Wort = 4 Byte, was der Größe vieler 
primitiver Datentypen entspricht, zum Beispiel Integer).

/* Copy */
Die Varianten von MEM_Copy kopieren entsprechend viele Bytes bzw. Worte 
von der Quelle (beginnend von Speicherstelle src) ans Ziel (beginnend an 
Speicherstelle dst).

Beachte: Wenn sich die Speicherbereiche überlappen ist das Verhalten 
unspezifiziert.

/* Swap */
"Swap" bedeutet so viel wie tauschen. Die Daten beginnend an der Adresse 
ptr1 werden an die Adresse ptr2 verschoben und umgekehrt.

Beachte: Wenn sich die Speicherbereiche überlappen ist das Verhalten 
unspezifiziert.
Anmerkung: Es wird nur konstant viel zusätzlicher Speicher benötigt.

/* Compare */
Die Varianten von MEM_Compare vergleichen die Daten in den 
Speicherbereichen beginnend an ptr1 und ptr2. Bei Gleichheit wird 1 
zurückgegeben, bei Ungleichheit 0.

//******************

func void MEM_InitAll()

Kann benutzt werden anstelle der Initialisierungsfunktionen von 
einzelnen Features. Tut nichts anderes als MEM_InitGlobalInst, 
MEM_InitLabels, MEM_InitStatArrs, STR_GetAddressInit und 
MEM_ReinitParser aufzurufen.

Tipp: Ein Aufruf in INIT_GLOBAL ist empfehlenswert. Dann müssen bis nach 
dem nächsten Laden keine weiteren Initialisierungen mehr vorgenommen 
werden.

Vorsicht: Manche Funktionen werden noch vor INIT_GLOBAL aufgerufen. Zum 
Beispiel werden Npcs vor INIT_GLOBAL erzeugt. Wird also zum Beispiel 
während der Npc Erzeugung auf Ikarus Funktionalität zurückgegriffen der 
eine Initialisierung mit einer der genannten Funktionen vorausgehen 
muss, ist ein Aufruf von MEM_InitAll in INIT_GLOBAL nicht hinreichend. 
Im Zweifelsfall ist es zu empfehlen, die passende 
Initialisierungsfunktion noch einmal direkt bei der Verwendung 
aufzurufen. Mehrfache Aufrufe schaden nicht und haben keine 
nennenswerten Performancetechnischen Implikationen.

//######################################
// 13.) "Obskure" Funktionen

Ikarus bietet auch einige eher technische Funktionen an, deren Nutzen 
nicht unbedingt unmittelbar greifbar ist. Die meisten, die diese Paket 
benutzen, werden sie nicht brauchen, ich werde sie hier dennoch erklären.

//******************

func int MEM_GetFuncPtr(var func fnc)

Gibt die Adresse einer Daedalus Funktion zurück. Das ist der Ort im 
Speicher, an der ihr Code anfängt, das heißt die Adresse des ersten 
Tokens (z.B. zPAR_TOK_PUSHVAR), dass zur Funktion gehört.

func int MEM_GetFuncOffset(var func fnc)

Ähnlich wie MEM_GetFuncPtr, allerdings wird die Adresse nicht absolut, 
sondern relativ zum Anfang des Codes angegeben. Jumps und Calls nutzen 
solche relativen Adressen.

//******************

func int MEM_GetClassDef (var int objPtr)

Übergeben wird ein Zeiger objPtr auf ein zCObject O, also zum Beispiel 
auf ein zCVob oder ein zCMaterial. Viele Objekte, die mehr als simple 
Datenstrukturen sind, sind direkt oder indirekt von zCObject abgeleitet.
MEM_GetClassDef gibt einen Zeiger auf ein Objekt C vom Typ zCClassDef 
zurück. C enthält Informationen über die Klasse, der O angehört. Zum 
Beispiel würde MEM_GetClassDef (MEM_InstToPtr (hero)) einen Zeiger auf 
das zCClassDef Objekt liefern, dass zur Klasse oCNpc gehört.

zCClassDef hat einige Interessante Eigenschaften (siehe Misc.d).

func string MEM_GetClassName (var int objPtr)

ist eine einfache Anwendung von MEM_GetClassDef und gibt den 
Klassennamen der Klasse aus, der das Objekt angehört, auf das objPtr 
zeigt. Zum Bespiel liefert MEM_GetClassName (MEM_InstToPtr (hero)) den 
string "oCNpc".

Wenn diesen Funktionen ein Zeiger übergeben wird, der nicht auf ein 
zCObject zeigt, wird das mit großer Wahrscheinlichkeit zu einem Absturz 
führen.

//******************

func int MEM_GetBufferCRC32 (var int buf, var int buflen) 

Berechnet einen Hashwert aus einem Bytearray, dass an buf beginnt und 
Länge buflen hat. Es wird die selbe Hashfunktion verwendet wie in Gothic.

func int MEM_GetStringHash (var string str) {

Berechnet den Hashwert eines Strings. Es wird die selbe Hashfunktion 
verwendet wie in Gothic.
Bemerkung: Diese Funktion wird von MEM_SearchVobByName benutzt.

//******************

func int MEM_Alloc (var int amount)

Mit MEM_Alloc werden amount Byte Speicher alloziert und ein Zeiger auf 
den Speicherbereich zurückgegeben.
Gothic hält keine Referenz auf diesen Speicherbereich und kann ihn auch 
nicht freigeben (auch nicht beim Zerstören der Session!).
Speicher sollte daher nur dann reserviert werden, wenn er garantiert vor 
dem Laden eines Spielstands wieder mit MEM_Free freigegeben werden kann 
oder garantiert ist, dass Gothic von diesem Speicherbereich weiß und ihn 
selbstständig freigibt.
Vielleicht kann man mit dieser Funktion neue Objekte erzeugen und 
dauerhaft in die Objektstruktur von Gothic einbauen. Das Bedarf aber 
großer Vorsicht, da die Objektkonstrukturen nicht genutzt werden können. 
Man müsste alles von Hand machen.

Sehr gut geeignet dürfte diese Funktion sein um Kleinigkeiten wie 
Listenelemente zu bauen und in vorhandenen Listen zu integrieren. Der 
neu allozierte Speicher ist stets genullt.

func int MEM_Realloc (var int oldptr, var int oldsize, var int newsize)

Alloziert einen Speicherbereich der größe newsize und gibt einen Zeiger 
auf diesen Speicherbereich zurück.
Der Speicherbereich ab Stelle oldptr wird freigegeben.
Falls newsize >= oldsize werden die ersten oldsize Bytes aus dem alten 
Speicherbereich in den neuen übernommen. Der zusätzliche Speicher ist 
mit Null initialisiert.
Falls newsize <= oldsize werden alle Bytes des neuen Speicherbereichs 
mit den entsprechenden Werten des alten Speicherbereichs initialisiert.
Diese Funktion ist dazu gedacht um einen allozierten Speicherbereich zu 
vergrößern oder zu verkleinern. Vorhandene Daten bleiben auf natürliche 
Art und Weise erhalten.

func void MEM_Free (var int ptr)

Gibt einen allozierten Speicherbereich wieder frei.
Vielleicht kann man so auch Engine-Objekte zerstören. Auch hier ist 
große Vorsicht angesagt, da keine Destruktoren aufgerufen werden!

Kleinigkeiten wie Listenelemente können so aber problemlos freigegeben 
werden.

//******************

func void MEM_SetParser(var int parserID)

Hiermit lässt sich der aktuelle Parser auf etwas anderes als den 
Content-Parser umstellen. Dies ist nötig, wenn man zum Beispiel mit 
Symbolen im Menü suchen und bearbeiten will. Kommunikation mit den 
Menüskripten wird dadurch möglich. Aber leider ist das ganze nicht ohne 
Tücken und vermutlich eher uninteressant, weil die Menüskripte selten 
von Gothic aufgerufen werden. Bestimmte Menüobjekte bleiben über die 
Session hinaus erhalten.

//******************

func void MemoryProtectionOverride (var int address, var int size)

Der Versuch das Codesegment oder schreibgeschützte Datensegmente zu 
beschreiben wird eine Accessviolation verursachen. 
MemoryProtectionOverride hebelt diesen Schreibschutz für den 
Adressbereich aus, der bei address beginnt und size Bytes groß ist.

Anmerkung: MemoryProtectionOverride hebt den Schreibschutz für alle 
Seite auf, die mindestens ein Byte im spezifizierten Adressbereich 
beinhalten. Im Allgemeinen ist also ein größerer Speicherbereich 
betroffen als angegeben.
MemoryProtectionOverride benutzt die Windows Funktion VirtualProtect.



//######################################
// VI. Gefahren
//######################################

Dieses Skriptpaket heißt nicht umsonst Ikarus:
Man kann die Grenzen von Daedalus hinter sich lassen, aber dabei auch 
auf die Schnauze fallen. Wer etwa an ungültigen Adressen liest, bekommt 
dabei keine zSpy-Warnung, sondern landet auf dem Desktop mit einer 
Access Violations. Dies ist kein Grund zur Panik, setzt aber 
Frusttolleranz vorraus (die man als Skripter aber auch sonst gut 
gebrauchen kann).

Natürlich kann man auch solche spektakulär anmutenden Fehler beheben und 
wenn man konzentriert und planvoll arbeitet, wird man schon was 
vernünftiges zu Stande bringen.

Kurz gesagt: Besondere Sorgfalt ist geboten! Ein Bug der zum Absturz 
führt ist nichts, was man in der Releaseversion haben will. Aber wenn 
man sauber arbeitet und ausführlich testet ist das alles halb so wild.

Ein guter Freund beim beheben von Abstürzen ist zweifellos PrintDebug, 
damit ist es möglich Meldungen an den zSpy zu schicken (zum Beispiel um 
einzugrenzen wo der Absturz überhaupt stattfindet). Auf die Funktion 
MEM_SetShowDebug und den Textfilter (Options -> Textfilter) im zSpy sei 
in diesem Zusammenhang nochmal besonders hingewiesen.

//######################################
// VII. Beispiele
//######################################

//--------------------------------------
// 1.) Funktion zum öffnen der Truhe im Fokus:

func void OpenFocussedChestOrDoor() {
    var oCNpc her;
    her = Hlp_GetNpc (hero);
    
    //Gar kein Fokusvob?
    if (!her.focus_vob) {
        Print ("Kein Fokus!");
        return;
    };
    
    //Fokusvob kein verschließbares Vob?
    if (!Hlp_Is_oCMobLockable(her.focus_vob)) {
        Print ("Keine Truhe oder Tür im Fokus!");
        return;
    };
    
    var oCMobLockable Lockable;
    Lockable = MEM_PtrToInst (her.focus_vob);
    
    if (Lockable.bitfield & oCMobLockable_bitfield_locked) {
        Lockable.bitfield = Lockable.bitfield & ~ 
oCMobLockable_bitfield_locked;
        
        Print (ConcatStrings (
                "Folgendes Vob geöffnet: ",
                Lockable._zCObject_objectName));
    } else {
        Print (ConcatStrings (
                Lockable._zCObject_objectName,
                " war gar nicht abgeschlossen!"));
    };
};

//--------------------------------------
// 2.) Kameraposition ermitteln:

func void PrintCameraPos() {
    /* Globale Instanzen (die es nur einmal gibt) initialisieren: */
    /* Initialisiert MEM_World, MEM_Game, etc. u.a. auch MEM_Camera */
    MEM_InitGlobalInst();
    
    /* Das Kameraobjekt ist kein vob (sondern was abstraktes),
     * weiß nicht wo und wie da Positionsdaten stehen.
    Ich arbeite lieber auf dem Kameravob: */
    var zCVob camVob;
    camVob = MEM_PtrToInst (MEM_Camera.connectedVob);
    
    /*Hier muss man wissen wie die Transformationsmatrix aufgebaut ist:

        Sie besteht aus drei Vektoren, die x, y und z Richtung
        des lokalen Koordinatensystem des Kameravobs
        in Weltkoordinaten angeben (dabei müsste z die
        Blickrichtung sein). Ich habe diese Vektoren hier
        mit v1, v2, v3 Bezeichnet.
        Zusätzlich gibt es in der 4. Spalte die Translation,
        das heißt die Position der Kamera.
    
        v1_x    v2_x    v3_x    x
        v1_y    v2_y    v3_y    y
        v1_z    v3_z    v3_z    z
        0       0       0       0
        
        Die Matrix ist Zeilenweise im Speicher abgelegt.
        Da wir uns für die letzte Spalte interessieren sind die Indizes
        im trafoWorld Array 3, 7 und 11, die wir brauchen.
    */
    
    Print (ConcatStrings ("x: ", 
IntToString(roundf(camVob.trafoObjToWorld[ 3]))));
    Print (ConcatStrings ("y: ", 
IntToString(roundf(camVob.trafoObjToWorld[ 7]))));
    Print (ConcatStrings ("z: ", 
IntToString(roundf(camVob.trafoObjToWorld[11]))));
};

//--------------------------------------
// 3.) Regen starten

func void StartRain() {
    /* Globale Instanzen initialisieren: */
    MEM_InitGlobalInst(); /* Hierrunter fällt auch der Skycontroller */
    
    /* man könnte sich jetzt hier was besseres überlegen,
     * aber ich machs mal so: */
    
    /* start am Anfang vom Tag (12:00 Uhr mittags) */
    MEM_SkyController.rainFX_timeStartRain = 0; //FLOATNULL;
     /* ende am Ende vom Tag (12:00 Uhr mittags des nächsten Tags) */
    MEM_SkyController.rainFX_timeStopRain = 1065353216; //FLOATEINS;
    
    /* Bemerkung dazu: Die Start und Endzeiten sind Gleitkommazahlen.
     * 0 steht für den Anfang des Tages 1 für das Ende des Tages.
     * Ein "Skytag" beginnt um 12:00 Uhr.
     * Zum Aufbau des Gleitkommaformats google man nach IEEE 745.
     * Ich habe mal floats in Daedalus implementiert:
     * http://forum.worldofplayers.de/forum/showthread.php?t=500080
     * Diese Implementierung kann man nutzen um sich
     * floats aus Ganzzahlen bauen zu lassen. */
    
    /* Ergebnis: Ganzer Tag regen! (es sei denn man ist in einer Zone
     * in der es schneit, dann den ganzen Tag Schnee) */
};

//--------------------------------------
// 4.) Geschachtelte Schleife
    
/* Soll alle Paare (x,y) aufzählen mit
    0 <= x < max_x,
    0 <= j < max_y
*/
    
func void printpairs(var int max_x, var int max_y) {
    /* Sprung-System initialisieren */
    MEM_InitLabels();
    /* PrintDebug soll benutzt werden, also Debugausgabe aktivieren */
    MEM_SetShowDebug (1);

    var int x; var int y;
    x = 0; 
    
    /* while (x < max_x) */
    var int x_loop; x_loop = MEM_StackPos.position;
    if (x < max_x) {
        y = 0;
        /* while (y < max_y) */
        var int y_loop; y_loop = MEM_StackPos.position;
        if (y < max_y) {
            var string out; out = "(";
            out = ConcatStrings (out, IntToString (x));
            out = ConcatStrings (out, ", ");
            out = ConcatStrings (out, IntToString (y));
            out = ConcatStrings (out, ")");
            PrintDebug (out);
            
            y += 1;
            
            /* continue y_loop */
            MEM_StackPos.position = y_loop;
        };
        
        x += 1;
        
        /* continue x_loop */
        MEM_StackPos.position = x_loop;
    };
};

/* Ausgabe eines Aufrufs printpairs (4,2) wäre dann:
    00:36 Info:  5 U:    Skript: (0, 0) .... <zError.cpp,#465>
    00:36 Info:  5 U:    Skript: (0, 1) .... <zError.cpp,#465>
    00:36 Info:  5 U:    Skript: (1, 0) .... <zError.cpp,#465>
    00:36 Info:  5 U:    Skript: (1, 1) .... <zError.cpp,#465>
    00:36 Info:  5 U:    Skript: (2, 0) .... <zError.cpp,#465>
    00:36 Info:  5 U:    Skript: (2, 1) .... <zError.cpp,#465>
    00:36 Info:  5 U:    Skript: (3, 0) .... <zError.cpp,#465>
    00:36 Info:  5 U:    Skript: (3, 1) .... <zError.cpp,#465>
*/

//--------------------------------------
// 5.) Aufrufen einer Funktion
//     anhand ihres Namens.

/* Dieses Beispiel zeigt nicht, weshalb MEM_CallByString
 * praktisch ist, aber wie man die Funktion benutzt. */
 
var zCVob someObject;
func int MyFunction(var int param1, var string str1,
                    var int param2, var string str2) {
    Print (ConcatStrings (str1, str2)); //(*)
    return 100 * param1 + param2;
};

func void foo() {
    var int result;
    
    /* Der Code zwischen A und B ist in diesem Fall
     * äquivalent zu:
     *   result = MyFunction (42, "Hello ", 23, "World!");
     *                                                    */
    
    /* A */
    MEM_PushIntParam (42);
    MEM_PushStringParam ("Hello ");
    MEM_PushIntParam (23);
    MEM_PushStringParam ("World!");
    
    MEM_CallByString ("MYFUNCTION");
    
    result = MEM_PopIntResult();
    /* B */
    
    Print (IntToString (result)); //(**)
};

/* Ausgegeben wird "Hello World" (das macht MyFunction bei (*))
 * sowie "4223" (das macht foo bei (**)). */

/* Anmerkung: Da Symbolindizes fortlaufend sind
 * und der Symbolindex von someObject einfach durch
 * someObject selbst gegeben ist, könnte
 * MEM_CallByString ("MYFUNCTION");
 * hier auch ersetzt werden durch
 * MEM_CallByID (someObject + 1); */
