#pragma once

#include <binaryen/src/binaryen-c.h>
#include <cstddef>

namespace warpo {

class BinaryenModule {
  BinaryenModuleRef ref_;

public:
  BinaryenModule(BinaryenModule const &) = delete;
  BinaryenModule(BinaryenModule &&o) noexcept : ref_(o.ref_) {
    if (&o != this)
      o.ref_ = nullptr;
  }
  BinaryenModule &operator=(BinaryenModule const &) = delete;
  BinaryenModule &operator=(BinaryenModule &&o) noexcept {
    BinaryenModuleRef tmp = ref_;
    ref_ = o.ref_;
    o.ref_ = ref_;
    return *this;
  }

  BinaryenModule() noexcept : BinaryenModule(nullptr) {}
  BinaryenModule(BinaryenModuleRef ref) noexcept : ref_(ref) {}
  ~BinaryenModule() noexcept {
    if (ref_)
      BinaryenModuleDispose(ref_);
  }

  BinaryenModuleRef get() const noexcept { return static_cast<BinaryenModuleRef>(ref_); }

  bool operator==(std::nullptr_t) const { return ref_ == nullptr; }
};

} // namespace warpo
