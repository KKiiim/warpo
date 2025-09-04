(module
 (type $0 (func (result i32)))
 (type $1 (func))
 (type $2 (func (param i32) (result i32)))
 (import "as-builtin-fn" "~lib/rt/__localtostack" (func $~lib/rt/__localtostack (param i32) (result i32)))
 (import "as-builtin-fn" "~lib/rt/__tmptostack" (func $~lib/rt/__tmptostack (param i32) (result i32)))
 (global $namespace/Outer.outerVar (mut i32) (i32.const 1))
 (global $namespace/Outer.Inner.aVar (mut i32) (i32.const 0))
 (global $namespace/Outer.Inner.anotherVar (mut i32) (i32.const 0))
 (global $namespace/Outer.Inner.evenAnotherVar (mut i32) (i32.const 0))
 (global $namespace/Outer.Inner.anEnum.ONE i32 (i32.const 1))
 (global $namespace/Outer.Inner.anEnum.TWO i32 (i32.const 2))
 (global $~lib/memory/__data_end i32 (i32.const 8))
 (global $~lib/memory/__stack_pointer (mut i32) (i32.const 32776))
 (global $~lib/memory/__heap_base i32 (i32.const 32776))
 (memory $0 0)
 (table $0 1 1 funcref)
 (elem $0 (i32.const 1))
 (export "memory" (memory $0))
 (start $~start)
 (func $namespace/Outer.Inner.aFunc (result i32)
  (return
   (global.get $namespace/Outer.Inner.aVar)
  )
 )
 (func $namespace/Joined.anotherFunc (result i32)
  (return
   (i32.const 3)
  )
 )
 (func $start:namespace
  (global.set $namespace/Outer.Inner.anotherVar
   (global.get $namespace/Outer.Inner.aVar)
  )
  (global.set $namespace/Outer.Inner.evenAnotherVar
   (global.get $namespace/Outer.outerVar)
  )
  (drop
   (global.get $namespace/Outer.Inner.aVar)
  )
  (drop
   (call $namespace/Outer.Inner.aFunc)
  )
  (drop
   (global.get $namespace/Outer.Inner.anEnum.ONE)
  )
  (drop
   (i32.const 2)
  )
  (drop
   (call $namespace/Joined.anotherFunc)
  )
 )
 (func $~start
  (call $start:namespace)
 )
)
