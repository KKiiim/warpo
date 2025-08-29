#pragma once

#include <cstdint>
#include <cstdlib>
#include <cstring>
#include <filesystem>
#include <fmt/base.h>
#include <fmt/format.h>
#include <map>
#include <optional>
#include <string>
#include <string_view>
#include <vector>

#include "warpo/frontend/Compiler.hpp"
#include "wasm-compiler/src/WasmModule/WasmModule.hpp"
#include "wasm-compiler/src/utils/STDCompilerLogger.hpp"
#include "wasm.h"

namespace warpo::frontend {

class FrontendCompiler {
  enum class IsEntry : uint32_t { NO, YES };

  vb::STDCompilerLogger logger;
  vb::WasmModule m;
  uint8_t const *stackTop;

  std::map<std::string, std::filesystem::path> packageRootMap_{};

  int32_t allocString(std::string_view str);

  void parseFile(int32_t const program, std::optional<std::string> const &code, std::string_view path, IsEntry isEntry);

  std::string getAsString(int32_t ptr);

  std::optional<std::filesystem::path> findPackageRoot(std::filesystem::path const &sourcePath,
                                                       std::string const &packageName);

  struct Dependency {
    std::optional<std::string> text;
    std::string path;
  };

  Dependency getDependencyForNodeModules(std::string const &nextFileInternalPath, int32_t program, int32_t nextFile);
  Dependency getDependencyForUserCode(std::string const &nextFileInternalPath);
  Dependency getDependency(std::string const &nextFileInternalPath, int32_t program, int32_t nextFile);

  std::vector<Dependency> getAllDependencies(int32_t const program);

  size_t checkDiag(int32_t const program);

public:
  static void init() { vb::WasmModule::initEnvironment(&malloc, &realloc, &free); }
  static void deinit() { vb::WasmModule::destroyEnvironment(); }

  FrontendCompiler(Config const &config);

  wasm::Module *compile(std::vector<std::string> const &entryFilePaths, Config const &config);
};

} // namespace warpo::frontend
