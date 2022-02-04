module d.internals.fe.lexer.Test;
import d.internals.fe.lexer;
import std.stdio:writeln;

enum TokenQuery {
    @(null    ,TokenGroup.litteral  ,""              ) NULL= 0,
    @(null    ,TokenGroup.whitespace,"[ \\r\\t\\n]"  ) WhiteSpace,
    @(null    ,TokenGroup.litteral  ,"[0-9]"         ) Number,
    @(null    ,TokenGroup.litteral  ,"[A-Za-z]"      ) Letter,
    @(null    ,TokenGroup.litteral  ,"[+\\-\\*/;]"   ) Operator,
    @(null    ,TokenGroup.litteral  ,"[\\[\\]\\{\\}]") Braket,
    @(null    ,TokenGroup.litteral  ,"[\\(\\)]"      ) Parenthese,
    @(null    ,TokenGroup.litteral  ,"[\"]"          ) Quote,
    @("null"  ,TokenGroup.builtin   ,""              ) Builtin_Null,
    @("if"    ,TokenGroup.keyword   ,""              ) KW_If,
    @("+"     ,TokenGroup.op        ,""              ) Op_Plus,
    @("-"     ,TokenGroup.op        ,""              ) Op_Dash,
    @("import",TokenGroup.keyword   ,""              ) KW_Import,
    @(null    ,TokenGroup.exception ,""              ) OutOfBoundsException= -1,
};

enum TokenPatturn {
    @(null) NULL= 0,
    @([Letter]                 ,[identifier,Letter,Number]) identifier,
    @([Quote,Number,Parenthese],[                        ]) value,
};
/**
 * TokenPattern | (start)  | (loop)   | [name]
 * ===============================================
 * b1           | a3       | b1 a3 a2 | identifier
 * -----------------------------------------------
 * b2           | a2 a6 a7 | none     | value
 * ---------------------------------------------
 * b3           | a4       | a1       | operator
**/

string code= `module main;
import std.stdo;
import std.string;
fun main:void(ArgV:string[]) {
    writeln("Hello world.  ");
};
`;
unittest {
	LexerCore.setQueryArray!TokenQuery;
	// writeln(tokenQuery);
	Source std_code= Source(File("./playground.d"), code);
	std_code.tokenQuery= Token.query;
	writeln(std_code._indexesOf());
	writeln("/-----");
	// foreach(_Tmp_00; std_code.data) {
	//     Token c= std_code.nextChar();
	//     writeln("'",c,"' ",c.charType.name);
	// };
	foreach(_Tmp_00; [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15]) {
		Token c= std_code.nextToken();
		writeln("'",c,"' ",c.charType.name);
		static if(DevSettings.showInfo) string cVal= c.getText();
	};
	writeln("\\-----");
};
