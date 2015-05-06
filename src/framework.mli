val init_memory : Load.bytecode_exe -> int -> Machine.memory_mapping * Repr.memory
val init_state : Machine.memory_mapping -> Repr.memory -> Load.bytecode_exe -> Machine.state

module Interp : sig
  open Machine

  val init : prog:string -> argv:string array -> memsize_kb:int -> state

  val do_c_call : state -> int64 -> int64 -> state option 

  val step : ?trace:int -> state -> state option

  val interactive : prog:string -> argv:string array -> memsize_kb:int -> 
    < step : unit;
      steps : int -> unit;
      stepto : int -> unit;
      stepd : int;
      stepsd : int -> int;
      steptod : int -> int;
      state : state;
      running : bool;
      ninstrs : int;
      trace : 
        < machine : unit;
          instr : unit;
          value : int64 -> unit;
          root : int64 -> unit;
        >
    >

end

module Testbench : sig

  type cfg = 
    {
      waves : bool;
      instr_trace : bool;
      state_trace : bool;
      mem_trace : bool;
    }

  val make : cfg -> Load.bytecode_exe -> unit

end

