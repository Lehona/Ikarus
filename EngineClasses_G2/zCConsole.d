const int zCON_MAX_EVAL = 15;
const int zcon_address  = 11221088; //0xAB3860

class zCConsole {
    var int _vtbl;
    
    var string id;       //zSTRING
    var string instr;    //zSTRING
    var string savemsg;  //zSTRING
    
    //zCArray<zSTRING> lastcommand;
        var int lastcommand_array;         //zString*
        var int lastcommand_numAlloc;      //int
        var int lastcommand_numInArray;    //int
        
    var int	    lastCommandPos;

    var int px; var int py;
    var int lx; var int ly;
    var int showmax; var int skip;
    
    var int dynsize;       //zBOOL
    var int _var;          //zBOOL
    var int autocomplete; //zBOOL

    //zList <zCConDat>	list;
        var int compare;            //int (*Compare)(const zCConDat* ele1,const zCConDat* ele2);
        var int count;              //int
        var int last;               //zCConDat*
        var int wurzel;             //zCConDat*
        
    var int conview; //zCView*

    var int			evalcount;
    var int evalfunc[zCON_MAX_EVAL]; //zBOOL (*evalfunc[])  ( const zSTRING &s, zSTRING &msg )
    var int changedfunc;             //void	 (*changedfunc)	( const zSTRING &s )
    
    var int world;        //zCWorld*	
    var int cparser;      //zCParser*	
    var int edit_index;   //int			
    var int edit_adr;     //void*		
};