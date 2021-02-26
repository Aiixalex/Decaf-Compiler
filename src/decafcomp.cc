
#include "default-defs.h"
#include <list>
#include <ostream>
#include <iostream>
#include <sstream>

#ifndef YYTOKENTYPE
#include "decafcomp.tab.h"
#endif

using namespace std;

symbol_table_list symtbl;

llvm::Value* access_symtbl(string ident) {
	for (auto i : symtbl) {
        auto find_ident = i.find(ident);
        if (find_ident != i.end()) {
            return find_ident->second;
        }
    }
    return NULL;
}

bool print_debug_flag = false;

void print_debug(bool flag, string output)
{
  	if(flag) { cout << output << endl; }
}

llvm::Type* get_llvm_type(string type) {
	llvm::Type* LLVMType;
	if (type == "VoidType")   LLVMType = Builder.getVoidTy();
	if (type == "IntType")    LLVMType = Builder.getInt32Ty();
	if (type == "BoolType")   LLVMType = Builder.getInt1Ty();
	if (type == "StringType") LLVMType = Builder.getInt8PtrTy();
	return LLVMType;
}

string yylval_to_string(string str) {
	if(str == "") { return str;}
	string res;
	for(int i=1; i<str.length()-1; i++) {
		if(str[i] != '\\') { res.push_back(str[i]); }
		else {
			switch(str[i+1]) {
				case 'a':  res.push_back('\a'); break;
				case 'b':  res.push_back('\b'); break;
				case 'f':  res.push_back('\f'); break;
				case 'n':  res.push_back('\n'); break;
				case 'r':  res.push_back('\r'); break;
				case 't':  res.push_back('\t'); break;
				case 'v':  res.push_back('\v'); break;
				case '\\': res.push_back('\\'); break;
				case '\'': res.push_back('\''); break;
				case '\"': res.push_back('\"'); break;
			}
			i++;
		}
	}
	return res;
}

/// decafAST - Base class for all abstract syntax tree nodes.
class decafAST {
public:
  virtual ~decafAST() {}
  virtual string str() { return string(""); }
  virtual llvm::Value *Codegen() = 0;
};

string getString(decafAST *d) {
	if (d != NULL) {
		return d->str();
	} else {
		return string("None");
	}
}

template <class T>
string commaList(list<T> vec) {
    string s("");
    for (typename list<T>::iterator i = vec.begin(); i != vec.end(); i++) { 
        s = s + (s.empty() ? string("") : string(",")) + (*i)->str(); 
    }   
    if (s.empty()) {
        s = string("None");
    }   
    return s;
}

template <class T>
llvm::Value *listCodegen(list<T> vec) {
	llvm::Value *val = NULL;
	for (typename list<T>::iterator i = vec.begin(); i != vec.end(); i++) { 
		llvm::Value *j = (*i)->Codegen();
		if (j != NULL) { val = j; }
	}	
	return val;
}

/// decafStmtList - List of Decaf statements
class decafStmtList : public decafAST {
	list<decafAST *> stmts;
public:
	decafStmtList() {}
	~decafStmtList() {
		for (list<decafAST *>::iterator i = stmts.begin(); i != stmts.end(); i++) { 
			delete *i;
		}
	}
	int size() { return stmts.size(); }
	void push_front(decafAST *e) { stmts.push_front(e); }
	void push_back(decafAST *e) { stmts.push_back(e); }
	list<decafAST*> get_stmts() { return stmts; }
	string str() { return commaList<class decafAST *>(stmts); }
	llvm::Value *Codegen() { 
		return listCodegen<decafAST *>(stmts); 
	}
};

class ExtTypeAST : public decafAST {
	string Type;
public:
	ExtTypeAST(string type) : Type(type) {}
	~ExtTypeAST() {}
	string get_type() { return Type; }
	string str() {
		return string("VarDef") + "(" + Type + ")";
	}
	llvm::Value *Codegen() {
		return NULL;
	}
};

class ExternAST : public decafAST {
	string Name;
	string MethodType;
	decafStmtList* ExternTypeList;
public:
	ExternAST(string name, string return_type, decafStmtList* typelist)
		: Name(name), MethodType(return_type), ExternTypeList(typelist) {}
	~ExternAST() {
		if(ExternTypeList != NULL) { delete ExternTypeList; }
	}
	string str() {
		return string("ExternFunction") + "(" + Name + "," + MethodType + "," + getString(ExternTypeList) + ")";
	}
	llvm::Value *Codegen() {
		print_debug(print_debug_flag, "Extern Codegen Start.");
		llvm::Type* returnTy = get_llvm_type(MethodType);

		vector<llvm::Type*> args_types;
		if(ExternTypeList != NULL) {
			list<decafAST*> stmts = ExternTypeList->get_stmts();
			for(list<decafAST*>::iterator i = stmts.begin(); i != stmts.end(); i++) {
				string LLVMType = ((ExtTypeAST*)(*i))->get_type();
				args_types.push_back(get_llvm_type(LLVMType));
			}
		}

		llvm::Function *func = llvm::Function::Create(
			llvm::FunctionType::get(returnTy, args_types, false),
			llvm::Function::ExternalLinkage,
			Name,
			TheModule
		);
		llvm::verifyFunction(*func);

		
		symtbl.front()[Name] = (llvm::Value*)func;

		return (llvm::Value*)func;
	}
};

class ConstantAST : public decafAST {
	string Type;
	string Str;
	int Num;
public:
	ConstantAST(string type, string str, int num) : Type(type), Str(str), Num(num) {}
	~ConstantAST() {}
	string getType() { return Type; }
	string str() {
		string s;
		if(Type == "NumberExpr") {
			s = "NumberExpr(" + to_string(Num) + ")";
		}
		else if (Type == "BoolExpr") {
			s = "BoolExpr(" + Str + ")";
		}
		else if (Type == "StringConstant") {
			s = "StringConstant(" + Str + ")";
		}
		return s;
	}
	llvm::Value *Codegen() {
		print_debug(print_debug_flag, "Constant Codegen Start.");
		llvm::Value* val;
		llvm::Constant* c;
		if(Type == "NumberExpr") {
			c = Builder.getInt32(Num);
			val = (llvm::Value*)c;
		}
		else if(Type == "BoolExpr") {
			if(Str == "True") { c = Builder.getInt1(1); }
			if(Str == "False") { c = Builder.getInt1(0); }
			val = (llvm::Value*)c;
		}
		if (Type == "StringConstant") {
			llvm::GlobalVariable* GS = Builder.CreateGlobalString(Str, "globalstring");
      		val = Builder.CreateConstGEP2_32(GS->getValueType(), GS, 0, 0, "cast");
		}
		return val;
	}
};

class FieldAST : public decafAST {
	string Name;
	string DecafType;
	string FieldSize;
	int ArraySize;
	ConstantAST* FieldConst;
	bool hasConstant;
public:
	FieldAST(string name, string decaf_type, string field_size, int array_size,  ConstantAST* field_const,  bool has_constant)
		: Name(name), DecafType(decaf_type), FieldSize(field_size), ArraySize(array_size), FieldConst(field_const), hasConstant(has_constant) {}
	~FieldAST() {}
	string str() {
		if(hasConstant == false) {
			return string("FieldDecl") + "(" + Name + "," + DecafType + "," + FieldSize + ")";
		}
		else {
			return string("AssignGlobalVar") + "(" + Name + "," + DecafType + "," + getString(FieldConst) +")";
		}
	}
	llvm::Value *Codegen() {
		print_debug(print_debug_flag, "Field Codegen Start.");
		llvm::Constant* value;
		if(hasConstant == true) {
			value = (llvm::Constant*)(FieldConst->Codegen());
		} else {
			if(DecafType == "IntType") {
				value = Builder.getInt32(0);
			} else if(DecafType == "BoolType") {
				value = Builder.getInt32(0);
			}
		}

		llvm::GlobalVariable* GV;
		llvm::Type* GVType = get_llvm_type(DecafType);
		if(hasConstant == true || FieldSize == "Scalar") {
			// declare a global variable
			GV = new llvm::GlobalVariable(
				*TheModule, 
				GVType, 
				false,  // variable is mutable
				llvm::GlobalValue::InternalLinkage, 
				value, 
				Name
			);
			symtbl.front()[Name] = (llvm::Value*)GV;
		} else {
			llvm::ArrayType *arrayi32 = llvm::ArrayType::get(GVType, ArraySize);
			// zeroinitalizer: initialize array to all zeroes
			llvm::Constant *zeroInit = llvm::Constant::getNullValue(arrayi32);
			// declare a global variable
			GV = new llvm::GlobalVariable(
				*TheModule, 
				arrayi32, 
				false, 
				llvm::GlobalValue::ExternalLinkage, 
				zeroInit, 
				Name
			);
			// 3rd parameter to GlobalVariable is false because it is not a constant variable
			symtbl.front()[Name] = (llvm::Value*)GV;
			symtbl.front()[Name + "_arraytype"] = (llvm::Value*)arrayi32;
		}

		print_debug(print_debug_flag, "Field Codegen End.");
		return (llvm::Value*)GV;
	}
};

class VarDefAST : public decafAST {
	string Name;
	string Type;
	bool isParam;
public:
	VarDefAST(string name, string type, bool is_param) : Name(name), Type(type), isParam(is_param) {}
	~VarDefAST() {}
	string get_name() { return Name; }
	string get_type() { return Type; }
	string str() {
		return "VarDef(" + Name + "," + Type + ")";
	}
	llvm::Value *Codegen() {	
		print_debug(print_debug_flag, "VarDef Codegen Start.");
		llvm::Type* LLVMType = get_llvm_type(Type);
		if(isParam == false) {
			llvm::AllocaInst* Alloca = Builder.CreateAlloca(LLVMType, 0, Name);

			// zero initialize variable
			llvm::Value* RValue;
			if(Type == "IntType") {
				RValue = (llvm::Value*)Builder.getInt32(0);
			}
			else if(Type == "BoolType") {
				RValue = (llvm::Value*)Builder.getInt1(0);
			}
			if (Type == "StringType") {
				llvm::GlobalVariable* GS = Builder.CreateGlobalString("", "globalstring");
				RValue = Builder.CreateConstGEP2_32(GS->getValueType(), GS, 0, 0, "cast");
			}
			const llvm::PointerType* ptrTy = RValue->getType()->getPointerTo();
			if(((llvm::Value*)Alloca)->getType() == ptrTy) {
				Builder.CreateStore(RValue, Alloca);
			}

			symtbl.front()[Name] = Alloca;
			return (llvm::Value*)Alloca;
		} else {
			return NULL;
		}
	}
};

class BlockAST : public decafAST {
	decafStmtList* VarDeclList;
	decafStmtList* StatementList;
	bool MethodFlag = false;
public:
	BlockAST(decafStmtList* var_decl_list, decafStmtList* statement_list)
		: VarDeclList(var_decl_list), StatementList(statement_list) {}
	~BlockAST() {
		if(VarDeclList != NULL) { delete VarDeclList; }
		if(StatementList != NULL) { delete StatementList; }
	}
	void isMethod() {
		MethodFlag = true;
	}
	string str() {
		if(MethodFlag == false) {
			return "Block(" + getString(VarDeclList) + "," + getString(StatementList) + ")";
		} else {
			return "MethodBlock(" + getString(VarDeclList) + "," + getString(StatementList) + ")";
		}
	}
	llvm::Value* Codegen() {
		print_debug(print_debug_flag, "Block Codegen Start.");
		llvm::Value* val;

		symtbl.push_front(symbol_table());

		if(VarDeclList != NULL) {
			VarDeclList->Codegen();
		}
		if(StatementList != NULL) {
			StatementList->Codegen();
		}

		symtbl.pop_front();
		return NULL;
	}
};

class MethodAST : public decafAST {
	string Name;
	string ReturnType;
	decafStmtList* ParamList;
	BlockAST* MethodBlock;
public:
	MethodAST( string name, string return_type, decafStmtList* param_list, BlockAST* method_block)
		: Name(name), ReturnType(return_type), ParamList(param_list), MethodBlock(method_block) {}
	~MethodAST() {
		if(ParamList != NULL) { delete ParamList; }
		if(MethodBlock != NULL) { delete MethodBlock; }
	}
	string str() {
		return "Method(" + Name + "," + ReturnType + "," + getString(ParamList) + "," + getString(MethodBlock) + ")";
	}
	void set_method() {
		llvm::Type* returnTy = get_llvm_type(ReturnType);
		vector<string> args_names;
		vector<llvm::Type*> args_types;
		if(ParamList != NULL) {
			list<decafAST*> stmts = ParamList->get_stmts();
			for(list<decafAST*>::iterator i = stmts.begin(); i != stmts.end(); i++) {
				string ParamName = ((VarDefAST*)(*i))->get_name();
				string ParamType = ((VarDefAST*)(*i))->get_type();
				args_names.push_back(ParamName);
				args_types.push_back(get_llvm_type(ParamType));
			}
		}
		llvm::Function *func = llvm::Function::Create(
    		llvm::FunctionType::get(returnTy, args_types, false),
    		llvm::Function::ExternalLinkage,
    		Name,
    		TheModule
		);
		int index = 0;
		for(auto &Arg : func->args())
    	{
      		Arg.setName(args_names[index++]);
    	}

		(symtbl.front())[Name] = (llvm::Value*)func;
	}
	llvm::Value* Codegen() {
		print_debug(print_debug_flag, "Method Codegen Start.");
		llvm::Function *func = (llvm::Function*)access_symtbl(Name);
    	llvm::Type *returnTy = get_llvm_type(ReturnType);
		llvm::BasicBlock *BB = llvm::BasicBlock::Create(TheContext, "entry", func);
		Builder.SetInsertPoint(BB);

		for (auto &Arg : func->args()) {
			llvm::AllocaInst *Alloca = Builder.CreateAlloca(Arg.getType(), NULL, Arg.getName());
  			// Store the initial value into the alloca.
  			Builder.CreateStore(&Arg, Alloca);
  			// Add to symbol table
			symtbl.front()[Arg.getName()] = (llvm::Value*)Alloca;
		}

		if(MethodBlock != NULL) {MethodBlock->Codegen();}

		if(returnTy->isVoidTy()) {
			Builder.CreateRet(NULL);
		} else if(returnTy->isIntegerTy(32)) {
			Builder.CreateRet(Builder.getInt32(0));
		} else if(returnTy->isIntegerTy(1)) {
			Builder.CreateRet(Builder.getInt1(0));
		}
		
		print_debug(print_debug_flag, "Method Codegen End.");
		return (llvm::Value*)func;
	}
};

class PackageAST : public decafAST {
	string Name;
	decafStmtList *FieldDeclList;
	decafStmtList *MethodDeclList;
public:
	PackageAST(string name, decafStmtList *fieldlist, decafStmtList *methodlist) 
		: Name(name), FieldDeclList(fieldlist), MethodDeclList(methodlist) {}
	~PackageAST() { 
		if (FieldDeclList != NULL) { delete FieldDeclList; }
		if (MethodDeclList != NULL) { delete MethodDeclList; }
	}
	string str() { 
		return string("Package") + "(" + Name + "," + getString(FieldDeclList) + "," + getString(MethodDeclList) + ")";
	}
	llvm::Value *Codegen() { 
		print_debug(print_debug_flag, "Package Codegen Start.");
		llvm::Value *val = NULL;
		TheModule->setModuleIdentifier(llvm::StringRef(Name)); 
		if (NULL != FieldDeclList) {
			val = FieldDeclList->Codegen();
		}
		if (NULL != MethodDeclList) {
			list<decafAST*> stmts = MethodDeclList->get_stmts();
			for (list<decafAST*>::iterator i = stmts.begin(); i != stmts.end(); i++) {
				((MethodAST*)(*i))->set_method();
			}
			val = MethodDeclList->Codegen();
		} 
		// Q: should we enter the class name into the symbol table?
		return val; 
	}
};

/// ProgramAST - the decaf program
class ProgramAST : public decafAST {
	decafStmtList *ExternList;
	PackageAST *PackageDef;
public:
	ProgramAST(decafStmtList *externs, PackageAST *c) : ExternList(externs), PackageDef(c) {}
	~ProgramAST() { 
		if (ExternList != NULL) { delete ExternList; } 
		if (PackageDef != NULL) { delete PackageDef; }
	}
	string str() { return string("Program") + "(" + getString(ExternList) + "," + getString(PackageDef) + ")"; }
	llvm::Value *Codegen() { 
		print_debug(print_debug_flag, "Program Codegen Start.");
		llvm::Value *val = NULL;
		if (NULL != ExternList) {
			val = ExternList->Codegen();
		}
		if (NULL != PackageDef) {
			val = PackageDef->Codegen();
		} else {
			throw runtime_error("no package definition in decaf program");
		}
		print_debug(print_debug_flag, "Program Codegen End.");
		return val; 
	}
};

class rValueAST : public decafAST {
	string Name;
	decafAST* Index;
	bool ExprFlag;
public:
	rValueAST(string name) : Name(name), Index(NULL), ExprFlag(false) {}
	rValueAST(string name, decafAST* index) : Name(name), Index(index), ExprFlag(true) {}
	~rValueAST() {
		if(Index != NULL) { delete Index; }
	}
	bool hasExpr() { return ExprFlag; }
	string getName() { return Name; }
	decafAST* getIndex() { return Index; }
	string str() {
		if(ExprFlag == false) {
			return "VariableExpr(" + Name + ")";
		} else {
			return "ArrayLocExpr(" + Name + "," + getString(Index) + ")";
		}
	}
	llvm::Value* Codegen() {
		llvm::Value* value = access_symtbl(Name);

		if(value != NULL) {
			if(ExprFlag == false) {
				value = Builder.CreateLoad(value, Name);
			} else {
				llvm::GlobalVariable* GV = (llvm::GlobalVariable*)value;
				// llvm::ArrayType* arrayi32 = (llvm::ArrayType*)GV->getType();
				llvm::ArrayType *arrayi32 = (llvm::ArrayType*)access_symtbl(Name + "_arraytype");
				llvm::Value* ArrayLoc = Builder.CreateStructGEP(arrayi32, GV, 0, "arrayloc");
				if(((ConstantAST*)Index)->getType() == "BoolExpr") {
					throw runtime_error("no package definition in decaf program");
				}
				llvm::Value* IndexValue = Index->Codegen();
				llvm::Value* ArrayIndex = Builder.CreateGEP(arrayi32->getElementType(), ArrayLoc, IndexValue, "arrayindex");
				value = Builder.CreateLoad(ArrayIndex, "loadtmp");
			}
		}
		return value;
	}
};

class AssignAST : public decafAST {
	rValueAST* Value;
	decafAST* Expr;
public:
	AssignAST(rValueAST* value, decafAST* expr) : Value(value), Expr(expr) {}
	~AssignAST() {
		if(Value != NULL) { delete Value; }
		if(Expr != NULL) { delete Expr; }
	}
	string str() {
		if(Value->hasExpr() == false) {
			return "AssignVar(" + Value->getName() + "," + getString(Expr) + ")";
		} else {
			return "AssignArrayLoc(" + Value->getName() + "," + getString( Value->getIndex() ) + "," + getString(Expr) + ")";
		}
	}
	llvm::Value* Codegen() {
		llvm::Value* LValue = access_symtbl(Value->getName());

		if(Value->hasExpr()) {
			llvm::GlobalVariable* GV = (llvm::GlobalVariable*)LValue;
			// llvm::ArrayType *arrayi32 = (llvm::ArrayType*)GV->getType();
			llvm::ArrayType *arrayi32 = (llvm::ArrayType*)access_symtbl(Value->getName() + "_arraytype");
			
			llvm::Value* ArrayLoc = Builder.CreateStructGEP(arrayi32, GV, 0, "arrayloc");
			llvm::Value* Index = Value->getIndex()->Codegen();
			llvm::Value* ArrayIndex = Builder.CreateGEP(arrayi32->getElementType(), ArrayLoc, Index, "arrayindex");
			LValue = ArrayIndex;
		}

		llvm::Value* RValue = Expr->Codegen();

		if(LValue->getType()->isIntegerTy(32) && RValue->getType()->isIntegerTy(1)) {
			RValue = Builder.CreateZExt(RValue, Builder.getInt32Ty(), "zexttmp");
		}

		llvm::Value* val;
		const llvm::PointerType *ptrTy = RValue->getType()->getPointerTo();
		if(LValue->getType() == ptrTy) {
			val = Builder.CreateStore(RValue, LValue);
		}
		return val;
	}
};

class MethodCallAST : public decafAST {
	string Name;
	decafStmtList* MethodArgList;
public:
	MethodCallAST(string name, decafStmtList* method_arg_list)
		: Name(name), MethodArgList(method_arg_list) {}
	~MethodCallAST() {
		if(MethodArgList != NULL) { delete MethodArgList; }
	}
	string str() {
		return "MethodCall(" + Name + "," + getString(MethodArgList) + ")";
	}
	llvm::Value* Codegen() {
		llvm::Function* func = (llvm::Function*)access_symtbl(Name);
		vector<llvm::Value*> args_values;
		list<decafAST*> stmts;
		if(MethodArgList != NULL) {
			stmts = MethodArgList->get_stmts();
		}

		if(func != NULL) {
			list<decafAST*>::iterator si;
			llvm::Function::arg_iterator ai;
			for(si = stmts.begin(), ai = func->arg_begin(); si != stmts.end(); si++, ai++) {
				llvm::Type* at = (*ai).getType();
				llvm::Value* arg_value = (*si)->Codegen();

				if(arg_value->getType()->isIntegerTy(1) && at->isIntegerTy(32)) {
					arg_value = Builder.CreateZExt(arg_value, Builder.getInt32Ty(), "zexttmp");
				}

				args_values.push_back(arg_value);
			}
		}
		bool isVoid = func->getReturnType()->isVoidTy();
    	return Builder.CreateCall(func, args_values, isVoid ? "" : "calltmp");
	}
};

class IfStmtAST : public decafAST {
	decafAST* Condition;
	BlockAST* IfBlock;
	BlockAST* ElseBlock;
public:
	IfStmtAST(decafAST* condition, BlockAST* if_block, BlockAST* else_block)
		: Condition(condition), IfBlock(if_block), ElseBlock(else_block) {}
	~IfStmtAST() {
		if (Condition != NULL) { delete Condition; }
		if (IfBlock != NULL) { delete IfBlock; }
		if (ElseBlock != NULL) { delete ElseBlock; }
	}
	string str() {
		return "IfStmt(" + getString(Condition) + "," + getString(IfBlock) + "," + getString(ElseBlock) + ")";
	}
	llvm::Value* Codegen() {
		llvm::Function* func = Builder.GetInsertBlock()->getParent();

		llvm::BasicBlock* IfStartBB = llvm::BasicBlock::Create(TheContext, "ifstart", func);
		llvm::BasicBlock* IfTrueBB = llvm::BasicBlock::Create(TheContext, "iftrue", func);
		llvm::BasicBlock* IfFalseBB = llvm::BasicBlock::Create(TheContext, "iffalse", func);
		
		symtbl.push_front(symbol_table());
		symtbl.front()["ifstart"] = IfStartBB;
		symtbl.front()["iftrue"] = IfTrueBB;
		symtbl.front()["iffalse"] = IfFalseBB;
		

		Builder.CreateBr(IfStartBB);
		Builder.SetInsertPoint(IfStartBB);

		llvm::Value* cond = Condition->Codegen();
		Builder.CreateCondBr(cond, IfTrueBB, IfFalseBB);

		Builder.SetInsertPoint(IfTrueBB);
		IfBlock->Codegen();
		if(ElseBlock != NULL) {
			llvm::BasicBlock* EndBB = llvm::BasicBlock::Create(TheContext, "end", func);
			Builder.CreateBr(EndBB);
			symtbl.front()["end"] = EndBB;
			Builder.SetInsertPoint(IfFalseBB);
			ElseBlock->Codegen();
			Builder.CreateBr(EndBB);
			Builder.SetInsertPoint(EndBB);
		} else {
			Builder.CreateBr(IfFalseBB);
			Builder.SetInsertPoint(IfFalseBB);
		}
		symtbl.pop_front();

		return NULL;
	}
};

class WhileStmtAST : public decafAST {
	decafAST* Condition;
	BlockAST* WhileBlock;
public:
	WhileStmtAST(decafAST* condition, BlockAST* while_block)
		: Condition(condition), WhileBlock(while_block) {}
	~WhileStmtAST() {
		if (Condition != NULL) { delete Condition; }
		if (WhileBlock != NULL) { delete WhileBlock; }
	}
	string str() {
		return "WhileStmt(" + getString(Condition) + "," + getString(WhileBlock) + ")";
	}
	llvm::Value* Codegen() {
		llvm::Function* func = Builder.GetInsertBlock()->getParent();
		
		llvm::BasicBlock* WhileStartBB = llvm::BasicBlock::Create(TheContext, "whilestart", func);
		llvm::BasicBlock* WhileTrueBB = llvm::BasicBlock::Create(TheContext, "whiletrue", func);
		llvm::BasicBlock* WhileEndBB = llvm::BasicBlock::Create(TheContext, "whileend", func);
		
		symtbl.push_front(symbol_table());
		symtbl.front()["loopstart"] = WhileStartBB;
		symtbl.front()["loopnext"] = WhileStartBB;
		symtbl.front()["looptrue"] = WhileTrueBB;
		symtbl.front()["loopend"] = WhileEndBB;

		Builder.CreateBr(WhileStartBB);
		Builder.SetInsertPoint(WhileStartBB);
		
		llvm::Value* cond = Condition->Codegen();
		Builder.CreateCondBr(cond, WhileTrueBB, WhileEndBB);

		Builder.SetInsertPoint(WhileTrueBB);
		WhileBlock->Codegen();
		Builder.CreateBr(WhileStartBB);
		symtbl.pop_front();

		Builder.SetInsertPoint(WhileEndBB);

		return NULL;
	}
};

class ForStmtAST : public decafAST {
	decafStmtList* PreAssignList;
	decafAST* Condition;
	decafStmtList* LoopAssignList;
	BlockAST* ForBlock;
public:
	ForStmtAST(decafStmtList* pre_assign_list, decafAST* condition, decafStmtList* loop_assign_list, BlockAST* for_block)
		: PreAssignList(pre_assign_list), Condition(condition), LoopAssignList(loop_assign_list), ForBlock(for_block) {}
	~ForStmtAST() {
		if (PreAssignList != NULL) { delete PreAssignList; }
		if (Condition != NULL) { delete Condition; }
		if (LoopAssignList != NULL) { delete LoopAssignList; }
		if (ForBlock != NULL) { delete ForBlock; }
	}
	string str() {
		return "ForStmt(" + getString(PreAssignList) + "," + getString(Condition) + ","
				+ getString(LoopAssignList) + "," + getString(ForBlock) + ")";
	}
	llvm::Value* Codegen() {
		llvm::Function* func = Builder.GetInsertBlock()->getParent();

		llvm::BasicBlock* ForStartBB = llvm::BasicBlock::Create(TheContext, "forstart", func);
		llvm::BasicBlock* ForTrueBB = llvm::BasicBlock::Create(TheContext, "fortrue", func);
		llvm::BasicBlock* ForNextBB = llvm::BasicBlock::Create(TheContext, "fornext", func);
		llvm::BasicBlock* ForEndBB = llvm::BasicBlock::Create(TheContext, "forend", func);
		
		symtbl.push_front(symbol_table());
		symtbl.front()["loopstart"] = ForStartBB;
		symtbl.front()["looptrue"] = ForTrueBB;
		symtbl.front()["loopnext"] = ForNextBB;
		symtbl.front()["loopend"] = ForEndBB;

		PreAssignList->Codegen();
		Builder.CreateBr(ForStartBB);
		Builder.SetInsertPoint(ForStartBB);

		llvm::Value* cond = Condition->Codegen();
		Builder.CreateCondBr(cond, ForTrueBB, ForEndBB);

		Builder.SetInsertPoint(ForTrueBB);
		ForBlock->Codegen();
		Builder.CreateBr(ForNextBB);

		Builder.SetInsertPoint(ForNextBB);
		LoopAssignList->Codegen();
		Builder.CreateBr(ForStartBB);
		symtbl.pop_front();

		Builder.SetInsertPoint(ForEndBB);

		return NULL;
	}
};

class ReturnStmtAST : public decafAST {
	decafAST* ReturnValue;
public:
	ReturnStmtAST(decafAST* return_value) : ReturnValue(return_value) {}
	~ReturnStmtAST() {
		if (ReturnValue != NULL) { delete ReturnValue; }
	}
	string str() {
		return "ReturnStmt(" + getString(ReturnValue) + ")";
	}
	llvm::Value* Codegen() {
		llvm::Value* val;
		if(ReturnValue != NULL) {
			val = ReturnValue->Codegen();
			Builder.CreateRet(val);
		}
		return val;
	}
};

class BreakStmtAST : public decafAST {
public:
	string str() { return "BreakStmt"; }
	llvm::Value *Codegen() {
		llvm::BasicBlock* LoopEndBB = (llvm::BasicBlock*)access_symtbl("loopend");
		if(LoopEndBB != NULL) {
			Builder.CreateBr(LoopEndBB);
		} else {
			throw runtime_error("invalid break statement");
		}
		return NULL;
	}
};

class ContinueStmtAST : public decafAST {
public:
	string str() { return "ContinueStmt"; }
	llvm::Value *Codegen() {
		llvm::BasicBlock* LoopStartBB = (llvm::BasicBlock*)access_symtbl("loopnext");
		if(LoopStartBB != NULL) {
			Builder.CreateBr(LoopStartBB);
		} else {
			throw runtime_error("invalid continue statement");
		}
		return NULL;
	}
};

class BinaryExprAST : public decafAST {
	string Op;
	decafAST* LeftValue;
	decafAST* RightValue;
public:
	BinaryExprAST(string op, decafAST* left_value, decafAST* right_value)
		: Op(op), LeftValue(left_value), RightValue(right_value) {}
	~BinaryExprAST() {
		if (LeftValue != NULL) { delete LeftValue; }
		if (RightValue != NULL) { delete RightValue; }
	}
	string str() {
		return "BinaryExpr(" + Op + "," + getString(LeftValue) + "," + getString(RightValue) + ")";
	}
	llvm::Value* Codegen() {
		llvm::Value* val;
		llvm::Value* LValue;
		llvm::Value* RValue;
		llvm::BasicBlock* CurBB;
		llvm::Function* func;
		llvm::BasicBlock* RightBB;
		llvm::BasicBlock* ResultBB;

		if(Op != "And"  && Op != "Or") {
			LValue = LeftValue->Codegen();
			RValue = RightValue->Codegen();
		} else {
			//short circuit
			CurBB = Builder.GetInsertBlock();
      		func = CurBB->getParent();
			RightBB = llvm::BasicBlock::Create(TheContext, "noskct", func);
			ResultBB = llvm::BasicBlock::Create(TheContext, "skctend", func);
		}

		if(Op == "And") {
			LValue = LeftValue->Codegen();
			CurBB = Builder.GetInsertBlock();
			Builder.CreateCondBr(LValue, RightBB, ResultBB);
			
			Builder.SetInsertPoint(RightBB);
			RValue = RightValue->Codegen();
			Builder.CreateBr(ResultBB);
			
			Builder.SetInsertPoint(ResultBB);
			llvm::PHINode *phival = Builder.CreatePHI(LValue->getType(), 2, "phival");

			phival->addIncoming(LValue, CurBB);
			phival->addIncoming(RValue, RightBB);
			
			val = (llvm::Value*)phival;
		}
		else if(Op == "Or") {
			LValue = LeftValue->Codegen();
			CurBB = Builder.GetInsertBlock();
			Builder.CreateCondBr(LValue, ResultBB, RightBB);

			Builder.SetInsertPoint(RightBB);
			RValue = RightValue->Codegen();
			RightBB = Builder.GetInsertBlock();
			Builder.CreateBr(ResultBB);

			Builder.SetInsertPoint(ResultBB);
			llvm::PHINode *phival = Builder.CreatePHI(LValue->getType(), 2, "phival");
			phival->addIncoming(LValue, CurBB);
			phival->addIncoming(RValue, RightBB);
			
			val = (llvm::Value*)phival;
		}
		else if(Op == "Plus") {
			val = Builder.CreateAdd(LValue,RValue,"addtmp");
		}
		else if(Op == "Minus") {
			val = Builder.CreateSub(LValue,RValue,"subtmp");
		}
		else if(Op == "Mult") {
			val = Builder.CreateMul(LValue,RValue,"multmp");
		}
		else if(Op == "Div") {
			val = Builder.CreateSDiv(LValue,RValue,"divtmp");
		}
		else if(Op == "Leftshift") {
			val = Builder.CreateShl(LValue,RValue,"lstmp");
		}
		else if(Op == "Rightshift") {
			val = Builder.CreateLShr(LValue,RValue,"rstmp");
		}
		else if(Op == "Mod") {
			val = Builder.CreateSRem(LValue,RValue,"modtmp");
		}
		else if(Op == "Eq") {
			val = Builder.CreateICmpEQ(LValue,RValue,"eqtmp");
		}
		else if(Op == "Neq") {
			val = Builder.CreateICmpNE(LValue,RValue,"neqtmp");
		}
		else if(Op == "Lt") {
			val = Builder.CreateICmpSLT(LValue,RValue,"lttmp");
		}
		else if(Op == "Leq") {
			val = Builder.CreateICmpSLE(LValue,RValue,"leqtmp");
		}
		else if(Op == "Gt") {
			val = Builder.CreateICmpSGT(LValue,RValue,"gttmp");
		}
		else if(Op == "Geq") {
			val = Builder.CreateICmpSGE(LValue,RValue,"geqtmp");
		}

		return val;
	}
};

class UnaryExprAST : public decafAST {
	string Op;
	decafAST* Value;
public:
	UnaryExprAST(string op, decafAST* value) : Op(op), Value(value) {}
	~UnaryExprAST() {
		if (Value != NULL) { delete Value; }
	}
	string str() {
		return "UnaryExpr(" + Op + "," + getString(Value) + ")";
	}
	llvm::Value* Codegen() {
		llvm::Value* val;
		llvm::Value* RValue = Value->Codegen();
		if(Op == "UnaryMinus") {
			val = Builder.CreateNeg(RValue,"negtmp");
		}
		else if(Op == "Not") {
			val = Builder.CreateNot(RValue,"nottmp");
		}
		return val;
	}
};