//--------------------------------------
// Kamera
//--------------------------------------

const int NUM_FRUSTUM_PLANES = 6;

class zCCamera {
    //enum { CLIP_FLAGS_FULL        = 63, CLIP_FLAGS_FULL_WO_FAR    = 15 };
    //enum { NUM_FRUSTUM_PLANES_WO_FAR  =  4 };
    //enum { FRUSTUM_PLANE_FAR  =  4 };

    //zTPlane           frustumplanes   [NUM_FRUSTUM_PLANES];
        var int frustumplanes[24/*NUM_FRUSTUM_PLANES * sizeof (zTPlane)*/];         //zTPlane: { zREAL distance; zPOINT3 normal; }
        var int signbits[/*NUM_FRUSTUM_PLANES als Bytes*/ 2];   //zBYTE

    //var int zTViewportData    vpData;
        var int xmin;               //int           // oben rechts
        var int ymin;               //int         
        var int xdim;               //int           
        var int ydim;               //int         
        var int xminFloat;          //zVALUE        // oben links
        var int yminFloat;          //zVALUE    
        var int xmaxFloat;          //zVALUE        // unten rechts
        var int ymaxFloat;          //zVALUE    
        var int xdimFloat;          //zVALUE        
        var int ydimFloat;          //zVALUE    
        var int xdimFloatMinus1;    //zVALUE    
        var int ydimFloatMinus1;    //zVALUE    
        var int xcenter;            //zVALUE
        var int ycenter;            //zVALUE
    
    var int targetView;                         //zCViewBase

    //Transformationsmatrizzen:
    var int camMatrix   [16];       //zMATRIX4
    var int camMatrixInv[16];       //zMATRIX4

    var int tremorToggle;       //zBOOL
    var int tremorScale;        //zREAL
    var int tremorAmplitude[3]; //zVEC3
    var int tremorOrigin[3];    //zVEC3
    var int tremorVelo;         //zREAL

    // Transformation matrices
    var int trafoView   [16];   //zMATRIX4
    var int trafoViewInv[16];   //zMATRIX4
    var int trafoWorld  [16];   //zMATRIX4
    
    /*
    template <class T, int SIZE> class zCMatrixStack {
        int     pos;
        T       stack[SIZE];
    }*/
    //zCMatrixStack<zMATRIX4,8> trafoViewStack;
        var int trafoViewStack[/* 1 + 16 * 8 */129];
    //zCMatrixStack<zMATRIX4,8> trafoWorldStack;
        var int trafoWorldStack[/* 1 + 16 * 8 */129];
    //zCMatrixStack<zMATRIX4,8> trafoWorldViewStack;
        var int trafoWorldViewStack[/* 1 + 16 * 8 */129];
    
    var int trafoProjection[16]; //zMATRIX4

    //enum { zTCAM_POLY_NUM_VERT = 4 };
    
    /*
    struct zTCamVertSimple {
        zREAL       x,y,z;      
        zVEC2       texuv;
        zCOLOR      color;
    };
    */
    
    //zTCamVertSimple polyCamVerts[zTCAM_POLY_NUM_VERT];
        var int polyCamVerts[/*zTCAM_POLY_NUM_VERT * (3 + 2 + 1)*/ 24];
    
    var int poly;           //zCPolygon* 
    var int polyMesh;       //zCMesh*   
    var int polyMaterial;   //zCMaterial*

    // Screen-Effects
    var int screenFadeEnabled;         //zBOOL            
    var int screenFadeColor;           //zCOLOR          
    var string screenFadeTexture;      //zSTRING            
    var int screenFadeTextureAniFPS;   //zREAL            
    
    /*
    enum zTRnd_AlphaBlendFunc   {   zRND_ALPHA_FUNC_MAT_DEFAULT,
                                zRND_ALPHA_FUNC_NONE,                   
                                zRND_ALPHA_FUNC_BLEND,              
                                zRND_ALPHA_FUNC_ADD,                    
                                zRND_ALPHA_FUNC_SUB,                    
                                zRND_ALPHA_FUNC_MUL,                    
                                zRND_ALPHA_FUNC_MUL2,                   
                                zRND_ALPHA_FUNC_TEST,   
                                zRND_ALPHA_FUNC_BLEND_TEST
                            };  */
    var int screenFadeTextureBlendFunc;     //zTRnd_AlphaBlendFunc
    var int cinemaScopeEnabled;             //zBOOL 
    var int cinemaScopeColor;               //zCOLOR

    //ungenutzt:
    //enum zPROJECTION  { PERSPECTIVE, ORTHOGONAL };
    var int projection;     //zPROJECTION
    
    /*
    enum zTCam_DrawMode { zCAM_DRAW_NORMAL, zCAM_DRAW_NOTHING, 
                      zCAM_DRAW_WIRE, zCAM_DRAW_FLAT, zCAM_DRAW_TEX }; */
    var int drawMode; //zTCam_DrawMode
    
    /*
    enum zTShadeMode    { zSHADE_NORMAL, zSHADE_NOTHING, zSHADE_CONSTANT, zSHADE_GOURAUD, zSHADE_LIGHTMAP }; */
    var int shadeMode;  //zTShadeMode
    
    var int drawWire;   //zBOOL

    var int farClipZ;          //zVALUE 
    var int nearClipZ;         //zVALUE 
    var int viewDistanceX;     //zVALUE 
    var int viewDistanceY;     //zVALUE 
    var int viewDistanceXInv;  //zVALUE 
    var int viewDistanceYInv;  //zVALUE 
    var int vobFarClipZ;       //zBOOL   
    var int fovH;              //zREAL
    var int fovV;              //zREAL   
    var int connectedVob;     //zCVob*
    
    var int topBottomSin;      //zVALUE
    var int topBottomCos;      //zVALUE
    var int leftRightSin;      //zVALUE
    var int leftRightCos;      //zVALUE
};