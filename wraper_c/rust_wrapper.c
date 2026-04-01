#include "rust_wrapper.h"

// Deklaracje symboli wygenerowanych w lib.rs (wyciągane z libmath_rust.a)
extern uint32_t gcd_c(uint32_t a, uint32_t b);
extern uint32_t smallest_prime_divisor_c(uint32_t n);
extern uint32_t euler_c(uint32_t n);
extern RustDiophantineResult solve_diophantine_c(int32_t a, int32_t b, int32_t c);

// Implementacja wrappera
unsigned int rust_wrapper_gcd(unsigned int a, unsigned int b) {
    return (unsigned int)gcd_c((uint32_t)a, (uint32_t)b);
}

unsigned int rust_wrapper_smallest_prime(unsigned int n) {
    return (unsigned int)smallest_prime_divisor_c((uint32_t)n);
}

unsigned int rust_wrapper_euler(unsigned int n) {
    return (unsigned int)euler_c((uint32_t)n);
}

RustDiophantineResult rust_wrapper_solve_diophantine(int a, int b, int c) {
    return solve_diophantine_c((int32_t)a, (int32_t)b, (int32_t)c);
}