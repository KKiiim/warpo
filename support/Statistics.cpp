

#include <chrono>
#include <cstddef>
#include <map>
#include <mutex>
#include <set>
#include <string>

#include "argparse/argparse.hpp"
#include "fmt/base.h"
#include "fmt/format.h"
#include "warpo/support/Opt.hpp"
#include "warpo/support/Statistics.hpp"

namespace warpo::support {

static cli::Opt<bool> EnableStatisticsOption{
    cli::Category::All,
    "--stats",
    [](argparse::Argument &arg) { arg.help("Prints statistics times.").flag().hidden(); },
};

static std::chrono::nanoseconds now() {
  return std::chrono::duration_cast<std::chrono::nanoseconds>(
      std::chrono::high_resolution_clock::now().time_since_epoch());
}

namespace {

struct PerformanceData {
  std::chrono::nanoseconds totalDuration_{0U};
  size_t cnt_ = 0;
};

static const char *toString(PerfItemKind kind) {
  switch (kind) {
  case PerfItemKind::Root:
    return "Root";
  case PerfItemKind::CompilationHIR:
    return "CompilationHIR";
  case PerfItemKind::Optimization:
    return "Optimization";
  case PerfItemKind::CompilationHIR_PrepareWASMModule:
    return "PrepareWASMModule";
  case PerfItemKind::CompilationHIR_Init:
    return "Init";
  case PerfItemKind::CompilationHIR_Parsing:
    return "Parsing";
  case PerfItemKind::CompilationHIR_Compilation:
    return "Compilation";
  case PerfItemKind::CompilationHIR_Parsing_DepsResolve:
    return "DepsResolve";
  case PerfItemKind::CompilationHIR_Parsing_BuiltinLib:
    return "BuiltinLib";
  }
  return "Unknown";
}

static std::string toString(std::chrono::nanoseconds ns) {
  uint64_t duration = ns.count();
  if (duration >= 1'000'000'000)
    return fmt::format("{:.3f}s", static_cast<double>(duration) / 1'000'000'000);
  if (duration >= 1'000'000)
    return fmt::format("{:.3f}ms", static_cast<double>(duration) / 1'000'000);
  if (duration >= 1'000)
    return fmt::format("{:.3f}µs", static_cast<double>(duration) / 1'000);
  return fmt::format("{:.3f}ns", static_cast<double>(duration));
}

class PerformanceCollector {
  std::mutex mutex_;
  std::map<PerfItemKind, PerformanceData> data_;

  void printNestedPerformanceData(size_t ident, PerfItemKind current,
                                  std::map<PerfItemKind, std::set<PerfItemKind>> const &nested) {
    fmt::println("{:>{}}- {}: {} times, total {}", "", ident * 2, toString(current), data_[current].cnt_,
                 toString(data_[current].totalDuration_));
    auto it = nested.find(current);
    if (it != nested.end()) {
      for (const auto &child : it->second)
        printNestedPerformanceData(ident + 1, child, nested);
    }
  }

public:
  PerformanceCollector() = default;
  PerformanceCollector(PerformanceCollector const &) = delete;
  PerformanceCollector(PerformanceCollector &&) = delete;
  PerformanceCollector &operator=(PerformanceCollector const &) = delete;
  PerformanceCollector &operator=(PerformanceCollector &&) = delete;

  static PerformanceCollector &ins() {
    static PerformanceCollector instance{};
    return instance;
  }

  void addData(PerfItemKind item, std::chrono::nanoseconds duration) {
    std::lock_guard<std::mutex> lock(mutex_);
    PerformanceData &data = data_[item];
    data.totalDuration_ += duration;
    data.cnt_++;
  }

  ~PerformanceCollector() {
    std::map<PerfItemKind, std::set<PerfItemKind>> const nested{
        std::pair<PerfItemKind, std::set<PerfItemKind>>{
            PerfItemKind::Root,
            {
                PerfItemKind::CompilationHIR,
                PerfItemKind::Optimization,
            },
        },
        std::pair<PerfItemKind, std::set<PerfItemKind>>{
            PerfItemKind::CompilationHIR,
            {
                PerfItemKind::CompilationHIR_Compilation,
                PerfItemKind::CompilationHIR_Init,
                PerfItemKind::CompilationHIR_Parsing,
                PerfItemKind::CompilationHIR_PrepareWASMModule,
            },
        },
        std::pair<PerfItemKind, std::set<PerfItemKind>>{
            PerfItemKind::CompilationHIR_Parsing,
            {
                PerfItemKind::CompilationHIR_Parsing_DepsResolve,
                PerfItemKind::CompilationHIR_Parsing_BuiltinLib,
            },
        },
        std::pair<PerfItemKind, std::set<PerfItemKind>>{
            PerfItemKind::Optimization,
            {},
        },
    };
    printNestedPerformanceData(0U, PerfItemKind::Root, nested);
  }
};

} // namespace

PerformanceStatisticRange::PerformanceStatisticRange(PerfItemKind item) : item_(item), startTime_(now()) {
  if (!EnableStatisticsOption.get())
    return;
}

PerformanceStatisticRange::~PerformanceStatisticRange() {
  if (!free_)
    release();
}

void PerformanceStatisticRange::release() {
  if (!EnableStatisticsOption.get())
    return;
  std::chrono::nanoseconds endTime = now();
  PerformanceCollector::ins().addData(item_, endTime - startTime_);
  free_ = true;
}

} // namespace warpo::support
