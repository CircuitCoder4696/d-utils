module d.reflection;
import core.runtime:defaultTraceHandler;

public string[] stack_trace() {   /++
    #var d.reflection.$(methodName):$(methodType)
    $div id="$(modulePath)" (
        $h2(Reflection $(methodName))
        $p(
            $b($(methodName)) is supposed to provide un-processed information from the stack-trace.  This information can later be used to help point at a specific piece of code where information has been logged from.  
        )
    )
++/
    version(GDC) {
        import std.stdio:writeln;
        writeln("[Err] ",__MODULE__," @",__LINE__,":   Reflection may require a lot of rewriting for it to work on `gdc`.  Try using `dmd`.  ");
    };
    version(LDC) {
        import std.stdio:writeln;
        writeln("[Err] ",__MODULE__," @",__LINE__,":   Reflection may require a lot of rewriting for it to work on `ldc`.  Try using `dmd`.  `ldc` returns incomplete information.  ");
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
