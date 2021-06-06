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
define weak_odr dso_local void @_ZN8testFunc3runEv(%struct.testFunc* %this) local_unnamed_addr #0 comdat align 2 {
entry:
  %_M_start.i = getelementptr inbounds %struct.testFunc, %struct.testFunc* %this, i64 0, i32 1, i32 0, i32 0, i32 0
  %0 = load i32*, i32** %_M_start.i, align 8, !tbaa !2
  %1 = load i32, i32* %0, align 4, !tbaa !8
  br label %for.body.for.body_crit_edge

for.cond.cleanup:                                 ; preds = %for.body.for.body_crit_edge
  %min_ = getelementptr inbounds %struct.testFunc, %struct.testFunc* %this, i64 0, i32 0
  store i32 %spec.select, i32* %min_, align 8, !tbaa !10
  ret void

for.body.for.body_crit_edge:                      ; preds = %entry, %for.body.for.body_crit_edge
  %indvars.iv.next16 = phi i64 [ 1, %entry ], [ %indvars.iv.next, %for.body.for.body_crit_edge ]
  %spec.select15 = phi i32 [ %1, %entry ], [ %spec.select, %for.body.for.body_crit_edge ]
  %add.ptr.i.phi.trans.insert = getelementptr inbounds i32, i32* %0, i64 %indvars.iv.next16
  %.pre = load i32, i32* %add.ptr.i.phi.trans.insert, align 4, !tbaa !8
  %cmp4 = icmp slt i32 %.pre, %spec.select15
  %spec.select = select i1 %cmp4, i32 %.pre, i32 %spec.select15
  %indvars.iv.next = add nuw nsw i64 %indvars.iv.next16, 1
  %exitcond.not = icmp eq i64 %indvars.iv.next, 1048576
  br i1 %exitcond.not, label %for.cond.cleanup, label %for.body.for.body_crit_edge, !llvm.loop !13
}

attributes #0 = { noinline nounwind uwtable "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "frame-pointer"="none" "less-precise-fpmad"="false" "min-legal-vector-width"="0" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }

!llvm.module.flags = !{!0}
!llvm.ident = !{!1}

!0 = !{i32 1, !"wchar_size", i32 4}
!1 = !{!"clang version 11.1.0 (https://github.com/llvm/llvm-project.git 1fdec59bffc11ae37eb51a1b9869f0696bfd5312)"}
!2 = !{!3, !5, i64 0}
!3 = !{!"_ZTSSt12_Vector_baseIiSaIiEE", !4, i64 0}
!4 = !{!"_ZTSNSt12_Vector_baseIiSaIiEE12_Vector_implE", !5, i64 0, !5, i64 8, !5, i64 16}
!5 = !{!"any pointer", !6, i64 0}
!6 = !{!"omnipotent char", !7, i64 0}
!7 = !{!"Simple C++ TBAA"}
!8 = !{!9, !9, i64 0}
!9 = !{!"int", !6, i64 0}
!10 = !{!11, !9, i64 0}
!11 = !{!"_ZTS8testFunc", !9, i64 0, !12, i64 8}
!12 = !{!"_ZTSSt6vectorIiSaIiEE"}
!13 = distinct !{!13, !14}
!14 = !{!"llvm.loop.unroll.disable"}
