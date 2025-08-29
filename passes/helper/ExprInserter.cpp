#include <memory>

#include "ExprInserter.hpp"
#include "ToString.hpp"
#include "fmt/base.h"
#include "wasm-builder.h"
#include "wasm-type.h"
#include "wasm.h"

#define PASS_NAME "EXPR_INSERTER"

namespace warpo::passes {

static bool isTerminator(wasm::Expression *expr) {
  if (expr->is<wasm::Return>() || expr->is<wasm::Unreachable>() || expr->is<wasm::Break>())
    return true;
  return false;
}

bool ExprInserter::canInsertBefore(wasm::Expression *insertPosition) {
  // those instruction does not have children, so we can insert before them directly.
  if (insertPosition->is<wasm::GlobalGet>() || insertPosition->is<wasm::LocalGet>() ||
      insertPosition->is<wasm::Const>())
    return true;
  // those instruction should be inserted after the last operand
  if (insertPosition->is<wasm::Call>()) {
    wasm::Call *const call = insertPosition->cast<wasm::Call>();
    if (call->operands.empty())
      return true;
    if (canInsertAfter(call->operands.back()))
      return true;
  }
  fmt::println("[" PASS_NAME "] fn '{}', failed to insert before {}", func_->name.str, toString(insertPosition));
  return false;
}

void ExprInserter::insertBefore(wasm::Builder &b, wasm::Expression *insertedExpr,
                                wasm::Expression **insertPositionPtr) {
  assert(insertedExpr->type == wasm::Type::none);
  wasm::Expression *const insertPosition = *insertPositionPtr;
  switch (insertPosition->_id) {
  case wasm::Expression::GlobalGetId:
  case wasm::Expression::LocalGetId:
  case wasm::Expression::ConstId:
    *insertPositionPtr = b.makeBlock({insertedExpr, insertPosition}, insertPosition->type);
    break;
  case wasm::Expression::CallId: {
    wasm::Call *const call = insertPosition->cast<wasm::Call>();
    if (call->operands.empty()) {
      *insertPositionPtr = b.makeBlock({insertedExpr, insertPosition}, insertPosition->type);
    } else {
      insertAfter(b, insertedExpr, &call->operands.back());
    }
    break;
  }
  default:
    __builtin_unreachable();
  }
}

bool ExprInserter::canInsertAfter(wasm::Expression *insertPosition) {
  if (insertPosition->type == wasm::Type::none && !isTerminator(insertPosition))
    return true;
  if (insertPosition->is<wasm::Return>())
    return true;
  if (insertPosition->is<wasm::If>())
    return true;
  fmt::println("[" PASS_NAME "] fn '{}', failed to insert after {}", func_->name.str, toString(insertPosition));
  return false;
}
void ExprInserter::insertAfter(wasm::Builder &b, wasm::Expression *insertedExpr, wasm::Expression **insertPositionPtr) {
  assert(insertedExpr->type == wasm::Type::none);
  wasm::Expression *const insertPosition = *insertPositionPtr;
  if (insertPosition->type == wasm::Type::none) {
    *insertPositionPtr = b.makeBlock({insertPosition, insertedExpr}, wasm::Type::none);
    return;
  }
  if (auto *const returnExpr = insertPosition->dynCast<wasm::Return>()) {
    if (returnExpr->value == nullptr) {
      *insertPositionPtr = b.makeBlock({insertedExpr, insertPosition}, wasm::Type::none);
    } else {
      wasm::Type const localType = returnExpr->value->type;
      wasm::Index const tmpLocal = b.addVar(func_, localType);
      returnExpr->value = b.makeBlock(
          {b.makeLocalSet(tmpLocal, returnExpr->value), insertedExpr, b.makeLocalGet(tmpLocal, localType)}, localType);
    }
    return;
  }
  if (auto *const ifExpr = insertPosition->dynCast<wasm::If>()) {
    wasm::Type const type = ifExpr->type;
    assert(type != wasm::Type::none);
    if (ifExpr->type == wasm::Type::unreachable) {
      *insertPositionPtr = b.makeBlock({insertPosition, insertedExpr}, wasm::Type::none);
    } else {
      wasm::Index index = wasm::Builder::addVar(func_, type);
      *insertPositionPtr = b.makeBlock(
          {
              b.makeLocalSet(index, ifExpr),
              insertedExpr,
              b.makeLocalGet(index, type),
          },
          type);
    }
    return;
  }
  __builtin_unreachable();
}

} // namespace warpo::passes

#ifdef WARPO_ENABLE_UNIT_TESTS

#include <gtest/gtest.h>

#include "FindExpr.hpp"

namespace warpo::passes::ut {

using wasm::Const, wasm::Block, wasm::Nop, wasm::Call, wasm::LocalGet, wasm::LocalSet, wasm::If, wasm::Return;
using wasm::Type;

TEST(ExprInserter, InsertBeforeNoOperand) {
  wasm::Module m{};
  wasm::Builder b{m};
  wasm::Expression *const insertPos = b.makeConst(1);
  std::unique_ptr<wasm::Function> f = wasm::Builder::makeFunction("test", wasm::Signature(), {}, insertPos);
  ExprInserter inserter{f.get()};

  ASSERT_TRUE(inserter.canInsertBefore(insertPos));
  inserter.insertBefore(b, b.makeNop(), findExprPointer(insertPos, f.get()));

  ASSERT_TRUE(f->body->is<Block>());
  ASSERT_TRUE(f->body->cast<Block>()->list[0]->is<Nop>());
  ASSERT_TRUE(f->body->cast<Block>()->list[1]->is<Const>());
}

TEST(ExprInserter, InsertBeforeCallWithoutOperands) {
  wasm::Module m{};
  wasm::Builder b{m};
  wasm::Expression *const insertPos = b.makeCall("call_tmp", {}, Type::none);
  std::unique_ptr<wasm::Function> f = wasm::Builder::makeFunction("test", wasm::Signature(), {}, insertPos);
  ExprInserter inserter{f.get()};

  ASSERT_TRUE(inserter.canInsertBefore(insertPos));
  inserter.insertBefore(b, b.makeNop(), findExprPointer(insertPos, f.get()));

  ASSERT_TRUE(f->body->is<Block>());
  ASSERT_TRUE(f->body->cast<Block>()->list[0]->is<Nop>());
  ASSERT_TRUE(f->body->cast<Block>()->list[1]->is<Call>());
}

TEST(ExprInserter, InsertBeforeCallWithOperands) {
  wasm::Module m{};
  wasm::Builder b{m};
  wasm::Expression *const insertPos = b.makeCall("call_tmp",
                                                 {
                                                     b.makeLocalGet(0, Type::i32),
                                                     b.makeIf(b.makeConst(0), b.makeConst(0), b.makeConst(0)),
                                                 },
                                                 Type::none);
  std::unique_ptr<wasm::Function> f = wasm::Builder::makeFunction("test", wasm::Signature(), {}, insertPos);
  ExprInserter inserter{f.get()};

  ASSERT_TRUE(inserter.canInsertBefore(insertPos));
  inserter.insertBefore(b, b.makeNop(), findExprPointer(insertPos, f.get()));

  ASSERT_EQ(f->body, insertPos);
  ASSERT_TRUE(insertPos->cast<Call>()->operands[0]->is<LocalGet>());
  ASSERT_TRUE(insertPos->cast<Call>()->operands[1]->is<Block>());
  ASSERT_TRUE(insertPos->cast<Call>()->operands[1]->cast<Block>()->list[0]->is<LocalSet>());
  ASSERT_TRUE(insertPos->cast<Call>()->operands[1]->cast<Block>()->list[0]->cast<LocalSet>()->value->is<If>());
  ASSERT_TRUE(insertPos->cast<Call>()->operands[1]->cast<Block>()->list[1]->is<Nop>());
  ASSERT_TRUE(insertPos->cast<Call>()->operands[1]->cast<Block>()->list[2]->is<LocalGet>());
}

TEST(ExprInserter, InsertAfterTypeNone) {
  wasm::Module m{};
  wasm::Builder b{m};
  wasm::Expression *const insertPos = b.makeCall("empty", {}, Type::none);
  std::unique_ptr<wasm::Function> f = wasm::Builder::makeFunction("test", wasm::Signature(), {}, insertPos);
  ExprInserter inserter{f.get()};

  ASSERT_TRUE(inserter.canInsertAfter(insertPos));
  inserter.insertAfter(b, b.makeNop(), findExprPointer(insertPos, f.get()));

  ASSERT_TRUE(f->body->is<Block>());
  ASSERT_TRUE(f->body->cast<Block>()->list[0]->is<Call>());
  ASSERT_TRUE(f->body->cast<Block>()->list[1]->is<Nop>());
}

TEST(ExprInserter, InsertAfterReturnWithoutValue) {
  wasm::Module m{};
  wasm::Builder b{m};
  wasm::Expression *const insertPos = b.makeReturn();
  std::unique_ptr<wasm::Function> f = wasm::Builder::makeFunction("test", wasm::Signature(), {}, insertPos);
  ExprInserter inserter{f.get()};

  ASSERT_TRUE(inserter.canInsertAfter(insertPos));
  inserter.insertAfter(b, b.makeNop(), findExprPointer(insertPos, f.get()));

  ASSERT_TRUE(f->body->is<Block>());
  ASSERT_TRUE(f->body->cast<Block>()->list[0]->is<Nop>());
  ASSERT_TRUE(f->body->cast<Block>()->list[1]->is<Return>());
}

TEST(ExprInserter, InsertAfterReturnWithValue) {
  wasm::Module m{};
  wasm::Builder b{m};
  wasm::Expression *const insertPos = b.makeReturn(b.makeConst(1));
  std::unique_ptr<wasm::Function> f = wasm::Builder::makeFunction("test", wasm::Signature(), {}, insertPos);
  ExprInserter inserter{f.get()};

  ASSERT_TRUE(inserter.canInsertAfter(insertPos));
  inserter.insertAfter(b, b.makeNop(), findExprPointer(insertPos, f.get()));

  ASSERT_EQ(f->body, insertPos);
  ASSERT_TRUE(f->body->cast<Return>()->value->is<Block>());
  ASSERT_TRUE(f->body->cast<Return>()->value->cast<Block>()->list[0]->is<LocalSet>());
  ASSERT_TRUE(f->body->cast<Return>()->value->cast<Block>()->list[0]->cast<LocalSet>()->value->is<Const>());
  ASSERT_TRUE(f->body->cast<Return>()->value->cast<Block>()->list[1]->is<Nop>());
  ASSERT_TRUE(f->body->cast<Return>()->value->cast<Block>()->list[2]->is<LocalGet>());
}

} // namespace warpo::passes::ut

#endif
