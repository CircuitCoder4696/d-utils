module d.util.array;
public import std.array;

public struct Array(T) {
    public static deRef(T)(void* array) {
        alias t= Array2D_data!T;
        return (cast(t*)array)[0];
    };
    private byte dn;
    private uint[] d;
    private T[] data;
    public this(uint x, uint y) {
        this.dn= 2;
        this.d= [x, y];
        this.data= new T[(x +1)*y];
    };
    public T opIndex(uint x, uint y) {
        return this.data[(x*this.d[1]) + y];
    };
    public void opIndexAssign(T v, uint x, uint y) {
        this.data[(x*this.d[1]) + y]= v;
    };
    public this(uint x, uint y, uint z) {
        this.dn= 3;
        this.d= [x, y, z];
        this.data= new T[(x +1)*y*z];
    };
    public T opIndex(uint x, uint y, uint z) {
        return this.data[(x + ((y + (z*this.d[1]))*this.d[0]))];
    };
    public void opIndexAssign(T v, uint x, uint y, uint z) {
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
    auto d2= new Array!float(4,5);
    auto d3= new Array!float(4,5,6);
    writeln(d2);
    writeln(d3);
};
