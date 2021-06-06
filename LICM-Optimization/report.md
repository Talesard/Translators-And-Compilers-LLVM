# Оптимизация инвариантов цикла

**Выполнил:** Напылов Евгений Игоревич, 381806-2

**Содержание**
- [Оптимизация инвариантов цикла](#оптимизация-инвариантов-цикла)
  - [Конфигурация](#конфигурация)
  - [Бенчмарк](#бенчмарк)
  - [Анализ результатов](#анализ-результатов)
  - [Приложение](#приложение)
    - [licm_5.cpp](#licm_5cpp)
      - [SRC](#src)
      - [LLVM IR -O1 без оптимизации инвариантов](#llvm-ir--o1-без-оптимизации-инвариантов)
      - [LLVM IR -O1 с оптимизацией инвариантов](#llvm-ir--o1-с-оптимизацией-инвариантов)
      - [Разница:](#разница)
    - [licm_10.cpp](#licm_10cpp)
        - [SRC](#src-1)
      - [LLVM IR -O1 без оптимизации инвариантов](#llvm-ir--o1-без-оптимизации-инвариантов-1)
      - [LLVM IR -O1 с оптимизацией инвариантов](#llvm-ir--o1-с-оптимизацией-инвариантов-1)
      - [Разница:](#разница-1)
    - [licm_20.cpp](#licm_20cpp)
      - [SRC](#src-2)
      - [LLVM IR -O1 без оптимизации инвариантов](#llvm-ir--o1-без-оптимизации-инвариантов-2)
      - [LLVM IR -O1 с оптимизацией инвариантов](#llvm-ir--o1-с-оптимизацией-инвариантов-2)
      - [Разница:](#разница-2)
    - [licm_div_5.cpp](#licm_div_5cpp)
      - [SRC](#src-3)
      - [LLVM IR -O1 без оптимизации инвариантов](#llvm-ir--o1-без-оптимизации-инвариантов-3)
      - [LLVM IR -O1 с оптимизацией инвариантов](#llvm-ir--o1-с-оптимизацией-инвариантов-3)
      - [Разница:](#разница-3)
    - [licm_div_10.cpp](#licm_div_10cpp)
      - [SRC](#src-4)
      - [LLVM IR -O1 без оптимизации инвариантов](#llvm-ir--o1-без-оптимизации-инвариантов-4)
      - [LLVM IR -O1 с оптимизацией инвариантов](#llvm-ir--o1-с-оптимизацией-инвариантов-4)
      - [Разница:](#разница-4)
    - [licm_div_20.cpp](#licm_div_20cpp)
      - [SRC](#src-5)
      - [LLVM IR -O1 без оптимизации инвариантов](#llvm-ir--o1-без-оптимизации-инвариантов-5)
      - [LLVM IR -O1 с оптимизацией инвариантов](#llvm-ir--o1-с-оптимизацией-инвариантов-5)
      - [Разница:](#разница-5)
    - [Полный лог бенчмарка](#полный-лог-бенчмарка)


## Конфигурация

**CPU:** Intel® Core™ i5-8265U  (lock 1,6 GHz)   
**Instruction set:**  Intel® SSE4.1, Intel® SSE4.2, Intel® AVX2  
**RAM:** 8GB DDR4  
**OS:** Ubuntu 18.04.5 LTS x86_64  
**KERNEL:** 5.4.0-73-generic

## Бенчмарк
| File | -o0, sec| -o1, sec | -o1 no licm, sec|
| ------------ | --------- | --------- | ---------|
|licm_5.cpp|3,04669|1,701383|1,7211|
|licm_10.cpp|2,792924|1,55242|1,564567|
|licm_20.cpp|2,709971|1,66211|1,68170|
|licm_div_5.cpp|2,326813|0,428037|2,261826|
|licm_div_10.cpp|4,526460|0,776558|4,46638|
|licm_div_20.cpp|8,92722|1,66797|8,853094|    


## Анализ результатов
Отличие конфигурации -o1 и -o1 no licm заключается в том, что оптимизация инвариантов убирает из цикла инструкции add и sdiv, которые на каждой итерации дают один и тот же результат, т.е. они инвариантны. Они помещаются в специальный блок, который выполняется один раз перед началом цикла. В цикле остается только инструкция store, которая присваивает вычисленные значения.    

Значения в функции main без оптимизации вычисляются во время выполнения программы. В версией с оптимизацией мне не удалось найти код, который бы был на это похож. Следовательно, значения в main были получены во время компиляции программы.   

Оптимизация инвариантого кода со сложением чисел практически не дает прироста по сравнению с огромной разницей в делении. Вероятно это связано с тем, что операция сложения является простой по сравнению с делением.   

Для деления время работы без оптимизации практически равно версии -o0. Это следует из того, что цикл содержит чрезвычайно много инвариантого кода, другие оптимизации на фоне этого практически не добавляют скорость.

Ниже в приложении находится LLVM IR для версий -o1 и -o1 без licm (-o0 в архиве с остальными). Так же там находится лог бенчмарка.

## Приложение
### licm_5.cpp
#### SRC
```C++
void func(int a1, int a2, int a3, int a4, int a5, int a6, int a7, int a8, int a9, int a10, int a11, int a12, int a13, int a14, int a15, int a16){
    int i;
    for (i = 0; i < 4 * SIZE; i++){
        b1[i]=a1+a2;
        b2[i]=a2+a3;
        b3[i]=a3+a4;
        b4[i]=a4+a5;
        b5[i]=a5+a6;
    }
}
```

#### LLVM IR -O1 без оптимизации инвариантов
```LLVM
for.body:                                         ; preds = %for.body, %entry
  %indvars.iv = phi i64 [ 0, %entry ], [ %indvars.iv.next, %for.body ]
  %add = add nsw i32 %a2, %a1
  %arrayidx = getelementptr inbounds [100000 x i32], [100000 x i32]* @b1, i64 0, i64 %indvars.iv
  store i32 %add, i32* %arrayidx, align 4, !tbaa !2
  %add1 = add nsw i32 %a3, %a2
  %arrayidx3 = getelementptr inbounds [100000 x i32], [100000 x i32]* @b2, i64 0, i64 %indvars.iv
  store i32 %add1, i32* %arrayidx3, align 4, !tbaa !2
  %add4 = add nsw i32 %a4, %a3
  %arrayidx6 = getelementptr inbounds [100000 x i32], [100000 x i32]* @b3, i64 0, i64 %indvars.iv
  store i32 %add4, i32* %arrayidx6, align 4, !tbaa !2
  %add7 = add nsw i32 %a5, %a4
  %arrayidx9 = getelementptr inbounds [100000 x i32], [100000 x i32]* @b4, i64 0, i64 %indvars.iv
  store i32 %add7, i32* %arrayidx9, align 4, !tbaa !2
  %add10 = add nsw i32 %a6, %a5
  %arrayidx12 = getelementptr inbounds [100000 x i32], [100000 x i32]* @b5, i64 0, i64 %indvars.iv
  store i32 %add10, i32* %arrayidx12, align 4, !tbaa !2
  %indvars.iv.next = add nuw nsw i64 %indvars.iv, 1
  %exitcond.not = icmp eq i64 %indvars.iv.next, 400000
  br i1 %exitcond.not, label %for.end, label %for.body, !llvm.loop !6
```

#### LLVM IR -O1 с оптимизацией инвариантов
```LLVM
entry:
  %add = add nsw i32 %a2, %a1
  %add1 = add nsw i32 %a3, %a2
  %add4 = add nsw i32 %a4, %a3
  %add7 = add nsw i32 %a5, %a4
  %add10 = add nsw i32 %a6, %a5
  br label %for.body

for.body:                                         ; preds = %for.body, %entry
  %indvars.iv = phi i64 [ 0, %entry ], [ %indvars.iv.next, %for.body ]
  %arrayidx = getelementptr inbounds [100000 x i32], [100000 x i32]* @b1, i64 0, i64 %indvars.iv
  store i32 %add, i32* %arrayidx, align 4, !tbaa !2
  %arrayidx3 = getelementptr inbounds [100000 x i32], [100000 x i32]* @b2, i64 0, i64 %indvars.iv
  store i32 %add1, i32* %arrayidx3, align 4, !tbaa !2
  %arrayidx6 = getelementptr inbounds [100000 x i32], [100000 x i32]* @b3, i64 0, i64 %indvars.iv
  store i32 %add4, i32* %arrayidx6, align 4, !tbaa !2
  %arrayidx9 = getelementptr inbounds [100000 x i32], [100000 x i32]* @b4, i64 0, i64 %indvars.iv
  store i32 %add7, i32* %arrayidx9, align 4, !tbaa !2
  %arrayidx12 = getelementptr inbounds [100000 x i32], [100000 x i32]* @b5, i64 0, i64 %indvars.iv
  store i32 %add10, i32* %arrayidx12, align 4, !tbaa !2
  %indvars.iv.next = add nuw nsw i64 %indvars.iv, 1
  %exitcond.not = icmp eq i64 %indvars.iv.next, 400000
  br i1 %exitcond.not, label %for.end, label %for.body, !llvm.loop !6
```
#### Разница:
Без оптимизации инвариантов в цикле выполняются 5 инструкций add без учета счетчика. С оптимизацией они вынесены в блок до начала цикла. В цикле остались инструкции store для этих сумм.

### licm_10.cpp
##### SRC
```C++
void func(int a1, int a2, int a3, int a4, int a5, int a6, int a7, int a8, int a9, int a10, int a11, int a12, int a13, int a14, int a15, int a16){
    int i;
    for (i = 0; i < 2 * SIZE; i++){
        b1[i]=a1+a2;
        b2[i]=a2+a3;
        b3[i]=a3+a4;
        b4[i]=a4+a5;
        b5[i]=a5+a6;
        b6[i]=a6+a7;
        b7[i]=a7+a8;
        b8[i]=a8+a9;
        b9[i]=a9+a10;
        b10[i]=a10+a11;
    }
}
```

#### LLVM IR -O1 без оптимизации инвариантов
```LLVM
for.body:                                         ; preds = %for.body, %entry
  %indvars.iv = phi i64 [ 0, %entry ], [ %indvars.iv.next, %for.body ]
  %add = add nsw i32 %a2, %a1
  %arrayidx = getelementptr inbounds [100000 x i32], [100000 x i32]* @b1, i64 0, i64 %indvars.iv
  store i32 %add, i32* %arrayidx, align 4, !tbaa !2
  %add1 = add nsw i32 %a3, %a2
  %arrayidx3 = getelementptr inbounds [100000 x i32], [100000 x i32]* @b2, i64 0, i64 %indvars.iv
  store i32 %add1, i32* %arrayidx3, align 4, !tbaa !2
  %add4 = add nsw i32 %a4, %a3
  %arrayidx6 = getelementptr inbounds [100000 x i32], [100000 x i32]* @b3, i64 0, i64 %indvars.iv
  store i32 %add4, i32* %arrayidx6, align 4, !tbaa !2
  %add7 = add nsw i32 %a5, %a4
  %arrayidx9 = getelementptr inbounds [100000 x i32], [100000 x i32]* @b4, i64 0, i64 %indvars.iv
  store i32 %add7, i32* %arrayidx9, align 4, !tbaa !2
  %add10 = add nsw i32 %a6, %a5
  %arrayidx12 = getelementptr inbounds [100000 x i32], [100000 x i32]* @b5, i64 0, i64 %indvars.iv
  store i32 %add10, i32* %arrayidx12, align 4, !tbaa !2
  %add13 = add nsw i32 %a7, %a6
  %arrayidx15 = getelementptr inbounds [100000 x i32], [100000 x i32]* @b6, i64 0, i64 %indvars.iv
  store i32 %add13, i32* %arrayidx15, align 4, !tbaa !2
  %add16 = add nsw i32 %a8, %a7
  %arrayidx18 = getelementptr inbounds [100000 x i32], [100000 x i32]* @b7, i64 0, i64 %indvars.iv
  store i32 %add16, i32* %arrayidx18, align 4, !tbaa !2
  %add19 = add nsw i32 %a9, %a8
  %arrayidx21 = getelementptr inbounds [100000 x i32], [100000 x i32]* @b8, i64 0, i64 %indvars.iv
  store i32 %add19, i32* %arrayidx21, align 4, !tbaa !2
  %add22 = add nsw i32 %a10, %a9
  %arrayidx24 = getelementptr inbounds [100000 x i32], [100000 x i32]* @b9, i64 0, i64 %indvars.iv
  store i32 %add22, i32* %arrayidx24, align 4, !tbaa !2
  %add25 = add nsw i32 %a11, %a10
  %arrayidx27 = getelementptr inbounds [100000 x i32], [100000 x i32]* @b10, i64 0, i64 %indvars.iv
  store i32 %add25, i32* %arrayidx27, align 4, !tbaa !2
  %indvars.iv.next = add nuw nsw i64 %indvars.iv, 1
  %exitcond.not = icmp eq i64 %indvars.iv.next, 200000
  br i1 %exitcond.not, label %for.end, label %for.body, !llvm.loop !6
```
#### LLVM IR -O1 с оптимизацией инвариантов
```LLVM
entry:
  %add = add nsw i32 %a2, %a1
  %add1 = add nsw i32 %a3, %a2
  %add4 = add nsw i32 %a4, %a3
  %add7 = add nsw i32 %a5, %a4
  %add10 = add nsw i32 %a6, %a5
  %add13 = add nsw i32 %a7, %a6
  %add16 = add nsw i32 %a8, %a7
  %add19 = add nsw i32 %a9, %a8
  %add22 = add nsw i32 %a10, %a9
  %add25 = add nsw i32 %a11, %a10
  br label %for.body

for.body:                                         ; preds = %for.body, %entry
  %indvars.iv = phi i64 [ 0, %entry ], [ %indvars.iv.next, %for.body ]
  %arrayidx = getelementptr inbounds [100000 x i32], [100000 x i32]* @b1, i64 0, i64 %indvars.iv
  store i32 %add, i32* %arrayidx, align 4, !tbaa !2
  %arrayidx3 = getelementptr inbounds [100000 x i32], [100000 x i32]* @b2, i64 0, i64 %indvars.iv
  store i32 %add1, i32* %arrayidx3, align 4, !tbaa !2
  %arrayidx6 = getelementptr inbounds [100000 x i32], [100000 x i32]* @b3, i64 0, i64 %indvars.iv
  store i32 %add4, i32* %arrayidx6, align 4, !tbaa !2
  %arrayidx9 = getelementptr inbounds [100000 x i32], [100000 x i32]* @b4, i64 0, i64 %indvars.iv
  store i32 %add7, i32* %arrayidx9, align 4, !tbaa !2
  %arrayidx12 = getelementptr inbounds [100000 x i32], [100000 x i32]* @b5, i64 0, i64 %indvars.iv
  store i32 %add10, i32* %arrayidx12, align 4, !tbaa !2
  %arrayidx15 = getelementptr inbounds [100000 x i32], [100000 x i32]* @b6, i64 0, i64 %indvars.iv
  store i32 %add13, i32* %arrayidx15, align 4, !tbaa !2
  %arrayidx18 = getelementptr inbounds [100000 x i32], [100000 x i32]* @b7, i64 0, i64 %indvars.iv
  store i32 %add16, i32* %arrayidx18, align 4, !tbaa !2
  %arrayidx21 = getelementptr inbounds [100000 x i32], [100000 x i32]* @b8, i64 0, i64 %indvars.iv
  store i32 %add19, i32* %arrayidx21, align 4, !tbaa !2
  %arrayidx24 = getelementptr inbounds [100000 x i32], [100000 x i32]* @b9, i64 0, i64 %indvars.iv
  store i32 %add22, i32* %arrayidx24, align 4, !tbaa !2
  %arrayidx27 = getelementptr inbounds [100000 x i32], [100000 x i32]* @b10, i64 0, i64 %indvars.iv
  store i32 %add25, i32* %arrayidx27, align 4, !tbaa !2
  %indvars.iv.next = add nuw nsw i64 %indvars.iv, 1
  %exitcond.not = icmp eq i64 %indvars.iv.next, 200000
  br i1 %exitcond.not, label %for.end, label %for.body, !llvm.loop !6
```
#### Разница:
Без оптимизации инвариантов в цикле выполняются 10 инструкций add. С оптимизацией они вынесены в блок до начала цикла. В цикле остались инструкции store для этих сумм.


### licm_20.cpp
#### SRC
```C++
void func(int a1, int a2, int a3, int a4, int a5, int a6, int a7, int a8, int a9, int a10, int a11, int a12, int a13, int a14, int a15, int a16){
    int i;
    for (i = 0; i < SIZE; i++){
        b1[i]=a1+a2;
        b2[i]=a2+a3;
        b3[i]=a3+a4;
        b4[i]=a4+a5;
        b5[i]=a5+a6;
        b6[i]=a6+a7;
        b7[i]=a7+a8;
        b8[i]=a8+a9;
        b9[i]=a9+a10;
        b10[i]=a10+a11;
        b11[i]=a11+a12;
        b12[i]=a12+a13;
        b13[i]=a13+a14;
        b14[i]=a14+a15;
        b15[i]=a15+a16;
        b16[i]=a16+a1;
        b17[i]=a16+a2;
        b18[i]=a16+a3;
        b19[i]=a16+a4;
        b20[i]=a16+a5;
    }
}
```

#### LLVM IR -O1 без оптимизации инвариантов
```LLVM
for.body:                                         ; preds = %for.body, %entry
  %indvars.iv = phi i64 [ 0, %entry ], [ %indvars.iv.next, %for.body ]
  %add = add nsw i32 %a2, %a1
  %arrayidx = getelementptr inbounds [100000 x i32], [100000 x i32]* @b1, i64 0, i64 %indvars.iv
  store i32 %add, i32* %arrayidx, align 4, !tbaa !2
  %add1 = add nsw i32 %a3, %a2
  %arrayidx3 = getelementptr inbounds [100000 x i32], [100000 x i32]* @b2, i64 0, i64 %indvars.iv
  store i32 %add1, i32* %arrayidx3, align 4, !tbaa !2
  %add4 = add nsw i32 %a4, %a3
  %arrayidx6 = getelementptr inbounds [100000 x i32], [100000 x i32]* @b3, i64 0, i64 %indvars.iv
  store i32 %add4, i32* %arrayidx6, align 4, !tbaa !2
  %add7 = add nsw i32 %a5, %a4
  %arrayidx9 = getelementptr inbounds [100000 x i32], [100000 x i32]* @b4, i64 0, i64 %indvars.iv
  store i32 %add7, i32* %arrayidx9, align 4, !tbaa !2
  %add10 = add nsw i32 %a6, %a5
  %arrayidx12 = getelementptr inbounds [100000 x i32], [100000 x i32]* @b5, i64 0, i64 %indvars.iv
  store i32 %add10, i32* %arrayidx12, align 4, !tbaa !2
  %add13 = add nsw i32 %a7, %a6
  %arrayidx15 = getelementptr inbounds [100000 x i32], [100000 x i32]* @b6, i64 0, i64 %indvars.iv
  store i32 %add13, i32* %arrayidx15, align 4, !tbaa !2
  %add16 = add nsw i32 %a8, %a7
  %arrayidx18 = getelementptr inbounds [100000 x i32], [100000 x i32]* @b7, i64 0, i64 %indvars.iv
  store i32 %add16, i32* %arrayidx18, align 4, !tbaa !2
  %add19 = add nsw i32 %a9, %a8
  %arrayidx21 = getelementptr inbounds [100000 x i32], [100000 x i32]* @b8, i64 0, i64 %indvars.iv
  store i32 %add19, i32* %arrayidx21, align 4, !tbaa !2
  %add22 = add nsw i32 %a10, %a9
  %arrayidx24 = getelementptr inbounds [100000 x i32], [100000 x i32]* @b9, i64 0, i64 %indvars.iv
  store i32 %add22, i32* %arrayidx24, align 4, !tbaa !2
  %add25 = add nsw i32 %a11, %a10
  %arrayidx27 = getelementptr inbounds [100000 x i32], [100000 x i32]* @b10, i64 0, i64 %indvars.iv
  store i32 %add25, i32* %arrayidx27, align 4, !tbaa !2
  %add28 = add nsw i32 %a12, %a11
  %arrayidx30 = getelementptr inbounds [100000 x i32], [100000 x i32]* @b11, i64 0, i64 %indvars.iv
  store i32 %add28, i32* %arrayidx30, align 4, !tbaa !2
  %add31 = add nsw i32 %a13, %a12
  %arrayidx33 = getelementptr inbounds [100000 x i32], [100000 x i32]* @b12, i64 0, i64 %indvars.iv
  store i32 %add31, i32* %arrayidx33, align 4, !tbaa !2
  %add34 = add nsw i32 %a14, %a13
  %arrayidx36 = getelementptr inbounds [100000 x i32], [100000 x i32]* @b13, i64 0, i64 %indvars.iv
  store i32 %add34, i32* %arrayidx36, align 4, !tbaa !2
  %add37 = add nsw i32 %a15, %a14
  %arrayidx39 = getelementptr inbounds [100000 x i32], [100000 x i32]* @b14, i64 0, i64 %indvars.iv
  store i32 %add37, i32* %arrayidx39, align 4, !tbaa !2
  %add40 = add nsw i32 %a16, %a15
  %arrayidx42 = getelementptr inbounds [100000 x i32], [100000 x i32]* @b15, i64 0, i64 %indvars.iv
  store i32 %add40, i32* %arrayidx42, align 4, !tbaa !2
  %add43 = add nsw i32 %a16, %a1
  %arrayidx45 = getelementptr inbounds [100000 x i32], [100000 x i32]* @b16, i64 0, i64 %indvars.iv
  store i32 %add43, i32* %arrayidx45, align 4, !tbaa !2
  %add46 = add nsw i32 %a16, %a2
  %arrayidx48 = getelementptr inbounds [100000 x i32], [100000 x i32]* @b17, i64 0, i64 %indvars.iv
  store i32 %add46, i32* %arrayidx48, align 4, !tbaa !2
  %add49 = add nsw i32 %a16, %a3
  %arrayidx51 = getelementptr inbounds [100000 x i32], [100000 x i32]* @b18, i64 0, i64 %indvars.iv
  store i32 %add49, i32* %arrayidx51, align 4, !tbaa !2
  %add52 = add nsw i32 %a16, %a4
  %arrayidx54 = getelementptr inbounds [100000 x i32], [100000 x i32]* @b19, i64 0, i64 %indvars.iv
  store i32 %add52, i32* %arrayidx54, align 4, !tbaa !2
  %add55 = add nsw i32 %a16, %a5
  %arrayidx57 = getelementptr inbounds [100000 x i32], [100000 x i32]* @b20, i64 0, i64 %indvars.iv
  store i32 %add55, i32* %arrayidx57, align 4, !tbaa !2
  %indvars.iv.next = add nuw nsw i64 %indvars.iv, 1
  %exitcond.not = icmp eq i64 %indvars.iv.next, 100000
  br i1 %exitcond.not, label %for.end, label %for.body, !llvm.loop !6
```
#### LLVM IR -O1 с оптимизацией инвариантов
```LLVM
entry:
  %add = add nsw i32 %a2, %a1
  %add1 = add nsw i32 %a3, %a2
  %add4 = add nsw i32 %a4, %a3
  %add7 = add nsw i32 %a5, %a4
  %add10 = add nsw i32 %a6, %a5
  %add13 = add nsw i32 %a7, %a6
  %add16 = add nsw i32 %a8, %a7
  %add19 = add nsw i32 %a9, %a8
  %add22 = add nsw i32 %a10, %a9
  %add25 = add nsw i32 %a11, %a10
  %add28 = add nsw i32 %a12, %a11
  %add31 = add nsw i32 %a13, %a12
  %add34 = add nsw i32 %a14, %a13
  %add37 = add nsw i32 %a15, %a14
  %add40 = add nsw i32 %a16, %a15
  %add43 = add nsw i32 %a16, %a1
  %add46 = add nsw i32 %a16, %a2
  %add49 = add nsw i32 %a16, %a3
  %add52 = add nsw i32 %a16, %a4
  %add55 = add nsw i32 %a16, %a5
  br label %for.body

for.body:                                         ; preds = %for.body, %entry
  %indvars.iv = phi i64 [ 0, %entry ], [ %indvars.iv.next, %for.body ]
  %arrayidx = getelementptr inbounds [100000 x i32], [100000 x i32]* @b1, i64 0, i64 %indvars.iv
  store i32 %add, i32* %arrayidx, align 4, !tbaa !2
  %arrayidx3 = getelementptr inbounds [100000 x i32], [100000 x i32]* @b2, i64 0, i64 %indvars.iv
  store i32 %add1, i32* %arrayidx3, align 4, !tbaa !2
  %arrayidx6 = getelementptr inbounds [100000 x i32], [100000 x i32]* @b3, i64 0, i64 %indvars.iv
  store i32 %add4, i32* %arrayidx6, align 4, !tbaa !2
  %arrayidx9 = getelementptr inbounds [100000 x i32], [100000 x i32]* @b4, i64 0, i64 %indvars.iv
  store i32 %add7, i32* %arrayidx9, align 4, !tbaa !2
  %arrayidx12 = getelementptr inbounds [100000 x i32], [100000 x i32]* @b5, i64 0, i64 %indvars.iv
  store i32 %add10, i32* %arrayidx12, align 4, !tbaa !2
  %arrayidx15 = getelementptr inbounds [100000 x i32], [100000 x i32]* @b6, i64 0, i64 %indvars.iv
  store i32 %add13, i32* %arrayidx15, align 4, !tbaa !2
  %arrayidx18 = getelementptr inbounds [100000 x i32], [100000 x i32]* @b7, i64 0, i64 %indvars.iv
  store i32 %add16, i32* %arrayidx18, align 4, !tbaa !2
  %arrayidx21 = getelementptr inbounds [100000 x i32], [100000 x i32]* @b8, i64 0, i64 %indvars.iv
  store i32 %add19, i32* %arrayidx21, align 4, !tbaa !2
  %arrayidx24 = getelementptr inbounds [100000 x i32], [100000 x i32]* @b9, i64 0, i64 %indvars.iv
  store i32 %add22, i32* %arrayidx24, align 4, !tbaa !2
  %arrayidx27 = getelementptr inbounds [100000 x i32], [100000 x i32]* @b10, i64 0, i64 %indvars.iv
  store i32 %add25, i32* %arrayidx27, align 4, !tbaa !2
  %arrayidx30 = getelementptr inbounds [100000 x i32], [100000 x i32]* @b11, i64 0, i64 %indvars.iv
  store i32 %add28, i32* %arrayidx30, align 4, !tbaa !2
  %arrayidx33 = getelementptr inbounds [100000 x i32], [100000 x i32]* @b12, i64 0, i64 %indvars.iv
  store i32 %add31, i32* %arrayidx33, align 4, !tbaa !2
  %arrayidx36 = getelementptr inbounds [100000 x i32], [100000 x i32]* @b13, i64 0, i64 %indvars.iv
  store i32 %add34, i32* %arrayidx36, align 4, !tbaa !2
  %arrayidx39 = getelementptr inbounds [100000 x i32], [100000 x i32]* @b14, i64 0, i64 %indvars.iv
  store i32 %add37, i32* %arrayidx39, align 4, !tbaa !2
  %arrayidx42 = getelementptr inbounds [100000 x i32], [100000 x i32]* @b15, i64 0, i64 %indvars.iv
  store i32 %add40, i32* %arrayidx42, align 4, !tbaa !2
  %arrayidx45 = getelementptr inbounds [100000 x i32], [100000 x i32]* @b16, i64 0, i64 %indvars.iv
  store i32 %add43, i32* %arrayidx45, align 4, !tbaa !2
  %arrayidx48 = getelementptr inbounds [100000 x i32], [100000 x i32]* @b17, i64 0, i64 %indvars.iv
  store i32 %add46, i32* %arrayidx48, align 4, !tbaa !2
  %arrayidx51 = getelementptr inbounds [100000 x i32], [100000 x i32]* @b18, i64 0, i64 %indvars.iv
  store i32 %add49, i32* %arrayidx51, align 4, !tbaa !2
  %arrayidx54 = getelementptr inbounds [100000 x i32], [100000 x i32]* @b19, i64 0, i64 %indvars.iv
  store i32 %add52, i32* %arrayidx54, align 4, !tbaa !2
  %arrayidx57 = getelementptr inbounds [100000 x i32], [100000 x i32]* @b20, i64 0, i64 %indvars.iv
  store i32 %add55, i32* %arrayidx57, align 4, !tbaa !2
  %indvars.iv.next = add nuw nsw i64 %indvars.iv, 1
  %exitcond.not = icmp eq i64 %indvars.iv.next, 100000
  br i1 %exitcond.not, label %for.end, label %for.body, !llvm.loop !6
```
#### Разница:
Без оптимизации инвариантов в цикле выполняются 20 инструкций add. С оптимизацией они вынесены в блок до начала цикла. В цикле остались инструкции store для этих сумм.

### licm_div_5.cpp
#### SRC
```C++
void func(int a1, int a2, int a3, int a4, int a5, int a6, int a7, int a8, int a9, int a10, int a11, int a12, int a13, int a14, int a15, int a16){
    int i;
    for (i = 1; i < SIZE; i++){
        b1[i]=a1/a2;
        b2[i]=a2/a3;
        b3[i]=a3/a4;
        b4[i]=a4/a5;
        b5[i]=a5/a6;
    }
}
```

#### LLVM IR -O1 без оптимизации инвариантов
```LLVM
for.body:                                         ; preds = %for.body, %entry
  %indvars.iv = phi i64 [ 1, %entry ], [ %indvars.iv.next, %for.body ]
  %div = sdiv i32 %a1, %a2
  %arrayidx = getelementptr inbounds [100000 x i32], [100000 x i32]* @b1, i64 0, i64 %indvars.iv
  store i32 %div, i32* %arrayidx, align 4, !tbaa !2
  %div1 = sdiv i32 %a2, %a3
  %arrayidx3 = getelementptr inbounds [100000 x i32], [100000 x i32]* @b2, i64 0, i64 %indvars.iv
  store i32 %div1, i32* %arrayidx3, align 4, !tbaa !2
  %div4 = sdiv i32 %a3, %a4
  %arrayidx6 = getelementptr inbounds [100000 x i32], [100000 x i32]* @b3, i64 0, i64 %indvars.iv
  store i32 %div4, i32* %arrayidx6, align 4, !tbaa !2
  %div7 = sdiv i32 %a4, %a5
  %arrayidx9 = getelementptr inbounds [100000 x i32], [100000 x i32]* @b4, i64 0, i64 %indvars.iv
  store i32 %div7, i32* %arrayidx9, align 4, !tbaa !2
  %div10 = sdiv i32 %a5, %a6
  %arrayidx12 = getelementptr inbounds [100000 x i32], [100000 x i32]* @b5, i64 0, i64 %indvars.iv
  store i32 %div10, i32* %arrayidx12, align 4, !tbaa !2
  %indvars.iv.next = add nuw nsw i64 %indvars.iv, 1
  %exitcond.not = icmp eq i64 %indvars.iv.next, 100000
  br i1 %exitcond.not, label %for.end, label %for.body, !llvm.loop !6
```
#### LLVM IR -O1 с оптимизацией инвариантов
```LLVM
entry:
  %div = sdiv i32 %a1, %a2
  %div1 = sdiv i32 %a2, %a3
  %div4 = sdiv i32 %a3, %a4
  %div7 = sdiv i32 %a4, %a5
  %div10 = sdiv i32 %a5, %a6
  br label %for.body

for.body:                                         ; preds = %for.body, %entry
  %indvars.iv = phi i64 [ 1, %entry ], [ %indvars.iv.next, %for.body ]
  %arrayidx = getelementptr inbounds [100000 x i32], [100000 x i32]* @b1, i64 0, i64 %indvars.iv
  store i32 %div, i32* %arrayidx, align 4, !tbaa !2
  %arrayidx3 = getelementptr inbounds [100000 x i32], [100000 x i32]* @b2, i64 0, i64 %indvars.iv
  store i32 %div1, i32* %arrayidx3, align 4, !tbaa !2
  %arrayidx6 = getelementptr inbounds [100000 x i32], [100000 x i32]* @b3, i64 0, i64 %indvars.iv
  store i32 %div4, i32* %arrayidx6, align 4, !tbaa !2
  %arrayidx9 = getelementptr inbounds [100000 x i32], [100000 x i32]* @b4, i64 0, i64 %indvars.iv
  store i32 %div7, i32* %arrayidx9, align 4, !tbaa !2
  %arrayidx12 = getelementptr inbounds [100000 x i32], [100000 x i32]* @b5, i64 0, i64 %indvars.iv
  store i32 %div10, i32* %arrayidx12, align 4, !tbaa !2
  %indvars.iv.next = add nuw nsw i64 %indvars.iv, 1
  %exitcond.not = icmp eq i64 %indvars.iv.next, 100000
  br i1 %exitcond.not, label %for.end, label %for.body, !llvm.loop !6
```
#### Разница:
Без оптимизации инвариантов в цикле выполняются 5 инструкций sdiv. С оптимизацией они вынесены в блок до начала цикла. В цикле остались инструкции store для этих данных.

### licm_div_10.cpp
#### SRC
```C++
void func(int a1, int a2, int a3, int a4, int a5, int a6, int a7, int a8, int a9, int a10, int a11, int a12, int a13, int a14, int a15, int a16){
    int i;
    for (i = 1; i < SIZE; i++){
        b1[i]=a1/a2;
        b2[i]=a2/a3;
        b3[i]=a3/a4;
        b4[i]=a4/a5;
        b5[i]=a5/a6;
        b6[i]=a6/a7;
        b7[i]=a7/a8;
        b8[i]=a8/a9;
        b9[i]=a9/a10;
        b10[i]=a10/a11;
    }
}
```

#### LLVM IR -O1 без оптимизации инвариантов
```LLVM
for.body:                                         ; preds = %for.body, %entry
  %indvars.iv = phi i64 [ 1, %entry ], [ %indvars.iv.next, %for.body ]
  %div = sdiv i32 %a1, %a2
  %arrayidx = getelementptr inbounds [100000 x i32], [100000 x i32]* @b1, i64 0, i64 %indvars.iv
  store i32 %div, i32* %arrayidx, align 4, !tbaa !2
  %div1 = sdiv i32 %a2, %a3
  %arrayidx3 = getelementptr inbounds [100000 x i32], [100000 x i32]* @b2, i64 0, i64 %indvars.iv
  store i32 %div1, i32* %arrayidx3, align 4, !tbaa !2
  %div4 = sdiv i32 %a3, %a4
  %arrayidx6 = getelementptr inbounds [100000 x i32], [100000 x i32]* @b3, i64 0, i64 %indvars.iv
  store i32 %div4, i32* %arrayidx6, align 4, !tbaa !2
  %div7 = sdiv i32 %a4, %a5
  %arrayidx9 = getelementptr inbounds [100000 x i32], [100000 x i32]* @b4, i64 0, i64 %indvars.iv
  store i32 %div7, i32* %arrayidx9, align 4, !tbaa !2
  %div10 = sdiv i32 %a5, %a6
  %arrayidx12 = getelementptr inbounds [100000 x i32], [100000 x i32]* @b5, i64 0, i64 %indvars.iv
  store i32 %div10, i32* %arrayidx12, align 4, !tbaa !2
  %div13 = sdiv i32 %a6, %a7
  %arrayidx15 = getelementptr inbounds [100000 x i32], [100000 x i32]* @b6, i64 0, i64 %indvars.iv
  store i32 %div13, i32* %arrayidx15, align 4, !tbaa !2
  %div16 = sdiv i32 %a7, %a8
  %arrayidx18 = getelementptr inbounds [100000 x i32], [100000 x i32]* @b7, i64 0, i64 %indvars.iv
  store i32 %div16, i32* %arrayidx18, align 4, !tbaa !2
  %div19 = sdiv i32 %a8, %a9
  %arrayidx21 = getelementptr inbounds [100000 x i32], [100000 x i32]* @b8, i64 0, i64 %indvars.iv
  store i32 %div19, i32* %arrayidx21, align 4, !tbaa !2
  %div22 = sdiv i32 %a9, %a10
  %arrayidx24 = getelementptr inbounds [100000 x i32], [100000 x i32]* @b9, i64 0, i64 %indvars.iv
  store i32 %div22, i32* %arrayidx24, align 4, !tbaa !2
  %div25 = sdiv i32 %a10, %a11
  %arrayidx27 = getelementptr inbounds [100000 x i32], [100000 x i32]* @b10, i64 0, i64 %indvars.iv
  store i32 %div25, i32* %arrayidx27, align 4, !tbaa !2
  %indvars.iv.next = add nuw nsw i64 %indvars.iv, 1
  %exitcond.not = icmp eq i64 %indvars.iv.next, 100000
  br i1 %exitcond.not, label %for.end, label %for.body, !llvm.loop !6
```
#### LLVM IR -O1 с оптимизацией инвариантов
```LLVM
entry:
  %div = sdiv i32 %a1, %a2
  %div1 = sdiv i32 %a2, %a3
  %div4 = sdiv i32 %a3, %a4
  %div7 = sdiv i32 %a4, %a5
  %div10 = sdiv i32 %a5, %a6
  %div13 = sdiv i32 %a6, %a7
  %div16 = sdiv i32 %a7, %a8
  %div19 = sdiv i32 %a8, %a9
  %div22 = sdiv i32 %a9, %a10
  %div25 = sdiv i32 %a10, %a11
  br label %for.body

for.body:                                         ; preds = %for.body, %entry
  %indvars.iv = phi i64 [ 1, %entry ], [ %indvars.iv.next, %for.body ]
  %arrayidx = getelementptr inbounds [100000 x i32], [100000 x i32]* @b1, i64 0, i64 %indvars.iv
  store i32 %div, i32* %arrayidx, align 4, !tbaa !2
  %arrayidx3 = getelementptr inbounds [100000 x i32], [100000 x i32]* @b2, i64 0, i64 %indvars.iv
  store i32 %div1, i32* %arrayidx3, align 4, !tbaa !2
  %arrayidx6 = getelementptr inbounds [100000 x i32], [100000 x i32]* @b3, i64 0, i64 %indvars.iv
  store i32 %div4, i32* %arrayidx6, align 4, !tbaa !2
  %arrayidx9 = getelementptr inbounds [100000 x i32], [100000 x i32]* @b4, i64 0, i64 %indvars.iv
  store i32 %div7, i32* %arrayidx9, align 4, !tbaa !2
  %arrayidx12 = getelementptr inbounds [100000 x i32], [100000 x i32]* @b5, i64 0, i64 %indvars.iv
  store i32 %div10, i32* %arrayidx12, align 4, !tbaa !2
  %arrayidx15 = getelementptr inbounds [100000 x i32], [100000 x i32]* @b6, i64 0, i64 %indvars.iv
  store i32 %div13, i32* %arrayidx15, align 4, !tbaa !2
  %arrayidx18 = getelementptr inbounds [100000 x i32], [100000 x i32]* @b7, i64 0, i64 %indvars.iv
  store i32 %div16, i32* %arrayidx18, align 4, !tbaa !2
  %arrayidx21 = getelementptr inbounds [100000 x i32], [100000 x i32]* @b8, i64 0, i64 %indvars.iv
  store i32 %div19, i32* %arrayidx21, align 4, !tbaa !2
  %arrayidx24 = getelementptr inbounds [100000 x i32], [100000 x i32]* @b9, i64 0, i64 %indvars.iv
  store i32 %div22, i32* %arrayidx24, align 4, !tbaa !2
  %arrayidx27 = getelementptr inbounds [100000 x i32], [100000 x i32]* @b10, i64 0, i64 %indvars.iv
  store i32 %div25, i32* %arrayidx27, align 4, !tbaa !2
  %indvars.iv.next = add nuw nsw i64 %indvars.iv, 1
  %exitcond.not = icmp eq i64 %indvars.iv.next, 100000
  br i1 %exitcond.not, label %for.end, label %for.body, !llvm.loop !6
```
#### Разница:
Без оптимизации инвариантов в цикле выполняются 10 инструкций sdiv. С оптимизацией они вынесены в блок до начала цикла. В цикле остались инструкции store для этих данных.

### licm_div_20.cpp
#### SRC
```C++
void func(int a1, int a2, int a3, int a4, int a5, int a6, int a7, int a8, int a9, int a10, int a11, int a12, int a13, int a14, int a15, int a16){
    int i;
    for (i = 1; i < SIZE; i++){
        b1[i]=a1/a2;
        b2[i]=a2/a3;
        b3[i]=a3/a4;
        b4[i]=a4/a5;
        b5[i]=a5/a6;
        b6[i]=a6/a7;
        b7[i]=a7/a8;
        b8[i]=a8/a9;
        b9[i]=a9/a10;
        b10[i]=a10/a11;
        b11[i]=a11/a12;
        b12[i]=a12/a13;
        b13[i]=a13/a14;
        b14[i]=a14/a15;
        b15[i]=a15/a16;
        b16[i]=a16/a1;
        b17[i]=a16/a2;
        b18[i]=a16/a3;
        b19[i]=a16/a4;
        b20[i]=a16/a5;
    }
}
```

#### LLVM IR -O1 без оптимизации инвариантов
```LLVM
for.body:                                         ; preds = %for.body, %entry
  %indvars.iv = phi i64 [ 1, %entry ], [ %indvars.iv.next, %for.body ]
  %div = sdiv i32 %a1, %a2
  %arrayidx = getelementptr inbounds [100000 x i32], [100000 x i32]* @b1, i64 0, i64 %indvars.iv
  store i32 %div, i32* %arrayidx, align 4, !tbaa !2
  %div1 = sdiv i32 %a2, %a3
  %arrayidx3 = getelementptr inbounds [100000 x i32], [100000 x i32]* @b2, i64 0, i64 %indvars.iv
  store i32 %div1, i32* %arrayidx3, align 4, !tbaa !2
  %div4 = sdiv i32 %a3, %a4
  %arrayidx6 = getelementptr inbounds [100000 x i32], [100000 x i32]* @b3, i64 0, i64 %indvars.iv
  store i32 %div4, i32* %arrayidx6, align 4, !tbaa !2
  %div7 = sdiv i32 %a4, %a5
  %arrayidx9 = getelementptr inbounds [100000 x i32], [100000 x i32]* @b4, i64 0, i64 %indvars.iv
  store i32 %div7, i32* %arrayidx9, align 4, !tbaa !2
  %div10 = sdiv i32 %a5, %a6
  %arrayidx12 = getelementptr inbounds [100000 x i32], [100000 x i32]* @b5, i64 0, i64 %indvars.iv
  store i32 %div10, i32* %arrayidx12, align 4, !tbaa !2
  %div13 = sdiv i32 %a6, %a7
  %arrayidx15 = getelementptr inbounds [100000 x i32], [100000 x i32]* @b6, i64 0, i64 %indvars.iv
  store i32 %div13, i32* %arrayidx15, align 4, !tbaa !2
  %div16 = sdiv i32 %a7, %a8
  %arrayidx18 = getelementptr inbounds [100000 x i32], [100000 x i32]* @b7, i64 0, i64 %indvars.iv
  store i32 %div16, i32* %arrayidx18, align 4, !tbaa !2
  %div19 = sdiv i32 %a8, %a9
  %arrayidx21 = getelementptr inbounds [100000 x i32], [100000 x i32]* @b8, i64 0, i64 %indvars.iv
  store i32 %div19, i32* %arrayidx21, align 4, !tbaa !2
  %div22 = sdiv i32 %a9, %a10
  %arrayidx24 = getelementptr inbounds [100000 x i32], [100000 x i32]* @b9, i64 0, i64 %indvars.iv
  store i32 %div22, i32* %arrayidx24, align 4, !tbaa !2
  %div25 = sdiv i32 %a10, %a11
  %arrayidx27 = getelementptr inbounds [100000 x i32], [100000 x i32]* @b10, i64 0, i64 %indvars.iv
  store i32 %div25, i32* %arrayidx27, align 4, !tbaa !2
  %div28 = sdiv i32 %a11, %a12
  %arrayidx30 = getelementptr inbounds [100000 x i32], [100000 x i32]* @b11, i64 0, i64 %indvars.iv
  store i32 %div28, i32* %arrayidx30, align 4, !tbaa !2
  %div31 = sdiv i32 %a12, %a13
  %arrayidx33 = getelementptr inbounds [100000 x i32], [100000 x i32]* @b12, i64 0, i64 %indvars.iv
  store i32 %div31, i32* %arrayidx33, align 4, !tbaa !2
  %div34 = sdiv i32 %a13, %a14
  %arrayidx36 = getelementptr inbounds [100000 x i32], [100000 x i32]* @b13, i64 0, i64 %indvars.iv
  store i32 %div34, i32* %arrayidx36, align 4, !tbaa !2
  %div37 = sdiv i32 %a14, %a15
  %arrayidx39 = getelementptr inbounds [100000 x i32], [100000 x i32]* @b14, i64 0, i64 %indvars.iv
  store i32 %div37, i32* %arrayidx39, align 4, !tbaa !2
  %div40 = sdiv i32 %a15, %a16
  %arrayidx42 = getelementptr inbounds [100000 x i32], [100000 x i32]* @b15, i64 0, i64 %indvars.iv
  store i32 %div40, i32* %arrayidx42, align 4, !tbaa !2
  %div43 = sdiv i32 %a16, %a1
  %arrayidx45 = getelementptr inbounds [100000 x i32], [100000 x i32]* @b16, i64 0, i64 %indvars.iv
  store i32 %div43, i32* %arrayidx45, align 4, !tbaa !2
  %div46 = sdiv i32 %a16, %a2
  %arrayidx48 = getelementptr inbounds [100000 x i32], [100000 x i32]* @b17, i64 0, i64 %indvars.iv
  store i32 %div46, i32* %arrayidx48, align 4, !tbaa !2
  %div49 = sdiv i32 %a16, %a3
  %arrayidx51 = getelementptr inbounds [100000 x i32], [100000 x i32]* @b18, i64 0, i64 %indvars.iv
  store i32 %div49, i32* %arrayidx51, align 4, !tbaa !2
  %div52 = sdiv i32 %a16, %a4
  %arrayidx54 = getelementptr inbounds [100000 x i32], [100000 x i32]* @b19, i64 0, i64 %indvars.iv
  store i32 %div52, i32* %arrayidx54, align 4, !tbaa !2
  %div55 = sdiv i32 %a16, %a5
  %arrayidx57 = getelementptr inbounds [100000 x i32], [100000 x i32]* @b20, i64 0, i64 %indvars.iv
  store i32 %div55, i32* %arrayidx57, align 4, !tbaa !2
  %indvars.iv.next = add nuw nsw i64 %indvars.iv, 1
  %exitcond.not = icmp eq i64 %indvars.iv.next, 100000
  br i1 %exitcond.not, label %for.end, label %for.body, !llvm.loop !6
```
#### LLVM IR -O1 с оптимизацией инвариантов
```LLVM
entry:
  %div = sdiv i32 %a1, %a2
  %div1 = sdiv i32 %a2, %a3
  %div4 = sdiv i32 %a3, %a4
  %div7 = sdiv i32 %a4, %a5
  %div10 = sdiv i32 %a5, %a6
  %div13 = sdiv i32 %a6, %a7
  %div16 = sdiv i32 %a7, %a8
  %div19 = sdiv i32 %a8, %a9
  %div22 = sdiv i32 %a9, %a10
  %div25 = sdiv i32 %a10, %a11
  %div28 = sdiv i32 %a11, %a12
  %div31 = sdiv i32 %a12, %a13
  %div34 = sdiv i32 %a13, %a14
  %div37 = sdiv i32 %a14, %a15
  %div40 = sdiv i32 %a15, %a16
  %div43 = sdiv i32 %a16, %a1
  %div46 = sdiv i32 %a16, %a2
  %div49 = sdiv i32 %a16, %a3
  %div52 = sdiv i32 %a16, %a4
  %div55 = sdiv i32 %a16, %a5
  br label %for.body

for.body:                                         ; preds = %for.body, %entry
  %indvars.iv = phi i64 [ 1, %entry ], [ %indvars.iv.next, %for.body ]
  %arrayidx = getelementptr inbounds [100000 x i32], [100000 x i32]* @b1, i64 0, i64 %indvars.iv
  store i32 %div, i32* %arrayidx, align 4, !tbaa !2
  %arrayidx3 = getelementptr inbounds [100000 x i32], [100000 x i32]* @b2, i64 0, i64 %indvars.iv
  store i32 %div1, i32* %arrayidx3, align 4, !tbaa !2
  %arrayidx6 = getelementptr inbounds [100000 x i32], [100000 x i32]* @b3, i64 0, i64 %indvars.iv
  store i32 %div4, i32* %arrayidx6, align 4, !tbaa !2
  %arrayidx9 = getelementptr inbounds [100000 x i32], [100000 x i32]* @b4, i64 0, i64 %indvars.iv
  store i32 %div7, i32* %arrayidx9, align 4, !tbaa !2
  %arrayidx12 = getelementptr inbounds [100000 x i32], [100000 x i32]* @b5, i64 0, i64 %indvars.iv
  store i32 %div10, i32* %arrayidx12, align 4, !tbaa !2
  %arrayidx15 = getelementptr inbounds [100000 x i32], [100000 x i32]* @b6, i64 0, i64 %indvars.iv
  store i32 %div13, i32* %arrayidx15, align 4, !tbaa !2
  %arrayidx18 = getelementptr inbounds [100000 x i32], [100000 x i32]* @b7, i64 0, i64 %indvars.iv
  store i32 %div16, i32* %arrayidx18, align 4, !tbaa !2
  %arrayidx21 = getelementptr inbounds [100000 x i32], [100000 x i32]* @b8, i64 0, i64 %indvars.iv
  store i32 %div19, i32* %arrayidx21, align 4, !tbaa !2
  %arrayidx24 = getelementptr inbounds [100000 x i32], [100000 x i32]* @b9, i64 0, i64 %indvars.iv
  store i32 %div22, i32* %arrayidx24, align 4, !tbaa !2
  %arrayidx27 = getelementptr inbounds [100000 x i32], [100000 x i32]* @b10, i64 0, i64 %indvars.iv
  store i32 %div25, i32* %arrayidx27, align 4, !tbaa !2
  %arrayidx30 = getelementptr inbounds [100000 x i32], [100000 x i32]* @b11, i64 0, i64 %indvars.iv
  store i32 %div28, i32* %arrayidx30, align 4, !tbaa !2
  %arrayidx33 = getelementptr inbounds [100000 x i32], [100000 x i32]* @b12, i64 0, i64 %indvars.iv
  store i32 %div31, i32* %arrayidx33, align 4, !tbaa !2
  %arrayidx36 = getelementptr inbounds [100000 x i32], [100000 x i32]* @b13, i64 0, i64 %indvars.iv
  store i32 %div34, i32* %arrayidx36, align 4, !tbaa !2
  %arrayidx39 = getelementptr inbounds [100000 x i32], [100000 x i32]* @b14, i64 0, i64 %indvars.iv
  store i32 %div37, i32* %arrayidx39, align 4, !tbaa !2
  %arrayidx42 = getelementptr inbounds [100000 x i32], [100000 x i32]* @b15, i64 0, i64 %indvars.iv
  store i32 %div40, i32* %arrayidx42, align 4, !tbaa !2
  %arrayidx45 = getelementptr inbounds [100000 x i32], [100000 x i32]* @b16, i64 0, i64 %indvars.iv
  store i32 %div43, i32* %arrayidx45, align 4, !tbaa !2
  %arrayidx48 = getelementptr inbounds [100000 x i32], [100000 x i32]* @b17, i64 0, i64 %indvars.iv
  store i32 %div46, i32* %arrayidx48, align 4, !tbaa !2
  %arrayidx51 = getelementptr inbounds [100000 x i32], [100000 x i32]* @b18, i64 0, i64 %indvars.iv
  store i32 %div49, i32* %arrayidx51, align 4, !tbaa !2
  %arrayidx54 = getelementptr inbounds [100000 x i32], [100000 x i32]* @b19, i64 0, i64 %indvars.iv
  store i32 %div52, i32* %arrayidx54, align 4, !tbaa !2
  %arrayidx57 = getelementptr inbounds [100000 x i32], [100000 x i32]* @b20, i64 0, i64 %indvars.iv
  store i32 %div55, i32* %arrayidx57, align 4, !tbaa !2
  %indvars.iv.next = add nuw nsw i64 %indvars.iv, 1
  %exitcond.not = icmp eq i64 %indvars.iv.next, 100000
  br i1 %exitcond.not, label %for.end, label %for.body, !llvm.loop !6
```
#### Разница:
Без оптимизации инвариантов в цикле выполняются 20 инструкций sdiv. С оптимизацией они вынесены в блок до начала цикла. В цикле остались инструкции store для этих данных.

### Полный лог бенчмарка
```
 Performance counter stats for './bin/o0/licm_5_o0' (10 runs):

          3 046,22 msec task-clock                #    1,000 CPUs utilized            ( +-  0,06% )
                12      context-switches          #    0,004 K/sec                    ( +-  6,64% )
                 0      cpu-migrations            #    0,000 K/sec                  
               884      page-faults               #    0,290 K/sec                  
     4 860 984 579      cycles                    #    1,596 GHz                      ( +-  0,05% )
    10 809 426 459      instructions              #    2,22  insn per cycle           ( +-  0,00% )
       801 581 740      branches                  #  263,140 M/sec                    ( +-  0,00% )
            29 590      branch-misses             #    0,00% of all branches          ( +-  0,86% )

           3,04669 +- 0,00185 seconds time elapsed  ( +-  0,06% )

cset: --> last message, executed args into cpuset "/user", new pid is: 11555

 Performance counter stats for './bin/o0/licm_10_o0' (10 runs):

          2 792,40 msec task-clock                #    1,000 CPUs utilized            ( +-  0,03% )
                15      context-switches          #    0,005 K/sec                    ( +-  4,19% )
                 0      cpu-migrations            #    0,000 K/sec                  
             1 174      page-faults               #    0,420 K/sec                  
     4 457 211 344      cycles                    #    1,596 GHz                      ( +-  0,03% )
     9 410 105 926      instructions              #    2,11  insn per cycle           ( +-  0,00% )
       401 698 805      branches                  #  143,855 M/sec                    ( +-  0,00% )
            29 923      branch-misses             #    0,01% of all branches          ( +-  1,08% )

          2,792924 +- 0,000770 seconds time elapsed  ( +-  0,03% )

cset: --> last message, executed args into cpuset "/user", new pid is: 11574

 Performance counter stats for './bin/o0/licm_20_o0' (10 runs):

          2 709,44 msec task-clock                #    1,000 CPUs utilized            ( +-  0,02% )
                13      context-switches          #    0,005 K/sec                    ( +-  5,95% )
                 0      cpu-migrations            #    0,000 K/sec                  
             2 049      page-faults               #    0,756 K/sec                  
     4 324 686 496      cycles                    #    1,596 GHz                      ( +-  0,02% )
     8 712 898 884      instructions              #    2,01  insn per cycle           ( +-  0,00% )
       202 170 760      branches                  #   74,617 M/sec                    ( +-  0,00% )
            29 822      branch-misses             #    0,01% of all branches          ( +-  0,41% )

          2,709971 +- 0,000500 seconds time elapsed  ( +-  0,02% )

cset: --> last message, executed args into cpuset "/user", new pid is: 11589

 Performance counter stats for './bin/o0/licm_div_5_o0' (10 runs):

          2 326,41 msec task-clock                #    1,000 CPUs utilized            ( +-  0,01% )
                11      context-switches          #    0,005 K/sec                    ( +-  3,59% )
                 0      cpu-migrations            #    0,000 K/sec                  
               594      page-faults               #    0,255 K/sec                  
     3 713 493 838      cycles                    #    1,596 GHz                      ( +-  0,01% )
     3 207 682 362      instructions              #    0,86  insn per cycle           ( +-  0,01% )
       201 294 410      branches                  #   86,526 M/sec                    ( +-  0,01% )
            25 997      branch-misses             #    0,01% of all branches          ( +-  0,77% )

          2,326813 +- 0,000297 seconds time elapsed  ( +-  0,01% )

cset: --> last message, executed args into cpuset "/user", new pid is: 11604

 Performance counter stats for './bin/o0/licm_div_10_o0' (10 runs):

          4 525,91 msec task-clock                #    1,000 CPUs utilized            ( +-  0,00% )
                18      context-switches          #    0,004 K/sec                    ( +-  4,28% )
                 0      cpu-migrations            #    0,000 K/sec                  
             1 077      page-faults               #    0,238 K/sec                  
     7 224 435 428      cycles                    #    1,596 GHz                      ( +-  0,00% )
     5 712 082 998      instructions              #    0,79  insn per cycle           ( +-  0,00% )
       202 028 679      branches                  #   44,638 M/sec                    ( +-  0,00% )
            35 739      branch-misses             #    0,02% of all branches          ( +-  0,76% )

          4,526460 +- 0,000202 seconds time elapsed  ( +-  0,00% )

cset: --> last message, executed args into cpuset "/user", new pid is: 11622

 Performance counter stats for './bin/o0/licm_div_20_o0' (10 runs):

          8 926,43 msec task-clock                #    1,000 CPUs utilized            ( +-  0,02% )
                36      context-switches          #    0,004 K/sec                    ( +-  1,51% )
                 0      cpu-migrations            #    0,000 K/sec                  
             2 049      page-faults               #    0,230 K/sec                  
    14 248 712 028      cycles                    #    1,596 GHz                      ( +-  0,02% )
    10 721 163 099      instructions              #    0,75  insn per cycle           ( +-  0,00% )
       203 545 359      branches                  #   22,803 M/sec                    ( +-  0,01% )
            56 401      branch-misses             #    0,03% of all branches          ( +-  1,35% )

           8,92722 +- 0,00135 seconds time elapsed  ( +-  0,02% )

cset: --> last message, executed args into cpuset "/user", new pid is: 11659

 Performance counter stats for './bin/o1/licm_5_o1' (10 runs):

          1 700,92 msec task-clock                #    1,000 CPUs utilized            ( +-  0,03% )
                 9      context-switches          #    0,005 K/sec                    ( +-  6,42% )
                 0      cpu-migrations            #    0,000 K/sec                  
               884      page-faults               #    0,520 K/sec                  
     2 715 050 702      cycles                    #    1,596 GHz                      ( +-  0,03% )
     2 807 715 390      instructions              #    1,03  insn per cycle           ( +-  0,00% )
       401 307 529      branches                  #  235,935 M/sec                    ( +-  0,00% )
            22 628      branch-misses             #    0,01% of all branches          ( +-  0,83% )

          1,701383 +- 0,000566 seconds time elapsed  ( +-  0,03% )

cset: --> last message, executed args into cpuset "/user", new pid is: 11674

 Performance counter stats for './bin/o1/licm_10_o1' (10 runs):

          1 551,92 msec task-clock                #    1,000 CPUs utilized            ( +-  0,08% )
                 9      context-switches          #    0,006 K/sec                    ( +-  8,40% )
                 0      cpu-migrations            #    0,000 K/sec                  
             1 174      page-faults               #    0,756 K/sec                  
     2 476 974 584      cycles                    #    1,596 GHz                      ( +-  0,07% )
     2 608 510 264      instructions              #    1,05  insn per cycle           ( +-  0,00% )
       201 439 956      branches                  #  129,801 M/sec                    ( +-  0,00% )
            20 446      branch-misses             #    0,01% of all branches          ( +-  0,65% )

           1,55242 +- 0,00121 seconds time elapsed  ( +-  0,08% )

cset: --> last message, executed args into cpuset "/user", new pid is: 11700

 Performance counter stats for './bin/o1/licm_20_o1' (10 runs):

          1 661,63 msec task-clock                #    1,000 CPUs utilized            ( +-  0,06% )
                 9      context-switches          #    0,005 K/sec                    ( +-  7,57% )
                 0      cpu-migrations            #    0,000 K/sec                  
             2 049      page-faults               #    0,001 M/sec                  
     2 651 936 329      cycles                    #    1,596 GHz                      ( +-  0,06% )
     3 011 561 412      instructions              #    1,14  insn per cycle           ( +-  0,00% )
       101 948 955      branches                  #   61,355 M/sec                    ( +-  0,00% )
            25 890      branch-misses             #    0,03% of all branches          ( +-  0,82% )

           1,66211 +- 0,00106 seconds time elapsed  ( +-  0,06% )

cset: --> last message, executed args into cpuset "/user", new pid is: 11718

 Performance counter stats for './bin/o1/licm_div_5_o1' (10 runs):

            427,68 msec task-clock                #    0,999 CPUs utilized            ( +-  0,07% )
                 3      context-switches          #    0,007 K/sec                    ( +- 18,90% )
                 0      cpu-migrations            #    0,000 K/sec                  
               594      page-faults               #    0,001 M/sec                  
       682 599 197      cycles                    #    1,596 GHz                      ( +-  0,06% )
       805 090 412      instructions              #    1,18  insn per cycle           ( +-  0,00% )
       100 869 054      branches                  #  235,849 M/sec                    ( +-  0,00% )
            15 996      branch-misses             #    0,02% of all branches          ( +-  0,75% )

          0,428037 +- 0,000302 seconds time elapsed  ( +-  0,07% )

cset: --> last message, executed args into cpuset "/user", new pid is: 11733

 Performance counter stats for './bin/o1/licm_div_10_o1' (10 runs):

            776,19 msec task-clock                #    1,000 CPUs utilized            ( +-  0,06% )
                 5      context-switches          #    0,006 K/sec                    ( +- 11,46% )
                 0      cpu-migrations            #    0,000 K/sec                  
             1 077      page-faults               #    0,001 M/sec                  
     1 238 846 891      cycles                    #    1,596 GHz                      ( +-  0,06% )
     1 307 189 531      instructions              #    1,06  insn per cycle           ( +-  0,00% )
       101 215 201      branches                  #  130,399 M/sec                    ( +-  0,00% )
            18 385      branch-misses             #    0,02% of all branches          ( +-  0,73% )

          0,776558 +- 0,000482 seconds time elapsed  ( +-  0,06% )

cset: --> last message, executed args into cpuset "/user", new pid is: 11750

 Performance counter stats for './bin/o1/licm_div_20_o1' (10 runs):

          1 667,53 msec task-clock                #    1,000 CPUs utilized            ( +-  0,07% )
                 9      context-switches          #    0,005 K/sec                    ( +-  5,41% )
                 0      cpu-migrations            #    0,000 K/sec                  
             2 049      page-faults               #    0,001 M/sec                  
     2 661 277 430      cycles                    #    1,596 GHz                      ( +-  0,06% )
     3 011 596 066      instructions              #    1,13  insn per cycle           ( +-  0,00% )
       101 948 428      branches                  #   61,137 M/sec                    ( +-  0,00% )
            22 160      branch-misses             #    0,02% of all branches          ( +-  0,77% )

           1,66797 +- 0,00111 seconds time elapsed  ( +-  0,07% )

cset: --> last message, executed args into cpuset "/user", new pid is: 11766

 Performance counter stats for './bin/o1_mod/licm_5_o1_mod' (10 runs):

          1 702,51 msec task-clock                #    1,000 CPUs utilized            ( +-  0,10% )
                10      context-switches          #    0,006 K/sec                    ( +-  8,39% )
                 0      cpu-migrations            #    0,000 K/sec                  
               884      page-faults               #    0,519 K/sec                  
     2 717 551 534      cycles                    #    1,596 GHz                      ( +-  0,10% )
     2 807 714 259      instructions              #    1,03  insn per cycle           ( +-  0,00% )
       401 308 236      branches                  #  235,716 M/sec                    ( +-  0,00% )
            23 600      branch-misses             #    0,01% of all branches          ( +-  1,86% )

           1,70300 +- 0,00165 seconds time elapsed  ( +-  0,10% )

cset: --> last message, executed args into cpuset "/user", new pid is: 11796

 Performance counter stats for './bin/o1_mod/licm_10_o1_mod' (10 runs):

          1 550,86 msec task-clock                #    1,000 CPUs utilized            ( +-  0,05% )
                 8      context-switches          #    0,005 K/sec                    ( +-  5,27% )
                 0      cpu-migrations            #    0,000 K/sec                  
             1 174      page-faults               #    0,757 K/sec                  
     2 475 261 990      cycles                    #    1,596 GHz                      ( +-  0,04% )
     3 408 623 071      instructions              #    1,38  insn per cycle           ( +-  0,00% )
       201 459 677      branches                  #  129,902 M/sec                    ( +-  0,01% )
            20 079      branch-misses             #    0,01% of all branches          ( +-  1,09% )

          1,551267 +- 0,000734 seconds time elapsed  ( +-  0,05% )

cset: --> last message, executed args into cpuset "/user", new pid is: 11815

 Performance counter stats for './bin/o1_mod/licm_20_o1_mod' (10 runs):

          1 660,21 msec task-clock                #    1,000 CPUs utilized            ( +-  0,07% )
                10      context-switches          #    0,006 K/sec                    ( +-  3,33% )
                 0      cpu-migrations            #    0,000 K/sec                  
             2 049      page-faults               #    0,001 M/sec                  
     2 649 632 426      cycles                    #    1,596 GHz                      ( +-  0,06% )
     5 511 532 263      instructions              #    2,08  insn per cycle           ( +-  0,00% )
       101 950 280      branches                  #   61,408 M/sec                    ( +-  0,00% )
            25 313      branch-misses             #    0,02% of all branches          ( +-  1,13% )

           1,66070 +- 0,00114 seconds time elapsed  ( +-  0,07% )

cset: --> last message, executed args into cpuset "/user", new pid is: 11830

 Performance counter stats for './bin/o1_mod/licm_div_5_o1_mod' (10 runs):

          2 261,33 msec task-clock                #    1,000 CPUs utilized            ( +-  0,01% )
                12      context-switches          #    0,005 K/sec                    ( +-  5,30% )
                 0      cpu-migrations            #    0,000 K/sec                  
               594      page-faults               #    0,263 K/sec                  
     3 609 595 983      cycles                    #    1,596 GHz                      ( +-  0,01% )
     2 307 476 759      instructions              #    0,64  insn per cycle           ( +-  0,00% )
       101 267 071      branches                  #   44,782 M/sec                    ( +-  0,01% )
            25 107      branch-misses             #    0,02% of all branches          ( +-  0,37% )

          2,261826 +- 0,000331 seconds time elapsed  ( +-  0,01% )

cset: --> last message, executed args into cpuset "/user", new pid is: 11847

 Performance counter stats for './bin/o1_mod/licm_div_10_o1_mod' (10 runs):

          4 465,80 msec task-clock                #    1,000 CPUs utilized            ( +-  0,17% )
                19      context-switches          #    0,004 K/sec                    ( +-  3,09% )
                 0      cpu-migrations            #    0,000 K/sec                  
             1 077      page-faults               #    0,241 K/sec                  
     7 128 226 485      cycles                    #    1,596 GHz                      ( +-  0,17% )
     4 311 881 244      instructions              #    0,60  insn per cycle           ( +-  0,00% )
       101 997 822      branches                  #   22,840 M/sec                    ( +-  0,00% )
            37 407      branch-misses             #    0,04% of all branches          ( +-  1,56% )

           4,46638 +- 0,00754 seconds time elapsed  ( +-  0,17% )

cset: --> last message, executed args into cpuset "/user", new pid is: 11873

 Performance counter stats for './bin/o1_mod/licm_div_20_o1_mod' (10 runs):

          8 852,34 msec task-clock                #    1,000 CPUs utilized            ( +-  0,00% )
                34      context-switches          #    0,004 K/sec                    ( +-  3,07% )
                 0      cpu-migrations            #    0,000 K/sec                  
             2 049      page-faults               #    0,231 K/sec                  
    14 130 469 324      cycles                    #    1,596 GHz                      ( +-  0,00% )
     8 820 786 521      instructions              #    0,62  insn per cycle           ( +-  0,00% )
       103 481 798      branches                  #   11,690 M/sec                    ( +-  0,03% )
            55 122      branch-misses             #    0,05% of all branches          ( +-  0,61% )

          8,853094 +- 0,000429 seconds time elapsed  ( +-  0,00% )

```
