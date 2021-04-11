# Scripts
Here are several scripts that helps streamline parts of the process.

## Reference

| Attempt     | description                                                  | args                               | output                                                       |
| ----------- | ------------------------------------------------------------ | ---------------------------------- | ------------------------------------------------------------ |
| build.sh    | Builds the project and runs against testcases in `testcases` directory | 0                                  | None                                                         |
| evaluate.sh | Compares all the project's output files in `output` directory against the given references in `reference` directory to find any failing tests, and where the difference occurs | 0                                  | None if all outputs are correct, file name and position of difference if failure occurred |
| result.sh   | Provides outputs for user to compare their output against the reference output, as well as the used test case | 1..* (file name without extension) | Provides the project's original test case, reference output, and the project's output |

## Usage
Here are several use-case examples of the scripts:

`Note: These examples assume you are executing the scripts from the project's root directory`

### Example 1

Input
```
./scripts/build.sh
```
Output
```
compiling cpp yacc file: decafcomp.y
output file: decafcomp
bison -b decafcomp -d decafcomp.y
/bin/mv -f decafcomp.tab.c decafcomp.tab.cc
flex -odecafcomp.lex.cc decafcomp.lex
clang -g -c decaf-stdlib.c
clang++ -Wno-deprecated-register -o ./decafcomp decafcomp.tab.cc decafcomp.lex.cc decaf-stdlib.o -I/usr/lib/llvm-7/include  -fno-exceptions -D_GNU_SOURCE -D__STDC_CONSTANT_MACROS -D__STDC_FORMAT_MACROS -D__STDC_LIMIT_MACROS -I/usr/lib/llvm-7/include -D_GNU_SOURCE -D__STDC_CONSTANT_MACROS -D__STDC_FORMAT_MACROS -D__STDC_LIMIT_MACROS -I/usr/lib/llvm-7/include -D_GNU_SOURCE -D__STDC_CONSTANT_MACROS -D__STDC_FORMAT_MACROS -D__STDC_LIMIT_MACROS -L/usr/lib/llvm-7/lib  -lLLVM-7 -ly -ll -lz -lncurses -ldl -lpthread -fcxx-exceptions
/bin/rm -f decafcomp.tab.h decafcomp.tab.cc decafcomp.lex.cc 
running on dev files
Warning: output/dev already exists. Existing files will be over-written.
running on test files
Warning: output/test already exists. Existing files will be over-written.
/home/alex_wang_10/repos/cmpt379-1207-ywa340/decafcomp/output.zip created
Correct(dev): 208 / 208
Score(dev): 208.00
Total Score: 208.00
```

### Example 2

Input
```
./scripts/evaluate.sh
```
Output
```
fshadow
0,                                                            | 0,
if-scoping
0,                                                            | 0,
```

### Example 3

General Input
```
./scripts/result.sh {filename1} {filenam2}..
```
Specific Input
```
./scripts/result.sh gcd
```
Output
```
---- Original ----
extern func print_int(int) void;

package GreatestCommonDivisor {
    var a int = 10;
    var b int = 20;

    func main() int {
        var x, y, z int;
        x = a;
        y = b;
        z = gcd(x, y);

        // print_int is part of the standard input-output library
        print_int(z);
    }

    // function that computes the greatest common divisor
    func gcd(a int, b int) int {
        if (b == 0) { return(a); }
        else { return( gcd(b, a % b) ); }
    }
}
---- Expected ----
10
---- Actual ----
10
```

Be cautious that you do not input file names that don't exist inside references/dev. If so, the script will fail.

## Example 4
Piping evaluate and result together to show the result of all files that aren't identical. This way you don't need to manually input every single file name into result.sh.

Input
```
./scripts/evaluate.sh | xargs ./contrib/result.sh
```
Output
```
0,                                                            | 0,
0,                                                            | 0,
---- Original ----

extern func print_string(string) void;
extern func print_int(int) void;

package byone {
  func i(i int) int {
    {
      var i int;
      i = 0;
      if (2 > i) {
        var i int;
        i = 2;
      }
      if (2 < i) {
      } else {
        var i int;
        i = 6;
      }
      print_int(i); print_string(",\r\n");
      return(0);
    }
  }
  func main() int {
    var i int;
    print_string("hello\n");
    i = 0;
    if (2 > i) {
      var i int;
      i = 2;
    }
    if (2 < i) {
    } else {
      var i int;
      i = 6;
    }
    print_int(i); print_string(",\r\n");
  }
}

---- Expected ----
hello
0,
---- Actual ----
hello
0,


---- Original ----

extern func print_string(string) void;
extern func print_int(int) void;

package byone {
  var fin[20] int;
  func main() int {
    var i int;
    print_string("hello\n");
    i = 0;
    if (2 > i) {
      var i int;
      i = 2;
    }
    if (2 < i) {
    } else {
      var i int;
      i = 6;
    }
    print_int(i); print_string(",\r\n");
  }
}

---- Expected ----
hello
0,
---- Actual ----
hello
0,
```
