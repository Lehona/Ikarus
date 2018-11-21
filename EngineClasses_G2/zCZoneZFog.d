/*
//zCZone / zCZoneMusic sind relativ uninteressante Klassen.

class zCZone / zCZoneMusic { //beide Klassen vom Speicherbild identisch
    //[zVob Stuff....]
    zCWorld             *world; //einzige neue Eigenschaft
};
*/

class zCZoneZFog {  
//class zCZoneZFogDefault { //beide Klassen vom Speicherbild identisch
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
    
    //zCZoneZFog, Eigenschaften aus dem Spacer bekanntrrun scripts
    
    var int fogRangeCenter;  //zREAL     
    var int innerRangePerc;  //zREAL     
    var int fogColor;        //zCOLOR   
    var int bFadeOutSky;     //zBOOL     
    var int bOverrideColor;  //zBOOL     
};