//===--- GenX.cpp - GenX Helpers for Tools ----------------------*- C++ -*-===//
//
//                     The LLVM Compiler Infrastructure
//
// This file is distributed under the University of Illinois Open Source
// License. See LICENSE.TXT for details.
//
//===----------------------------------------------------------------------===//

#include "GenX.h"
#include "clang/Driver/DriverDiagnostic.h"
#include "clang/Driver/Options.h"
#include "llvm/ADT/StringSwitch.h"
#include "llvm/Option/ArgList.h"

using namespace clang::driver;
using namespace clang::driver::tools;
using namespace clang;
using namespace llvm::opt;

static const char *getCanonicalGenXTargetCPU(const std::string &CPU) {
    // As side-effect of the way we accept the CM command line options for
    // backwards compatiblity, the CPU string may be prefixed by '=' or ':'.
    // If so, remove the prefix character.
    size_t CPUNameStart = CPU.find_first_not_of("=:");
    if (CPUNameStart == std::string::npos)
        CPUNameStart = 0;
    std::string CPUName = CPU.substr(CPUNameStart);
    std::transform(CPUName.begin(), CPUName.end(), CPUName.begin(), ::toupper);

    // Ensure the CPU name is in canonical form
    const char *CanonicalCPU = llvm::StringSwitch<const char *>(CPUName)
        .Cases("GEN7_5", "HSW", "HSW")
        .Cases("GEN8", "BDW", "BDW")
        .Cases("GEN8LP", "GEN8_5", "CHV", "CHV")
        .Cases("GEN9", "SKL", "SKL")
        .Cases("GEN9LP", "BXT", "BXT")
        .Cases("GEN9_5", "GEN9P5", "KBL", "KBL")
        .Cases("GEN9_5LP", "GEN9P5LP", "GLK", "GLK")
        .Cases("GEN11", "ICL", "ICL")
        .Cases("GEN11LP", "ICLLP", "ICLLP")
        .Cases("GEN12LP", "TGLLP", "TGLLP")
        .Default("");

    return CanonicalCPU;
}


const char *GenX::getGenXTargetCPU(const ArgList &Args) {
    // GenX target CPU may be specified using one of /Qxcm_jit_target=xxx,
    // -mcpu=xxx, or -march=xxx.
    if (const Arg *A = Args.getLastArg(options::OPT_Qxcm_jit_target)) {
        const char *Jit_CPU = getCanonicalGenXTargetCPU(A->getValue());
        if (strlen(Jit_CPU))
            return Jit_CPU;
    }
    if (const Arg *A = Args.getLastArg(options::OPT_mcpu_EQ)) {
        const char *Mcpu_CPU = getCanonicalGenXTargetCPU(A->getValue());
        if (strlen(Mcpu_CPU))
            return Mcpu_CPU;
    }
    if (const Arg *A = Args.getLastArg(options::OPT_march_EQ)) {
        const char *March_CPU = getCanonicalGenXTargetCPU(A->getValue());
        if (strlen(March_CPU))
            return March_CPU;
    }

    // no GenX target CPU specified
    return "";
}

void GenX::getGenXTargetFeatures(const Driver &D, const llvm::Triple &Triple,
                                 const ArgList &Args,
                                 std::vector<StringRef> &Features) {
  if (Args.getLastArg(options::OPT_mdump_regalloc))
    Features.push_back("+dump_regalloc");
  if (Args.getLastArg(options::OPT_mCM_disable_jmpi))
    Features.push_back("+disable_jmpi");
  if (Args.getLastArg(options::OPT_mCM_warn_callable))
    Features.push_back("+warn_callable");
  if (Args.getLastArg(options::OPT_mCM_no_vector_decomposition))
    Features.push_back("+disable_vec_decomp");
  if (Args.getLastArg(options::OPT_mCM_translate_legacy))
    Features.push_back("+translate_legacy_message");
  if (Args.getLastArg(options::OPT_femulate_i64))
    Features.push_back("+emulate_i64");

  if (Args.getLastArg(options::OPT_fcmocl))
    Features.push_back("+ocl_runtime");

}
