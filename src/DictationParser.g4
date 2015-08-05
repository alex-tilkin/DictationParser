grammar DictationParser;

/* Parser */

// Top
command: creationCommand | navigationCommand | selectionCommand | modificationCommand;

// Creation Layer
creationCommand: creationVerb (AN | A)? (createField | createMethod | createDataType | createBlock | createStatement) elementLocation?;
creationVerb: CREATE | NEW;
createField: fieldModifier? fieldRef;
createMethod: modifier? (METHOD | FUNCTION) namedElement ((THAT_ACCEPTS | WITH) parametersList)?;
createDataType: modifier? (INNER)? dataType namedElement;
createBlock: BLOCK;
createStatement: createExpression;// | <Create-Control-Flow-Statement>
createExpression: KURK;//<Create-Assignment-Expression> | <Create-Method-Invocation-Expression> | <Create-Object-Creation-Expression> | <Create-Increment-Decrement-Expression>;

// Navigation Layer
navigationCommand: navigationVerb (dataType | FIELD | METHOD)? ElementName | exitCommand;
navigationVerb: GO_TO | WE_ARE_DONE_WIT;
exitCommand: (EXIT | QUIT) elementRef;
exit: WE_ARE_DONE_WIT | EXIT;

// Modification
modificationCommand: modifyAccessLevel;
modifyAccessLevel: modificationVerb accessLevel;
modificationVerb: MAKE_IT | CHANGE_IT;

// Selection
selectionCommand: (NUMBER | OPTION)? Number;

// Common
fieldModifier: modifier FINAL? TRANSIENT? VOLATILE?;
modifier: STATIC? accessLevel;
accessLevel: PRIVATE | PUBLIC | PROTECTED;

elementLocation: locationRef (elementRef | line);
fieldRef:  FIELD (ElementName? OF_TYPE ElementType | OF_TYPE ElementType namedElement | ElementName);
elementRef: classRef | fieldRef | enumRef | interfaceRef | unspecifiedRef;
classRef: CLASS ElementName;
namedElement: reference? ElementName;
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

KURK: 'kurk'; // Not part of the language.

//
AND: 'and';
OR: 'or';

// Language idioms
METHOD: 'method';
FUNCTION: 'function';
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

// Commands
GO_TO: 'go to';
EXIT: 'exit';
QUIT: 'quit';
WE_ARE_DONE_WIT: 'we are done with';
MAKE_IT: 'make it';
CHANGE_IT: 'change it to';
CREATE: 'create';

//ABSTRACT      : 'abstract';
//ASSERT        : 'assert';
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
//DO            : 'do';
//DOUBLE        : 'double';
//ELSE          : 'else';
ENUM          : 'enum';
//EXTENDS       : 'extends';
FINAL         : 'final';
//FINALLY       : 'finally';
//FLOAT         : 'float';
//FOR           : 'for';
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
//WHILE         : 'while';

Number: [0-9] | 'one' | 'two' | 'three' | 'four' | 'five' | 'six' | 'seven' | 'eight' | 'nine';
ElementType : [a-zA-Z$_]+;
ElementName : [a-zA-Z0-9$_]+;
WS  :  [ \t\r\n\u000C]+ -> skip;