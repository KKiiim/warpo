#include <cstdlib>
#include <cstring>
#include <fmt/base.h>
#include <fmt/format.h>
#include <map>
#include <optional>
#include <stdexcept>
#include <string>
#include <vector>

#include "CompilerImpl.hpp"
#include "warpo/frontend/Compiler.hpp"
#include "warpo/support/Opt.hpp"

namespace warpo::frontend {

static std::optional<std::string> convertEmptyStringToNullOpt(std::string const &str) {
  if (!str.empty())
    return str;
  return std::nullopt;
}

static cli::Opt<std::vector<std::string>> entryPaths{
    "entries",
    [](argparse::Argument &arg) -> void { arg.help("entry files").nargs(argparse::nargs_pattern::at_least_one); },
};

static cli::Opt<std::vector<std::string>> useOptions{
    "-u",
    "--use",
    [](argparse::Argument &arg) -> void {
      arg.help("use option, format <name>=<value>").nargs(argparse::nargs_pattern::at_least_one).append();
    },
};
static std::map<std::string, std::string> getUses() {
  std::map<std::string, std::string> res{};
  std::vector<std::string> const &uses = useOptions.get();
  for (std::string const &use : uses) {
    size_t const eqPos = use.find('=');
    if (eqPos == std::string::npos || eqPos == 0) {
      fmt::println("ERROR: invalid use option: {}", use);
      std::exit(1);
    }
    res.insert_or_assign(use.substr(0, eqPos), use.substr(eqPos + 1));
  }
  return res;
}

static cli::Opt<std::string> ascWasmOption{
    "--asc-wasm",
    [](argparse::Argument &arg) -> void { arg.help("WASM files for the frontend compiler").hidden(); },
};

static cli::Opt<std::vector<std::string>> disableFeatureOptions{
    "--disable-feature",
    [](argparse::Argument &arg) -> void {
      arg.help("disable mutable-globals, sign-extension, nontrapping-f2i, bulk-memory")
          .nargs(argparse::nargs_pattern::at_least_one)
          .append();
    },
};
static Features operator|(Features a, Features b) {
  return static_cast<Features>(static_cast<uint32_t>(a) | static_cast<uint32_t>(b));
}
static Features unset(Features a, Features b) {
  return static_cast<Features>(static_cast<uint32_t>(a) & ~static_cast<uint32_t>(b));
}
static Features getFeatures() {
  Features res = Features::MutableGlobals | Features::SignExtension | Features::NontrappingF2I | Features::BulkMemory;
  std::vector<std::string> const &disableFeatures = disableFeatureOptions.get();
  for (std::string const &disableFeature : disableFeatures) {
    if (disableFeature == "sign-extension") {
      res = unset(res, Features::SignExtension);
    } else if (disableFeature == "mutable-globals") {
      res = unset(res, Features::MutableGlobals);
    } else if (disableFeature == "nontrapping-f2i") {
      res = unset(res, Features::NontrappingF2I);
    } else if (disableFeature == "bulk-memory") {
      res = unset(res, Features::BulkMemory);
    } else {
      throw std::runtime_error("unknown feature: " + disableFeature);
    }
  }
  return res;
}

static cli::Opt<std::string> exportStartOption{
    "--exportStart",
    [](argparse::Argument &arg) -> void {
      arg.help("Exports the start function using the specified name instead of calling it implicitly."
               " Useful to obtain the exported memory before executing any code accessing it.")
          .nargs(1);
    },
};

static cli::Opt<bool> exportTableOption{
    "--exportTable",
    [](argparse::Argument &arg) -> void { arg.help("Exports the function table as 'table'.").flag(); },
};
static cli::Opt<bool> exportRuntimeOption{
    "--exportRuntime",
    [](argparse::Argument &arg) -> void {
      arg.help("Always exports the runtime helpers (__new, __collect, __pin etc.).").flag();
    },
};

static cli::Opt<uint32_t> initialMemoryOption{
    "--initialMemory",
    [](argparse::Argument &arg) -> void {
      arg.help("Sets the initial memory size in pages.").nargs(1).default_value(static_cast<uint32_t>(-1));
    },
};

} // namespace warpo::frontend

void warpo::frontend::init() { FrontendCompiler::init(); }

BinaryenModuleRef warpo::frontend::compile(std::vector<std::string> const &entryFilePaths, Config const &config) {
  FrontendCompiler compiler{config};
  return compiler.compile(entryFilePaths, config);
}

BinaryenModuleRef warpo::frontend::compile() {
  Config config{
      .uses = getUses(),
      .ascWasmPath = convertEmptyStringToNullOpt(ascWasmOption.get()),
      .features = getFeatures(),
      .exportStart = convertEmptyStringToNullOpt(exportStartOption.get()),
      .exportRuntime = exportRuntimeOption.get(),
      .exportTable = exportTableOption.get(),
      .initialMemory = initialMemoryOption.get() == static_cast<uint32_t>(-1)
                           ? std::nullopt
                           : std::optional<uint32_t>{initialMemoryOption.get()},
  };

  return compile(entryPaths.get(), config);
}
