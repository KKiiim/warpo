#pragma once

#include "pass.h"
#include "wasm.h"

namespace warpo::passes::gc {

/// @brief fast lower tostack function
struct FastLower : public wasm::Pass {
  explicit FastLower() { name = "gc::FastLower"; }
  void run(wasm::Module *m) override;
};

} // namespace warpo::passes::gc
