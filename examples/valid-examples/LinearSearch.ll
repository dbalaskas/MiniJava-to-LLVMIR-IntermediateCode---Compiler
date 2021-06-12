@.LinearSearch_vtable = global [0 x i8*] []
@.LS_vtable = global [4 x i8*] [i8* bitcast (i32 (i8*, i32)* @LS.Start to i8*), i8* bitcast (i32 (i8*)* @LS.Print to i8*), i8* bitcast (i32 (i8*, i32)* @LS.Search to i8*), i8* bitcast (i32 (i8*, i32)* @LS.Init to i8*)]

declare i8* @calloc(i32, i32)
declare i32 @printf(i8*, ...)
declare void @exit(i32)

@_cint = constant [4 x i8] c"%d\0a\00"
@_cOOB = constant [15 x i8] c"Out of bounds\0a\00"
define void @print_int(i32 %i) {
	%_str = bitcast [4 x i8]* @_cint to i8*
	call i32 (i8*, ...) @printf(i8* %_str, i32 %i)
	ret void
}

define void @throw_oob() {
	%_str = bitcast [15 x i8]* @_cOOB to i8*
	call i32 (i8*, ...) @printf(i8* %_str)
	call void @exit(i32 1)
	ret void
}

define i32 @main() {

	%_0 = call i8* @calloc(i32 1, i32 20)
	%_1 = bitcast i8* %_0 to i8***
	%_2 = getelementptr [4 x i8*], [4 x i8*]* @.LS_vtable, i32 0, i32 0
	store i8** %_2, i8*** %_1
	; LS.Start : 0
	%_3 = bitcast i8* %_0 to i8***
	%_4 = load i8**, i8*** %_3
	%_5 = getelementptr i8*, i8** %_4, i32 0
	%_6 = load i8*, i8** %_5
	%_7 = bitcast i8* %_6 to i32 (i8*, i32)*
	%_8 = call i32 %_7(i8* %_0, i32 10)
	call void (i32) @print_int(i32 %_8)

	ret i32 0
}

define i32 @LS.Start(i8* %this, i32 %.sz) {
	%sz = alloca i32
	store i32 %.sz, i32* %sz
	%aux01 = alloca i32

	%aux02 = alloca i32


	; LS.Init : 3
	%_0 = bitcast i8* %this to i8***
	%_1 = load i8**, i8*** %_0
	%_2 = getelementptr i8*, i8** %_1, i32 3
	%_3 = load i8*, i8** %_2
	%_4 = bitcast i8* %_3 to i32 (i8*, i32)*
	%_6 = load i32, i32* %sz
	%_5 = call i32 %_4(i8* %this, i32 %_6)
	store i32 %_5, i32* %aux01

	; LS.Print : 1
	%_7 = bitcast i8* %this to i8***
	%_8 = load i8**, i8*** %_7
	%_9 = getelementptr i8*, i8** %_8, i32 1
	%_10 = load i8*, i8** %_9
	%_11 = bitcast i8* %_10 to i32 (i8*)*
	%_12 = call i32 %_11(i8* %this)
	store i32 %_12, i32* %aux02

	call void (i32) @print_int(i32 9999)

	; LS.Search : 2
	%_13 = bitcast i8* %this to i8***
	%_14 = load i8**, i8*** %_13
	%_15 = getelementptr i8*, i8** %_14, i32 2
	%_16 = load i8*, i8** %_15
	%_17 = bitcast i8* %_16 to i32 (i8*, i32)*
	%_18 = call i32 %_17(i8* %this, i32 8)
	call void (i32) @print_int(i32 %_18)

	; LS.Search : 2
	%_19 = bitcast i8* %this to i8***
	%_20 = load i8**, i8*** %_19
	%_21 = getelementptr i8*, i8** %_20, i32 2
	%_22 = load i8*, i8** %_21
	%_23 = bitcast i8* %_22 to i32 (i8*, i32)*
	%_24 = call i32 %_23(i8* %this, i32 12)
	call void (i32) @print_int(i32 %_24)

	; LS.Search : 2
	%_25 = bitcast i8* %this to i8***
	%_26 = load i8**, i8*** %_25
	%_27 = getelementptr i8*, i8** %_26, i32 2
	%_28 = load i8*, i8** %_27
	%_29 = bitcast i8* %_28 to i32 (i8*, i32)*
	%_30 = call i32 %_29(i8* %this, i32 17)
	call void (i32) @print_int(i32 %_30)

	; LS.Search : 2
	%_31 = bitcast i8* %this to i8***
	%_32 = load i8**, i8*** %_31
	%_33 = getelementptr i8*, i8** %_32, i32 2
	%_34 = load i8*, i8** %_33
	%_35 = bitcast i8* %_34 to i32 (i8*, i32)*
	%_36 = call i32 %_35(i8* %this, i32 50)
	call void (i32) @print_int(i32 %_36)
	ret i32 55
}

define i32 @LS.Print(i8* %this) {
	%j = alloca i32


	store i32 1, i32* %j


	br label %while_cond0

while_cond0:
	%_3 = load i32, i32* %j
	%_4 = getelementptr i8, i8* %this, i32 16
	%_5 = bitcast i8* %_4 to i32*
	%_6 = load i32, i32* %_5
	%_7 = icmp slt i32 %_3, %_6
	br i1 %_7, label %while_body1, label %while_end2

while_body1:


	%_8 = getelementptr i8, i8* %this, i32 8
	%_9 = bitcast i8* %_8 to i32**
	%_10 = load i32*, i32** %_9
	%_11 = load i32, i32* %j
	%_12 = load i32, i32* %_10
	%_13 = icmp sge i32 %_11, 0
	%_16 = icmp slt i32 %_11, %_12
	%_17 = and i1 %_13, %_16
	br i1 %_17, label %oob_safe14, label %oob_error15

oob_error15:
	call void @throw_oob()
	br label %oob_safe14

oob_safe14:
	%_18 = add i32 %_11, 1
	%_19 = getelementptr i32, i32* %_10, i32 %_18
	%_20 = load i32, i32* %_19
	call void (i32) @print_int(i32 %_20)

	%_21 = load i32, i32* %j
	%_22 = add i32 %_21, 1
	store i32 %_22, i32* %j

	br label %while_cond0

while_end2:
	ret i32 0
}

define i32 @LS.Search(i8* %this, i32 %.num) {
	%num = alloca i32
	store i32 %.num, i32* %num
	%j = alloca i32

	%ls01 = alloca i1

	%ifound = alloca i32

	%aux01 = alloca i32

	%aux02 = alloca i32

	%nt = alloca i32


	store i32 1, i32* %j

	store i1 0, i1* %ls01

	store i32 0, i32* %ifound


	br label %while_cond0

while_cond0:
	%_3 = load i32, i32* %j
	%_4 = getelementptr i8, i8* %this, i32 16
	%_5 = bitcast i8* %_4 to i32*
	%_6 = load i32, i32* %_5
	%_7 = icmp slt i32 %_3, %_6
	br i1 %_7, label %while_body1, label %while_end2

while_body1:


	%_8 = getelementptr i8, i8* %this, i32 8
	%_9 = bitcast i8* %_8 to i32**
	%_10 = load i32*, i32** %_9
	%_11 = load i32, i32* %j
	%_12 = load i32, i32* %_10
	%_13 = icmp sge i32 %_11, 0
	%_16 = icmp slt i32 %_11, %_12
	%_17 = and i1 %_13, %_16
	br i1 %_17, label %oob_safe14, label %oob_error15

oob_error15:
	call void @throw_oob()
	br label %oob_safe14

oob_safe14:
	%_18 = add i32 %_11, 1
	%_19 = getelementptr i32, i32* %_10, i32 %_18
	%_20 = load i32, i32* %_19
	store i32 %_20, i32* %aux01

	%_21 = load i32, i32* %num
	%_22 = add i32 %_21, 1
	store i32 %_22, i32* %aux02

	%_23 = load i32, i32* %aux01
	%_24 = load i32, i32* %num
	%_25 = icmp slt i32 %_23, %_24
	br i1 %_25, label %if_then26, label %if_else27

if_then26:

	store i32 0, i32* %nt

	br label %if_end28

if_else27:

	%_29 = load i32, i32* %aux01
	%_30 = load i32, i32* %aux02
	%_31 = icmp slt i32 %_29, %_30
	%_32 = xor i1 1, %_31
	br i1 %_32, label %if_then33, label %if_else34

if_then33:

	store i32 0, i32* %nt

	br label %if_end35

if_else34:


	store i1 1, i1* %ls01

	store i32 1, i32* %ifound

	%_36 = getelementptr i8, i8* %this, i32 16
	%_37 = bitcast i8* %_36 to i32*
	%_38 = load i32, i32* %_37
	store i32 %_38, i32* %j

	br label %if_end35

if_end35:

	br label %if_end28

if_end28:

	%_39 = load i32, i32* %j
	%_40 = add i32 %_39, 1
	store i32 %_40, i32* %j

	br label %while_cond0

while_end2:
	%_41 = load i32, i32* %ifound
	ret i32 %_41
}

define i32 @LS.Init(i8* %this, i32 %.sz) {
	%sz = alloca i32
	store i32 %.sz, i32* %sz
	%j = alloca i32

	%k = alloca i32

	%aux01 = alloca i32

	%aux02 = alloca i32


	%_0 = load i32, i32* %sz
	%_1 = getelementptr i8, i8* %this, i32 16
	%_2 = bitcast i8* %_1 to i32*
	store i32 %_0, i32* %_2

	%_3 = load i32, i32* %sz
	%_4 = add i32 1, %_3
	%_5 = icmp sge i32 %_4, 1
	br i1 %_5, label %oob_safe6, label %oob_error7

oob_error7:
	call void @throw_oob()

	br label %oob_safe6

oob_safe6:
	%_8 = add i32 1, %_3
	%_9 = call i8* @calloc(i32 %_8 , i32 4)
	%_10 = bitcast i8* %_9 to i32*
	store i32 %_3, i32* %_10

	%_11 = getelementptr i8, i8* %this, i32 8
	%_12 = bitcast i8* %_11 to i32**
	store i32* %_10, i32** %_12

	store i32 1, i32* %j

	%_13 = getelementptr i8, i8* %this, i32 16
	%_14 = bitcast i8* %_13 to i32*
	%_15 = load i32, i32* %_14
	%_16 = add i32 %_15, 1
	store i32 %_16, i32* %k


	br label %while_cond17

while_cond17:
	%_20 = load i32, i32* %j
	%_21 = getelementptr i8, i8* %this, i32 16
	%_22 = bitcast i8* %_21 to i32*
	%_23 = load i32, i32* %_22
	%_24 = icmp slt i32 %_20, %_23
	br i1 %_24, label %while_body18, label %while_end19

while_body18:


	%_25 = load i32, i32* %j
	%_26 = mul i32 2, %_25
	store i32 %_26, i32* %aux01

	%_27 = load i32, i32* %k
	%_28 = sub i32 %_27, 3
	store i32 %_28, i32* %aux02

	%_29 = load i32, i32* %j
	%_30 = load i32, i32* %aux01
	%_31 = load i32, i32* %aux02
	%_32 = add i32 %_30, %_31
	%_33 = getelementptr i8, i8* %this, i32 8
	%_34 = bitcast i8* %_33 to i32**
	%_35 = load i32*, i32** %_34
	%_36 = load i32, i32* %_35
	%_37 = icmp sge i32 %_29, 0
	%_38 = icmp slt i32 %_29, %_36
	%_39 = and i1 %_37, %_38
	br i1 %_39, label %oob_safe40, label %oob_error41

oob_error41:
	call void @throw_oob()

	br label %oob_safe40

oob_safe40:
	%_42 = add i32 %_29, 1
	%_43 = getelementptr i32, i32* %_35, i32 %_42
	store i32 %_32, i32* %_43


	%_44 = load i32, i32* %j
	%_45 = add i32 %_44, 1
	store i32 %_45, i32* %j

	%_46 = load i32, i32* %k
	%_47 = sub i32 %_46, 1
	store i32 %_47, i32* %k

	br label %while_cond17

while_end19:
	ret i32 0
}

