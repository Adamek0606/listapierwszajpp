with Interfaces.C; use Interfaces.C;

package Imported_Math is

   type C_Diophantine_Result is record
      Has_Solution : C_bool;
      X            : int;
      Y            : int;
   end record;
   pragma Convention (C, C_Diophantine_Result);

   type Rust_Diophantine_Result is record
      Has_Solution : int;
      X            : int;
      Y            : int;
   end record;
   pragma Convention (C, Rust_Diophantine_Result);

   function C_Gcd (A, B : unsigned) return unsigned;
   pragma Import (C, C_Gcd, "gcd");

   function C_Spd (N : unsigned) return unsigned;
   pragma Import (C, C_Spd, "smallest_prime_divisor");

   function C_Euler (N : unsigned) return unsigned;
   pragma Import (C, C_Euler, "euler");

   function C_Solve_Diophantine (A, B, C_Val : int) return C_Diophantine_Result;
   pragma Import (C, C_Solve_Diophantine, "solve_diophantine");

   function Rust_Gcd (A, B : unsigned) return unsigned;
   pragma Import (C, Rust_Gcd, "gcd_c");

   function Rust_Spd (N : unsigned) return unsigned;
   pragma Import (C, Rust_Spd, "smallest_prime_divisor_c");

   function Rust_Euler (N : unsigned) return unsigned;
   pragma Import (C, Rust_Euler, "euler_c");

   function Rust_Solve_Diophantine (A, B, C_Val : int) return Rust_Diophantine_Result;
   pragma Import (C, Rust_Solve_Diophantine, "solve_diophantine_c");

end Imported_Math;