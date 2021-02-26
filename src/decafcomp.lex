%{
#include "default-defs.h"
#include "decafcomp.tab.h"
#include <cstring>
#include <string>
#include <sstream>
#include <iostream>

using namespace std;

int lineno = 1;
int tokenpos = 1;

int str_to_int(string yytext) {
  int res = 0;
  if(yytext[0] == '0' && (yytext[1] == 'x' || yytext[1] == 'X')) {
    for(int i=2; i<yytext.length(); i++) {
      if(yytext[i] >= '0' && yytext[i] <= '9') {
        res = res * 16 + yytext[i] - '0';
      } else if(yytext[i] >= 'A' && yytext[i] <= 'F') {
        res = res * 16 + yytext[i] - 'A' + 10;
      } else if(yytext[i] >= 'a' && yytext[i] <= 'f') {
        res = res * 16 + yytext[i] - 'a' + 10;
      }
    }
  }
  else
  {
    for(int i=0; i<yytext.length(); i++) {
      res = res * 10 + yytext[i] - '0';
    }
  }
  return res;
}

int str_to_ascii(string yytext) {
  int res;
  if(yytext.size() == 3) { res = yytext[1] - 'A' + 65; }
  else if(yytext.size() == 4)
  { 
    if(yytext[2] == 'a') res = 7;
    if(yytext[2] == 'b') res = 8;
    if(yytext[2] == 't') res = 9;
    if(yytext[2] == 'n') res = 10;
    if(yytext[2] == 'v') res = 11;
    if(yytext[2] == 'f') res = 12;
    if(yytext[2] == 'r') res = 13;
    if(yytext[2] == '\\') res = 92;
    if(yytext[2] == '\'') res = 39;
    if(yytext[2] == '\"') res = 34;
  }
  return res;
};

%}

%%
  /*
    Pattern definitions for all tokens 
  */
bool                       { return T_BOOLTYPE; }
break                      { return T_BREAK; }
continue                   { return T_CONTINUE; }
else                       { return T_ELSE; }
extern                     { return T_EXTERN; }
false                      { return T_FALSE; }
for                        { return T_FOR; }
func                       { return T_FUNC; }
if                         { return T_IF; }
int                        { return T_INTTYPE; }
null                       { return T_NULL; }
package                    { return T_PACKAGE; }
return                     { return T_RETURN; }
string                     { return T_STRINGTYPE; }
true                       { return T_TRUE; }
var                        { return T_VAR; }
void                       { return T_VOID; }
while                      { return T_WHILE; }

\/\/[^\n]*\n               { }
\&\&                       { return T_AND; }
==                         { return T_EQ; }
>=                         { return T_GEQ; }
\<\<                       { return T_LEFTSHIFT; }
\<=                        { return T_LEQ; }
!=                         { return T_NEQ; }
\|\|                       { return T_OR; }
>>                         { return T_RIGHTSHIFT; }

=                          { return T_ASSIGN; }
\,                         { return T_COMMA; }
\/                         { return T_DIV; }
\.                         { return T_DOT; }
>                          { return T_GT; }
\<                         { return T_LT; }
\-                         { return T_MINUS; }
\%                         { return T_MOD; }
\*                         { return T_MULT; }
!                          { return T_NOT; }
\+                         { return T_PLUS; }
\;                         { return T_SEMICOLON; }
\{                         { return T_LCB; }
\}                         { return T_RCB; }
\(                         { return T_LPAREN; }
\)                         { return T_RPAREN; }
\[                         { return T_LSB; }
\]                         { return T_RSB; }

([0-9]+)|(0(x|X)[a-fA-F0-9]+)     { yylval.ival = str_to_int(yytext); return T_INTCONSTANT; }
\'([^'\\\n]|\\[nrtvfab\\\'\"])\'  { yylval.ival = str_to_ascii(yytext); return T_CHARCONSTANT;}
\"([^"\\\n]|\\[nrtvfab\\\'\"])*\" { yylval.sval = new string(yytext); return T_STRINGCONSTANT; }
[a-zA-Z\_][a-zA-Z\_0-9]*   { yylval.sval = new string(yytext); return T_ID; } /* note that identifier pattern must be after all keywords */
[\t\r\a\v\b ]+             { } /* ignore whitespace */
\n                         { lineno += 1; }
.                          { return T_ERROR; }

%%

int yyerror(const char *s) {
  cerr << lineno << ": " << s << endl;
  return 1;
}

