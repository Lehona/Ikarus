const int zCResource_bitfield0_cacheState        = ((1 <<  2) - 1) <<  0;
const int zCResource_bitfield0_cacheOutLock      = ((1 <<  1) - 1) <<  8;
const int zCResource_bitfield0_cacheClassIndex   = ((1 <<  8) - 1) << 16;
const int zCResource_bitfield0_managedByResMan   = ((1 <<  1) - 1) << 24;
const int zCResource_bitfield1_cacheInPriority   = ((1 << 16) - 1) <<  0;
const int zCResource_bitfield1_canBeCachedOut    = ((1 <<  1) - 1) << 16;

class zCResource {
    //zCObject {
      var int    _vtbl;
      var int    _zCObject_refCtr;
      var int    _zCObject_hashIndex;
      var int    _zCObject_hashNext;
      var string _zCObject_objectName;

    var int nextRes;    //zCResource*
    var int prevRes;    //zCResource*
    var int timeStamp;  //zDWORD

    //zCCriticalSection stateChangeGuard
        var int stateChangeGuard_vbtl;
        var int stateChangeGuard_criticalSection[6]; //CRITICAL_SECTION

    var int bitfield[2];
};


const int zCTexture_bitfield_hasAlpha            = 1 <<  0;
const int zCTexture_bitfield_isAnimated          = 1 <<  8;
const int zCTexture_bitfield_changingRealtime    = 1 << 16;
const int zCTexture_bitfield_isTextureTile       = 1 << 24;

class zCTexture {
    //zCObject {
      var int    _vtbl;
      var int    _zCObject_refCtr;
      var int    _zCObject_hashIndex;
      var int    _zCObject_hashNext;
      var string _zCObject_objectName;

    //zCResource
      var int _zCResource_nextRes;
      var int _zCResource_prevRes;
      var int _zCResource_timeStamp;
      var int _zCResource_stateChangeGuard_vbtl;
      var int _zCResource_stateChangeGuard_criticalSection[6];
      var int _zCResource_bitfield[2];

    //zCTextureExchange
      var int _zCTextureExchange_vtbl;

    var int nextAni     [3]; //zCTexture*
    var int prevAni     [3]; //zCTexture*
    var int actAniFrame [3]; //int
    var int numAniFrames[3]; //int

    var int bitfield;
};

const int zCTex_D3D_bitfield_xtex_decompress = ((1 <<  1) - 1) << 17;
const int zCTex_D3D_bitfield_xtex_locked     = ((1 <<  1) - 1) << 18;
const int zCTex_D3D_bitfield_xtex_palsupport = ((1 <<  1) - 1) << 19;
const int zCTex_D3D_bitfield_xtex_miplocked  = ((1 << 12) - 1) << 20;

class zCTex_D3D {
    //zCObject {
      var int    _vtbl;
      var int    _zCObject_refCtr;
      var int    _zCObject_hashIndex;
      var int    _zCObject_hashNext;
      var string _zCObject_objectName;

    //zCResource
      var int _zCResource_nextRes;
      var int _zCResource_prevRes;
      var int _zCResource_timeStamp;
      var int _zCResource_stateChangeGuard_vbtl;
      var int _zCResource_stateChangeGuard_criticalSection[6];
      var int _zCResource_bitfield[2];

    //zCTextureExchange
      var int _zCTextureExchange_vtbl;
    
    //zCTexture
      var int _zCTexture_nextAni[3];     
      var int _zCTexture_prevAni[3];     
      var int _zCTexture_actAniFrame[3]; 
      var int _zCTexture_numAniFrames[3];
      var int _zCTexture_bitfield;
    
    var int xtex_textureflag; //tends to be 0xDEADFACE
    var int bitfield;

    //zCTextureInfo xtex_texinfo
        var int xtex_texinfo_texFormat;     // zTRnd_TextureFormat
        var int xtex_texinfo_sizeX;         // int
        var int xtex_texinfo_sizeY;         // int
        var int xtex_texinfo_numMipMap;     // int
        var int xtex_texinfo_refSizeX;      // int
        var int xtex_texinfo_refSizeY;      // int
        var int xtex_texinfo_averageColor;  // zCOLOR

    //zCSurfaceCache_D3D::zCSlotIndex xtex_slotindex
		var int	xtex_slotindex_dynamic;            //int
		var int	xtex_slotindex_pixelformat;        //int
		var int	xtex_slotindex_mipmaps;            //int
		var int	xtex_slotindex_width;              //int
		var int	xtex_slotindex_height;             //int
    
    var int xtex_pPalettePtr;           //char*
    var int xtex_pddpal;                //IDirectDrawPalette*
    var int xtex_internalnumber;        //int                      
    var int xtex_alphaTex;              //zBOOL                    
    var int xtex_pddtex[12];            //IDirectDrawSurface7*
    var int xtex_pddtemporarytex[12];   //IDirectDrawSurface7*
    var int xtex_lastFrameUsed;         //int
    var int xtex_buffer;                //void*
};