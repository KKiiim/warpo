#pragma once

#include <chrono>

namespace warpo::support {

enum class PerfItemKind {
  Root,

  CompilationHIR,
  Optimization,

  CompilationHIR_PrepareWASMModule,
  CompilationHIR_Init,
  CompilationHIR_Parsing,
  CompilationHIR_Compilation,

  CompilationHIR_Parsing_DepsResolve,
  CompilationHIR_Parsing_BuiltinLib,
};

class PerformanceStatisticRange {
  bool free_ = false;
  PerfItemKind item_;
  std::chrono::nanoseconds startTime_;

public:
  explicit PerformanceStatisticRange(PerfItemKind item);
  ~PerformanceStatisticRange();

  void release();
};

} // namespace warpo::support
