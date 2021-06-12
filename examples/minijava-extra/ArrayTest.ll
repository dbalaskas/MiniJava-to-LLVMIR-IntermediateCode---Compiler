@.ArrayTest_vtable = global [0 x i8*] []
@.Test_vtable = global [1 x i8*] [i8* bitcast (i1 (i8*, i32)* @Test.start to i8*)]

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
	%n = alloca i1


	%_0 = call i8* @calloc(i32 1, i32 8)
	%_1 = bitcast i8* %_0 to i8***
	%_2 = getelementptr [1 x i8*], [1 x i8*]* @.Test_vtable, i32 0, i32 0
	store i8** %_2, i8*** %_1
	; Test.start : 0
	%_3 = bitcast i8* %_0 to i8***
	%_4 = load i8**, i8*** %_3
	%_5 = getelementptr i8*, i8** %_4, i32 0
	%_6 = load i8*, i8** %_5
	%_7 = bitcast i8* %_6 to i1 (i8*, i32)*
	%_8 = call i1 %_7(i8* %_0, i32 10)
	store i1 %_8, i1* %n

	ret i32 0
}

define i1 @Test.start(i8* %this, i32 %.sz) {
	%sz = alloca i32
	store i32 %.sz, i32* %sz
	%b = alloca i32*

	%l = alloca i32

	%i = alloca i32


	%_0 = load i32, i32* %sz
	%_1 = add i32 1, %_0
	%_2 = icmp sge i32 %_1, 1
	br i1 %_2, label %oob_safe3, label %oob_error4

oob_error4:
	call void @throw_oob()

	br label %oob_safe3

oob_safe3:
	%_5 = add i32 1, %_0
	%_6 = call i8* @calloc(i32 %_5 , i32 4)
	%_7 = bitcast i8* %_6 to i32*
	store i32 %_0, i32* %_7

	store i32* %_7, i32** %b

	%_8 = load i32*, i32** %b
	%_9 = load i32, i32* %_8	store i32 %_9, i32* %l

	store i32 0, i32* %i


	br label %while_cond10

while_cond10:
	%_13 = load i32, i32* %i
	%_14 = load i32, i32* %l
	%_15 = icmp slt i32 %_13, %_14
	br i1 %_15, label %while_body11, label %while_end12

while_body11:


	%_16 = load i32, i32* %i
	%_17 = load i32, i32* %i
	%_18 = load i32*, i32** %b
	%_19 = load i32, i32* %_18
	%_20 = icmp sge i32 %_16, 0
	%_21 = icmp slt i32 %_16, %_19
	%_22 = and i1 %_20, %_21
	br i1 %_22, label %oob_safe23, label %oob_error24

oob_error24:
	call void @throw_oob()

	br label %oob_safe23

oob_safe23:
	%_25 = add i32 %_16, 1
	%_26 = getelementptr i32, i32* %_18, i32 %_25
	store i32 %_17, i32* %_26


	%_27 = load i32*, i32** %b
	%_28 = load i32, i32* %i
	%_29 = load i32, i32* %_27
	%_30 = icmp sge i32 %_28, 0
	%_33 = icmp slt i32 %_28, %_29
	%_34 = and i1 %_30, %_33
	br i1 %_34, label %oob_safe31, label %oob_error32

oob_error32:
	call void @throw_oob()
	br label %oob_safe31

oob_safe31:
	%_35 = add i32 %_28, 1
	%_36 = getelementptr i32, i32* %_27, i32 %_35
	%_37 = load i32, i32* %_36
	call void (i32) @print_int(i32 %_37)

	%_38 = load i32, i32* %i
	%_39 = add i32 %_38, 1
	store i32 %_39, i32* %i

	br label %while_cond10

while_end12:
	ret i1 1
}

