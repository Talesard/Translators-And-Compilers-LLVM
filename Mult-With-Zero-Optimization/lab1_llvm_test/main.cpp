#include <iostream>
#include <cstdint>
#include <chrono>

int main() {
    
    std::cout << "TIME TEST:" << std::endl;
    auto time = std::chrono::duration<double>{};

    uint64_t arr[] = {0, 1, 2, 3, 4, 5, 6, 7, 8, 9};

    for (std::uint64_t i = 0; i < 150000000; i++) {
        auto const start = std::chrono::high_resolution_clock::now();

        arr[0] *= 0;
        arr[1] *= 0;
        arr[2] *= 0;
        arr[3] *= 0;
        arr[4] *= 0;
        arr[5] *= 0;
        arr[6] *= 0;
        arr[7] *= 0;
        arr[8] *= 0;
        arr[9] *= 0;

        auto const finish = std::chrono::high_resolution_clock::now();
        time += std::chrono::duration_cast<std::chrono::duration<double>>(finish - start);
    }

    
    for (int i = 0; i < 10; i++) { std::cout << arr[i] << ' '; }

    std::cout << "\nt: " << time.count() << std::endl;


    std::cout << "CHECK ALWAYS ZERO: ";
    int x = 0;
    for(int i = 0; i < 10000; i++) {
        int tmp = i;
        tmp *= 0;
        if (tmp != 0) {
            throw "FAIL: not zero";
        }
    }

    std::cout << "ok" << std::endl;
    return 0;
}