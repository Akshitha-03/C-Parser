grammar hello;   

start : program_unit;
program_unit			    : function_definition
							| decl									
							| program_unit function_definition					
							| program_unit decl					
							;
function_definition			: decl_specs declarator decl_list compound_stat 	
							| declarator decl_list compound_stat
							| decl_specs declarator	compound_stat 				
							| declarator compound_stat
							;
decl						: decl_specs init_declarator_list SEMICOLEN 				
							| decl_specs SEMICOLEN
							;
decl_list					: decl
							| decl_list decl
							;
decl_specs					: storage_class_spec decl_specs
							| storage_class_spec
							| type_spec decl_specs								
							| type_spec 										
							| type_qualifier decl_specs
							| type_qualifier
							;
storage_class_spec			: AUTOKEY
							| REGISTER
							| STATICKEY
							| EXTERN
							| TYPKEY
							;
type_spec					: VOIDKEY
							| CHARKEY
							| SHORTKEY
							| INTEGER
							| LONGKEY
							| FLOAT
							| DOUBLE
							| UNSIGNKEY
							| SIGNKEY											
							| struct_or_union_spec
							| enum_spec
							| typedef_name
							;
type_qualifier				: CONSTKEY
							| VOLATILEKEY
							;
struct_or_union_spec		: struct_or_union ID LB struct_decl_list RB
							| struct_or_union LB struct_decl_list RB
							| struct_or_union ID
							;
struct_or_union				: UNION
							| STRUCTKEY
							;
struct_decl_list			: struct_decl
							| struct_decl_list struct_decl
							;
init_declarator_list		: init_declarator
							| init_declarator_list COMMA init_declarator
							;
init_declarator				: declarator
                            | declarator EQUAL consts
							| declarator EQUAL initializer
							;
struct_decl					: spec_qualifier_list struct_declarator_list SEMICOLEN
							;
spec_qualifier_list			: type_spec spec_qualifier_list
							| type_spec
							| type_qualifier spec_qualifier_list
							| type_qualifier
							;
struct_declarator_list		: struct_declarator
							| struct_declarator_list COMMA struct_declarator
							;
struct_declarator			: declarator
							| declarator COLEN const_exp
							| COLEN const_exp
							;
enum_spec					: ENUM ID LB enumerator_list RB
							| ENUM LB enumerator_list RB
							| ENUM ID
							;
enumerator_list				: enumerator
							| enumerator_list COMMA enumerator
							;
enumerator					: ID
							| ID EQUAL const_exp
							;
declarator			        : ID
							| pointer declarator 												
							| OPENB declarator CLOSEB									
							| declarator LSQ const_exp RSQ							
							| declarator LSQ RSQ
							| declarator OPENB param_type_list CLOSEB 			
							| declarator OPENB id_list CLOSEB 					
							| declarator OPENB	CLOSEB 							
							;
pointer						: MUL type_qualifier_list
							| MUL
							| MUL type_qualifier_list pointer
							| MUL pointer
							;
type_qualifier_list			: type_qualifier
							| type_qualifier_list type_qualifier
							;
param_type_list				: param_list
							| param_list COMMA PARAM_CONST
							;
param_list					: param_decl
							| param_list COMMA param_decl
							;
param_decl					: decl_specs declarator
							| decl_specs abstract_declarator
							| decl_specs
							;
id_list						: ID
							| id_list COMMA ID
							;
initializer					: assignment_exp
							| LB initializer_list RB
							| LB initializer_list COMMA RB
							;
initializer_list			: initializer
							| initializer_list COMMA initializer
							;
type_name					: spec_qualifier_list abstract_declarator
							| spec_qualifier_list
							;
abstract_declarator			: pointer
							| pointer direct_abstract_declarator
							| direct_abstract_declarator
							;
direct_abstract_declarator	: OPENB abstract_declarator CLOSEB
							| direct_abstract_declarator LSQ const_exp RSQ
							| LSQ const_exp RSQ
							| direct_abstract_declarator LSQ RSQ
							| LSQ RSQ
							| direct_abstract_declarator OPENB param_type_list CLOSEB
							| OPENB param_type_list CLOSEB
							| direct_abstract_declarator OPENB CLOSEB
							| OPENB CLOSEB
							;
typedef_name				: T
							;
stat						: labeled_stat 									      	
							| exp_stat 											  	
							| compound_stat 									  	
							| selection_stat  									  
							| iteration_stat
							| jump_stat
							| exp_stat stat
							;
							
labeled_stat				: ID COLEN stat
							| CASEKEY const_exp COLEN stat
							| DEFAULTKEY COLEN stat
							;
exp_stat					: exp SEMICOLEN
							| SEMICOLEN
							;
compound_stat				: LB decl_list stat RB   						
							| LB stat RB										
							| LB decl_list	RB										
							| LB RB												
							;
selection_stat				: IF OPENB exp CLOSEB stat 									
							| IF OPENB exp CLOSEB stat ELSE stat
							| SWITCHKEY OPENB exp CLOSEB stat
							;
iteration_stat				: WHILE OPENB exp CLOSEB stat
							| DO stat WHILE OPENB exp CLOSEB SEMICOLEN
							| FOR OPENB exp SEMICOLEN exp SEMICOLEN exp CLOSEB stat
							| FOR OPENB exp SEMICOLEN exp SEMICOLEN	CLOSEB stat
							| FOR OPENB exp SEMICOLEN SEMICOLEN exp CLOSEB stat
							| FOR OPENB exp SEMICOLEN SEMICOLEN CLOSEB stat
							| FOR OPENB SEMICOLEN exp SEMICOLEN exp CLOSEB stat
							| FOR OPENB SEMICOLEN exp SEMICOLEN CLOSEB stat
							| FOR OPENB SEMICOLEN SEMICOLEN exp CLOSEB stat
							| FOR OPENB SEMICOLEN SEMICOLEN CLOSEB stat
							;
jump_stat					: GOTOKEY ID SEMICOLEN
							| CONTINUE SEMICOLEN
							| BREAK SEMICOLEN
							| RETKEY exp SEMICOLEN
							| RETKEY SEMICOLEN
							;
exp							: consts
                            | primary_exp
                            | postfix_exp
                            | unary_exp
                            | cast_exp
                            | mult_exp
                            | additive_exp
                            | shift_expression
                            | relational_exp
                            | equality_exp
                            | and_exp
                            | conditional_exp
                            | exclusive_or_exp 
                            | inclusive_or_exp
                            | logical_and_exp
                            | logical_or_exp
							| assignment_exp 
							| exp COMMA assignment_exp
							;
assignment_exp				: primary_exp
							| additive_exp
							| conditional_exp
							| unary_exp assignment_operator assignment_exp			
							;
assignment_operator			: MULEQ
							| DIVEQ
							| SUMEQ
							| SUBEQ
							| MODEQ
							| EQUAL
							;
conditional_exp				: logical_or_exp
							| logical_or_exp QUESTION exp COLEN conditional_exp
							;	
const_exp					: conditional_exp
							;
logical_or_exp				: logical_and_exp
							| logical_or_exp LOGOR logical_and_exp
							;
logical_and_exp				: inclusive_or_exp
							| logical_and_exp LOGAND inclusive_or_exp
							;
inclusive_or_exp			: exclusive_or_exp
							| inclusive_or_exp BITOR exclusive_or_exp
							;
exclusive_or_exp			: and_exp
							| exclusive_or_exp BITXOR and_exp
							;
and_exp						: equality_exp
							| and_exp BITAND equality_exp
							;
equality_exp				: relational_exp
							| equality_exp EQ relational_exp
							| equality_exp NEQ relational_exp
							;
relational_exp				: primary_exp
                            | shift_expression
							| primary_exp LT shift_expression
							| relational_exp GT shift_expression
							| relational_exp GTE shift_expression
							| relational_exp LTE shift_expression
							;
shift_expression			: primary_exp
							| additive_exp
							| shift_expression SHIFTLT additive_exp
							| shift_expression SHIFTRT additive_exp
							;
additive_exp				: primary_exp
							| mult_exp
							| additive_exp ADD mult_exp
							| additive_exp SUB mult_exp
							;
mult_exp					: primary_exp
							| cast_exp
							| mult_exp MUL cast_exp
							| mult_exp SLASH cast_exp
							| mult_exp MOD cast_exp
							;
cast_exp					: unary_exp
							| OPENB type_name CLOSEB cast_exp
							;
unary_exp					: postfix_exp
							| INC unary_exp
							| DEC unary_exp
							| unary_operator cast_exp
							| SIZEOFKEY unary_exp
							| SIZEOFKEY OPENB type_name CLOSEB
							;
unary_operator				: BITAND
							| MUL
							| ADD 
							| SUB
							| BITCOMP
							| LOGNOT 				
							;
postfix_exp					: primary_exp 											
							| postfix_exp LSQ exp RSQ
							| postfix_exp OPENB argument_exp_list CLOSEB
							| postfix_exp OPENB CLOSEB
							| postfix_exp DOT ID
							| postfix_exp POINT_CONST ID
							| postfix_exp INC
							| postfix_exp DEC
							;
primary_exp					: ID 													
							| consts 												
							| STRINGLIT 												
							| OPENB exp CLOSEB
							;
argument_exp_list			: primary_exp
							| assignment_exp
							| primary_exp COMMA assignment_exp
							| assignment_exp COMMA assignment_exp
							;
consts						: NUM 											
							| FLOAT_CONST
							;
	   

PPD: ('#include <stdio.h>'|'#include <stdlib.h>'|'#include <limits.h>'| '#include <time.h>'| '#include <string.h>' | '#include <math.h>'| '#include <assert.h>')->skip;
CHARKEY:'char';
INTEGER:'int';
DOUBLE:'double';
RETKEY: 'return';
CASEKEY:'case';
SIZEOFKEY:'sizeof';
LONGKEY:'long';
SHORTKEY:'short';
TYPKEY:'typedef';
SWITCHKEY:'switch';
UNSIGNKEY:'unsigned';
VOIDKEY:'void';
STATICKEY:'static';
STRUCTKEY:'struct';
GOTOKEY:'goto';
AUTOKEY:'auto';
ELSE:'else';
IF:'if';
BREAK:'break';
ENUM:'enum';
REGISTER:'register';
EXTERN:'extern';
UNION:'union';
FLOAT:'float';
CONSTKEY:'const';
FOR:'for';
SIGNKEY:'signed';
CONTINUE:'continue';
VOLATILEKEY:'volatile';
DEFAULTKEY:'default';
WHILE:'while';
DO:'do';
PACKEDKEY:'_Packed';
STRINGLIT:'"' ( '\\' [btnfr"'\\] | ~[\r\n\\"] )+ '"';
COMMA : ',';
COLEN : ':';
MULEQ: '*=';
DIVEQ: '/=';
SUMEQ: '+=';
SUBEQ: '-=';
MODEQ: '%=';
POINT_CONST: '->';
EQUAL : '=' ;
INC:'++';
DEC:'--';
SEMICOLEN : ';';
OPENB : '(';
CLOSEB : ')';
DQUOTE: '"';
ADD : '+' ;
SUB : '-';
MUL : '*';
DOT:'.';
MOD:'%';
SLASH:'/';
BITAND:'&';
BITOR:'|';
SHIFTLT:'<<';
SHIFTRT:'>>';
BITCOMP:'~';
BITXOR:'^';
T:'t';
LOGAND:'&&';
LOGOR:'||';
NEQ: '!=';
LOGNOT:'!';
GT:'>';
LT:'<';
GTE:'>=';
LTE:'<=';
EQ:'==';
ID : ('a'..'z'|'A'..'Z'|'_')('a'..'z'| '0'..'9'|'A'..'Z'|'_')*;
NUM : ('0'..'9')+;
FLOAT_CONST:('0'..'9')+'.'('0'..'9')+;
HASH:'#';
DOLLAR:'$';
ATT:'@';
LB:'{';
RB:'}';
LSQ:'[';
RSQ:']';
QUESTION:'?';
PARAM_CONST: '...';
MULTCMT: '/*' .*? '*/' ->skip;
SINGLECMT: '//'~[\r]* ->skip;
WS : [ \r\n\t]+ -> skip;