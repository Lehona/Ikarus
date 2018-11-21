class zCVobWaypoint {
    //Ein ganz gewöhnliches Vob (wird als Hilfsvob verwendet)
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
};

class zCWaypoint {
    //zCObject {
        var int    _vtbl;
        var int    _zCObject_refCtr;
        var int    _zCObject_hashIndex;
        var int    _zCObject_hashNext;
        var string _zCObject_objectName;
    //}
    
    // Kürzeste Weg Suche durch das zCWaynet
    // Diese Eigenschaften besser nicht nutzen,
    // es sind A* (Zwischen-) Ergebnisse.
    var int routeCtr;                       //int                 
    var int curCost;                        //int                 
    var int estCost;                        //int                 
    var int score;                          //int                 
    var int curList;                        //int                 
    var int parent;                         //zCWay*            
    
    //Sonstige Daten
    var int waterDepth;                     //int          
    var int underWater;                     //zBOOL 
      
    var int pos[3];                         //zVEC3   // Position dieses Waypoints
    var int dir[3];                         //zVEC3   // AtVector
    var string name;                        //zSTRING   

    // dazugehöriger Vob in dér Welt
    var int wpvob;                          //zCVobWaypoint*
    
    // Liste der hier beginnenden Wege ( Ways )
    //zCList <zCWay>    wayList;
        var int wayList_data;               //zCWay*
        var int wayList_next;               //zCList<zCWay>*
};

class oCWay { //Unterklasse von zCWay.
    var int _vtbl;                  //Zeiger auf Methodentabelle

    // Kürzeste Weg Suche durch das zCWaynet
    // Diese Eigenschaften besser nicht nutzen,
    // es sind A* (Zwischen-) Ergebnisse.
    var int cost;                   //int
    var int usedCtr;                //int

    //Sonstige Eigenschaften
    var int chasmDepth;             //zREAL
    var int chasm;                  //zBOOL
    var int jump;                   //zBOOL

    //die beiden anschließenden Wegpunkte
    var int left;                   //zCWaypoint*
    var int right;                  //zCWaypoint*
    
    //Objekte im Weg?
    var int ladder;                 //oCMobLadder*
    var int door;                   //oCMobDoor*     
};

class zCWayNet {
    //zCObject {
        var int    _vtbl;
        var int    _zCObject_refCtr;
        var int    _zCObject_hashIndex;
        var int    _zCObject_hashNext;
        var string _zCObject_objectName;
    //}
    
    var int world;                          //zCWorld*

    //zCListSort    <zCWaypoint>        wplist;     // Alle Waypoints   im Netz
        var int wplist_compareFunc;         //int (*Compare)(zCWaypoint *ele1,zCWaypoint *ele2);
        var int wplist_data;                //zCWaypoint*
        var int wplist_next;                //zCListSort<zCWaypoint>*
        
    //zCList        <zCWay>     waylist;    // Alle Ways        im Netz
        var int waylist_data;               //zCWay*
        var int waylist_next;               //zCList<zCWay>*

    //enum      { WAY_LIST_NONE, WAY_LIST_OPEN, WAY_LIST_CLOSED };
    
    //zCListSort    <zCWaypoint>        openList;
        var int openList_compareFunc;       //int (*Compare)(zCWaypoint *ele1,zCWaypoint *ele2);
        var int openList_data;              //zCWaypoint*
        var int openList_next;              //zCListSort<zCWaypoint>*
        
    var int routeCtr;                       //int
};

class zCRoute {
	//var int wayList;   //zCList <zCWay>	
        var int wayList_data; //zCWay*
        var int wayList_next; //zCList<zCWay>*
    
	var int startwp;   //zCWaypoint*		
	var int target;    //zCWaypoint*		
	var int way;       //zCWay*			
	var int waynode;   //zCList <zCWay>* 
};



