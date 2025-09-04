(module
 (type $0 (func))
 (type $1 (func (param i32) (result i32)))
 (import "as-builtin-fn" "~lib/rt/__localtostack" (func $~lib/rt/__localtostack (param i32) (result i32)))
 (import "as-builtin-fn" "~lib/rt/__tmptostack" (func $~lib/rt/__tmptostack (param i32) (result i32)))
 (global $~lib/builtins/f32.MAX_VALUE f32 (f32.const 3402823466385288598117041e14))
 (global $~lib/builtins/i32.MAX_VALUE i32 (i32.const 2147483647))
 (global $~lib/builtins/i32.MIN_VALUE i32 (i32.const -2147483648))
 (global $~lib/builtins/f32.NaN f32 (f32.const nan:0x400000))
 (global $~lib/builtins/i64.MAX_VALUE i64 (i64.const 9223372036854775807))
 (global $~lib/builtins/i64.MIN_VALUE i64 (i64.const -9223372036854775808))
 (global $~lib/builtins/u32.MAX_VALUE i32 (i32.const -1))
 (global $~lib/builtins/u32.MIN_VALUE i32 (i32.const 0))
 (global $~lib/builtins/u64.MAX_VALUE i64 (i64.const -1))
 (global $~lib/builtins/u64.MIN_VALUE i64 (i64.const 0))
 (global $~lib/builtins/f64.MAX_VALUE f64 (f64.const 1797693134862315708145274e284))
 (global $~lib/builtins/f64.NaN f64 (f64.const nan:0x8000000000000))
 (global $~lib/memory/__data_end i32 (i32.const 8))
 (global $~lib/memory/__stack_pointer (mut i32) (i32.const 32776))
 (global $~lib/memory/__heap_base i32 (i32.const 32776))
 (global $~started (mut i32) (i32.const 0))
 (memory $0 0)
 (table $0 1 1 funcref)
 (elem $0 (i32.const 1))
 (export "memory" (memory $0))
 (export "_start" (func $~start))
 (func $start:nontrapping-f2i
  (drop
   (i32.eq
    (i32.trunc_sat_f32_s
     (global.get $~lib/builtins/f32.MAX_VALUE)
    )
    (global.get $~lib/builtins/i32.MAX_VALUE)
   )
  )
  (drop
   (i32.eq
    (i32.trunc_sat_f32_s
     (f32.neg
      (global.get $~lib/builtins/f32.MAX_VALUE)
     )
    )
    (global.get $~lib/builtins/i32.MIN_VALUE)
   )
  )
  (drop
   (i32.eq
    (i32.trunc_sat_f32_s
     (global.get $~lib/builtins/f32.NaN)
    )
    (i32.const 0)
   )
  )
  (drop
   (i64.eq
    (i64.trunc_sat_f32_s
     (global.get $~lib/builtins/f32.MAX_VALUE)
    )
    (global.get $~lib/builtins/i64.MAX_VALUE)
   )
  )
  (drop
   (i64.eq
    (i64.trunc_sat_f32_s
     (f32.neg
      (global.get $~lib/builtins/f32.MAX_VALUE)
     )
    )
    (global.get $~lib/builtins/i64.MIN_VALUE)
   )
  )
  (drop
   (i64.eq
    (i64.trunc_sat_f32_s
     (global.get $~lib/builtins/f32.NaN)
    )
    (i64.const 0)
   )
  )
  (drop
   (i32.eq
    (i32.trunc_sat_f32_u
     (global.get $~lib/builtins/f32.MAX_VALUE)
    )
    (global.get $~lib/builtins/u32.MAX_VALUE)
   )
  )
  (drop
   (i32.eq
    (i32.trunc_sat_f32_u
     (f32.neg
      (global.get $~lib/builtins/f32.MAX_VALUE)
     )
    )
    (global.get $~lib/builtins/u32.MIN_VALUE)
   )
  )
  (drop
   (i32.eq
    (i32.trunc_sat_f32_u
     (global.get $~lib/builtins/f32.NaN)
    )
    (i32.const 0)
   )
  )
  (drop
   (i64.eq
    (i64.trunc_sat_f32_u
     (global.get $~lib/builtins/f32.MAX_VALUE)
    )
    (global.get $~lib/builtins/u64.MAX_VALUE)
   )
  )
  (drop
   (i64.eq
    (i64.trunc_sat_f32_u
     (f32.neg
      (global.get $~lib/builtins/f32.MAX_VALUE)
     )
    )
    (global.get $~lib/builtins/u64.MIN_VALUE)
   )
  )
  (drop
   (i64.eq
    (i64.trunc_sat_f32_u
     (global.get $~lib/builtins/f32.NaN)
    )
    (i64.const 0)
   )
  )
  (drop
   (i32.eq
    (i32.trunc_sat_f64_s
     (global.get $~lib/builtins/f64.MAX_VALUE)
    )
    (global.get $~lib/builtins/i32.MAX_VALUE)
   )
  )
  (drop
   (i32.eq
    (i32.trunc_sat_f64_s
     (f64.neg
      (global.get $~lib/builtins/f64.MAX_VALUE)
     )
    )
    (global.get $~lib/builtins/i32.MIN_VALUE)
   )
  )
  (drop
   (i32.eq
    (i32.trunc_sat_f64_s
     (global.get $~lib/builtins/f64.NaN)
    )
    (i32.const 0)
   )
  )
  (drop
   (i64.eq
    (i64.trunc_sat_f64_s
     (global.get $~lib/builtins/f64.MAX_VALUE)
    )
    (global.get $~lib/builtins/i64.MAX_VALUE)
   )
  )
  (drop
   (i64.eq
    (i64.trunc_sat_f64_s
     (f64.neg
      (global.get $~lib/builtins/f64.MAX_VALUE)
     )
    )
    (global.get $~lib/builtins/i64.MIN_VALUE)
   )
  )
  (drop
   (i64.eq
    (i64.trunc_sat_f64_s
     (global.get $~lib/builtins/f64.NaN)
    )
    (i64.const 0)
   )
  )
  (drop
   (i32.eq
    (i32.trunc_sat_f64_u
     (global.get $~lib/builtins/f64.MAX_VALUE)
    )
    (global.get $~lib/builtins/u32.MAX_VALUE)
   )
  )
  (drop
   (i32.eq
    (i32.trunc_sat_f64_u
     (f64.neg
      (global.get $~lib/builtins/f64.MAX_VALUE)
     )
    )
    (global.get $~lib/builtins/u32.MIN_VALUE)
   )
  )
  (drop
   (i32.eq
    (i32.trunc_sat_f64_u
     (global.get $~lib/builtins/f64.NaN)
    )
    (i32.const 0)
   )
  )
  (drop
   (i64.eq
    (i64.trunc_sat_f64_u
     (global.get $~lib/builtins/f64.MAX_VALUE)
    )
    (global.get $~lib/builtins/u64.MAX_VALUE)
   )
  )
  (drop
   (i64.eq
    (i64.trunc_sat_f64_u
     (f64.neg
      (global.get $~lib/builtins/f64.MAX_VALUE)
     )
    )
    (global.get $~lib/builtins/u64.MIN_VALUE)
   )
  )
  (drop
   (i64.eq
    (i64.trunc_sat_f64_u
     (global.get $~lib/builtins/f64.NaN)
    )
    (i64.const 0)
   )
  )
 )
 (func $~start
  (if
   (global.get $~started)
   (then
    (return)
   )
  )
  (global.set $~started
   (i32.const 1)
  )
  (call $start:nontrapping-f2i)
 )
)
