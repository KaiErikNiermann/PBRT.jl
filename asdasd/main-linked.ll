; ModuleID = 'main.225d1bb29b40c5e1-cgu.0'
source_filename = "main.225d1bb29b40c5e1-cgu.0"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-i128:128-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

@vtable.0 = private unnamed_addr constant <{ [24 x i8], ptr, ptr, ptr }> <{ [24 x i8] c"\00\00\00\00\00\00\00\00\08\00\00\00\00\00\00\00\08\00\00\00\00\00\00\00", ptr @"_ZN4core3ops8function6FnOnce40call_once$u7b$$u7b$vtable.shim$u7d$$u7d$17h6e01b2ff0f5fb540E", ptr @"_ZN3std2rt10lang_start28_$u7b$$u7b$closure$u7d$$u7d$17h1168fae7c2fd8efdE", ptr @"_ZN3std2rt10lang_start28_$u7b$$u7b$closure$u7d$$u7d$17h1168fae7c2fd8efdE" }>, align 8
@alloc_2c3e1b1fcabdbe1e47ac2b5c9e67906a = private unnamed_addr constant <{ [17 x i8] }> <{ [17 x i8] c"Sum of integers: " }>, align 1
@alloc_49a1e817e911805af64bbc7efb390101 = private unnamed_addr constant <{ [1 x i8] }> <{ [1 x i8] c"\0A" }>, align 1
@alloc_4fd3f97b217e517bf80bb2f049cb13f0 = private unnamed_addr constant <{ ptr, [8 x i8], ptr, [8 x i8] }> <{ ptr @alloc_2c3e1b1fcabdbe1e47ac2b5c9e67906a, [8 x i8] c"\11\00\00\00\00\00\00\00", ptr @alloc_49a1e817e911805af64bbc7efb390101, [8 x i8] c"\01\00\00\00\00\00\00\00" }>, align 8
@alloc_720585a813f056967f4f732a51abef76 = private unnamed_addr constant <{ [15 x i8] }> <{ [15 x i8] c"Sum of floats: " }>, align 1
@alloc_b6415b1ced752598e33f3bf76a4ead24 = private unnamed_addr constant <{ ptr, [8 x i8], ptr, [8 x i8] }> <{ ptr @alloc_720585a813f056967f4f732a51abef76, [8 x i8] c"\0F\00\00\00\00\00\00\00", ptr @alloc_49a1e817e911805af64bbc7efb390101, [8 x i8] c"\01\00\00\00\00\00\00\00" }>, align 8

; std::rt::lang_start
; Function Attrs: nonlazybind uwtable
define hidden noundef i64 @_ZN3std2rt10lang_start17hefc27b9d44b2002dE(ptr noundef nonnull %main, i64 noundef %argc, ptr noundef %argv, i8 noundef %sigpipe) unnamed_addr #0 {
start:
  %_8 = alloca [8 x i8], align 8
  call void @llvm.lifetime.start.p0(i64 8, ptr nonnull %_8)
  store ptr %main, ptr %_8, align 8
; call std::rt::lang_start_internal
  %0 = call noundef i64 @_ZN3std2rt19lang_start_internal17h5e7c81cecd7f0954E(ptr noundef nonnull align 1 %_8, ptr noalias noundef nonnull readonly align 8 dereferenceable(48) @vtable.0, i64 noundef %argc, ptr noundef %argv, i8 noundef %sigpipe)
  call void @llvm.lifetime.end.p0(i64 8, ptr nonnull %_8)
  ret i64 %0
}

; std::rt::lang_start::{{closure}}
; Function Attrs: inlinehint nonlazybind uwtable
define internal noundef i32 @"_ZN3std2rt10lang_start28_$u7b$$u7b$closure$u7d$$u7d$17h1168fae7c2fd8efdE"(ptr noalias nocapture noundef readonly align 8 dereferenceable(8) %_1) unnamed_addr #1 {
start:
  %_4 = load ptr, ptr %_1, align 8, !nonnull !4, !noundef !4
; call std::sys::backtrace::__rust_begin_short_backtrace
  tail call fastcc void @_ZN3std3sys9backtrace28__rust_begin_short_backtrace17hae39def316604ea5E(ptr noundef nonnull %_4)
  ret i32 0
}

; std::sys::backtrace::__rust_begin_short_backtrace
; Function Attrs: noinline nonlazybind uwtable
define internal fastcc void @_ZN3std3sys9backtrace28__rust_begin_short_backtrace17hae39def316604ea5E(ptr nocapture noundef nonnull readonly %f) unnamed_addr #2 {
start:
  tail call void %f()
  tail call void asm sideeffect "", "~{memory}"() #6, !srcloc !5
  ret void
}

; core::ops::function::FnOnce::call_once{{vtable.shim}}
; Function Attrs: inlinehint nonlazybind uwtable
define internal noundef i32 @"_ZN4core3ops8function6FnOnce40call_once$u7b$$u7b$vtable.shim$u7d$$u7d$17h6e01b2ff0f5fb540E"(ptr nocapture noundef readonly %_1) unnamed_addr #1 personality ptr @rust_eh_personality {
start:
  %0 = load ptr, ptr %_1, align 8, !nonnull !4, !noundef !4
; call std::sys::backtrace::__rust_begin_short_backtrace
  tail call fastcc void @_ZN3std3sys9backtrace28__rust_begin_short_backtrace17hae39def316604ea5E(ptr noundef nonnull %0), !noalias !6
  ret i32 0
}

; main::main
; Function Attrs: nonlazybind uwtable
define internal void @_ZN4main4main17hfb7f0a93cf431d44E() unnamed_addr #0 {
start:
  %_11 = alloca [16 x i8], align 8
  %_9 = alloca [48 x i8], align 8
  %float_sum = alloca [8 x i8], align 8
  %_5 = alloca [16 x i8], align 8
  %_3 = alloca [48 x i8], align 8
  %int_sum = alloca [4 x i8], align 4
  call void @llvm.lifetime.start.p0(i64 4, ptr nonnull %int_sum)
  %0 = tail call noundef i32 @add_i32(i32 noundef 5, i32 noundef 10) #6
  store i32 %0, ptr %int_sum, align 4
  call void @llvm.lifetime.start.p0(i64 48, ptr nonnull %_3)
  call void @llvm.lifetime.start.p0(i64 16, ptr nonnull %_5)
  store ptr %int_sum, ptr %_5, align 8
  %_6.sroa.4.0..sroa_idx = getelementptr inbounds i8, ptr %_5, i64 8
  store ptr @"_ZN4core3fmt3num3imp52_$LT$impl$u20$core..fmt..Display$u20$for$u20$i32$GT$3fmt17h70cb0cc39cca2353E", ptr %_6.sroa.4.0..sroa_idx, align 8
  store ptr @alloc_4fd3f97b217e517bf80bb2f049cb13f0, ptr %_3, align 8
  %1 = getelementptr inbounds i8, ptr %_3, i64 8
  store i64 2, ptr %1, align 8
  %2 = getelementptr inbounds i8, ptr %_3, i64 32
  store ptr null, ptr %2, align 8
  %3 = getelementptr inbounds i8, ptr %_3, i64 16
  store ptr %_5, ptr %3, align 8
  %4 = getelementptr inbounds i8, ptr %_3, i64 24
  store i64 1, ptr %4, align 8
; call std::io::stdio::_print
  call void @_ZN3std2io5stdio6_print17h47fcac1e810b43ceE(ptr noalias nocapture noundef nonnull align 8 dereferenceable(48) %_3)
  call void @llvm.lifetime.end.p0(i64 48, ptr nonnull %_3)
  call void @llvm.lifetime.end.p0(i64 16, ptr nonnull %_5)
  call void @llvm.lifetime.end.p0(i64 4, ptr nonnull %int_sum)
  call void @llvm.lifetime.start.p0(i64 8, ptr nonnull %float_sum)
  %5 = call noundef double @add_f64(double noundef 2.500000e+00, double noundef 3.500000e+00) #6
  store double %5, ptr %float_sum, align 8
  call void @llvm.lifetime.start.p0(i64 48, ptr nonnull %_9)
  call void @llvm.lifetime.start.p0(i64 16, ptr nonnull %_11)
  store ptr %float_sum, ptr %_11, align 8
  %_12.sroa.4.0..sroa_idx = getelementptr inbounds i8, ptr %_11, i64 8
  store ptr @"_ZN4core3fmt5float52_$LT$impl$u20$core..fmt..Display$u20$for$u20$f64$GT$3fmt17hadc1df07b9cb914cE", ptr %_12.sroa.4.0..sroa_idx, align 8
  store ptr @alloc_b6415b1ced752598e33f3bf76a4ead24, ptr %_9, align 8
  %6 = getelementptr inbounds i8, ptr %_9, i64 8
  store i64 2, ptr %6, align 8
  %7 = getelementptr inbounds i8, ptr %_9, i64 32
  store ptr null, ptr %7, align 8
  %8 = getelementptr inbounds i8, ptr %_9, i64 16
  store ptr %_11, ptr %8, align 8
  %9 = getelementptr inbounds i8, ptr %_9, i64 24
  store i64 1, ptr %9, align 8
; call std::io::stdio::_print
  call void @_ZN3std2io5stdio6_print17h47fcac1e810b43ceE(ptr noalias nocapture noundef nonnull align 8 dereferenceable(48) %_9)
  call void @llvm.lifetime.end.p0(i64 48, ptr nonnull %_9)
  call void @llvm.lifetime.end.p0(i64 16, ptr nonnull %_11)
  call void @llvm.lifetime.end.p0(i64 8, ptr nonnull %float_sum)
  ret void
}

; std::rt::lang_start_internal
; Function Attrs: nonlazybind uwtable
declare noundef i64 @_ZN3std2rt19lang_start_internal17h5e7c81cecd7f0954E(ptr noundef nonnull align 1, ptr noalias noundef readonly align 8 dereferenceable(48), i64 noundef, ptr noundef, i8 noundef) unnamed_addr #0

; Function Attrs: nounwind nonlazybind uwtable
declare noundef i32 @rust_eh_personality(i32 noundef, i32 noundef, i64 noundef, ptr noundef, ptr noundef) unnamed_addr #3

; Function Attrs: nounwind nonlazybind uwtable
declare noundef i32 @add_i32(i32 noundef, i32 noundef) unnamed_addr #3

; core::fmt::num::imp::<impl core::fmt::Display for i32>::fmt
; Function Attrs: nonlazybind uwtable
declare noundef zeroext i1 @"_ZN4core3fmt3num3imp52_$LT$impl$u20$core..fmt..Display$u20$for$u20$i32$GT$3fmt17h70cb0cc39cca2353E"(ptr noalias noundef readonly align 4 dereferenceable(4), ptr noalias noundef align 8 dereferenceable(64)) unnamed_addr #0

; std::io::stdio::_print
; Function Attrs: nonlazybind uwtable
declare void @_ZN3std2io5stdio6_print17h47fcac1e810b43ceE(ptr noalias nocapture noundef align 8 dereferenceable(48)) unnamed_addr #0

; Function Attrs: nounwind nonlazybind uwtable
declare noundef double @add_f64(double noundef, double noundef) unnamed_addr #3

; core::fmt::float::<impl core::fmt::Display for f64>::fmt
; Function Attrs: nonlazybind uwtable
declare noundef zeroext i1 @"_ZN4core3fmt5float52_$LT$impl$u20$core..fmt..Display$u20$for$u20$f64$GT$3fmt17hadc1df07b9cb914cE"(ptr noalias noundef readonly align 8 dereferenceable(8), ptr noalias noundef align 8 dereferenceable(64)) unnamed_addr #0

; Function Attrs: nonlazybind
define noundef i32 @main(i32 %0, ptr %1) unnamed_addr #4 {
top:
  %_8.i = alloca [8 x i8], align 8
  %2 = sext i32 %0 to i64
  call void @llvm.lifetime.start.p0(i64 8, ptr nonnull %_8.i)
  store ptr @_ZN4main4main17hfb7f0a93cf431d44E, ptr %_8.i, align 8
; call std::rt::lang_start_internal
  %3 = call noundef i64 @_ZN3std2rt19lang_start_internal17h5e7c81cecd7f0954E(ptr noundef nonnull align 1 %_8.i, ptr noalias noundef nonnull readonly align 8 dereferenceable(48) @vtable.0, i64 noundef %2, ptr noundef %1, i8 noundef 0)
  call void @llvm.lifetime.end.p0(i64 8, ptr nonnull %_8.i)
  %4 = trunc i64 %3 to i32
  ret i32 %4
}

; Function Attrs: mustprogress nocallback nofree nosync nounwind willreturn memory(argmem: readwrite)
declare void @llvm.lifetime.start.p0(i64 immarg, ptr nocapture) #5

; Function Attrs: mustprogress nocallback nofree nosync nounwind willreturn memory(argmem: readwrite)
declare void @llvm.lifetime.end.p0(i64 immarg, ptr nocapture) #5

attributes #0 = { nonlazybind uwtable "probe-stack"="inline-asm" "target-cpu"="x86-64" }
attributes #1 = { inlinehint nonlazybind uwtable "probe-stack"="inline-asm" "target-cpu"="x86-64" }
attributes #2 = { noinline nonlazybind uwtable "probe-stack"="inline-asm" "target-cpu"="x86-64" }
attributes #3 = { nounwind nonlazybind uwtable "probe-stack"="inline-asm" "target-cpu"="x86-64" }
attributes #4 = { nonlazybind "probe-stack"="inline-asm" "target-cpu"="x86-64" }
attributes #5 = { mustprogress nocallback nofree nosync nounwind willreturn memory(argmem: readwrite) }
attributes #6 = { nounwind }

!llvm.module.flags = !{!0, !1, !2}
!llvm.ident = !{!3}

!0 = !{i32 8, !"PIC Level", i32 2}
!1 = !{i32 7, !"PIE Level", i32 2}
!2 = !{i32 2, !"RtLibUseGOT", i32 1}
!3 = !{!"rustc version 1.81.0 (eeb90cda1 2024-09-04)"}
!4 = !{}
!5 = !{i32 1767574}
!6 = !{!7}
!7 = distinct !{!7, !8, !"_ZN3std2rt10lang_start28_$u7b$$u7b$closure$u7d$$u7d$17h1168fae7c2fd8efdE: %_1"}
!8 = distinct !{!8, !"_ZN3std2rt10lang_start28_$u7b$$u7b$closure$u7d$$u7d$17h1168fae7c2fd8efdE"}
