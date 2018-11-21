const int MAX_ITEMS = 150;
const int MENU_EVENT_MAX = 9;

class zCMenu {
    var int _vtbl;                  //0x0000

    var string backPic;             //0x0004 zSTRING 
    var string backWorld;           //0x0018 zSTRING
    var int posx;                   //0x001C int
    var int posy;                   //0x0020 int
    var int dimx;                   //0x0000 int
    var int dimy;                   //0x0000 int
    var int alpha;                  //0x0000 int
    var string musicThemeName;      //0x0000 zSTRING
    var int eventTimerUpdateMSec;   //0x0000 int
    var string itemID[MAX_ITEMS];   //0x0000 zSTRING
    var int     flags;              //0x0000 int
    var int     defaultOutGame;     //0x0000 int
    var int     defaultInGame;      //0x0000 int

    var int m_pWindow;              //0x0000 zCViewWindow*
    var int m_pInnerWindow;         //0x0000 zCViewWindow*
    
    var int m_exitState;            //0x0000 enum { NONE, BACK, GO, FINISHED }

    var string name;                //0x0000 zSTRING

    var int m_musicTheme;           //zCMusicTheme*
    var int m_mainSel;              //int
    var int m_screenInitDone;       //zBOOL

    var int m_use_dimx;             //int
    var int m_use_dimy;             //int
    var int m_use_posx;             //int
    var int m_use_posy;             //int
    
    var int m_pViewInfo;            //zCView*
    var int cursorVob;              //zCVob*

    var int eventOccured[MENU_EVENT_MAX]; //zBOOL
    var int cursorEn;               //zBOOL
    var int noneSelectable;         //zBOOL
    var int registeredCPP;          //zBOOL
    
    var int updateTimer;            //int
    var int fxTimer;                //float
    
    /*
    enum zTMenuItemSelAction {
        SEL_ACTION_UNDEF            = 0,
        SEL_ACTION_BACK             = 1,
        SEL_ACTION_STARTMENU        = 2,
        SEL_ACTION_STARTITEM        = 3,
        SEL_ACTION_CLOSE            = 4,
        SEL_ACTION_CONCOMMANDS      = 5,
        SEL_ACTION_PLAY_SOUND       = 6,
        SEL_ACTION_EXECCOMMANDS     = 7 
    };*/
    var int forceSelAction;         //zTMenuItemSelAction
    
    var string forceSelAction_S;    //zSTRING
    var int forceSelActionItem;     //zCMenuItem*
    var int forcedSelAction;        //zBOOL
    
    //zCArray <zCMenuItem *> m_listItems;   
        var int m_listItems_array;  //zCMenuItem*
        var int m_listItems_numAlloc;//int   
        var int m_listItems_numInArray;//int
    
    //[oCMenu_Status_only]
    //oCMenu_Status ist eine Unterklasse und hat zusätzlich diese Eigenschaften:
    //Hab mir gespart dafür nochmal eine Extraklasse zu schreiben, für diese Eigenschaften, siehe unten:
    
    //zCArray <oSMenuInfoAttribute> m_listAttributes;   
        var int m_listAttributes_array;     //oSMenuInfoAttribute*
        var int m_listAttributes_numAlloc;  //int    
        var int m_listAttributes_numInArray;//int
    //zCArray <oSMenuInfoTalent>        m_listTalents;
        var int m_listTalents_array;        //oSMenuInfoTalent*
        var int m_listTalents_numAlloc;     //int    
        var int m_listTalents_numInArray;   //int
    //zCArray <oSMenuInfoArmor>     m_listArmory;
        var int m_listArmory_array;         //oSMenuInfoArmor*
        var int m_listArmory_numAlloc;      //int    
        var int m_listArmory_numInArray;    //int
    
    //[/oCMenu_Status_only]
};

//Danke an Nico für die folgenden drei Klassen:
class oSMenuInfoAttribute {
    var string Name;
    var string Description;
    var int    Value;
    var int    MaxValue;
    var int    Type;  // 0 = HP, 1 = DEX, 2 = MANA, 3 = STR
};

class oSMenuInfoTalent {
    var string Name;
    var string Description;
    var string SkillEnum;
    var int    Value;
    var int    Skill;
};

class oSMenuInfoArmor {
    var int Value;  // 0 = 1H, 1 = 2H, 2 = BOW, 3 = CROSSBOW
};

//#################################################################
//
//  zCView: Basis für viele Anzeigeelemente
//
//#################################################################

//------------------------------------------------
//  Textzeile von zCView:
//------------------------------------------------

class zCViewText {
	var int _vtbl;
	
	var int posx;
	var int posy;
	
	var string text;	//zSTRING //Die Entscheidende Eigenschaft.
	var int font;		//zCFont*
	var int timer;		//zREAL //übrige Zeit für PrintScreen anzeigen die nur eine bestimmte Zeit dauern?
	var int inPrintWin; //zBOOL //vermutlich für anzeigen mit "Print", die nach oben weggeschoben werden.

	var int color;		//zCOLOR
	var int timed;		//zBOOL
	var int colored;	//zBOOL		//klingt interessant. Vielleicht kann man hiermit was anfangen.
};

//siehe Konstanten für Adresse vom globalen zCView screen.

/* zCViews kapseln zweidimensionale Objekte auf dem Bildschirm.
 * Dazu zählen zum Beispiel Texte oder Menüelemente.
 * 
 * Bei Menüelemente verhält es sich so:
 * -Ein Menüelement wird generiert, wenn es das erste mal gebraucht wird. Es lebt dann bis zum beenden von Gothic.
 * -Ein Menüelement speichert den Text, der zu ihm gehört in zCMenuItem.m_listLines.
 * -Sobald ein Menüelement etwas anzeigen muss, erzeugt es ein "InnerWindow" um speichert sich eine Referenz
 *  auf dieses InnerWindow in zCMenuItem.m_pInnerWindow.
 * -Das InnerWindow ist ein zCView und bekommt eine Kopie des anzuzeigenden Textes vom Menüelement.
 * -Das InnerWindow speichert sich alle Textzeilen (meistens eine) in zCView.textLines. Das "nullte" Element von solchen Liste bleibt stets leer.
 * -Der Text wird vom InnerWindow dann in jedem Frame gezeichnet. Sobald das Menüitem entscheidet, dass es nichts mehr anzeigen muss wird das InnerWindow zerstört.
 */

class zCView {
    var int _vtbl;
    var int _zCInputCallBack_vtbl; //Noch eine _vtbl, weil zCView von zwei Klassen erbt.
    
    /*
    enum zEViewFX
    {
        VIEW_FX_NONE,
        VIEW_FX_ZOOM,
        VIEW_FX_MAX 
    }*/
    var int m_bFillZ;               //zBOOL
    var int next;                   //zCView*

    //enum zTviewID { VIEW_SCREEN,VIEW_VIEWPORT,VIEW_ITEM };
    var int viewID;                 //zTviewID
    var int flags;                  //int
    var int intflags;               //int
    var int ondesk;                 //zBOOL Flag if in list

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
    var int alphafunc;              //zTRnd_AlphaBlendFunc
    var int color;                  //zCOLOR b, g, r, a
    var int alpha;                  //int

    // Childs
    //zList <zCView>            childs
        var int childs_compare;        //(*Compare)(zCView *ele1,zCView *ele2)
        var int childs_count;          //int
        var int childs_last;           //zCView*
        var int childs_wurzel;         //zCView*
    
    var int owner;              //zCView*
    var int backTex;            //zCTexture*

    //Das Menüzeug nutzt oft virtuelle Koordinaten.
    var int vposx;              //int
    var int vposy;              //int
    var int vsizex;             //int
    var int vsizey;             //int
    
    //Aber auch "echt" Pixelpositionen
    var int pposx;              //int
    var int pposy;              //int
    var int psizex;             //int
    var int psizey;             //int

    //Font
    var int font;               //zCFont*
    var int fontColor;          //zCOLOR
    
    //Das Textfenster:
    var int px1;                //int
    var int py1;                //int
    var int px2;                //int
    var int py2;                //int
    
    var int winx;               //int // Position in Text-Win
    var int winy;               //int
    
    //zCList <zCViewText>       textLines;
        var int textLines_data; //zCViewText*
        var int textLines_next; //zCList <zCViewText>*
        
    var int scrollMaxTime;      //zREAL
    var int scrollTimer;        //zREAL
    
    /*
    enum zTViewFX: {
        VIEW_FX_NONE        = 0,
        VIEW_FX_ZOOM        = 1,
        VIEW_FX_FADE        = VIEW_FX_ZOOM << 1,
        VIEW_FX_BOUNCE      = VIEW_FX_FADE << 1,

        VIEW_FX_FORCE_DWORD = 0xffffffff
    }*/
    
    var int fxOpen       ;    //zTViewFX            
    var int fxClose      ;    //zTViewFX            
    var int timeDialog   ;    //zREAL                 
    var int timeOpen     ;    //zREAL
    var int timeClose    ;    //zREAL                 
    var int speedOpen    ;    //zREAL                 
    var int speedClose   ;    //zREAL                 
    var int isOpen       ;    //zBOOL                 
    var int isClosed     ;    //zBOOL                 
    var int continueOpen ;    //zBOOL                 
    var int continueClose;    //zBOOL                 
    var int removeOnClose;    //zBOOL                 
    var int resizeOnOpen ;    //zBOOL                 
    var int maxTextLength;    //int                    
    var string textMaxLength;    //zSTRING              
    var int posCurrent_0[2]; //zVEC2
    var int posCurrent_1[2]; //zVEC2              
    var int posOpenClose_0[2]; //zVEC2
    var int posOpenClose_1[2]; //zVEC2
};

const int MAX_USERSTRINGS = 10;
const int MAX_SEL_ACTIONS =  5;
const int MAX_USERVARS    =  4;
const int MAX_EVENTS      = 10;

class zCMenuItem {
    var int zCView__vtbl;
    var int zCInputCallBack_vtbl;
    var int zCView_m_bFillZ;    
    var int zCView_next;        
    var int zCView_viewID;      
    var int zCView_flags;      
    var int zCView_intflags;   
    var int zCView_ondesk;      
    var int zCView_alphafunc;   
    var int zCView_color;       
    var int zCView_alpha;       
    var int zCView_compare; 
    var int zCView_childs_count;       
    var int zCView_childs_last;        
    var int zCView_childs_wurzel;      
    var int zCView_childs_owner;       
    var int zCView_backTex; 
    var int zCView_vposx;       
    var int zCView_vposy;       
    var int zCView_vsizex;     
    var int zCView_vsizey;      
    var int zCView_pposx;      
    var int zCView_pposy;       
    var int zCView_psizex;      
    var int zCView_psizey;      
    var int zCView_font;        
    var int zCView_fontColor;   
    var int zCView_px1;            
    var int zCView_py1;            
    var int zCView_px2;            
    var int zCView_py2;            
    var int zCView_winx;            
    var int zCView_winy;            
    var int zCView_textLines_data;  
    var int zCView_textLines_next; 
    var int zCView_scrollMaxTime;   
    var int zCView_scrollTimer; 
    var int zCView_fxOpen        ;  
    var int zCView_fxClose       ;  
    var int zCView_timeDialog    ;  
    var int zCView_timeOpen  ;  
    var int zCView_timeClose     ;  
    var int zCView_speedOpen     ;  
    var int zCView_speedClose    ;  
    var int zCView_isOpen        ;  
    var int zCView_isClosed  ;  
    var int zCView_continueOpen ;  
    var int zCView_continueClose;  
    var int zCView_removeOnClose;  
    var int zCView_resizeOnOpen ;  
    var int zCView_maxTextLength;  
    var string zCView_textMaxLength;            
    var int zCView_posCurrent_0[2]; 
    var int zCView_posCurrent_1[2];       
    var int zCView_posOpenClose_0[2];
    var int zCView_posOpenClose_1[2];
    
    //Parser Start
    
    var string m_parFontName;                            //zSTRING 
    var string m_parText            [MAX_USERSTRINGS];   //zSTRING 
    var string m_parBackPic;                             //zSTRING 
    var string m_parAlphaMode;                           //zSTRING 
    var int m_parAlpha;                                  //int         
    var int m_parType;                                   //int         
    var int m_parOnSelAction        [MAX_SEL_ACTIONS] ;  //int         
    var string m_parOnSelAction_S   [MAX_SEL_ACTIONS];   //zSTRING 
    var string m_parOnChgSetOption;                      //zSTRING 
    var string m_parOnChgSetOptionSection;                //zSTRING 
    var int m_parOnEventAction  [MAX_EVENTS];            //int         
    var int m_parPosX;                                   //int         
    var int m_parPosY;                                   //int         
    var int m_parDimX;                                   //int         
    var int m_parDimY;                                   //int         
    var int m_parSizeStartScale;                         //float      
    var int m_parItemFlags;                              //int         
    var int m_parOpenDelayTime;                          //float      
    var int m_parOpenDuration;                           //float      
    var int m_parUserFloat      [MAX_USERVARS];          //float   
    var string m_parUserString      [MAX_USERVARS];      //zSTRING 
    var int m_parFrameSizeX;                             //int         
    var int m_parFrameSizeY;                             //int         
    var string m_parHideIfOptionSectionSet;              //zSTRING  
    var string m_parHideIfOptionSet;                     //zSTRING  
    var int m_parHideOnValue;                            //int      
    
    //Parser End
    
    var int m_iRefCtr;                //int                      
    var int m_pInnerWindow;           //zCView*               
    var int m_pFont;                  //zCFont*               
    var int m_pFontHi;                //zCFont*               
    var int m_pFontSel;               //zCFont*               
    var int m_pFontDis;               //zCFont*               
    var int m_bViewInitialized;       //zBOOL                   
    var int m_bLeaveItem;             //zBOOL                   
    var int m_bVisible;               //zBOOL                   
    var int m_bDontRender;            //zBOOL                   
    //zCArray<zSTRING> m_listLines;
        var int m_listLines_array;     //zSTRING*
        var int m_listLines_numAlloc;  //int     
        var int m_listLines_numInArray;//int

    var string id;                     //zSTRING            
    var int inserted;                  //zBOOL            
    var int changed;                   //zBOOL            
    var int active;                    //zBOOL            
    var int open;                      //zBOOL            
    var int close;                     //zBOOL            
    var int opened;                    //zBOOL            
    var int closed;                    //zBOOL            
    var int disabled;                  //zBOOL            
    var int orgWin;                    //zCView*            
    var int fxTimer;                   //float            
    var int openDelayTimer;            //float            
    
    var int activeTimer;               //float
	var int registeredCPP;             //zBOOL
	var int firstTimeInserted;         //zBOOL
};

//#################################################################
//
//  Auch ein zCView, aber ein anderes:
//
//#################################################################

class oCViewStatusBar
{
    var int zCView__vtbl;
    var int _zCInputCallBack_vtbl;
    var int zCView_m_bFillZ;    
    var int zCView_next;        
    var int zCView_viewID;      
    var int zCView_flags;      
    var int zCView_intflags;   
    var int zCView_ondesk;      
    var int zCView_alphafunc;   
    var int zCView_color;       
    var int zCView_alpha;       
    var int zCView_compare; 
    var int zCView_childs_count;       
    var int zCView_childs_last;        
    var int zCView_childs_wurzel;      
    var int zCView_childs_owner;       
    var int zCView_backTex; 
    var int zCView_vposx;       
    var int zCView_vposy;       
    var int zCView_vsizex;     
    var int zCView_vsizey;      
    var int zCView_pposx;      
    var int zCView_pposy;       
    var int zCView_psizex;      
    var int zCView_psizey;      
    var int zCView_font;        
    var int zCView_fontColor;   
    var int zCView_px1;            
    var int zCView_py1;            
    var int zCView_px2;            
    var int zCView_py2;            
    var int zCView_winx;            
    var int zCView_winy;            
    var int zCView_textLines_data;  
    var int zCView_textLines_next; 
    var int zCView_scrollMaxTime;   
    var int zCView_scrollTimer; 
    var int zCView_fxOpen        ;  
    var int zCView_fxClose       ;  
    var int zCView_timeDialog    ;  
    var int zCView_timeOpen  ;  
    var int zCView_timeClose     ;  
    var int zCView_speedOpen     ;  
    var int zCView_speedClose    ;  
    var int zCView_isOpen        ;  
    var int zCView_isClosed  ;  
    var int zCView_continueOpen ;  
    var int zCView_continueClose;  
    var int zCView_removeOnClose;  
    var int zCView_resizeOnOpen ;  
    var int zCView_maxTextLength;  
    var string zCView_textMaxLength;            
    var int zCView_posCurrent_0[2]; 
    var int zCView_posCurrent_1[2];       
    var int zCView_posOpenClose_0[2];
    var int zCView_posOpenClose_1[2];
    
    var int minLow, maxHigh;         //zREAL
    var int low, high;               //zREAL
    var int previewValue;            //zREAL
    var int currentValue;            //zREAL
    
    var int scale;                   //float   
    var int range_bar;               //zCView* 
    var int value_bar;               //zCView* 
    var string texView;              //zSTRING 
    var string texRange;             //zSTRING 
    var string texValue;             //zSTRING 
};

//#################################################################
//
//  Vermutlich ziemlich nutzlos, ich dachte zunächst die Klasse
//  wäre wichtiger. Alles entscheidende spielt sich
//  zumindest was das Charaktermenü angeht in den gewöhnlichen
//  zCMenuItems ab. zCMenuItemText wird (nicht ausschließlich)
//  für Auswahlboxen benutzt (In den Einstellungen: [ja|nein]-Box)
//
//#################################################################

class zCMenuItemText {
	var int zCView__vtbl;
    var int _zCInputCallBack_vtbl;
    var int zCView_m_bFillZ;    
    var int zCView_next;        
    var int zCView_viewID;      
    var int zCView_flags;      
    var int zCView_intflags;   
    var int zCView_ondesk;      
    var int zCView_alphafunc;   
    var int zCView_color;       
    var int zCView_alpha;       
    var int zCView_compare; 
    var int zCView_childs_count;       
    var int zCView_childs_last;        
    var int zCView_childs_wurzel;      
    var int zCView_childs_owner;       
    var int zCView_backTex; 
    var int zCView_vposx;       
    var int zCView_vposy;       
    var int zCView_vsizex;     
    var int zCView_vsizey;      
    var int zCView_pposx;      
    var int zCView_pposy;       
    var int zCView_psizex;      
    var int zCView_psizey;      
    var int zCView_font;        
    var int zCView_fontColor;   
    var int zCView_px1;            
    var int zCView_py1;            
    var int zCView_px2;            
    var int zCView_py2;            
    var int zCView_winx;            
    var int zCView_winy;            
    var int zCView_textLines_data;  
    var int zCView_textLines_next; 
    var int zCView_scrollMaxTime;   
    var int zCView_scrollTimer; 
    var int zCView_fxOpen        ;  
    var int zCView_fxClose       ;  
    var int zCView_timeDialog    ;  
    var int zCView_timeOpen  ;  
    var int zCView_timeClose     ;  
    var int zCView_speedOpen     ;  
    var int zCView_speedClose    ;  
    var int zCView_isOpen        ;  
    var int zCView_isClosed  ;  
    var int zCView_continueOpen ;  
    var int zCView_continueClose;  
    var int zCView_removeOnClose;  
    var int zCView_resizeOnOpen ;  
    var int zCView_maxTextLength;  
    var string zCView_textMaxLength;            
    var int zCView_posCurrent_0[2]; 
    var int zCView_posCurrent_1[2];       
    var int zCView_posOpenClose_0[2];
    var int zCView_posOpenClose_1[2];
    
    var string _zCMenuItem_m_parFontName;                           
    var string _zCMenuItem_m_parText [MAX_USERSTRINGS];  
    var string _zCMenuItem_m_parBackPic;                            
    var string _zCMenuItem_m_parAlphaMode;                          
    var int _zCMenuItem_m_parAlpha;                                 
    var int _zCMenuItem_m_parType;                                  
    var int _zCMenuItem_m_parOnSelAction [MAX_SEL_ACTIONS] ; 
    var string _zCMenuItem_m_parOnSelAction_S [MAX_SEL_ACTIONS];  
    var string _zCMenuItem_m_parOnChgSetOption;                     
    var string _zCMenuItem_m_parOnChgSetOptionSection;              
    var int _zCMenuItem_m_parOnEventAction [MAX_EVENTS];           
    var int _zCMenuItem_m_parPosX;                                  
    var int _zCMenuItem_m_parPosY;                                  
    var int _zCMenuItem_m_parDimX;                                  
    var int _zCMenuItem_m_parDimY;                                  
    var int _zCMenuItem_m_parSizeStartScale;                        
    var int _zCMenuItem_m_parItemFlags;                             
    var int _zCMenuItem_m_parOpenDelayTime;                         
    var int _zCMenuItem_m_parOpenDuration;                          
    var int _zCMenuItem_m_parUserFloat [MAX_USERVARS];         
    var string _zCMenuItem_m_parUserString [MAX_USERVARS];     
    var int _zCMenuItem_m_parFrameSizeX;                            
    var int _zCMenuItem_m_parFrameSizeY;                            
    var string _zCMenuItem_m_parHideIfOptionSectionSet;             
    var string _zCMenuItem_m_parHideIfOptionSet;                    
    var int _zCMenuItem_m_parHideOnValue;                           
    var int _zCMenuItem_m_iRefCtr;                             
    var int _zCMenuItem_m_pInnerWindow;                        
    var int _zCMenuItem_m_pFont;                               
    var int _zCMenuItem_m_pFontHi;                             
    var int _zCMenuItem_m_pFontSel;                            
    var int _zCMenuItem_m_pFontDis;                            
    var int _zCMenuItem_m_bViewInitialized;                    
    var int _zCMenuItem_m_bLeaveItem;                          
    var int _zCMenuItem_m_bVisible;                            
    var int _zCMenuItem_m_bDontRender;                         
    var int _zCMenuItem_m_listLines_array;                 
    var int _zCMenuItem_m_listLines_numAlloc;              
    var int _zCMenuItem_m_listLines_numInArray;            
    var string _zCMenuItem_id;                                 
    var int _zCMenuItem_inserted;                              
    var int _zCMenuItem_changed;                               
    var int _zCMenuItem_active;                                
    var int _zCMenuItem_open;                                  
    var int _zCMenuItem_close;                                 
    var int _zCMenuItem_opened;                                
    var int _zCMenuItem_closed;                                
    var int _zCMenuItem_disabled;                              
    var int _zCMenuItem_orgWin;                                
    var int _zCMenuItem_fxTimer;                               
    var int _zCMenuItem_openDelayTimer;                        
    var int _zCMenuItem_activeTimer;                           
	var int _zCMenuItem_registeredCPP;                            
	var int _zCMenuItem_firstTimeInserted;     

    /* 	enum {
	    	MODE_SIMPLE,
	    	MODE_ENUM,
	    	MODE_MULTILINE
    } */
    var int m_mode; //siehe enum

	var string m_fullText;		//zSTRING
	var int	m_numOptions;	    //int //Relevant für Options-Menüitems wo man zum Beispiel zwischen "aus" und "an" wählen kann.

	var int m_topLine;          //int		 
	var int m_viewLines;        //int		 
	var int m_numLines;         //int		 
	var int m_unformated;	    //zBOOL	
};