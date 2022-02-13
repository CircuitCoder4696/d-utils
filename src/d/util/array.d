module d.util.array;
public import std.array;

unittest {
    import std.stdio:writeln;
    auto d= Array!float(40*40,400,5);
    writeln(d);
};

public struct Array(T) {
    import std.format:format;
    public static deRef(T)(void* array) {
        alias t= Array2D_data!T;
        return (cast(t*)array)[0];
    };
    private uint[] d;
    private T[] data;
    public this(uint[] dimensions) {
        size_t len= 1;
        foreach(v; dimensions)len *= v;
        this.d= dimensions.dup;
        this.data= new T[len];
    };
    public this(uint x) {
        this.d= [x];
        this.data= new T[x];
    };
    public T opIndex(uint x) {
        assert(this.d[0] > x, "`x:uint` is out of range.  ");
        return this.data[x];
    };
    public void opIndexAssign(T v, uint x) {
        assert(this.d[0] > x, "`x:uint` is out of range.  ");
        this.data[x]= v;
    };
    public this(uint x, uint y) {
        this.d= [x, y];
        this.data= new T[(x +1)*y];
    };
    public T opIndex(uint x, uint y) {
        assert(this.d[0] > x, "`x:uint` is out of range.  ");
        assert(this.d[1] > y, "`y:uint` is out of range.  ");
        return this.data[(x*this.d[1]) + y];
    };
    public void opIndexAssign(T v, uint x, uint y) {
        assert(this.d[0] > x, "`x:uint` is out of range.  ");
        assert(this.d[1] > y, "`y:uint` is out of range.  ");
        this.data[(x*this.d[1]) + y]= v;
    };
    public this(uint x, uint y, uint z) {
        this.d= [x, y, z];
        this.data= new T[(x +1)*y*z];
    };
    public T opIndex(uint x, uint y, uint z) {
        assert(this.d[0] > x, "`x:uint` is out of range.  ");
        assert(this.d[1] > y, "`y:uint` is out of range.  ");
        assert(this.d[2] > z, "`z:uint` is out of range.  ");
        return this.data[(x + ((y + (z*this.d[1]))*this.d[0]))];
    };
    public void opIndexAssign(T v, uint x, uint y, uint z) {
        assert(this.d[0] > x, "`x:uint` is out of range.  ");
        assert(this.d[1] > y, "`y:uint` is out of range.  ");
        assert(this.d[2] > z, "`z:uint` is out of range.  ");
        this.data[(x + ((y + (z*this.d[1]))*this.d[0]))]= v;
    };
};

alias doubleArray= Array!double;

unittest {
    import std.stdio:writeln;
    auto d2= Array!float(4,5);
    auto d3= Array!float(4,5,6);
    writeln(d2);
    writeln(d3);
};

unittest {
    import std.stdio:writeln;
    auto d2= Array!float(4,5);
    auto d3= Array!float(4,5,6);
    writeln(d2);
    writeln(d3);
};
