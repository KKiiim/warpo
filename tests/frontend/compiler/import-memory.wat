(module
 (type $0 (func))
 (type $1 (func (param i32) (result i32)))
 (type $2 (func (param i32 i32 i32 i32)))
 (import "env" "abort" (func $~lib/builtins/abort (param i32 i32 i32 i32)))
 (import "as-builtin-fn" "~lib/rt/__localtostack" (func $~lib/rt/__localtostack (param i32) (result i32)))
 (import "as-builtin-fn" "~lib/rt/__tmptostack" (func $~lib/rt/__tmptostack (param i32) (result i32)))
 (global $~lib/memory/__data_end i32 (i32.const 124))
 (global $~lib/memory/__stack_pointer (mut i32) (i32.const 32892))
 (global $~lib/memory/__heap_base i32 (i32.const 32892))
 (memory $0 1)
 (data $0 (i32.const 12) "l\00\00\00\00\00\00\00\00\00\00\00\02\00\00\00V\00\00\00.\00.\00/\00t\00e\00s\00t\00s\00/\00f\00r\00o\00n\00t\00e\00n\00d\00/\00c\00o\00m\00p\00i\00l\00e\00r\00/\00i\00m\00p\00o\00r\00t\00-\00m\00e\00m\00o\00r\00y\00.\00t\00s\00\00\00\00\00\00\00")
 (table $0 1 1 funcref)
 (elem $0 (i32.const 1))
 (export "memory" (memory $0))
 (start $~start)
 (func $start:../tests/frontend/compiler/import-memory
  (if
   (i32.eqz
    (i32.ne
     (memory.size)
     (i32.const 0)
    )
   )
   (then
    (call $~lib/builtins/abort
     (i32.const 0)
     (i32.const 32)
     (i32.const 1)
     (i32.const 1)
    )
    (unreachable)
   )
  )
 )
 (func $~start
  (call $start:../tests/frontend/compiler/import-memory)
 )
)
