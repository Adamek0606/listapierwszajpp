import ctypes
import os
#wyszukiwanie bibliotek 
lib_c = ctypes.CDLL(os.path.abspath("./libmath_c.so"))
lib_rust = ctypes.CDLL(os.path.abspath("./libmath_rust.so"))
lib_ada = ctypes.CDLL(os.path.abspath("./libmath_ada.so"))

class CDiophantineResult(ctypes.Structure):
    _fields_ = [
        ("has_solution", ctypes.c_bool),
        ("x", ctypes.c_int),
        ("y", ctypes.c_int)
    ]
class RustAdaDiophantineResult(ctypes.Structure):
    _fields_ = [
        ("has_solution", ctypes.c_int),
        ("x", ctypes.c_int),
        ("y", ctypes.c_int)
    ]

#mapowanie argumentów i typów zwracanych dla funkcji z bibliotek
lib_c.gcd.argtypes = [ctypes.c_uint32, ctypes.c_uint32]#skonwrtuj argumenty do uint32 gdy wywołujemy funkcję z biblioteki C
lib_c.gcd.restype = ctypes.c_uint32#skonwertuj wynik do uint32 gdy otrzymujemy wynik z biblioteki C

lib_c.smallest_prime_divisor.argtypes = [ctypes.c_uint32]
lib_c.smallest_prime_divisor.restype = ctypes.c_uint32

lib_c.euler.argtypes = [ctypes.c_uint32]
lib_c.euler.restype = ctypes.c_uint32

lib_c.solve_diophantine.argtypes = [ctypes.c_int, ctypes.c_int, ctypes.c_int]
lib_c.solve_diophantine.restype = CDiophantineResult


#RUST
lib_rust.gcd_c.argtypes = [ctypes.c_uint32, ctypes.c_uint32]
lib_rust.gcd_c.restype = ctypes.c_uint32

lib_rust.smallest_prime_divisor_c.argtypes = [ctypes.c_uint32]
lib_rust.smallest_prime_divisor_c.restype = ctypes.c_uint32

lib_rust.euler_c.argtypes = [ctypes.c_uint32]
lib_rust.euler_c.restype = ctypes.c_uint32

lib_rust.solve_diophantine_c.argtypes = [ctypes.c_int, ctypes.c_int, ctypes.c_int]
lib_rust.solve_diophantine_c.restype = RustAdaDiophantineResult


#ADA
lib_ada.adainit.argtypes = []
lib_ada.adafinal.argtypes = []

lib_ada.ada_gcd_c.argtypes = [ctypes.c_uint32, ctypes.c_uint32]
lib_ada.ada_gcd_c.restype = ctypes.c_uint32

lib_ada.ada_spd_c.argtypes = [ctypes.c_uint32]
lib_ada.ada_spd_c.restype = ctypes.c_uint32

lib_ada.ada_euler_c.argtypes = [ctypes.c_uint32]
lib_ada.ada_euler_c.restype = ctypes.c_uint32

lib_ada.ada_solve_diophantine_c.argtypes = [ctypes.c_int, ctypes.c_int, ctypes.c_int]
lib_ada.ada_solve_diophantine_c.restype = RustAdaDiophantineResult


if __name__ == "__main__":
    a, b = 1071, 462
    n = 10
    da, db, dc = 10, 6, 2
    lib_ada.adainit()
    print("C za pomoca PYTHON")
    print(f"C GCD({a}, {b}) =", lib_c.gcd(a, b))
    print(f"C SPD({n}) =", lib_c.smallest_prime_divisor(n))
    print(f"C Euler({n}) =", lib_c.euler(n))
    
    res_c = lib_c.solve_diophantine(da, db, dc)
    if res_c.has_solution:
        print(f"C Diofantyczne: x = {res_c.x}, y = {res_c.y}\n")
    else:
        print("C: Brak rozwiązania.\n")


    print("Rust za pomoca PYTHON")
    print(f"Rust GCD({a}, {b}) =", lib_rust.gcd_c(a, b))
    print(f"Rust SPD({n}) =", lib_rust.smallest_prime_divisor_c(n))
    print(f"Rust Euler({n}) =", lib_rust.euler_c(n))
    
    res_rust = lib_rust.solve_diophantine_c(da, db, dc)
    if res_rust.has_solution != 0:
        print(f"Rust Diofantyczne: x = {res_rust.x}, y = {res_rust.y}\n")
    else:
        print("Rust: Brak rozwiązania.\n")

    print("Ada za pomoca PYTHON")
    print(f"Ada GCD({a}, {b}) =", lib_ada.ada_gcd_c(a, b))
    print(f"Ada SPD({n}) =", lib_ada.ada_spd_c(n))
    print(f"Ada Euler({n}) =", lib_ada.ada_euler_c(n))
    
    res_ada = lib_ada.ada_solve_diophantine_c(da, db, dc)
    if res_ada.has_solution != 0:
        print(f"Ada Diofantyczne: x = {res_ada.x}, y = {res_ada.y}\n")
    else:
        print("Ada: Brak rozwiązania.\n")

    lib_ada.adafinal()
