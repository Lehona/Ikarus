/* address of the pointer that points to the current MusicZone.
   poorly tested, was null most of the time, don't know why. */
const int oCZoneMusic__s_musiczone_Address = 10111524; //0x9A4A24 //oCZoneMusic*

class oCZoneMusic {  
//class oCZoneMusicDefault { //beide Klassen vom Speicherbild identisch
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
    //zCZone
        var int     _zCZone_world;      //zCWorld*
    
    //oCZoneMusic
	var int enabled;			//zBOOL
	var int local_enabled;		//zBOOL
	var int priority;			//int
	var int ellipsoid;			//zBOOL
	var int reverbLevel;		//float
	var int volumeLevel;		//float
	var int loop;				//zBOOL
	var int dayEntranceDone;    //zBOOL
	var int nightEntranceDone;  //zBOOL
};
