import os

N = 10

print("--------- BASE ---------")

for i in range(N):
    os.system("./baseline")

print("--------- OPT ----------")

for i in range(N):
    os.system("./optimized")