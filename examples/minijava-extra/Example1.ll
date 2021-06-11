@.Example1_vtable = global [0 x i8*] []
@.Test1_vtable = global [1 x i8*] [i8* bitcast (i32 (i8*, i32, i1)* @Test1.Start to i8*)]

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
	%_0 = call i8* @calloc(i32 1, i32 12)
	%_1 = bitcast i8* %_0 to i8***
	%_2 = getelementptr [1 x i8*], [1 x i8*]* @.Test1_vtable, i32 0, i32 0
	store i8** %_2, i8*** %_1

	; Test1.Start : 0
	%_3 = bitcast i8* %_0 to i8***
	%_4 = load i8**, i8*** %_3
	%_5 = getelementptr i8*, i8** %_4, i32 0
	%_6 = load i8*, i8** %_5
	%_7 = bitcast i8* %_6 to i32 (i8*, i32, i1)*
	%_8 = call i32 %_7(i8* %_0, i32 5, i1 1)

	call void (i32) @print_int(i32 %_8)

	ret i32 0
}

define i32 @Test1.Start(i8* %this, i32 %.b, i1 %.c) {
	%b = alloca i32
	store i32 %.b, i32* %b
	%c = alloca i1
	store i1 %.c, i1* %c
	%ntb = alloca i1

	%nti = alloca i32*

	%ourint = alloca i32

	%_0 = load i32, i32* %b
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

	store i32* %_3, i32** %nti
	%_6 = load i32*, i32** %nti
	%_7 = load i32, [Ljava.lang.String;@22d8cfe0
	%_8 = icmp sge [Ljava.lang.String;@579bb367, 0
	%_11 = icmp slt [Ljava.lang.String;@579bb367, %_7
	%_12 = and i1 %_8, %_11
	br i1 %_12, label %oob_safe9, label %oob_error10

%oob_error10:
	call void @throw_oob()
	br label %oob_safe9

%oob_safe9:
	%_13 = add [Ljava.lang.String;@579bb367, 1
	%_14 = getelementptr i32, [Ljava.lang.String;@22d8cfe0, i32 %_13
	%_15 = load i32, i32* %_14
	store i32 %_15, i32* %ourint
	%_16 = load i32, i32* %ourint
	call void (i32) @print_int(i32 %_16)
	%_17 = load i32*, i32** %nti
	%_18 = load i32, [Ljava.lang.String;@1de0aca6
	%_19 = icmp sge [Ljava.lang.String;@255316f2, 0
	%_22 = icmp slt [Ljava.lang.String;@255316f2, %_18
	%_23 = and i1 %_19, %_22
	br i1 %_23, label %oob_safe20, label %oob_error21

%oob_error21:
	call void @throw_oob()
	br label %oob_safe20

%oob_safe20:
	%_24 = add [Ljava.lang.String;@255316f2, 1
	%_25 = getelementptr i32, [Ljava.lang.String;@1de0aca6, i32 %_24
	%_26 = load i32, i32* %_25
	ret i32 %_26
}

