package Math_ada is
   type Diophantine_Result is record
      Has_Solution : Boolean;
      X            : Integer;
      Y            : Integer;
   end record;
   procedure Extended_Gcd (A, B : Integer; X, Y, D : out Integer);

   function Gcd (A, B : Natural) return Natural;

   function Smallest_Prime_Divisor (N : Natural) return Natural;

   function Euler (N : Natural) return Natural;

   function Solve_Diophantine (A, B, C : Integer) return Diophantine_Result;
end Math_ada;