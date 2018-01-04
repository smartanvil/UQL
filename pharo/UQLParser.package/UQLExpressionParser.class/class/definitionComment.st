generated
definitionComment
"### Scanner part
<decimalnumber>: [0-9]+ ;
<hexnumber>: 0x[0-9a-fA-F]+ ;
<realnumber>: <decimalnumber>? [\.] <decimalnumber> ; #  added to support real numbers (not in the grammar but apear in the contracts)	
<booleanliteral> : true | false ;
<reservedkeywords>:  SELECT | FROM | IN | AT |LIMIT| PORT | WHERE  | ORDER | BY |  IS | AND | OR | NOT | CONTRACTS | TRANSACTIONS | BLOCKS | TYPE | ACCOUNTS | CONTRACT | ACTIVATED-METHODS | STAMP | CREATE | COLLECTION | DIRECTORY | REPOSITORY  | WEI ;
<identifier>: [a-zA-Z_$] [a-zA-Z_$0-9]* ;
<url>: [a-zA-Z_$] [a-zA-Z_$0-9]*[\:] [a-zA-Z_$/] [a-zA-Z_$0-9.@:/]* ;
<whitespace>: \s+ ;
<stringLiteral>: ( [""] ( [^""\r\n]  | ([ \\ ] . ) )* [""] ) 
               | ( ['] ( [^'\r\n]  | ([ \\ ] . ) )* ['] ) ;

<comment>
	: \/\/ [^\r\n]* 
	| /\*([^*]|[\r\n]|(\*+([^*/]|[\r\n])))*\*+/
	| -- [^\r\n]* 
 	;

### Directives 	
%root RootQuery;
%annotate_tokens;
%prefix UQL;
%suffix Node;
%left "")""  ;
#expression operators -- lowest precedence are first.
%left "","";
%right "":"";
%left ""||"" ""or"";
%left ""&&"" ""and"";
%left ""=="" ""!="" ""="" ""<>"";
%left ""<"" ""<="" "">"" "">="";
%left ""+"" ""-"";
%left ""*"" ""/"" ""%"";
%right ""**"";
%left ""++"" ""--""; 
%right ""delete"" ""!"" ""~"";
%right ""["" ""("";
%left ""."" ;

### Parser & AST Definition

RootQuery : ( Clause 'clause')* "";"" {{}} ;
Clause : SelectStatement | CreateStatement |SetStatement |CreateConnectionStatement;



SelectStatement: ""select"" ExpressionList 'binding' FromStatement 'from' (DomainStatement 'domain')?  ( WhereStatement  'where')? (OrderByStatement 'orderBy')? (LimitStatement 'limit')?  {{}};



CreateStatement: ""create"" ""collection"" IdentifierLiteral 'name' ""{"" SelectStatement 'selection' ""}"" {{}};

ConnectionType:  ""ethereum"" | ""mongodb""  | ""sql"" |  ""bitcoin"" | ""litecoin"" | ""bitcash"" {{}};

CreateConnectionStatement: ""create""  ConnectionType 'type'   ""connection"" IdentifierLiteral 'name'  UrlLiteral 'url' {{}};

SetStatement: UnionStatement | IntersectionStatement | MinusStatement;

UnionStatement:   ""("" (SetStatement |SelectStatement) 'left_collection' "")""  ""union""  ""("" (SetStatement | SelectStatement) 'right_collection' "")""   {{}};
IntersectionStatement:   ""("" (SetStatement |SelectStatement) 'left_collection' "")""  ""intersect""  ""("" (SetStatement | SelectStatement) 'right_collection' "")""   {{}};
MinusStatement:   ""("" (SetStatement |SelectStatement) 'left_collection' "")""  ""minus""  ""("" (SetStatement | SelectStatement) 'right_collection' "")""   {{}};


DomainStatement: ""domain"" UrlLiteral 'url' {{}};

FromStatement: ""from"" SourceBind 'base_source' (Join 'sources')* {{}};

SourceBind: IdentifierLiteral 'binding' ""in"" (IdentifierLiteral | MemberAccess) 'buffer_name' ( ""at"" (IdentifierLiteral | UrlLiteral ) 'database' )? {{}};

WhereStatement: ""where""  (BooleanOperation | CompareOperation) 'expression' {{}};

InnerJoin: ""join"" SourceBind 'joined_source' ""on"" (BooleanOperation | CompareOperation) 'expression' {{}};
LeftJoin: ""left"" ""join"" SourceBind 'joined_source' ""on"" (BooleanOperation | CompareOperation) 'expression' {{}};
RightJoin: ""right"" ""join"" SourceBind 'joined_source' ""on"" (BooleanOperation | CompareOperation) 'expression' {{}};
Join: InnerJoin | LeftJoin | RightJoin;


OrderByStatement: ""order"" ""by"" Expression 'expression' {{}};

LimitStatement: ""limit"" <decimalnumber> 'amount' {{}};


### Booleans! 
	BooleanOperable: 
		(TermExpression | BooleanOperation | CompareOperation | ParenthesisBooleanExpression | ParenthesisCompareExpression);

	BooleanOperation:
		NotOperation
		| OrOperation 
		| AndOperation  ;

	AndOperation:
		BooleanOperable 'left_exp' (""&&""|""and"")  BooleanOperable 'right_exp' {{}};
	OrOperation:
		 BooleanOperable 'left_exp' (""||""|""or"") BooleanOperable 'right_exp' {{}};
	NotOperation:	
		 (""!"" | ""~"" ) BooleanOperable 'exp' {{}};


### Arithmetics! 
	ArithmeticallyOperable: 
		ArithmeticOperation | TermExpression | Measure | ParenthesisArithmeticExpression  ;

	ArithmeticOperation: 
		NegativeOperation 
		| PowerOperation 
		| MultiplyOperation| DivideOperation | ModuleOperation
		| SumOperation | SubstractOperation ;

	NegativeOperation: 
		""-"" 'operator'  ArithmeticallyOperable 'exp' {{}};
	PowerOperation: 
		ArithmeticallyOperable 'left_exp' ""**"" 'operator' ArithmeticallyOperable 'right_exp' {{}};
	MultiplyOperation: 
		ArithmeticallyOperable 'left_exp' ""*""   'operator' ArithmeticallyOperable 'right_exp' {{}};
	DivideOperation: 
		ArithmeticallyOperable 'left_exp'  ""/""  'operator' ArithmeticallyOperable 'right_exp' {{}};
	ModuleOperation: 
		ArithmeticallyOperable 'left_exp'  ""%""  'operator' ArithmeticallyOperable 'right_exp' {{}};
	SumOperation: 
		ArithmeticallyOperable 'left_exp'  ""+""  'operator' ArithmeticallyOperable 'right_exp' {{}};
	SubstractOperation: 
		ArithmeticallyOperable 'left_exp'  ""-""  'operator' ArithmeticallyOperable 'right_exp' {{}};

### Comparisions!
ComparisionOperable: 
	(TermExpression | ArithmeticOperation |  ParenthesisArithmeticExpression | Measure  ); 

CompareOperation: 
	(LesserThanOperation | LesserEqualsThanOperation | GreaterThanOperation| GreaterEqualsThanOperation)
	|(EqualsToOperation | DifferentThanOperation | LikeOperation | InOperation | BetweenOperation | IsNullOperation | IsNotNullOperation  );


LesserThanOperation: 
	ComparisionOperable 'left_exp' ""<""   ComparisionOperable 'right_exp' {{}};
LesserEqualsThanOperation: 
	ComparisionOperable 'left_exp' ""<=""   ComparisionOperable 'right_exp' {{}};
GreaterThanOperation: 
	ComparisionOperable 'left_exp' "">""  ComparisionOperable 'right_exp' {{}};
GreaterEqualsThanOperation: 
	ComparisionOperable 'left_exp' "">="" ComparisionOperable 'right_exp' {{}};
EqualsToOperation: 
	ComparisionOperable 'left_exp' (""=="" | ""="")  ComparisionOperable 'right_exp' {{}};
DifferentThanOperation: 
	ComparisionOperable 'left_exp' (""!="" | ""<>"")   ComparisionOperable 'right_exp' {{}};
LikeOperation: 
	ComparisionOperable 'left_exp' ""like"" StringLiteral 'right_exp' {{}};
InOperation: 
	ComparisionOperable 'left_exp' ""in""  TupleExpression 'right_exp' {{}};
BetweenOperation: 
	ComparisionOperable 'left_exp' ""between""  ComparisionOperable 'left_guard' ""and"" ComparisionOperable 'right_guard' {{}};
IsNullOperation: 
	TermExpression 'expression' ""is"" ""null""   {{}};
IsNotNullOperation: 
	TermExpression 'left_exp' ""is"" ""not"" ""null"" {{}};



ParenthesisArithmeticExpression: ""("" ArithmeticOperation 'exp' "")""  {{}};
ParenthesisBooleanExpression: ""("" BooleanOperation 'exp' "")""  {{}};
ParenthesisCompareExpression: ""("" CompareOperation 'exp' "")""  {{}};
ParenthesisTupleExpression: ""("" TupleExpression 'exp' "")""  {{}};
ParenthesisTermExpression: ""("" TermExpression 'exp' "")""  {{}};



ParenthesisExpression: 
	ParenthesisArithmeticExpression | ParenthesisBooleanExpression | ParenthesisCompareExpression | ParenthesisTupleExpression | ParenthesisTermExpression;



Expression :  
	ParenthesisExpression
	| ArithmeticOperation
	| CompareOperation
	| BooleanOperation
	| TupleExpression
	| TermExpression 
	;

TermExpression
	: Call 
	| Access 
	| Literal ;


Access
	: MemberAccess
	| ArrayAccess;


Call	
         : MethodCall
	| FunctionCall;


Literal
	: IdentifierLiteral
	| BooleanLiteral
	| StringLiteral
	| NumberLiteral
	| UrlLiteral;

MemberAccess
	: IdentifierLiteral  'value'  ( "".""  IdentifierLiteral  'member' ) +  {{}}
	| FunctionCall 'value' ( "".""  IdentifierLiteral  'member' ) +  {{}} 
	| MethodCall 'value' ( "".""  IdentifierLiteral 'member' ) +  {{}};

ArrayAccess 
	: IdentifierLiteral 'value' ""["" Expression 'access' ""]"" {{}}
	| IdentifierLiteral 'value'  ( "".""   IdentifierLiteral  'member' ) +  ""["" Expression 'access' ""]""  {{}}
	| FunctionCall 'value'  ( "".""  IdentifierLiteral 'member' ) *  ""["" Expression 'access' ""]""  {{}}
	| MethodCall 'value'  ( "".""  IdentifierLiteral 'member' ) *  ""["" Expression 'access' ""]""  {{}};

FunctionCall
	: IdentifierLiteral 'selector'  ""("" FunctionCallArguments 'arguments' "")""  {{}} ;

MethodCall
	: IdentifierLiteral 'value'  "".""  IdentifierLiteral 'selector' ""("" FunctionCallArguments 'arguments' "")""  {{}}
	| IdentifierLiteral 'value'  ( ""."" IdentifierLiteral 'member' ) + "".""   IdentifierLiteral 'selector' ""("" FunctionCallArguments 'arguments' "")"" {{}} 
	| NumberLiteral 'value' ( ""."" IdentifierLiteral 'member' ) * ""."" IdentifierLiteral 'selector' ""("" FunctionCallArguments 'arguments' "")"" {{}} 
	| StringLiteral 'value'  ( ""."" IdentifierLiteral 'member' ) * "".""   IdentifierLiteral'selector' ""("" FunctionCallArguments 'arguments' "")""  {{}}
	| FunctionCall 'value'  ( ""."" IdentifierLiteral 'member' ) * "".""   IdentifierLiteral 'selector' ""("" FunctionCallArguments 'arguments' "")""  {{}} 
	| MethodCall 'value'  ( ""."" IdentifierLiteral 'member' ) *  "".""   IdentifierLiteral 'selector' ""("" FunctionCallArguments 'arguments' "")""  {{}} ;

IdentifierLiteral 
	: <identifier> 'value' {{}};

BooleanLiteral
	: <booleanliteral> 'value' {{}};

StringLiteral
 	: <stringLiteral> 'value' {{}};

NumberLiteral 
	: ( <realnumber> | <hexnumber> | <decimalnumber> ) 'value' {{}};

UrlLiteral
	: <url> 'value' {{}};


Measure:
	NumberLiteral 'value' NumberUnit 'unit' {{}};
NumberUnit 
	: ""wei"" 
	| ""szabo""
	| ""finney"" 
	| ""ether""
	| ""seconds"" 
	| ""minutes"" 
	| ""hours"" 
	| ""days"" 
	| ""weeks"" 
	| ""years""
	;
TupleExpression 
	: ""["" ( Expression 'exp' ( "","" (Expression 'exp')?  )*  )? ""]"" {{}}	
 	| ""("" ( Expression 'exp' ( "","" (Expression 'exp')?  )*  )? "")"" {{}} 
	| ""["" ("","" (Expression 'exp')? )+ ""]"" {{}}
	| ""("" ("","" (Expression 'exp')? )+ "")"" {{}}
         ; 
FunctionCallArguments 
	: ""{"" (NameValueList 'name_value_list')? ""}"" {{}} 
	| (ExpressionList 'exp_list') ? {{}} 
	;

NameValueList 
	: IdentifierLiteral 'id' "":"" Expression 'exp' ( "","" IdentifierLiteral 'id' "":"" Expression 'exp' )* ("","")? {{}}
	;
ExpressionList
	: Expression 'exp' ( "","" Expression 'exp' )* {{}}
	;"