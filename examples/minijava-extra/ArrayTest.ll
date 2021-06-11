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
	br i1 %_2, label %oob_safe4, label %oob_error5

%oob_error5:
	call void @throw_oob()
%oob_safe4:
	%_1 = add i32 1, %_0
	%_2 = call i8* @calloc(i32 %_1 , i32 4)
	%_3 = bitcast i8* %_2 to i32*
	store %_0, i32* %_3

	store i32* %_3, i32** %b
	%_6 = load i32*, i32** %b
	%_7 = load i32, i32* %_6	store i32 %_7, i32* %l
	store i32 0, i32* %i
%cond8:
	%_11 = load i32, i32* %i
	%_12 = load i32, i32* %l
	%_13 = icmp slt i32 %_11, %_12
	br i1 %_13, label %while9, label %end10

%while9:
	%_14 = load i32, i32* %i
	%_15 = load i32, i32* %i
	%_16 = loadi32*, i32** %b
	%_17 = load i32, i32* %_16
	%_18 = icmp sge i32 %_14, 0
	%_19 = icmp slt i32 %_14, %_17
	%_20 = and i1 %_18, %_19
	br i1 %_20, label %l0, label %l1

%l1:
	call void @throw_oob()
%l0:
	%_21 = add i32 %_14, 1
	%_22 = getelementptr i32, i32* %_16, i32 %_21
	store i32 %_15, i32* %_22

	%_23 = load i32*, i32** %b
	%_24 = load i32, i32* %i
	%_25 = load i32, [Ljava.lang.String;@277050dc
	%_26 = icmp sge [Ljava.lang.String;@5c29bfd, 0
	%_29 = icmp slt [Ljava.lang.String;@5c29bfd, %_25
	%_30 = and i1 %_26, %_29
	br i1 %_30, label %oob_safe27, label %oob_error28

%oob_error28:
	call void @throw_oob()
	br label %oob_safe27

%oob_safe27:
	%_31 = add [Ljava.lang.String;@5c29bfd, 1
	%_32 = getelementptr i32, [Ljava.lang.String;@277050dc, i32 %_31
	%_33 = load i32, i32* %_32
	call void (i32) @print_int(i32 %_33)
	%_34 = load i32, i32* %i
	%_35 = add i32 %_34, 1
	store i32 %_35, i32* %i
%end10:
	ret i1 1
}

