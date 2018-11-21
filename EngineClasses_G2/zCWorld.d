const int zCWorld_DIMENSION = 3; //achwas
const int zCWorld_VobHashTable_Offset = 600; //0x0258
const int VOB_HASHTABLE_SIZE = 2048;

class oWorld {
/*0x0000*/    var int    _vtbl;
            //Object
/*0x0004*/    var int    _zCObject_refCtr;
/*0x0008*/    var int    _zCObject_hashIndex;
/*0x000C*/    var int    _zCObject_hashNext;
/*0x0010*/    var string _zCObject_objectName;
      
            //zCTree<zCVob>     globalVobTree;  //Jedes (?) Vob in der Welt ist hier drin.
/*0x0024*/    var int globalVobTree_parent;     //zCTree<zCVob>* 
/*0x0028*/    var int globalVobTree_firstChild; //zCTree<zCVob>* 
/*0x002C*/    var int globalVobTree_next;       //zCTree<zCVob>* 
/*0x0030*/    var int globalVobTree_prev;       //zCTree<zCVob>* 
/*0x0034*/    var int globalVobTree_data;       //zCVob*            
            
            /*
            enum                zTWorldLoadMode         {   zWLD_LOAD_GAME_STARTUP,         
                                                            zWLD_LOAD_GAME_SAVED_DYN,       
                                                            zWLD_LOAD_GAME_SAVED_STAT,      
                                                            zWLD_LOAD_EDITOR_COMPILED,      
                                                            zWLD_LOAD_EDITOR_UNCOMPILED,    
                                                            zWLD_LOAD_MERGE };
            enum                zTWorldSaveMode         {   zWLD_SAVE_GAME_SAVED_DYN,       
                                                            zWLD_SAVE_EDITOR_COMPILED,      
                                                            zWLD_SAVE_EDITOR_UNCOMPILED,    
                                                            zWLD_SAVE_COMPILED_ONLY         
                                                        };
            enum                zTWorldLoadMergeMode    {   zWLD_LOAD_MERGE_ADD,                    
                                                            zWLD_LOAD_MERGE_REPLACE_ROOT_VISUAL };
          */
            
            //Ergebnisse einer Raytracing suche...
            //zTTraceRayReport  traceRayReport;
/*0x0038*/      var int foundHit;               //zBOOL        
/*0x003C*/      var int foundVob;               //zCVob*           
/*0x0040*/      var int foundPoly;              //zCPolygon*
/*0x0044*/      var int foundIntersection[3];   //zVEC3     
/*0x0050*/      var int foundPolyNormal[3];     //zVEC3     
/*0x005C*/      var int foundVertex;            //zCVertex* 

        /*
            enum zTStaticWorldLightMode {   
                zWLD_LIGHT_VERTLIGHT_ONLY,
                zWLD_LIGHT_VERTLIGHT_LIGHTMAPS_LOW_QUAL,
                zWLD_LIGHT_VERTLIGHT_LIGHTMAPS_MID_QUAL,
                zWLD_LIGHT_VERTLIGHT_LIGHTMAPS_HI_QUAL
            };
            
            enum zTWld_RenderMode { zWLD_RENDER_MODE_VERT_LIGHT,        
                                    zWLD_RENDER_MODE_LIGHTMAPS  };  */
            
            //Sonstige Daten:
/*0x0060*/  var int ownerSession;      //zCSession*  
/*0x0064*/  var int csPlayer;          //zCCSPlayer*    

/*0x0068*/  var string m_strlevelName; //zSTRING                    
/*0x007C*/  var int compiled;               //zBOOL                 
/*0x0080*/  var int compiledEditorMode;     //zBOOL                 
/*0x0084*/  var int traceRayIgnoreVobFlag;  //zBOOL                 
/*0x0088*/  var int m_bIsInventoryWorld;    //zBOOL                 
/*0x008C*/  var int worldRenderMode;        //zTWld_RenderMode / int
/*0x0090*/  var int wayNet;                 //zCWayNet*
/*0x0094*/  var int masterFrameCtr;         //zTFrameCtr            
/*0x0098*/  var int vobFarClipZ;            //zREAL                 
/*0x009C*/  var int vobFarClipZScalability; //zREAL
            
            //zCArray<zCVob*>               traceRayVobList;
/*0x00A0*/      var int traceRayVobList_array;      //zCVob**
/*0x00A4*/      var int traceRayVobList_numAlloc;   //int
/*0x00A8*/      var int traceRayVobList_numInArray; //int
            //zCArray<zCVob*>               traceRayTempIgnoreVobList;
/*0x00AC*/      var int traceRayTempIgnoreVobList_array;      //zCVob**
/*0x00B0*/      var int traceRayTempIgnoreVobList_numAlloc;   //int
/*0x00B4*/      var int traceRayTempIgnoreVobList_numInArray; //int
        
/*0x00B8*/  var int renderingFirstTime;         //zBOOL                      
/*0x00BC*/  var int showWaynet;                 //zBOOL              
/*0x00C0*/  var int showTraceRayLines;          //zBOOL              
/*0x00C4*/  var int progressBar;               //zCViewProgressBar* 
/*0x00C8*/  var int unarchiveFileLen;           //zDWORD            
/*0x00CC*/  var int unarchiveStartPosVobtree;   //zDWORD            
/*0x00D0*/  var int numVobsInWorld;             //int                             
            
            //zCArray<zCWorldPerFrameCallback*> perFrameCallbackList;
/*0x00D4*/      var int perFrameCallbackList_array;      //zCWorldPerFrameCallback**
/*0x00D8*/      var int perFrameCallbackList_numAlloc;   //int    
/*0x00DC*/      var int perFrameCallbackList_numInArray; //int    
            
            //Der Outdoorskycontroller ist der interessante
            //Hat eine Outdoorwelt einen Indoorskycontroller für Portalräume?
/*0x00E0*/  var int skyControlerIndoor;        //zCSkyControler*
/*0x00E4*/  var int skyControlerOutdoor;       //zCSkyControler*
/*0x00E8*/  var int activeSkyControler;        //zCSkyControler*
                                        
            // zones                    
            //zCArray<zCZone*>          zoneGlobalList;     //Defaut-Zonen sind am Anfang der Liste
/*0x00EC*/     var int zoneGlobalList_array;      //zCZone**
/*0x00F0*/     var int zoneGlobalList_numAlloc;   //int
/*0x00F4*/     var int zoneGlobalList_numInArray; //int
            //zCArraySort<zCZone*>      zoneActiveList;
/*0x00F8*/     var int zoneActiveList_array;      //zCZone**
/*0x00FC*/     var int zoneActiveList_numAlloc;   //int
/*0x0100*/     var int zoneActiveList_numInArray; //int
/*0x0104*/     var int zoneActiveList_compare;    //int (*Compare)(const void* ele1,const void* ele2)
       
            //zCArraySort<zCZone*>      zoneLastClassList;
/*0x0108*/     var int zoneLastClassList_array;      //zCZone**
/*0x010C*/     var int zoneLastClassList_numAlloc;   //int
/*0x0110*/     var int zoneLastClassList_numInArray; //int
/*0x0114*/     var int zoneLastClassList_compare;     //int (*Compare)(const void* ele1,const void* ele2)
        

            //Drei Handle-Listen, jeweils nach einer Koordinate sortiert.
            //Um aktive Zonen für eine Welt durch Schnittmenge dreier Array Abschnitte zu bestimmen. (?)
            //zCVobBBox3DSorter<zCZone> zoneBoxSorter
/*0x0118*/          var int zoneBoxSorter_vtbl;     //Methodentabelle
                //zCArray<zTBoxSortHandle *>        handles;
/*0x011C*/          var int zoneBoxSorter_handles_array;         //zTBoxSortHandle**
/*0x0120*/          var int zoneBoxSorter_handles_numAlloc;      //int
/*0x0124*/          var int zoneBoxSorter_handles_numInArray;    //int
                //zCArraySort<zTNode*> nodeList[zCWorld_DIMENSION];
                    //0
/*0x0128*/          var int zoneBoxSorter_nodeList0_array;         //zTNode**
/*0x012C*/          var int zoneBoxSorter_nodeList0_numAlloc;      //int             
/*0x0130*/          var int zoneBoxSorter_nodeList0_numInArray;    //int             
/*0x0134*/          var int zoneBoxSorter_nodeList0_compare;       //int    (*Compare)(const void* ele1,const void* ele2)
                    //1                                                
/*0x0138*/          var int zoneBoxSorter_nodeList1_array;         //zTNode**
/*0x013C*/          var int zoneBoxSorter_nodeList1_numAlloc;      //int             
/*0x0140*/          var int zoneBoxSorter_nodeList1_numInArray;    //int             
/*0x0144*/          var int zoneBoxSorter_nodeList1_compare;       //int    (*Compare)(const void* ele1,const void* ele2)
                    //2                                                
/*0x0148*/          var int zoneBoxSorter_nodeList2_array;         //zTNode**
/*0x014C*/          var int zoneBoxSorter_nodeList2_numAlloc;      //int             
/*0x0150*/          var int zoneBoxSorter_nodeList2_numInArray;    //int             
/*0x0154*/          var int zoneBoxSorter_nodeList2_compare;       //int    (*Compare)(const void* ele1,const void* ele2)
/*0x0158*/      var int zoneBoxSorter_sorted;                       //zBOOL
            
            //Um die zur Zeit relevante Menge von Zonen einzugrenzen?
            
            //zCVobBBox3DSorter<zCZone>::zTBoxSortHandle    zoneActiveHandle;
/*0x015C*/      var int zoneActiveHandle_vtbl;                  //Pointer to Method table
/*0x0160*/      var int zoneActiveHandle_mySorter;              //zCBBox3DSorterBase*
                   //zTBBox3D bbox3D;
/*0x0164*/          var int zoneActiveHandle_mins[3];           //zPOINT3
/*0x0170*/          var int zoneActiveHandle_maxs[3];           //zPOINT3

/*0x017C*/      var int zoneActiveHandle_indexBegin [zCWorld_DIMENSION]; //int
/*0x0188*/      var int zoneActiveHandle_indexEnd   [zCWorld_DIMENSION]; //int
                
                //zCArray<VOB*> activeList;
/*0x0194*/          var int zoneActiveHandle_activeList_array;         //VOB **
/*0x0198*/          var int zoneActiveHandle_activeList_numAlloc;      //int             
/*0x019C*/          var int zoneActiveHandle_activeList_numInArray;    //int             
        
/*0x01A0*/  var int addZonesToWorld;                        //zBOOL
/*0x01A4*/  var int showZonesDebugInfo;                     //zBOOL
    
            //--------------------------------------
            // Binary Space Partitioning Tree
            //--------------------------------------
    
/*0x01A8*/  var int cbspTree;                               //zCCBspTree*   //"construction" Bsp. Was tut der?
            //zCBspTree bspTree;                    //Hier der eigentliche bsp Tree:
/*0x01AC*/    var int bspTree_actNodePtr;           //zCBspNode* //nur beim Aufbau interessant
/*0x01B0*/    var int bspTree_actLeafPtr;           //zCBspLeaf* //nur beim Aufbau interessant
                 
/*0x01B4*/    var int bspTree_bspRoot;              //zCBspBase*
/*0x01B8*/    var int bspTree_mesh;                 //zCMesh*
/*0x01BC*/    var int bspTree_treePolyList;         //zCPolygon**
/*0x01C0*/    var int bspTree_nodeList;             //zCBspNode*
/*0x01C4*/    var int bspTree_leafList;             //zCBspLeaf*
/*0x01C8*/    var int bspTree_numNodes;             //int           
/*0x01CC*/    var int bspTree_numLeafs;             //int           
/*0x01D0*/    var int bspTree_numPolys;             //int           
              
              //zCArray<zCVob*>         renderVobList;    //Im letzten Frame gerendert
/*0x01D4*/      var int bspTree_renderVobList_array;      //zCVob**
/*0x01D8*/      var int bspTree_renderVobList_numAlloc;   //int
/*0x01DC*/      var int bspTree_renderVobList_numInArray; //int
              //zCArray<zCVobLight*>        renderLightList;        //Im letzten Frame gerendert
/*0x01E0*/      var int bspTree_renderLightList_array;      //zCVobLight**
/*0x01E4*/      var int bspTree_renderLightList_numAlloc;   //int
/*0x01E8*/      var int bspTree_renderLightList_numInArray; //int                                                   

              //zCArray<zCBspSector*>       sectorList; //im letzten Frame gerendert
/*0x01EC*/      var int bspTree_sectorList_array;      //zCBspSector**
/*0x01F0*/      var int bspTree_sectorList_numAlloc;   //int
/*0x01F4*/      var int bspTree_sectorList_numInArray; //int                                                    
              //zCArray<zCPolygon*>     portalList;
/*0x01F8*/      var int bspTree_portalList_array;      //zCPolygon**
/*0x02FC*/      var int bspTree_portalList_numAlloc;   //int
/*0x0200*/      var int bspTree_portalList_numInArray; //int                                                    
              
              //enum zTBspTreeMode      {   zBSP_MODE_INDOOR, zBSP_MODE_OUTDOOR };
/*0x0204*/    var int bspTree_bspTreeMode;         //zTBspTreeMode    
/*0x0208*/    var int bspTree_worldRenderMode;     //zTWld_RenderMode / int
/*0x020C*/    var int bspTree_vobFarClipZ;         //zREAL                  
/*0x0210*/    var int bspTree_vobFarPlane[4];       //zTPlane                       //zREAL     distance; //zPOINT3     normal;
/*0x0220*/    var int bspTree_vobFarPlaneSignbits; //int                         
/*0x0224*/    var int bspTree_drawVobBBox3D;       //zBOOL                  
/*0x0228*/    var int bspTree_leafsRendered;       //int                         
/*0x022C*/    var int bspTree_vobsRendered;        //int                         
/*0x0230*/    var int bspTree_m_bRenderedFirstTime;//zBOOL                  
/*0x0234*/    var int bspTree_masterFrameCtr;      //zTFrameCtr         
/*0x0238*/    var int bspTree_actPolyPtr;           //zCPolygon**   //nur beim Aufbau interessant
/*0x023C*/    var int bspTree_compiled;            //zBOOL                  
                                                                    
            //zCArray<zCVob*>               activeVobList;  //aktive Vobs (Physik / AI)
/*0x0240*/      var int activeVobList_array;      //zCVob**
/*0x0244*/      var int activeVobList_numAlloc;   //int
/*0x0248*/      var int activeVobList_numInArray; //int 
            //zCArray<zCVob*>               walkList; // wird im jedem Frame als Kopie der activeVobList gesetzt. Dann bekommt jedes Objekt in der Liste die Gelegenheit seinen Kram zu erledigen.
/*0x024C*/      var int walkList_array;      //zCVob**
/*0x0250*/      var int walkList_numAlloc;   //int
/*0x0254*/      var int walkList_numInArray; //int  
            //zCArray<zCVob*>               vobHashTable[VOB_HASHTABLE_SIZE];               // for fast vob searching by name
                //Mit "array", "numAlloc" und "numInArray" also 3*VOB_HASHTABLE_SIZE Wörter.
                //Der Lexer erlaubt keine so großen Arrays, daher ist meine Deklaration semantischer Unsinn.
                //Wer mit der Hashtabelle arbeiten will, muss selbst die Offsetrechnung betreiben.
                //Siehe MEM_SearchVobByName für Benutzung.
/*0x0258*/      var int vobHashTableStart[2048];
                var int vobHashTableMiddle[2048];
                var int vobHashTableEnd[2048];

            var string worldFilename;   //zSTRING Pfad des aktuellen Levels
            var string worldName;       //zSTRING Name des aktuellen Levels
    
            //nicht ausprobiert, aber hoffentlich ist der Name Programm.
            //wie hier sortiert ist weiß ich nicht.
            var int voblist;            //zCListSort<zCVob>*
            var int voblist_npcs;       //zCListSort<oCNpc>*
            var int voblist_items;      //zCListSort<oCItem>*
};