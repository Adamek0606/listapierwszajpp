
#[repr(C)]
pub struct CDiophantineResult {
    pub has_solution: bool, 
    pub x: i32,
    pub y: i32,
}
#[repr(C)]
pub struct RustAdaDiophantineResult {
    pub has_solution: i32, 
    pub x: i32,
    pub y: i32,
}

extern "C" { // extere "C" - oznacza ze funkcje sa eksportowane w stylu C
    //Funkcje z biblioteki C (libmath_c.a) 
    fn gcd(a: u32, b: u32) -> u32; 
    fn smallest_prime_divisor(n: u32) -> u32;
    fn euler(n: u32) -> u32;
    fn solve_diophantine(a: i32, b: i32, c: i32) -> CDiophantineResult;

    //Funkcje z biblioteki Ady 
    fn ada_gcd_c(a: u32, b: u32) -> u32;
    fn ada_spd_c(n: u32) -> u32;
    fn ada_euler_c(n: u32) -> u32;
    fn ada_solve_diophantine_c(a: i32, b: i32, c: i32) -> RustAdaDiophantineResult;
    fn adainit();
    fn adafinal();

    //Funkcje z biblioteki Rusta (libmath_rust.a) ---
    fn gcd_c(a: u32, b: u32) -> u32;
    fn smallest_prime_divisor_c(n: u32) -> u32;
    fn euler_c(n: u32) -> u32;
    fn solve_diophantine_c(a: i32, b: i32, c: i32) -> RustAdaDiophantineResult;
}
fn main() {
    let a: u32 = 1071;
    let b: u32 = 462;
    let n: u32 = 10;
    let da: i32 = 10;
    let db: i32 = 6;
    let dc: i32 = 2;

    //wszystkie wywołania funkcji z bibliotek C i Ady muszą być w bloku unsafe
    unsafe {
        adainit();

        println!("C ZA POMOCA WRAPERRA W RUST");
        println!("C GCD: {}", gcd(a, b));
        println!("C SPD: {}", smallest_prime_divisor(n));
        println!("C Euler: {}", euler(n));
        
        let c_res = solve_diophantine(da, db, dc);
        if c_res.has_solution {
            println!("C Diofantyczne: x = {}, y = {}", c_res.x, c_res.y);
        } else {
            println!("C: Brak rozwiązania.");
        }
        println!();


        println!("ADA - ZA POMOCA WRAPPERA W RUST");
        println!("Ada GCD: {}", ada_gcd_c(a, b));
        println!("Ada SPD: {}", ada_spd_c(n));
        println!("Ada Euler: {}", ada_euler_c(n));
        
        let ada_res = ada_solve_diophantine_c(da, db, dc);
        if ada_res.has_solution != 0 {
            println!("Ada Diofantyczne: x = {}, y = {}", ada_res.x, ada_res.y);
        } else {
            println!("Ada: Brak rozwiązania.");
        }
        println!();


        println!("RUST");
        println!("Rust GCD: {}", gcd_c(a, b));
        println!("Rust SPD: {}", smallest_prime_divisor_c(n));
        println!("Rust Euler: {}", euler_c(n));
        
        let rust_res = solve_diophantine_c(da, db, dc);
        if rust_res.has_solution != 0 {
            println!("Rust Diofantyczne: x = {}, y = {}", rust_res.x, rust_res.y);
        } else {
            println!("Rust: Brak rozwiązania.");
        }
        println!();

        adafinal();
    }
}