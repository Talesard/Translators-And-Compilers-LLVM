import os

N = "13"
FUNC = '_ZN8testFunc3runEv' # ?run@testFunc@@QEAAXXZ
LLVM_BIN = '~/repos/llvm-project/build/bin/' # may be = '' if you want use default

print("Без векторизации, без раскрутки")
os.system(f'{LLVM_BIN}clang++ -O3 -fno-vectorize -fno-unroll-loops -I./loops/vectorizable/ -DINCLUDE_TEST=\\"test{N}.hpp\\" test.cpp -emit-llvm -c -o test{N}.bc')
os.system(f'{LLVM_BIN}llvm-extract -func={FUNC} test{N}.bc -o run-fn.bc')
os.system(f'{LLVM_BIN}llvm-dis run-fn.bc -o run-fn_novec_nounroll.ll')
os.system(f'{LLVM_BIN}clang++ -O3 -fno-vectorize -fno-unroll-loops -Rpass=loop-vectorize ./benchmark_app/main.cpp -I ./loops/vectorizable/ -DINCLUDE_TEST=\\"test{N}.hpp\\" -o ./benchmark_app_novec_nounroll.exe')
os.system('./benchmark_app_novec_nounroll.exe')

print('\n\n\n\nБез векторизации, с раскруткой')
os.system(f'{LLVM_BIN}clang++ -O3 -fno-vectorize -Rpass=loop-vectorize -I./loops/vectorizable/ -DINCLUDE_TEST=\\"test{N}.hpp\\" test.cpp -emit-llvm -c -o test{N}.bc')
os.system(f'{LLVM_BIN}llvm-extract -func={FUNC} test{N}.bc -o run-fn.bc')
os.system(f'{LLVM_BIN}llvm-dis run-fn.bc -o run-fn_novec_yesunroll.ll')
os.system(f'{LLVM_BIN}clang++ -O3 -fno-vectorize -Rpass=loop-vectorize ./benchmark_app/main.cpp -I ./loops/vectorizable/ -DINCLUDE_TEST=\\"test{N}.hpp\\" -o ./benchmark_app_novec_yesunroll.exe')
os.system('./benchmark_app_novec_yesunroll.exe')

print('\n\n\n\nС векторизацией, без раскрутки')
os.system(f'{LLVM_BIN}clang++ -O3 -fno-unroll-loops -Rpass=loop-vectorize -I./loops/vectorizable/ -DINCLUDE_TEST=\\"test{N}.hpp\\" test.cpp -emit-llvm -c -o test{N}.bc')
os.system(f'{LLVM_BIN}llvm-extract -func={FUNC} test{N}.bc -o run-fn.bc')
os.system(f'{LLVM_BIN}llvm-dis run-fn.bc -o run-fn_yesvec_nounroll.ll')
os.system(f'{LLVM_BIN}clang++ -O3 -fno-unroll-loops -Rpass=loop-vectorize ./benchmark_app/main.cpp -I ./loops/vectorizable/ -DINCLUDE_TEST=\\"test{N}.hpp\\" -o ./benchmark_app_yesvec_nounroll.exe')
os.system('./benchmark_app_yesvec_nounroll.exe')

print('\n\n\n\nС векторизацией, с раскруткой')
os.system(f'{LLVM_BIN}clang++ -O3 -Rpass=loop-vectorize -I./loops/vectorizable/ -DINCLUDE_TEST=\\"test{N}.hpp\\" test.cpp -emit-llvm -c -o test{N}.bc')
os.system(f'{LLVM_BIN}llvm-extract -func={FUNC} test{N}.bc -o run-fn.bc')
os.system(f'{LLVM_BIN}llvm-dis run-fn.bc -o run-fn_yesvec_yesunroll.ll')
os.system(f'{LLVM_BIN}clang++ -O3 -Rpass=loop-vectorize ./benchmark_app/main.cpp -I ./loops/vectorizable/ -DINCLUDE_TEST=\\"test{N}.hpp\\" -o ./benchmark_app_yesvec_yesunroll.exe')
os.system('./benchmark_app_yesvec_yesunroll.exe')