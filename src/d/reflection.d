module d.reflection;
import core.runtime:defaultTraceHandler;

public string[] stack_trace() {
    version(GDC) {
        import std.stdio:writeln;
        writeln("[Err] ",__MODULE__," @",__LINE__,":   Reflection may require a lot of rewriting for it to work on `gdc`.  Try using `dmd`.  ");
    };
    version(LDC) {
        import std.stdio:writeln;
        writeln("[Warn] ",__MODULE__," @",__LINE__,":   Reflection is not ready for `ldc`.  ");
    };
    import core.stdc.stdlib;
    void* st= malloc(0);
    auto trace= defaultTraceHandler(st);
    string[] result= new string[0];
    foreach (line; trace)
        result ~= [line.idup];
    free(st);
    return result;
};
