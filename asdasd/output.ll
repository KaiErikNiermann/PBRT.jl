; ModuleID = 'test.cpp'
source_filename = "test.cpp"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-pc-linux-gnu"

%struct.Box = type { i32 }

$_Z8out_typeI3BoxIiEENT_10value_typeES2_S2_ = comdat any

@__const.main.a = private unnamed_addr constant %struct.Box { i32 1 }, align 4
@__const.main.b = private unnamed_addr constant %struct.Box { i32 2 }, align 4

; Function Attrs: mustprogress noinline norecurse optnone uwtable
define dso_local noundef i32 @main() #0 {
  %1 = alloca i32, align 4
  %2 = alloca %struct.Box, align 4
  %3 = alloca %struct.Box, align 4
  %4 = alloca i32, align 4
  %5 = alloca %struct.Box, align 4
  %6 = alloca %struct.Box, align 4
  store i32 0, i32* %1, align 4
  %7 = bitcast %struct.Box* %2 to i8*
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* align 4 %7, i8* align 4 bitcast (%struct.Box* @__const.main.a to i8*), i64 4, i1 false)
  %8 = bitcast %struct.Box* %3 to i8*
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* align 4 %8, i8* align 4 bitcast (%struct.Box* @__const.main.b to i8*), i64 4, i1 false)
  %9 = bitcast %struct.Box* %5 to i8*
  %10 = bitcast %struct.Box* %2 to i8*
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* align 4 %9, i8* align 4 %10, i64 4, i1 false)
  %11 = bitcast %struct.Box* %6 to i8*
  %12 = bitcast %struct.Box* %3 to i8*
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* align 4 %11, i8* align 4 %12, i64 4, i1 false)
  %13 = getelementptr inbounds %struct.Box, %struct.Box* %5, i32 0, i32 0
  %14 = load i32, i32* %13, align 4
  %15 = getelementptr inbounds %struct.Box, %struct.Box* %6, i32 0, i32 0
  %16 = load i32, i32* %15, align 4
  %17 = call noundef i32 @_Z8out_typeI3BoxIiEENT_10value_typeES2_S2_(i32 %14, i32 %16)
  store i32 %17, i32* %4, align 4
  ret i32 0
}

; Function Attrs: argmemonly nofree nounwind willreturn
declare void @llvm.memcpy.p0i8.p0i8.i64(i8* noalias nocapture writeonly, i8* noalias nocapture readonly, i64, i1 immarg) #1

; Function Attrs: mustprogress noinline nounwind optnone uwtable
define linkonce_odr dso_local noundef i32 @_Z8out_typeI3BoxIiEENT_10value_typeES2_S2_(i32 %0, i32 %1) #2 comdat {
  %3 = alloca %struct.Box, align 4
  %4 = alloca %struct.Box, align 4
  %5 = getelementptr inbounds %struct.Box, %struct.Box* %3, i32 0, i32 0
  store i32 %0, i32* %5, align 4
  %6 = getelementptr inbounds %struct.Box, %struct.Box* %4, i32 0, i32 0
  store i32 %1, i32* %6, align 4
  %7 = getelementptr inbounds %struct.Box, %struct.Box* %3, i32 0, i32 0
  %8 = load i32, i32* %7, align 4
  ret i32 %8
}

attributes #0 = { mustprogress noinline norecurse optnone uwtable "frame-pointer"="all" "min-legal-vector-width"="0" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #1 = { argmemonly nofree nounwind willreturn }
attributes #2 = { mustprogress noinline nounwind optnone uwtable "frame-pointer"="all" "min-legal-vector-width"="0" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }

!llvm.linker.options = !{}
!llvm.module.flags = !{!0, !1, !2, !3, !4}
!llvm.ident = !{!5}

!0 = !{i32 1, !"wchar_size", i32 4}
!1 = !{i32 7, !"PIC Level", i32 2}
!2 = !{i32 7, !"PIE Level", i32 2}
!3 = !{i32 7, !"uwtable", i32 1}
!4 = !{i32 7, !"frame-pointer", i32 2}
!5 = !{!"Ubuntu clang version 14.0.0-1ubuntu1.1"}
