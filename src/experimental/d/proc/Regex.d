module experimental.d.proc.Regex;
import d.util.bits:BitArray;

unittest {
    import std.stdio:writeln;
    RegexFilter rf= genRegexFilter("[0-9A-Za-z]");
    writeln(rf);
};

private struct LoopedFilter {
    BitArray data;
};

private struct RegexFilter {
    import std.variant:Variant;
    size_t length;
    Variant[] data;
    public void append(BitArray bits) {
        this.data[this.length++]= bits;
    };
    public void append(LoopedFilter bits) {
        this.data[this.length++]= bits;
    };
};

private enum fgState : int {
    Symbols,
    FilterGen,
    SymEscape,
};

public RegexFilter genRegexFilter(string regexString) {
    import std.variant:var=Variant;
    RegexFilter result= RegexFilter();
    size_t i,j= regexString.length;
    fgState state;
    BitArray bits= BitArray(256);
    i--;
    while((i++)<j)switch(state) {
        case fgState.SymEscape:
            bits[regexString[++i]]= true;
            break;
        case fgState.FilterGen:
            bits[regexString[i]]= true;
            break;
        default:switch(regexString[i]) {
            case '[':
                state= fgState.FilterGen;
                break;
            case ']':
                state= fgState.Symbols;
                if(regexString[i +1]=='+') {
                    result.append(LoopedFilter(bits));
                } else {
                    result.append(bits);
                };
                break;
            default:
        };
    };
    return result;
};
