module d.util.bits;

public struct BitArray(uint size) {
    private enum byteNum= (size /8) + ((size %8)>0);
    private enum metaIndex= "[index /8, index %8]";
    private enum metaIndex_unrap= "uint indexByte= index /8; uint indexBit= index %8;";
    alias bitfield= void[byteNum];
    public bitfield data;
    public bitfield __bitfield1_storage() @property { return this.data; };
    private enum bitPlaces= [0x80, 0x40, 0x20, 0x10, 0x08, 0x04, 0x02, 0x01];
    public bool opIndex(uint index) @property {
        mixin(metaIndex_unrap);
        return ((cast(ubyte[])this.data)[indexByte]&bitPlaces[indexBit])>0;
    };
    public void opIndexAssign(bool bit, uint index) @property {
        mixin(metaIndex_unrap);
        ubyte* bytes= cast(ubyte*)this.data.ptr;
        ubyte v= bytes[indexByte];
        v ^= v & bitPlaces[indexBit];
        v |= bit * bitPlaces[indexBit];
        (cast(ubyte[])this.data)[indexByte]= v;
    };
};

unittest {
    BitArray!35 flags;
    flags[18]= true;
    flags[13]= true;
    flags[14]= true;
    assert((cast(ubyte[])flags.__bitfield1_storage)[0]==0x00);
    assert((cast(ubyte[])flags.__bitfield1_storage)[1]==0x06);
    assert((cast(ubyte[])flags.__bitfield1_storage)[2]==0x20);
    assert((cast(ubyte[])flags.__bitfield1_storage)[3]==0x00);
    assert((cast(ubyte[])flags.__bitfield1_storage)[4]==0x00);
    flags[13]= false;
    flags[14]= false;
    flags[3]= true;
    flags[7]= true;
    flags[17]= true;
    flags[33]= true;
    assert((cast(ubyte[])flags.__bitfield1_storage)[0]==0x11);
    assert((cast(ubyte[])flags.__bitfield1_storage)[1]==0x00);
    assert((cast(ubyte[])flags.__bitfield1_storage)[2]==0x60);
    assert((cast(ubyte[])flags.__bitfield1_storage)[3]==0x00);
    assert((cast(ubyte[])flags.__bitfield1_storage)[4]==0x40);
    writeln(flags.__bitfield1_storage);   //   [17, 0, 96, 0, 64]
};
