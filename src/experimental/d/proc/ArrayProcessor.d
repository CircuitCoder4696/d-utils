module d.proc.ArrayProcessor;

public class ArrayProcessor {
    public static size_t[] indexesOf_homo(T)(T[] data, T[] query) {
        size_t[] result= [];
        long q= -2;
        while(q!=-1) {
            q= data.indexOf(query, q + 1);
            if(q < 0)break;
            result ~= (&q)[0..1];
        };
        return result;
    };
    public static size_t[] indexesOf_hete(T)(T[] data, T[] query) {
        size_t[] result= [];
        long q= -2;
        while(q!=-1) {
            q += query.length;
            q= data.indexOf(query, q);
            if(q < 0)break;
            result ~= (&q)[0..1];
        };
        return result;
    };
    public static T[] replaceAll(T)(T[] data, T[] from, T[] to) {
        T[] result= "";
        result.length += 65536;   //Note:   Just in case, I want to try and avoid letting it take up space via reallocations.  
        size_t pre,post,toLen= to.length;
        size_t[] d0= indexesOf_hete(data, from);
        post= d0[0];
        result ~= data[pre..post];
        foreach(_i, i; d0[1..$]) {
            pre= post + toLen;
            post= i;
            result ~= to ~ data[pre..post];
        };
        return result;
    };
    public static T[] replace(T)(T[] data, T[] oldSeg, T[] newSeg) {
        T[] result= [];
        result.length += 65536;   //Note:   Just in case, I want to try and avoid letting it take up space via reallocations.  
        size_t pre,post,toLen= to.length;
        size_t[] d0= indexesOf_hete(data, from);
        return data;
    };
};
public class t_ArrayProcessor {
    import std.stdio:writeln;
    string d0= "Hello world!  ";
    string d1;
    void replaceSegmentsOfString() {
        d1= ArrayProcessor.replace(d0, "o", ":letter_O:");
    };
    public void test(string[] ArgV) {
        replaceSegmentsOfString();
        writeln(d1);
        writeln("[Critical] ",__MODULE__," @",__LINE__,":   Unfortunately this compiler doesn't see certain static methods.  ");
    };
};
