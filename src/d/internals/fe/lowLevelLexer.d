module d.internals.fe.lowLevelLexer;
import std.conv:to;
import std.regex:matchFirst;
import std.stdio:writeln;
import std.string:indexOf;
import std.meta:AliasSeq;
import std.traits:EnumMembers;
enum DevSettings {
    showInfo= true,
};
enum TokenGroup {
    builtin= "builtinVal",
    keyword= "keyword",
    op= "operator",
    litteral= "litteral",
    exception= "Exception",
    whitespace= "WhiteSpace",
};
public class LexerCore {
    public static void setQueryArray(T)() {
        TokenType tokenQueryElem;
        static foreach(size_t index, string member; __traits(allMembers, T)) {
            tokenQueryElem= TokenType(
            __traits(getAttributes, __traits(getMember, T, member)),
            member, index);
            Token.query ~= [tokenQueryElem];
            // writeln(tokenQueryElem);
        };
    };
    // static this() {
    //     LexerCore.qTkn();
    // };
};
struct TokenType {
    public string query;
    public string id;
    public string regex;
    public string name;
    public int type;
};
struct Token {
    public static TokenType[] query;
    public Source code;
    public uint start;
    public uint stop;
    public TokenType charType;   //   Utility for lexer.
    public size_t type;   //   Utility for lexer.
    public string getText() {
        this.charType= this.getCharType();
        this.type= this.charType.type;
        return this.code.data[this.start..this.stop];
    };
    public string toString() {
        return this.getText();
    };
    public TokenType getCharType() {//   writeln(__LINE__,"   //ToDo:   Fix this.  ");
        // static if(DevSettings.showInfo) query= Token.query;
        foreach(i, tq; Token.query[1..$]) {
            if(matchFirst(this.code.data[(this.start)..(this.start +1)], tq.regex).length>0)return tq;
        };
        return query[0];
    };
    public bool charTypeEquals(immutable(char) c) {   writeln(__LINE__,"   //ToDo:   Fix this.  ");
    return matchFirst([c], this.charType.regex).length>0;
    };
    public TokenType getCharTokenType(immutable(char) c) {
        foreach(i, tq; this.query[1..$]) {
            if(matchFirst(this.code.data[(this.start)..(this.start +1)], tq.regex).length>0)return tq;
        };
        return this.query[0];
    };
    public TokenType peekNextCharQuery() {
        foreach(i, tq; this.query[1..$]) {
            if(matchFirst([this.code.data[this.stop]], tq.regex).length>0)return tq;
        };
        return this.query[0];
    };
};
struct File {
    import std.file:_read=read;
    public string path;
    public this(string filePath) {
        this.path= filePath;
    };
    public string read() {
        return cast(immutable(char[])) _read(this.path);
    };
};
struct Source {
    public File file;
    public string data;
    public uint cursor;
    TokenType[] tokenQuery;
    public this(File file) {
        this.file= file;
        this.data= file.read();
    };
    public this(File file, string data) {
        this.file= file;
        this.data= data;
    };
    public Token nextChar() {
        Token result= Token(this, this.cursor++, this.cursor);
        result.charType= result.getCharType();
        return result;
    };
    public Token newToken() {   writeln(__LINE__,"   //ToDo:   Fix this.  ");
    uint nextCursor= this.cursor +1;
    Token result= Token(this, this.cursor, nextCursor);
    this.cursor= nextCursor;
    return result;
    };
    public long[] _indexesOf_00() {
        size_t[] result= [];
        Token c= Token(this, this.cursor, cast(uint) this.data.length);
        foreach(i, q; Token.query) {
            if(q.query=="") {
                result ~= [-2];
                continue;
            };
            result ~= [c.getText().indexOf(q.query)];
        };
        return cast(long[]) result;
    };
    public long[] _indexesOf() {
        return this._indexesOf_00();
    };
    public Token nextToken() {
        int _ail_00= 400;
        Token c,result= this.nextChar();
        static if(DevSettings.showInfo) {
            string resultVal= result.getText();
            size_t resultType= result.type;
        };
        while(_ail_00--){
            c= this.nextChar();
            static if(DevSettings.showInfo) {
                char cVal= c.getText()[0];
                size_t cType= result.type;
            };
            if(c.type!=result.type)break;
        };
        this.cursor--;
        result.stop= this.cursor;
        return result;
    };
};

struct TokenArray {
    public Token[] tokens;   //   tokens= [['letter',code[0]]];
    public this(Source code) {   writeln(__LINE__,"   //ToDo:   Fix this.  ");   //   def lexer(code):
    this.tokens ~= [code.newToken()];
    this.tokens ~= [code.nextToken()];   //   for c in code:
    };
};
