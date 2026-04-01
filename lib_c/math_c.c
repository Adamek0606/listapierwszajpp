#include "math_c.h"

unsigned int gcd(unsigned int a,unsigned int b) { //algorytm Euklidesa, kazdy dzielnik a i b jest dzielnikiem ich reszty z dzielenia, a największy wspólny dzielnik jest ostatnim niezerowym resztą
    while (b != 0) {
        int temp;
        temp = b;
        b = a % b;
        a = temp;
    }
    return a;
}

unsigned int smallest_prime_divisor(unsigned int n) {//Znajduje najmniejszy dzielnik pierwszy większy niż 1
    
    if (n < 2)
        return 0;

    if (n % 2 == 0) //jeśli n jest parzyste, to 2 jest jego najmniejszym dzielnikiem pierwszym
        return 2;
    int i = 3;
    while (i * i <= n) {
        if (n % i == 0)
            return i;
        i = i + 2; 
    }

    return n;
}

unsigned int euler(unsigned int n) {//Oblicza funkcję Eulera(ile jest liczb mniejszych od n, które są względnie pierwsze z n) 
    int result;
    int p;

    if (n == 0)
        return 0;

    result = n;//zakladam, że wszystkie liczby mniejsze od n są względnie pierwsze z n
    p = 2;

    while (p * p <= n) {
        if (n % p == 0) {//znajduje wszystkie dzielniki pierwsze n i odejmujemy
            while (n % p == 0) {
                n = n / p;//dziele dopoki n jest podzielne przez p, zeby usunac wszystkie wystapienia tego dzielnika pierwszego
            }
            result = result - result / p;
        }
        p = p + 1;
    }

    if (n > 1) {
        result = result - result / n;//jesli n jest większe niż 1, to znaczy, że n jest dzielnikiem pierwszym 
    }

    return result;
}


static int extended_gcd(int a, int b, int *x, int *y) {// * x,y wskaźniki na zmienne 
    int d;
    int x1, y1;

    if (b == 0) {
        *x = 1;
        *y = 0;
        return a;
    }

    d = extended_gcd(b, a % b, &x1, &y1);

    *x = y1;
    *y = x1 - (a / b) * y1;

    return d;
}

DiophantineResult solve_diophantine(int a, int b, int c) {
    DiophantineResult result;
    int x0, y0;
    int d;
    int k;

    result.has_solution = false;
    result.x = 0;
    result.y = 0;

    //Zabezpieczenie na wypadek niepoprawnych danych (a i b muszą być dodatnie)
    if (a <= 0 || b <= 0) {
        return result; 
    }

    d = extended_gcd(a, b, &x0, &y0); //&-przekazanie adresu zmiennej

    //Sprawdzenie, czy rozwiązanie w ogóle istnieje, na podstawie twierdzenia o równaniach diofantycznych: rozwiązanie istnieje wtedy i tylko wtedy, gdy d dzieli c
    if (c % d != 0) {
        return result;
    }

    k = c / d;

    //Zapisujemy rozwiązanie 
    long long xp = (long long)x0 * k;
    long long yp = (long long)(-y0) * k;

    //Obliczamy "kroki", o jakie możemy przesuwać rozwiązania
    long long step_x = b / d;
    long long step_y = a / d;

    //Szukamy najmniejszego t, dla którego xp + t * step_x >= 0
    long long tx;
    if (xp <= 0) {
        tx = (-xp + step_x - 1) / step_x; //sufit dla liczb dodatnich
    } else {
        tx = (-xp) / step_x;              //gdyby wynik byl dodatni ale nie minimalny 
    }

    //Szukamy najmniejszego t, dla którego yp + t * step_y >= 0
    long long ty;
    if (yp <= 0) {
        ty = (-yp + step_y - 1) / step_y;
    } else {
        ty = (-yp) / step_y;
    }

    long long howmuch_steps = 0;
    if (tx > ty) {
        howmuch_steps = tx;
    } else {
        howmuch_steps = ty;
    }

    
    result.has_solution = true;
    result.x = (int)(xp + howmuch_steps * step_x);
    result.y = (int)(yp + howmuch_steps * step_y);

    return result;
}