Abhängig von der Gothic Version (1 oder 2) ist die G1 oder G2 Versionen
vom EngineClasses Ordner sowie der Ikarus_Const.d zu wählen.

Zunächst ist die Datei Ikarus_Const_G[x] zu parsen,
danach alle Dateien im Ordner "EngineClasses_G[X]"
und zuletzt Ikarus.d (unabhängig von der Gothic Version).
Die Datei Ikarus_Doc.d ist natürlich NICHT zu parsen.

Ikarus.d             enthält sämtliche Funktionen von Ikarus.
Ikarus_Const_G[X].d  enthält spezifische Konstanten für die Gothic Version [X].
Die Klassen          halten fest welche Eigenschaften wo zu finden sind.
Ikarus_Doc.d         enthält ausführliche Informationen zur Nutzung dieses Pakets.

Die Datei float.d enthält eine von Ikarus abhängige Funktionensammlung
um mit Floatingpointwerten (bzw. zREAL) zu rechnen. Dies stellt eine
Empfehlenswerte aber nicht notwendige Ergänzung zu Ikarus dar.
Die Benutzung ist in der Datei selbst erklärt.
Die Datei muss nach Ikarus.d geparst werden.

Um Ikarus zu nutzen, braucht lediglich Ikarus_G1.src, bzw. Ikarus_G2.src
in die Gothic.src eingetragen zu werden.
