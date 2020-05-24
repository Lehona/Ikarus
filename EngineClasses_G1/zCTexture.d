const int zCResource_bitfield0_cacheState        = ((1 <<  2) - 1) <<  0;
const int zCResource_bitfield0_cacheOutLock      = ((1 <<  1) - 1) <<  8;
const int zCResource_bitfield0_cacheClassIndex   = ((1 <<  8) - 1) << 16;
const int zCResource_bitfield0_managedByResMan   = ((1 <<  1) - 1) << 24;
const int zCResource_bitfield1_cacheInPriority   = ((1 << 16) - 1) <<  0;
// const int zCResource_bitfield1_canBeCachedOut = ((1 <<  1) - 1) << 16; //G2 only

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
