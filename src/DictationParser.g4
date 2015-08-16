grammar DictationParser;

/* Parser */

// Top
command: creationCommand | navigationCommand | selectionCommand | modificationCommand | deletionCommand | invokationCommand;

// Creation Layer
creationCommand: creationVerb? (AN | A)? (createField | createMethod | createConstructor | createDataType | createBlock | createLoop) elementLocation?;
creationVerb: CREATE | NEW | OPEN;
createField: fieldModifier? fieldRef;
createMethod: modifier? (METHOD | FUNCTION) namedElement ((THAT_ACCEPTS | WITH) parametersList)? (return Element)?;
createConstructor: modifier? CONSTRUCTOR ((THAT_ACCEPTS | WITH) parametersList)?;
createDataType: modifier? (INNER)? dataType namedElement ((implements | extends) Element)?;
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
navigationVerb: GO_TO | WE_ARE_DONE_WIT;
exitCommand: (EXIT | QUIT) (elementRef | (dataType | FIELD | METHOD)? Element);
exit: WE_ARE_DONE_WIT | EXIT;

// Modification Layer
modificationCommand: modifyAccessLevel;
modifyAccessLevel: modificationVerb accessLevel;
modificationVerb: MAKE_IT | CHANGE_IT;

// Selection Layer
selectionCommand: (NUMBER | OPTION)? number;

// Deletion Layer
deletionCommand: (DELETE | REMOVE) (line | elementRef);

// Invocation Layer
invokationCommand: CALL? Element (OF Element)?;

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
            expression (PLUS PLUS | MINUS MINUS) |
            expression AND expression |
            expression OR expression |
            (PLUS | MINUS | PLUS PLUS | MINUS MINUS) expression |
            expression (IS_EQUAL | IS_DIFFERENT | LESS_THAN_EQUAL | GREATER_THAN_EQUAL | GREATER_THAN | LESS_THAN | IS_NOT | IS) expression |
            IF expression (IS_EQUAL | IS_DIFFERENT | LESS_THAN_EQUAL | GREATER_THAN_EQUAL | GREATER_THAN | LESS_THAN | IS_NOT | IS) expression THEN command (ELSE command)? |
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
primary: OPEN_PRANTECES expression? | Element (OF Element)? | number;
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
return: THAT_RETURNS | RETURNS | RETURN;
implements: IMPLEMENTS | IMPLEMENT | THAT_IMPLEMENTS;
extends: EXTENDS | EXTEND | THAT_EXTENDS;
number: Number | ZERO | ONE | TWO | THREE | FOUR | FIVE | SIX | SEVEN | EIGHT | NINE;
plus: PLUS | MATH_PLUS;
minus: MINUS | MATH_MINUS;

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
WE_ARE_DONE_WIT: 'we are done with';
MAKE_IT: 'make it';
CHANGE_IT: 'change it to';
CREATE: 'create';
OPEN: 'open';
OPEN_PRANTECES: 'open pranteces';
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
IS_EQUAL: 'is equal to' | 'equal to' | 'equals to' | 'equals' | 'is equals';
IS_DIFFERENT: 'is different from' | 'different from';
LESS_THAN: 'less than' | '<' | 'is less than';
LESS_THAN_EQUAL: 'less than equal' | '<=' | '< =';
GREATER_THAN: 'greater than' | '>' | 'is greater than';
GREATER_THAN_EQUAL: 'greater than equal' | '>=' | '> =';
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
Number: [0-9]+;
Element: [a-z0-9\-]+;
WS  :  [ \t\r\n\u000C]+ -> skip;