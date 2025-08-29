#pragma once

#include <binaryen/src/binaryen-c.h>
#include <map>
#include <optional>
#include <string>
#include <vector>

namespace warpo::frontend {

void init();

// sync from assemblyscript/std/assembly/shared/feature.ts
enum class Features : uint32_t {
  /** No additional features. */
  None = 0,
  /** Sign extension operations. */
  SignExtension = 1 << 0, // see: https://github.com/WebAssembly/sign-extension-ops
  /** Mutable global imports and exports. */
  MutableGlobals = 1 << 1, // see: https://github.com/WebAssembly/mutable-global
  /** Non-trapping float to integer operations. */
  NontrappingF2I = 1 << 2, // see: https://github.com/WebAssembly/nontrapping-float-to-int-conversions
  /** Bulk memory operations. */
  BulkMemory = 1 << 3, // see: https://github.com/WebAssembly/bulk-memory-operations
  /** SIMD types and operations. */
  Simd = 1 << 4, // see: https://github.com/WebAssembly/simd
  /** Threading and atomic operations. */
  Threads = 1 << 5, // see: https://github.com/WebAssembly/threads
  /** Exception handling operations. */
  ExceptionHandling = 1 << 6, // see: https://github.com/WebAssembly/exception-handling
  /** Tail call operations. */
  TailCalls = 1 << 7, // see: https://github.com/WebAssembly/tail-call
  /** Reference types. */
  ReferenceTypes = 1 << 8, // see: https://github.com/WebAssembly/reference-types
  /** Multi value types. */
  MultiValue = 1 << 9, // see: https://github.com/WebAssembly/multi-value
  /** Garbage collection. */
  GC = 1 << 10, // see: https://github.com/WebAssembly/gc
  /** Memory64. */
  Memory64 = 1 << 11, // see: https://github.com/WebAssembly/memory64
  /** Relaxed SIMD. */
  RelaxedSimd = 1 << 12, // see: https://github.com/WebAssembly/relaxed-simd
  /** Extended const expressions. */
  ExtendedConst = 1 << 13, // see: https://github.com/WebAssembly/extended-const
  /** Reference typed strings. */
  Stringref = 1 << 14, // see: https://github.com/WebAssembly/stringref
  /** All features. */
  All = (1 << 15) - 1
};

struct Config {
  std::map<std::string, std::string> uses;
  std::optional<std::string> ascWasmPath;
  Features features;
  std::optional<std::string> exportStart;
  bool exportRuntime;
  bool exportTable;
  std::optional<uint32_t> initialMemory;
};

BinaryenModuleRef compile();
BinaryenModuleRef compile(std::vector<std::string> const &entryFilePaths, Config const &config);

} // namespace warpo::frontend
