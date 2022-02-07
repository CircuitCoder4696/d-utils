module d.util.bits;

public struct BitArray {
    alias bitfield= void[];
    public bitfield data;
    public size_t size;
    public bitfield __bitfield1_storage() @property { return this.data; };
    private enum metaIndex_unrap= "uint indexByte= index /8; uint indexBit= index %8;";
    private enum bitPlaces= [0x80, 0x40, 0x20, 0x10, 0x08, 0x04, 0x02, 0x01];
    public this(uint size) {
    	uint byteNum= (size /8) + ((size %8)>0);
        this.size= size;
        this.data= new void[byteNum];
    };
    public bool opIndex(uint index) @property {
        mixin(metaIndex_unrap);
        return ((cast(ubyte[])this.data)[indexByte]&bitPlaces[indexBit])>0;
    };
    public void opIndexAssign(bool bit, uint index) @property {
        mixin(metaIndex_unrap);
        assert(size > ((indexByte*8) + indexBit), "`bit` out of bounds!  ");
        ubyte* bytes= cast(ubyte*)this.data.ptr;
        ubyte v= bytes[indexByte];
        v ^= v & bitPlaces[indexBit];
        v |= bit * bitPlaces[indexBit];
        (cast(ubyte[])this.data)[indexByte]= v;
    };
    public void setUByte(ubyte val, uint index) @property {
        mixin(metaIndex_unrap);
        assert(size > index, "`byte` out of bounds!  ");
        ubyte* bytes= cast(ubyte*)this.data.ptr;
        bytes[index]= val;
    };
    public void setUShort(ushort val, uint index) @property {
        mixin(metaIndex_unrap);
        assert(size > indexByte, "`byte` out of bounds!  ");
        ushort* shorts= cast(ushort*)(this.data.ptr + index);
        shorts[0]= val;
    };
    public void setUInt(uint val, uint index) @property {
        mixin(metaIndex_unrap);
        assert(size > index, "`int` out of bounds!  ");
        uint* bytes= cast(uint*)(this.data.ptr + index);
        bytes[index]= val;
    };
    public void setULong(ulong val, uint index) @property {
        mixin(metaIndex_unrap);
        assert(size > indexByte, "`byte` out of bounds!  ");
        ulong* ulongs= cast(ulong*)(this.data.ptr + index);
        ulongs[0]= val;
    };
    public string toString() {
        return "BitArray(%s)".format(this.size);
    };
};

public struct BitField(uint size) {
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
        assert(size > ((indexByte*8) + indexBit), "`bit` out of bounds!  ");
        ubyte* bytes= cast(ubyte*)this.data.ptr;
        ubyte v= bytes[indexByte];
        v ^= v & bitPlaces[indexBit];
        v |= bit * bitPlaces[indexBit];
        (cast(ubyte[])this.data)[indexByte]= v;
    };
    public void setUByte(ubyte val, uint index) @property {
        mixin(metaIndex_unrap);
        assert(size > index, "`byte` out of bounds!  ");
        ubyte* bytes= cast(ubyte*)this.data.ptr;
        bytes[index]= val;
    };
    public void setUShort(ushort val, uint index) @property {
        mixin(metaIndex_unrap);
        assert(size > indexByte, "`byte` out of bounds!  ");
        ushort* shorts= cast(ushort*)(this.data.ptr + index);
        shorts[0]= val;
    };
    public void setUInt(uint val, uint index) @property {
        mixin(metaIndex_unrap);
        assert(size > index, "`int` out of bounds!  ");
        uint* bytes= cast(uint*)(this.data.ptr + index);
        bytes[index]= val;
    };
    public void setULong(ulong val, uint index) @property {
        mixin(metaIndex_unrap);
        assert(size > indexByte, "`byte` out of bounds!  ");
        ulong* ulongs= cast(ulong*)(this.data.ptr + index);
        ulongs[0]= val;
    };
    public string toString() {
        return "BitField!(%s)".format(size);
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
    // writeln(flags.data);   //   [17, 0, 96, 0, 64]
    flags.setUInt(2500000000, 0);
    // writeln(flags.data);   //   [0, 249, 2, 149, 64]
    assert((cast(ubyte[])flags.__bitfield1_storage)[0]==0x00);
    assert((cast(ubyte[])flags.__bitfield1_storage)[1]==0xf9);
    assert((cast(ubyte[])flags.__bitfield1_storage)[2]==0x02);
    assert((cast(ubyte[])flags.__bitfield1_storage)[3]==0x95);
    assert((cast(ubyte[])flags.__bitfield1_storage)[4]==0x40);
};
