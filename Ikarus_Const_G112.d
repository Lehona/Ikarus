const int GOTHIC_BASE_VERSION = 112; // Gothic Sequel 1.12f

//--------------------------------------
// Nutzervariablen:
//--------------------------------------

const string MEM_FARFARAWAY = "TOT";		//dort wird der Mem-Helper gespawnt
const string MEM_HELPER_NAME = "MEMHLP";    //so heißt er

const int zERR_TYPE_OK    = 0; /* [ungenutzt]        */
const int zERR_TYPE_INFO  = 1; /* MEM_Info           */
const int zERR_TYPE_WARN  = 2; /* MEM_Warn           */
const int zERR_TYPE_FAULT = 3; /* MEM_Error          */
const int zERR_TYPE_FATAL = 4; /* [ungenutzt]        */

const int zERR_ReportToZSpy     = zERR_TYPE_INFO;  //alles ab zERR_TYPE_INFO
const int zERR_ShowErrorBox     = zERR_TYPE_FAULT; //Messageboxen nur für Errors
const int zERR_PrintStackTrace  = zERR_TYPE_WARN; //Tracktrace printen für Warnings.

const int zERR_ErrorBoxOnlyForFirst   = 1; /* nie mehr als eine Error-Box anzeigen */
const int zERR_StackTraceOnlyForFirst = 0; /* nur für den ersten Error Stack Trace anzeigen */

/* Debug Channel:
 * MEM_Debug wird nicht von Ikarus verwendet und stellt einen
 * frei konfigurierbaren Nachrichtenkanal dar. */
 
const string zERR_DEBUG_PREFIX   = "Debug: ";      //dieses Präfix immer vor die Nachricht setzen.
const int    zERR_DEBUG_TOSPY    = 1;              //MEM_Debug Nachrichten an zSpy senden?
const int    zERR_DEBUG_TYPE     = zERR_TYPE_INFO; //Wenn ja als was an den Spy schicken?
const int    zERR_DEBUG_TOSCREEN = 0;              //MEM_Debug Nachrichten per "Print" ausgeben.
const int    zERR_DEBUG_ERRORBOX = 0;              //Eine Error-Box anzeigen (zum OK Klicken).

//--------------------------------------
// Adressen
//--------------------------------------

//Parser
const int ContentParserAddress      =  9588808;//0x925048
const int vfxParserPointerAddress   =  9106668;//0x8AF4EC
const int menuParserPointerAddress  =  9121540;//0x8B2F04
const int pfxParserPointerAddress   =  9150980;//0x8BA204

//ShowDebug-Einstellung
const int showDebugAddress = 9593888;//0x926420

//Array mit alle erzeugten (und nicht wieder zerstörten) Menüs
const int MEMINT_MenuArrayOffset = 9121504;//0x8B2EE0
const int MEMINT_MenuItemArrayAddres = 9121696; //0x8B2FA0

//Ein paar nützliche statische Objekte
const int MEMINT_oGame_Pointer_Address = 9571724; //0x920D8C
const int MEMINT_zTimer_Address = 9523392;//0x9150C0
const int MEMINT_oCInformationManager_Address = 10625664;//0xA22280

const int MEMINT_gameMan_Pointer_address = 9056728; //0x8A31D8

//Zufallszahlenarray der Engine (für Hashwerte):
const int crc_table_address = 8486052;//0x817CA4

//Arrays mit Informationen zu gedrückten Tasten
const int MEMINT_KeyEvent_Offset = 9119680;//0x8B27C0
const int MEMINT_KeyToggle_Offset = 9120212;//0x8B29D4
const int MEMINT_KeyBuffer_offset = 9121280;//0x8B2E00

//Statisches Zeug vom Spawnmanager
const int SPAWN_INSERTTIME_MAX_Address = 9007864; //0x8972F8 //zREAL*
const int SPAWN_INSERTRANGE_Address    = 9007868; //0x8972FC //zREAL*
const int SPAWN_REMOVERANGE_Address    = 9007872; //0x897300 //zREAL*

/* In Gothic 1 nicht vorhanden: 
	const int game_holdTime_Address; //zBOOL*
*/

//Statische Eigenschaften betreffend der Untertitelanzeige:
const int oCNpc_isEnabledTalkBox_Address        =  8994696; //893F88 //zBOOL*

/* In Gothic 1 nicht vorhanden:
	const int oCNpc_isEnabledTalkBoxPlayer_Address;		 //zBOOL*
	const int oCNpc_isEnabledTalkBoxAmbient_Address;	 //zBOOL*
	const int oCNpc_isEnabledTalkBoxNoise_Address;		 //zBOOL*
*/

//globaler Screen (vom Typ zCView), da liegt z.B HP-Bar etc drin.
const int screen_offset = 9593876;	//0x926414

//Gekapselte Gothic.ini (zum Zugriff stehen Funktionen bereit)
const int zoptions_Pointer_Address = 9102252; //0x8AE3AC
//[modname].ini (zum Zugriff stehen Funktionen bereit)
const int zgameoptions_Pointer_Address = 0; // In Gothic Sequel 1.12f nicht vorhanden

//Performance Counter Ticks per Millisecond
const int PC_TicksPerMS_Address = 9128480; //0x8B4A20

//--------------------------------------
// Sonstige Konstanten
//--------------------------------------

//Adresse der Methodentabellen zur Unterscheidung von Objekten
const int oCMobFire_vtbl        = 8522116; //0x820984
const int zCMover_vtbl          = 8515332; //0x81EF04
const int oCMob_vtbl            = 8522928; //0x820CB0
const int oCMobInter_vtbl       = 8523112; //0x820D68
const int oCMobLockable_vtbl    = 8520884; //0x8204B4
const int oCMobContainer_vtbl   = 8520544; //0x820360
const int oCMobDoor_vtbl        = 8521792; //0x820840
const int oCItem_vtbl           = 8519708; //0x82001C
const int oCNpc_vtbl            = 8523508; //0x820EF4
const int zCVobLight_vtbl		= 8512716; //0x81E4CC

const int oCMobWheel_vtbl       = 8521208; //0x8205F8
const int oCMobLadder_vtbl      = 8521500; //0x82071C
const int oCMobSwitch_vtbl      = 8520252; //0x82023C
const int oCMobBed_vtbl         = 8519960; //0x820118

// ClassDef addresses
const int oCMobFire_classDef       = 9576376; //0x921FB8
const int zCMover_classDef         = 9557840; //0x91D750
const int oCMOB_classDef           = 9577368; //0x922398
const int oCMobInter_classDef      = 9577232; //0x922310
const int oCMobLockable_classDef   = 9576104; //0x921EA8
const int oCMobContainer_classDef  = 9576984; //0x922218
const int oCMobDoor_classDef       = 9575968; //0x921E20
const int oCMobBed_classDef        = 9575848; //0x921DA8
const int oCMobSwitch_classDef     = 9576736; //0x922120
const int oCMobWheel_classDef      = 9575736; //0x921D38
const int oCMobLadder_classDef     = 9576872; //0x9221A8
const int oCNpc_classDef           = 9578544; //0x922830
const int oCItem_classDef          = 9574736; //0x921950
const int zCVobLight_classDef      = 9557240; //0x91D4F8

//--------------------------------------
// Tasten
//--------------------------------------

//Diese Liste kommt von hier:
//http://community.bistudio.com/wiki/DIK_KeyCodes

const int KEY_ESCAPE          = 01;
const int KEY_1               = 02;
const int KEY_2               = 03;
const int KEY_3               = 04;
const int KEY_4               = 05;
const int KEY_5               = 06;
const int KEY_6               = 07;
const int KEY_7               = 08;
const int KEY_8               = 09;
const int KEY_9               = 10;
const int KEY_0               = 11;
const int KEY_MINUS           = 12; 
const int KEY_EQUALS          = 13;
const int KEY_BACK            = 14; 
const int KEY_TAB             = 15;
const int KEY_Q               = 16;
const int KEY_W               = 17;
const int KEY_E               = 18;
const int KEY_R               = 19;
const int KEY_T               = 20;
const int KEY_Y               = 21;
const int KEY_U               = 22;
const int KEY_I               = 23;
const int KEY_O               = 24;
const int KEY_P               = 25;
const int KEY_LBRACKET        = 26;
const int KEY_RBRACKET        = 27;
const int KEY_RETURN          = 28; 
const int KEY_LCONTROL        = 29;
const int KEY_A               = 30;
const int KEY_S               = 31;
const int KEY_D               = 32;
const int KEY_F               = 33;
const int KEY_G               = 34;
const int KEY_H               = 35;
const int KEY_J               = 36;
const int KEY_K               = 37;
const int KEY_L               = 38;
const int KEY_SEMICOLON       = 39;
const int KEY_APOSTROPHE      = 40;
const int KEY_GRAVE           = 41; 
const int KEY_LSHIFT          = 42;
const int KEY_BACKSLASH       = 43;
const int KEY_Z               = 44;
const int KEY_X               = 45;
const int KEY_C               = 46;
const int KEY_V               = 47;
const int KEY_B               = 48;
const int KEY_N               = 49;
const int KEY_M               = 50;
const int KEY_COMMA           = 51;
const int KEY_PERIOD          = 52; 
const int KEY_SLASH           = 53; 
const int KEY_RSHIFT          = 54;
const int KEY_MULTIPLY        = 55; 
const int KEY_LMENU           = 56; 
const int KEY_SPACE           = 57;
const int KEY_CAPITAL         = 58;
const int KEY_F1              = 59;
const int KEY_F2              = 60;
const int KEY_F3              = 61;
const int KEY_F4              = 62;
const int KEY_F5              = 63;
const int KEY_F6              = 64;
const int KEY_F7              = 65;
const int KEY_F8              = 66;
const int KEY_F9              = 67;
const int KEY_F10             = 68;
const int KEY_NUMLOCK         = 69;
const int KEY_SCROLL          = 70; 
const int KEY_NUMPAD7         = 71;
const int KEY_NUMPAD8         = 72;
const int KEY_NUMPAD9         = 73;
const int KEY_SUBTRACT        = 74; 
const int KEY_NUMPAD4         = 75;
const int KEY_NUMPAD5         = 76;
const int KEY_NUMPAD6         = 77;
const int KEY_ADD             = 78; 
const int KEY_NUMPAD1         = 79;
const int KEY_NUMPAD2         = 80;
const int KEY_NUMPAD3         = 81;
const int KEY_NUMPAD0         = 82;
const int KEY_DECIMAL         = 83; 
const int KEY_OEM_102         = 86; 
const int KEY_F11             = 87; 
const int KEY_F12             = 88; 
const int KEY_F13             = 100;
const int KEY_F14             = 101;
const int KEY_F15             = 102;
const int KEY_KANA            = 112;
const int KEY_ABNT_C1         = 115;
const int KEY_CONVERT         = 121;
const int KEY_NOCONVERT       = 123;
const int KEY_YEN             = 124;
const int KEY_ABNT_C2         = 125;
const int KEY_NUMPADEQUALS    = 141;
const int KEY_PREVTRACK       = 144;
const int KEY_AT              = 145;
const int KEY_COLON           = 146;
const int KEY_UNDERLINE       = 147;
const int KEY_KANJI           = 148;
const int KEY_STOP            = 149;
const int KEY_AX              = 150;
const int KEY_UNLABELED       = 151;
const int KEY_NEXTTRACK       = 153;
const int KEY_NUMPADENTER     = 156;
const int KEY_RCONTROL        = 157;
const int KEY_MUTE            = 160;
const int KEY_CALCULATOR      = 161;
const int KEY_PLAYPAUSE       = 162;
const int KEY_MEDIASTOP       = 164;
const int KEY_VOLUMEDOWN      = 174;
const int KEY_VOLUMEUP        = 176;
const int KEY_WEBHOME         = 178;
const int KEY_NUMPADCOMMA     = 179;
const int KEY_DIVIDE          = 181;
const int KEY_SYSRQ           = 183;
const int KEY_RMENU           = 184;
const int KEY_PAUSE           = 197;
const int KEY_HOME            = 199;
const int KEY_UPARROW         = 200;
const int KEY_PRIOR           = 201;
const int KEY_LEFTARROW       = 203;
const int KEY_RIGHTARROW      = 205;
const int KEY_END             = 207;
const int KEY_DOWNARROW       = 208;
const int KEY_NEXT            = 209;
const int KEY_INSERT          = 210;
const int KEY_DELETE          = 211;
const int KEY_LWIN            = 219;
const int KEY_RWIN            = 220;
const int KEY_APPS            = 221;
const int KEY_POWER           = 222;
const int KEY_SLEEP           = 223;
const int KEY_WAKE            = 227;
const int KEY_WEBSEARCH       = 229;
const int KEY_WEBFAVORITES    = 230;
const int KEY_WEBREFRESH      = 231;
const int KEY_WEBSTOP         = 232;
const int KEY_WEBFORWARD      = 233;
const int KEY_WEBBACK         = 234;
const int KEY_MYCOMPUTER      = 235;
const int KEY_MAIL            = 236;
const int KEY_MEDIASELECT     = 237;

const int MOUSE_BUTTONLEFT	= 524; //linke Maustaste
const int MOUSE_BUTTONRIGHT	= 525; //rechte Maustaste
const int MOUSE_BUTTONMID	= 526; //mittlere Maustaste
const int MOUSE_XBUTTON1	= 527; //Sonderbuttons...
const int MOUSE_XBUTTON2	= 528;
const int MOUSE_XBUTTON3	= 529;
const int MOUSE_XBUTTON4	= 530;
const int MOUSE_XBUTTON5	= 531;
