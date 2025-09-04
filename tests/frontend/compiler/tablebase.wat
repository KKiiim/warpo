(module
 (type $0 (func))
 (type $1 (func (param i32) (result i32)))
 (type $2 (func (param i32 i32 i32 i32)))
 (import "env" "abort" (func $~lib/builtins/abort (param i32 i32 i32 i32)))
 (import "as-builtin-fn" "~lib/rt/__localtostack" (func $~lib/rt/__localtostack (param i32) (result i32)))
 (import "as-builtin-fn" "~lib/rt/__tmptostack" (func $~lib/rt/__tmptostack (param i32) (result i32)))
 (global $../tests/frontend/compiler/tablebase/staticFunction i32 (i32.const 32))
 (global $~lib/native/ASC_TABLE_BASE i32 (i32.const 0))
 (global $~lib/memory/__data_end i32 (i32.const 156))
 (global $~lib/memory/__stack_pointer (mut i32) (i32.const 32924))
 (global $~lib/memory/__heap_base i32 (i32.const 32924))
 (memory $0 1)
 (data $0 (i32.const 12) "\1c\00\00\00\00\00\00\00\00\00\00\00\04\00\00\00\08\00\00\00\01\00\00\00\00\00\00\00\00\00\00\00")
 (data $1 (i32.const 44) "l\00\00\00\00\00\00\00\00\00\00\00\02\00\00\00N\00\00\00.\00.\00/\00t\00e\00s\00t\00s\00/\00f\00r\00o\00n\00t\00e\00n\00d\00/\00c\00o\00m\00p\00i\00l\00e\00r\00/\00t\00a\00b\00l\00e\00b\00a\00s\00e\00.\00t\00s\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00")
 (table $0 2 2 funcref)
 (elem $0 (i32.const 1) $../tests/frontend/compiler/tablebase/foo)
 (export "memory" (memory $0))
 (start $~start)
 (func $../tests/frontend/compiler/tablebase/foo
  (nop)
 )
 (func $~lib/function/Function<%28%29=>void>#get:index (param $this i32) (result i32)
  (return
   (i32.load
    (local.get $this)
   )
  )
 )
 (func $start:../tests/frontend/compiler/tablebase
  (if
   (i32.eqz
    (i32.eq
     (i32.const 0)
     (i32.const 32)
    )
   )
   (then
    (call $~lib/builtins/abort
     (i32.const 0)
     (i32.const 64)
     (i32.const 5)
     (i32.const 1)
    )
    (unreachable)
   )
  )
  (if
   (i32.eqz
    (i32.eq
     (call $~lib/function/Function<%28%29=>void>#get:index
      (call $~lib/rt/__tmptostack
       (global.get $../tests/frontend/compiler/tablebase/staticFunction)
      )
     )
     (i32.const 32)
    )
   )
   (then
    (call $~lib/builtins/abort
     (i32.const 0)
     (i32.const 64)
     (i32.const 6)
     (i32.const 1)
    )
    (unreachable)
   )
  )
 )
 (func $~start
  (call $start:../tests/frontend/compiler/tablebase)
 )
)
