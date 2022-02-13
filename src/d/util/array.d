module d.util.array;
public import std.array;

alias doubleArray2D= Array2D_data!double;

public struct Array(T) {
    public static deRef(T)(void* array) {
        alias t= Array2D_data!T;
        return (cast(t*)array)[0];
    };
    private byte dn;
    private ulong x;
    private ulong y;
    private ulong z;
    private T[] data;
    public this(uint x, uint y) {
        this.dn= 2;
        this.x= x;
        this.y= y;
        this.data= new T[(x +1)*y];
    };
    public T opIndex(uint x, uint y) {
        return this.data[(x*this.y) + y];
    };
    public void opIndexAssign(T v, uint x, uint y) {
        this.data[(x*this.y) + y]= v;
    };
    public this(uint x, uint y, uint z) {
        this.dn= 3;
        this.x= x;
        this.y= y;
        this.z= z;
        this.data= new T[(x +1)*y*z];
    };
    public T opIndex(uint x, uint y, uint z) {
        return this.data[(x + ((y + (z*this.y))*this.x))];
    };
    public void opIndexAssign(T v, uint x, uint y, uint z) {
        this.data[(x + ((y + (z*this.y))*this.x))]= v;
    };
};

alias doubleArray= Array!double;

unittest {
    import std.stdio:writeln;
    auto d2= Array2D_data!(float)(4,5);
    auto d3= Array3D_data!(float)(4,5,6);
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
