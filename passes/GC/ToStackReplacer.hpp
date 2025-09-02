#pragma once

#include <fmt/base.h>
#include <fmt/format.h>
#include <memory>

#include "StackAssigner.hpp"
#include "pass.h"
#include "wasm.h"

namespace warpo::passes::gc {

// localtostack/tmptostack => tostack<offset>(v)
struct ToStackReplacer : public wasm::Pass {
  std::shared_ptr<StackPositions const> stackPositions_;
  explicit ToStackReplacer(std::shared_ptr<StackPositions const> const &stackPositions)
      : stackPositions_(stackPositions) {
    name = "ToStackReplacer";
  }
  bool isFunctionParallel() override { return true; }
  std::unique_ptr<Pass> create() override { return std::make_unique<ToStackReplacer>(stackPositions_); }
  bool modifiesBinaryenIR() override { return true; }
  void runOnFunction(wasm::Module *m, wasm::Function *func) override;

  static wasm::Name getToStackFunctionName(uint32_t offset) {
    return wasm::Name{fmt::format("~lib/rt/__tostack<{}>", offset)};
  }

private:
  void replaceToStackCallExpr(wasm::Module *m, wasm::Function *func, StackPosition const &stackPosition);
};

} // namespace warpo::passes::gc
