#pragma once

#include <cassert>

#include "wasm.h"

namespace warpo::passes {

inline void setAsUnImported(wasm::Importable *importable) {
  assert(importable != nullptr);
  importable->module = wasm::Name{};
  importable->base = wasm::Name{};
}

} // namespace warpo::passes
