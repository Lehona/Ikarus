//#################################################################
//
//  Ini File Interface: zCOption
//
//#################################################################

/*
    The sense of "Temporary values" is probably, that the developers
    thought of an "apply" button. If that "apply" button is used,
    temporary values would have been made persistent.
    
    Doesn't seem like this feature is used anywhere.
*/

//************************************
//  zCOptions is the interface
//  to access ini files.
//************************************

const int NUM_ENTRIES = 26;

class zCOption {
    var int _vbtl;
    var int m_bReadTemp;            //zBOOL //read "temporary" value instead of normal value.

    //zCArray<zCOptionSection*> sectionList; //an ini files consists of sections
        var int sectionList_array;
        var int sectionList_numAlloc;
        var int sectionList_numInArray;
    
    var int directory[NUM_ENTRIES];      //zFILE*   //no idea what this is for.
    var string dir_string[NUM_ENTRIES];  //zSTRING //no idea what this is for.
    var string commandline;              //zSTRING //zCOptions is responsible for the command line as well.
};

class zCOptionSection { 
    var string secName;                 //zSTRING //name of the section. For example "GAME"

    //zCArray<zCOptionEntry*> entryList; //the entries in this section.
        var int entryList_array;
        var int entryList_numAlloc;
        var int entryList_numInArray;
};

const int sizeof_zCOptionSection = /* sizeof_zString */ 20 + 12;

class zCOptionEntry {   
    var int changed;            //zBOOL     //unused?
    
    //zCArray <EntryChangeHandler> ccbList; //engine functions that want to be informed, whenever this option changes. Quite useless for modders.
        var int ccbList_array;
        var int ccbList_numAlloc;
        var int ccbList_numInArray;

    // Variable-Data    
    var string varName;        //zSTRING    //name of the variable
    var string varValue;       //zSTRING    //value of the variable (everything is converted to a string)
    var string varValueTemp;   //zSTRING    //temporary value of the variable. See above. Useless as far as I can see.
    var int varFlag;           //int        //flags of the variable. The engine doesn't seem to care about these flags however.
};

const int sizeof_zCOptionEntry = 5*4 + 3 * 20;