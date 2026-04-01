#ifndef ADA_WRAPPER_H
#define ADA_WRAPPER_H

typedef struct {
    int has_solution;
    int x;
    int y;
} AdaDiophantineResult;

extern void adainit(void);
extern void adafinal(void);

// Funkcje Twojego wrappera
unsigned int ada_wrapper_gcd(unsigned int a, unsigned int b);
unsigned int ada_wrapper_smallest_prime(unsigned int n);
unsigned int ada_wrapper_euler(unsigned int n);
AdaDiophantineResult ada_wrapper_solve_diophantine(int a, int b, int c);

#endif