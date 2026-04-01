with Interfaces.C; use Interfaces.C;

package body Math_Ada_C is

   function Gcd_C (A, B : unsigned) return unsigned is
   begin
      return unsigned (Math_ada.Gcd (Natural (A), Natural (B)));
   end Gcd_C;

   function Spd_C (N : unsigned) return unsigned is
   begin
      return unsigned (Math_ada.Smallest_Prime_Divisor (Natural (N)));
   end Spd_C;

   function Euler_C (N : unsigned) return unsigned is
   begin
      return unsigned (Math_ada.Euler (Natural (N)));
   end Euler_C;

   function Solve_Diophantine_C (A, B, C : int) return C_Diophantine_Result is
      Res_Ada : Math_ada.Diophantine_Result;
      Res_C   : C_Diophantine_Result;
   begin
      -- Wywołujemy Twoją oryginalną logikę z math_ada.adb
      Res_Ada := Math_ada.Solve_Diophantine (Integer (A), Integer (B), Integer (C));
      
      -- Tłumaczymy wynik Ady (Boolean) na wynik C (int)
      if Res_Ada.Has_Solution then
         Res_C.Has_Solution := 1;
      else
         Res_C.Has_Solution := 0;
      end if;
      Res_C.X := int (Res_Ada.X);
      Res_C.Y := int (Res_Ada.Y);
      
      return Res_C;
   end Solve_Diophantine_C;

end Math_Ada_C;