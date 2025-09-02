#include <cassert>
#include <cstddef>
#include <map>
#include <memory>

#include "GCInfo.hpp"
#include "StackAssigner.hpp"
#include "ToStackReplacer.hpp"
#include "support/name.h"
#include "wasm-builder.h"
#include "wasm-traversal.h"
#include "wasm.h"

#define PASS_NAME "ToStackReplacer"

namespace warpo::passes::gc {

void ToStackReplacer::runOnFunction(wasm::Module *m, wasm::Function *func) {
  StackPosition const &stackPosition = stackPositions_->at(func);
  replaceToStackCallExpr(m, func, stackPosition);
}

void ToStackReplacer::replaceToStackCallExpr(wasm::Module *m, wasm::Function *func,
                                             StackPosition const &stackPosition) {
  struct CallReplacer : public wasm::PostWalker<CallReplacer> {
    wasm::Function *func;
    StackPosition const &stackPosition_;
    explicit CallReplacer(StackPosition const &input, wasm::Function *func) : stackPosition_(input), func(func) {}
    void visitCall(wasm::Call *expr) {
      if (expr->target != FnLocalToStack && expr->target != FnTmpToStack)
        return;

      auto it = stackPosition_.find(expr);
      if (it == stackPosition_.end()) {
        // no need to tostack
        assert(expr->operands.size() == 1);
        replaceCurrent(expr->operands.front());
      } else {
        uint32_t const offset = it->second;
        wasm::Builder builder{*getModule()};
        expr->target = getToStackFunctionName(offset);
      }
    }
  };
  CallReplacer callReplacer{stackPosition, func};
  callReplacer.walkFunctionInModule(func, m);
}

} // namespace warpo::passes::gc
