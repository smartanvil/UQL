generated
symbolNames
	^ #('"!"' '"~"' '"--"' '"delete"' '"["' '"%"' '"**"' '"++"' '"("' '"years"' '"}"' '"create"' '"collection"' '"*"' '"."' '";"' '"select"' '"/"' '"ethereum"' '"&&"' '"and"' '"||"' '"or"' '"=="' '")"' '","' '":"' '"!="' '">="' '"+"' '"<="' '">"' '"-"' '"="' '"<>"' '"<"' '"{"' '"not"' '"]"' '"is"' '"null"' '"wei"' '"limit"' '"mongodb"' '"between"' '"szabo"' '"days"' '"weeks"' '"minutes"' '"hours"' '"like"' '"finney"' '"ether"' '"seconds"' '"by"' '"order"' '"right"' '"intersect"' '"bitcash"' '"connection"' '"minus"' '"sql"' '"bitcoin"' '"litecoin"' '"union"' '"on"' '"domain"' '"left"' '"join"' '"where"' '"from"' '"in"' '"at"' '<decimalnumber>' '<hexnumber>' '<realnumber>' '<booleanliteral>' '<identifier>' '<url>' '<whitespace>' '<stringLiteral>' '<comment>' 'ExpressionList' 'FromStatement' 'DomainStatement' '( DomainStatement)' '( DomainStatement)?' 'WhereStatement' '( WhereStatement)' '( WhereStatement)?' 'OrderByStatement' '( OrderByStatement)' '( OrderByStatement)?' 'LimitStatement' '( LimitStatement)' '( LimitStatement)?' 'IdentifierLiteral' 'ConnectionType' 'UrlLiteral' 'UnionStatement' 'IntersectionStatement' 'MinusStatement' 'CreateStatement' 'SourceBind' 'Join' '( Join)' '( Join)*' 'MemberAccess' '( IdentifierLiteral MemberAccess)' '( IdentifierLiteral UrlLiteral)' '( "at" ( IdentifierLiteral UrlLiteral))' '( "at" ( IdentifierLiteral UrlLiteral))?' 'BooleanOperation' 'CompareOperation' '( BooleanOperation CompareOperation)' 'InnerJoin' 'LeftJoin' 'RightJoin' 'Expression' 'SelectStatement' 'TermExpression' 'ParenthesisBooleanExpression' 'ParenthesisCompareExpression' '( TermExpression BooleanOperation CompareOperation ParenthesisBooleanExpression ParenthesisCompareExpression)' 'BooleanOperable' 'NotOperation' 'OrOperation' 'AndOperation' '( "&&" "and")' 'CreateConnectionStatement' '( "!" "~")' 'ArithmeticOperation' 'Measure' 'ParenthesisArithmeticExpression' 'ArithmeticallyOperable' 'NegativeOperation' 'PowerOperation' 'MultiplyOperation' 'DivideOperation' 'ModuleOperation' 'SumOperation' 'SubstractOperation' '( TermExpression ArithmeticOperation ParenthesisArithmeticExpression Measure)' 'ComparisionOperable' 'LesserThanOperation' 'LesserEqualsThanOperation' 'GreaterThanOperation' 'GreaterEqualsThanOperation' '( LesserThanOperation LesserEqualsThanOperation GreaterThanOperation GreaterEqualsThanOperation)' 'EqualsToOperation' 'DifferentThanOperation' 'LikeOperation' 'InOperation' 'BetweenOperation' 'IsNullOperation' 'IsNotNullOperation' '( EqualsToOperation DifferentThanOperation LikeOperation InOperation BetweenOperation IsNullOperation IsNotNullOperation)' '( "==" "=")' '( "!=" "<>")' 'StringLiteral' 'TupleExpression' 'ParenthesisTupleExpression' 'ParenthesisTermExpression' 'ParenthesisExpression' 'Call' 'Access' 'Literal' 'ArrayAccess' 'MethodCall' 'FunctionCall' 'BooleanLiteral' 'NumberLiteral' '( "." IdentifierLiteral)' '( "." IdentifierLiteral)+' '( "." IdentifierLiteral)*' 'FunctionCallArguments' 'B e g i n' 'RootQuery' '( "||" "or")' '( Clause)*' '( Clause)' '( <realnumber> <hexnumber> <decimalnumber>)' 'Clause' 'NumberUnit' '( Expression)' '( Expression)?' '( "," ( Expression)?)' '( "," ( Expression)?)*' '( Expression ( "," ( Expression)?)*)' '( Expression ( "," ( Expression)?)*)?' '( "," ( Expression)?)+' 'NameValueList' '( NameValueList)' '( NameValueList)?' '( ExpressionList)' '( ExpressionList)?' '( "," IdentifierLiteral ":" Expression)' '( "," IdentifierLiteral ":" Expression)*' '( ",")' '( ",")?' '( "," Expression)' '( "," Expression)*' 'E O F' 'error' 'SetStatement' '( SetStatement SelectStatement)')