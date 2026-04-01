with Ada.Text_IO;         use Ada.Text_IO;
with Ada.Integer_Text_IO; use Ada.Integer_Text_IO;
with Interfaces.C;        use Interfaces.C;

with Math_ada;            
with Imported_Math;       

procedure Main is
   -- Zmienne testowe
   Val_A : constant unsigned := 1071;
   Val_B : constant unsigned := 462;
   N     : constant unsigned := 10;
   Da    : constant int := 10;
   Db    : constant int := 6;
   Dc    : constant int := 2;

   Res_Ada  : Math_ada.Diophantine_Result;
   Res_C    : Imported_Math.C_Diophantine_Result;
   Res_Rust : Imported_Math.Rust_Diophantine_Result;

begin
   Put_Line ("ADA - biblioteka ");
   Put ("Ada GCD: "); Put (Integer (Math_ada.Gcd (Natural (Val_A), Natural (Val_B))), 0); New_Line;
   Put ("Ada SPD: "); Put (Integer (Math_ada.Smallest_Prime_Divisor    (Natural (N))), 0); New_Line;
   Put ("Ada Euler: "); Put (Integer (Math_ada.Euler (Natural (N))), 0); New_Line;
   Res_Ada := Math_ada.Solve_Diophantine (Integer (Da), Integer (Db), Integer (Dc));
   if Res_Ada.Has_Solution then
      Put_Line ("Ada Diofantyczne: x = " & Integer'Image (Res_Ada.X) & ", y = " & Integer'Image (Res_Ada.Y));
   else
      Put_Line ("Ada: Brak rozwiazania.");
   end if;
   New_Line;

   Put_Line ("C - Za pomoca wrappera ");
   Put ("C GCD: "); Put (Integer (Imported_Math.C_Gcd (Val_A, Val_B)), 0); New_Line;
   Put ("C SPD: "); Put (Integer (Imported_Math.C_Spd (Val_B)), 0); New_Line;
   Put ("C Euler: "); Put (Integer (Imported_Math.C_Euler (Val_B)), 0); New_Line;

   Res_C := Imported_Math.C_Solve_Diophantine (Da, Db, Dc);
   if Res_C.Has_Solution then -- C_bool traktowane liczbowo lub logicznie zaleznie od kompilatora
      Put_Line ("C Diofantyczne: x = " & Integer'Image (Integer (Res_C.X)) & ", y = " & Integer'Image (Integer (Res_C.Y)));
   else
      Put_Line ("C: Brak rozwiazania.");
   end if;
   New_Line;

   Put_Line ("RUST - Za pomoca wrappera ");
   Put ("Rust GCD: "); Put (Integer (Imported_Math.Rust_Gcd (Val_A, Val_B)), 0); New_Line;
   Put ("Rust SPD: "); Put (Integer (Imported_Math.Rust_Spd (Val_B)), 0); New_Line; 
   Put ("Rust Euler: "); Put (Integer (Imported_Math.Rust_Euler (Val_B)), 0); New_Line;
   Res_Rust := Imported_Math.Rust_Solve_Diophantine (Da, Db, Dc);
   if Res_Rust.Has_Solution /= 0 then
      Put_Line ("Rust Diofantyczne: x = " & Integer'Image (Integer (Res_Rust.X)) & ", y = " & Integer'Image (Integer (Res_Rust.Y)));
   else
      Put_Line ("Rust: Brak rozwiazania.");
   end if;
   New_Line;
end Main;

--adam@adam-VirtualBox:~/studia/sem4/jpp/listapierwsza/wraper_ada$ gnatlink main.ali libmath_adaa.a libmath_c.a libmath_rust.a -lpthread -ldl -lm
