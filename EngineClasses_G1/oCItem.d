class oCItem {
//  zCVob {
//      zCObject {
            var int    vfptr;
            var int    _zCObject_refCtr;
            var int    _zCObject_hashIndex;
            var int    _zCObject_hashNext;
            var string _zCObject_objectName;
//      }
        var int        _zCVob_globalVobTreeNode;
        var int        _zCVob_lastTimeDrawn;
        var int        _zCVob_lastTimeCollected;
        var int        _zCVob_vobLeafList_array;
        var int        _zCVob_vobLeafList_numAlloc;
        var int        _zCVob_vobLeafList_numInArray;
        var int        _zCVob_trafoObjToWorld[16];
        var int        _zCVob_bbox3D_mins[3];
        var int        _zCVob_bbox3D_maxs[3];
        var int        _zCVob_touchVobList_array;
        var int        _zCVob_touchVobList_numAlloc;
        var int        _zCVob_touchVobList_numInArray;
        var int        _zCVob_type;
        var int        _zCVob_groundShadowSizePacked;
        var int        _zCVob_homeWorld;
        var int        _zCVob_groundPoly;
        var int        _zCVob_callback_ai;
        var int        _zCVob_trafo;
        var int        _zCVob_visual;
        var int        _zCVob_visualAlpha;
        var int        _zCVob_rigidBody;
        var int        _zCVob_lightColorStat;
        var int        _zCVob_lightColorDyn;
        var int        _zCVob_lightDirectionStat[3];
        var int        _zCVob_vobPresetName;
        var int        _zCVob_eventManager;
        var int        _zCVob_nextOnTimer;
        var int        _zCVob_bitfield[5];
        var int        _zCVob_m_poCollisionObjectClass;
        var int        _zCVob_m_poCollisionObject;
//  }
  
	// Für alle Items
	VAR INT		id								;				
	VAR STRING  name,nameID						;
	VAR INT		hp,hp_max						;

	VAR INT     mainflag,flags					;		//	Hauptflag und weitere Flags
	VAR INT		weight,value					;			
															
	// Für Waffen								
	VAR INT		damageType						;		//	Welche Schadensarten
	VAR	INT		damageTotal						;
	VAR INT		damage			[DAM_INDEX_MAX]	;

	// Für Rüstungen
	VAR INT		wear							;
	VAR INT		protection		[PROT_INDEX_MAX];

	// Für Nahrung
	VAR INT		nutrition						;		//	HP-Steigerung bei Nahrung

	// Benötigte Attribute zum Benutzen des Items
	VAR INT		cond_atr		[3]				;
	VAR INT		cond_value		[3]				;

	// Attribute, die bei anlegen des Items verändert werden
	VAR INT		change_atr		[3]				;
	VAR INT		change_value	[3]				;

	// Parserfunktionen
	VAR FUNC	magic							;		//	Parserfunktion zum "Magie Header"
	VAR FUNC	on_equip						;		//	Parserfunktion, wenn Item equipped wird.
	VAR FUNC	on_unequip						;		//	Parserfunktion, wenn Item unequipped wird.
	VAR FUNC	on_state		[4]				;			
															
	// Besitzer									
	VAR FUNC	owner							;		//	Besitzer : Instanz-Name
	VAR INT		ownerGuild						;		//	Besitzer : Gilde
	VAR INT		disguiseGuild					;		//	Zur Schau getragene Gilde durch Verkleidung

	// Die 3DS-Datei
	VAR STRING	visual							;

	// Veränderung des NSC-Meshes beim Anlegen dieses Gegenstandes
	VAR STRING  visual_change					;		//	ASC - File
	VAR INT		visual_skin						;
	
	VAR STRING 	scemeName						;
	VAR INT		material						;	
	// VAR STRING	pfx								;		//	Magic Weapon PFX
	VAR INT		munition						;		//	Instance of Munition
															
	var int 	spell							;			
	var int		range							;			
	
	var int		mag_circle						;
	
	VAR STRING	description						;
	VAR STRING	text			[ITM_TEXT_MAX]	;
	VAR INT		count			[ITM_TEXT_MAX]	;
	
	var int amount;							//int Wieviele Items sind das (Itemstapel)
	var int instanz;						//int Symbolindex
	var int c_manipulation;					//int ?
	var int last_manipulation;				//zREAL ?
	var int magic_value;					//int ?
	var int next;							//oCItem* sind wohl einfach verkettete Listen.
};				