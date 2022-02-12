module d.util.array;
public import std.array;

public struct Array2D(T) {
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

alias doubleArray2D= Array2D!double;

public struct Array3D(T) {
    private ulong x;
    private ulong y;
    private ulong z;
    private T[] data;
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

alias doubleArray3D= Array3D!double;

unittest {
    import std.stdio:writeln;
    doubleArray2d test= doubleArray2d(4, 5);
    test[3,5]= 21.0;
    writeln(test);
};
