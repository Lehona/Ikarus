//--------------------------------------
// Baum / Knoten. Für Vobtree
//--------------------------------------

//template <class T> 
class zCTree {
    var int parent;            //zCTree* 
    var int firstChild;        //zCTree* 
    var int next;              //zCTree* 
    var int prev;              //zCTree* 
    var int data;              //T*
};

//--------------------------------------
// Listen, Arrays. Treten oft auf.
//--------------------------------------

const int sizeof_zCArray = 12;

/* zCArray ist eine sehr einfache und gleichzeitig sehr wichtige Datenstruktur. */

//template <class T> 
class zCArray {
    var int array;              //T*        //Zeiger auf Speicherbereich
    var int numAlloc;           //int       //Für wieviele Elemente ist gerade Speicher reserviert?
    var int numInArray;         //int       //Anzahl der Elemente in diesem Speicherbereich
};

//template <class T> 
class zCArraySort {
    var int array;              //T*
    var int numAlloc;           //int
    var int numInArray;         //int
    var int compare;            //int (*Compare)(const T* ele1,const T* ele2);
};

//template <class T>
class zList {
    var int compare;            //int (*Compare)(const T* ele1,const T* ele2);
    var int count;              //Anzahl Elemente
    var int last;               //T*
    var int wurzel;             //T*
};

//template <class T> 
class zCList {
    var int data;               //T*
    var int next;               //zCList<T>*
};

//template <class T> 
class zCListSort {
    var int compareFunc;        //int (*Compare)(T *ele1,T *ele2);
    var int data;               //T*
    var int next;               //zCListSort<T>*
};

//zMAT4
class zMAT4 {
    /* die Matrix hat folgende Gestalt:
     *
     *  x1  y1  z1  p1
     *  x2  y2  z2  p2
     *  x3  y3  z3  p3
     *
     * Dabei sind x, y, z die Bilder der Einheitsvektoren unter der Transformation.
     * Andersgesagt: x, y, z sind die Vektoren, die im Spacer angezeigt werden, wenn man das
     * Vob anklickt (davon ist y die Komponente die normalerweise nach oben zeigt).
     * Ist ein Punkt im lokalen Koordinatensystem des Vobs an (a1, a2, a3), und liegt das
     * Vob mit Transformationsmatrix M in der Welt dann ist der Punkt im
     * Koordinatensystem der Welt an M * (a1, a2, a3, 1)^T.
     * ("^T" soll nur bedeuten, dass der Vektor eigentlich senkrecht stehen muss).
     * Die vierte Zeile der Matrix ist ungenutzt und sinnlos. */
    
    /* Zeilenweise */
    var int v0[4]; //zREAL[4]
    var int v1[4]; //zREAL[4]
    var int v2[4]; //zREAL[4]
    var int v3[4]; //zREAL[4]
};

//andere Formulierung, wer lieber alles in einem array haben will:
class zMATRIX4 {
    var int trafo[16]; //zREAL[16]
};

//------------------------------------------------
//  zTPlane: Ebene im Raum
//------------------------------------------------

class zTPlane 
{
    var int distance;    //zREAL    //vermutlich Distanz zum Ursprung (was sonst?)
    var int normal[3];   //zPOINT3  //normalenvektor
};

//------------------------------------------------
//  zCPolygon
//------------------------------------------------

/* Bedeutung von zCPolygon.portalPoly:

    enum zTPortalType   { zPORTAL_TYPE_NONE         = 0, 
                          zPORTAL_TYPE_SMALL        = 1, 
                          zPORTAL_TYPE_BIG          = 2, 
                          zPORTAL_TYPE_BIG_NOFADE   = 3 
                        };
*/
const int zCPolygon_bitfield_polyNumVert            = ((1 <<  8) - 1) <<  0;
const int zCPolygon_bitfield_portalPoly             = ((1 <<  2) - 1) <<  8;
const int zCPolygon_bitfield_occluder               = ((1 <<  1) - 1) << 10;
const int zCPolygon_bitfield_sectorPoly             = ((1 <<  1) - 1) << 11;
const int zCPolygon_bitfield_mustRelight            = ((1 <<  1) - 1) << 12;
const int zCPolygon_bitfield_portalIndoorOutdoor    = ((1 <<  1) - 1) << 13;
const int zCPolygon_bitfield_ghostOccluder          = ((1 <<  1) - 1) << 14;
const int zCPolygon_bitfield_noDynLightNear         = ((1 <<  1) - 1) << 15;
const int zCPolygon_bitfield_sectorIndex            = ((1 << 16) - 1) << 16; //indoor only

class zCVertFeature {
    var int vertNormal[3];    //zPOINT3
	var int lightStat;        //zCOLOR	
	var int lightDyn;         //zCOLOR	
	var int texu;             //zVALUE	
    var int texv;             //zVALUE 
};

class zCPolygon 
{
/*0x0000*/    var int vertex;                 //zCVertex** //array
/*0x0004*/    var int lastTimeDrawn;          //int
    
              //zTPlane               polyPlane;
/*0x0008*/        var int polyPlane_distance;     //zREAL
/*0x000C*/        var int polyPlane_normal[3];    //zVEC3
    
/*0x0018*/    var int material;               //zCMaterial*
/*0x001C*/    var int lightmap;               //zCLightMap*

/*0x0020*/    var int clipVert;               //zCVertex      **    
/*0x0024*/    var int clipFeat;               //zCVertFeature **
/*0x0028*/    var int numClipVert;            //int

/*0x002C*/    var int feature;                //zCVertFeature ** //array
/*0x0030*/    var int bitfield;
};

class zCMaterial {
    //zCObject {
      var int    _vtbl;
      var int    _zCObject_refCtr;
      var int    _zCObject_hashIndex;
      var int    _zCObject_hashNext;
      var string _zCObject_objectName;

	//zCArray<zCPolygon*>		polyList;
        var int polyList_array;         //zCPolygon**
        var int polyList_numAlloc;      //int
        var int polyList_numInArray;    //int
        
    var int polyListTimeStamp;          //zDWORD		
	var int texture;                    //zCTexture*	
	var int color;						//zCOLOR		
	var int smoothAngle;                //zREAL		
	var int matGroup;                   //zTMat_Group	
	var int bspSectorFront;			    //zCBspSector*	 //outdoor
	var int bspSectorBack;				//zCBspSector*	 //outdoor
	var int texAniCtrl;                 //zCTexAniCtrl
	var int detailObjectVisualName;     //zSTRING*		

	var int kambient;                        //zREAL
    var int kdiffuse;                        //zREAL
    
    var int m_bEnvironmentalMappingStrength; //zREAL
    
    var int bitfield[7]; //???
    
    /*
		zUINT8				 smooth					: 1;
		zUINT8				 dontUseLightmaps		: 1;
		zUINT8				 texAniMap				: 1;
		zUINT8				 lodDontCollapse		: 1;
		zUINT8				 noCollDet				: 1;
		zUINT8				 forceOccluder			: 1;
		zUINT8				 m_bEnvironmentalMapping: 1;
		zUINT8				 polyListNeedsSort		: 1;
		zUINT8				 matUsage				: 8;
		zUINT8				 libFlag				: 8;
		zTRnd_AlphaBlendFunc rndAlphaBlendFunc		: 8;
		zUINT8				 m_bIgnoreSun			: 1;
	*/
	                                       
	var int m_enuWaveMode;                   //zTWaveAniMode	
	var int m_enuWaveSpeed;                  //zTFFT			
	var int m_fWaveMaxAmplitude;             //float			
	var int m_fWaveGridSize;                 //float			
                                           
	var int detailTexture;                   //zCTexture*                  
	var int detailTextureScale;              //zREAL		                    
	var int texAniMapDelta[2];               //zPOINT2		                
                                           
	var int default_mapping[2];              //zPOINT2		                    
	var int texScale[2];                     //zPOINT2		                        
};

class zTPortalInfo {
	var int visible;        //zBYTE
	var int alpha;          //zBYTE
};

class zCBspSector {
	var string sectorName;             //zSTRING
	
    //zCArray<zCBspBase*>				sectorNodes;
        var int sectorNodes_array;        //zCBspBase**
        var int sectorNodes_numAlloc;    //int
        var int sectorNodes_numInArray;  //int
        
	var int sectorIndex;		        //zDWORD
    
	//zCArray<zCPolygon*>				sectorPortals;
        var int sectorPortals_array;        //zCPolygon**
        var int sectorPortals_numAlloc;    //int
        var int sectorPortals_numInArray;  //int
    
	//zCArray<zTPortalInfo>			sectorPortalInfo;
        var int sectorPortalInfo_array;      //zTPortalInfo*
        var int sectorPortalInfo_numAlloc;  //int
        var int sectorPortalInfo_numInArray;//int
    
	var int activated;          //zTFrameCtr	
	var int rendered;           //zTFrameCtr	
	//zTBBox2D	 activePortal;
        var int mins[2];                //zVEC2
        var int maxs[2];                //zVEC2
	var int sectorCenter[3];	//zVEC3
	var int hasBigNoFade;		//zBOOL8	
};

//--------------------------------------
// Boundingbox
//--------------------------------------

class zTBBox3D {
	var int mins[3]; //zPOINT3	
	var int maxs[3]; //zPOINT3
};

//--------------------------------------
// Portalzeug
//--------------------------------------

class oCPortalRoom {
    var string portalName;    //zSTRING 
    var string ownerNpc;      //zSTRING 
    var int ownerGuild;    //int           
};

class oCPortalRoomManager {
    var int oldPlayerPortal;    //zSTRING*      
    var int curPlayerPortal;    //zSTRING*      
    var int oldPlayerRoom;      //oCPortalRoom*
    var int curPlayerRoom;      //oCPortalRoom*

    //zCArraySort <oCPortalRoom*> portals;
        var int portals_array;      //oCPortalRoom**
        var int portals_numAlloc;   //int
        var int portals_numInArray; //int
        var int portals_compare;    //int (*Compare)(const oCPortalRoom* ele1,const oCPortalRoom* ele2); //sortiert nach Portalnamen.
};

//--------------------------------------
// Timer (technisch und spieltechnisch)
//--------------------------------------

class zCTimer {
    var int factorMotion;        //zREAL        //nicht zu klein machen. Sonst: Freeze bei hoher Framerate!
    var int frameTimeFloat;      //zREAL [msec] //Zeit der zwischen diesem und dem letzten Frame verstrichen ist
    var int totalTimeFloat;      //zREAL [msec] //gesamte Zeit
    var int frameTimeFloatSecs;  //zREAL  [s]
    var int totalTimeFloatSecs;  //zREAL  [s]
    var int lastTimer;           //zDWORD
    var int frameTime;           //zDWORD [msec] //nochmal als Ganzahl
    var int totalTime;           //zDWORD [msec]
    var int minFrameTime;        //zDWORD       //antifreeze. Sonst wird die Framezeit auf 0 gerundet und nichts bewegt sich
          
    var int forcedMaxFrameTime;  //zDWORD //länger als das darf ein Frame (in Spielzeit) nicht dauern. Um zu große Zeitsprünge für die Objekte zu vermeiden? Jedenfalls sort dies dafür, dass das Spiel langsamer läuft, wenn das Spiel mit rendern nicht hinterherkommt.
};

const int oCWorldTimer_TicksPerHour		  = 250000;
const int oCWorldTimer_TicksPerMin_approx = 4167; //< 1 sec / Tag daneben

class oCWorldTimer {
    //250000 Ticks pro Stunde
    var int worldTime;    //zREAL   
    var int day;          //int      
};

//--------------------------------------
// Spawnmanager
//--------------------------------------

/* Ausbeute der Klasse ist eher gering, aber folgende
 * drei statischen Variablen sind sehr interessant:

     SPAWN_INSERTTIME_MAX_Address
     SPAWN_INSERTRANGE_Address   
     SPAWN_REMOVERANGE_Address   

 * Eingeführt sind sie in Ikarus_Const.d */

class oTSpawnNode {
    var int npc;         //oCNpc *
    var int spawnPos[3]; //zVEC3
    var int timer;       //zREAL
};

class oCSpawnManager {
    //zCArray<oTSpawnNode*> spawnList;
        var int spawnList_array;        //oTSpawnNode**
        var int spawnList_numAlloc;     //int
        var int spawnList_numInArray;   //int
        
    var int spawningEnabled;        //zBOOL
    var int camPos[3];              //zVEC3
    var int insertTime;             //zREAL //Verzögerungszeit des Spawnmanagers (Performancegründe)

    var int spawnFlags; //war mal ne Kopierschutz Sache, böse Raubkopierer hatten mit gepimpten immortal Flags zu kämpfen. jetzt ungenutzt.
};

//--------------------------------------
// zCOLOR
//--------------------------------------

const int zCOLOR_CHANNEL     = (1 << 8) - 1;
const int zCOLOR_SHIFT_RED   = 16;
const int zCOLOR_SHIFT_GREEN = 8;
const int zCOLOR_SHIFT_BLUE  = 0;
const int zCOLOR_SHIFT_ALPHA = 24;

const int zCOLOR_RED   = zCOLOR_CHANNEL << zCOLOR_SHIFT_RED;
const int zCOLOR_GREEN = zCOLOR_CHANNEL << zCOLOR_SHIFT_GREEN;
const int zCOLOR_BLUE  = zCOLOR_CHANNEL << zCOLOR_SHIFT_BLUE;
const int zCOLOR_ALPHA = zCOLOR_CHANNEL << zCOLOR_SHIFT_ALPHA;

//--------------------------------------
// Light
//--------------------------------------
const int zCVobLight_bitfield_isStatic       = ((1 << 1) - 1) <<  0;
const int zCVobLight_bitfield_rangeAniSmooth = ((1 << 1) - 1) <<  1;
const int zCVobLight_bitfield_rangeAniLoop   = ((1 << 1) - 1) <<  2;
const int zCVobLight_bitfield_colorAniSmooth = ((1 << 1) - 1) <<  3;
const int zCVobLight_bitfield_colorAniLoop   = ((1 << 1) - 1) <<  4;
const int zCVobLight_bitfield_isTurnedOn     = ((1 << 1) - 1) <<  5;
const int zCVobLight_bitfield_lightQuality   = ((1 << 4) - 1) <<  6;
const int zCVobLight_bitfield_lightType      = ((1 << 4) - 1) << 10;
const int zCVobLight_bitfield_m_bCanMove     = ((1 << 1) - 1) << 14;

const int zCVobLight_lightData_colorAniList_array_offset = 300; //0x12C

class zCVobLight {
    //zCVob {
      //zCObject {
      var int    _vtbl;
      var int    _zCObject_refCtr;
      var int    _zCObject_hashIndex;
      var int    _zCObject_hashNext;
      var string _zCObject_objectName;
      //}
      var int    _zCVob_globalVobTreeNode;
      var int    _zCVob_lastTimeDrawn;
      var int    _zCVob_lastTimeCollected;
      var int    _zCVob_vobLeafList_array;
      var int    _zCVob_vobLeafList_numAlloc;
      var int    _zCVob_vobLeafList_numInArray;
      var int    _zCVob_trafoObjToWorld[16];
      var int    _zCVob_bbox3D_mins[3];
      var int    _zCVob_bbox3D_maxs[3];
      var int    _zCVob_bsphere3D_center[3];
      var int    _zCVob_bsphere3D_radius;
      var int    _zCVob_touchVobList_array;
      var int    _zCVob_touchVobList_numAlloc;
      var int    _zCVob_touchVobList_numInArray;
      var int    _zCVob_type;
      var int    _zCVob_groundShadowSizePacked;
      var int    _zCVob_homeWorld;
      var int    _zCVob_groundPoly;
      var int    _zCVob_callback_ai;
      var int    _zCVob_trafo;
      var int    _zCVob_visual;
      var int    _zCVob_visualAlpha;
      var int    _zCVob_m_fVobFarClipZScale;
      var int    _zCVob_m_AniMode;
      var int    _zCVob_m_aniModeStrength;
      var int    _zCVob_m_zBias;
      var int    _zCVob_rigidBody;
      var int    _zCVob_lightColorStat;
      var int    _zCVob_lightColorDyn;
      var int    _zCVob_lightDirectionStat[3];
      var int    _zCVob_vobPresetName;
      var int    _zCVob_eventManager;
      var int    _zCVob_nextOnTimer;
      var int    _zCVob_bitfield[5];
      var int    _zCVob_m_poCollisionObjectClass;
      var int    _zCVob_m_poCollisionObject;
    
    //Ein Licht Vob kann verschiedene Farben und Reichweite haben.
    //Schließlich gibt es animierte Lichter!
    
             //zCVobLightData    lightData;
                 //zCArray<zVALUE>       rangeAniScaleList; //zREAL ~ zVALUE
/*0x120*/            var int lightData_rangeAniScaleList_array;      //zVALUE*
/*0x124*/            var int lightData_rangeAniScaleList_numAlloc;   //int
/*0x128*/            var int lightData_rangeAniScaleList_numInArray; //int
         
                 //zCArray<zCOLOR>       colorAniList;
/*0x12C*/            var int lightData_colorAniList_array;           //zCOLOR*
/*0x130*/            var int lightData_colorAniList_numAlloc;        //int
/*0x134*/            var int lightData_colorAniList_numInArray;      //int
                 
/*0x138*/        var int lensFlareFXNo;                              //int                  
/*0x13C*/        var int lensFlareFX;                                //zCLensFlareFX*
                 
/*0x140*/        var int lightColor;                                 //zCOLOR //Alphakanal hier irrelevant
/*0x144*/        var int range;                                      //zVALUE
/*0x148*/        var int rangeInv;                                   //zVALUE
/*0x14C*/        var int rangeBackup;                                //zVALUE
                 
                 //Daten zur Lichtanimation
                 //Zustand der Reichweitenanimation
/*0x150*/        var int rangeAniActFrame;                           //zVALUE
/*0x154*/        var int rangeAniFPS;                                //zVALUE
                 
                 //Zustand der Farbanimation
/*0x158*/        var int colorAniActFrame;                           //zVALUE                
/*0x15C*/        var int colorAniFPS;                                //zVALUE                
                 
                 // spotLights? Ich kenne das Feature nicht.
/*0x160*/        var int spotConeAngleDeg;                           //zREAL
                 
                 //Siehe Auflistung oben
/*0x164*/        var int bitfield;
        
    
             //zTRayTurboValMap<zCPolygon*, int>affectedPolyMap;
                 /*
                 struct zSNode                                   
                 {                                               
                     KEY             m_Key       ;               
                     ELEMENT         m_Element   ;               
                     unsigned long   m_u32Hash   ;               
                     zSNode*         m_pNext     ;               
                 }; */
                 //zCArray<zSNode*>              m_arrNodes;
/*0x168*/            var int affectedPolyMap_m_arrNodes_array;       //zSNode**
/*0x16C*/            var int affectedPolyMap_m_arrNodes_numAlloc;    //int
/*0x170*/            var int affectedPolyMap_m_arrNodes_nunInArray;  //int
    
/*0x174*/    var string lightPresetInUse;                //zSTRING
};

//--------------------------------------
// Magie buch
//--------------------------------------

/* Beschreibungen ergänzt von Mud-freak. Danke dafür! */

/* Genutzt um den Kreis über dem Spieler bei der Zauberauswahl anzuzeigen 
 * außerdem für zuordnungen von Zaubern <-> Items <-> Tasten. */

class oCMag_Book {
    //zCArray    <oCSpell*>   spells;
        var int spells_array;
        var int spells_numAlloc;
        var int spells_numInArray;
    //zCArray    <oCItem*>    spellitems;
        var int spellitems_array;
        var int spellitems_numAlloc;
        var int spellitems_numInArray;
    
    var int wld;                //zCWorld*    
    var int owner;              //zCVob*      
    var int model;              //zCModel*    //model of the owner (seems to be kind of redundant)
    var int spellnr;            //int         //selected spell --> n+4 = Slot/Taste
    var int MAG_HEIGHT;         //zREAL       //some offset to shift the spell above the head of the owner (for spell choosing)
    var int active;             //zBOOL       //unused??
    var int remove_all;         //zBOOL       //some internal stuff? --> Beim Schließen des MagBooks, wenn ein vorher gezogene Zauber weggesteckt wird auf 1, sonst auf 0 (ALLE (vorher gezogener einbegriffen) Spells wieder zurück "in die Hüfte")
    var int in_movement;        //zBOOL       //currently rotating the spells above the player head? --> und öffnen oder schließen
    var int show_handsymbol;    //zBOOL       //? --> PFX bzw. Spell in der Hand (vergleichbar mit gezogen oder nicht)
    var int step;               //zREAL       //if n spells are in the mag book this is 360/n 
    var int action;             //int         //internal --> 0 = keine Aktion, 1 = drehen, 2 = öffnen, 3 = schließen
    var int UNUSED;             //int         //
    var int open;               //zBOOL       //currently showing mag book (cirlce above player head)?
    var int open_delay_timer;   //zREAL       //used for delaying the time until the rune turns into a pfx --> 2000 msec
    var int show_particles;     //zBOOL       //currently rendering the spell above the player head as a pfx?
    var int targetdir;          //zREAL       //used for turning the spellbook over time when player pressed "left" or "right" --> um wieviel Grad drehen; Ist nach rechts wie die Eigenschaft step (also 360/n), aber nach links ((360/n)-1)*-1 (negativ und ein Grad weniger)
    var int t1;                 //zREAL       // - " -  --> "Keyframes": FLOATNULL = Die Eigenschaft action startet, FLOATEINS = Die Eigenschaft action endet
    var int targetpos[3];       //zVEC3       //used for popping out the magbook (from the hips) and closing it again. --> von Position
    var int startpos[3];        //zVEC3       // - " -  --> nach Position (auch beim Schließen, d.h. startpos und targetpos werden ausgetauscht)

    var int nextRegister;       //int         //not sure. Something with key assignment? --> Dieser Wert scheint sich nie zu ändern
    var int keys;               //int         //bitfield. If key n \in {0, 1, ..., 9} is used, keys & (1 << n) is true.  --> zeigt, ob ein Zauber im Slot (Taste) n+4 angelegt ist, hört also eigentlich bei n = 6 (Anzahl der Tasten für die Zauber) auf (nicht bei 9)
};

//--------------------------------------
// String
//--------------------------------------

/*
    Speicherlayout eines Strings.
    Gothic geht eigentlich ganz gut mit Strings um, man braucht diese Klasse nicht.
    Ich habe sie nur intern gebraucht um Speicher zu allozieren.
*/

class zString {
    var int _vtbl;
    var int _allocater; //immer 0
    var int ptr; //pointer zu den Daten
    var int len; //Länge des Strings
    var int res; //Anzahl allozierter Bytes
};

const int sizeof_zString = 20;

//--------------------------------------
// zCClassDef
//--------------------------------------

/* Für jede (von zCObject abgeleitete) Klasse gibt es
 * ein "Verwaltungsobjekt" vom Typ zCClassDef.
 * Dieses kapselt einige nützliche Informationen zu der
 * Gesamtheit der Objekte dieser Klasse.
 * Mit MEM_GetClassDef (var int objPtr) kann das
 * zu einem Objekt gehörige zCClassDef Objekt bestimmt
 * werden. Das heißt für ein übergebenes Vob, bekäme
 * man zCClassDef für die Klasse zCVob.
 */

class zCClassDef {
    var string className;            //zSTRING
    var string baseClassName;        //zSTRING
    var string scriptClassName;      //zSTRING
    var int baseClassDef;            //zCClassDef* //davon abgeleitet
    
    var int createNewInstance;       //zCObject* ( *) (void) //Pointer auf klassenspezifische Funktion
    var int createNewInstanceBackup; //zCObject* ( *) (void) //Pointer auf klassenspezifische Funktion
    
    /*
    enum zTClassFlags {
        zCLASS_FLAG_SHARED_OBJECTS      = 1<<0, //Mehrfach benutzt Objekte (wie Visuals zum Beispiel)
        zCLASS_FLAG_TRANSIENT           = 1<<1, //Flüchtig, soll nicht gespeichert werden.
        zCLASS_FLAG_RESOURCE            = 1<<2, //keine Ahnung / vermutlich irrelevant
    };*/
    
    var int classFlags;              //zDWORD //siehe enum
    var int classSize;               //zDWORD //Größe in Bytes
    
    var int numLivingObjects;        //Anzahl Objekte von dieser Klasse
    var int numCtorCalled;           //Konstruktor wurde sooft aufgerufen
    
    var int hashTable;               //zCObject** //Hashtabelle der Größe 1024. Objekte sind mit zCObject.hashNext verknüpft, falls mehrere auf den selben Wert hashen.
    //zCArray<zCObject*> objectList;    //alle benannten (!) Objekte von genau (!) dieser Klasse (!) //Ausrufezeichenanmerkungen: 1.) unbenannte sind nicht drin 2.) Objekte von Unterklassen sind nicht drin 3.) diese Eigenschaft kann sehr nützlich sein.
        var int objectList_array;       //zCObject**
        var int objectList_numAlloc;    //int
        var int objectList_numInArray;  //int
    
    var int archiveVersion;          //zWORD //vermutlich nutzlos
    var int archiveVersionSum;       //zWORD //vermutlich nutzlos
};      

//--------------------------------------
// oCLogTopic
//--------------------------------------

class oCLogTopic {
	var string   		m_strDescription;
	var int       		m_enuSection	; //LOG_MISSION / LOG_NOTE
	var int            	m_enuStatus		; //LOG_RUNNING / ...
	
    //zCList<zString> m_lstEntries;
        var int m_lstEntries_data; //zString*
        var int m_lstEntries_next; //zCList<zString>*
};

/* oCLogManager == zCList<oCLogTopic> */

class oCLogManager {
    var int data; //oCLogTopic*
    var int next; //zCList<oCLogTopic>*
};

const int oCLogManager_Ptr = 11191608; //0xAAC538

//--------------------------------------
// zERROR
//--------------------------------------

class zERROR {
    var int _vtbl;
    var int onexit;  //void (*__cdecl)()
    var string filter_authors;
    var int	filter_flag;
    var int filter_level;
    var int	target;
    var int	ack_type; //zERROR_TYPE
    var int log_file; //zFILE*
    var int indent_depth; //zBYTE
    var int spyHandle; //HWND
    var int spyMutex;  //zCMutex*
};