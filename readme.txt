Abh�ngig von der Gothic Version (1 oder 2) ist die G1 oder G2 Versionen
vom EngineClasses Ordner sowie der Ikarus_Const.d zu w�hlen.

Zun�chst ist die Datei Ikarus_Const_G[x] zu parsen,
danach alle Dateien im Ordner "EngineClasses_G[X]"
und zuletzt Ikarus.d (unabh�ngig von der Gothic Version).
Die Datei Ikarus_Doc.d ist nat�rlich NICHT zu parsen.

Ikarus.d             enth�lt s�mtliche Funktionen von Ikarus.
Ikarus_Const_G[X].d  enth�lt spezifische Konstanten f�r die Gothic Version [X].
Die Klassen          halten fest welche Eigenschaften wo zu finden sind.
Ikarus_Doc.d         enth�lt ausf�hrliche Informationen zur Nutzung dieses Pakets.

Die Datei float.d enth�lt eine von Ikarus abh�ngige Funktionensammlung
um mit Floatingpointwerten (bzw. zREAL) zu rechnen. Dies stellt eine
Empfehlenswerte aber nicht notwendige Erg�nzung zu Ikarus dar.
Die Benutzung ist in der Datei selbst erkl�rt.
Die Datei muss nach Ikarus.d geparst werden.

Um Ikarus zu nutzen, braucht lediglich Ikarus_G1.src, bzw. Ikarus_G2.src
in die Gothic.src eingetragen zu werden.
