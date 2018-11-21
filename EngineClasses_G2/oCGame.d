//statics:

class zCSession {
	var int _vtbl;
    var int csMan;        //zCCSManager*
    var int world;        //zCWorld*
    var int camera;       //zCCamera*
    var int aiCam;        //zCAICamera*
    var int camVob;       //zCVob*
    var int viewport;     //zCView*
};

const int GAME_VIEW_MAX = 6;

class oCGame {
    var int _vtbl;
    var int _zCSession_csMan;        //zCCSManager*
    var int _zCSession_world;        //zCWorld*
    var int _zCSession_camera;       //zCCamera*
    var int _zCSession_aiCam;        //zCAICamera*
    var int _zCSession_camVob;       //zCVob*
    var int _zCSession_viewport;     //zCView*

    var int cliprange;              //zREAL
    var int fogrange;               //zREAL
    var int inScriptStartup;        //zBOOL
    var int inLoadSaveGame;         //zBOOL
    var int inLevelChange;          //zBOOL

    /*
    enum oTGameDialogView
    {
        GAME_VIEW_SCREEN        ,
        GAME_VIEW_CONVERSATION  ,
        GAME_VIEW_AMBIENT       ,
        GAME_VIEW_CINEMA        ,
        GAME_VIEW_CHOICE        ,
        GAME_VIEW_NOISE         ,
        GAME_VIEW_MAX
    }*/

    //Views sind Kanäle, über die die Engine
    //Informationen anzeigen kann.
    //Beispiel sind die normalen Dialoguntertitelboxen.
    var int array_view[GAME_VIEW_MAX];          //zCView*
    var int array_view_visible[GAME_VIEW_MAX];  //zBOOL
    var int array_view_enabled[GAME_VIEW_MAX];  //zBOOL

    var int savegameManager;        //oCSavegameManager*
    var int game_text;              //zCView*
    var int load_screen;            //zCView*
    var int save_screen;            //zCView*
    var int pause_screen;           //zCView*
    var int hpBar;                  //oCViewStatusBar*
    var int swimBar;                //oCViewStatusBar*
    var int manaBar;                //oCViewStatusBar*
    var int focusBar;               //oCViewStatusBar*
    var int showPlayerStatus;       //zBOOL

    // Debugsachen
    var int game_drawall;           //zBOOL   //"toggle Desktop"
    var int game_frameinfo;         //zBOOL
    var int game_showaniinfo;       //zBOOL
    var int game_showwaynet;        //zBOOL
    var int game_testmode;          //zBOOL
    var int game_editwaynet;        //zBOOL
    var int game_showtime;          //zBOOL
    var int game_showranges;        //zBOOL
    var int drawWayBoxes;           //zBOOL
    var int scriptStartup;          //zBOOL
    var int showFreePoints;         //zBOOL
    var int showRoutineNpc;         //oCNpc*

    // Levelinfos
    var int loadNextLevel;          //zBOOL
    var string loadNextLevelName;   //zSTRING
    var string loadNextLevelStart;  //zSTRING

    // Spielerspezifika
    var int startpos[3];            //zVEC3
    var int gameInfo;               //oCGameInfo* //etwas auf den ersten Blick uninteressantes
    var int pl_light;               //zCVobLight*
    var int pl_lightval;            //zREAL

    // Timer
    var int wldTimer;               //oCWorldTimer*
    var int timeStep;               //zREAL                               // Ermöglicht Einzelbildschaltung
    var int singleStep;             //zBOOL

    // Referenzen auf Einzelstückklassen.
    var int guilds;                 //oCGuilds*
    var int infoman;                //oCInfoManager*
    var int newsman;                //oCNewsManager*
    var int svmman;                 //oCSVMManager*
    var int trademan;               //oCTradeManager*
    var int portalman;              //oCPortalRoomManager*
    var int spawnman;               //oCSpawnManager*

    //Zeug
    var int music_delay;            //zREAL
    var int watchnpc;               //oCNpc*

    //Kurz nachdem Laden kurze Pause, damit
    //sich die Systemressourcen erholen.
    var int m_bWorldEntered;        //zBOOL
    var int m_fEnterWorldTimer;     //zREAL

    //Klar:
    var int initial_hour;           //int
    var int initial_minute;         //int

    //Debug:
    //zCArray<zCVob*>           debugInstances;
        var int debugInstances_array;       //zCVob**
        var int debugInstances_numAlloc;    //int
        var int debugInstances_numInArray;  //int

    var int debugChannels;          //int
    var int debugAllInstances;      //zBOOL

    //Objektroutinen ("Wld_SetObjectRoutine"), z.B. Laternen: nur Nachts an
    /*
    typedef struct {
        zSTRING     objName;
        int         stateNum;
        int         hour1,min1;
        int         type;
    } TObjectRoutine; */

    var int oldRoutineDay;          //int

    //zCListSort<TObjectRoutine>    objRoutineList;
      var int objRoutineList_compareFunc;           //int (*Compare)(TObjectRoutine *ele1,TObjectRoutine *ele2);
      var int objRoutineList_data;                  //TObjectRoutine*
      var int objRoutineList_next;                  //zCListSort<TObjectRoutine>*

    var int currentObjectRoutine;                   //zCListSort<TObjectRoutine>*

    //ProgressBar
    var int progressBar;                            //zCViewProgressBar*

    //Nicht jedes Fass in der Welt hat ein privates Visual.
    //Ich schätze mal, dass alle benutzten Visuals hier gesammelt werden
    //und Vobs nur Kopien der Referenzen halten.

    //zCArray   <zCVisual*>     visualList;
      var int visualList_array;         //zCVisual**
      var int visualList_numAlloc;      //int
      var int visualList_numInArray;    //int
};

//######################################################
//
//	Game Manager: Kümmert sich darum
//  Game Sessions zu starten zu speichern usw.
//
//######################################################

class CGameManager
{
	var int _vbtl;

	var int oldAlphaBlendFunc;  //zTRnd_AlphaBlendFunc
	var int sysContextHandle;   //zTSystemContextHandle

	var int gameSession;        //oCGame*
	var int backLoop;           //oCGame*
	var int exitGame;	        //zBOOL
	var int exitSession;	    //zBOOL
	var int gameIdle;           //zBOOL
	var int lastWorldWasGame;   //zBOOL
	var int savegameManager;    //oCSavegameManager*

	//zCArray<zSTRING>	lastDatFileList;
		var int lastDatFileList_array;     	//zSTRING*
		var int lastDatFileList_numAlloc;   //int
		var int lastDatFileList_numInArray; //int

	//zCArray<zSTRING>	lastWorldList;
		var int lastWorldList_array;     	//zSTRING*
		var int lastWorldList_numAlloc;     //int
		var int lastWorldList_numInArray;   //int

	var string backWorldRunning;    //zSTRING
	var string backDatFileRunning;  //zSTRING

	var int vidScreen;              //zCView*
	var int initScreen;             //zCView*

	var int introActive;            //zBOOL
	var int dontStartGame;          //zBOOL

	var int videoPlayer;            //oCBinkPlayer*
	var int videoPlayInGame;        //zBOOL

	var int menu_chgkeys;           //zCMenu*
	var int menu_chgkeys_ext;       //zCMenu*
	var int menu_save_savegame;     //oCMenuSavegame*
	var int menu_load_savegame;	    //oCMenuSavegame*

	var int	playTime;				//int  //wird selten (?) aktualisiert. Mindestens aber beim Speichern und Laden.
};