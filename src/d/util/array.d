module d.util.array;
public import std.array;

public struct array2d(T) {
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

alias doubleArray2d= array2d!double;

unittest {
    import std.stdio:writeln;
    doubleArray2d test= doubleArray2d(4, 5);
    test[3,5]= 21.0;
    writeln(test);
};
