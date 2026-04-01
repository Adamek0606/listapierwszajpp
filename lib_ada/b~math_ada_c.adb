pragma Warnings (Off);
pragma Ada_95;
pragma Source_File_Name (ada_main, Spec_File_Name => "b~math_ada_c.ads");
pragma Source_File_Name (ada_main, Body_File_Name => "b~math_ada_c.adb");
pragma Suppress (Overflow_Check);

package body ada_main is

   E080 : Short_Integer; pragma Import (Ada, E080, "system__os_lib_E");
   E009 : Short_Integer; pragma Import (Ada, E009, "ada__exceptions_E");
   E015 : Short_Integer; pragma Import (Ada, E015, "system__soft_links_E");
   E027 : Short_Integer; pragma Import (Ada, E027, "system__exception_table_E");
   E050 : Short_Integer; pragma Import (Ada, E050, "ada__containers_E");
   E075 : Short_Integer; pragma Import (Ada, E075, "ada__io_exceptions_E");
   E034 : Short_Integer; pragma Import (Ada, E034, "ada__numerics_E");
   E062 : Short_Integer; pragma Import (Ada, E062, "ada__strings_E");
   E064 : Short_Integer; pragma Import (Ada, E064, "ada__strings__maps_E");
   E067 : Short_Integer; pragma Import (Ada, E067, "ada__strings__maps__constants_E");
   E007 : Short_Integer; pragma Import (Ada, E007, "interfaces__c_E");
   E028 : Short_Integer; pragma Import (Ada, E028, "system__exceptions_E");
   E089 : Short_Integer; pragma Import (Ada, E089, "system__object_reader_E");
   E057 : Short_Integer; pragma Import (Ada, E057, "system__dwarf_lines_E");
   E023 : Short_Integer; pragma Import (Ada, E023, "system__soft_links__initialize_E");
   E049 : Short_Integer; pragma Import (Ada, E049, "system__traceback__symbolic_E");
   E033 : Short_Integer; pragma Import (Ada, E033, "system__img_int_E");
   E070 : Short_Integer; pragma Import (Ada, E070, "system__img_uns_E");
   E103 : Short_Integer; pragma Import (Ada, E103, "math_ada_E");
   E002 : Short_Integer; pragma Import (Ada, E002, "math_ada_c_E");

   Sec_Default_Sized_Stacks : array (1 .. 1) of aliased System.Secondary_Stack.SS_Stack (System.Parameters.Runtime_Default_Sec_Stack_Size);

   Local_Priority_Specific_Dispatching : constant String := "";
   Local_Interrupt_States : constant String := "";

   Is_Elaborated : Boolean := False;

   procedure adafinal is
      procedure s_stalib_adafinal;
      pragma Import (Ada, s_stalib_adafinal, "system__standard_library__adafinal");

      procedure Runtime_Finalize;
      pragma Import (C, Runtime_Finalize, "__gnat_runtime_finalize");

   begin
      if not Is_Elaborated then
         return;
      end if;
      Is_Elaborated := False;
      Runtime_Finalize;
      s_stalib_adafinal;
   end adafinal;

   type No_Param_Proc is access procedure;
   pragma Favor_Top_Level (No_Param_Proc);

   procedure adainit is
      Main_Priority : Integer;
      pragma Import (C, Main_Priority, "__gl_main_priority");
      Time_Slice_Value : Integer;
      pragma Import (C, Time_Slice_Value, "__gl_time_slice_val");
      WC_Encoding : Character;
      pragma Import (C, WC_Encoding, "__gl_wc_encoding");
      Locking_Policy : Character;
      pragma Import (C, Locking_Policy, "__gl_locking_policy");
      Queuing_Policy : Character;
      pragma Import (C, Queuing_Policy, "__gl_queuing_policy");
      Task_Dispatching_Policy : Character;
      pragma Import (C, Task_Dispatching_Policy, "__gl_task_dispatching_policy");
      Priority_Specific_Dispatching : System.Address;
      pragma Import (C, Priority_Specific_Dispatching, "__gl_priority_specific_dispatching");
      Num_Specific_Dispatching : Integer;
      pragma Import (C, Num_Specific_Dispatching, "__gl_num_specific_dispatching");
      Main_CPU : Integer;
      pragma Import (C, Main_CPU, "__gl_main_cpu");
      Interrupt_States : System.Address;
      pragma Import (C, Interrupt_States, "__gl_interrupt_states");
      Num_Interrupt_States : Integer;
      pragma Import (C, Num_Interrupt_States, "__gl_num_interrupt_states");
      Unreserve_All_Interrupts : Integer;
      pragma Import (C, Unreserve_All_Interrupts, "__gl_unreserve_all_interrupts");
      Detect_Blocking : Integer;
      pragma Import (C, Detect_Blocking, "__gl_detect_blocking");
      Default_Stack_Size : Integer;
      pragma Import (C, Default_Stack_Size, "__gl_default_stack_size");
      Default_Secondary_Stack_Size : System.Parameters.Size_Type;
      pragma Import (C, Default_Secondary_Stack_Size, "__gnat_default_ss_size");
      Bind_Env_Addr : System.Address;
      pragma Import (C, Bind_Env_Addr, "__gl_bind_env_addr");

      procedure Runtime_Initialize (Install_Handler : Integer);
      pragma Import (C, Runtime_Initialize, "__gnat_runtime_initialize");

      Finalize_Library_Objects : No_Param_Proc;
      pragma Import (C, Finalize_Library_Objects, "__gnat_finalize_library_objects");
      Binder_Sec_Stacks_Count : Natural;
      pragma Import (Ada, Binder_Sec_Stacks_Count, "__gnat_binder_ss_count");
      Default_Sized_SS_Pool : System.Address;
      pragma Import (Ada, Default_Sized_SS_Pool, "__gnat_default_ss_pool");

   begin
      if Is_Elaborated then
         return;
      end if;
      Is_Elaborated := True;
      Main_Priority := -1;
      Time_Slice_Value := -1;
      WC_Encoding := 'b';
      Locking_Policy := ' ';
      Queuing_Policy := ' ';
      Task_Dispatching_Policy := ' ';
      Priority_Specific_Dispatching :=
        Local_Priority_Specific_Dispatching'Address;
      Num_Specific_Dispatching := 0;
      Main_CPU := -1;
      Interrupt_States := Local_Interrupt_States'Address;
      Num_Interrupt_States := 0;
      Unreserve_All_Interrupts := 0;
      Detect_Blocking := 0;
      Default_Stack_Size := -1;

      ada_main'Elab_Body;
      Default_Secondary_Stack_Size := System.Parameters.Runtime_Default_Sec_Stack_Size;
      Binder_Sec_Stacks_Count := 1;
      Default_Sized_SS_Pool := Sec_Default_Sized_Stacks'Address;

      Runtime_Initialize (1);

      Finalize_Library_Objects := null;

      if E009 = 0 then
         Ada.Exceptions'Elab_Spec;
      end if;
      if E015 = 0 then
         System.Soft_Links'Elab_Spec;
      end if;
      if E027 = 0 then
         System.Exception_Table'Elab_Body;
      end if;
      E027 := E027 + 1;
      if E050 = 0 then
         Ada.Containers'Elab_Spec;
      end if;
      E050 := E050 + 1;
      if E075 = 0 then
         Ada.Io_Exceptions'Elab_Spec;
      end if;
      E075 := E075 + 1;
      if E034 = 0 then
         Ada.Numerics'Elab_Spec;
      end if;
      E034 := E034 + 1;
      if E062 = 0 then
         Ada.Strings'Elab_Spec;
      end if;
      E062 := E062 + 1;
      if E064 = 0 then
         Ada.Strings.Maps'Elab_Spec;
      end if;
      E064 := E064 + 1;
      if E067 = 0 then
         Ada.Strings.Maps.Constants'Elab_Spec;
      end if;
      E067 := E067 + 1;
      if E007 = 0 then
         Interfaces.C'Elab_Spec;
      end if;
      E007 := E007 + 1;
      if E028 = 0 then
         System.Exceptions'Elab_Spec;
      end if;
      E028 := E028 + 1;
      if E089 = 0 then
         System.Object_Reader'Elab_Spec;
      end if;
      E089 := E089 + 1;
      if E057 = 0 then
         System.Dwarf_Lines'Elab_Spec;
      end if;
      if E080 = 0 then
         System.Os_Lib'Elab_Body;
      end if;
      E080 := E080 + 1;
      if E023 = 0 then
         System.Soft_Links.Initialize'Elab_Body;
      end if;
      E023 := E023 + 1;
      E015 := E015 + 1;
      if E049 = 0 then
         System.Traceback.Symbolic'Elab_Body;
      end if;
      E049 := E049 + 1;
      if E033 = 0 then
         System.Img_Int'Elab_Spec;
      end if;
      E033 := E033 + 1;
      E009 := E009 + 1;
      if E070 = 0 then
         System.Img_Uns'Elab_Spec;
      end if;
      E070 := E070 + 1;
      E057 := E057 + 1;
      E103 := E103 + 1;
      E002 := E002 + 1;
   end adainit;

--  BEGIN Object file/option list
   --   ./math_ada.o
   --   ./math_ada_c.o
   --   -L./
   --   -L/usr/lib/gcc/x86_64-linux-gnu/13/adalib/
   --   -shared
   --   -lgnat-13
   --   -ldl
--  END Object file/option list   

end ada_main;
