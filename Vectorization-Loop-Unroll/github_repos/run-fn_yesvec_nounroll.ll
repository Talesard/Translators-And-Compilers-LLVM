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

vector.body:                                      ; preds = %vector.body, %entry
  %index = phi i64 [ 0, %entry ], [ %index.next, %vector.body ]
  %vec.phi = phi <4 x i32> [ %minmax.ident.splat, %entry ], [ %5, %vector.body ]
  %offset.idx = or i64 %index, 1
  %2 = getelementptr inbounds i32, i32* %0, i64 %offset.idx, !dbg !23
  %3 = bitcast i32* %2 to <4 x i32>*, !dbg !25
  %wide.load = load <4 x i32>, <4 x i32>* %3, align 4, !dbg !25, !tbaa !20
  %4 = icmp slt <4 x i32> %wide.load, %vec.phi, !dbg !26
  %5 = select <4 x i1> %4, <4 x i32> %wide.load, <4 x i32> %vec.phi, !dbg !27
  %index.next = add i64 %index, 4
  %6 = icmp eq i64 %index.next, 1048572
  br i1 %6, label %middle.block, label %vector.body, !llvm.loop !28

middle.block:                                     ; preds = %vector.body
  %7 = call i32 @llvm.experimental.vector.reduce.smin.v4i32(<4 x i32> %5), !dbg !22
  br label %for.body.for.body_crit_edge, !dbg !22

for.cond.cleanup:                                 ; preds = %for.body.for.body_crit_edge
  %min_ = getelementptr inbounds %struct.testFunc, %struct.testFunc* %this, i64 0, i32 0, !dbg !32
  store i32 %spec.select, i32* %min_, align 8, !dbg !33, !tbaa !34
  ret void, !dbg !37

for.body.for.body_crit_edge:                      ; preds = %middle.block, %for.body.for.body_crit_edge
  %indvars.iv.next16 = phi i64 [ 1048573, %middle.block ], [ %indvars.iv.next, %for.body.for.body_crit_edge ]
  %spec.select15 = phi i32 [ %7, %middle.block ], [ %spec.select, %for.body.for.body_crit_edge ]
  %add.ptr.i.phi.trans.insert = getelementptr inbounds i32, i32* %0, i64 %indvars.iv.next16, !dbg !23
  %.pre = load i32, i32* %add.ptr.i.phi.trans.insert, align 4, !dbg !25, !tbaa !20
  %cmp4 = icmp slt i32 %.pre, %spec.select15, !dbg !26
  %spec.select = select i1 %cmp4, i32 %.pre, i32 %spec.select15, !dbg !27
  %indvars.iv.next = add nuw nsw i64 %indvars.iv.next16, 1, !dbg !38
  %exitcond.not = icmp eq i64 %indvars.iv.next, 1048576, !dbg !39
  br i1 %exitcond.not, label %for.cond.cleanup, label %for.body.for.body_crit_edge, !dbg !22, !llvm.loop !40
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
!28 = distinct !{!28, !22, !29, !30, !31}
!29 = !DILocation(line: 28, column: 9, scope: !6)
!30 = !{!"llvm.loop.unroll.disable"}
!31 = !{!"llvm.loop.isvectorized", i32 1}
!32 = !DILocation(line: 30, column: 9, scope: !6)
!33 = !DILocation(line: 30, column: 14, scope: !6)
!34 = !{!35, !21, i64 0}
!35 = !{!"_ZTS8testFunc", !21, i64 0, !36, i64 8}
!36 = !{!"_ZTSSt6vectorIiSaIiEE"}
!37 = !DILocation(line: 31, column: 2, scope: !6)
!38 = !DILocation(line: 25, column: 25, scope: !6)
!39 = !DILocation(line: 25, column: 19, scope: !6)
!40 = distinct !{!40, !22, !29, !30, !31}
