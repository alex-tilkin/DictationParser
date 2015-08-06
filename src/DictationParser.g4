grammar DictationParser;

/* Parser */

// Top
command: creationCommand | navigationCommand | selectionCommand | modificationCommand | deletionCommand | invokationCommand;

// Creation Layer
creationCommand: creationVerb? (AN | A)? (createField | createMethod | createConstructor | createDataType | createBlock | createLoop) elementLocation?;
creationVerb: CREATE | NEW | OPEN;
createField: fieldModifier? fieldRef;
createMethod: modifier? (METHOD | FUNCTION) namedElement ((THAT_ACCEPTS | WITH) parametersList)?;
createConstructor: modifier? CONSTRUCTOR ((THAT_ACCEPTS | WITH) parametersList)?;
createDataType: modifier? (INNER)? dataType namedElement;
createBlock: BLOCK | createBlockStatement;
createBlockStatement: localVariableDeclaration | statement;
createLoop: createForLoop | createWhileLoop | createDoWhileLoop | createForEachLoop;
createForEachLoop: FOR_EACH ;
FOR_EACH: 'for each' | 'foreach';
/*createForLoop: FOR ;
forControl
    :   enhancedForControl
    |   forInit? ';' expression? ';' forUpdate?
    ;

forInit
    :   localVariableDeclaration
//    |   expressionList
    ;*/
createWhileLoop:;
createDoWhileLoop:;
createForEachLoop:;

// Navigation Layer
navigationCommand: navigationVerb (dataType | FIELD | METHOD)? ElementName | exitCommand;
navigationVerb: GO_TO | WE_ARE_DONE_WIT;
exitCommand: (EXIT | QUIT) elementRef;
exit: WE_ARE_DONE_WIT | EXIT;

// Modification Layer
modificationCommand: modifyAccessLevel;
modifyAccessLevel: modificationVerb accessLevel;
modificationVerb: MAKE_IT | CHANGE_IT;

// Selection Layer
selectionCommand: (NUMBER | OPTION)? Number;

// Deletion Layer
deletionCommand: (DELETE | REMOVE) (line | elementRef);

// Invocation Layer
invokationCommand: CALL? ElementName (OF ElementName);

// Common Layer
fieldModifier: FINAL? modifier TRANSIENT? VOLATILE?;
variableModifier: FINAL | STATIC;
modifier: STATIC? accessLevel;
accessLevel: PRIVATE | PUBLIC | PROTECTED;
localVariableDeclaration: variableModifier* elementsName OF_TYPE ElementType;
statement: expression;// | ASSERT expression (':' expression)?;
    /*|   'if' parExpression statement ('else' statement)?
    |   'for' '(' forControl ')' statement
    |   'while' parExpression statement
    |   'do' statement 'while' parExpression
    |   'try' block (catchClause+ finallyBlock? | finallyBlock)
    |   'try' resourceSpecification block catchClause* finallyBlock?
    |   'switch' parExpression '{' switchBlockStatementGroup* switchLabel* '}'
    |   'synchronized' parExpression block
    |   'return' expression?
    |   'throw' expression
    |   'break' Identifier?
    |   'continue' Identifier?
    |   statementExpression
    |   Identifier ':' statement
    ;*/
expression: primary |
            expression (PLUS_PLUS | MINUS_MINUS) |
            expression (IS_EQUAL | IS_DIFFERENT) expression |
            expression AND expression |
            expression OR expression |
            (PLUS | MINUS | PLUS_PLUS | MINUS_MINUS) expression |
            expression (LESS_THAN_EQUAL | GREATER_THAN_EQUAL | GREATER_THAN | LESS_THAN) expression |
            IF expression (IS_EQUAL | IS_DIFFERENT | LESS_THAN_EQUAL | GREATER_THAN_EQUAL | GREATER_THAN | LESS_THAN) expression THEN expression
            (ELSE expression)?;

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
primary: OPEN_PRANTECES expression | ElementName;
/*    :   '(' expression ')'
    |   'this'
    |   'super'
    |   literal
    |   type '.' 'class'
    |   'void' '.' 'class'
    |   nonWildcardTypeArguments (explicitGenericInvocationSuffix | 'this' arguments)
    ;*/

elementLocation: locationRef (elementRef | line);
fieldRef:  FIELD (elementsName? OF_TYPE ElementType | OF_TYPE ElementType namedElement | elementsName);
elementRef: classRef | fieldRef | enumRef | interfaceRef | unspecifiedRef;
classRef: CLASS ElementName;
namedElement: reference? elementsName;
elementsName: (ElementName AND)* ElementName;
enumRef: ENUM ElementName;
interfaceRef: INTERFACE ElementName;
unspecifiedRef: ElementName;
reference: NAMED | CALLED;
locationRef: INSIDE | IN | AFTER | BEFORE | ABOVE | BELOW;
parametersList: (parameter AND)* parameter;
parameter: ElementName OF_TYPE ElementType;
dataType: CLASS | ENUM | INTERFACE;
line: LINE NUMBER? Number;

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

// Operators
MINUS: 'minus';
PLUS: 'plus';
PLUS_PLUS: 'plus plus' | '++' | '+ +';
MINUS_MINUS: 'minus minus' | '--' | '- -';
IS_EQUAL: 'is equal to' | 'equal to' | 'equals to';
IS_DIFFERENT: 'is different from' | 'different';
LESS_THAN: 'less than' | '<' | 'is less than';
LESS_THAN_EQUAL: 'less than equal' | '<=' | '< =';
GREATER_THAN: 'greater than' | '>' | 'is greater than';
GREATER_THAN_EQUAL: 'greater than equal' | '>=' | '> =';
IF: 'if';
THEN: 'then';

//ABSTRACT      : 'abstract';
ASSERT        : 'assert';
//BOOLEAN       : 'boolean';
//BREAK         : 'break';
//BYTE          : 'byte';
//CASE          : 'case';
//CATCH         : 'catch';
//CHAR          : 'char';
CLASS         : 'class';
//CONST         : 'const';
//CONTINUE      : 'continue';
//DEFAULT       : 'default';
DO            : 'do';
//DOUBLE        : 'double';
ELSE          : 'else';
ENUM          : 'enum';
//EXTENDS       : 'extends';
FINAL         : 'final';
//FINALLY       : 'finally';
//FLOAT         : 'float';
FOR           : 'for';
//IF            : 'if';
//GOTO          : 'goto';
//IMPLEMENTS    : 'implements';
//IMPORT        : 'import';
//INSTANCEOF    : 'instanceof';
//INT           : 'int';
INTERFACE     : 'interface';
//LONG          : 'long';
//NATIVE        : 'native';
//NEW           : 'new';
//PACKAGE       : 'package';
PRIVATE       : 'private';
PROTECTED     : 'protected';
PUBLIC        : 'public';
//RETURN        : 'return';
//SHORT         : 'short';
STATIC        : 'static';
//STRICTFP      : 'strictfp';
//SUPER         : 'super';
//SWITCH        : 'switch';
//SYNCHRONIZED  : 'synchronized';
//THIS          : 'this';
//THROW         : 'throw';
//THROWS        : 'throws';
TRANSIENT     : 'transient';
//TRY           : 'try';
//VOID          : 'void';
VOLATILE      : 'volatile';
WHILE         : 'while';

Number: [0-9]+ | 'one' | 'two' | 'three' | 'four' | 'five' | 'six' | 'seven' | 'eight' | 'nine';
ElementType : [a-zA-Z$_]+;
ElementName : [a-zA-Z0-9$_]+;
WS  :  [ \t\r\n\u000C]+ -> skip;