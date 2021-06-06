; ModuleID = 'run-fn.bc'
source_filename = "test.cpp"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

%struct.testFunc = type { i32, %"class.std::vector" }
%"class.std::vector" = type { %"struct.std::_Vector_base" }
%"struct.std::_Vector_base" = type { %"struct.std::_Vector_base<int, std::allocator<int>>::_Vector_impl" }
%"struct.std::_Vector_base<int, std::allocator<int>>::_Vector_impl" = type { i32*, i32*, i32* }

$_ZN8testFunc3runEv = comdat any

; Function Attrs: noinline nounwind uwtable
define weak_odr dso_local void @_ZN8testFunc3runEv(%struct.testFunc* %this) local_unnamed_addr #0 comdat align 2 !dbg !6 {
entry:
  %_M_start.i = getelementptr inbounds %struct.testFunc, %struct.testFunc* %this, i64 0, i32 1, i32 0, i32 0, i32 0, !dbg !9
  %0 = load i32*, i32** %_M_start.i, align 8, !dbg !9, !tbaa !13
  %1 = load i32, i32* %0, align 4, !dbg !19, !tbaa !20
  %minmax.ident.splatinsert = insertelement <4 x i32> undef, i32 %1, i32 0, !dbg !22
  %minmax.ident.splat = shufflevector <4 x i32> %minmax.ident.splatinsert, <4 x i32> undef, <4 x i32> zeroinitializer, !dbg !22
  br label %vector.body, !dbg !22

vector.body:                                      ; preds = %vector.body.1, %entry
  %index = phi i64 [ 0, %entry ], [ %index.next.1, %vector.body.1 ]
  %vec.phi = phi <4 x i32> [ %minmax.ident.splat, %entry ], [ %18, %vector.body.1 ]
  %vec.phi17 = phi <4 x i32> [ %minmax.ident.splat, %entry ], [ %19, %vector.body.1 ]
  %offset.idx = or i64 %index, 1
  %2 = getelementptr inbounds i32, i32* %0, i64 %offset.idx, !dbg !23
  %3 = bitcast i32* %2 to <4 x i32>*, !dbg !25
  %wide.load = load <4 x i32>, <4 x i32>* %3, align 4, !dbg !25, !tbaa !20
  %4 = getelementptr inbounds i32, i32* %2, i64 4, !dbg !25
  %5 = bitcast i32* %4 to <4 x i32>*, !dbg !25
  %wide.load18 = load <4 x i32>, <4 x i32>* %5, align 4, !dbg !25, !tbaa !20
  %6 = icmp slt <4 x i32> %wide.load, %vec.phi, !dbg !26
  %7 = icmp slt <4 x i32> %wide.load18, %vec.phi17, !dbg !26
  %8 = select <4 x i1> %6, <4 x i32> %wide.load, <4 x i32> %vec.phi, !dbg !27
  %9 = select <4 x i1> %7, <4 x i32> %wide.load18, <4 x i32> %vec.phi17, !dbg !27
  %10 = icmp eq i64 %index, 1048560
  br i1 %10, label %middle.block, label %vector.body.1, !llvm.loop !28

middle.block:                                     ; preds = %vector.body
  %rdx.minmax.cmp = icmp slt <4 x i32> %8, %9, !dbg !22
  %rdx.minmax.select = select <4 x i1> %rdx.minmax.cmp, <4 x i32> %8, <4 x i32> %9, !dbg !22
  %11 = call i32 @llvm.experimental.vector.reduce.smin.v4i32(<4 x i32> %rdx.minmax.select), !dbg !22
  %add.ptr.i.phi.trans.insert = getelementptr inbounds i32, i32* %0, i64 1048569, !dbg !23
  %.pre = load i32, i32* %add.ptr.i.phi.trans.insert, align 4, !dbg !25, !tbaa !20
  %cmp4 = icmp slt i32 %.pre, %11, !dbg !26
  %spec.select = select i1 %cmp4, i32 %.pre, i32 %11, !dbg !27
  %add.ptr.i.phi.trans.insert.1 = getelementptr inbounds i32, i32* %0, i64 1048570, !dbg !23
  %.pre.1 = load i32, i32* %add.ptr.i.phi.trans.insert.1, align 4, !dbg !25, !tbaa !20
  %cmp4.1 = icmp slt i32 %.pre.1, %spec.select, !dbg !26
  %spec.select.1 = select i1 %cmp4.1, i32 %.pre.1, i32 %spec.select, !dbg !27
  %add.ptr.i.phi.trans.insert.2 = getelementptr inbounds i32, i32* %0, i64 1048571, !dbg !23
  %.pre.2 = load i32, i32* %add.ptr.i.phi.trans.insert.2, align 4, !dbg !25, !tbaa !20
  %cmp4.2 = icmp slt i32 %.pre.2, %spec.select.1, !dbg !26
  %spec.select.2 = select i1 %cmp4.2, i32 %.pre.2, i32 %spec.select.1, !dbg !27
  %add.ptr.i.phi.trans.insert.3 = getelementptr inbounds i32, i32* %0, i64 1048572, !dbg !23
  %.pre.3 = load i32, i32* %add.ptr.i.phi.trans.insert.3, align 4, !dbg !25, !tbaa !20
  %cmp4.3 = icmp slt i32 %.pre.3, %spec.select.2, !dbg !26
  %spec.select.3 = select i1 %cmp4.3, i32 %.pre.3, i32 %spec.select.2, !dbg !27
  %add.ptr.i.phi.trans.insert.4 = getelementptr inbounds i32, i32* %0, i64 1048573, !dbg !23
  %.pre.4 = load i32, i32* %add.ptr.i.phi.trans.insert.4, align 4, !dbg !25, !tbaa !20
  %cmp4.4 = icmp slt i32 %.pre.4, %spec.select.3, !dbg !26
  %spec.select.4 = select i1 %cmp4.4, i32 %.pre.4, i32 %spec.select.3, !dbg !27
  %add.ptr.i.phi.trans.insert.5 = getelementptr inbounds i32, i32* %0, i64 1048574, !dbg !23
  %.pre.5 = load i32, i32* %add.ptr.i.phi.trans.insert.5, align 4, !dbg !25, !tbaa !20
  %cmp4.5 = icmp slt i32 %.pre.5, %spec.select.4, !dbg !26
  %spec.select.5 = select i1 %cmp4.5, i32 %.pre.5, i32 %spec.select.4, !dbg !27
  %add.ptr.i.phi.trans.insert.6 = getelementptr inbounds i32, i32* %0, i64 1048575, !dbg !23
  %.pre.6 = load i32, i32* %add.ptr.i.phi.trans.insert.6, align 4, !dbg !25, !tbaa !20
  %cmp4.6 = icmp slt i32 %.pre.6, %spec.select.5, !dbg !26
  %spec.select.6 = select i1 %cmp4.6, i32 %.pre.6, i32 %spec.select.5, !dbg !27
  %min_ = getelementptr inbounds %struct.testFunc, %struct.testFunc* %this, i64 0, i32 0, !dbg !31
  store i32 %spec.select.6, i32* %min_, align 8, !dbg !32, !tbaa !33
  ret void, !dbg !36

vector.body.1:                                    ; preds = %vector.body
  %offset.idx.1 = or i64 %index, 9
  %12 = getelementptr inbounds i32, i32* %0, i64 %offset.idx.1, !dbg !23
  %13 = bitcast i32* %12 to <4 x i32>*, !dbg !25
  %wide.load.1 = load <4 x i32>, <4 x i32>* %13, align 4, !dbg !25, !tbaa !20
  %14 = getelementptr inbounds i32, i32* %12, i64 4, !dbg !25
  %15 = bitcast i32* %14 to <4 x i32>*, !dbg !25
  %wide.load18.1 = load <4 x i32>, <4 x i32>* %15, align 4, !dbg !25, !tbaa !20
  %16 = icmp slt <4 x i32> %wide.load.1, %8, !dbg !26
  %17 = icmp slt <4 x i32> %wide.load18.1, %9, !dbg !26
  %18 = select <4 x i1> %16, <4 x i32> %wide.load.1, <4 x i32> %8, !dbg !27
  %19 = select <4 x i1> %17, <4 x i32> %wide.load18.1, <4 x i32> %9, !dbg !27
  %index.next.1 = add nuw nsw i64 %index, 16
  br label %vector.body
}

; Function Attrs: nounwind readnone willreturn
declare i32 @llvm.experimental.vector.reduce.smin.v4i32(<4 x i32>) #1

attributes #0 = { noinline nounwind uwtable "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "frame-pointer"="none" "less-precise-fpmad"="false" "min-legal-vector-width"="0" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { nounwind readnone willreturn }

!llvm.dbg.cu = !{!0}
!llvm.module.flags = !{!3, !4}
!llvm.ident = !{!5}

!0 = distinct !DICompileUnit(language: DW_LANG_C_plus_plus_14, file: !1, producer: "clang version 11.1.0 (https://github.com/llvm/llvm-project.git 1fdec59bffc11ae37eb51a1b9869f0696bfd5312)", isOptimized: true, runtimeVersion: 0, emissionKind: NoDebug, enums: !2, splitDebugInlining: false, nameTableKind: None)
!1 = !DIFile(filename: "test.cpp", directory: "/home/talesard/repos/lab3/github_repos")
!2 = !{}
!3 = !{i32 2, !"Debug Info Version", i32 3}
!4 = !{i32 1, !"wchar_size", i32 4}
!5 = !{!"clang version 11.1.0 (https://github.com/llvm/llvm-project.git 1fdec59bffc11ae37eb51a1b9869f0696bfd5312)"}
!6 = distinct !DISubprogram(name: "run", scope: !7, file: !7, line: 23, type: !8, scopeLine: 23, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !0, retainedNodes: !2)
!7 = !DIFile(filename: "./loops/vectorizable/test13.hpp", directory: "/home/talesard/repos/lab3/github_repos")
!8 = !DISubroutineType(types: !2)
!9 = !DILocation(line: 798, column: 25, scope: !10, inlinedAt: !12)
!10 = distinct !DISubprogram(name: "operator[]", scope: !11, file: !11, line: 795, type: !8, scopeLine: 796, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !0, retainedNodes: !2)
!11 = !DIFile(filename: "/usr/lib/gcc/x86_64-linux-gnu/7.5.0/../../../../include/c++/7.5.0/bits/stl_vector.h", directory: "")
!12 = distinct !DILocation(line: 24, column: 19, scope: !6)
!13 = !{!14, !16, i64 0}
!14 = !{!"_ZTSSt12_Vector_baseIiSaIiEE", !15, i64 0}
!15 = !{!"_ZTSNSt12_Vector_baseIiSaIiEE12_Vector_implE", !16, i64 0, !16, i64 8, !16, i64 16}
!16 = !{!"any pointer", !17, i64 0}
!17 = !{!"omnipotent char", !18, i64 0}
!18 = !{!"Simple C++ TBAA"}
!19 = !DILocation(line: 24, column: 19, scope: !6)
!20 = !{!21, !21, i64 0}
!21 = !{!"int", !17, i64 0}
!22 = !DILocation(line: 25, column: 3, scope: !6)
!23 = !DILocation(line: 0, scope: !10, inlinedAt: !24)
!24 = distinct !DILocation(line: 26, column: 23, scope: !6)
!25 = !DILocation(line: 26, column: 23, scope: !6)
!26 = !DILocation(line: 27, column: 21, scope: !6)
!27 = !DILocation(line: 27, column: 17, scope: !6)
!28 = distinct !{!28, !22, !29, !30}
!29 = !DILocation(line: 28, column: 9, scope: !6)
!30 = !{!"llvm.loop.isvectorized", i32 1}
!31 = !DILocation(line: 30, column: 9, scope: !6)
!32 = !DILocation(line: 30, column: 14, scope: !6)
!33 = !{!34, !21, i64 0}
!34 = !{!"_ZTS8testFunc", !21, i64 0, !35, i64 8}
!35 = !{!"_ZTSSt6vectorIiSaIiEE"}
!36 = !DILocation(line: 31, column: 2, scope: !6)
