import os

print('[PREPARING]')
print('ПЕРЕД ТЕСТОМ ОТКЛЮЧИТЬ ТУРБОБУСТ ВРУЧНУЮ!')
print('sudo echo 1 > /sys/devices/system/cpu/intel_pstate/no_turbo')
print('ПОСЛЕ ТЕСТА ВКЛЮЧИТЬ ТУРБОБУСТ!')
print('sudo echo 0 > /sys/devices/system/cpu/intel_pstate/no_turbo')
os.system('sudo cset shield -c 1,1 -k on')


print('[BENCH -O0]')
os.system('sudo cset shield --exec -- perf stat -r 10 ./bin/o0/licm_5_o0')
os.system('sudo cset shield --exec -- perf stat -r 10 ./bin/o0/licm_10_o0')
os.system('sudo cset shield --exec -- perf stat -r 10 ./bin/o0/licm_20_o0')
os.system('sudo cset shield --exec -- perf stat -r 10 ./bin/o0/licm_div_5_o0')
os.system('sudo cset shield --exec -- perf stat -r 10 ./bin/o0/licm_div_10_o0')
os.system('sudo cset shield --exec -- perf stat -r 10 ./bin/o0/licm_div_20_o0')

print('[BENCH -O1]')
os.system('sudo cset shield --exec -- perf stat -r 10 ./bin/o1/licm_5_o1')
os.system('sudo cset shield --exec -- perf stat -r 10 ./bin/o1/licm_10_o1')
os.system('sudo cset shield --exec -- perf stat -r 10 ./bin/o1/licm_20_o1')
os.system('sudo cset shield --exec -- perf stat -r 10 ./bin/o1/licm_div_5_o1')
os.system('sudo cset shield --exec -- perf stat -r 10 ./bin/o1/licm_div_10_o1')
os.system('sudo cset shield --exec -- perf stat -r 10 ./bin/o1/licm_div_20_o1')

print('[BENCH -O1 MOD]')
os.system('sudo cset shield --exec -- perf stat -r 10 ./bin/o1_mod/licm_5_o1_mod')
os.system('sudo cset shield --exec -- perf stat -r 10 ./bin/o1_mod/licm_10_o1_mod')
os.system('sudo cset shield --exec -- perf stat -r 10 ./bin/o1_mod/licm_20_o1_mod')
os.system('sudo cset shield --exec -- perf stat -r 10 ./bin/o1_mod/licm_div_5_o1_mod')
os.system('sudo cset shield --exec -- perf stat -r 10 ./bin/o1_mod/licm_div_10_o1_mod')
os.system('sudo cset shield --exec -- perf stat -r 10 ./bin/o1_mod/licm_div_20_o1_mod')

os.system('sudo echo 0 > /sys/devices/system/cpu/intel_pstate/no_turbo')

print('ПОСЛЕ ТЕСТА ВКЛЮЧИТЬ ТУРБОБУСТ!')
print('sudo echo 0 > /sys/devices/system/cpu/intel_pstate/no_turbo')