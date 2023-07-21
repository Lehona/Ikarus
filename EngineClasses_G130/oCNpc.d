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
};
const int sizeof_zCVob = 288;           // 0x0120

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
  var int    npcType;                                                   // 0x019C int
  var int    variousFlags;                                              // 0x01A0 int
  var int    attribute[8];                                              // 0x01A4 int[NPC_ATR_MAX]
  var int    hitChance[5];                                              // 0x01C4 int[NPC_HITCHANCE_MAX]
  var int    protection[8];                                             // 0x01D8 int[oEDamageIndex_MAX]
  var int    damage[8];                                                 // 0x01F8 int[oEDamageIndex_MAX]
  var int    damagetype;                                                // 0x0218 int
  var int    guild;                                                     // 0x021C int
  var int    level;                                                     // 0x0220 int
  var func   mission[5];                                                // 0x0224 int[NPC_MIS_MAX]
  var int    fighttactic;                                               // 0x0238 int
  var int    fmode;                                                     // 0x023C int
  var int    voice;                                                     // 0x0240 int
  var int    voicePitch;                                                // 0x0244 int
  var int    mass;                                                      // 0x0248 int
  var func   daily_routine;                                             // 0x024C int
  var func   startAIState;                                              // 0x0250 int
  var string spawnPoint;                                                // 0x0254 zSTRING
  var int    spawnDelay;                                                // 0x0268 int
  var int    senses;                                                    // 0x026C int
  var int    senses_range;                                              // 0x0270 int
  var int    aiscriptvars[70];                                          // 0x0274 int[70]
  var string wpname;                                                    // 0x038C zSTRING
  var int    experience_points;                                         // 0x03A0 zUINT32
  var int    experience_points_next_level;                              // 0x03A4 zUINT32
  var int    learn_points;                                              // 0x03A8 zUINT32
  var int    bodyStateInterruptableOverride;                            // 0x03AC int
  var int    noFocus;                                                   // 0x03B0 zBOOL
  var int    parserEnd;                                                 // 0x03B4 int
  var int    bloodEnabled;                                              // 0x03B8 int
  var int    bloodDistance;                                             // 0x03BC int
  var int    bloodAmount;                                               // 0x03C0 int
  var int    bloodFlow;                                                 // 0x03C4 int
  var string bloodEmitter;                                              // 0x03C8 zSTRING
  var string bloodTexture;                                              // 0x03DC zSTRING
  var int    didHit;                                                    // 0x03F0 zBOOL
  var int    didParade;                                                 // 0x03F4 zBOOL
  var int    didShoot;                                                  // 0x03F8 zBOOL
  var int    hasLockedEnemy;                                            // 0x03FC zBOOL
  var int    isDefending;                                               // 0x0400 zBOOL
  var int    wasAiming;                                                 // 0x0404 zBOOL
  var int    lastAction;                                                // 0x0408 oCNpc::TFAction
  var int    enemy;                                                     // 0x040C oCNpc*
  var int    speedTurn;                                                 // 0x0410 zREAL
  var int    foundFleePoint;                                            // 0x0414 zBOOL
  var int    reachedFleePoint;                                          // 0x0418 zBOOL
  var int    vecFlee[3];                                                // 0x041C zVEC3
  var int    posFlee[3];                                                // 0x0428 zVEC3
  var int    waypointFlee;                                              // 0x0434 zCWaypoint*
//oTRobustTrace {
  var int    rbt_bitfield;                                              // 0x0438 oCNpc_oTRobustTrace_bitfield_Xxx
  var int    rbt_targetPos[3];                                          // 0x043C zVEC3
  var int    rbt_targetVob;                                             // 0x0448 zCVob*
  var int    rbt_obstVob;                                               // 0x044C zCVob*
  var int    rbt_targetDist;                                            // 0x0450 zREAL
  var int    rbt_lastTargetDist;                                        // 0x0454 zREAL
  var int    rbt_maxTargetDist;                                         // 0x0458 zREAL
  var int    rbt_dirTurn;                                               // 0x045C zREAL
  var int    rbt_timer;                                                 // 0x0460 zREAL
  var int    rbt_dirFirst[3];                                           // 0x0464 zVEC3
  var int    rbt_dirLastAngle;                                          // 0x0470 zREAL
  //zCArray<oTDirectionInfo*> {
  var int    rbt_lastDirections_array;                                  // 0x0474 oTDirectionInfo**
  var int    rbt_lastDirections_numAlloc;                               // 0x0478 int
  var int    rbt_lastDirections_numInArray;                             // 0x047C int
  //}
  var int    rbt_frameCtr;                                              // 0x0480 int
  var int    rbt_targetPosArray[15];                                    // 0x0484 zVEC3[5]
  var int    rbt_targetPosCounter;                                      // 0x04C0 int
  var int    rbt_targetPosIndex;                                        // 0x04C4 int
  var int    rbt_checkVisibilityTime;                                   // 0x04C8 zREAL
  var int    rbt_positionUpdateTime;                                    // 0x04CC zREAL
  var int    rbt_failurePossibility;                                    // 0x04D0 zREAL
//}
//zCList<oCNpcTimedOverlay> {
  var int    timedOverlays_data;                                        // 0x04D4 oCNpcTimedOverlay*
  var int    timedOverlays_next;                                        // 0x04D8 zCList<oCNpcTimedOverlay>*
//}
//zCArray<oCNpcTalent*> {
  var int    talents_array;                                             // 0x04DC oCNpcTalent**
  var int    talents_numAlloc;                                          // 0x04E0 int
  var int    talents_numInArray;                                        // 0x04E4 int
//}
  var int    spellMana;                                                 // 0x04E8 int
//oCMagFrontier {
  var int    magFrontier_warningFX;                                     // 0x04EC oCVisualFX*
  var int    magFrontier_shootFX;                                       // 0x04F0 oCVisualFX*
  var int    magFrontier_npc;                                           // 0x04F4 oCNpc*
  var int    magFrontier_bitfield;                                      // 0x04F8 oCMagFrontier_bitfield_Xxx
//}
//oCNpc_States {
  var int    state_vtbl;                                                // 0x04FC
  var string state_name;                                                // 0x0500 zSTRING
  var int    state_npc;                                                 // 0x0514 oCNpc*
  //TNpcAIState {
  var int    state_curState_index;                                      // 0x0518 int
  var int    state_curState_loop;                                       // 0x051C int
  var int    state_curState_end;                                        // 0x0520 int
  var int    state_curState_timeBehaviour;                              // 0x0524 int
  var int    state_curState_restTime;                                   // 0x0528 zREAL
  var int    state_curState_phase;                                      // 0x052C int
  var int    state_curState_valid;                                      // 0x0530 zBOOL
  var string state_curState_name;                                       // 0x0534 zSTRING
  var int    state_curState_stateTime;                                  // 0x0548 zREAL
  var int    state_curState_prgIndex;                                   // 0x054C int
  var int    state_curState_isRtnState;                                 // 0x0550 zBOOL
  //}
  //TNpcAIState {
  var int    state_nextState_index;                                     // 0x0554 int
  var int    state_nextState_loop;                                      // 0x0558 int
  var int    state_nextState_end;                                       // 0x055C int
  var int    state_nextState_timeBehaviour;                             // 0x0560 int
  var int    state_nextState_restTime;                                  // 0x0564 zREAL
  var int    state_nextState_phase;                                     // 0x0568 int
  var int    state_nextState_valid;                                     // 0x056C zBOOL
  var string state_nextState_name;                                      // 0x0570 zSTRING
  var int    state_nextState_stateTime;                                 // 0x0584 zREAL
  var int    state_nextState_prgIndex;                                  // 0x0588 int
  var int    state_nextState_isRtnState;                                // 0x058C zBOOL
  //}
  var int    state_lastAIState;                                         // 0x0590 int
  var int    state_hasRoutine;                                          // 0x0594 zBOOL
  var int    state_rtnChanged;                                          // 0x0598 zBOOL
  var int    state_rtnBefore;                                           // 0x059C oCRtnEntry*
  var int    state_rtnNow;                                              // 0x05A0 oCRtnEntry*
  var int    state_rtnRoute;                                            // 0x05A4 zCRoute*
  var int    state_rtnOverlay;                                          // 0x05A8 zBOOL
  var int    state_rtnOverlayCount;                                     // 0x05AC int
  var int    state_walkmode_routine;                                    // 0x05B0 int
  var int    state_weaponmode_routine;                                  // 0x05B4 zBOOL
  var int    state_startNewRoutine;                                     // 0x05B8 zBOOL
  var int    state_aiStateDriven;                                       // 0x05BC int
  var int    state_aiStatePosition[3];                                  // 0x05C0 zVEC3
  var int    state_parOther;                                            // 0x05CC oCNpc*
  var int    state_parVictim;                                           // 0x05D0 oCNpc*
  var int    state_parItem;                                             // 0x05D4 oCItem*
  var int    state_rntChangeCount;                                      // 0x05D8 int
//}
//oCNpcInventory {
  //oCItemContainer {
  var int    inventory2_vtbl;                                           // 0x05DC
  var int    inventory2_oCItemContainer_contents;                       // 0x05E0 zCListSort<oCItem>*
  var int    inventory2_oCItemContainer_npc;                            // 0x05E4 oCNpc*
  var string inventory2_oCItemContainer_titleText;                      // 0x05E8 zSTRING
  var int    inventory2_oCItemContainer_invMode;                        // 0x05FC int
  var int    inventory2_oCItemContainer_selectedItem;                   // 0x0600 int
  var int    inventory2_oCItemContainer_offset;                         // 0x0604 int
  var int    inventory2_oCItemContainer_maxSlotsCol;                    // 0x0608 int
  var int    inventory2_oCItemContainer_maxSlotsColScr;                 // 0x060C int
  var int    inventory2_oCItemContainer_maxSlotsRow;                    // 0x0610 int
  var int    inventory2_oCItemContainer_maxSlotsRowScr;                 // 0x0614 int
  var int    inventory2_oCItemContainer_maxSlots;                       // 0x0618 int
  var int    inventory2_oCItemContainer_marginTop;                      // 0x061C int
  var int    inventory2_oCItemContainer_marginLeft;                     // 0x0620 int
  var int    inventory2_oCItemContainer_frame;                          // 0x0624 zBOOL
  var int    inventory2_oCItemContainer_right;                          // 0x0628 zBOOL
  var int    inventory2_oCItemContainer_ownList;                        // 0x062C zBOOL
  var int    inventory2_oCItemContainer_prepared;                       // 0x0630 zBOOL
  var int    inventory2_oCItemContainer_passive;                        // 0x0634 zBOOL
  var int    inventory2_oCItemContainer_TransferCount;                  // 0x0638 zINT
  var int    inventory2_oCItemContainer_viewTitle;                      // 0x063C zCView*
  var int    inventory2_oCItemContainer_viewBack;                       // 0x0640 zCView*
  var int    inventory2_oCItemContainer_viewItem;                       // 0x0644 zCView*
  var int    inventory2_oCItemContainer_viewItemActive;                 // 0x0648 zCView*
  var int    inventory2_oCItemContainer_viewItemHightlighted;           // 0x064C zCView*
  var int    inventory2_oCItemContainer_viewItemActiveHighlighted;      // 0x0650 zCView*
  var int    inventory2_oCItemContainer_viewItemInfo;                   // 0x0654 zCView*
  var int    inventory2_oCItemContainer_viewItemInfoItem;               // 0x0658 zCView*
  var int    inventory2_oCItemContainer_textView;                       // 0x065C zCView*
  var int    inventory2_oCItemContainer_viewArrowAtTop;                 // 0x0660 zCView*
  var int    inventory2_oCItemContainer_viewArrowAtBottom;              // 0x0664 zCView*
  var int    inventory2_oCItemContainer_rndWorld;                       // 0x0668 zCWorld*
  var int    inventory2_oCItemContainer_posx;                           // 0x066C int
  var int    inventory2_oCItemContainer_posy;                           // 0x0670 int
  var int    inventory2_oCItemContainer_m_bManipulateItemsDisabled;     // 0x0674 zBOOL
  var int    inventory2_oCItemContainer_m_bCanTransferMoreThanOneItem;  // 0x0678 zBOOL
  //}
  var int    inventory2_owner;                                          // 0x067C oCNpc*
  var int    inventory2_packAbility;                                    // 0x0680 zBOOL
  //zCListSort<oCItem> {
  var int    inventory2_inventory_Compare;                              // 0x0684 int(_cdecl*)(oCItem*,oCItem*)
  var int    inventory2_inventory_data;                                 // 0x0688 oCItem*
  var int    inventory2_inventory_next;                                 // 0x068C zCListSort<oCItem>*
  //}
  var string inventory2_packString;                                     // 0x0690 zSTRING
  var int    inventory2_maxSlots;                                       // 0x06A4 int
//}
  var int    trader;                                                    // 0x06A8 oCItemContainer*
  var int    tradeNpc;                                                  // 0x06AC oCNpc*
  var int    rangeToPlayer;                                             // 0x06B0 zREAL
//zCArray<zTSoundHandle> {
  var int    listOfVoiceHandles_array;                                  // 0x06B4 zTSoundHandle*
  var int    listOfVoiceHandles_numAlloc;                               // 0x06B8 int
  var int    listOfVoiceHandles_numInArray;                             // 0x06BC int
//}
  var int    voiceIndex;                                                // 0x06C0 int
//zCArray<oCVisualFX*> {
  var int    effectList_array;                                          // 0x06C4 oCVisualFX**
  var int    effectList_numAlloc;                                       // 0x06C8 int
  var int    effectList_numInArray;                                     // 0x06CC int
//}
  var int    bitfield[5];                                               // 0x06D0 oCNpc_bitfieldX_Xxx
  var int    instanz;                                                   // 0x06E4 int
  var string mds_name;                                                  // 0x06E8 zSTRING
  var string body_visualName;                                           // 0x06FC zSTRING
  var string head_visualName;                                           // 0x0710 zSTRING
  var int    model_scale[3];                                            // 0x0724 VEC3
  var int    model_fatness;                                             // 0x0730 zREAL
  var int    namenr;                                                    // 0x0734 int
  var int    hpHeal;                                                    // 0x0738 zREAL
  var int    manaHeal;                                                  // 0x073C zREAL
  var int    swimtime;                                                  // 0x0740 zREAL
  var int    divetime;                                                  // 0x0744 zREAL
  var int    divectr;                                                   // 0x0748 zREAL
  var int    fireVob;                                                   // 0x074C zCVob*
  var int    fireDamage;                                                // 0x0750 int
  var int    fireDamageTimer;                                           // 0x0754 zREAL
  var int    attitude;                                                  // 0x0758 int
  var int    tmp_attitude;                                              // 0x075C int
  var int    attTimer;                                                  // 0x0760 zREAL
  var int    knowsPlayer;                                               // 0x0764 int
  var int    percList[66];                                              // 0x0768 TNpcPerc[NPC_PERC_MAX] { int percID; int percFunc }
  var int    percActive;                                                // 0x0870 int
  var int    percActiveTime;                                            // 0x0874 zREAL
  var int    percActiveDelta;                                           // 0x0878 zREAL
  var int    overrideFallDownHeight;                                    // 0x087C zBOOL
  var int    fallDownHeight;                                            // 0x0880 zREAL
  var int    fallDownDamage;                                            // 0x0884 int
  var int    mag_book;                                                  // 0x0888 oCMag_Book*
//zCList<oCSpell> {
  var int    activeSpells_data;                                         // 0x088C oCSpell*
  var int    activeSpells_next;                                         // 0x0890 int
//}
//zCArray<zSTRING> {
  var int    activeOverlays_array;                                      // 0x0894 zSTRING*
  var int    activeOverlays_numAlloc;                                   // 0x0898 int
  var int    activeOverlays_numInArray;                                 // 0x089C int
//}
  var int    askbox;                                                    // 0x08A0 oCAskBox*
  var int    askYes;                                                    // 0x08A4 int
  var int    askNo;                                                     // 0x08A8 int
  var int    canTalk;                                                   // 0x08AC zREAL
  var int    talkOther;                                                 // 0x08B0 oCNpc*
  var int    info;                                                      // 0x08B4 oCInfo*
  var int    news;                                                      // 0x08B8 oCNews*
  var int    curMission;                                                // 0x08BC oCMission*
//oCNewsMemory {
  var int    knownNews_vtbl;                                            // 0x08C0
  //zCList<oCNews> {
  var int    knownNews_iknow_data;                                      // 0x08C4 oCNews*
  var int    knownNews_iknow_next;                                      // 0x08C8 zCList<oCNews>*
  //}
//}
  var int    carry_vob;                                                 // 0x08CC zCVob*
  var int    interactMob;                                               // 0x08D0 oCMobInter*
  var int    interactItem;                                              // 0x08D4 oCItem*
  var int    interactItemCurrentState;                                  // 0x08D8 int
  var int    interactItemTargetState;                                   // 0x08DC int
  var int    script_aiprio;                                             // 0x08E0 int
  var int    old_script_state;                                          // 0x08E4 int
  var int    human_ai;                                                  // 0x08E8 oCAIHuman*
  var int    anictrl;                                                   // 0x08EC oCAniCtrl_Human*
  var int    route;                                                     // 0x08F0 zCRoute*
  var int    damageMul;                                                 // 0x08F4 zREAL
  var int    csg;                                                       // 0x08F8 oCNpcMessage*
  var int    lastLookMsg;                                               // 0x08FC oCNpcMessage*
  var int    lastPointMsg;                                              // 0x0900 oCNpcMessage*
//zCArray<zCVob*> {
  var int    vobList_array;                                             // 0x0904 zCVob**
  var int    vobList_numAlloc;                                          // 0x0908 int
  var int    vobList_numInArray;                                        // 0x090C int
//}
  var int    vobcheck_time;                                             // 0x0910 zREAL
  var int    pickvobdelay;                                              // 0x0914 zREAL
  var int    focus_vob;                                                 // 0x0918 zCVob*
//zCArray<TNpcSlot*> {
  var int    invSlot_array;                                             // 0x091C TNpcSlot**
  var int    invSlot_numAlloc;                                          // 0x0920 int
  var int    invSlot_numInArray;                                        // 0x0924 int
//}
//zCArray<TNpcSlot*> {
  var int    tmpSlotList_array;                                         // 0x0928 TNpcSlot**
  var int    tmpSlotList_numAlloc;                                      // 0x092C int
  var int    tmpSlotList_numInArray;                                    // 0x0930 int
//}
  var int    fadeAwayTime;                                              // 0x0934 zREAL
  var int    respawnTime;                                               // 0x0938 zREAL
  var int    selfDist;                                                  // 0x093C zREAL
  var int    fightRangeBase;                                            // 0x0940 int
  var int    fightRangeFist;                                            // 0x0944 int
  var int    fightRangeG;                                               // 0x0948 int
  var int    fight_waitTime;                                            // 0x094C zREAL
  var int    fight_waitForAniEnd;                                       // 0x0950 zTModelAniID
  var int    fight_lastStrafeFrame;                                     // 0x0954 zREAL
  var int    soundType;                                                 // 0x0958 int
  var int    soundVob;                                                  // 0x095C zCVob*
  var int    soundPosition[3];                                          // 0x0960 zVEC3
  var int    playerGroup;                                               // 0x096C zCPlayerGroup*
};
const int sizeof_oCNpc = 2416;                                          // 0x0970

//************************************************
//   Talente sehen so aus:
//************************************************

class oCNpcTalent {
	//zCObject {
	var int    _vtbl;
	var int    _zCObject_refCtr;
	var int    _zCObject_hashIndex;
	var int    _zCObject_hashNext;
	var string _zCObject_objectName;
	//}
	var int m_talent;  //int //welches Talent? selbe Konstanten wie in Constants.d (z.B: NPC_TALENT_1H)
	var int m_skill;   //int
	var int m_value;   //int
};

////////////////////////////////////////////////////////////////////////////////
//                                                                            //
//                                   oCNews                                   //
//                                                                            //
////////////////////////////////////////////////////////////////////////////////

class oCNews {
    var int    _vtbl;         // 0x0000
    var int    told;          // 0x0004 zBOOL
    var int    spread_time;   // 0x0008 zREAL
    var int    spreadType;    // 0x000C oTNewsSpreadType
    var int    news_id;       // 0x0010 int
    var int    gossip;        // 0x0014 zBOOL
    var int    mNpcWitness;   // 0x0018 oCNpc*
    var int    mNpcOffender;  // 0x001C oCNpc*
    var int    mNpcVictim;    // 0x0020 oCNpc*
    var string witnessName;   // 0x0024 zSTRING
    var string offenderName;  // 0x0038 zSTRING
    var string victimName;    // 0x004C zSTRING
    var int    guildvictim;   // 0x0060 zBOOL
};
const int sizeof_oCNews = 100;  // 0x0064
