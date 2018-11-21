class zCVisual {
    var int    _vtbl;
    var int    _zCObject_refCtr;
    var int    _zCObject_hashIndex;
    var int    _zCObject_hashNext;
    var string _zCObject_objectName;

    var int nextLODVisual;          //zCVisual*
    var int prevLODVisual;          //zCVisual*            
    var int lodFarDistance;         //zREAL                    
    var int lodNearFadeOutDistance;    //zREAL        
};

class zCMesh {
    var int    _vtbl;
    var int    _zCObject_refCtr;
    var int    _zCObject_hashIndex;
    var int    _zCObject_hashNext;
    var string _zCObject_objectName;

    var int _zCVisual_nextLODVisual;         
    var int _zCVisual_prevLODVisual;                 
    var int _zCVisual_lodFarDistance;                    
    var int _zCVisual_lodNearFadeOutDistance;

    var int numPoly;       //int
    var int numVert;       //int
    var int numFeat;       //int

    var int vertList;              //zCVertex** 
    var int polyList;              //zCPolygon**
    var int featList;              //zCVertFeature**

    var int vertArray;             //zCVertex*
    var int polyArray;             //zCPolygon*
    var int featArray;             //zCVertFeature*

    //zTBBox3D        bbox3D;
        var int bbox3D_mins[3];       //zREAL
        var int bbox3D_maxs[3];       //zREAL
    
    //zCOBBox3D        obbox3D;
        var int obbox3D_center[3];    // zVEC3
        var int obbox3D_axis[9];      // zVEC3[3]
        var int obbox3D_extent[3];    // zVEC3

        //zCList<zCOBBox3D>    childs;
            var int obbox3D_childs_data;               //zCOBBox3D*
            var int obbox3D_childs_next;               //zCListSort<zCOBBox3D>*
        
    var int masterFrameCtr;             //int

    var int next;                       //zCMesh*
    var int prev;                       //zCMesh*
    
    var string meshName;                //zSTRING
    var int hasLightmaps;               //zBOOL
    var int m_bUsesAlphaTesting;        //zBOOL

    var int    numVertAlloc;               //int
    var int    numPolyAlloc;               //int
};
