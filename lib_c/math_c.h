#ifndef MYLIB_H
#define MYLIB_H

#include <stdbool.h>

//Struktura wyniku równania diofantycznego
typedef struct DiophantineResult {
    bool has_solution;
    int x;
    int y;
} DiophantineResult;

//Największy wspólny dzielnik
unsigned int gcd(unsigned int a, unsigned int b);

// Najmniejszy dzielnik pierwszy (n > 1)
unsigned int smallest_prime_divisor(unsigned int n);

//Funkcja Eulera
unsigned int euler(unsigned int n);

//Równanie diofantyczne ax - by = c
DiophantineResult solve_diophantine(int a, int b, int c);

#endif