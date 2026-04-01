with Interfaces.C; use Interfaces.C;
with Math_ada;

package Math_Ada_C is

   -- Struktura ułożona specjalnie pod pamięć C (odpowiednik struct)
   type C_Diophantine_Result is record
      Has_Solution : int;
      X            : int;
      Y            : int;
   end record;
   pragma Convention (C, C_Diophantine_Result);

   -- Eksportujemy funkcje pod ładnymi nazwami dla C
   function Gcd_C (A, B : unsigned) return unsigned;
   pragma Export (C, Gcd_C, "ada_gcd_c");

   function Spd_C (N : unsigned) return unsigned;
   pragma Export (C, Spd_C, "ada_spd_c");

   function Euler_C (N : unsigned) return unsigned;
   pragma Export (C, Euler_C, "ada_euler_c");

   function Solve_Diophantine_C (A, B, C : int) return C_Diophantine_Result;
   pragma Export (C, Solve_Diophantine_C, "ada_solve_diophantine_c");

end Math_Ada_C;