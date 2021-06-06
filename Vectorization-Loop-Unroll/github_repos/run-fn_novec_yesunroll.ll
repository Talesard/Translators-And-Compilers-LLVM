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
  br label %for.body.for.body_crit_edge, !dbg !22

for.cond.cleanup:                                 ; preds = %for.body.for.body_crit_edge
  %min_ = getelementptr inbounds %struct.testFunc, %struct.testFunc* %this, i64 0, i32 0, !dbg !23
  store i32 %spec.select.4, i32* %min_, align 8, !dbg !24, !tbaa !25
  ret void, !dbg !28

for.body.for.body_crit_edge:                      ; preds = %for.body.for.body_crit_edge, %entry
  %indvars.iv.next16 = phi i64 [ 1, %entry ], [ %indvars.iv.next.4, %for.body.for.body_crit_edge ]
  %spec.select15 = phi i32 [ %1, %entry ], [ %spec.select.4, %for.body.for.body_crit_edge ]
  %add.ptr.i.phi.trans.insert = getelementptr inbounds i32, i32* %0, i64 %indvars.iv.next16, !dbg !29
  %.pre = load i32, i32* %add.ptr.i.phi.trans.insert, align 4, !dbg !31, !tbaa !20
  %cmp4 = icmp slt i32 %.pre, %spec.select15, !dbg !32
  %spec.select = select i1 %cmp4, i32 %.pre, i32 %spec.select15, !dbg !33
  %indvars.iv.next = add nuw nsw i64 %indvars.iv.next16, 1, !dbg !34
  %add.ptr.i.phi.trans.insert.1 = getelementptr inbounds i32, i32* %0, i64 %indvars.iv.next, !dbg !29
  %.pre.1 = load i32, i32* %add.ptr.i.phi.trans.insert.1, align 4, !dbg !31, !tbaa !20
  %cmp4.1 = icmp slt i32 %.pre.1, %spec.select, !dbg !32
  %spec.select.1 = select i1 %cmp4.1, i32 %.pre.1, i32 %spec.select, !dbg !33
  %indvars.iv.next.1 = add nuw nsw i64 %indvars.iv.next16, 2, !dbg !34
  %add.ptr.i.phi.trans.insert.2 = getelementptr inbounds i32, i32* %0, i64 %indvars.iv.next.1, !dbg !29
  %.pre.2 = load i32, i32* %add.ptr.i.phi.trans.insert.2, align 4, !dbg !31, !tbaa !20
  %cmp4.2 = icmp slt i32 %.pre.2, %spec.select.1, !dbg !32
  %spec.select.2 = select i1 %cmp4.2, i32 %.pre.2, i32 %spec.select.1, !dbg !33
  %indvars.iv.next.2 = add nuw nsw i64 %indvars.iv.next16, 3, !dbg !34
  %add.ptr.i.phi.trans.insert.3 = getelementptr inbounds i32, i32* %0, i64 %indvars.iv.next.2, !dbg !29
  %.pre.3 = load i32, i32* %add.ptr.i.phi.trans.insert.3, align 4, !dbg !31, !tbaa !20
  %cmp4.3 = icmp slt i32 %.pre.3, %spec.select.2, !dbg !32
  %spec.select.3 = select i1 %cmp4.3, i32 %.pre.3, i32 %spec.select.2, !dbg !33
  %indvars.iv.next.3 = add nuw nsw i64 %indvars.iv.next16, 4, !dbg !34
  %add.ptr.i.phi.trans.insert.4 = getelementptr inbounds i32, i32* %0, i64 %indvars.iv.next.3, !dbg !29
  %.pre.4 = load i32, i32* %add.ptr.i.phi.trans.insert.4, align 4, !dbg !31, !tbaa !20
  %cmp4.4 = icmp slt i32 %.pre.4, %spec.select.3, !dbg !32
  %spec.select.4 = select i1 %cmp4.4, i32 %.pre.4, i32 %spec.select.3, !dbg !33
  %indvars.iv.next.4 = add nuw nsw i64 %indvars.iv.next16, 5, !dbg !34
  %exitcond.not.4 = icmp eq i64 %indvars.iv.next.4, 1048576, !dbg !35
  br i1 %exitcond.not.4, label %for.cond.cleanup, label %for.body.for.body_crit_edge, !dbg !22, !llvm.loop !36
}

attributes #0 = { noinline nounwind uwtable "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "frame-pointer"="none" "less-precise-fpmad"="false" "min-legal-vector-width"="0" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }

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
!23 = !DILocation(line: 30, column: 9, scope: !6)
!24 = !DILocation(line: 30, column: 14, scope: !6)
!25 = !{!26, !21, i64 0}
!26 = !{!"_ZTS8testFunc", !21, i64 0, !27, i64 8}
!27 = !{!"_ZTSSt6vectorIiSaIiEE"}
!28 = !DILocation(line: 31, column: 2, scope: !6)
!29 = !DILocation(line: 0, scope: !10, inlinedAt: !30)
!30 = distinct !DILocation(line: 26, column: 23, scope: !6)
!31 = !DILocation(line: 26, column: 23, scope: !6)
!32 = !DILocation(line: 27, column: 21, scope: !6)
!33 = !DILocation(line: 27, column: 17, scope: !6)
!34 = !DILocation(line: 25, column: 25, scope: !6)
!35 = !DILocation(line: 25, column: 19, scope: !6)
!36 = distinct !{!36, !22, !37}
!37 = !DILocation(line: 28, column: 9, scope: !6)
