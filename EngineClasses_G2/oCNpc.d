//#################################################################
//
//  Nicos C_NPC
//
//#################################################################

////////////////////////////////////////////////////////////////////////////////
//                                                                            //
//                                  zCObject                                  //
//                                                                            //
////////////////////////////////////////////////////////////////////////////////

//NOTE: Bit field mask consts:     BitCount    FirstBit
const int zCObject_hashIndex = ((1 << 16) - 1) << 0;

class zCObject
{
  var int    _vtbl;       // 0x0000
  var int    refCtr;      // 0x0004 int
  var int    hashIndex;   // 0x0008 zWORD
  var int    hashNext;    // 0x000C zCObject*
  var string objectName;  // 0x0010 zSTRING
};                        // 0x0024

////////////////////////////////////////////////////////////////////////////////
//                                                                            //
//                                   zCVob                                    //
//                                                                            //
////////////////////////////////////////////////////////////////////////////////

const int zCVob_bitfield0_showVisual                = ((1 << 1) - 1) <<  0;
const int zCVob_bitfield0_drawBBox3D                = ((1 << 1) - 1) <<  1;
const int zCVob_bitfield0_visualAlphaEnabled        = ((1 << 1) - 1) <<  2;
const int zCVob_bitfield0_physicsEnabled            = ((1 << 1) - 1) <<  3;
const int zCVob_bitfield0_staticVob                 = ((1 << 1) - 1) <<  4;
const int zCVob_bitfield0_ignoredByTraceRay         = ((1 << 1) - 1) <<  5;
const int zCVob_bitfield0_collDetectionStatic       = ((1 << 1) - 1) <<  6;
const int zCVob_bitfield0_collDetectionDynamic      = ((1 << 1) - 1) <<  7;
const int zCVob_bitfield0_castDynShadow             = ((1 << 2) - 1) <<  8;
const int zCVob_bitfield0_lightColorStatDirty       = ((1 << 1) - 1) << 10;
const int zCVob_bitfield0_lightColorDynDirty        = ((1 << 1) - 1) << 11;
const int zCVob_bitfield1_isInMovementMode          = ((1 << 2) - 1) <<  0;
const int zCVob_bitfield2_sleepingMode              = ((1 << 2) - 1) <<  0;
const int zCVob_bitfield2_mbHintTrafoLocalConst     = ((1 << 1) - 1) <<  2;
const int zCVob_bitfield2_mbInsideEndMovementMethod = ((1 << 1) - 1) <<  3;
const int zCVob_bitfield3_visualCamAlign            = ((1 << 2) - 1) <<  0;
const int zCVob_bitfield4_collButNoMove             = ((1 << 4) - 1) <<  0;
const int zCVob_bitfield4_dontWriteIntoArchive      = ((1 << 1) - 1) <<  4;
const int zCVob_bitfield4_bIsInWater                = ((1 << 1) - 1) <<  5;
const int zCVob_bitfield4_bIsAmbientVob             = ((1 << 1) - 1) <<  6;

//Offsets der X, Y, Z Positionen im trafoObjToWorld Array:
const int zCVob_trafoObjToWorld_X =  3;
const int zCVob_trafoObjToWorld_Y =  7;
const int zCVob_trafoObjToWorld_Z = 11;

class zCVob
{
//zCObject {
  var int    _vtbl;
  var int    _zCObject_refCtr;
  var int    _zCObject_hashIndex;
  var int    _zCObject_hashNext;
  var string _zCObject_objectName;
//}
  var int    globalVobTreeNode;         // 0x0024 zCTree<zCVob>*
  var int    lastTimeDrawn;             // 0x0028 zTFrameCtr
  var int    lastTimeCollected;         // 0x002C zDWORD
//zCArray<zCBspLeaf*> {
  var int    vobLeafList_array;         // 0x0030 zCBspLeaf**
  var int    vobLeafList_numAlloc;      // 0x0034 int
  var int    vobLeafList_numInArray;    // 0x0038 int
//}
  var int    trafoObjToWorld[16];       // 0x003C zMATRIX4
//zTBBox3D {
  var int    bbox3D_mins[3];            // 0x007C zPOINT3
  var int    bbox3D_maxs[3];            // 0x0088 zPOINT3
//}
//zTBSphere3D {
  var int    bsphere3D_center[3];       // 0x0094 zPOINT3
  var int    bsphere3D_radius;          // 0x00A0 zVALUE
//}
//zCArray<zCVob*> {
  var int    touchVobList_array;        // 0x00A4 zCVob**
  var int    touchVobList_numAlloc;     // 0x00A8 int
  var int    touchVobList_numInArray;   // 0x00AC int
//}
  var int    type;                      // 0x00B0 zTVobType
  var int    groundShadowSizePacked;    // 0x00B4 zDWORD
  var int    homeWorld;                 // 0x00B8 zCWorld*
  var int    groundPoly;                // 0x00BC zCPolygon*
  var int    callback_ai;               // 0x00C0 zCAIBase*
  var int    trafo;                     // 0x00C4 zMATRIX4*
  var int    visual;                    // 0x00C8 zCVisual*
  var int    visualAlpha;               // 0x00CC zREAL
  var int    m_fVobFarClipZScale;       // 0x00D0 zREAL
  var int    m_AniMode;                 // 0x00D4 zTAnimationMode
  var int    m_aniModeStrength;         // 0x00D8 zREAL
  var int    m_zBias;                   // 0x00DC int
  var int    rigidBody;                 // 0x00E0 zCRigidBody*
  var int    lightColorStat;            // 0x00E4 zCOLOR
  var int    lightColorDyn;             // 0x00E8 zCOLOR
  var int    lightDirectionStat[3];     // 0x00EC zVEC3
  var int    vobPresetName;             // 0x00F8 zSTRING*
  var int    eventManager;              // 0x00FC zCEventManager*
  var int    nextOnTimer;               // 0x0100 zREAL
  var int    bitfield[5];               // 0x0104 zCVob_bitfieldX_Xxx
  var int    m_poCollisionObjectClass;  // 0x0118 zCCollisionObjectDef*
  var int    m_poCollisionObject;       // 0x011C zCCollisionObject*
};                                      // 0x0120

////////////////////////////////////////////////////////////////////////////////
//                                                                            //
//                                   oCNpc                                    //
//                                                                            //
////////////////////////////////////////////////////////////////////////////////

const int oCMagFrontier_bitfield_isWarning  = ((1 << 1) - 1) << 0;
const int oCMagFrontier_bitfield_isShooting = ((1 << 1) - 1) << 1;

const int oCNpc_bitfield0_showaidebug          = ((1 <<  1) - 1) <<  0;
const int oCNpc_bitfield0_showNews             = ((1 <<  1) - 1) <<  1;
const int oCNpc_bitfield0_csAllowedAsRole      = ((1 <<  1) - 1) <<  2;
const int oCNpc_bitfield0_isSummoned           = ((1 <<  1) - 1) <<  3;
const int oCNpc_bitfield0_respawnOn            = ((1 <<  1) - 1) <<  4;
const int oCNpc_bitfield0_movlock              = ((1 <<  1) - 1) <<  5;
const int oCNpc_bitfield0_drunk                = ((1 <<  1) - 1) <<  6;
const int oCNpc_bitfield0_mad                  = ((1 <<  1) - 1) <<  7;
const int oCNpc_bitfield0_overlay_wounded      = ((1 <<  1) - 1) <<  8;
const int oCNpc_bitfield0_inOnDamage           = ((1 <<  1) - 1) <<  9;
const int oCNpc_bitfield0_autoremoveweapon     = ((1 <<  1) - 1) << 10;
const int oCNpc_bitfield0_openinventory        = ((1 <<  1) - 1) << 11;
const int oCNpc_bitfield0_askroutine           = ((1 <<  1) - 1) << 12;
const int oCNpc_bitfield0_spawnInRange         = ((1 <<  1) - 1) << 13;
const int oCNpc_bitfield0_body_TexVarNr        = ((1 << 16) - 1) << 14;
const int oCNpc_bitfield1_body_TexColorNr      = ((1 << 16) - 1) <<  0;
const int oCNpc_bitfield1_head_TexVarNr        = ((1 << 16) - 1) << 16;
const int oCNpc_bitfield2_teeth_TexVarNr       = ((1 << 16) - 1) <<  0;
const int oCNpc_bitfield2_guildTrue            = ((1 <<  8) - 1) << 16;
const int oCNpc_bitfield2_drunk_heal           = ((1 <<  8) - 1) << 24;
const int oCNpc_bitfield3_mad_heal             = ((1 <<  8) - 1) <<  0;
const int oCNpc_bitfield3_spells               = ((1 <<  8) - 1) <<  8;
const int oCNpc_bitfield4_bodyState            = ((1 << 19) - 1) <<  0;
const int oCNpc_bitfield4_m_bAniMessageRunning = ((1 <<  1) - 1) << 19;

const int oCNpc_oTRobustTrace_bitfield_stand                = ((1 << 1) - 1) << 0;
const int oCNpc_oTRobustTrace_bitfield_dirChoosed           = ((1 << 1) - 1) << 1;
const int oCNpc_oTRobustTrace_bitfield_exactPosition        = ((1 << 1) - 1) << 2;
const int oCNpc_oTRobustTrace_bitfield_targetReached        = ((1 << 1) - 1) << 3;
const int oCNpc_oTRobustTrace_bitfield_standIfTargetReached = ((1 << 1) - 1) << 4;
const int oCNpc_oTRobustTrace_bitfield_waiting              = ((1 << 1) - 1) << 5;
const int oCNpc_oTRobustTrace_bitfield_isObstVobSmall       = ((1 << 1) - 1) << 6;
const int oCNpc_oTRobustTrace_bitfield_targetVisible        = ((1 << 1) - 1) << 7;
const int oCNpc_oTRobustTrace_bitfield_useChasmChecks       = ((1 << 1) - 1) << 8;

//Das alte Lese/Schreibsystem benötigt diese Offsets
const int MEM_NpcID_Offset   = 288; //0x120
const int MEM_NpcName_Offset = 292; //0x124

class oCNpc
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
  
//}
  var int    idx;                                                       // 0x0120 int
  var string name;                                                      // 0x0124 zSTRING[5]
  var string name_1;
  var string name_2;
  var string name_3;
  var string name_4;
  var string slot;                                                      // 0x0188 zSTRING
  var string effect;                                                    // 0x019C zSTRING
  var int    npcType;                                                   // 0x01B0 int
  var int    variousFlags;                                              // 0x01B4 int
  var int    attribute[8];                                              // 0x01B8 int[NPC_ATR_MAX]
  var int    hitChance[5];                                              // 0x01D8 int[NPC_HITCHANCE_MAX]
  var int    protection[8];                                             // 0x01EC int[oEDamageIndex_MAX]
  var int    damage[8];                                                 // 0x020C int[oEDamageIndex_MAX]
  var int    damagetype;                                                // 0x022C int
  var int    guild;                                                     // 0x0230 int
  var int    level;                                                     // 0x0234 int
  var func   mission[5];                                                // 0x0238 int[NPC_MIS_MAX]
  var int    fighttactic;                                               // 0x024C int
  var int    fmode;                                                     // 0x0250 int
  var int    voice;                                                     // 0x0254 int
  var int    voicePitch;                                                // 0x0258 int
  var int    mass;                                                      // 0x025C int
  var func   daily_routine;                                             // 0x0260 int
  var func   startAIState;                                              // 0x0264 int
  var string spawnPoint;                                                // 0x0268 zSTRING
  var int    spawnDelay;                                                // 0x027C int
  var int    senses;                                                    // 0x0280 int
  var int    senses_range;                                              // 0x0284 int
  var int    aiscriptvars[100];                                         // 0x0288 int[100]
  var string wpname;                                                    // 0x0418 zSTRING
  var int    experience_points;                                         // 0x042C zUINT32
  var int    experience_points_next_level;                              // 0x0430 zUINT32
  var int    learn_points;                                              // 0x0434 zUINT32
  var int    bodyStateInterruptableOverride;                            // 0x0438 int
  var int    noFocus;                                                   // 0x043C zBOOL
  var int    parserEnd;                                                 // 0x0440 int
  var int    bloodEnabled;                                              // 0x0444 int
  var int    bloodDistance;                                             // 0x0448 int
  var int    bloodAmount;                                               // 0x044C int
  var int    bloodFlow;                                                 // 0x0450 int
  var string bloodEmitter;                                              // 0x0454 zSTRING
  var string bloodTexture;                                              // 0x0468 zSTRING
  var int    didHit;                                                    // 0x047C zBOOL
  var int    didParade;                                                 // 0x0480 zBOOL
  var int    didShoot;                                                  // 0x0484 zBOOL
  var int    hasLockedEnemy;                                            // 0x0488 zBOOL
  var int    isDefending;                                               // 0x048C zBOOL
  var int    wasAiming;                                                 // 0x0490 zBOOL
  var int    lastAction;                                                // 0x0494 oCNpc::TFAction
  var int    enemy;                                                     // 0x0498 oCNpc*
  var int    speedTurn;                                                 // 0x049C zREAL
  var int    foundFleePoint;                                            // 0x04A0 zBOOL
  var int    reachedFleePoint;                                          // 0x04A4 zBOOL
  var int    vecFlee[3];                                                // 0x04A8 zVEC3
  var int    posFlee[3];                                                // 0x04B4 zVEC3
  var int    waypointFlee;                                              // 0x04C0 zCWaypoint*
//oTRobustTrace {
  var int    rbt_bitfield;                                              // 0x04C4 oCNpc_oTRobustTrace_bitfield_Xxx
  var int    rbt_targetPos[3];                                          // 0x04C8 zVEC3
  var int    rbt_targetVob;                                             // 0x04D4 zCVob*
  var int    rbt_obstVob;                                               // 0x04D8 zCVob*
  var int    rbt_targetDist;                                            // 0x04DC zREAL
  var int    rbt_lastTargetDist;                                        // 0x04E0 zREAL
  var int    rbt_maxTargetDist;                                         // 0x04E4 zREAL
  var int    rbt_dirTurn;                                               // 0x04E8 zREAL
  var int    rbt_timer;                                                 // 0x04EC zREAL
  var int    rbt_dirFirst[3];                                           // 0x04F0 zVEC3
  var int    rbt_dirLastAngle;                                          // 0x04FC zREAL
  //zCArray<oTDirectionInfo*> {
  var int    rbt_lastDirections_array;                                  // 0x0500 oTDirectionInfo**
  var int    rbt_lastDirections_numAlloc;                               // 0x0504 int
  var int    rbt_lastDirections_numInArray;                             // 0x0508 int
  //}
  var int    rbt_frameCtr;                                              // 0x050C int
  var int    rbt_targetPosArray[15];                                    // 0x0510 zVEC3[5]
  var int    rbt_targetPosCounter;                                      // 0x054C int
  var int    rbt_targetPosIndex;                                        // 0x0550 int
  var int    rbt_checkVisibilityTime;                                   // 0x0554 zREAL
  var int    rbt_positionUpdateTime;                                    // 0x0558 zREAL
  var int    rbt_failurePossibility;                                    // 0x055C zREAL
//}
//zCList<oCNpcTimedOverlay> {
  var int    timedOverlays_data;                                        // 0x0560 oCNpcTimedOverlay*
  var int    timedOverlays_next;                                        // 0x0564 zCList<oCNpcTimedOverlay>*
//}
//zCArray<oCNpcTalent*> {
  var int    talents_array;                                             // 0x0568 oCNpcTalent**
  var int    talents_numAlloc;                                          // 0x056C int
  var int    talents_numInArray;                                        // 0x0570 int
//}
  var int    spellMana;                                                 // 0x0574 int
//oCMagFrontier {
  var int    magFrontier_warningFX;                                     // 0x0578 oCVisualFX*
  var int    magFrontier_shootFX;                                       // 0x057C oCVisualFX*
  var int    magFrontier_npc;                                           // 0x0580 oCNpc*
  var int    magFrontier_bitfield;                                      // 0x0584 oCMagFrontier_bitfield_Xxx
//}
//oCNpc_States {
  var int    state_vtbl;                                                // 0x0588
  var string state_name;                                                // 0x058C zSTRING
  var int    state_npc;                                                 // 0x05A0 oCNpc*
  //TNpcAIState {
  var int    state_curState_index;                                      // 0x05A4 int
  var int    state_curState_loop;                                       // 0x05A8 int
  var int    state_curState_end;                                        // 0x05AC int
  var int    state_curState_timeBehaviour;                              // 0x05B0 int
  var int    state_curState_restTime;                                   // 0x05B4 zREAL
  var int    state_curState_phase;                                      // 0x05B8 int
  var int    state_curState_valid;                                      // 0x05BC zBOOL
  var string state_curState_name;                                       // 0x05C0 zSTRING
  var int    state_curState_stateTime;                                  // 0x05D4 zREAL
  var int    state_curState_prgIndex;                                   // 0x05D8 int
  var int    state_curState_isRtnState;                                 // 0x05DC zBOOL
  //}
  //TNpcAIState {
  var int    state_nextState_index;                                     // 0x05E0 int
  var int    state_nextState_loop;                                      // 0x05E4 int
  var int    state_nextState_end;                                       // 0x05E8 int
  var int    state_nextState_timeBehaviour;                             // 0x05EC int
  var int    state_nextState_restTime;                                  // 0x05F0 zREAL
  var int    state_nextState_phase;                                     // 0x05F4 int
  var int    state_nextState_valid;                                     // 0x05F8 zBOOL
  var string state_nextState_name;                                      // 0x05FC zSTRING
  var int    state_nextState_stateTime;                                 // 0x0610 zREAL
  var int    state_nextState_prgIndex;                                  // 0x0614 int
  var int    state_nextState_isRtnState;                                // 0x0618 zBOOL
  //}
  var int    state_lastAIState;                                         // 0x061C int
  var int    state_hasRoutine;                                          // 0x0620 zBOOL
  var int    state_rtnChanged;                                          // 0x0624 zBOOL
  var int    state_rtnBefore;                                           // 0x0628 oCRtnEntry*
  var int    state_rtnNow;                                              // 0x062C oCRtnEntry*
  var int    state_rtnRoute;                                            // 0x0630 zCRoute*
  var int    state_rtnOverlay;                                          // 0x0634 zBOOL
  var int    state_rtnOverlayCount;                                     // 0x0638 int
  var int    state_walkmode_routine;                                    // 0x063C int
  var int    state_weaponmode_routine;                                  // 0x0640 zBOOL
  var int    state_startNewRoutine;                                     // 0x0644 zBOOL
  var int    state_aiStateDriven;                                       // 0x0648 int
  var int    state_aiStatePosition[3];                                  // 0x064C zVEC3
  var int    state_parOther;                                            // 0x0658 oCNpc*
  var int    state_parVictim;                                           // 0x065C oCNpc*
  var int    state_parItem;                                             // 0x0660 oCItem*
  var int    state_rntChangeCount;                                      // 0x0664 int
//}
//oCNpcInventory {
  //oCItemContainer {
  var int    inventory2_vtbl;                                           // 0x0668
  var int    inventory2_oCItemContainer_contents;                       // 0x066C zCListSort<oCItem>*
  var int    inventory2_oCItemContainer_npc;                            // 0x0670 oCNpc*
  var string inventory2_oCItemContainer_titleText;                      // 0x0674 zSTRING
  var int    inventory2_oCItemContainer_invMode;                        // 0x0688 int
  var int    inventory2_oCItemContainer_selectedItem;                   // 0x068C int
  var int    inventory2_oCItemContainer_offset;                         // 0x0690 int
  var int    inventory2_oCItemContainer_maxSlotsCol;                    // 0x0694 int
  var int    inventory2_oCItemContainer_maxSlotsColScr;                 // 0x0698 int
  var int    inventory2_oCItemContainer_maxSlotsRow;                    // 0x069C int
  var int    inventory2_oCItemContainer_maxSlotsRowScr;                 // 0x06A0 int
  var int    inventory2_oCItemContainer_maxSlots;                       // 0x06A4 int
  var int    inventory2_oCItemContainer_marginTop;                      // 0x06A8 int
  var int    inventory2_oCItemContainer_marginLeft;                     // 0x06AC int
  var int    inventory2_oCItemContainer_frame;                          // 0x06B0 zBOOL
  var int    inventory2_oCItemContainer_right;                          // 0x06B4 zBOOL
  var int    inventory2_oCItemContainer_ownList;                        // 0x06B8 zBOOL
  var int    inventory2_oCItemContainer_prepared;                       // 0x06BC zBOOL
  var int    inventory2_oCItemContainer_passive;                        // 0x06C0 zBOOL
  var int    inventory2_oCItemContainer_TransferCount;                  // 0x06C4 zINT
  var int    inventory2_oCItemContainer_viewTitle;                      // 0x06C8 zCView*
  var int    inventory2_oCItemContainer_viewBack;                       // 0x06CC zCView*
  var int    inventory2_oCItemContainer_viewItem;                       // 0x06D0 zCView*
  var int    inventory2_oCItemContainer_viewItemActive;                 // 0x06D4 zCView*
  var int    inventory2_oCItemContainer_viewItemHightlighted;           // 0x06D8 zCView*
  var int    inventory2_oCItemContainer_viewItemActiveHighlighted;      // 0x06DC zCView*
  var int    inventory2_oCItemContainer_viewItemInfo;                   // 0x06E0 zCView*
  var int    inventory2_oCItemContainer_viewItemInfoItem;               // 0x06E4 zCView*
  var int    inventory2_oCItemContainer_textView;                       // 0x06E8 zCView*
  var int    inventory2_oCItemContainer_viewArrowAtTop;                 // 0x06EC zCView*
  var int    inventory2_oCItemContainer_viewArrowAtBottom;              // 0x06F0 zCView*
  var int    inventory2_oCItemContainer_rndWorld;                       // 0x06F4 zCWorld*
  var int    inventory2_oCItemContainer_posx;                           // 0x06F8 int
  var int    inventory2_oCItemContainer_posy;                           // 0x06FC int
  var int    inventory2_oCItemContainer_m_bManipulateItemsDisabled;     // 0x0700 zBOOL
  var int    inventory2_oCItemContainer_m_bCanTransferMoreThanOneItem;  // 0x0704 zBOOL
  //}
  var int    inventory2_owner;                                          // 0x0708 oCNpc*
  var int    inventory2_packAbility;                                    // 0x070C zBOOL
  //zCListSort<oCItem> {
  var int    inventory2_inventory_Compare;                              // 0x0710 int(_cdecl*)(oCItem*,oCItem*)
  var int    inventory2_inventory_data;                                 // 0x0714 oCItem*
  var int    inventory2_inventory_next;                                 // 0x0718 zCListSort<oCItem>*
  //}
  var string inventory2_packString;                                     // 0x071C zSTRING
  var int    inventory2_maxSlots;                                       // 0x0730 int
//}
  var int    trader;                                                    // 0x0734 oCItemContainer*
  var int    tradeNpc;                                                  // 0x0738 oCNpc*
  var int    rangeToPlayer;                                             // 0x073C zREAL
//zCArray<zTSoundHandle> {
  var int    listOfVoiceHandles_array;                                  // 0x0740 zTSoundHandle*
  var int    listOfVoiceHandles_numAlloc;                               // 0x0744 int
  var int    listOfVoiceHandles_numInArray;                             // 0x0748 int
//}
  var int    voiceIndex;                                                // 0x074C int
//zCArray<oCVisualFX*> {
  var int    effectList_array;                                          // 0x0750 oCVisualFX**
  var int    effectList_numAlloc;                                       // 0x0754 int
  var int    effectList_numInArray;                                     // 0x0758 int
//}
  var int    bitfield[5];                                               // 0x075C oCNpc_bitfieldX_Xxx
  var int    instanz;                                                   // 0x0770 int
  var string mds_name;                                                  // 0x0774 zSTRING
  var string body_visualName;                                           // 0x0788 zSTRING
  var string head_visualName;                                           // 0x079C zSTRING
  var int    model_scale[3];                                            // 0x07B0 VEC3
  var int    model_fatness;                                             // 0x07BC zREAL
  var int    namenr;                                                    // 0x07C0 int
  var int    hpHeal;                                                    // 0x07C4 zREAL
  var int    manaHeal;                                                  // 0x07C8 zREAL
  var int    swimtime;                                                  // 0x07CC zREAL
  var int    divetime;                                                  // 0x07D0 zREAL
  var int    divectr;                                                   // 0x07D4 zREAL
  var int    fireVob;                                                   // 0x07D8 zCVob*
  var int    fireDamage;                                                // 0x07DC int
  var int    fireDamageTimer;                                           // 0x07E0 zREAL
  var int    attitude;                                                  // 0x07E4 int
  var int    tmp_attitude;                                              // 0x07E8 int
  var int    attTimer;                                                  // 0x07EC zREAL
  var int    knowsPlayer;                                               // 0x07F0 int
  var int    percList[66];                                              // 0x07F4 TNpcPerc[NPC_PERC_MAX] { int percID; int percFunc }
  var int    percActive;                                                // 0x08FC int
  var int    percActiveTime;                                            // 0x0900 zREAL
  var int    percActiveDelta;                                           // 0x0904 zREAL
  var int    overrideFallDownHeight;                                    // 0x0908 zBOOL
  var int    fallDownHeight;                                            // 0x090C zREAL
  var int    fallDownDamage;                                            // 0x0910 int
  var int    mag_book;                                                  // 0x0914 oCMag_Book*
//zCList<oCSpell> {
  var int    activeSpells_data;                                         // 0x0918 oCSpell*
  var int    activeSpells_next;                                         // 0x091C int
//}
  var int    lastHitSpellID;                                            // 0x0920 int
  var int    lastHitSpellCat;                                           // 0x0924 int
//zCArray<zSTRING> {
  var int    activeOverlays_array;                                      // 0x0928 zSTRING*
  var int    activeOverlays_numAlloc;                                   // 0x092C int
  var int    activeOverlays_numInArray;                                 // 0x0930 int
//}
  var int    askbox;                                                    // 0x0934 oCAskBox*
  var int    askYes;                                                    // 0x0938 int
  var int    askNo;                                                     // 0x093C int
  var int    canTalk;                                                   // 0x0940 zREAL
  var int    talkOther;                                                 // 0x0944 oCNpc*
  var int    info;                                                      // 0x0948 oCInfo*
  var int    news;                                                      // 0x094C oCNews*
  var int    curMission;                                                // 0x0950 oCMission*
//oCNewsMemory {
  var int    knownNews_vtbl;                                            // 0x0954
  //zCList<oCNews> {
  var int    knownNews_iknow_data;                                      // 0x0958 oCNews*
  var int    knownNews_iknow_next;                                      // 0x095C zCList<oCNews>*
  //}
//}
  var int    carry_vob;                                                 // 0x0960 zCVob*
  var int    interactMob;                                               // 0x0964 oCMobInter*
  var int    interactItem;                                              // 0x0968 oCItem*
  var int    interactItemCurrentState;                                  // 0x096C int
  var int    interactItemTargetState;                                   // 0x0970 int
  var int    script_aiprio;                                             // 0x0974 int
  var int    old_script_state;                                          // 0x0978 int
  var int    human_ai;                                                  // 0x097C oCAIHuman*
  var int    anictrl;                                                   // 0x0980 oCAniCtrl_Human*
  var int    route;                                                     // 0x0984 zCRoute*
  var int    damageMul;                                                 // 0x0988 zREAL
  var int    csg;                                                       // 0x098C oCNpcMessage*
  var int    lastLookMsg;                                               // 0x0990 oCNpcMessage*
  var int    lastPointMsg;                                              // 0x0994 oCNpcMessage*
//zCArray<zCVob*> {
  var int    vobList_array;                                             // 0x0998 zCVob**
  var int    vobList_numAlloc;                                          // 0x099C int
  var int    vobList_numInArray;                                        // 0x09A0 int
//}
  var int    vobcheck_time;                                             // 0x09A4 zREAL
  var int    pickvobdelay;                                              // 0x09A8 zREAL
  var int    focus_vob;                                                 // 0x09AC zCVob*
//zCArray<TNpcSlot*> {
  var int    invSlot_array;                                             // 0x09B0 TNpcSlot**
  var int    invSlot_numAlloc;                                          // 0x09B4 int
  var int    invSlot_numInArray;                                        // 0x09B8 int
//}
//zCArray<TNpcSlot*> {
  var int    tmpSlotList_array;                                         // 0x09BC TNpcSlot**
  var int    tmpSlotList_numAlloc;                                      // 0x09C0 int
  var int    tmpSlotList_numInArray;                                    // 0x09C4 int
//}
  var int    fadeAwayTime;                                              // 0x09C8 zREAL
  var int    respawnTime;                                               // 0x09CC zREAL
  var int    selfDist;                                                  // 0x09D0 zREAL
  var int    fightRangeBase;                                            // 0x09D4 int
  var int    fightRangeFist;                                            // 0x09D8 int
  var int    fightRangeG;                                               // 0x09DC int
  var int    fight_waitTime;                                            // 0x09E0 zREAL
  var int    fight_waitForAniEnd;                                       // 0x09E4 zTModelAniID
  var int    fight_lastStrafeFrame;                                     // 0x09E8 zREAL
  var int    soundType;                                                 // 0x09EC int
  var int    soundVob;                                                  // 0x09F0 zCVob*
  var int    soundPosition[3];                                          // 0x09F4 zVEC3
  var int    playerGroup;                                               // 0x0A00 zCPlayerGroup*
};                                                                      // 0x0A04

//************************************************
//   Talente sehen so aus:
//************************************************

class oCNpcTalent {
	var int m_talent;  //int //welches Talent? selbe Konstanten wie in Constants.d (z.B: NPC_TALENT_1H)
	var int m_skill;   //int				
	var int m_value;   //int				
};
