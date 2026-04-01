#ifndef RUST_WRAPPER_H
#define RUST_WRAPPER_H

#include <stdint.h>

// Struktura wyników (zmieniona nazwa, by w przyszłości nie gryzła się z C)
typedef struct {
    int32_t has_solution;
    int32_t x;
    int32_t y;
} RustDiophantineResult;

// Deklaracje Twoich funkcji wrappera
unsigned int rust_wrapper_gcd(unsigned int a, unsigned int b);
unsigned int rust_wrapper_smallest_prime(unsigned int n);
unsigned int rust_wrapper_euler(unsigned int n);
RustDiophantineResult rust_wrapper_solve_diophantine(int a, int b, int c);

#endif