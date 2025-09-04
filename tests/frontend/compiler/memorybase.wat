(module
 (type $0 (func))
 (type $1 (func (param i32) (result i32)))
 (type $2 (func (param i32 i32 i32 i32)))
 (import "env" "abort" (func $~lib/builtins/abort (param i32 i32 i32 i32)))
 (import "as-builtin-fn" "~lib/rt/__localtostack" (func $~lib/rt/__localtostack (param i32) (result i32)))
 (import "as-builtin-fn" "~lib/rt/__tmptostack" (func $~lib/rt/__tmptostack (param i32) (result i32)))
 (global $../tests/frontend/compiler/memorybase/staticData i32 (i32.const 16))
 (global $~lib/native/ASC_MEMORY_BASE i32 (i32.const 0))
 (global $~lib/memory/__data_end i32 (i32.const 140))
 (global $~lib/memory/__stack_pointer (mut i32) (i32.const 32908))
 (global $~lib/memory/__heap_base i32 (i32.const 32908))
 (memory $0 1)
 (data $0 (i32.const 16) "\00")
 (data $1 (i32.const 28) "l\00\00\00\00\00\00\00\00\00\00\00\02\00\00\00P\00\00\00.\00.\00/\00t\00e\00s\00t\00s\00/\00f\00r\00o\00n\00t\00e\00n\00d\00/\00c\00o\00m\00p\00i\00l\00e\00r\00/\00m\00e\00m\00o\00r\00y\00b\00a\00s\00e\00.\00t\00s\00\00\00\00\00\00\00\00\00\00\00\00\00")
 (table $0 1 1 funcref)
 (elem $0 (i32.const 1))
 (export "memory" (memory $0))
 (start $~start)
 (func $start:../tests/frontend/compiler/memorybase
  (if
   (i32.eqz
    (i32.eq
     (i32.const 0)
     (i32.const 1024)
    )
   )
   (then
    (call $~lib/builtins/abort
     (i32.const 0)
     (i32.const 48)
     (i32.const 3)
     (i32.const 1)
    )
    (unreachable)
   )
  )
  (if
   (i32.eqz
    (i32.eq
     (global.get $../tests/frontend/compiler/memorybase/staticData)
     (i32.const 0)
    )
   )
   (then
    (call $~lib/builtins/abort
     (i32.const 0)
     (i32.const 48)
     (i32.const 4)
     (i32.const 1)
    )
    (unreachable)
   )
  )
 )
 (func $~start
  (call $start:../tests/frontend/compiler/memorybase)
 )
)
