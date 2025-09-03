#pragma once

#include <binaryen/src/binaryen-c.h>
#include <cstdint>
#include <string>
#include <vector>

namespace warpo::passes {

struct Output {
  std::string wat;
  std::vector<uint8_t> wasm;
  std::string sourceMap;
};

struct Config {
  std::string sourceMapURL;
};

void init();

Output runOnWat(std::string const &input, Config const &config);
Output runOnModule(BinaryenModuleRef const m, Config const &config);

void runAndEmit(BinaryenModuleRef const m, std::string const &outputPath);
void runAndEmit(std::string const &inputPath, std::string const &outputPath);

} // namespace warpo::passes
