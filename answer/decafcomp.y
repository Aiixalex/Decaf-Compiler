%{
#include <iostream>
#include <ostream>
#include <string>
#include <cstdlib>
#include "default-defs.h"

int yylex(void);
int yyerror(char *); 

// print AST?
bool printAST = false;

using namespace std;

// this global variable contains all the generated code
static llvm::Module *TheModule;

// this is the method used to construct the LLVM intermediate code (IR)
static llvm::LLVMContext TheContext;
static llvm::IRBuilder<> Builder(TheContext);
// the calls to TheContext in the init above and in the
// following code ensures that we are incrementally generating
// instructions in the right order

// dummy main function
// WARNING: this is not how you should implement code generation
// for the main function!
// You should write the codegen for the main method as 
// part of the codegen for method declarations (MethodDecl)
// static llvm::Function *TheFunction = 0;

// we have to create a main function 
llvm::Function *gen_main_def() {
    // create the top-level definition for main
    llvm::FunctionType *FT = llvm::FunctionType::get(llvm::IntegerType::get(TheContext, 32), false);
    llvm::Function *TheFunction = llvm::Function::Create(FT, llvm::Function::ExternalLinkage, "main", TheModule);
    if (TheFunction == 0) {
        throw runtime_error("empty function block"); 
    }
    // Create a new basic block which contains a sequence of LLVM instructions
    llvm::BasicBlock *BB = llvm::BasicBlock::Create(TheContext, "entry", TheFunction);
    // All subsequent calls to IRBuilder will place instructions in this location
    Builder.SetInsertPoint(BB);
    return TheFunction;
}

#include "decafcomp.cc"

%}

%union{
    class decafAST *ast;
    string *sval;
    std::deque<string> *deq;
    int ival;
 }

%token T_BOOLTYPE T_BREAK T_CONTINUE T_ELSE T_EXTERN T_FALSE T_FOR T_FUNC T_IF T_INTTYPE
%token T_NULL T_PACKAGE T_RETURN T_STRINGTYPE T_TRUE T_VAR T_VOID T_WHILE

// %token T_COMMENT
%token T_AND T_EQ T_GEQ T_LEFTSHIFT T_LEQ T_NEQ T_OR T_RIGHTSHIFT

%token T_ASSIGN T_COMMA T_DIV T_DOT T_GT T_LT T_MINUS T_MOD T_MULT T_NOT T_PLUS T_SEMICOLON
%token T_LCB T_RCB T_LPAREN T_RPAREN T_LSB T_RSB

%token <ival> T_INTCONSTANT
%token <ival> T_CHARCONSTANT
%token <sval> T_STRINGCONSTANT
%token <sval> T_ID
%token T_ERROR

%left T_OR
%left T_AND
%left T_EQ T_NEQ
%left T_GEQ T_LEQ T_LT T_GT
%left T_PLUS T_MINUS
%left T_LEFTSHIFT T_RIGHTSHIFT
%left T_MULT T_DIV T_MOD
%left UNARY

%type <ast> decafpackage extern_list extern_decl extern_type_comma_list
%type <ast> field_list field_decl method_list method_decl
%type <ast> param_comma_list param_comma_list_nonempty block var_decl_list var_decl
%type <ast> statement_list statement assign_list assign lvalue method_call
%type <ast> method_arg_comma_list method_arg_comma_list_nonempty method_arg expr constant
// %type <sval> unary_operator binary_operator arithmetic_operator boolean_operator
%type <sval> extern_type decaf_type method_type bool_constant
%type <deq> id_comma_list

%%

start: program

program: extern_list decafpackage
    { 
        ProgramAST *prog = new ProgramAST((decafStmtList *)$1, (PackageAST *)$2); 
		if (printAST) {
			cout << getString(prog) << endl;
		}
        try {
            prog->Codegen();
        } 
        catch (std::runtime_error &e) {
            cout << "semantic error: " << e.what() << endl;
            //cout << prog->str() << endl; 
            exit(EXIT_FAILURE);
        }
        delete prog;
    }

decafpackage: T_PACKAGE T_ID begin_block field_list method_list end_block
    {
        $$ = new PackageAST( *$2, (decafStmtList *)$4, (decafStmtList *)$5 );
        delete $2;
    }
    ;

extern_list: extern_decl extern_list
    {
        decafStmtList *slist;
        if($2 == NULL) {
            slist = new decafStmtList();
        } else {
            slist = (decafStmtList *)$2;
        }
        slist->push_front($1);
        $$ = slist;
    }
    | /* extern_list can be empty */
    { $$ = NULL; }
    ;

extern_decl: T_EXTERN T_FUNC T_ID T_LPAREN extern_type_comma_list T_RPAREN method_type T_SEMICOLON
    {
        $$ = new ExternAST( *$3, *$7, (decafStmtList *)$5 );
        delete $3;
        delete $7;
    }
    ;

extern_type_comma_list: extern_type T_COMMA extern_type_comma_list
    {
        decafStmtList* slist = (decafStmtList *)$3;
        ExtTypeAST* t = new ExtTypeAST(*$1);
        slist->push_front(t);
        $$ = slist;
        delete $1;
    }
    | extern_type
    {
        decafStmtList* slist = new decafStmtList();
        ExtTypeAST* t = new ExtTypeAST(*$1);
        slist->push_front(t);
        $$ = slist;
        delete $1;
    }
    |
    { $$ = NULL; }
    ;
    
field_list: field_decl field_list
    {
        decafStmtList *slist;
        if($2 == NULL) {
            slist = new decafStmtList();
        } else {
            slist = (decafStmtList *)$2;
        }
        slist->push_front($1);
        $$ = slist;
    }
    |
    { $$ = NULL; }
    ;

field_decl: T_VAR id_comma_list decaf_type T_SEMICOLON
    {
        decafStmtList *slist = new decafStmtList();
        FieldAST* t;
        for( int i = 0; i < $2->size(); i++ ) {
            t = new FieldAST((*$2)[i], *$3, "Scalar", 0, NULL, false);
            slist->push_back(t);
        }
        $$ = slist;
        delete $2;
        delete $3;
    }
    | T_VAR id_comma_list T_LSB T_INTCONSTANT T_RSB decaf_type T_SEMICOLON
    {
        decafStmtList *slist = new decafStmtList();
        FieldAST* t;
        for( int i = 0; i < $2->size(); i++ ) {
            t = new FieldAST((*$2)[i], *$6, string("Array(") + to_string($4) + ")", $4, NULL, false);
            slist->push_back(t);
        }
        $$ = slist;
        delete $2;
        delete $6;
    }
    | T_VAR id_comma_list decaf_type T_ASSIGN constant T_SEMICOLON
    {
        decafStmtList *slist = new decafStmtList();
        FieldAST* t;
        for( int i = 0; i < $2->size(); i++ ) {
            t = new FieldAST((*$2)[i], *$3, "", 0, (ConstantAST*)$5, true);
            slist->push_back(t);
        }
        $$ = slist;
        delete $2;
        delete $3;
    }
    ;

id_comma_list: T_ID T_COMMA id_comma_list
    {
        deque<string> *slist;
        slist = $3;
        slist->push_front(*$1);
        $$ = slist;
        delete $1;
    }
    | T_ID
    {
        deque<string> *slist = new deque<string>;
        slist->push_front(*$1);
        $$ = slist;
        delete $1;
    }
    ;

method_list: method_decl method_list
    {
        decafStmtList* slist;
        if($2 != NULL) {
            slist = (decafStmtList*)$2;
        } else {
            slist = new decafStmtList();
        }
        slist->push_front($1);
        $$ = slist;
    }
    |
    { $$ = NULL; }
    ;

method_decl: T_FUNC T_ID T_LPAREN param_comma_list T_RPAREN method_type block
    {
        BlockAST* t = (BlockAST*)$7;
        t->isMethod();
        $$ = new MethodAST(*$2, *$6, (decafStmtList *)$4, t);
        delete $2;
        delete $6;
    }
    ;

param_comma_list: param_comma_list_nonempty
    { $$ = $1; }
    |
    { $$ = NULL; }

param_comma_list_nonempty: T_ID decaf_type T_COMMA param_comma_list
    {
        decafStmtList* slist = (decafStmtList*)$4;
        VarDefAST* t = new VarDefAST(*$1, *$2, true);
        slist->push_front(t);
        $$ = slist;
        delete $1;
        delete $2;
    }
    | T_ID decaf_type
    {
        decafStmtList* slist = new decafStmtList();
        VarDefAST* t = new VarDefAST(*$1, *$2, true);
        slist->push_front(t);
        $$ = slist;
        delete $1;
        delete $2;
    }
    ;

block: begin_block var_decl_list statement_list end_block
    {
        $$ = new BlockAST((decafStmtList*)$2, (decafStmtList*)$3);
    }
    ;

begin_block: T_LCB
    {
        symtbl.push_front(symbol_table());
    }
    ;

end_block: T_RCB
    {
        symtbl.pop_front();
    }
    ;

var_decl_list: var_decl var_decl_list
    {
        decafStmtList* slist;
        if($2 != NULL) {
            slist = (decafStmtList*)$2;
        } else {
            slist = new decafStmtList();
        }
        slist->push_front($1);
        $$ = slist;
    }
    |
    { $$ = NULL; }
    ;

var_decl: T_VAR id_comma_list decaf_type T_SEMICOLON
    {
        decafStmtList* slist = new decafStmtList();
        VarDefAST* t;
        for(int i=0; i < $2->size(); i++) {
            t = new VarDefAST((*$2)[i], *$3, false);
            slist->push_back(t);
        }
        $$ = slist;
        delete $2;
        delete $3;
    }
    ;

statement_list: statement statement_list
    {
        decafStmtList* slist;
        if($2 != NULL){
            slist = (decafStmtList*)$2;
        } else {
            slist = new decafStmtList();
        }
        slist->push_front($1);
        $$ = slist;
    }
    |
    { $$ = NULL; }
    ;

statement: block
    { $$ = $1; }
    | assign T_SEMICOLON
    { $$ = $1; }
    | method_call T_SEMICOLON
    { $$ = $1; }
    | T_IF T_LPAREN expr T_RPAREN block T_ELSE block
    {
        $$ = new IfStmtAST((decafAST*)$3, (BlockAST*)$5, (BlockAST*)$7);
    }
    | T_IF T_LPAREN expr T_RPAREN block
    {
        $$ = new IfStmtAST((decafAST*)$3, (BlockAST*)$5, NULL);
    }
    | T_WHILE T_LPAREN expr T_RPAREN block
    {
        $$ = new WhileStmtAST((decafAST*)$3, (BlockAST*)$5);
    }
    | T_FOR T_LPAREN assign_list T_SEMICOLON expr T_SEMICOLON assign_list T_RPAREN block
    {
        $$ = new ForStmtAST((decafStmtList*)$3,(decafAST*)$5,(decafStmtList*)$7, (BlockAST*)$9);
    }
    | T_RETURN T_LPAREN expr T_RPAREN T_SEMICOLON
    {
        $$ = new ReturnStmtAST($3);
    }
    | T_RETURN T_LPAREN T_RPAREN T_SEMICOLON
    {
        $$ = new ReturnStmtAST(NULL);
    }
    | T_RETURN T_SEMICOLON
    {
        $$ = new ReturnStmtAST(NULL);
    }
    | T_BREAK T_SEMICOLON
    {
        $$ =  new BreakStmtAST();
    }
    | T_CONTINUE T_SEMICOLON
    {
        $$ = new ContinueStmtAST();
    }
    ;

assign_list: assign T_COMMA assign_list
    {
        decafStmtList* slist = (decafStmtList*)$3;
        slist->push_front($1);
        $$ = slist;
    }
    | assign
    {
        decafStmtList* slist = new decafStmtList();
        slist->push_front($1);
        $$ = slist;
    }
    ;

assign: lvalue T_ASSIGN expr
    {
        $$ = new AssignAST((rValueAST*)$1, (decafAST*)$3);
    }
    ;

lvalue: T_ID T_LSB expr T_RSB
    {
        $$ = new rValueAST(*$1, (decafAST*)$3);
        delete $1;
    }
    |
    T_ID
    {
        $$ = new rValueAST(*$1);
        delete $1;
    }
    ;

method_call: T_ID T_LPAREN method_arg_comma_list T_RPAREN
    {
        $$ = new MethodCallAST(*$1, (decafStmtList*)$3);
        delete $1;
    }
    ;

method_arg_comma_list: method_arg_comma_list_nonempty
    { $$ = $1; }
    |
    { $$ = NULL; }
    ;

method_arg_comma_list_nonempty: method_arg T_COMMA method_arg_comma_list
    {
        decafStmtList* slist = (decafStmtList*)$3;
        slist->push_front($1);
        $$ = slist;
    }
    | method_arg
    {
        decafStmtList* slist = new decafStmtList();
        slist->push_front($1);
        $$ = slist;
    }
    ;

method_arg: expr
    { $$ = $1; }
    |
    T_STRINGCONSTANT
    {
        string str = yylval_to_string(*$1);
        $$ = new ConstantAST("StringConstant",str, 0);
        delete $1;
    }
    ;

expr: lvalue
    {
        $$ = $1;
    }
    | method_call
    {
        $$ = $1;
    }
    | constant
    {
        $$ = $1;
    }
    | expr T_PLUS expr
    {
        $$ = new BinaryExprAST("Plus", (decafAST*)$1, (decafAST*)$3);
    }
    | expr T_MINUS expr
    {
        $$ = new BinaryExprAST("Minus", (decafAST*)$1, (decafAST*)$3);
    }| expr T_MULT expr
    {
        $$ = new BinaryExprAST("Mult", (decafAST*)$1, (decafAST*)$3);
    }| expr T_DIV expr
    {
        $$ = new BinaryExprAST("Div", (decafAST*)$1, (decafAST*)$3);
    }| expr T_LEFTSHIFT expr
    {
        $$ = new BinaryExprAST("Leftshift", (decafAST*)$1, (decafAST*)$3);
    }| expr T_RIGHTSHIFT expr
    {
        $$ = new BinaryExprAST("Rightshift", (decafAST*)$1, (decafAST*)$3);
    }| expr T_MOD expr
    {
        $$ = new BinaryExprAST("Mod", (decafAST*)$1, (decafAST*)$3);
    }| expr T_EQ expr
    {
        $$ = new BinaryExprAST("Eq", (decafAST*)$1, (decafAST*)$3);
    }| expr T_NEQ expr
    {
        $$ = new BinaryExprAST("Neq", (decafAST*)$1, (decafAST*)$3);
    }| expr T_LT expr
    {
        $$ = new BinaryExprAST("Lt", (decafAST*)$1, (decafAST*)$3);
    }| expr T_LEQ expr
    {
        $$ = new BinaryExprAST("Leq", (decafAST*)$1, (decafAST*)$3);
    }| expr T_GT expr
    {
        $$ = new BinaryExprAST("Gt", (decafAST*)$1, (decafAST*)$3);
    }| expr T_GEQ expr
    {
        $$ = new BinaryExprAST("Geq", (decafAST*)$1, (decafAST*)$3);
    }| expr T_AND expr
    {
        $$ = new BinaryExprAST("And", (decafAST*)$1, (decafAST*)$3);
    }| expr T_OR expr
    {
        $$ = new BinaryExprAST("Or", (decafAST*)$1, (decafAST*)$3);
    }
    | T_MINUS expr %prec UNARY
    {
        $$ = new UnaryExprAST("UnaryMinus", (decafAST*)$2);
    }
    | T_NOT expr %prec UNARY
    {
        $$ = new UnaryExprAST("Not", (decafAST*)$2);
    }
    | T_LPAREN expr T_RPAREN
    {
        $$ = $2;
    }
    ;

extern_type: T_STRINGTYPE
    { $$ = new string("StringType"); }
    |
    decaf_type
    { $$ = $1; }
    ;

decaf_type: T_INTTYPE
    { $$ = new string("IntType"); }
    | T_BOOLTYPE
    { $$ = new string("BoolType"); }
    ;

method_type: T_VOID
    { $$ = new string("VoidType"); }
    | decaf_type
    { $$ = $1; }
    ;

bool_constant: T_TRUE
    { $$ = new string("True"); }
    | T_FALSE
    { $$ = new string("False"); }
    ;

constant: T_INTCONSTANT
    {
        $$ = new ConstantAST( "NumberExpr", "", $1);
    }
    | T_CHARCONSTANT
    {
        $$ = new ConstantAST( "NumberExpr", "", $1);
    }
    | bool_constant
    {
        $$ = new ConstantAST( "BoolExpr", *$1, 0);
    }
    ;

%%

int main() {
    // initialize LLVM
    llvm::LLVMContext &Context = TheContext;
    // Make the module, which holds all the code.
    TheModule = new llvm::Module("DecafComp", Context);
    // set up symbol table
    symtbl.push_front(symbol_table());
    // set up dummy main function
    //TheFunction = gen_main_def();
    // parse the input and create the abstract syntax tree
    int retval = yyparse();
    // remove symbol table
    symtbl.pop_front();
    // Finish off the main function. (see the WARNING above)
    // return 0 from main, which is EXIT_SUCCESS
    //Builder.CreateRet(llvm::ConstantInt::get(TheContext, llvm::APInt(32, 0)));
    // Validate the generated code, checking for consistency.
    //verifyFunction(*TheFunction);
    // Print out all of the generated code to stderr
    TheModule->print(llvm::errs(), nullptr);
    return(retval >= 1 ? EXIT_FAILURE : EXIT_SUCCESS);
}

