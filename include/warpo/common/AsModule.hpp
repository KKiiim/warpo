// Copyright (C) 2025 Bayerische Motoren Werke Aktiengesellschaft (BMW AG)
//
// SPDX-License-Identifier: Apache-2.0
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
//     http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.

#pragma once

#include <binaryen/src/binaryen-c.h>
#include <cstddef>
#include <utility>

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

class AsModule {
  BinaryenModule raw_;
  // TODO: more information fields

public:
  AsModule() = default;
  explicit AsModule(BinaryenModule raw) : raw_(std::move(raw)) {}
  BinaryenModuleRef get() const { return raw_.get(); }
  bool valid() const { return raw_ != nullptr; }
  bool invalid() const { return !valid(); }
};

} // namespace warpo
