#pragma once

#include <cstdlib>
#include <ctime>
#include <vector>

#define N 1024*1024

struct testFunc{
    testFunc() : a(N), b(N), r(N) {
        srand (time(NULL));
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Rpass"
#pragma clang diagnostic ignored "-Rpass-missed"
#pragma clang diagnostic ignored "-Rpass-analysis"
        for (int i =0; i < N; i++) {
           a[i] = static_cast <double> (rand()) / static_cast <double> (RAND_MAX);
           b[i] = static_cast <double> (rand()) / static_cast <double> (RAND_MAX);
        }
#pragma clang diagnostic pop
    }

    __attribute__((noinline))
	void run(){
		for (int i=0; i < N; i++) {
            r[i] = a[i] * b[i];
        }
	}
private:
	std::vector<double> a, b, r;
};