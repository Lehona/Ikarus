
//
// Only for demonstration purposes. Usage at your own risk.
// Only for Gothic I version 1.08k_mod (current Player-Kit)
//

////////////////////////////////////////////////////////////////////////////////
//                                                                            //
//                                  zCObject                                  //
//                                                                            //
////////////////////////////////////////////////////////////////////////////////

//NOTE: Bit field mask consts:     BitCount    FirstBit
const int zCObject_hashIndex = ((1 << 16) - 1) << 0;

class zCObject {
    var int    _vtbl;          // 0x0000
    var int    refCtr;         // 0x0004 int
    var int    hashIndex;      // 0x0008 zWORD
    var int    hashNext;       // 0x000C zCObject*
    var string objectName;     // 0x0010 zSTRING
};
const int sizeOf_zCObject = 36;// 0x0024

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
const int zCVob_bitfield4_collButNoMove             = ((1 << 8) - 1) <<  0;
const int zCVob_bitfield4_dontWriteIntoArchive      = ((1 << 1) - 1) <<  8;

//Offsets der X, Y, Z Positionen im trafoObjToWorld Array:
const int zCVob_trafoObjToWorld_X =  3;
const int zCVob_trafoObjToWorld_Y =  7;
const int zCVob_trafoObjToWorld_Z = 11;

class zCVob {
	var int    _vtbl;
//  zCObject {
        var int    _zCObject_refCtr;
        var int    _zCObject_hashIndex;
        var int    _zCObject_hashNext;
        var string _zCObject_objectName;
//  }
    var int        globalVobTreeNode;         // 0x0024 zCTree<zCVob>*
    var int        lastTimeDrawn;             // 0x0028 zTFrameCtr
    var int        lastTimeCollected;         // 0x002C zDWORD
//  zCArray<zCBspLeaf*> vobLeafList {
        var int    vobLeafList_array;         // 0x0030 zCBspLeaf**
        var int    vobLeafList_numAlloc;      // 0x0034 int
        var int    vobLeafList_numInArray;    // 0x0038 int
//  }
    var int        trafoObjToWorld[16];       // 0x003C zMATRIX4
//  zTBBox3D bbox3D {
        var int    bbox3D_mins[3];            // 0x007C zPOINT3
        var int    bbox3D_maxs[3];            // 0x0088 zPOINT3
//  }
//  zCArray<zCVob*> touchVobList {
        var int    touchVobList_array;        // 0x0094 zCVob**
        var int    touchVobList_numAlloc;     // 0x0098 int
        var int    touchVobList_numInArray;   // 0x009C int
//  }
    var int        type;                      // 0x00A0 zTVobType
    var int        groundShadowSizePacked;    // 0x00A4 zDWORD
    var int        homeWorld;                 // 0x00A8 zCWorld*
    var int        groundPoly;                // 0x00AC zCPolygon*
    var int        callback_ai;               // 0x00B0 zCAIBase*
    var int        trafo;                     // 0x00B4 zMATRIX4*
    var int        visual;                    // 0x00B8 zCVisual*
    var int        visualAlpha;               // 0x00BC zREAL
    var int        rigidBody;                 // 0x00C0 zCRigidBody*
    var int        lightColorStat;            // 0x00C4 zCOLOR
    var int        lightColorDyn;             // 0x00C8 zCOLOR
    var int        lightDirectionStat[3];     // 0x00CC zVEC3
    var int        vobPresetName;             // 0x00D8 zSTRING*
    var int        eventManager;              // 0x00DC zCEventManager*
    var int        nextOnTimer;               // 0x00E0 zREAL
    var int        bitfield[5];               // 0x00E4 zCVob_bitfieldX_Xxx
    var int        m_poCollisionObjectClass;  // 0x00F8 zCCollisionObjectDef*
    var int        m_poCollisionObject;       // 0x00FC zCCollisionObject*
};
const int sizeof_zCVob = 256;                 // 0x0100

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

const int oTRobustTrace_bitfield_stand                = ((1 << 1) - 1) << 0;
const int oTRobustTrace_bitfield_dirChoosed           = ((1 << 1) - 1) << 1;
const int oTRobustTrace_bitfield_exactPosition        = ((1 << 1) - 1) << 2;
const int oTRobustTrace_bitfield_targetReached        = ((1 << 1) - 1) << 3;
const int oTRobustTrace_bitfield_standIfTargetReached = ((1 << 1) - 1) << 4;
const int oTRobustTrace_bitfield_waiting              = ((1 << 1) - 1) << 5;
const int oTRobustTrace_bitfield_isObstVobSmall       = ((1 << 1) - 1) << 6;
const int oTRobustTrace_bitfield_targetVisible        = ((1 << 1) - 1) << 7;
const int oTRobustTrace_bitfield_useChasmChecks       = ((1 << 1) - 1) << 8;

//Das alte Lese/Schreibsystem benötigt diese Offsets
const int MEM_NpcID_Offset   = 256; //0x100
const int MEM_NpcName_Offset = 260; //0x104

class oCNpc
{
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
//  C_NPC {
        var int        idx;                                        // 0x0100 int
        var string     name;                                       // 0x0104 zSTRING[5]
        var string     name1;
        var string     name2;
        var string     name3;
        var string     name4;
        var string     slot;                                       // 0x0168 zSTRING
        var int        npcType;                                    // 0x017C int
        var int        variousFlags;                               // 0x0180 int
        var int        attribute[8];                               // 0x0184 int[NPC_ATR_MAX]
        var int        protection[8];                              // 0x01A4 int[oEDamageIndex_MAX]
        var int        damage[8];                                  // 0x01C4 int[oEDamageIndex_MAX]
        var int        damagetype;                                 // 0x01E4 int
        var int        guild;                                      // 0x01E8 int
        var int        level;                                      // 0x01EC int
        var func       mission[5];                                 // 0x01F0 int[NPC_MIS_MAX]
        var int        fighttactic;                                // 0x0204 int
        var int        fmode;                                      // 0x0208 int
        var int        voice;                                      // 0x020C int
        var int        voicePitch;                                 // 0x0210 int
        var int        mass;                                       // 0x0214 int
        var func       daily_routine;                              // 0x0218 int
        var func       startAIState;                               // 0x021C int
        var string     spawnPoint;                                 // 0x0220 zSTRING
        var int        spawnDelay;                                 // 0x0234 int
        var int        senses;                                     // 0x0238 int
        var int        senses_range;                               // 0x023C int
        var int        aiscriptvars[50];                           // 0x0240 int[50]
        var string     wpname;                                     // 0x0308 zSTRING
        var int        experience_points;                          // 0x031C zUINT32
        var int        experience_points_next_level;               // 0x0320 zUINT32
        var int        learn_points;                               // 0x0324 zUINT32
//  }
    var int            parserEnd;                                  // 0x0328 int
    var int            bloodEnabled;                               // 0x032C int
    var int            bloodDistance;                              // 0x0330 int
    var int            bloodAmount;                                // 0x0334 int
    var int            bloodFlow;                                  // 0x0338 int
    var string         bloodEmitter;                               // 0x033C zSTRING
    var string         bloodTexture;                               // 0x0350 zSTRING
    var int            didHit;                                     // 0x0364 zBOOL
    var int            didParade;                                  // 0x0368 zBOOL
    var int            didShoot;                                   // 0x036C zBOOL
    var int            hasLockedEnemy;                             // 0x0370 zBOOL
    var int            isDefending;                                // 0x0374 zBOOL
    var int            wasAiming;                                  // 0x0378 zBOOL
    var int            enemy;                                      // 0x037C oCNpc*
    var int            speedTurn;                                  // 0x0380 zREAL
    var int            foundFleePoint;                             // 0x0384 zBOOL
    var int            reachedFleePoint;                           // 0x0388 zBOOL
    var int            vecFlee[3];                                 // 0x038C zVEC3
    var int            posFlee[3];                                 // 0x0398 zVEC3
    var int            waypointFlee;                               // 0x03A4 zCWaypoint*
//  oTRobustTrace rbt {
        var int        rbt_bitfield;                               // 0x03A8 oTRobustTrace_bitfield_Xxx
        var int        rbt_targetPos[3];                           // 0x03AC zVEC3
        var int        rbt_targetVob;                              // 0x03B8 zCVob*
        var int        rbt_obstVob;                                // 0x03BC zCVob*
        var int        rbt_targetDist;                             // 0x03C0 zREAL
        var int        rbt_lastTargetDist;                         // 0x03C4 zREAL
        var int        rbt_maxTargetDist;                          // 0x03C8 zREAL
        var int        rbt_dirTurn;                                // 0x03CC zREAL
        var int        rbt_timer;                                  // 0x03D0 zREAL
        var int        rbt_dirFirst[3];                            // 0x03D4 zVEC3
        var int        rbt_dirLastAngle;                           // 0x03E0 zREAL
//      zCArray<oTDirectionInfo*> lastDirections {
            var int    rbt_lastDirections_array;                   // 0x03E4 oTDirectionInfo**
            var int    rbt_lastDirections_numAlloc;                // 0x03E8 int
            var int    rbt_lastDirections_numInArray;              // 0x03EC int
//      }
        var int        rbt_frameCtr;                               // 0x03F0 int
        var int        rbt_targetPosArray[15];                     // 0x03F4 zVEC3[5]
        var int        rbt_targetPosCounter;                       // 0x0430 int
        var int        rbt_targetPosIndex;                         // 0x0434 int
        var int        rbt_checkVisibilityTime;                    // 0x0438 zREAL
        var int        rbt_positionUpdateTime;                     // 0x043C zREAL
        var int        rbt_failurePossibility;                     // 0x0440 zREAL
//  }
//  zCList<oCNpcTimedOverlay> timedOverlays {
        var int        timedOverlays_data;                         // 0x0444 oCNpcTimedOverlay*
        var int        timedOverlays_next;                         // 0x0448 zCList<oCNpcTimedOverlay>*
//  }
//  zCArray<oCNpcTalent*> talents {
        var int        talents_array;                              // 0x044C oCNpcTalent**
        var int        talents_numAlloc;                           // 0x0450 int
        var int        talents_numInArray;                         // 0x0454 int
//  }
    var int            spellMana;                                  // 0x0458 int
    var int            visualFX;                                   // 0x045C oCVisualFX*
//  oCMagFrontier magFrontier {
        var int        magFrontier_warningFX;                      // 0x0460 oCVisualFX*
        var int        magFrontier_shootFX;                        // 0x0464 oCVisualFX*
        var int        magFrontier_npc;                            // 0x0468 oCNpc*
        var int        magFrontier_bitfield;                       // 0x046C oCMagFrontier_bitfield_Xxx
//  }
//  oCNpc_States state {
        var int        state_vfptr;                                // 0x0470
        var string     state_name;                                 // 0x0474 zSTRING
        var int        state_npc;                                  // 0x0488 oCNpc*
//      TNpcAIState curState {
            var int    state_curState_index;                       // 0x048C int
            var int    state_curState_loop;                        // 0x0490 int
            var int    state_curState_end;                         // 0x0494 int
            var int    state_curState_timeBehaviour;               // 0x0498 int
            var int    state_curState_restTime;                    // 0x049C zREAL
            var int    state_curState_phase;                       // 0x04A0 int
            var int    state_curState_valid;                       // 0x04A4 zBOOL
            var string state_curState_name;                        // 0x04A8 zSTRING
            var int    state_curState_stateTime;                   // 0x04BC zREAL
            var int    state_curState_prgIndex;                    // 0x04C0 int
            var int    state_curState_isRtnState;                  // 0x04C4 zBOOL
//      }
//      TNpcAIState nextState {
            var int    state_nextState_index;                      // 0x04C8 int
            var int    state_nextState_loop;                       // 0x04CC int
            var int    state_nextState_end;                        // 0x04D0 int
            var int    state_nextState_timeBehaviour;              // 0x04D4 int
            var int    state_nextState_restTime;                   // 0x04D8 zREAL
            var int    state_nextState_phase;                      // 0x04DC int
            var int    state_nextState_valid;                      // 0x04E0 zBOOL
            var string state_nextState_name;                       // 0x04E4 zSTRING
            var int    state_nextState_stateTime;                  // 0x04F8 zREAL
            var int    state_nextState_prgIndex;                   // 0x04FC int
            var int    state_nextState_isRtnState;                 // 0x0500 zBOOL
//      }
        var int        state_lastAIState;                          // 0x0504 int
        var int        state_hasRoutine;                           // 0x0508 zBOOL
        var int        state_rtnChanged;                           // 0x050C zBOOL
        var int        state_rtnBefore;                            // 0x0510 oCRtnEntry*
        var int        state_rtnNow;                               // 0x0514 oCRtnEntry*
        var int        state_rtnRoute;                             // 0x0518 zCRoute*
        var int        state_rtnOverlay;                           // 0x051C zBOOL
        var int        state_rtnOverlayCount;                      // 0x0520 int
        var int        state_walkmode_routine;                     // 0x0524 int
        var int        state_weaponmode_routine;                   // 0x0528 zBOOL
        var int        state_startNewRoutine;                      // 0x052C zBOOL
        var int        state_aiStateDriven;                        // 0x0530 int
        var int        state_aiStatePosition[3];                   // 0x0534 zVEC3
        var int        state_parOther;                             // 0x0540 oCNpc*
        var int        state_parVictim;                            // 0x0544 oCNpc*
        var int        state_parItem;                              // 0x0548 oCItem*
        var int        state_rntChangeCount;                       // 0x054C int
//  }
//  oCNpcInventory {
//      oCItemContainer inventory2 {
            var int    inventory2_vtbl;                           				   // 0x0550
            var int    inventory2_oCItemContainer_contents;                        // 0x0554 zCListSort<oCItem>*
            var int    inventory2_oCItemContainer_npc;                             // 0x0558 oCNpc*
            var int    inventory2_oCItemContainer_selectedItem;                    // 0x055C int
            var int    inventory2_oCItemContainer_offset;                          // 0x0560 int
            var int    inventory2_oCItemContainer_drawItemMax;                     // 0x0564 int
            var int    inventory2_oCItemContainer_itemListMode;                    // 0x0568 oTItemListMode
            var int    inventory2_oCItemContainer_frame;                           // 0x056C zBOOL
            var int    inventory2_oCItemContainer_right;                           // 0x0570 zBOOL
            var int    inventory2_oCItemContainer_ownList;                         // 0x0574 zBOOL
            var int    inventory2_oCItemContainer_prepared;                        // 0x0578 zBOOL
            var int    inventory2_oCItemContainer_passive;                         // 0x057C zBOOL
            var int    inventory2_oCItemContainer_viewCat;                         // 0x0580 zCView*
            var int    inventory2_oCItemContainer_viewItem;                        // 0x0584 zCView*
            var int    inventory2_oCItemContainer_viewItemActive;                  // 0x0588 zCView*
            var int    inventory2_oCItemContainer_viewItemHightlighted;            // 0x058C zCView*
            var int    inventory2_oCItemContainer_viewItemActiveHighlighted;       // 0x0590 zCView*
            var int    inventory2_oCItemContainer_viewItemFocus;                   // 0x0594 zCView*
            var int    inventory2_oCItemContainer_viewItemActiveFocus;             // 0x0598 zCView*
            var int    inventory2_oCItemContainer_viewItemHightlightedFocus;       // 0x059C zCView*
            var int    inventory2_oCItemContainer_viewItemActiveHighlightedFocus;  // 0x05A0 zCView*
            var int    inventory2_oCItemContainer_viewItemInfo;                    // 0x05A4 zCView*
            var int    inventory2_oCItemContainer_viewItemInfoItem;                // 0x05A8 zCView*
            var int    inventory2_oCItemContainer_textView;                        // 0x05AC zCView*
            var int    inventory2_oCItemContainer_viewArrowAtTop;                  // 0x05B0 zCView*
            var int    inventory2_oCItemContainer_viewArrowAtBottom;               // 0x05B4 zCView*
            var int    inventory2_oCItemContainer_rndWorld;                        // 0x05B8 zCWorld*
            var int    inventory2_oCItemContainer_posx;                            // 0x05BC int
            var int    inventory2_oCItemContainer_posy;                            // 0x05C0 int
            var string inventory2_oCItemContainer_textCategoryStatic;              // 0x05C4 zSTRING
            var int    inventory2_oCItemContainer_m_bManipulateItemsDisabled;      // 0x05D8 zBOOL
            var int    inventory2_oCItemContainer_m_bCanTransferMoreThanOneItem;   // 0x05DC zBOOL
            var int    inventory2_oCItemContainer_image_chroma;                    // 0x05E0 zCOLOR
            var int    inventory2_oCItemContainer_blit_chroma;                     // 0x05E4 zCOLOR
//      }
        var int        inventory2_owner;                           // 0x05E8 oCNpc*
        var int        inventory2_packAbility;                     // 0x05EC zBOOL
//      zCListSort<oCItem>[INV_MAX] inventory {
            var int    inventory2_inventory0_Compare;              // 0x05F0 int(_cdecl*)(oCItem*,oCItem*)
            var int    inventory2_inventory0_data;                 // 0x05F4 oCItem*
            var int    inventory2_inventory0_next;                 // 0x05F8 zCListSort<oCItem>*
            var int    inventory2_inventory1_Compare;              // 0x05FC int(_cdecl*)(oCItem*,oCItem*)
            var int    inventory2_inventory1_data;                 // 0x0600 oCItem*
            var int    inventory2_inventory1_next;                 // 0x0604 zCListSort<oCItem>*
            var int    inventory2_inventory2_Compare;              // 0x0608 int(_cdecl*)(oCItem*,oCItem*)
            var int    inventory2_inventory2_data;                 // 0x060C oCItem*
            var int    inventory2_inventory2_next;                 // 0x0610 zCListSort<oCItem>*
            var int    inventory2_inventory3_Compare;              // 0x0614 int(_cdecl*)(oCItem*,oCItem*)
            var int    inventory2_inventory3_data;                 // 0x0618 oCItem*
            var int    inventory2_inventory3_next;                 // 0x061C zCListSort<oCItem>*
            var int    inventory2_inventory4_Compare;              // 0x0620 int(_cdecl*)(oCItem*,oCItem*)
            var int    inventory2_inventory4_data;                 // 0x0624 oCItem*
            var int    inventory2_inventory4_next;                 // 0x0628 zCListSort<oCItem>*
            var int    inventory2_inventory5_Compare;              // 0x062C int(_cdecl*)(oCItem*,oCItem*)
            var int    inventory2_inventory5_data;                 // 0x0630 oCItem*
            var int    inventory2_inventory5_next;                 // 0x0634 zCListSort<oCItem>*
            var int    inventory2_inventory6_Compare;              // 0x0638 int(_cdecl*)(oCItem*,oCItem*)
            var int    inventory2_inventory6_data;                 // 0x063C oCItem*
            var int    inventory2_inventory6_next;                 // 0x0640 zCListSort<oCItem>*
            var int    inventory2_inventory7_Compare;              // 0x0644 int(_cdecl*)(oCItem*,oCItem*)
            var int    inventory2_inventory7_data;                 // 0x0648 oCItem*
            var int    inventory2_inventory7_next;                 // 0x064C zCListSort<oCItem>*
            var int    inventory2_inventory8_Compare;              // 0x0650 int(_cdecl*)(oCItem*,oCItem*)
            var int    inventory2_inventory8_data;                 // 0x0654 oCItem*
            var int    inventory2_inventory8_next;                 // 0x0658 zCListSort<oCItem>*
//      }
        var string     inventory2_packString;                      // 0x065C zSTRING[INV_MAX]
        var string     inventory2_packString1;
        var string     inventory2_packString2;
        var string     inventory2_packString3;
        var string     inventory2_packString4;
        var string     inventory2_packString5;
        var string     inventory2_packString6;
        var string     inventory2_packString7;
        var string     inventory2_packString8;
        var int        inventory2__offset[9];                      // 0x0710 int[INV_MAX]
        var int        inventory2__itemnr[9];                      // 0x0734 int[INV_MAX]
        var int        inventory2_maxSlots[9];                     // 0x0758 int[INV_MAX]
        var int        inventory2_invnr;                           // 0x077C int
//  }
    var int            trader;                                     // 0x0780 oCItemContainer*
    var int            tradeNpc;                                   // 0x0784 oCNpc*
    var int            rangeToPlayer;                              // 0x0788 zREAL
//  zCArray<zTSoundHandle> listOfVoiceHandles {
        var int        listOfVoiceHandles_array;                   // 0x078C zTSoundHandle*
        var int        listOfVoiceHandles_numAlloc;                // 0x0790 int
        var int        listOfVoiceHandles_numInArray;              // 0x0794 int
//  }
    var int            voiceIndex;                                 // 0x0798 int
    var int            bitfield[5];                                // 0x079C oCNpc_bitfieldX_Xxx
    var int            instanz;                                    // 0x07B0 int
    var string         mds_name;                                   // 0x07B4 zSTRING
    var string         body_visualName;                            // 0x07C8 zSTRING
    var string         head_visualName;                            // 0x07DC zSTRING
    var int            model_scale[3];                             // 0x07F0 VEC3
    var int            model_fatness;                              // 0x07FC zREAL
    var int            namenr;                                     // 0x0800 int
    var int            hpHeal;                                     // 0x0804 zREAL
    var int            manaHeal;                                   // 0x0808 zREAL
    var int            swimtime;                                   // 0x080C zREAL
    var int            divetime;                                   // 0x0810 zREAL
    var int            divectr;                                    // 0x0814 zREAL
    var int            fireVob;                                    // 0x0818 zCVob*
    var int            fireDamage;                                 // 0x081C int
    var int            fireDamageTimer;                            // 0x0820 zREAL
    var int            attitude;                                   // 0x0824 int
    var int            tmp_attitude;                               // 0x0828 int
    var int            attTimer;                                   // 0x082C zREAL
    var int            knowsPlayer;                                // 0x0830 int
    var int            percList[66];                               // 0x0834 TNpcPerc[NPC_PERC_MAX] { int percID; int percFunc }
    var int            percActive;                                 // 0x093C int
    var int            percActiveTime;                             // 0x0940 zREAL
    var int            percActiveDelta;                            // 0x0944 zREAL
    var int            overrideFallDownHeight;                     // 0x0948 zBOOL
    var int            fallDownHeight;                             // 0x094C zREAL
    var int            fallDownDamage;                             // 0x0950 int
    var int            mag_book;                                   // 0x0954 oCMag_Book*
//  zCList<oCSpell> activeSpells {
        var int        activeSpells_data;                          // 0x0958 oCSpell*
        var int        activeSpells_next;                          // 0x095C int
//  }
//  zCArray<zSTRING> activeOverlays {
        var int        activeOverlays_array;                       // 0x0960 zSTRING*
        var int        activeOverlays_numAlloc;                    // 0x0964 int
        var int        activeOverlays_numInArray;                  // 0x0968 int
//  }
    var int            askbox;                                     // 0x096C oCAskBox*
    var int            askYes;                                     // 0x0970 int
    var int            askNo;                                      // 0x0974 int
    var int            canTalk;                                    // 0x0978 zREAL
    var int            talkOther;                                  // 0x097C oCNpc*
    var int            info;                                       // 0x0980 oCInfo*
    var int            news;                                       // 0x0984 oCNews*
    var int            curMission;                                 // 0x0988 oCMission*
//  oCNewsMemory knownNews {
        var int        knownNews_vtbl;                            // 0x098C
//      zCList<oCNews> iknow {
            var int    knownNews_iknow_data;                       // 0x0990 oCNews*
            var int    knownNews_iknow_next;                       // 0x0994 zCList<oCNews>*
//      }
//  }
    var int            carry_vob;                                  // 0x0998 zCVob*
    var int            interactMob;                                // 0x099C oCMobInter*
    var int            interactItem;                               // 0x09A0 oCItem*
    var int            interactItemCurrentState;                   // 0x09A4 int
    var int            interactItemTargetState;                    // 0x09A8 int
    var int            script_aiprio;                              // 0x09AC int
    var int            old_script_state;                           // 0x09B0 int
    var int            human_ai;                                   // 0x09B4 oCAIHuman*
    var int            anictrl;                                    // 0x09B8 oCAniCtrl_Human*
    var int            route;                                      // 0x09BC zCRoute*
    var int            damageMul;                                  // 0x09C0 zREAL
    var int            csg;                                        // 0x09C4 oCNpcMessage*
    var int            lastLookMsg;                                // 0x09C8 oCNpcMessage*
    var int            lastPointMsg;                               // 0x09CC oCNpcMessage*
//  zCArray<zCVob*> vobList {
        var int        vobList_array;                              // 0x09D0 zCVob**
        var int        vobList_numAlloc;                           // 0x09D4 int
        var int        vobList_numInArray;                         // 0x09D8 int
//  }
    var int            vobcheck_time;                              // 0x09DC zREAL
    var int            pickvobdelay;                               // 0x09E0 zREAL
    var int            focus_vob;                                  // 0x09E4 zCVob*
//  zCArray<TNpcSlot*> invSlot {
        var int        invSlot_array;                              // 0x09E8 TNpcSlot**
        var int        invSlot_numAlloc;                           // 0x09EC int
        var int        invSlot_numInArray;                         // 0x09F0 int
//  }
//  zCArray<TNpcSlot*> tmpSlotList {
        var int        tmpSlotList_array;                          // 0x09F4 TNpcSlot**
        var int        tmpSlotList_numAlloc;                       // 0x09F8 int
        var int        tmpSlotList_numInArray;                     // 0x09FC int
//  }
    var int            fadeAwayTime;                               // 0x0A00 zREAL
    var int            respawnTime;                                // 0x0A04 zREAL
    var int            selfDist;                                   // 0x0A08 zREAL
    var int            fightRangeBase;                             // 0x0A0C int
    var int            fightRangeFist;                             // 0x0A10 int
    var int            fight_waitTime;                             // 0x0A14 zREAL
    var int            fight_waitForAniEnd;                        // 0x0A18 zTModelAniID
    var int            fight_lastStrafeFrame;                      // 0x0A1C zREAL
    var int            soundType;                                  // 0x0A20 int
    var int            soundVob;                                   // 0x0A24 zCVob*
    var int            soundPosition[3];                           // 0x0A28 zVEC3
    var int            playerGroup;                                // 0x0A34 zCPlayerGroup*
};
const int sizeof_oCNpc = 2616;                                       // 0x0A38

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

