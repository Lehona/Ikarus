const int zCTrigger_bitfield_reactToOnTrigger  = ((1 << 1) - 1) << 0;
const int zCTrigger_bitfield_reactToOnTouch    = ((1 << 1) - 1) << 1;
const int zCTrigger_bitfield_reactToOnDamage   = ((1 << 1) - 1) << 2;
const int zCTrigger_bitfield_respondToObject   = ((1 << 1) - 1) << 3;
const int zCTrigger_bitfield_respondToPC       = ((1 << 1) - 1) << 4;
const int zCTrigger_bitfield_respondToNPC      = ((1 << 1) - 1) << 5;
    
const int zCTrigger_bitfield_startEnabled      = ((1 << 1) - 1) << (8 + 0);
const int zCTrigger_bitfield_isEnabled         = ((1 << 1) - 1) << (8 + 1);
const int zCTrigger_bitfield_sendUntrigger     = ((1 << 1) - 1) << (8 + 2);

class zCTrigger {
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
    
    //zCTriggerBase
    //Eigenschaften sollten weitgehend klar sein
    var string triggerTarget;       //zSTRING
    
    var int bitfield; //siehe oben
    /*
    struct {
        zUINT8          reactToOnTrigger: 1;
        zUINT8          reactToOnTouch  : 1;
        zUINT8          reactToOnDamage : 1;
        zUINT8          respondToObject : 1;
        zUINT8          respondToPC     : 1;
        zUINT8          respondToNPC    : 1;
    } filterFlags;
    struct {
        zUINT8          startEnabled    : 1;    
        zUINT8          isEnabled       : 1;
        zUINT8          sendUntrigger   : 1;    
    } flags; */
    
    var string respondToVobName; //zSTRING
    var int numCanBeActivated;   //zSWORD
    var int retriggerWaitSec;    //zREAL
    var int damageThreshold;     //zREAL
    var int fireDelaySec;        //zREAL
    var int nextTimeTriggerable; //zREAL  //vgl. Eigenschaft retriggerWaitSec
    var int savedOtherVob;       //zCVob*
    var int countCanBeActivated; //zSWORD
};

class oCTriggerScript {
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
    
    var string _zCTrigger_triggerTarget;        //zSTRING
    var int    _zCTrigger_bitfield;             //siehe oben
    var string _zCTrigger_respondToVobName;     //zSTRING
    var int    _zCTrigger_numCanBeActivated;    //zSWORD
    var int    _zCTrigger_retriggerWaitSec;     //zREAL
    var int    _zCTrigger_damageThreshold;      //zREAL
    var int    _zCTrigger_fireDelaySec;         //zREAL
    var int    _zCTrigger_nextTimeTriggerable;  //zREAL
    var int    _zCTrigger_savedOtherVob;        //zCVob*
    var int    _zCTrigger_countCanBeActivated;  //zSWORD
    
    var string scriptFunc;                      //zSTRING
};

class oCTriggerChangeLevel {
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
    
    var string _zCTrigger_triggerTarget;
    var int    _zCTrigger_bitfield;
    var string _zCTrigger_respondToVobName; 
    var int    _zCTrigger_numCanBeActivated;
    var int    _zCTrigger_retriggerWaitSec; 
    var int    _zCTrigger_damageThreshold;  
    var int    _zCTrigger_fireDelaySec;     
    var int    _zCTrigger_nextTimeTriggerable;
    var int    _zCTrigger_savedOtherVob;      
    var int    _zCTrigger_countCanBeActivated;
    
    var string levelName;  //zSTRING
    var string startVob;   //zSTRING
};

const int zCMover_bitfield_moverLocked     = ((1 << 1) - 1) <<  0;
const int zCMover_bitfield_autoLinkEnabled = ((1 << 1) - 1) <<  8;
const int zCMover_bitfield_autoRotate      = ((1 << 1) - 1) << 16;
const int sizeof_zCMover = 624;

class zTMov_Keyframe {
	var int pos[3];			//zPOINT3
	var int quat[4];		//zCQuat
};

const int sizeof_zTMov_KeyFrame = 28;
	
class zCMover {
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
    
    var string _zCTrigger_triggerTarget;
    var int    _zCTrigger_bitfield;
    var string _zCTrigger_respondToVobName; 
    var int    _zCTrigger_numCanBeActivated;
    var int    _zCTrigger_retriggerWaitSec; 
    var int    _zCTrigger_damageThreshold;  
    var int    _zCTrigger_fireDelaySec;     
    var int    _zCTrigger_nextTimeTriggerable;
    var int    _zCTrigger_savedOtherVob;      
    var int    _zCTrigger_countCanBeActivated;
    
    /*
    Keyframes
    struct zTMov_Keyframe {
        zPOINT3     pos;
        zCQuat      quat;
    };
    */
    
    //zCArray<zTMov_Keyframe>   keyframeList;
        var int keyframeList_array;         //zTMov_Keyframe*
        var int keyframeList_numAlloc;      //int
        var int keyframeList_numInArray;    //int
    
    // internals
    var int actKeyPosDelta[3];              //zVEC3
    var int actKeyframeF;                   //zREAL
    var int actKeyframe;                    //int    
    var int nextKeyframe;                   //int    
    var int moveSpeedUnit;                  //zREAL
    var int advanceDir;                     //zREAL
    
    /*
    enum zTMoverState       { MOVER_STATE_OPEN, 
                              MOVER_STATE_OPENING, 
                              MOVER_STATE_CLOSED, 
                              MOVER_STATE_CLOSING
                            }*/
    var int moverState;                     //zTMoverState
    
    var int numTriggerEvents;               //int    
    var int stayOpenTimeDest;               //zREAL
    
    var int model;                          //zCModel*
    var int soundMovingHandle;              //zTSoundHandle
    var int sfxMoving;                      //zCSoundFX*

    var int moveSpeed;                          //zREAL 
    var int stayOpenTimeSec;                    //zREAL 
    var int touchBlockerDamage;                 //zREAL 
    
    var int bitfield;
    
    /*
    enum zTMoverAniType     { MA_KEYFRAME,
                              MA_MODEL_ANI, 
                              MA_WAYPOINT 
                            }; */
    var int moverAniType;                       //zTMoverAniType

    /*
    enum zTMoverBehavior    { MB_2STATE_TOGGLE,             
                              MB_2STATE_TRIGGER_CONTROL,    
                              MB_2STATE_OPEN_TIMED,         
                              MB_NSTATE_LOOP,
                              MB_NSTATE_SINGLE_KEYS
                            }*/
    var int moverBehavior;                      //zTMoverBehavior

    /*enum zTTouchBehavior  { TB_TOGGLE,
                              TB_WAIT
                            }*/
    var int touchBehavior;                      //zTTouchBehavior

    // aniType: Keyframe
    /* enum zTPosLerpType       {   PL_LINEAR, 
                                    PL_CURVE 
                            } */
    var int posLerpType;                        //zTPosLerpType
    
    /* enum zTSpeedType     { ST_CONST , 
                              ST_SLOW_START_END     , ST_SLOW_START     , ST_SLOW_END,
                              ST_SEG_SLOW_START_END , ST_SEG_SLOW_START , ST_SEG_SLOW_END 
                            } */
    var int speedType;                          //zTSpeedType

    // sound                                    
    var string soundOpenStart;                  //zSTRING
    var string soundOpenEnd;                    //zSTRING
    var string soundMoving;                     //zSTRING
    var string soundCloseStart;                 //zSTRING
    var string soundCloseEnd;                   //zSTRING
    var string soundLock;                       //zSTRING
    var string soundUnlock;                     //zSTRING
    var string soundUseLocked;                  //zSTRING
};