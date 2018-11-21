//--------------------------------------
// Normales Mob
//--------------------------------------

const int oCMob_bitfield_hitp           = ((1 << 12) - 1) <<  0;
const int oCMob_bitfield_damage         = ((1 << 12) - 1) << 12;
const int oCMob_bitfield_isDestroyed    = ((1 <<  1) - 1) << 24;
const int oCMob_bitfield_moveable       = ((1 <<  1) - 1) << 25;
const int oCMob_bitfield_takeable       = ((1 <<  1) - 1) << 26;
const int oCMob_bitfield_focusOverride  = ((1 <<  1) - 1) << 27;
const int oCMob_bitfield_sndMat         = ((1 <<  3) - 1) << 28; //oTSndMaterial

class oCMob {
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
    
    //Mobeigenschaften:
    var string name;                //zSTRING Symbolischer Name, z.B. "MOBNAME_DOOR"
    
    var int bitfield;

    var string visualDestroyed;     //zSTRING
    
    var string ownerStr;            //zSTRING
    var string ownerGuildStr;       //zSTRING

    var int owner;                  //int
    var int ownerGuild;             //int
                                    
    var int focusNameIndex;         //int //Index des Parsersymbols, dass den Namen enthält, zum Beispiel Index des Symbols MOBNAME_DOOR.

    //zCList<zCVob>     ignoreVobList;
        var int ignoreVobList_data;     //zCVob*
        var int ignoreVobList_next;     //zCList<zCVob>*
};

//--------------------------------------
// Mobinter
//--------------------------------------

const int oCMobInter_bitfield_npcsMax       = ((1 << 8) -1) <<  0;
const int oCMobInter_bitfield_npcsNeeded    = ((1 << 8) -1) <<  8;
const int oCMobInter_bitfield_npcsCurrent   = ((1 << 8) -1) << 16;
const int oCMobInter_bitfield_tmpState      = ((1 << 8) -1) << 24;

class oCMobInter {
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
    
    //oCMob
      var string _oCMob_name;               
      var int    _oCMob_bitfield;
      var string _oCMob_visualDestroyed;    
      var string _oCMob_ownerStr;           
      var string _oCMob_ownerGuildStr;      
      var int    _oCMob_owner;              
      var int    _oCMob_ownerGuild;         
      var int    _oCMob_focusNameIndex;     
      var int    _oCMob_ignoreVobList_data; 
      var int    _oCMob_ignoreVobList_next; 
      
    //oCMobInter:
    
    
    //Optimale Positionen sind wohl die, zu denen der Held bei der Benutzung hinploppt. Ich bin aber kein Animierer, hab wenig Ahnung davon.
    //zCList<TMobOptPos>    optimalPosList; // List of all Optimal Positions
      var int optimalPosList_data;      //TMobOptPos*
      var int optimalPosList_next;      //zCList<TMobOptPos>*
    
    //wohlbekannte Eigenschaften:
    var string triggerTarget;               //zSTRING
    var string useWithItem;                 //zSTRING
    var string sceme;                       //zSTRING
    var string conditionFunc;               //zSTRING
    var string onStateFuncName;             //zSTRING
    
    //Zustand des Mobs
    var int state;                          //int
    var int state_num;                      //int
    var int state_target;                   //int Zustand auf den gerade "hingearbeitet wird" ?
    
    var int rewind;                         //zBOOL

    var int mobStateAni;                    //int / zTModelAniID
    var int npcStateAni;                    //int / zTModelAniID
    
    var int bitfield; //siehe oben
    var int tmpStateChanged;                //zBOOL
    
    var int Direction;                      //TMobInterDirection "Richtung in die das Mob benutzt wird????", (0 = none, 1 = up, 2 = down)
    
    var int onInterruptReturnToSlotPos;     //zBOOL
    
    var int startPos[3];                    //zVEC3
    var int aniCombHeight;                  //zREAL
    var int inUseVob;                       //zCVob*
    var int timerEnd;                       //zREAL
};

//--------------------------------------
// Lockable
//--------------------------------------

const int oCMobLockable_bitfield_locked     = ((1 <<  1) - 1) << 0;
const int oCMobLockable_bitfield_autoOpen   = ((1 <<  1) - 1) << 1;
const int oCMobLockable_bitfield_pickLockNr = ((1 << 30) - 1) << 2;

class oCMobLockable
{
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
    
    //oCMob
      var string _oCMob_name;               
      var int    _oCMob_bitfield;
      var string _oCMob_visualDestroyed;    
      var string _oCMob_ownerStr;           
      var string _oCMob_ownerGuildStr;      
      var int    _oCMob_owner;              
      var int    _oCMob_ownerGuild;         
      var int    _oCMob_focusNameIndex;     
      var int    _oCMob_ignoreVobList_data; 
      var int    _oCMob_ignoreVobList_next; 
      
    //oCMobInter:
      var int _oCMobInter_optimalPosList_data;
      var int _oCMobInter_optimalPosList_next;
      var string _oCMobInter_triggerTarget; 
      var string _oCMobInter_useWithItem;       
      var string _oCMobInter_sceme;         
      var string _oCMobInter_conditionFunc; 
      var string _oCMobInter_onStateFuncName;   
      var int _oCMobInter_state;                
      var int _oCMobInter_state_num;            
      var int _oCMobInter_state_target;     
      var int _oCMobInter_rewind;               
      var int _oCMobInter_mobStateAni;      
      var int _oCMobInter_npcStateAni;      
      var int _oCMobInter_bitfield;
      var int _oCMobInter_tmpStateChanged;
      var int _oCMobInter_Direction;        
      var int _oCMobInter_onInterruptReturnToSlotPos;   
      var int _oCMobInter_startPos[3];              
      var int _oCMobInter_aniCombHeight;                
      var int _oCMobInter_inUseVob;                 
      var int _oCMobInter_timerEnd;                 
    
    //oCMobLockable  
    
    var int bitfield;
    
    var string keyInstance;     // zSTRING //Schlüsselinstanzname
    var string pickLockStr;     // zSTRING //linksrechtscombo
};

//--------------------------------------
// Door
//--------------------------------------

class oCMobDoor
{
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
    
    //oCMob
      var string _oCMob_name;               
      var int    _oCMob_bitfield;
      var string _oCMob_visualDestroyed;    
      var string _oCMob_ownerStr;           
      var string _oCMob_ownerGuildStr;      
      var int _oCMob_owner;              
      var int _oCMob_ownerGuild;         
      var int _oCMob_focusNameIndex;     
      var int _oCMob_ignoreVobList_data;    
      var int _oCMob_ignoreVobList_next;    
      
    //oCMobInter:
      var int _oCMobInter_optimalPosList_data;
      var int _oCMobInter_optimalPosList_next;
      var string _oCMobInter_triggerTarget; 
      var string _oCMobInter_useWithItem;       
      var string _oCMobInter_sceme;         
      var string _oCMobInter_conditionFunc; 
      var string _oCMobInter_onStateFuncName;   
      var int _oCMobInter_state;                
      var int _oCMobInter_state_num;            
      var int _oCMobInter_state_target;     
      var int _oCMobInter_rewind;               
      var int _oCMobInter_mobStateAni;      
      var int _oCMobInter_npcStateAni;      
      var int _oCMobInter_bitfield;
      var int _oCMobInter_tmpStateChanged;
      var int _oCMobInter_Direction;        
      var int _oCMobInter_onInterruptReturnToSlotPos;   
      var int _oCMobInter_startPos[3];              
      var int _oCMobInter_aniCombHeight;                
      var int _oCMobInter_inUseVob;                 
      var int _oCMobInter_timerEnd;                 
    
    //oCMobLockable  
      var int _oCMobLockable_bitfield;
      var string _oCMobLockable_keyInstance;
      var string _oCMobLockable_pickLockStr;
    
    //oCMobDoor
    var string addName;         // zSTRING // FRONT / BACK
};

//--------------------------------------
// Container
//--------------------------------------

class oCMobContainer
{
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
    
    //oCMob
      var string _oCMob_name;               
      var int    _oCMob_bitfield;
      var string _oCMob_visualDestroyed;    
      var string _oCMob_ownerStr;           
      var string _oCMob_ownerGuildStr;      
      var int    _oCMob_owner;              
      var int    _oCMob_ownerGuild;         
      var int    _oCMob_focusNameIndex;     
      var int    _oCMob_ignoreVobList_data; 
      var int    _oCMob_ignoreVobList_next; 
      
    //oCMobInter:
      var int _oCMobInter_optimalPosList_data;
      var int _oCMobInter_optimalPosList_next;
      var string _oCMobInter_triggerTarget; 
      var string _oCMobInter_useWithItem;       
      var string _oCMobInter_sceme;         
      var string _oCMobInter_conditionFunc; 
      var string _oCMobInter_onStateFuncName;   
      var int _oCMobInter_state;                
      var int _oCMobInter_state_num;            
      var int _oCMobInter_state_target;     
      var int _oCMobInter_rewind;               
      var int _oCMobInter_mobStateAni;      
      var int _oCMobInter_npcStateAni;      
      var int _oCMobInter_bitfield;
      var int _oCMobInter_tmpStateChanged;
      var int _oCMobInter_Direction;        
      var int _oCMobInter_onInterruptReturnToSlotPos;   
      var int _oCMobInter_startPos[3];              
      var int _oCMobInter_aniCombHeight;                
      var int _oCMobInter_inUseVob;                 
      var int _oCMobInter_timerEnd;                 
    
    //oCMobLockable  
      var int _oCMobLockable_bitfield;
      var string _oCMobLockable_keyInstance;
      var string _oCMobLockable_pickLockStr;
    
    //oCMobContainer
    var string contains;                //zSTRING //Scriptinstanzen der Items. Nicht aktuelle gehalten! Original Spacereinstellung!
    
    var int items;                      //oCItemContainer*
    //zCListSort<oCItem>    containList; //sollte die richtigen Daten beinhalten
      var int containList_compareFunc;          //int (*Compare)(oCItem *ele1,oCItem *ele2);
      var int containList_data;                 //oCItem*           
      var int containList_next;                 //zCListSort<oCItem>*
};

class oCMobFire {
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
    
    //oCMob
      var string _oCMob_name;               
      var int    _oCMob_bitfield;
      var string _oCMob_visualDestroyed;    
      var string _oCMob_ownerStr;           
      var string _oCMob_ownerGuildStr;      
      var int    _oCMob_owner;              
      var int    _oCMob_ownerGuild;         
      var int    _oCMob_focusNameIndex;     
      var int    _oCMob_ignoreVobList_data; 
      var int    _oCMob_ignoreVobList_next; 
      
    //oCMobInter:
      var int _oCMobInter_optimalPosList_data;
      var int _oCMobInter_optimalPosList_next;
      var string _oCMobInter_triggerTarget; 
      var string _oCMobInter_useWithItem;       
      var string _oCMobInter_sceme;         
      var string _oCMobInter_conditionFunc; 
      var string _oCMobInter_onStateFuncName;   
      var int _oCMobInter_state;                
      var int _oCMobInter_state_num;            
      var int _oCMobInter_state_target;     
      var int _oCMobInter_rewind;               
      var int _oCMobInter_mobStateAni;      
      var int _oCMobInter_npcStateAni;      
      var int _oCMobInter_bitfield;
      var int _oCMobInter_tmpStateChanged;
      var int _oCMobInter_Direction;        
      var int _oCMobInter_onInterruptReturnToSlotPos;   
      var int _oCMobInter_startPos[3];              
      var int _oCMobInter_aniCombHeight;                
      var int _oCMobInter_inUseVob;                 
      var int _oCMobInter_timerEnd;
	
	//oCMobFire
	var string fireSlot;		//zSTRING: z.B: "BIP01 FIRE"
	var string fireVobtreeName; //zSTRING: z.B. "FIRETREE_MEDIUM.ZEN"
	
	var int fireVobtree;		//zCVob*
};