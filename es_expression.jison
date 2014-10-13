
/* If this file is modified copy the generated es_expression.js file to es_client/vendor/ */
/* lexical grammar */
%lex
%%
\s+                                                             {/* skip whitespace */}
'"'("\\"["]|[^"])*'"'                                           {return 'STRING';}
"'"('\\'[']|[^'])*"'"                                           {return 'STRING';}
/*
'$'[A-Za-z]+'$'[0-9]+[:]'$'[A-Za-z]+'$'[0-9]+                   {return 'FIXEDCELLRANGE';}
'$'[A-Za-z]+'$'[0-9]+                                           {return 'FIXEDCELL';}
'SHEET'[0-9]+[:!][A-Za-z]+[0-9]+[:][A-Za-z]+[0-9]+              {return 'REMOTECELLRANGE';}
'SHEET'[0-9]+[:!][A-Za-z]+[0-9]+                                {return 'REMOTECELL';}
[0-9]([0-9]?)[-/][0-9]([0-9]?)[-/][0-9]([0-9]?)([0-9]?)([0-9]?) {return 'DATE';}
*/
'cellReference'[(][^):]*[)][:]'cellReference'[(][^):]*[)]       {return 'CELLRANGE';}
[A-Za-z]+[0-9]+[:][A-Za-z]+[0-9]+                               {return 'CELLRANGE';}
[A-Za-z]+[0-9]+                                                 {return 'CELL';}
[0-9]+[%]                                                       {return 'PERCENT';}
[0-9]+("."[0-9]+)?                                              {return 'NUMBER';} 
"$"                             {/* skip whitespace */}
" "                             {return ' ';}
"."                             {return '.';}
":"                             {return ':';}
";"                             {return ';';}
","                             {return ',';}
"*"                             {return '*';}
"/"                             {return '/';}
"-"                             {return '-';}
"+"                             {return '+';}
"^"                             {return '^';}
"("                             {return '(';}
")"                             {return ')';}
">="                            {return 'GTE';}
"<="                            {return 'LTE';}
"<>"                            {return 'NE';}
">"                             {return '>';}
"<"                             {return '<';}
"NOT"                           {return 'NOT';}
"PI"                            {return 'PI';}
"E"                             {return 'E';}
'"'                             {return '"';}
"'"                             {return "'";}
"!"                             {return "!";}
<<EOF>>                         {return 'EOF';}
"="                             {return '=';}
[A-Za-z]+                       {return 'IDENTIFIER';}


/lex

/* operator associations and precedence (low-top, high- bottom) */
%left 'LTE' 'GTE' 'NE' 'NOT' '||' '='
%left '>' '<'
%left '+' '-'
%left '*' '/'
%left '^'
%left '%'
%left UMINUS

%start expressions

%% /* language grammar */

expressions
 : e EOF
     {return $1;}
 ;

e
        : e LTE e
                {$$ = ($1 * 1) <= ($3 * 1);}
        | e GTE e
                {$$ = ($1 * 1) >= ($3 * 1);}
        | e NE e
                {$$ = ($1 * 1) != ($3 * 1);}
        | e NOT e
                {$$ = ($1 * 1) != ($3 * 1);}
        | e '=' e
                {$$ = $1 == $3;}
        | e '>' e
                {$$ = ($1 * 1) > ($3 * 1);}
        | e '<' e
                {$$ = ($1 * 1) < ($3 * 1);}
        | e '+' e
                {$$ = ($1 * 1) + ($3 * 1);}
        | e '-' e
                {$$ = ($1 * 1) - ($3 * 1);}
        | e '*' e
                {$$ = ($1 * 1) * ($3 * 1);}
        | e '/' e
                {$$ = ($1 * 1) / ($3 * 1);}
        | e '^' e
                {$$ = Math.pow(($1 * 1), ($3 * 1));}
        | '-' e
                {$$ = $2 * -1;}
        | '(' e ')'
                {$$ = $2;}
        | PERCENT
                {$$ = ($1.replace(/%/,'') * 1) / 100;}
        | NUMBER
                {$$ = Number(yytext);}
        | E
                {$$ = Math.E;}
        | PI
                {$$ = Math.PI;}
        | CELL
                {$$ = yy.parseCellValue($1)}
        | CELLRANGE
                {$$ = yy.parseCellRange($1)}
/*
        | FIXEDCELL
                {$$ = yy.lexer.cellHandler.fixedCellValue.apply(yy.lexer.cell, [$1]);}
        | FIXEDCELLRANGE
                {$$ = yy.lexer.cellHandler.fixedCellRangeValue.apply(yy.lexer.cell, [$1]);}
        | REMOTECELL
                {$$ = yy.lexer.cellHandler.remoteCellValue.apply(yy.lexer.cell, [$1]);}
        | REMOTECELLRANGE
                {$$ = yy.lexer.cellHandler.remoteCellRangeValue.apply(yy.lexer.cell, [$1]);}
*/
        | IDENTIFIER '(' ')'
                {$$ = yy.callFunction($1, '', yy.currentCell);}
        | IDENTIFIER '(' expseq ')'
                {$$ = yy.callFunction($1, $3, yy.currentCell);}
        | STRING
                {$$ = $1.substring(1, $1.length - 1);}  
 ;

expseq
 : e
        | e ';' expseq
        {
                $$ = ($.isArray($3) ? $3 : [$3]);
                $$.push($1);
        }
        | e ',' expseq
        {
                $$ = ($.isArray($3) ? $3 : [$3]);
                $$.push($1);
        }
 ;
