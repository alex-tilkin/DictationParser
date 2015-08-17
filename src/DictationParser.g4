grammar DictationParser;

/* Parser */

// Top
command: creationCommand | navigationCommand | selectionCommand | modificationCommand | deletionCommand | invocationCommand;

// Creation Layer
creationCommand: creationVerb? (AN | A)? (createField | createMethod | createConstructor | createDataType | createBlock | createLoop) elementLocation?;
creationVerb: CREATE | NEW | OPEN;
createField: fieldModifier? fieldRef;
createMethod: modifier? (METHOD | FUNCTION) namedElement ((THAT_ACCEPTS | WITH) parametersList)? (returnsVars Element)?;
createConstructor: modifier? CONSTRUCTOR ((THAT_ACCEPTS | WITH) parametersList)?;
createDataType: modifier? (INNER)? dataType namedElement ((implementsVars | extendsVars) Element)?;
createBlock: BLOCK | createBlockStatement;
createBlockStatement: localVariableDeclaration | statement;
createLoop: createForEachLoop | createWhileLoop | createDoWhileLoop | createForLoop;
createForEachLoop: FOR_EACH Element IN Element command?;
createWhileLoop: WHILE expression DO? command?;
createDoWhileLoop: DO command WHILE expression;
createForLoop: FOR ;
/*forControl
    :   enhancedForControl
    |   forInit? ';' expression? ';' forUpdate?
    ;

forInit
    :   localVariableDeclaration
//    |   expressionList
    ;*/

// Navigation Layer
navigationCommand: navigationVerb (dataType | FIELD | METHOD)? Element | exitCommand;
navigationVerb: GO_TO | WE_ARE_DONE_WITH;
exitCommand: (EXIT | QUIT) (elementRef | (dataType | FIELD | METHOD)? Element);
exit: WE_ARE_DONE_WITH | EXIT;

// Modification Layer
modificationCommand: modifyAccessLevel;
modifyAccessLevel: modificationVerb accessLevel;
modificationVerb: MAKE_IT | CHANGE_IT;

// Selection Layer
selectionCommand: (NUMBER | OPTION)? number;

// Deletion Layer
deletionCommand: (DELETE | REMOVE) (line | elementRef);

// Invocation Layer
invocationCommand: CALL? Element (OF Element)?;

// Common Layer
fieldModifier: FINAL? modifier TRANSIENT? VOLATILE?;
variableModifier: FINAL | STATIC;
modifier: ABSTRACT? STATIC? accessLevel;
accessLevel: PRIVATE | PUBLIC | PROTECTED;
localVariableDeclaration: variableModifier* elementsName OF_TYPE Element;
statement: expression | RETURN expression? | TRY CATCH | THROW expression;
    /*
    |   ASSERT expression (':' expression)?;
    |   'if' parExpression statement ('else' statement)?
    |   'for' '(' forControl ')' statement
    |   'while' parExpression statement
    |   'do' statement 'while' parExpression
    |   'try' block (catchClause+ finallyBlock? | finallyBlock)
    |   'try' resourceSpecification block catchClause* finallyBlock?
    |   'switch' parExpression '{' switchBlockStatementGroup* switchLabel* '}'
    |   'synchronized' parExpression block
    |   'break' Identifier?
    |   'continue' Identifier?
    |   statementExpression
    |   Identifier ':' statement
    ;*/

expression: primary |
            expression (plusVars plusVars | minusVars minusVars) |
            expression AND expression |
            expression OR expression |
            (plusVars | minusVars | plusVars plusVars | minusVars minusVars) expression |
            expression (equalsVars | isDifferentVars | lessThanEqualsVars | greaterThanEqualVars | greaterThanVars | lessThanVars | IS_NOT | IS) expression |
            IF expression (equalsVars | isDifferentVars | lessThanEqualsVars | greaterThanEqualVars | greaterThanVars | lessThanVars | IS_NOT | IS) expression THEN command (ELSE command)? |
            NEW (expression | elementRef) |
            ASSIGN expression TO expression;

 //    |   expression '.' Identifier
 //    |   expression '.' 'this'
 //    |   expression '.' 'new' nonWildcardTypeArguments? innerCreator
 //    |   expression '.' 'super' superSuffix
 //    |   expression '.' explicitGenericInvocation
 //    |   expression '[' expression ']'
 //    |   expression '(' expressionList? ')'
 //    |   NEW creator
 //    |   '(' type ')' expression
 //    |   ('~'|'!') expression
 //    |   expression ('*'|'/'|'%') expression
 //    |   expression ('+'|'-') expression
//expression ('<' '<' | '>' '>' '>' | '>' '>') expression
 //    |   expression 'instanceof' type
 //    |   expression '^' expression
 //    |   expression '?' expression ':' expression
 //    |   <assoc=right> expression
 //        (   '='
 //        |   '+='
 //        |   '-='
 //        |   '*='
 //        |   '/='
 //        |   '&='
 //        |   '|='
 //        |   '^='
 //        |   '>>='
 //        |   '>>>='
 //        |   '<<='
 //        |   '%='
 //        )
 //        expression
primary: OPEN_PARENTHESES expression? | Element (OF Element)? | number;
elementLocation: locationRef (elementRef | line);
fieldRef:  FIELD (elementsName? OF_TYPE Element | OF_TYPE Element namedElement | elementsName);
elementRef: classRef | fieldRef | enumRef | interfaceRef | unspecifiedRef;
classRef: CLASS Element;
namedElement: reference? elementsName;
elementsName: (Element AND)* Element;
enumRef: ENUM Element;
interfaceRef: INTERFACE Element;
unspecifiedRef: Element;
reference: NAMED | CALLED;
locationRef: INSIDE | IN | AFTER | BEFORE | ABOVE | BELOW;
parametersList: (parameter AND)* parameter;
parameter: Element OF_TYPE Element;
dataType: CLASS | ENUM | INTERFACE;
line: LINE NUMBER? number;

// Forms of Expressions
returnsVars: THAT_RETURNS | RETURNS | RETURN;
implementsVars: IMPLEMENTS | IMPLEMENT | THAT_IMPLEMENTS;
extendsVars: EXTENDS | EXTEND | THAT_EXTENDS;
number: Number | ZERO | ONE | TWO | THREE | FOUR | FIVE | SIX | SEVEN | EIGHT | NINE;
plusVars: PLUS | MATH_PLUS;
minusVars: MINUS | MATH_MINUS;
equalsVars: IS_EQUAL_TO | EQUAL_TO | EQUALS_TO | EQUALS | IS_EQUALS;
isDifferentVars: IS_DIFFERENT_FROM | DIFFERENT_FROM;
lessThanVars: LESS_THAN | LESS_THAN_MATH | IS_LESS_THAN;
lessThanEqualsVars: LESS_THAN_EQUAL | LESS_THAN_EQUAL_MATH | LESS_THAN_EQUAL_MATH_SPACE;
greaterThanVars: GREATER_THAN | GREATER_THAN_MATH | IS_GREATER_THAN;
greaterThanEqualVars: GREATER_THAN_EQUAL | GREATER_THAN_EQUAL_MATH | GREATER_THAN_EQUAL_MATH_SPACE;

/* Lexer */

// Language idioms
METHOD: 'method';
FUNCTION: 'function';
CONSTRUCTOR: 'constructor';
FIELD: 'field';
BLOCK: 'block';

// Orientation
INSIDE: 'inside';
IN: 'in';
AFTER: 'after';
BEFORE: 'before';
ABOVE: 'above';
BELOW: 'below';
INNER: 'inner';

// Reference
OF_TYPE: 'of type';
NEW: 'new';
NAMED: 'named';
CALLED: 'called';
LINE: 'line';
NUMBER: 'number';
OPTION: 'option';
AN: 'an';
A: 'a';
THAT_ACCEPTS: 'that accepts';
WITH: 'with';
AND: 'and';
OR: 'or';
TO: 'to';

// Commands
GO_TO: 'go to';
EXIT: 'exit';
QUIT: 'quit';
WE_ARE_DONE_WITH: 'we are done with';
MAKE_IT: 'make it';
CHANGE_IT: 'change it to';
CREATE: 'create';
OPEN: 'open';
OPEN_PARENTHESES: 'open pranteces';
CALL: 'call';
OF: 'of';
DELETE: 'delete';
REMOVE: 'remove';
ASSIGN: 'assign';

// Operators
PLUS: 'plus';
MATH_PLUS: '+';
MINUS: 'minus';
MATH_MINUS: '-';
IS: 'is';
IS_NOT: 'is not';

IS_EQUAL_TO: 'is equal to';
EQUAL_TO: 'equal to';
EQUALS_TO: 'equals to';
EQUALS: 'equals';
IS_EQUALS: 'is equals';

IS_DIFFERENT_FROM: 'is different from';
DIFFERENT_FROM: 'different from';

LESS_THAN: 'less than';
LESS_THAN_MATH: '<';
IS_LESS_THAN: 'is less than';

LESS_THAN_EQUAL: 'less than equal';
LESS_THAN_EQUAL_MATH: '<=';
LESS_THAN_EQUAL_MATH_SPACE: '< =';

GREATER_THAN: 'greater than';
GREATER_THAN_MATH: '>';
IS_GREATER_THAN: 'is greater than';

GREATER_THAN_EQUAL: 'greater than equal';
GREATER_THAN_EQUAL_MATH: '>=';
GREATER_THAN_EQUAL_MATH_SPACE: '> =';

IF: 'if';
THEN: 'then';
ABSTRACT      : 'abstract';
ASSERT        : 'assert';
//BREAK         : 'break';
//CASE          : 'case';
CATCH         : 'catch';
CLASS         : 'class';
//CONST         : 'const';
//CONTINUE      : 'continue';
//DEFAULT       : 'default';
DO            : 'do';
ELSE          : 'else';
ENUM          : 'enum';
EXTENDS       : 'extends';
EXTEND: 'extend';
THAT_EXTENDS: 'that extends';
FINAL         : 'final';
//FINALLY       : 'finally';
FOR           : 'for';
IMPLEMENTS    : 'implements';
THAT_IMPLEMENTS: 'that implements';
IMPLEMENT: 'implement';
//IMPORT        : 'import';
//INSTANCEOF    : 'instanceof';
INTERFACE     : 'interface';
//NATIVE        : 'native';
//PACKAGE       : 'package';
PRIVATE       : 'private';
PROTECTED     : 'protected';
PUBLIC        : 'public';
STATIC        : 'static';
//STRICTFP      : 'strictfp';
SUPER         : 'super';
//SWITCH        : 'switch';
//SYNCHRONIZED  : 'synchronized';
THROW         : 'throw';
THROWS        : 'throws';
TRANSIENT     : 'transient';
TRY           : 'try';
VOID          : 'void';
VOLATILE      : 'volatile';
WHILE         : 'while';
FOR_EACH: 'for each' | 'foreach';
THAT_RETURNS: 'that returns';
RETURNS: 'returns';
RETURN: 'return';

// Figures
ZERO: 'zero';
ONE: 'one';
TWO: 'two';
THREE: 'three';
FOUR: 'four';
FIVE: 'five';
SIX: 'six';
SEVEN: 'seven';
EIGHT: 'eight';
NINE: 'nine';

// Lexer Core
Number: [0-9]+;
Element: [a-z0-9\-]+;
WS  :  [ \t\r\n\u000C]+ -> skip;