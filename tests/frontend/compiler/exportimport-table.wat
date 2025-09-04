(module
 (type $0 (func))
 (type $1 (func (param i32) (result i32)))
 (import "as-builtin-fn" "~lib/rt/__localtostack" (func $~lib/rt/__localtostack (param i32) (result i32)))
 (import "as-builtin-fn" "~lib/rt/__tmptostack" (func $~lib/rt/__tmptostack (param i32) (result i32)))
 (global $../tests/frontend/compiler/exportimport-table/f (mut i32) (i32.const 32))
 (global $~lib/memory/__data_end i32 (i32.const 44))
 (global $~lib/memory/__stack_pointer (mut i32) (i32.const 32812))
 (global $~lib/memory/__heap_base i32 (i32.const 32812))
 (memory $0 1)
 (data $0 (i32.const 12) "\1c\00\00\00\00\00\00\00\00\00\00\00\04\00\00\00\08\00\00\00\01\00\00\00\00\00\00\00\00\00\00\00")
 (table $0 2 2 funcref)
 (elem $0 (i32.const 1) $start:../tests/frontend/compiler/exportimport-table~anonymous|0)
 (export "memory" (memory $0))
 (start $~start)
 (func $start:../tests/frontend/compiler/exportimport-table~anonymous|0
  (nop)
 )
 (func $start:../tests/frontend/compiler/exportimport-table
  (drop
   (global.get $../tests/frontend/compiler/exportimport-table/f)
  )
 )
 (func $~start
  (call $start:../tests/frontend/compiler/exportimport-table)
 )
)
