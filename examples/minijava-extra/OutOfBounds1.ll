@.OutOfBounds1_vtable = global [0 x i8*] []
@.A_vtable = global [1 x i8*] [i8* bitcast (i32 (i8*)* @A.run to i8*)]

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
	%_0 = call i8* @calloc(i32 1, i32 8)
	%_1 = bitcast i8* %_0 to i8***
	%_2 = getelementptr [1 x i8*], [1 x i8*]* @.A_vtable, i32 0, i32 0
	store i8** %_2, i8*** %_1

	; A.run : 0
	%_3 = bitcast i8* %_0 to i8***
	%_4 = load i8**, i8*** %_3
	%_5 = getelementptr i8*, i8** %_4, i32 0
	%_6 = load i8*, i8** %_5
	%_7 = bitcast i8* %_6 to i32 (i8*)*
	%_8 = call i32 %_7(i8* %_0)

	call void (i32) @print_int(i32 %_8)

	ret i32 0
}

define i32 @A.run(i8* %this) {
	%a = alloca i32*

	%_0 = add i32 1, 20
	%_1 = icmp sge i32 %_0, 1
	br i1 %_1, label %oob_safe3, label %oob_error4

%oob_error4:
	call void @throw_oob()
%oob_safe3:
	%_0 = add i32 1, 20
	%_1 = call i8* @calloc(i32 %_0 , i32 4)
	%_2 = bitcast i8* %_1 to i32*
	store 20, i32* %_2

	store i32* %_2, i32** %a
	%_5 = load i32*, i32** %a
	%_6 = load i32, [Ljava.lang.String;@5cb0d902
	%_7 = icmp sge [Ljava.lang.String;@46fbb2c1, 0
	%_10 = icmp slt [Ljava.lang.String;@46fbb2c1, %_6
	%_11 = and i1 %_7, %_10
	br i1 %_11, label %oob_safe8, label %oob_error9

%oob_error9:
	call void @throw_oob()
	br label %oob_safe8

%oob_safe8:
	%_12 = add [Ljava.lang.String;@46fbb2c1, 1
	%_13 = getelementptr i32, [Ljava.lang.String;@5cb0d902, i32 %_12
	%_14 = load i32, i32* %_13
	call void (i32) @print_int(i32 %_14)
	%_15 = load i32*, i32** %a
	%_16 = load i32, [Ljava.lang.String;@1698c449
	%_17 = icmp sge [Ljava.lang.String;@5ef04b5, 0
	%_20 = icmp slt [Ljava.lang.String;@5ef04b5, %_16
	%_21 = and i1 %_17, %_20
	br i1 %_21, label %oob_safe18, label %oob_error19

%oob_error19:
	call void @throw_oob()
	br label %oob_safe18

%oob_safe18:
	%_22 = add [Ljava.lang.String;@5ef04b5, 1
	%_23 = getelementptr i32, [Ljava.lang.String;@1698c449, i32 %_22
	%_24 = load i32, i32* %_23
	ret i32 %_24
}

