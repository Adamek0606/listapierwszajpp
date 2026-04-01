package body Math_ada is

   function Gcd (A, B : Natural) return Natural is
      Temp_A : Natural := A;
      Temp_B : Natural := B;
      Temp   : Natural;
   begin
      while Temp_B /= 0 loop
         Temp   := Temp_B;
         Temp_B := Temp_A mod Temp_B;
         Temp_A := Temp;
      end loop;
      return Temp_A;
   end Gcd;

   function Smallest_Prime_Divisor (N : Natural) return Natural is
      I : Natural := 3;
   begin
      if N < 2 then
         return 0;
      end if;

      if N mod 2 = 0 then
         return 2;
      end if;

      while I * I <= N loop
         if N mod I = 0 then
            return I;
         end if;
         I := I + 2;
      end loop;

      return N;
   end Smallest_Prime_Divisor;

   function Euler (N : Natural) return Natural is
      Result : Natural;
      P      : Natural;
      Temp_N : Natural := N;
   begin
      if Temp_N = 0 then
         return 0;
      end if;

      Result := Temp_N;
      P := 2;

      while P * P <= Temp_N loop
         if Temp_N mod P = 0 then
            while Temp_N mod P = 0 loop
               Temp_N := Temp_N / P;
            end loop;
            Result := Result - Result / P;
         end if;
         P := P + 1;
      end loop;

      if Temp_N > 1 then
         Result := Result - Result / Temp_N;
      end if;

      return Result;
   end Euler;

   procedure Extended_Gcd (A, B : in Integer; X, Y, D : out Integer) is
      X1, Y1 : Integer;
   begin
      if B = 0 then
         X := 1;
         Y := 0;
         D := A;
         return;
      end if;

      Extended_Gcd (B, A mod B, X1, Y1, D);

      X := Y1;
      Y := X1 - (A / B) * Y1;
   end Extended_Gcd;

   function Solve_Diophantine (A, B, C : Integer) return Diophantine_Result is
      Result : Diophantine_Result := (Has_Solution => False, X => 0, Y => 0);
      X0, Y0, D : Integer;
      K : Integer;
      
      XP, YP, Step_X, Step_Y : Long_Long_Integer;
      TX, TY, How_Much_Steps : Long_Long_Integer;
   begin
      if A <= 0 or B <= 0 then
         return Result;
      end if;

      Extended_Gcd (A, B, X0, Y0, D);

      if C mod D /= 0 then
         return Result;
      end if;

      K := C / D;

      XP := Long_Long_Integer (X0) * Long_Long_Integer (K);
      YP := Long_Long_Integer (-Y0) * Long_Long_Integer (K);

      Step_X := Long_Long_Integer (B / D);
      Step_Y := Long_Long_Integer (A / D);

      if XP <= 0 then
         TX := (-XP + Step_X - 1) / Step_X;
      else
         TX := (-XP) / Step_X;
      end if;

      if YP <= 0 then
         TY := (-YP + Step_Y - 1) / Step_Y;
      else
         TY := (-YP) / Step_Y;
      end if;

      if TX > TY then
         How_Much_Steps := TX;
      else
         How_Much_Steps := TY;
      end if;

      Result.Has_Solution := True;
      Result.X := Integer (XP + How_Much_Steps * Step_X);
      Result.Y := Integer (YP + How_Much_Steps * Step_Y);

      return Result;
   end Solve_Diophantine;

end Math_ada;