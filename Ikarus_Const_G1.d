const int GOTHIC_BASE_VERSION = 1;

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
const int ContentParserAddress      =  9293320;//0x8DCE08
const int vfxParserPointerAddress   =  8822380;//0x869E6C
const int menuParserPointerAddress  =  8836056;//0x86D3D8
const int pfxParserPointerAddress   =  8864640;//0x874380

//ShowDebug-Einstellung
const int showDebugAddress = 9298376;//0x8DE1C8

//Array mit alle erzeugten (und nicht wieder zerstörten) Menüs
const int MEMINT_MenuArrayOffset = 8836020;//0x86D3B4
const int MEMINT_MenuItemArrayAddres = 8836196; //0x86D464

//Ein paar nützliche statische Objekte
const int MEMINT_oGame_Pointer_Address = 9283260; //0x8DA6BC
const int MEMINT_zTimer_Address = 9236972;//0x8CF1EC
const int MEMINT_oCInformationManager_Address = 10328072;//0x9D9808

const int MEMINT_gameMan_Pointer_address = 8776164; //0x85E9E4

//Zufallszahlenarray der Engine (für Hashwerte):
const int crc_table_address = 8211704;//0x7D4CF8

//Arrays mit Informationen zu gedrückten Tasten
const int MEMINT_KeyEvent_Offset = 8834248;//0x86CCC8
const int MEMINT_KeyToggle_Offset = 8834768;//0x86CED0
const int MEMINT_KeyBuffer_offset = 8835804;//0x86D2DC

//Statisches Zeug vom Spawnmanager
const int SPAWN_INSERTTIME_MAX_Address = 8720304; //0x850FB0 //zREAL*
const int SPAWN_INSERTRANGE_Address    = 8720308; //0x850FB4 //zREAL*
const int SPAWN_REMOVERANGE_Address    = 8720312; //0x850FB8 //zREAL*

/* In Gothic 1 nicht vorhanden: 
	const int game_holdTime_Address; //zBOOL*
*/

//Statische Eigenschaften betreffend der Untertitelanzeige:
const int oCNpc_isEnabledTalkBox_Address        =  8707644; //84DE3C //zBOOL*

/* In Gothic 1 nicht vorhanden:
	const int oCNpc_isEnabledTalkBoxPlayer_Address;		 //zBOOL*
	const int oCNpc_isEnabledTalkBoxAmbient_Address;	 //zBOOL*
	const int oCNpc_isEnabledTalkBoxNoise_Address;		 //zBOOL*
*/

//globaler Screen (vom Typ zCView), da liegt z.B HP-Bar etc drin.
const int screen_offset = 9298364;	//0x8DE1BC

//Gekapselte Gothic.ini (zum Zugriff stehen Funktionen bereit)
const int zoptions_Pointer_Address = 8820372; //0x869694
//[modname].ini (zum Zugriff stehen Funktionen bereit)
const int zgameoptions_Pointer_Address = 8820376; //0x869698

//Performance Counter Ticks per Millisecond
const int PC_TicksPerMS_Address = 8842796; //0x86EE2C

//--------------------------------------
// Sonstige Konstanten
//--------------------------------------

//Adresse der Methodentabellen zur Unterscheidung von Objekten
const int oCMobFire_vtbl        = 8247780;
const int zCMover_vtbl          = 8241068;
const int oCMob_vtbl            = 8248572;
const int oCMobInter_vtbl       = 8248756;
const int oCMobContainer_vtbl   = 8246268;
const int oCMobDoor_vtbl        = 8247468;
const int oCItem_vtbl           = 8245452;
const int oCNpc_vtbl            = 8249140;

//orcwarriors constants:

const int zCEventMenager_vtbl            = 8251772;
const int poCollisionObject_vtbl     	 = 8256180;
const int poCollisionObjectClass_vtbl    = 7711376;
const int oCView_vtbl           		 = 8251936;
const int oCViewStatusBar_vtbl           = 8197216;
const int zCSkyController_Outdoor_vtbl   = 8243908;
const int oWorld_vtbl   				 = 8251596;
const int oCGame_vtbl   				 = 8244204;
const int zCAIBase_vtbl					 = 8200912;
const int oCAIHuman_vtbl   				 = 8243220;
//const int zCVisual_vtbl   			 = ?
const int zCModel_vtbl   				 = 8208364;
const int oCNpcTalent_vtbl   			 = 8249116;
const int zCRoute_vtbl   				 = 8252184;
const int oCMobLadder_vtbl    			 = 8247188;	
const int oCInfoMenager_vtbl   			 = 6705872;	
const int zString_vtbl   				 = 8193768;	
const int zCZoneSound_vtbl 				 = 8243052;	
const int zCZoneMusicDefault_vtbl		 = 8252620;	
const int zCZoneMusic_vtbl				 = 8252476;	
const int zCCSManager_vtbl				 = 8194068;	
const int zCAICamera_vtbl				 = 8201664;	
const int zCVob_vtbl				 	 = 8238156;
const int oCGameInfo_vtbl			 	 = 8196140;	
const int zCMenuItem_vtbl		 	 	 = 8251988;
const int zCTexture_vtbl			 	 = 8254100;
const int zCMaterial_vtbl			 	 = 8208076;
const int zCMesh_vtbl			 	 	 = 8208236;
const int oCFreepoint_vtbl			  	 = 8252220;
const int oCLensFlare_vtbl			  	 = 8240412;
const int zCVobSound_vtbl			  	 = 8243052;
//const int oCWaypoint_vtbl			  	 = ?
const int zCVobLight_vtbl			  	 = 8238388;
const int oCTriggerScript_vtbl		  	 = 8196940;
const int oCMobWheel_vtbl            	 = 8246908;
const int zCZoneSoundDaytime_vtbl 		 = 8242900;	
const int oCTriggerChangeLevel_vtbl		 = 8196812;
const int zCDecal_vtbl					 = 8241804;
const int oCMeshSoftSkin_vtbl			 = 8209812;
const int oCModelAni_vtbl				 = 8208660;

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
