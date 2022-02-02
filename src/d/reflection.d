module d.reflection;
import core.runtime:defaultTraceHandler;

public string[] stack_trace() {
    auto trace= defaultTraceHandler(null);
    string[] result= new string[0];
    foreach (line; trace) result ~= [line];
    return result;
};
