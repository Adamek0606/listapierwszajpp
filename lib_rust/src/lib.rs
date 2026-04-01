#[repr(C)]
pub struct DiophantineResult {
    pub has_solution: i32, // lepiej niż bool!
    pub x: i32,
    pub y: i32,
}

// =====================
// RUSTOWE FUNKCJE
// =====================

pub fn gcd(mut a: u32, mut b: u32) -> u32 {
    while b != 0 {
        let temp = b;
        b = a % b;
        a = temp;
    }
    a
}

pub fn smallest_prime_divisor(n: u32) -> u32 {
    if n < 2 {
        return 0;
    }
    if n % 2 == 0 {
        return 2;
    }

    let mut i = 3;
    while i * i <= n {
        if n % i == 0 {
            return i;
        }
        i += 2;
    }
    n
}

pub fn euler(mut n: u32) -> u32 {
    if n == 0 {
        return 0;
    }

    let mut result = n;
    let mut p = 2;

    while p * p <= n {
        if n % p == 0 {
            while n % p == 0 {
                n /= p;
            }
            result -= result / p;
        }
        p += 1;
    }

    if n > 1 {
        result -= result / n;
    }

    result
}

fn extended_gcd(a: i32, b: i32) -> (i32, i32, i32) {
    if b == 0 {
        (a, 1, 0)
    } else {
        let (d, x1, y1) = extended_gcd(b, a % b);
        (d, y1, x1 - (a / b) * y1)
    }
}

pub fn solve_diophantine(a: i32, b: i32, c: i32) -> DiophantineResult {
    if a <= 0 || b <= 0 {
        return DiophantineResult { has_solution: 0, x: 0, y: 0 };
    }

    let (d, x0, y0) = extended_gcd(a, b);

    if c % d != 0 {
        return DiophantineResult { has_solution: 0, x: 0, y: 0 };
    }

    let k = c / d;

    let xp = x0 as i64 * k as i64;
    let yp = -y0 as i64 * k as i64;

    let step_x = (b / d) as i64;
    let step_y = (a / d) as i64;

    let tx = if xp <= 0 {
        (-xp + step_x - 1) / step_x
    } else {
        -xp / step_x
    };

    let ty = if yp <= 0 {
        (-yp + step_y - 1) / step_y
    } else {
        -yp / step_y
    };

    let how_many_steps = if tx > ty { tx } else { ty };

    DiophantineResult {
        has_solution: 1,
        x: (xp + how_many_steps * step_x) as i32,
        y: (yp + how_many_steps * step_y) as i32,
    }
}



#[no_mangle]
pub extern "C" fn gcd_c(a: u32, b: u32) -> u32 {
    gcd(a, b)
}

#[no_mangle]
pub extern "C" fn smallest_prime_divisor_c(n: u32) -> u32 {
    smallest_prime_divisor(n)
}

#[no_mangle]
pub extern "C" fn euler_c(n: u32) -> u32 {
    euler(n)
}

#[no_mangle]
pub extern "C" fn solve_diophantine_c(a: i32, b: i32, c: i32) -> DiophantineResult {
    solve_diophantine(a, b, c)
}