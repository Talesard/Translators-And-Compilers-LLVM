# Анализ автовекторизации в LLVM

**Выполнил:** Напылов Евгений Игоревич, 381806-2.  
Вариант 13.
  - [Конфигурация](#конфигурация)
  - [Исследуемый цикл](#исследуемый-цикл)
  - [Сравнение LLVM IR](#сравнение-llvm-ir)
    - [Без автовекторизации и раскрутки](#без-автовекторизации-и-раскрутки)
    - [Без автовекторизации, с раскруткой](#без-автовекторизации-с-раскруткой)
    - [С автовекторизацией, без раскрутки](#с-автовекторизацией-без-раскрутки)
    - [С автовекторизацией, c раскруткой](#с-автовекторизацией-c-раскруткой)
  - [Анализ LLVM IR](#анализ-llvm-ir)
      - [Без автовекторизации, с раскруткой](#без-автовекторизации-с-раскруткой-1)
      - [С автовекторизацией, без раскрутки](#с-автовекторизацией-без-раскрутки-1)
      - [С автовекторизацией, c раскруткой](#с-автовекторизацией-c-раскруткой-1)
  - [Измерение времени исполнения](#измерение-времени-исполнения)
  - [Анализ времени исполнения](#анализ-времени-исполнения)
## Конфигурация
**CPU:** Intel® Core™ i5-8265U  
**Instruction set:**  Intel® SSE4.1, Intel® SSE4.2, Intel® AVX2

## Исследуемый цикл  
```C++
	void run(){
            // возможно тут должен быть min=a[0]?
            // но на сравнение это не влияет
            int min = 0;
            for (int i=0; i < N; i++) {
                int val = a[i];
                if (val < min) min = val;
            }
            min_ = min;
	}
```

## Сравнение LLVM IR  
### Без автовекторизации и раскрутки 
```LLVM
for.cond.cleanup:                                 ; preds = %for.body
  %min_ = getelementptr inbounds %struct.testFunc, %struct.testFunc* %this, i64 0, i32 0
  store i32 %spec.select, i32* %min_, align 8, !tbaa !8
  ret void

for.body:                                         ; preds = %for.body, %entry
  %indvars.iv = phi i64 [ 0, %entry ], [ %indvars.iv.next, %for.body ]
  %min.011 = phi i32 [ 0, %entry ], [ %spec.select, %for.body ]
  %add.ptr.i = getelementptr inbounds i32, i32* %0, i64 %indvars.iv
  %1 = load i32, i32* %add.ptr.i, align 4, !tbaa !12
  %cmp2 = icmp slt i32 %1, %min.011
  %spec.select = select i1 %cmp2, i32 %1, i32 %min.011
  %indvars.iv.next = add nuw nsw i64 %indvars.iv, 1
  %exitcond.not = icmp eq i64 %indvars.iv.next, 1048576
  br i1 %exitcond.not, label %for.cond.cleanup, label %for.body, !llvm.loop !13
}
```

### Без автовекторизации, с раскруткой
```LLVM
for.cond.cleanup:                                 ; preds = %for.body
  %min_ = getelementptr inbounds %struct.testFunc, %struct.testFunc* %this, i64 0, i32 0, !dbg !20
  store i32 %spec.select.3, i32* %min_, align 8, !dbg !21, !tbaa !22
  ret void, !dbg !26

for.body:                                         ; preds = %for.body, %entry
  %indvars.iv = phi i64 [ 0, %entry ], [ %indvars.iv.next.3, %for.body ]
  %min.011 = phi i32 [ 0, %entry ], [ %spec.select.3, %for.body ]
  %add.ptr.i = getelementptr inbounds i32, i32* %0, i64 %indvars.iv, !dbg !27
  %1 = load i32, i32* %add.ptr.i, align 4, !dbg !28, !tbaa !29
  %cmp2 = icmp slt i32 %1, %min.011, !dbg !30
  %spec.select = select i1 %cmp2, i32 %1, i32 %min.011, !dbg !31
  %indvars.iv.next = or i64 %indvars.iv, 1, !dbg !32
  %add.ptr.i.1 = getelementptr inbounds i32, i32* %0, i64 %indvars.iv.next, !dbg !27
  %2 = load i32, i32* %add.ptr.i.1, align 4, !dbg !28, !tbaa !29
  %cmp2.1 = icmp slt i32 %2, %spec.select, !dbg !30
  %spec.select.1 = select i1 %cmp2.1, i32 %2, i32 %spec.select, !dbg !31
  %indvars.iv.next.1 = or i64 %indvars.iv, 2, !dbg !32
  %add.ptr.i.2 = getelementptr inbounds i32, i32* %0, i64 %indvars.iv.next.1, !dbg !27
  %3 = load i32, i32* %add.ptr.i.2, align 4, !dbg !28, !tbaa !29
  %cmp2.2 = icmp slt i32 %3, %spec.select.1, !dbg !30
  %spec.select.2 = select i1 %cmp2.2, i32 %3, i32 %spec.select.1, !dbg !31
  %indvars.iv.next.2 = or i64 %indvars.iv, 3, !dbg !32
  %add.ptr.i.3 = getelementptr inbounds i32, i32* %0, i64 %indvars.iv.next.2, !dbg !27
  %4 = load i32, i32* %add.ptr.i.3, align 4, !dbg !28, !tbaa !29
  %cmp2.3 = icmp slt i32 %4, %spec.select.2, !dbg !30
  %spec.select.3 = select i1 %cmp2.3, i32 %4, i32 %spec.select.2, !dbg !31
  %indvars.iv.next.3 = add nuw nsw i64 %indvars.iv, 4, !dbg !32
  %exitcond.not.3 = icmp eq i64 %indvars.iv.next.3, 1048576, !dbg !33
  br i1 %exitcond.not.3, label %for.cond.cleanup, label %for.body, !dbg !19, !llvm.loop !34
}
```

### С автовекторизацией, без раскрутки
```LLVM
vector.body:                                      ; preds = %vector.body, %entry
  %index = phi i64 [ 0, %entry ], [ %index.next, %vector.body ], !dbg !20
  %vec.phi = phi <4 x i32> [ zeroinitializer, %entry ], [ %4, %vector.body ]
  %1 = getelementptr inbounds i32, i32* %0, i64 %index, !dbg !21
  %2 = bitcast i32* %1 to <4 x i32>*, !dbg !22
  %wide.load = load <4 x i32>, <4 x i32>* %2, align 4, !dbg !22, !tbaa !23
  %3 = icmp slt <4 x i32> %wide.load, %vec.phi, !dbg !25
  %4 = select <4 x i1> %3, <4 x i32> %wide.load, <4 x i32> %vec.phi, !dbg !26
  %index.next = add i64 %index, 4, !dbg !20
  %5 = icmp eq i64 %index.next, 1048576, !dbg !20
  br i1 %5, label %middle.block, label %vector.body, !dbg !20, !llvm.loop !27

middle.block:                                     ; preds = %vector.body
  %6 = call i32 @llvm.experimental.vector.reduce.smin.v4i32(<4 x i32> %4), !dbg !19
  %min_ = getelementptr inbounds %struct.testFunc, %struct.testFunc* %this, i64 0, i32 0, !dbg !31
  store i32 %6, i32* %min_, align 8, !dbg !32, !tbaa !33
  ret void, !dbg !36
}
```

### С автовекторизацией, c раскруткой
```LLVM
vector.body:                                      ; preds = %vector.body, %entry
  %index = phi i64 [ 0, %entry ], [ %index.next.1, %vector.body ], !dbg !20
  %vec.phi = phi <4 x i32> [ zeroinitializer, %entry ], [ %15, %vector.body ]
  %vec.phi12 = phi <4 x i32> [ zeroinitializer, %entry ], [ %16, %vector.body ]
  %1 = getelementptr inbounds i32, i32* %0, i64 %index, !dbg !21
  %2 = bitcast i32* %1 to <4 x i32>*, !dbg !22
  %wide.load = load <4 x i32>, <4 x i32>* %2, align 4, !dbg !22, !tbaa !23
  %3 = getelementptr inbounds i32, i32* %1, i64 4, !dbg !22
  %4 = bitcast i32* %3 to <4 x i32>*, !dbg !22
  %wide.load13 = load <4 x i32>, <4 x i32>* %4, align 4, !dbg !22, !tbaa !23
  %5 = icmp slt <4 x i32> %wide.load, %vec.phi, !dbg !25
  %6 = icmp slt <4 x i32> %wide.load13, %vec.phi12, !dbg !25
  %7 = select <4 x i1> %5, <4 x i32> %wide.load, <4 x i32> %vec.phi, !dbg !26
  %8 = select <4 x i1> %6, <4 x i32> %wide.load13, <4 x i32> %vec.phi12, !dbg !26
  %index.next = or i64 %index, 8, !dbg !20
  %9 = getelementptr inbounds i32, i32* %0, i64 %index.next, !dbg !21
  %10 = bitcast i32* %9 to <4 x i32>*, !dbg !22
  %wide.load.1 = load <4 x i32>, <4 x i32>* %10, align 4, !dbg !22, !tbaa !23
  %11 = getelementptr inbounds i32, i32* %9, i64 4, !dbg !22
  %12 = bitcast i32* %11 to <4 x i32>*, !dbg !22
  %wide.load13.1 = load <4 x i32>, <4 x i32>* %12, align 4, !dbg !22, !tbaa !23
  %13 = icmp slt <4 x i32> %wide.load.1, %7, !dbg !25
  %14 = icmp slt <4 x i32> %wide.load13.1, %8, !dbg !25
  %15 = select <4 x i1> %13, <4 x i32> %wide.load.1, <4 x i32> %7, !dbg !26
  %16 = select <4 x i1> %14, <4 x i32> %wide.load13.1, <4 x i32> %8, !dbg !26
  %index.next.1 = add nuw nsw i64 %index, 16, !dbg !20
  %17 = icmp eq i64 %index.next.1, 1048576, !dbg !20
  br i1 %17, label %middle.block, label %vector.body, !dbg !20, !llvm.loop !27

middle.block:                                     ; preds = %vector.body
  %rdx.minmax.cmp = icmp slt <4 x i32> %15, %16, !dbg !19
  %rdx.minmax.select = select <4 x i1> %rdx.minmax.cmp, <4 x i32> %15, <4 x i32> %16, !dbg !19
  %18 = call i32 @llvm.experimental.vector.reduce.smin.v4i32(<4 x i32> %rdx.minmax.select), !dbg !19
  %min_ = getelementptr inbounds %struct.testFunc, %struct.testFunc* %this, i64 0, i32 0, !dbg !30
  store i32 %18, i32* %min_, align 8, !dbg !31, !tbaa !32
  ret void, !dbg !35
}
```
## Анализ LLVM IR
#### Без автовекторизации, с раскруткой
В цикле легко заметны 4 одинаковые по смыслу блока. Теперь в каждой итерации цикла "умещаются четыре старых итерации." По сравнению с базовой версией число итераций уменьшилось в 4 раза.
#### С автовекторизацией, без раскрутки
На каждой итерации происходит загрузка пары из четырех элементов типа int32. Затем в этих векторах происходит поиск минимума. В конце цикла производится редукция минимума, чтобы получить одно наименьшее значение.
#### С автовекторизацией, c раскруткой
Заметно совмещение предыдущих подходов. На каждой итерации происходит выполнение нескольких модифицированных "итераций базовой версии". При этом модификация заключается в том, что итерации векторизуются по четыре элемента.
## Измерение времени исполнения
| Конфигурация | Время, мс | Ускорение |
| ------------ | --------- | --------- |
|Без автовекторизации и раскрутки|586.811|base|
|Без автовекторизации, с раскруткой|370.027|1.586|
|С автовекторизацией, без раскрутки|240.201|2.443|
|С автовекторизацией, c раскруткой|186.303|3.150|

## Анализ времени исполнения
Самой производительной оказалась конфигурация, совмещающая векторизацию и раскрутку цикла. Ускорение по сравнению с базовой версией более чем в три раза. Это следует из того, что процессор поддерживает набор инструкций SSE4.1, а именно P{MIN,MAX}{SB,UW,SD,UD} (взято с вики) - векторизация минимума. Раскрутка цикла в паре с векторизацией позволяет использовать больший объем данных на каждой итерации. Следовательно, кэш процесора содержит гораздо больше данных, необходимых в данный момент (или чуть позже). Раскрутка цикла так же приводит к потенциальному параллелизму инструкций.
