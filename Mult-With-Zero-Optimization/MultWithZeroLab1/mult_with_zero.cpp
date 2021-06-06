#include "llvm/Pass.h"
#include "llvm/IR/Function.h"
#include "llvm/IR/InstIterator.h"
#include "llvm/Support/raw_ostream.h"
#include "llvm/IR/Constants.h"
#include "llvm/IR/LegacyPassManager.h"
#include "llvm/Transforms/IPO/PassManagerBuilder.h"

using namespace llvm;

namespace {

    struct MultWithZero: public FunctionPass {
        static char ID;
        MultWithZero(): FunctionPass(ID) {}

        bool runOnFunction(Function& function) override {
            errs() << "MULT WITH ZERO pass, funct: " << function.getName() << "\n";
            bool changed = false;
            for (auto ii = inst_begin(function), ie = inst_end(function); ii!=ie;){
                auto instruction = &*ii;
                ++ii;

                if (isTrivialMult(instruction)){
                    if(!instruction->use_empty()) {
                        replaceWithArgument(instruction);
                    }    
                    instruction->eraseFromParent();
                    changed = true;
                }
            }
            
            return changed;
        }

    private:

        // check: mult and one operand is zero
        bool isTrivialMult(Instruction const* instruction) const {
            return isBinaryMult(instruction) && isTrivial(instruction);
        }

        // check: operation is mult
        bool isBinaryMult(Instruction const* instruction) const {
            return instruction->getOpcode() == Instruction::Mul && instruction->getNumOperands() == 2;
        }

        // check: at least one opreand is zero
        bool isTrivial(Instruction const* instruction) const {
            auto const& operands = instruction->operands();
            return std::any_of(operands.begin(), operands.end(), [this](auto const& operand){return isZero(operand);});
        }

        // check: operand is zero
        bool isZero(Value const* operand) const {
            auto const constant = dyn_cast<ConstantInt>(operand);
            return constant && constant->isZero();
        }

        // what do we do when multiplying with zero
        void replaceWithArgument(Instruction* instruction) const {
            auto const& lhs = instruction->getOperand(0);
            auto const& rhs = instruction->getOperand(1);
            auto const& zero = isZero(lhs) ? lhs : rhs;
            instruction->replaceAllUsesWith(zero);
        }

    };
}

char MultWithZero::ID = 0;

static RegisterPass<MultWithZero> X(
    "multwithzero",
    "MultWithZero Peephole Optimization Pass",
    false,
    false
);

static RegisterStandardPasses Y(
    PassManagerBuilder::EP_EarlyAsPossible,
    [](const PassManagerBuilder& builder, legacy::PassManagerBase& manager){ manager.add(new MultWithZero());}
);

