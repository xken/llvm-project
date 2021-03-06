; RUN: llc -mtriple=aarch64-none-linux-gnu -mattr=+sve < %s | FileCheck %s

; This file checks that unpredicated load/store instructions to locals
; use the right instructions and offsets.

; Data fills

define void @fill_nxv16i8() {
; CHECK-LABEL: fill_nxv16i8
; CHECK-DAG: ld1b    { z{{[01]}}.b }, p0/z, [sp]
; CHECK-DAG: ld1b    { z{{[01]}}.b }, p0/z, [sp, #1, mul vl]
  %local0 = alloca <vscale x 16 x i8>
  %local1 = alloca <vscale x 16 x i8>
  load volatile <vscale x 16 x i8>, <vscale x 16 x i8>* %local0
  load volatile <vscale x 16 x i8>, <vscale x 16 x i8>* %local1
  ret void
}

define void @fill_nxv8i16() {
; CHECK-LABEL: fill_nxv8i16
; CHECK-DAG: ld1h    { z{{[01]}}.h }, p0/z, [sp]
; CHECK-DAG: ld1h    { z{{[01]}}.h }, p0/z, [sp, #1, mul vl]
  %local0 = alloca <vscale x 8 x i16>
  %local1 = alloca <vscale x 8 x i16>
  load volatile <vscale x 8 x i16>, <vscale x 8 x i16>* %local0
  load volatile <vscale x 8 x i16>, <vscale x 8 x i16>* %local1
  ret void
}

define void @fill_nxv4i32() {
; CHECK-LABEL: fill_nxv4i32
; CHECK-DAG: ld1w    { z{{[01]}}.s }, p0/z, [sp]
; CHECK-DAG: ld1w    { z{{[01]}}.s }, p0/z, [sp, #1, mul vl]
  %local0 = alloca <vscale x 4 x i32>
  %local1 = alloca <vscale x 4 x i32>
  load volatile <vscale x 4 x i32>, <vscale x 4 x i32>* %local0
  load volatile <vscale x 4 x i32>, <vscale x 4 x i32>* %local1
  ret void
}

define void @fill_nxv2i64() {
; CHECK-LABEL: fill_nxv2i64
; CHECK-DAG: ld1d    { z{{[01]}}.d }, p0/z, [sp]
; CHECK-DAG: ld1d    { z{{[01]}}.d }, p0/z, [sp, #1, mul vl]
  %local0 = alloca <vscale x 2 x i64>
  %local1 = alloca <vscale x 2 x i64>
  load volatile <vscale x 2 x i64>, <vscale x 2 x i64>* %local0
  load volatile <vscale x 2 x i64>, <vscale x 2 x i64>* %local1
  ret void
}


; Data spills

define void @spill_nxv16i8(<vscale x 16 x i8> %v0, <vscale x 16 x i8> %v1) {
; CHECK-LABEL: spill_nxv16i8
; CHECK-DAG: st1b    { z{{[01]}}.b }, p0, [sp]
; CHECK-DAG: st1b    { z{{[01]}}.b }, p0, [sp, #1, mul vl]
  %local0 = alloca <vscale x 16 x i8>
  %local1 = alloca <vscale x 16 x i8>
  store volatile <vscale x 16 x i8> %v0, <vscale x 16 x i8>* %local0
  store volatile <vscale x 16 x i8> %v1, <vscale x 16 x i8>* %local1
  ret void
}

define void @spill_nxv8i16(<vscale x 8 x i16> %v0, <vscale x 8 x i16> %v1) {
; CHECK-LABEL: spill_nxv8i16
; CHECK-DAG: st1h    { z{{[01]}}.h }, p0, [sp]
; CHECK-DAG: st1h    { z{{[01]}}.h }, p0, [sp, #1, mul vl]
  %local0 = alloca <vscale x 8 x i16>
  %local1 = alloca <vscale x 8 x i16>
  store volatile <vscale x 8 x i16> %v0, <vscale x 8 x i16>* %local0
  store volatile <vscale x 8 x i16> %v1, <vscale x 8 x i16>* %local1
  ret void
}

define void @spill_nxv4i32(<vscale x 4 x i32> %v0, <vscale x 4 x i32> %v1) {
; CHECK-LABEL: spill_nxv4i32
; CHECK-DAG: st1w    { z{{[01]}}.s }, p0, [sp]
; CHECK-DAG: st1w    { z{{[01]}}.s }, p0, [sp, #1, mul vl]
  %local0 = alloca <vscale x 4 x i32>
  %local1 = alloca <vscale x 4 x i32>
  store volatile <vscale x 4 x i32> %v0, <vscale x 4 x i32>* %local0
  store volatile <vscale x 4 x i32> %v1, <vscale x 4 x i32>* %local1
  ret void
}

define void @spill_nxv2i64(<vscale x 2 x i64> %v0, <vscale x 2 x i64> %v1) {
; CHECK-LABEL: spill_nxv2i64
; CHECK-DAG: st1d    { z{{[01]}}.d }, p0, [sp]
; CHECK-DAG: st1d    { z{{[01]}}.d }, p0, [sp, #1, mul vl]
  %local0 = alloca <vscale x 2 x i64>
  %local1 = alloca <vscale x 2 x i64>
  store volatile <vscale x 2 x i64> %v0, <vscale x 2 x i64>* %local0
  store volatile <vscale x 2 x i64> %v1, <vscale x 2 x i64>* %local1
  ret void
}

; Predicate fills

define void @fill_nxv16i1() {
; CHECK-LABEL: fill_nxv16i1
; CHECK-DAG: ldr    p{{[01]}}, [sp, #8, mul vl]
; CHECK-DAG: ldr    p{{[01]}}, [sp]
  %local0 = alloca <vscale x 16 x i1>
  %local1 = alloca <vscale x 16 x i1>
  load volatile <vscale x 16 x i1>, <vscale x 16 x i1>* %local0
  load volatile <vscale x 16 x i1>, <vscale x 16 x i1>* %local1
  ret void
}

define void @fill_nxv8i1() {
; CHECK-LABEL: fill_nxv8i1
; CHECK-DAG: ldr    p{{[01]}}, [sp, #4, mul vl]
; CHECK-DAG: ldr    p{{[01]}}, [sp]
  %local0 = alloca <vscale x 8 x i1>
  %local1 = alloca <vscale x 8 x i1>
  load volatile <vscale x 8 x i1>, <vscale x 8 x i1>* %local0
  load volatile <vscale x 8 x i1>, <vscale x 8 x i1>* %local1
  ret void
}

define void @fill_nxv4i1() {
; CHECK-LABEL: fill_nxv4i1
; CHECK-DAG: ldr    p{{[01]}}, [sp, #6, mul vl]
; CHECK-DAG: ldr    p{{[01]}}, [sp, #4, mul vl]
  %local0 = alloca <vscale x 4 x i1>
  %local1 = alloca <vscale x 4 x i1>
  load volatile <vscale x 4 x i1>, <vscale x 4 x i1>* %local0
  load volatile <vscale x 4 x i1>, <vscale x 4 x i1>* %local1
  ret void
}

define void @fill_nxv2i1() {
; CHECK-LABEL: fill_nxv2i1
; CHECK-DAG: ldr    p{{[01]}}, [sp, #7, mul vl]
; CHECK-DAG: ldr    p{{[01]}}, [sp, #6, mul vl]
  %local0 = alloca <vscale x 2 x i1>
  %local1 = alloca <vscale x 2 x i1>
  load volatile <vscale x 2 x i1>, <vscale x 2 x i1>* %local0
  load volatile <vscale x 2 x i1>, <vscale x 2 x i1>* %local1
  ret void
}

; Predicate spills

define void @spill_nxv16i1(<vscale x 16 x i1> %v0, <vscale x 16 x i1> %v1) {
; CHECK-LABEL: spill_nxv16i1
; CHECK-DAG: str    p{{[01]}}, [sp, #8, mul vl]
; CHECK-DAG: str    p{{[01]}}, [sp]
  %local0 = alloca <vscale x 16 x i1>
  %local1 = alloca <vscale x 16 x i1>
  store volatile <vscale x 16 x i1> %v0, <vscale x 16 x i1>* %local0
  store volatile <vscale x 16 x i1> %v1, <vscale x 16 x i1>* %local1
  ret void
}

define void @spill_nxv8i1(<vscale x 8 x i1> %v0, <vscale x 8 x i1> %v1) {
; CHECK-LABEL: spill_nxv8i1
; CHECK-DAG: str    p{{[01]}}, [sp, #4, mul vl]
; CHECK-DAG: str    p{{[01]}}, [sp]
  %local0 = alloca <vscale x 8 x i1>
  %local1 = alloca <vscale x 8 x i1>
  store volatile <vscale x 8 x i1> %v0, <vscale x 8 x i1>* %local0
  store volatile <vscale x 8 x i1> %v1, <vscale x 8 x i1>* %local1
  ret void
}

define void @spill_nxv4i1(<vscale x 4 x i1> %v0, <vscale x 4 x i1> %v1) {
; CHECK-LABEL: spill_nxv4i1
; CHECK-DAG: str    p{{[01]}}, [sp, #6, mul vl]
; CHECK-DAG: str    p{{[01]}}, [sp, #4, mul vl]
  %local0 = alloca <vscale x 4 x i1>
  %local1 = alloca <vscale x 4 x i1>
  store volatile <vscale x 4 x i1> %v0, <vscale x 4 x i1>* %local0
  store volatile <vscale x 4 x i1> %v1, <vscale x 4 x i1>* %local1
  ret void
}

define void @spill_nxv2i1(<vscale x 2 x i1> %v0, <vscale x 2 x i1> %v1) {
; CHECK-LABEL: spill_nxv2i1
; CHECK-DAG: str    p{{[01]}}, [sp, #7, mul vl]
; CHECK-DAG: str    p{{[01]}}, [sp, #6, mul vl]
  %local0 = alloca <vscale x 2 x i1>
  %local1 = alloca <vscale x 2 x i1>
  store volatile <vscale x 2 x i1> %v0, <vscale x 2 x i1>* %local0
  store volatile <vscale x 2 x i1> %v1, <vscale x 2 x i1>* %local1
  ret void
}
