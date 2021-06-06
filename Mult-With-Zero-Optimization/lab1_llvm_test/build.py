import os

print("--->baseline.ll")
x = os.system("~/repos/llvm-project/build/bin/clang++ -O0 -emit-llvm -S -c main.cpp -o /dev/stdout | sed 's/ optnone//g' > baseline.ll")
if not x: print("ok")

print("--->baseline executable")
x = os.system("~/repos/llvm-project/build/bin/clang++ baseline.ll -o baseline")
if not x: print("ok")

print("--->optimized.ll")
x = os.system("~/repos/llvm-project/build/bin/opt -load ~/repos/llvm-project/build/lib/MultWithZeroLab1.so -multwithzero < baseline.ll -S -o optimized.ll")
if not x: print("ok")

x = print("--->optimized executable")
os.system(" ~/repos/llvm-project/build/bin/clang++ optimized.ll -o optimized")
if not x: print("ok")
