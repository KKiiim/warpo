(module
 (type $0 (func (param i32) (result i32)))
 (type $1 (func))
 (type $2 (func (param f32) (result i32)))
 (type $3 (func (param f64) (result i32)))
 (import "as-builtin-fn" "~lib/rt/__localtostack" (func $~lib/rt/__localtostack (param i32) (result i32)))
 (import "as-builtin-fn" "~lib/rt/__tmptostack" (func $~lib/rt/__tmptostack (param i32) (result i32)))
 (global $~lib/shared/runtime/Runtime.Stub i32 (i32.const 0))
 (global $~lib/shared/runtime/Runtime.Minimal i32 (i32.const 1))
 (global $~lib/shared/runtime/Runtime.Incremental i32 (i32.const 2))
 (global $~lib/memory/__data_end i32 (i32.const 380))
 (global $~lib/memory/__stack_pointer (mut i32) (i32.const 33148))
 (global $~lib/memory/__heap_base i32 (i32.const 33148))
 (memory $0 1)
 (data $0 (i32.const 12) "\1c\00\00\00\00\00\00\00\00\00\00\00\02\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00")
 (data $1 (i32.const 44) "\1c\00\00\00\00\00\00\00\00\00\00\00\02\00\00\00\02\00\00\00a\00\00\00\00\00\00\00\00\00\00\00")
 (data $2 (i32.const 76) "\1c\00\00\00\00\00\00\00\00\00\00\00\02\00\00\00\04\00\00\00a\00b\00\00\00\00\00\00\00\00\00")
 (data $3 (i32.const 108) "\1c\00\00\00\00\00\00\00\00\00\00\00\02\00\00\00\06\00\00\00a\00b\00c\00\00\00\00\00\00\00")
 (data $4 (i32.const 140) "\1c\00\00\00\00\00\00\00\00\00\00\00\02\00\00\00\08\00\00\00a\00b\00c\00d\00\00\00\00\00")
 (data $5 (i32.const 172) "\1c\00\00\00\00\00\00\00\00\00\00\00\02\00\00\00\n\00\00\00a\00b\00c\00d\00e\00\00\00")
 (data $6 (i32.const 204) "\1c\00\00\00\00\00\00\00\00\00\00\00\02\00\00\00\0c\00\00\00a\00b\00c\00d\00e\00f\00")
 (data $7 (i32.const 236) ",\00\00\00\00\00\00\00\00\00\00\00\02\00\00\00\0e\00\00\00a\00b\00c\00d\00e\00f\00g\00\00\00\00\00\00\00\00\00\00\00\00\00\00\00")
 (data $8 (i32.const 284) ",\00\00\00\00\00\00\00\00\00\00\00\02\00\00\00\10\00\00\00a\00b\00c\00d\00e\00f\00g\00h\00\00\00\00\00\00\00\00\00\00\00\00\00")
 (data $9 (i32.const 332) ",\00\00\00\00\00\00\00\00\00\00\00\02\00\00\00\12\00\00\00a\00b\00c\00d\00e\00f\00g\00h\00i\00\00\00\00\00\00\00\00\00\00\00")
 (table $0 1 1 funcref)
 (elem $0 (i32.const 1))
 (export "memory" (memory $0))
 (start $~start)
 (func $~lib/rt/common/OBJECT#get:rtSize (param $this i32) (result i32)
  (i32.load offset=16
   (local.get $this)
  )
 )
 (func $~lib/string/String#get:length (param $this i32) (result i32)
  (return
   (i32.shr_u
    (call $~lib/rt/common/OBJECT#get:rtSize
     (i32.sub
      (local.get $this)
      (i32.const 20)
     )
    )
    (i32.const 1)
   )
  )
 )
 (func $~lib/util/hash/HASH<~lib/string/String|null> (param $key i32) (result i32)
  (local $key|1 i32)
  (local $h i32)
  (local $len i32)
  (local $pos i32)
  (local $s1 i32)
  (local $s2 i32)
  (local $s3 i32)
  (local $s4 i32)
  (local $end i32)
  (local $h|10 i32)
  (local $key|11 i32)
  (local $h|12 i32)
  (local $key|13 i32)
  (local $h|14 i32)
  (local $key|15 i32)
  (local $h|16 i32)
  (local $key|17 i32)
  (local $end|18 i32)
  (drop
   (i32.const 1)
  )
  (return
   (block $~lib/util/hash/hashStr|inlined.0 (result i32)
    (local.set $key|1
     (call $~lib/rt/__localtostack
      (local.get $key)
     )
    )
    (if
     (i32.eq
      (local.get $key|1)
      (i32.const 0)
     )
     (then
      (br $~lib/util/hash/hashStr|inlined.0
       (i32.const 0)
      )
     )
    )
    (local.set $h
     (i32.shl
      (call $~lib/string/String#get:length
       (call $~lib/rt/__tmptostack
        (local.get $key|1)
       )
      )
      (i32.const 1)
     )
    )
    (local.set $len
     (local.get $h)
    )
    (local.set $pos
     (local.get $key|1)
    )
    (if
     (i32.ge_u
      (local.get $len)
      (i32.const 16)
     )
     (then
      (local.set $s1
       (i32.add
        (i32.add
         (i32.const 0)
         (i32.const -1640531535)
        )
        (i32.const -2048144777)
       )
      )
      (local.set $s2
       (i32.add
        (i32.const 0)
        (i32.const -2048144777)
       )
      )
      (local.set $s3
       (i32.const 0)
      )
      (local.set $s4
       (i32.sub
        (i32.const 0)
        (i32.const -1640531535)
       )
      )
      (local.set $end
       (i32.sub
        (i32.add
         (local.get $len)
         (local.get $pos)
        )
        (i32.const 16)
       )
      )
      (block $while-break|0
       (loop $while-continue|0
        (if
         (i32.le_u
          (local.get $pos)
          (local.get $end)
         )
         (then
          (local.set $s1
           (block $~lib/util/hash/mix|inlined.0 (result i32)
            (local.set $h|10
             (local.get $s1)
            )
            (local.set $key|11
             (i32.load
              (local.get $pos)
             )
            )
            (br $~lib/util/hash/mix|inlined.0
             (i32.mul
              (i32.rotl
               (i32.add
                (local.get $h|10)
                (i32.mul
                 (local.get $key|11)
                 (i32.const -2048144777)
                )
               )
               (i32.const 13)
              )
              (i32.const -1640531535)
             )
            )
           )
          )
          (local.set $s2
           (block $~lib/util/hash/mix|inlined.1 (result i32)
            (local.set $h|12
             (local.get $s2)
            )
            (local.set $key|13
             (i32.load offset=4
              (local.get $pos)
             )
            )
            (br $~lib/util/hash/mix|inlined.1
             (i32.mul
              (i32.rotl
               (i32.add
                (local.get $h|12)
                (i32.mul
                 (local.get $key|13)
                 (i32.const -2048144777)
                )
               )
               (i32.const 13)
              )
              (i32.const -1640531535)
             )
            )
           )
          )
          (local.set $s3
           (block $~lib/util/hash/mix|inlined.2 (result i32)
            (local.set $h|14
             (local.get $s3)
            )
            (local.set $key|15
             (i32.load offset=8
              (local.get $pos)
             )
            )
            (br $~lib/util/hash/mix|inlined.2
             (i32.mul
              (i32.rotl
               (i32.add
                (local.get $h|14)
                (i32.mul
                 (local.get $key|15)
                 (i32.const -2048144777)
                )
               )
               (i32.const 13)
              )
              (i32.const -1640531535)
             )
            )
           )
          )
          (local.set $s4
           (block $~lib/util/hash/mix|inlined.3 (result i32)
            (local.set $h|16
             (local.get $s4)
            )
            (local.set $key|17
             (i32.load offset=12
              (local.get $pos)
             )
            )
            (br $~lib/util/hash/mix|inlined.3
             (i32.mul
              (i32.rotl
               (i32.add
                (local.get $h|16)
                (i32.mul
                 (local.get $key|17)
                 (i32.const -2048144777)
                )
               )
               (i32.const 13)
              )
              (i32.const -1640531535)
             )
            )
           )
          )
          (local.set $pos
           (i32.add
            (local.get $pos)
            (i32.const 16)
           )
          )
          (br $while-continue|0)
         )
        )
       )
      )
      (local.set $h
       (i32.add
        (local.get $h)
        (i32.add
         (i32.add
          (i32.add
           (i32.rotl
            (local.get $s1)
            (i32.const 1)
           )
           (i32.rotl
            (local.get $s2)
            (i32.const 7)
           )
          )
          (i32.rotl
           (local.get $s3)
           (i32.const 12)
          )
         )
         (i32.rotl
          (local.get $s4)
          (i32.const 18)
         )
        )
       )
      )
     )
     (else
      (local.set $h
       (i32.add
        (local.get $h)
        (i32.add
         (i32.const 0)
         (i32.const 374761393)
        )
       )
      )
     )
    )
    (local.set $end|18
     (i32.sub
      (i32.add
       (local.get $key|1)
       (local.get $len)
      )
      (i32.const 4)
     )
    )
    (block $while-break|1
     (loop $while-continue|1
      (if
       (i32.le_u
        (local.get $pos)
        (local.get $end|18)
       )
       (then
        (local.set $h
         (i32.add
          (local.get $h)
          (i32.mul
           (i32.load
            (local.get $pos)
           )
           (i32.const -1028477379)
          )
         )
        )
        (local.set $h
         (i32.mul
          (i32.rotl
           (local.get $h)
           (i32.const 17)
          )
          (i32.const 668265263)
         )
        )
        (local.set $pos
         (i32.add
          (local.get $pos)
          (i32.const 4)
         )
        )
        (br $while-continue|1)
       )
      )
     )
    )
    (local.set $end|18
     (i32.add
      (local.get $key|1)
      (local.get $len)
     )
    )
    (block $while-break|2
     (loop $while-continue|2
      (if
       (i32.lt_u
        (local.get $pos)
        (local.get $end|18)
       )
       (then
        (local.set $h
         (i32.add
          (local.get $h)
          (i32.mul
           (i32.load8_u
            (local.get $pos)
           )
           (i32.const 374761393)
          )
         )
        )
        (local.set $h
         (i32.mul
          (i32.rotl
           (local.get $h)
           (i32.const 11)
          )
          (i32.const -1640531535)
         )
        )
        (local.set $pos
         (i32.add
          (local.get $pos)
          (i32.const 1)
         )
        )
        (br $while-continue|2)
       )
      )
     )
    )
    (local.set $h
     (i32.xor
      (local.get $h)
      (i32.shr_u
       (local.get $h)
       (i32.const 15)
      )
     )
    )
    (local.set $h
     (i32.mul
      (local.get $h)
      (i32.const -2048144777)
     )
    )
    (local.set $h
     (i32.xor
      (local.get $h)
      (i32.shr_u
       (local.get $h)
       (i32.const 13)
      )
     )
    )
    (local.set $h
     (i32.mul
      (local.get $h)
      (i32.const -1028477379)
     )
    )
    (local.set $h
     (i32.xor
      (local.get $h)
      (i32.shr_u
       (local.get $h)
       (i32.const 16)
      )
     )
    )
    (br $~lib/util/hash/hashStr|inlined.0
     (local.get $h)
    )
   )
  )
 )
 (func $std/hash/check (param $hash i32) (result i32)
  (return
   (i32.const 1)
  )
 )
 (func $~lib/util/hash/HASH<~lib/string/String> (param $key i32) (result i32)
  (local $key|1 i32)
  (local $h i32)
  (local $len i32)
  (local $pos i32)
  (local $s1 i32)
  (local $s2 i32)
  (local $s3 i32)
  (local $s4 i32)
  (local $end i32)
  (local $h|10 i32)
  (local $key|11 i32)
  (local $h|12 i32)
  (local $key|13 i32)
  (local $h|14 i32)
  (local $key|15 i32)
  (local $h|16 i32)
  (local $key|17 i32)
  (local $end|18 i32)
  (drop
   (i32.const 1)
  )
  (return
   (block $~lib/util/hash/hashStr|inlined.1 (result i32)
    (local.set $key|1
     (call $~lib/rt/__localtostack
      (local.get $key)
     )
    )
    (if
     (i32.eq
      (local.get $key|1)
      (i32.const 0)
     )
     (then
      (br $~lib/util/hash/hashStr|inlined.1
       (i32.const 0)
      )
     )
    )
    (local.set $h
     (i32.shl
      (call $~lib/string/String#get:length
       (call $~lib/rt/__tmptostack
        (local.get $key|1)
       )
      )
      (i32.const 1)
     )
    )
    (local.set $len
     (local.get $h)
    )
    (local.set $pos
     (local.get $key|1)
    )
    (if
     (i32.ge_u
      (local.get $len)
      (i32.const 16)
     )
     (then
      (local.set $s1
       (i32.add
        (i32.add
         (i32.const 0)
         (i32.const -1640531535)
        )
        (i32.const -2048144777)
       )
      )
      (local.set $s2
       (i32.add
        (i32.const 0)
        (i32.const -2048144777)
       )
      )
      (local.set $s3
       (i32.const 0)
      )
      (local.set $s4
       (i32.sub
        (i32.const 0)
        (i32.const -1640531535)
       )
      )
      (local.set $end
       (i32.sub
        (i32.add
         (local.get $len)
         (local.get $pos)
        )
        (i32.const 16)
       )
      )
      (block $while-break|0
       (loop $while-continue|0
        (if
         (i32.le_u
          (local.get $pos)
          (local.get $end)
         )
         (then
          (local.set $s1
           (block $~lib/util/hash/mix|inlined.4 (result i32)
            (local.set $h|10
             (local.get $s1)
            )
            (local.set $key|11
             (i32.load
              (local.get $pos)
             )
            )
            (br $~lib/util/hash/mix|inlined.4
             (i32.mul
              (i32.rotl
               (i32.add
                (local.get $h|10)
                (i32.mul
                 (local.get $key|11)
                 (i32.const -2048144777)
                )
               )
               (i32.const 13)
              )
              (i32.const -1640531535)
             )
            )
           )
          )
          (local.set $s2
           (block $~lib/util/hash/mix|inlined.5 (result i32)
            (local.set $h|12
             (local.get $s2)
            )
            (local.set $key|13
             (i32.load offset=4
              (local.get $pos)
             )
            )
            (br $~lib/util/hash/mix|inlined.5
             (i32.mul
              (i32.rotl
               (i32.add
                (local.get $h|12)
                (i32.mul
                 (local.get $key|13)
                 (i32.const -2048144777)
                )
               )
               (i32.const 13)
              )
              (i32.const -1640531535)
             )
            )
           )
          )
          (local.set $s3
           (block $~lib/util/hash/mix|inlined.6 (result i32)
            (local.set $h|14
             (local.get $s3)
            )
            (local.set $key|15
             (i32.load offset=8
              (local.get $pos)
             )
            )
            (br $~lib/util/hash/mix|inlined.6
             (i32.mul
              (i32.rotl
               (i32.add
                (local.get $h|14)
                (i32.mul
                 (local.get $key|15)
                 (i32.const -2048144777)
                )
               )
               (i32.const 13)
              )
              (i32.const -1640531535)
             )
            )
           )
          )
          (local.set $s4
           (block $~lib/util/hash/mix|inlined.7 (result i32)
            (local.set $h|16
             (local.get $s4)
            )
            (local.set $key|17
             (i32.load offset=12
              (local.get $pos)
             )
            )
            (br $~lib/util/hash/mix|inlined.7
             (i32.mul
              (i32.rotl
               (i32.add
                (local.get $h|16)
                (i32.mul
                 (local.get $key|17)
                 (i32.const -2048144777)
                )
               )
               (i32.const 13)
              )
              (i32.const -1640531535)
             )
            )
           )
          )
          (local.set $pos
           (i32.add
            (local.get $pos)
            (i32.const 16)
           )
          )
          (br $while-continue|0)
         )
        )
       )
      )
      (local.set $h
       (i32.add
        (local.get $h)
        (i32.add
         (i32.add
          (i32.add
           (i32.rotl
            (local.get $s1)
            (i32.const 1)
           )
           (i32.rotl
            (local.get $s2)
            (i32.const 7)
           )
          )
          (i32.rotl
           (local.get $s3)
           (i32.const 12)
          )
         )
         (i32.rotl
          (local.get $s4)
          (i32.const 18)
         )
        )
       )
      )
     )
     (else
      (local.set $h
       (i32.add
        (local.get $h)
        (i32.add
         (i32.const 0)
         (i32.const 374761393)
        )
       )
      )
     )
    )
    (local.set $end|18
     (i32.sub
      (i32.add
       (local.get $key|1)
       (local.get $len)
      )
      (i32.const 4)
     )
    )
    (block $while-break|1
     (loop $while-continue|1
      (if
       (i32.le_u
        (local.get $pos)
        (local.get $end|18)
       )
       (then
        (local.set $h
         (i32.add
          (local.get $h)
          (i32.mul
           (i32.load
            (local.get $pos)
           )
           (i32.const -1028477379)
          )
         )
        )
        (local.set $h
         (i32.mul
          (i32.rotl
           (local.get $h)
           (i32.const 17)
          )
          (i32.const 668265263)
         )
        )
        (local.set $pos
         (i32.add
          (local.get $pos)
          (i32.const 4)
         )
        )
        (br $while-continue|1)
       )
      )
     )
    )
    (local.set $end|18
     (i32.add
      (local.get $key|1)
      (local.get $len)
     )
    )
    (block $while-break|2
     (loop $while-continue|2
      (if
       (i32.lt_u
        (local.get $pos)
        (local.get $end|18)
       )
       (then
        (local.set $h
         (i32.add
          (local.get $h)
          (i32.mul
           (i32.load8_u
            (local.get $pos)
           )
           (i32.const 374761393)
          )
         )
        )
        (local.set $h
         (i32.mul
          (i32.rotl
           (local.get $h)
           (i32.const 11)
          )
          (i32.const -1640531535)
         )
        )
        (local.set $pos
         (i32.add
          (local.get $pos)
          (i32.const 1)
         )
        )
        (br $while-continue|2)
       )
      )
     )
    )
    (local.set $h
     (i32.xor
      (local.get $h)
      (i32.shr_u
       (local.get $h)
       (i32.const 15)
      )
     )
    )
    (local.set $h
     (i32.mul
      (local.get $h)
      (i32.const -2048144777)
     )
    )
    (local.set $h
     (i32.xor
      (local.get $h)
      (i32.shr_u
       (local.get $h)
       (i32.const 13)
      )
     )
    )
    (local.set $h
     (i32.mul
      (local.get $h)
      (i32.const -1028477379)
     )
    )
    (local.set $h
     (i32.xor
      (local.get $h)
      (i32.shr_u
       (local.get $h)
       (i32.const 16)
      )
     )
    )
    (br $~lib/util/hash/hashStr|inlined.1
     (local.get $h)
    )
   )
  )
 )
 (func $~lib/util/hash/HASH<f32> (param $key f32) (result i32)
  (local $key|1 i32)
  (local $len i32)
  (local $h i32)
  (drop
   (i32.const 0)
  )
  (block
   (drop
    (i32.const 0)
   )
   (block
    (drop
     (i32.const 1)
    )
    (block
     (drop
      (i32.eq
       (i32.const 4)
       (i32.const 4)
      )
     )
     (return
      (block $~lib/util/hash/hash32|inlined.0 (result i32)
       (local.set $key|1
        (i32.reinterpret_f32
         (local.get $key)
        )
       )
       (local.set $len
        (i32.const 4)
       )
       (local.set $h
        (i32.add
         (i32.add
          (i32.const 0)
          (i32.const 374761393)
         )
         (local.get $len)
        )
       )
       (local.set $h
        (i32.add
         (local.get $h)
         (i32.mul
          (local.get $key|1)
          (i32.const -1028477379)
         )
        )
       )
       (local.set $h
        (i32.mul
         (i32.rotl
          (local.get $h)
          (i32.const 17)
         )
         (i32.const 668265263)
        )
       )
       (local.set $h
        (i32.xor
         (local.get $h)
         (i32.shr_u
          (local.get $h)
          (i32.const 15)
         )
        )
       )
       (local.set $h
        (i32.mul
         (local.get $h)
         (i32.const -2048144777)
        )
       )
       (local.set $h
        (i32.xor
         (local.get $h)
         (i32.shr_u
          (local.get $h)
          (i32.const 13)
         )
        )
       )
       (local.set $h
        (i32.mul
         (local.get $h)
         (i32.const -1028477379)
        )
       )
       (local.set $h
        (i32.xor
         (local.get $h)
         (i32.shr_u
          (local.get $h)
          (i32.const 16)
         )
        )
       )
       (br $~lib/util/hash/hash32|inlined.0
        (local.get $h)
       )
      )
     )
    )
   )
  )
 )
 (func $~lib/util/hash/HASH<f64> (param $key f64) (result i32)
  (local $key|1 i64)
  (local $h i32)
  (drop
   (i32.const 0)
  )
  (block
   (drop
    (i32.const 0)
   )
   (block
    (drop
     (i32.const 1)
    )
    (block
     (drop
      (i32.eq
       (i32.const 8)
       (i32.const 4)
      )
     )
     (drop
      (i32.eq
       (i32.const 8)
       (i32.const 8)
      )
     )
     (return
      (block $~lib/util/hash/hash64|inlined.0 (result i32)
       (local.set $key|1
        (i64.reinterpret_f64
         (local.get $key)
        )
       )
       (local.set $h
        (i32.add
         (i32.add
          (i32.const 0)
          (i32.const 374761393)
         )
         (i32.const 8)
        )
       )
       (local.set $h
        (i32.add
         (local.get $h)
         (i32.mul
          (i32.wrap_i64
           (local.get $key|1)
          )
          (i32.const -1028477379)
         )
        )
       )
       (local.set $h
        (i32.mul
         (i32.rotl
          (local.get $h)
          (i32.const 17)
         )
         (i32.const 668265263)
        )
       )
       (local.set $h
        (i32.add
         (local.get $h)
         (i32.mul
          (i32.wrap_i64
           (i64.shr_u
            (local.get $key|1)
            (i64.const 32)
           )
          )
          (i32.const -1028477379)
         )
        )
       )
       (local.set $h
        (i32.mul
         (i32.rotl
          (local.get $h)
          (i32.const 17)
         )
         (i32.const 668265263)
        )
       )
       (local.set $h
        (i32.xor
         (local.get $h)
         (i32.shr_u
          (local.get $h)
          (i32.const 15)
         )
        )
       )
       (local.set $h
        (i32.mul
         (local.get $h)
         (i32.const -2048144777)
        )
       )
       (local.set $h
        (i32.xor
         (local.get $h)
         (i32.shr_u
          (local.get $h)
          (i32.const 13)
         )
        )
       )
       (local.set $h
        (i32.mul
         (local.get $h)
         (i32.const -1028477379)
        )
       )
       (local.set $h
        (i32.xor
         (local.get $h)
         (i32.shr_u
          (local.get $h)
          (i32.const 16)
         )
        )
       )
       (br $~lib/util/hash/hash64|inlined.0
        (local.get $h)
       )
      )
     )
    )
   )
  )
 )
 (func $start:std/hash
  (drop
   (call $std/hash/check
    (call $~lib/util/hash/HASH<~lib/string/String|null>
     (i32.const 0)
    )
   )
  )
  (drop
   (call $std/hash/check
    (call $~lib/util/hash/HASH<~lib/string/String>
     (i32.const 32)
    )
   )
  )
  (drop
   (call $std/hash/check
    (call $~lib/util/hash/HASH<~lib/string/String>
     (i32.const 64)
    )
   )
  )
  (drop
   (call $std/hash/check
    (call $~lib/util/hash/HASH<~lib/string/String>
     (i32.const 96)
    )
   )
  )
  (drop
   (call $std/hash/check
    (call $~lib/util/hash/HASH<~lib/string/String>
     (i32.const 128)
    )
   )
  )
  (drop
   (call $std/hash/check
    (call $~lib/util/hash/HASH<~lib/string/String>
     (i32.const 160)
    )
   )
  )
  (drop
   (call $std/hash/check
    (call $~lib/util/hash/HASH<~lib/string/String>
     (i32.const 192)
    )
   )
  )
  (drop
   (call $std/hash/check
    (call $~lib/util/hash/HASH<~lib/string/String>
     (i32.const 224)
    )
   )
  )
  (drop
   (call $std/hash/check
    (call $~lib/util/hash/HASH<~lib/string/String>
     (i32.const 256)
    )
   )
  )
  (drop
   (call $std/hash/check
    (call $~lib/util/hash/HASH<~lib/string/String>
     (i32.const 304)
    )
   )
  )
  (drop
   (call $std/hash/check
    (call $~lib/util/hash/HASH<~lib/string/String>
     (i32.const 352)
    )
   )
  )
  (drop
   (call $std/hash/check
    (call $~lib/util/hash/HASH<f32>
     (f32.const 0)
    )
   )
  )
  (drop
   (call $std/hash/check
    (call $~lib/util/hash/HASH<f32>
     (f32.const 1)
    )
   )
  )
  (drop
   (call $std/hash/check
    (call $~lib/util/hash/HASH<f32>
     (f32.const 1.100000023841858)
    )
   )
  )
  (drop
   (call $std/hash/check
    (call $~lib/util/hash/HASH<f32>
     (f32.const -0)
    )
   )
  )
  (drop
   (call $std/hash/check
    (call $~lib/util/hash/HASH<f32>
     (f32.const inf)
    )
   )
  )
  (drop
   (call $std/hash/check
    (call $~lib/util/hash/HASH<f32>
     (f32.const nan:0x400000)
    )
   )
  )
  (drop
   (call $std/hash/check
    (call $~lib/util/hash/HASH<f64>
     (f64.const 0)
    )
   )
  )
  (drop
   (call $std/hash/check
    (call $~lib/util/hash/HASH<f64>
     (f64.const 1)
    )
   )
  )
  (drop
   (call $std/hash/check
    (call $~lib/util/hash/HASH<f64>
     (f64.const 1.1)
    )
   )
  )
  (drop
   (call $std/hash/check
    (call $~lib/util/hash/HASH<f64>
     (f64.const -0)
    )
   )
  )
  (drop
   (call $std/hash/check
    (call $~lib/util/hash/HASH<f64>
     (f64.const inf)
    )
   )
  )
  (drop
   (call $std/hash/check
    (call $~lib/util/hash/HASH<f64>
     (f64.const nan:0x8000000000000)
    )
   )
  )
 )
 (func $~start
  (call $start:std/hash)
 )
)
