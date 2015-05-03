type machine_register = 
  (* zinc registers *)
  [ `accu | `env | `pc | `sp | `extra_args | `trapsp
  (* other state *)
  | `global_data | `atom_table | `alloc_base | `stack_high ]

type cache = [ `stack | `program | `mem ]

type state = 
  {
    (* zinc registers *)
    accu : int64;
    env : int64;
    pc : int64;
    sp : int64;
    extra_args : int64;
    trapsp : int64;
    (* other state *)
    global_data : int64;
    atom_table : int64;
    alloc_base : int64;
    stack_high : int64;
    (* memory *)
    memory : Repr.memory;
    (* executable *)
    exe : Load.bytecode_exe;
  }

let empty = 
  {
    accu = 0L;
    env = 0L;
    pc = 0L;
    sp = 0L;
    extra_args = 0L;
    trapsp = 0L;
    global_data = 0L;
    atom_table = 0L;
    alloc_base = 0L;
    stack_high = 0L;
    memory = Bigarray.(Array1.create int64 c_layout 0);
    exe = Load.empty;
  }

let string_of_mach_reg = function
  | `accu -> "accu"
  | `env -> "env"
  | `pc -> "pc"
  | `sp -> "sp"
  | `extra_args -> "extra_args"
  | `trapsp -> "trapsp"
  | `global_data -> "global_data"
  | `atom_table -> "atom_table"
  | `alloc_base -> "alloc_base"
  | `stack_high -> "stack_high"

let string_of_cache = function
  | `stack -> "stack"
  | `program -> "program"
  | `mem -> "mem"

