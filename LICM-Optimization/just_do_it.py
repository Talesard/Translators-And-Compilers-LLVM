import os
# stock - copy
# mod - first
LLVM_BIN_STOCK = '~/repos/llvm-project-copy/build/bin/'
LLVM_BIN_MOD = '~/repos/llvm-project/build/bin/'

try:
    os.mkdir('asm')
except:
    pass

try:
    os.mkdir('bin')
except:
    pass

try:
    os.mkdir('bc')
except:
    pass

try:
    os.mkdir('llvmir')
except:
    pass

try:
    os.mkdir('asm/o0')
except:
    pass

try:
    os.mkdir('asm/o1')
except:
    pass

try:
    os.mkdir('asm/o1_mod')
except:
    pass

try:
    os.mkdir('bin/o0')
except:
    pass

try:
    os.mkdir('bin/o1')
except:
    pass

try:
    os.mkdir('bin/o1_mod')
except:
    pass

try:
    os.mkdir('bc/o0')
except:
    pass

try:
    os.mkdir('bc/o1')
except:
    pass

try:
    os.mkdir('bc/o1_mod')
except:
    pass

try:
    os.mkdir('llvmir/o0')
except:
    pass

try:
    os.mkdir('llvmir/o1')
except:
    pass

try:
    os.mkdir('llvmir/o1_mod')
except:
    pass

print('===== STOCK LLVM =====')
print('ASM -O0')
os.system(f'{LLVM_BIN_STOCK}clang++ -O0 -S licm_5.cpp -o asm/o0/licm_5_o0.asm')
os.system(f'{LLVM_BIN_STOCK}clang++ -O0 -S licm_10.cpp -o asm/o0/licm_10_o0.asm')
os.system(f'{LLVM_BIN_STOCK}clang++ -O0 -S licm_20.cpp -o asm/o0/licm_20_o0.asm')
os.system(f'{LLVM_BIN_STOCK}clang++ -O0 -S licm_div_5.cpp -o asm/o0/licm_div_5_o0.asm')
os.system(f'{LLVM_BIN_STOCK}clang++ -O0 -S licm_div_10.cpp -o asm/o0/licm_div_10_o0.asm')
os.system(f'{LLVM_BIN_STOCK}clang++ -O0 -S licm_div_20.cpp -o asm/o0/licm_div_20_o0.asm')

print('LLVM IR -O0')
os.system(f'{LLVM_BIN_STOCK}clang++ -O0 licm_5.cpp -emit-llvm -c -o bc/o0/licm_5_o0.bc')
os.system(f'{LLVM_BIN_STOCK}llvm-dis bc/o0/licm_5_o0.bc -o llvmir/o0/licm_5_o0.ll')
os.system(f'{LLVM_BIN_STOCK}clang++ -O0 licm_10.cpp -emit-llvm -c -o bc/o0/licm_10_o0.bc')
os.system(f'{LLVM_BIN_STOCK}llvm-dis bc/o0/licm_10_o0.bc -o llvmir/o0/licm_10_o0.ll')
os.system(f'{LLVM_BIN_STOCK}clang++ -O0 licm_20.cpp -emit-llvm -c -o bc/o0/licm_20_o0.bc')
os.system(f'{LLVM_BIN_STOCK}llvm-dis bc/o0/licm_20_o0.bc -o llvmir/o0/licm_20_o0.ll')
os.system(f'{LLVM_BIN_STOCK}clang++ -O0 licm_div_5.cpp -emit-llvm -c -o bc/o0/licm_div_5_o0.bc')
os.system(f'{LLVM_BIN_STOCK}llvm-dis bc/o0/licm_div_5_o0.bc -o llvmir/o0/licm_div_5_o0.ll')
os.system(f'{LLVM_BIN_STOCK}clang++ -O0 licm_div_10.cpp -emit-llvm -c -o bc/o0/licm_div_10_o0.bc')
os.system(f'{LLVM_BIN_STOCK}llvm-dis bc/o0/licm_div_10_o0.bc -o llvmir/o0/licm_div_10_o0.ll')
os.system(f'{LLVM_BIN_STOCK}clang++ -O0 licm_div_20.cpp -emit-llvm -c -o bc/o0/licm_div_20_o0.bc')
os.system(f'{LLVM_BIN_STOCK}llvm-dis bc/o0/licm_div_20_o0.bc -o llvmir/o0/licm_div_20_o0.ll')


print('BIN -O0')
os.system(f'{LLVM_BIN_STOCK}clang++ -O0 licm_5.cpp -o bin/o0/licm_5_o0')
os.system(f'{LLVM_BIN_STOCK}clang++ -O0 licm_10.cpp -o bin/o0/licm_10_o0')
os.system(f'{LLVM_BIN_STOCK}clang++ -O0 licm_20.cpp -o bin/o0/licm_20_o0')
os.system(f'{LLVM_BIN_STOCK}clang++ -O0 licm_div_5.cpp -o bin/o0/licm_div_5_o0')
os.system(f'{LLVM_BIN_STOCK}clang++ -O0 licm_div_10.cpp -o bin/o0/licm_div_10_o0')
os.system(f'{LLVM_BIN_STOCK}clang++ -O0 licm_div_20.cpp -o bin/o0/licm_div_20_o0')

print('ASM -O1')
os.system(f'{LLVM_BIN_STOCK}clang++ -O1 -S licm_5.cpp -o asm/o1/licm_5_o1.asm')
os.system(f'{LLVM_BIN_STOCK}clang++ -O1 -S licm_10.cpp -o asm/o1/licm_10_o1.asm')
os.system(f'{LLVM_BIN_STOCK}clang++ -O1 -S licm_20.cpp -o asm/o1/licm_20_o1.asm')
os.system(f'{LLVM_BIN_STOCK}clang++ -O1 -S licm_div_5.cpp -o asm/o1/licm_div_5_o1.asm')
os.system(f'{LLVM_BIN_STOCK}clang++ -O1 -S licm_div_10.cpp -o asm/o1/licm_div_10_o1.asm')
os.system(f'{LLVM_BIN_STOCK}clang++ -O1 -S licm_div_20.cpp -o asm/o1/licm_div_20_o1.asm')

print('LLVM IR -O1')
os.system(f'{LLVM_BIN_STOCK}clang++ -O1 licm_5.cpp -emit-llvm -c -o bc/o1/licm_5_o1.bc')
os.system(f'{LLVM_BIN_STOCK}llvm-dis bc/o1/licm_5_o1.bc -o llvmir/o1/licm_5_o1.ll')
os.system(f'{LLVM_BIN_STOCK}clang++ -O1 licm_10.cpp -emit-llvm -c -o bc/o1/licm_10_o1.bc')
os.system(f'{LLVM_BIN_STOCK}llvm-dis bc/o1/licm_10_o1.bc -o llvmir/o1/licm_10_o1.ll')
os.system(f'{LLVM_BIN_STOCK}clang++ -O1 licm_20.cpp -emit-llvm -c -o bc/o1/licm_20_o1.bc')
os.system(f'{LLVM_BIN_STOCK}llvm-dis bc/o1/licm_20_o1.bc -o llvmir/o1/licm_20_o1.ll')
os.system(f'{LLVM_BIN_STOCK}clang++ -O1 licm_div_5.cpp -emit-llvm -c -o bc/o1/licm_div_5_o1.bc')
os.system(f'{LLVM_BIN_STOCK}llvm-dis bc/o1/licm_div_5_o1.bc -o llvmir/o1/licm_div_5_o1.ll')
os.system(f'{LLVM_BIN_STOCK}clang++ -O1 licm_div_10.cpp -emit-llvm -c -o bc/o1/licm_div_10_o1.bc')
os.system(f'{LLVM_BIN_STOCK}llvm-dis bc/o1/licm_div_10_o1.bc -o llvmir/o1/licm_div_10_o1.ll')
os.system(f'{LLVM_BIN_STOCK}clang++ -O1 licm_div_20.cpp -emit-llvm -c -o bc/o1/licm_div_20_o1.bc')
os.system(f'{LLVM_BIN_STOCK}llvm-dis bc/o1/licm_div_20_o1.bc -o llvmir/o1/licm_div_20_o1.ll')

print('BIN -O1')
os.system(f'{LLVM_BIN_STOCK}clang++ -O1 licm_5.cpp -o bin/o1/licm_5_o1')
os.system(f'{LLVM_BIN_STOCK}clang++ -O1 licm_10.cpp -o bin/o1/licm_10_o1')
os.system(f'{LLVM_BIN_STOCK}clang++ -O1 licm_20.cpp -o bin/o1/licm_20_o1')
os.system(f'{LLVM_BIN_STOCK}clang++ -O1 licm_div_5.cpp -o bin/o1/licm_div_5_o1')
os.system(f'{LLVM_BIN_STOCK}clang++ -O1 licm_div_10.cpp -o bin/o1/licm_div_10_o1')
os.system(f'{LLVM_BIN_STOCK}clang++ -O1 licm_div_20.cpp -o bin/o1/licm_div_20_o1')

print('===== ========== =====')
print('\n')
print('====== MOD LLVM ======')
print('ASM -O1 MOD')
os.system(f'{LLVM_BIN_MOD}clang++ -O1 -S licm_5.cpp -o asm/o1_mod/licm_5_o1_mod.asm')
os.system(f'{LLVM_BIN_MOD}clang++ -O1 -S licm_10.cpp -o asm/o1_mod/licm_10_o1_mod.asm')
os.system(f'{LLVM_BIN_MOD}clang++ -O1 -S licm_20.cpp -o asm/o1_mod/licm_20_o1_mod.asm')
os.system(f'{LLVM_BIN_MOD}clang++ -O1 -S licm_div_5.cpp -o asm/o1_mod/licm_div_5_o1_mod.asm')
os.system(f'{LLVM_BIN_MOD}clang++ -O1 -S licm_div_10.cpp -o asm/o1_mod/licm_div_10_o1_mod.asm')
os.system(f'{LLVM_BIN_MOD}clang++ -O1 -S licm_div_20.cpp -o asm/o1_mod/licm_div_20_o1_mod.asm')

print('LLVM IR -O1 MOD')
os.system(f'{LLVM_BIN_MOD}clang++ -O1 licm_5.cpp -emit-llvm -c -o bc/o1_mod/licm_5_o1_mod.bc')
os.system(f'{LLVM_BIN_MOD}llvm-dis bc/o1_mod/licm_5_o1_mod.bc -o llvmir/o1_mod/licm_5_o1_mod.ll')
os.system(f'{LLVM_BIN_MOD}clang++ -O1 licm_10.cpp -emit-llvm -c -o bc/o1_mod/licm_10_o1_mod.bc')
os.system(f'{LLVM_BIN_MOD}llvm-dis bc/o1_mod/licm_10_o1_mod.bc -o llvmir/o1_mod/licm_10_o1_mod.ll')
os.system(f'{LLVM_BIN_MOD}clang++ -O1 licm_20.cpp -emit-llvm -c -o bc/o1_mod/licm_20_o1_mod.bc')
os.system(f'{LLVM_BIN_MOD}llvm-dis bc/o1_mod/licm_20_o1_mod.bc -o llvmir/o1_mod/licm_20_o1_mod.ll')
os.system(f'{LLVM_BIN_MOD}clang++ -O1 licm_div_5.cpp -emit-llvm -c -o bc/o1_mod/licm_div_5_o1_mod.bc')
os.system(f'{LLVM_BIN_MOD}llvm-dis bc/o1_mod/licm_div_5_o1_mod.bc -o llvmir/o1_mod/licm_div_5_o1_mod.ll')
os.system(f'{LLVM_BIN_MOD}clang++ -O1 licm_div_10.cpp -emit-llvm -c -o bc/o1_mod/licm_div_10_o1_mod.bc')
os.system(f'{LLVM_BIN_MOD}llvm-dis bc/o1_mod/licm_div_10_o1_mod.bc -o llvmir/o1_mod/licm_div_10_o1_mod.ll')
os.system(f'{LLVM_BIN_MOD}clang++ -O1 licm_div_20.cpp -emit-llvm -c -o bc/o1_mod/licm_div_20_o1_mod.bc')
os.system(f'{LLVM_BIN_MOD}llvm-dis bc/o1_mod/licm_div_20_o1_mod.bc -o llvmir/o1_mod/licm_div_20_o1_mod.ll')

print('BIN -O1 MOD')
os.system(f'{LLVM_BIN_MOD}clang++ -O1 licm_5.cpp -o bin/o1_mod/licm_5_o1_mod')
os.system(f'{LLVM_BIN_MOD}clang++ -O1 licm_10.cpp -o bin/o1_mod/licm_10_o1_mod')
os.system(f'{LLVM_BIN_MOD}clang++ -O1 licm_20.cpp -o bin/o1_mod/licm_20_o1_mod')
os.system(f'{LLVM_BIN_MOD}clang++ -O1 licm_div_5.cpp -o bin/o1_mod/licm_div_5_o1_mod')
os.system(f'{LLVM_BIN_MOD}clang++ -O1 licm_div_10.cpp -o bin/o1_mod/licm_div_10_o1_mod')
os.system(f'{LLVM_BIN_MOD}clang++ -O1 licm_div_20.cpp -o bin/o1_mod/licm_div_20_o1_mod')

print('====== === ==== ======')