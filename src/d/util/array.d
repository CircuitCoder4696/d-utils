module d.util.array;
public import std.array;

public struct Array2D_data(T) {
    public static deRef(T)(void* array) {
        alias t= Array2D_data!T;
        return (cast(t*)array)[0];
    };
    private uint x;
    private uint y;
    private T[] data;
    public this(uint x, uint y) {
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
};

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

alias doubleArray3D= Array3D_data!double;

public class Array(T) {
    private uint dn;
    private void* d;
    public this(uint x, uint y) {
        Array2D_data!T result= Array2D_data!T(x,y);
        this.dn= 2;
        this.d= cast(void*) &result;
    };
    public this(uint x, uint y, uint z) {
        Array3D_data!T result= Array3D_data!T(x,y,z);
        this.dn= 3;
        this.d= cast(void*) &result;
    };
    // private auto data() @property {
    //     switch(this.dn) {
    //         case 2: return (cast((Array2D_data!T)*)this.d)[0];
    //         case 3: return (cast((Array3D_data!T)*)this.d)[0];
    //         default:
    //             assert(0,"Data is corrupted!  ");
    //     };
    // };
    private auto data2D() @property {
        return (Array2D_data!T).deRef(this.d);
    };
    private auto data3D() @property {
        return (Array3D_data!T).deRef(this.d);
    };
    public T opIndex(uint x, uint y) {
        return this.data2D[(x*this.y) + y];
    };
    public void opIndexAssign(T v, uint x, uint y) {
        this.data2D[(x*this.y) + y]= v;
    };
    public T opIndex(uint x, uint y, uint z) {
        return this.data3D[(x + ((y + (z*this.y))*this.x))];
    };
    public void opIndexAssign(T v, uint x, uint y, uint z) {
        this.data3D[(x + ((y + (z*this.y))*this.x))]= v;
    };
};

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
