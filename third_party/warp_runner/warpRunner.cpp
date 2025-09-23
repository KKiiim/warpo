#include "warpRunner.hpp"

#include "src/utils/StackTop.hpp"

WarpRunner::WarpRunner(void *const ctx)
    : logger(), stackTop(static_cast<uint8_t const *>(vb::getStackTop())), m{logger} {
  m.setStacktraceRecordCount(32U);
  m.setContext(ctx);
}
