cd answer
rm decafcomp
make decafcomp
cd ..
./answer/llvm-run testcases/dev/err-bool-index.decaf
