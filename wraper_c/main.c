#include <stdio.h>
#include <stdbool.h>
#include "math_c.h"        // Twoja biblioteka C
#include "rust_wrapper.h"   // Twoja biblioteka Rust przez wrapper
#include "ada_wrapper.h"    // Twoja biblioteka Ada przez wrapper
int main() {
    adainit(); // Inicjalizacja środowiska Ady

    unsigned int a = 1071, b = 462;
    unsigned int n = 10;
    int da = 10, db = 6, dc = 2;

 
    printf("RUST - za pomoca wrappera\n");

    unsigned int r_gcd = rust_wrapper_gcd(a, b);
    printf("Rust GCD(%u, %u) = %u\n", a, b, r_gcd);

    unsigned int r_spd = rust_wrapper_smallest_prime(n);
    printf("Rust Smallest Prime Divisor(%u) = %u\n", n, r_spd);

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
    printf("C Smallest Prime Divisor(%u) = %u\n", n, smallest_prime_divisor(n));

    unsigned int c_euler_val = euler(n);
    printf("C Euler(%u) = %u\n", n, c_euler_val);

    DiophantineResult c_res = solve_diophantine(da, db, dc);
    if (c_res.has_solution) {
        printf("C Diophantine (%dx + %dy = %d): x = %d, y = %d\n", da, db, dc, c_res.x, c_res.y);
    } else {
        printf("C: Brak rozwiązania.\n");
    }

    printf("ADA - za pomoca wrappera\n");
    printf("Ada GCD(%u, %u) = %u\n", a, b, ada_wrapper_gcd(a, b));
    printf("Ada Euler(%u) = %u\n", n, ada_wrapper_euler(n));
    printf("Ada Smallest Prime Divisor(%u) = %u\n", n, ada_wrapper_smallest_prime(n));
    AdaDiophantineResult a_res = ada_wrapper_solve_diophantine(da, db, dc);
    if (a_res.has_solution) {
        printf("Ada Diophantine (%dx + %dy = %d): x = %d, y = %d\n", da, db, dc, a_res.x, a_res.y);
    } else {
        printf("Ada: Brak rozwiazania.\n");
    }
    adafinal();
}   
//gcc main.c rust_wrapper.c ada_wrapper.c libmath_c.a libmath_rust.a libmath_ada.a -o program -lgnat -lpthread -ldl -lm