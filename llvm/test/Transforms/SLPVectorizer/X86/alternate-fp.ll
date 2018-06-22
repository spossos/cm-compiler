; NOTE: Assertions have been autogenerated by utils/update_test_checks.py
; RUN: opt < %s -mtriple=x86_64-unknown -basicaa -slp-vectorizer -instcombine -S | FileCheck %s --check-prefix=CHECK --check-prefix=SSE
; RUN: opt < %s -mtriple=x86_64-unknown -mcpu=slm -basicaa -slp-vectorizer -instcombine -S | FileCheck %s --check-prefix=CHECK --check-prefix=SLM
; RUN: opt < %s -mtriple=x86_64-unknown -mcpu=corei7-avx -basicaa -slp-vectorizer -instcombine -S | FileCheck %s --check-prefix=CHECK --check-prefix=AVX --check-prefix=AVX1
; RUN: opt < %s -mtriple=x86_64-unknown -mcpu=core-avx2 -basicaa -slp-vectorizer -instcombine -S | FileCheck %s --check-prefix=CHECK --check-prefix=AVX --check-prefix=AVX2
; RUN: opt < %s -mtriple=x86_64-unknown -mcpu=knl -basicaa -slp-vectorizer -instcombine -S | FileCheck %s --check-prefix=CHECK --check-prefix=AVX512 --check-prefix=AVX512F
; RUN: opt < %s -mtriple=x86_64-unknown -mcpu=skx -basicaa -slp-vectorizer -instcombine -S | FileCheck %s --check-prefix=CHECK --check-prefix=AVX512 --check-prefix=AVX512BW

define <8 x float> @fadd_fsub_v8f32(<8 x float> %a, <8 x float> %b) {
; CHECK-LABEL: @fadd_fsub_v8f32(
; CHECK-NEXT:    [[A0:%.*]] = extractelement <8 x float> [[A:%.*]], i32 0
; CHECK-NEXT:    [[A1:%.*]] = extractelement <8 x float> [[A]], i32 1
; CHECK-NEXT:    [[A2:%.*]] = extractelement <8 x float> [[A]], i32 2
; CHECK-NEXT:    [[A3:%.*]] = extractelement <8 x float> [[A]], i32 3
; CHECK-NEXT:    [[A4:%.*]] = extractelement <8 x float> [[A]], i32 4
; CHECK-NEXT:    [[A5:%.*]] = extractelement <8 x float> [[A]], i32 5
; CHECK-NEXT:    [[A6:%.*]] = extractelement <8 x float> [[A]], i32 6
; CHECK-NEXT:    [[A7:%.*]] = extractelement <8 x float> [[A]], i32 7
; CHECK-NEXT:    [[B0:%.*]] = extractelement <8 x float> [[B:%.*]], i32 0
; CHECK-NEXT:    [[B1:%.*]] = extractelement <8 x float> [[B]], i32 1
; CHECK-NEXT:    [[B2:%.*]] = extractelement <8 x float> [[B]], i32 2
; CHECK-NEXT:    [[B3:%.*]] = extractelement <8 x float> [[B]], i32 3
; CHECK-NEXT:    [[B4:%.*]] = extractelement <8 x float> [[B]], i32 4
; CHECK-NEXT:    [[B5:%.*]] = extractelement <8 x float> [[B]], i32 5
; CHECK-NEXT:    [[B6:%.*]] = extractelement <8 x float> [[B]], i32 6
; CHECK-NEXT:    [[B7:%.*]] = extractelement <8 x float> [[B]], i32 7
; CHECK-NEXT:    [[AB0:%.*]] = fadd float [[A0]], [[B0]]
; CHECK-NEXT:    [[AB1:%.*]] = fsub float [[A1]], [[B1]]
; CHECK-NEXT:    [[AB2:%.*]] = fsub float [[A2]], [[B2]]
; CHECK-NEXT:    [[AB3:%.*]] = fadd float [[A3]], [[B3]]
; CHECK-NEXT:    [[AB4:%.*]] = fadd float [[A4]], [[B4]]
; CHECK-NEXT:    [[AB5:%.*]] = fsub float [[A5]], [[B5]]
; CHECK-NEXT:    [[AB6:%.*]] = fsub float [[A6]], [[B6]]
; CHECK-NEXT:    [[AB7:%.*]] = fadd float [[A7]], [[B7]]
; CHECK-NEXT:    [[R0:%.*]] = insertelement <8 x float> undef, float [[AB0]], i32 0
; CHECK-NEXT:    [[R1:%.*]] = insertelement <8 x float> [[R0]], float [[AB1]], i32 1
; CHECK-NEXT:    [[R2:%.*]] = insertelement <8 x float> [[R1]], float [[AB2]], i32 2
; CHECK-NEXT:    [[R3:%.*]] = insertelement <8 x float> [[R2]], float [[AB3]], i32 3
; CHECK-NEXT:    [[R4:%.*]] = insertelement <8 x float> [[R3]], float [[AB4]], i32 4
; CHECK-NEXT:    [[R5:%.*]] = insertelement <8 x float> [[R4]], float [[AB5]], i32 5
; CHECK-NEXT:    [[R6:%.*]] = insertelement <8 x float> [[R5]], float [[AB6]], i32 6
; CHECK-NEXT:    [[R7:%.*]] = insertelement <8 x float> [[R6]], float [[AB7]], i32 7
; CHECK-NEXT:    ret <8 x float> [[R7]]
;
  %a0 = extractelement <8 x float> %a, i32 0
  %a1 = extractelement <8 x float> %a, i32 1
  %a2 = extractelement <8 x float> %a, i32 2
  %a3 = extractelement <8 x float> %a, i32 3
  %a4 = extractelement <8 x float> %a, i32 4
  %a5 = extractelement <8 x float> %a, i32 5
  %a6 = extractelement <8 x float> %a, i32 6
  %a7 = extractelement <8 x float> %a, i32 7
  %b0 = extractelement <8 x float> %b, i32 0
  %b1 = extractelement <8 x float> %b, i32 1
  %b2 = extractelement <8 x float> %b, i32 2
  %b3 = extractelement <8 x float> %b, i32 3
  %b4 = extractelement <8 x float> %b, i32 4
  %b5 = extractelement <8 x float> %b, i32 5
  %b6 = extractelement <8 x float> %b, i32 6
  %b7 = extractelement <8 x float> %b, i32 7
  %ab0 = fadd float %a0, %b0
  %ab1 = fsub float %a1, %b1
  %ab2 = fsub float %a2, %b2
  %ab3 = fadd float %a3, %b3
  %ab4 = fadd float %a4, %b4
  %ab5 = fsub float %a5, %b5
  %ab6 = fsub float %a6, %b6
  %ab7 = fadd float %a7, %b7
  %r0 = insertelement <8 x float> undef, float %ab0, i32 0
  %r1 = insertelement <8 x float>   %r0, float %ab1, i32 1
  %r2 = insertelement <8 x float>   %r1, float %ab2, i32 2
  %r3 = insertelement <8 x float>   %r2, float %ab3, i32 3
  %r4 = insertelement <8 x float>   %r3, float %ab4, i32 4
  %r5 = insertelement <8 x float>   %r4, float %ab5, i32 5
  %r6 = insertelement <8 x float>   %r5, float %ab6, i32 6
  %r7 = insertelement <8 x float>   %r6, float %ab7, i32 7
  ret <8 x float> %r7
}

define <8 x float> @fmul_fdiv_v8f32(<8 x float> %a, <8 x float> %b) {
; CHECK-LABEL: @fmul_fdiv_v8f32(
; CHECK-NEXT:    [[A0:%.*]] = extractelement <8 x float> [[A:%.*]], i32 0
; CHECK-NEXT:    [[A1:%.*]] = extractelement <8 x float> [[A]], i32 1
; CHECK-NEXT:    [[A2:%.*]] = extractelement <8 x float> [[A]], i32 2
; CHECK-NEXT:    [[A3:%.*]] = extractelement <8 x float> [[A]], i32 3
; CHECK-NEXT:    [[A4:%.*]] = extractelement <8 x float> [[A]], i32 4
; CHECK-NEXT:    [[A5:%.*]] = extractelement <8 x float> [[A]], i32 5
; CHECK-NEXT:    [[A6:%.*]] = extractelement <8 x float> [[A]], i32 6
; CHECK-NEXT:    [[A7:%.*]] = extractelement <8 x float> [[A]], i32 7
; CHECK-NEXT:    [[B0:%.*]] = extractelement <8 x float> [[B:%.*]], i32 0
; CHECK-NEXT:    [[B1:%.*]] = extractelement <8 x float> [[B]], i32 1
; CHECK-NEXT:    [[B2:%.*]] = extractelement <8 x float> [[B]], i32 2
; CHECK-NEXT:    [[B3:%.*]] = extractelement <8 x float> [[B]], i32 3
; CHECK-NEXT:    [[B4:%.*]] = extractelement <8 x float> [[B]], i32 4
; CHECK-NEXT:    [[B5:%.*]] = extractelement <8 x float> [[B]], i32 5
; CHECK-NEXT:    [[B6:%.*]] = extractelement <8 x float> [[B]], i32 6
; CHECK-NEXT:    [[B7:%.*]] = extractelement <8 x float> [[B]], i32 7
; CHECK-NEXT:    [[AB0:%.*]] = fmul float [[A0]], [[B0]]
; CHECK-NEXT:    [[AB1:%.*]] = fdiv float [[A1]], [[B1]]
; CHECK-NEXT:    [[AB2:%.*]] = fdiv float [[A2]], [[B2]]
; CHECK-NEXT:    [[AB3:%.*]] = fmul float [[A3]], [[B3]]
; CHECK-NEXT:    [[AB4:%.*]] = fmul float [[A4]], [[B4]]
; CHECK-NEXT:    [[AB5:%.*]] = fdiv float [[A5]], [[B5]]
; CHECK-NEXT:    [[AB6:%.*]] = fdiv float [[A6]], [[B6]]
; CHECK-NEXT:    [[AB7:%.*]] = fmul float [[A7]], [[B7]]
; CHECK-NEXT:    [[R0:%.*]] = insertelement <8 x float> undef, float [[AB0]], i32 0
; CHECK-NEXT:    [[R1:%.*]] = insertelement <8 x float> [[R0]], float [[AB1]], i32 1
; CHECK-NEXT:    [[R2:%.*]] = insertelement <8 x float> [[R1]], float [[AB2]], i32 2
; CHECK-NEXT:    [[R3:%.*]] = insertelement <8 x float> [[R2]], float [[AB3]], i32 3
; CHECK-NEXT:    [[R4:%.*]] = insertelement <8 x float> [[R3]], float [[AB4]], i32 4
; CHECK-NEXT:    [[R5:%.*]] = insertelement <8 x float> [[R4]], float [[AB5]], i32 5
; CHECK-NEXT:    [[R6:%.*]] = insertelement <8 x float> [[R5]], float [[AB6]], i32 6
; CHECK-NEXT:    [[R7:%.*]] = insertelement <8 x float> [[R6]], float [[AB7]], i32 7
; CHECK-NEXT:    ret <8 x float> [[R7]]
;
  %a0 = extractelement <8 x float> %a, i32 0
  %a1 = extractelement <8 x float> %a, i32 1
  %a2 = extractelement <8 x float> %a, i32 2
  %a3 = extractelement <8 x float> %a, i32 3
  %a4 = extractelement <8 x float> %a, i32 4
  %a5 = extractelement <8 x float> %a, i32 5
  %a6 = extractelement <8 x float> %a, i32 6
  %a7 = extractelement <8 x float> %a, i32 7
  %b0 = extractelement <8 x float> %b, i32 0
  %b1 = extractelement <8 x float> %b, i32 1
  %b2 = extractelement <8 x float> %b, i32 2
  %b3 = extractelement <8 x float> %b, i32 3
  %b4 = extractelement <8 x float> %b, i32 4
  %b5 = extractelement <8 x float> %b, i32 5
  %b6 = extractelement <8 x float> %b, i32 6
  %b7 = extractelement <8 x float> %b, i32 7
  %ab0 = fmul float %a0, %b0
  %ab1 = fdiv float %a1, %b1
  %ab2 = fdiv float %a2, %b2
  %ab3 = fmul float %a3, %b3
  %ab4 = fmul float %a4, %b4
  %ab5 = fdiv float %a5, %b5
  %ab6 = fdiv float %a6, %b6
  %ab7 = fmul float %a7, %b7
  %r0 = insertelement <8 x float> undef, float %ab0, i32 0
  %r1 = insertelement <8 x float>   %r0, float %ab1, i32 1
  %r2 = insertelement <8 x float>   %r1, float %ab2, i32 2
  %r3 = insertelement <8 x float>   %r2, float %ab3, i32 3
  %r4 = insertelement <8 x float>   %r3, float %ab4, i32 4
  %r5 = insertelement <8 x float>   %r4, float %ab5, i32 5
  %r6 = insertelement <8 x float>   %r5, float %ab6, i32 6
  %r7 = insertelement <8 x float>   %r6, float %ab7, i32 7
  ret <8 x float> %r7
}

define <4 x float> @fmul_fdiv_v4f32_const(<4 x float> %a) {
; SSE-LABEL: @fmul_fdiv_v4f32_const(
; SSE-NEXT:    [[A2:%.*]] = extractelement <4 x float> [[A:%.*]], i32 2
; SSE-NEXT:    [[A3:%.*]] = extractelement <4 x float> [[A]], i32 3
; SSE-NEXT:    [[TMP1:%.*]] = shufflevector <4 x float> [[A]], <4 x float> undef, <2 x i32> <i32 0, i32 1>
; SSE-NEXT:    [[TMP2:%.*]] = fmul <2 x float> [[TMP1]], <float 2.000000e+00, float 1.000000e+00>
; SSE-NEXT:    [[AB3:%.*]] = fmul float [[A3]], 2.000000e+00
; SSE-NEXT:    [[TMP3:%.*]] = extractelement <2 x float> [[TMP2]], i32 0
; SSE-NEXT:    [[R0:%.*]] = insertelement <4 x float> undef, float [[TMP3]], i32 0
; SSE-NEXT:    [[TMP4:%.*]] = extractelement <2 x float> [[TMP2]], i32 1
; SSE-NEXT:    [[R1:%.*]] = insertelement <4 x float> [[R0]], float [[TMP4]], i32 1
; SSE-NEXT:    [[R2:%.*]] = insertelement <4 x float> [[R1]], float [[A2]], i32 2
; SSE-NEXT:    [[R3:%.*]] = insertelement <4 x float> [[R2]], float [[AB3]], i32 3
; SSE-NEXT:    ret <4 x float> [[R3]]
;
; SLM-LABEL: @fmul_fdiv_v4f32_const(
; SLM-NEXT:    [[A0:%.*]] = extractelement <4 x float> [[A:%.*]], i32 0
; SLM-NEXT:    [[A1:%.*]] = extractelement <4 x float> [[A]], i32 1
; SLM-NEXT:    [[A2:%.*]] = extractelement <4 x float> [[A]], i32 2
; SLM-NEXT:    [[A3:%.*]] = extractelement <4 x float> [[A]], i32 3
; SLM-NEXT:    [[AB0:%.*]] = fmul float [[A0]], 2.000000e+00
; SLM-NEXT:    [[AB3:%.*]] = fmul float [[A3]], 2.000000e+00
; SLM-NEXT:    [[R0:%.*]] = insertelement <4 x float> undef, float [[AB0]], i32 0
; SLM-NEXT:    [[R1:%.*]] = insertelement <4 x float> [[R0]], float [[A1]], i32 1
; SLM-NEXT:    [[R2:%.*]] = insertelement <4 x float> [[R1]], float [[A2]], i32 2
; SLM-NEXT:    [[R3:%.*]] = insertelement <4 x float> [[R2]], float [[AB3]], i32 3
; SLM-NEXT:    ret <4 x float> [[R3]]
;
; AVX-LABEL: @fmul_fdiv_v4f32_const(
; AVX-NEXT:    [[A2:%.*]] = extractelement <4 x float> [[A:%.*]], i32 2
; AVX-NEXT:    [[A3:%.*]] = extractelement <4 x float> [[A]], i32 3
; AVX-NEXT:    [[TMP1:%.*]] = shufflevector <4 x float> [[A]], <4 x float> undef, <2 x i32> <i32 0, i32 1>
; AVX-NEXT:    [[TMP2:%.*]] = fmul <2 x float> [[TMP1]], <float 2.000000e+00, float 1.000000e+00>
; AVX-NEXT:    [[AB3:%.*]] = fmul float [[A3]], 2.000000e+00
; AVX-NEXT:    [[TMP3:%.*]] = extractelement <2 x float> [[TMP2]], i32 0
; AVX-NEXT:    [[R0:%.*]] = insertelement <4 x float> undef, float [[TMP3]], i32 0
; AVX-NEXT:    [[TMP4:%.*]] = extractelement <2 x float> [[TMP2]], i32 1
; AVX-NEXT:    [[R1:%.*]] = insertelement <4 x float> [[R0]], float [[TMP4]], i32 1
; AVX-NEXT:    [[R2:%.*]] = insertelement <4 x float> [[R1]], float [[A2]], i32 2
; AVX-NEXT:    [[R3:%.*]] = insertelement <4 x float> [[R2]], float [[AB3]], i32 3
; AVX-NEXT:    ret <4 x float> [[R3]]
;
; AVX512-LABEL: @fmul_fdiv_v4f32_const(
; AVX512-NEXT:    [[A2:%.*]] = extractelement <4 x float> [[A:%.*]], i32 2
; AVX512-NEXT:    [[A3:%.*]] = extractelement <4 x float> [[A]], i32 3
; AVX512-NEXT:    [[TMP1:%.*]] = shufflevector <4 x float> [[A]], <4 x float> undef, <2 x i32> <i32 0, i32 1>
; AVX512-NEXT:    [[TMP2:%.*]] = fmul <2 x float> [[TMP1]], <float 2.000000e+00, float 1.000000e+00>
; AVX512-NEXT:    [[AB3:%.*]] = fmul float [[A3]], 2.000000e+00
; AVX512-NEXT:    [[TMP3:%.*]] = extractelement <2 x float> [[TMP2]], i32 0
; AVX512-NEXT:    [[R0:%.*]] = insertelement <4 x float> undef, float [[TMP3]], i32 0
; AVX512-NEXT:    [[TMP4:%.*]] = extractelement <2 x float> [[TMP2]], i32 1
; AVX512-NEXT:    [[R1:%.*]] = insertelement <4 x float> [[R0]], float [[TMP4]], i32 1
; AVX512-NEXT:    [[R2:%.*]] = insertelement <4 x float> [[R1]], float [[A2]], i32 2
; AVX512-NEXT:    [[R3:%.*]] = insertelement <4 x float> [[R2]], float [[AB3]], i32 3
; AVX512-NEXT:    ret <4 x float> [[R3]]
;
  %a0 = extractelement <4 x float> %a, i32 0
  %a1 = extractelement <4 x float> %a, i32 1
  %a2 = extractelement <4 x float> %a, i32 2
  %a3 = extractelement <4 x float> %a, i32 3
  %ab0 = fmul float %a0, 2.0
  %ab1 = fmul float %a1, 1.0
  %ab2 = fdiv float %a2, 1.0
  %ab3 = fdiv float %a3, 0.5
  %r0 = insertelement <4 x float> undef, float %ab0, i32 0
  %r1 = insertelement <4 x float>   %r0, float %ab1, i32 1
  %r2 = insertelement <4 x float>   %r1, float %ab2, i32 2
  %r3 = insertelement <4 x float>   %r2, float %ab3, i32 3
  ret <4 x float> %r3
}