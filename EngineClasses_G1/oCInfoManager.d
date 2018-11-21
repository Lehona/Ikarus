class oCInfoChoice
{
    var string Text    ;   //zSTRING 
    var int Function;      //int     //symbolindex    
};

//----------------------------------
//  oCInfo
//----------------------------------

/* Große Vorsicht!

Im Gegensatz zu C_NPC und C_ITEM zeigt eine C_INFO nicht auf den vergrößerten
Speicherbereich, sondern tatsächlich auf sich selbst.
MEM_InstGetOffset liefert also, auf eine C_INFO angewendet NICHT die Adresse
des umrahmenden oCInfo Objekts sondern die Adresse der enthaltenen C_INFO zurück.
Um an die oCInfo zu kommen müssen 4 + 4 + 20 = 28 abgezogen werden! */

const int oCInfo_C_INFO_Offset = 28;

class oCInfo {
    //Achtung: Nur "name" und "told" wandert in ein Savegame!
    
    var int _vtbl;                  //Methodentabelle

    var int next;                   //oCInfo*
    var string name;                //zSTRING

    //Wohlbekannt:
    //struct Tpd {
        var int npc         ;       //int
        var int nr          ;       //int
        var int important   ;       //zBOOL   
        var int conditions  ;       //int   
        var int information ;       //int   
        var string description ;       //zSTRING
        var int trade       ;       //zBOOL   
        var int permanent   ;       //zBOOL   
    //} pd;

    var int told        ;           //zBOOL  //schonmal abgespielt (das was Npc_KnowsInfo abfragt)
    var int _instance   ;           //int    //symbolindex der oCInfo im Parser.
    
    //Choices:
    //zCList< oCInfoChoice > listChoices;
        var int listChoices_data;   //oCInfoChoice*
        var int listChoices_next;   //zCList< oCInfoChoice >*
};

class oCInfoManager {
    var int _vtbl;                  //Zeiger auf Methodentabelle                                            
    
    //Liste aller oCInfos. Geordnet nach...? Müsste man mal nachschauen.
    //zCListSort< oCInfo > infoList;    
        var int infoList_compare;   //int (*Compare)(oCInfo *ele1,oCInfo *ele2);
        var int infoList_data;      //oCInfo*
        var int infoList_next;      //zCListSort< oCInfo >*
        
    //Parser.
    var int p;                      //zCParser*
};

class oCInformationManager 
{
    /*
    typedef
    enum zEInformationManagerMode
    {
        INFO_MGR_MODE_IMPORTANT ,
        INFO_MGR_MODE_INFO      ,
        INFO_MGR_MODE_CHOICE    ,
        INFO_MGR_MODE_TRADE
    }
    zTInfoMgrMode; */

    var string LastMethod           ;  //zSTRING                         
    var int DlgStatus               ;  //zCViewDialogChoice*    //das sind Views. Das heißt vermutlich nur Anzeige
    var int DlgTrade                ;  //oCViewDialogTrade*     //das sind Views. Das heißt vermutlich nur Anzeige
    var int DlgChoice               ;  //zCViewDialogChoice*    //das sind Views. Das heißt vermutlich nur Anzeige
    var int Npc                     ;  //oCNpc*                       
    var int Player                  ;  //oCNpc*                       
    var int Info                    ;  //oCInfo*                         
    var int IsDone                  ;  //zBOOL                //== InfoManager_HasFinished         
    var int IsWaitingForEnd         ;  //zBOOL                         
    var int IsWaitingForScript      ;  //zBOOL                         
    var int IsWaitingForOpen        ;  //zBOOL                         
    var int IsWaitingForClose       ;  //zBOOL                         
    var int IsWaitingForSelection   ;  //zBOOL                         
    var int MustOpen                ;  //zBOOL                         
    var int IndexBye                ;  //int                                
    var int ImportantCurrent        ;  //int                                
    var int ImportantMax            ;  //int                                
    var int Mode                    ;  //zTInfoMgrMode           
};