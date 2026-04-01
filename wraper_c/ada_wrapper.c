#include "ada_wrapper.h"

// Deklaracje funkcji wyciąganych prosto z libmath_ada.a
extern unsigned int ada_gcd_c(unsigned int a, unsigned int b);
extern unsigned int ada_spd_c(unsigned int n);
extern unsigned int ada_euler_c(unsigned int n);
extern AdaDiophantineResult ada_solve_diophantine_c(int a, int b, int c);

// Implementacja
unsigned int ada_wrapper_gcd(unsigned int a, unsigned int b) {
    return ada_gcd_c(a, b);
}

unsigned int ada_wrapper_smallest_prime(unsigned int n) {
    return ada_spd_c(n);
}

unsigned int ada_wrapper_euler(unsigned int n) {
    return ada_euler_c(n);
}

AdaDiophantineResult ada_wrapper_solve_diophantine(int a, int b, int c) {
    return ada_solve_diophantine_c(a, b, c);
}