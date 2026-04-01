#include <stdio.h>
#include <stdbool.h>
#include "math_c.h"        // Twoja biblioteka C
#include "rust_wrapper.h"   // Twoja biblioteka Rust przez wrapper

int main() {

    unsigned int a = 1071, b = 462;
    unsigned int n = 10;
    int da = 10, db = 6, dc = 2;

 
    printf("RUST - za pomoca wrappera\n");

    unsigned int r_gcd = rust_wrapper_gcd(a, b);
    printf("Rust GCD(%u, %u) = %u\n", a, b, r_gcd);

    unsigned int r_euler = rust_wrapper_euler(n);
    printf("Rust Euler(%u) = %u\n", n, r_euler);

    RustDiophantineResult r_res = rust_wrapper_solve_diophantine(da, db, dc);
    if (r_res.has_solution) {
        printf("Rust Diophantine (%dx + %dy = %d): x = %d, y = %d\n", da, db, dc, r_res.x, r_res.y);
    } else {
        printf("Rust: Brak rozwiązania.\n");
    }

    printf("C - za pomoca Biblioteki C\n");
    unsigned int c_gcd_val = gcd(a, b);
    printf("C GCD(%u, %u) = %u\n", a, b, c_gcd_val);

    unsigned int c_euler_val = euler(n);
    printf("C Euler(%u) = %u\n", n, c_euler_val);

    DiophantineResult c_res = solve_diophantine(da, db, dc);
    if (c_res.has_solution) {
        printf("C Diophantine (%dx + %dy = %d): x = %d, y = %d\n", da, db, dc, c_res.x, c_res.y);
    } else {
        printf("C: Brak rozwiązania.\n");
    }
    return 0;
}