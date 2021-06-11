@.Factorial_vtable = global [0 x i8*] []
@.Fac_vtable = global [1 x i8*] [i8* bitcast (i32 (i8*, i32)* @Fac.ComputeFac to i8*)]

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
	%_2 = getelementptr [1 x i8*], [1 x i8*]* @.Fac_vtable, i32 0, i32 0
	store i8** %_2, i8*** %_1

	; Fac.ComputeFac : 0
	%_3 = bitcast i8* %_0 to i8***
	%_4 = load i8**, i8*** %_3
	%_5 = getelementptr i8*, i8** %_4, i32 0
	%_6 = load i8*, i8** %_5
	%_7 = bitcast i8* %_6 to i32 (i8*, i32)*
	%_8 = call i32 %_7(i8* %_0, i32 10)

	call void (i32) @print_int(i32 %_8)

	ret i32 0
}

define i32 @Fac.ComputeFac(i8* %this, i32 %.num) {
	%num = alloca i32
	store i32 %.num, i32* %num
	%num_aux = alloca i32

	%arr = alloca i32*

	%_0 = add i32 1, 5
	%_1 = icmp sge i32 %_0, 1
	br i1 %_1, label %oob_safe3, label %oob_error4

%oob_error4:
	call void @throw_oob()
%oob_safe3:
	%_0 = add i32 1, 5
	%_1 = call i8* @calloc(i32 %_0 , i32 4)
	%_2 = bitcast i8* %_1 to i32*
	store 5, i32* %_2

	store i32* %_2, i32** %arr
	%_5 = load i32*, i32** %arr
	%_6 = load i32, [Ljava.lang.String;@1698c449
	%_7 = icmp sge [Ljava.lang.String;@5ef04b5, 0
	%_10 = icmp slt [Ljava.lang.String;@5ef04b5, %_6
	%_11 = and i1 %_7, %_10
	br i1 %_11, label %oob_safe8, label %oob_error9

%oob_error9:
	call void @throw_oob()
	br label %oob_safe8

%oob_safe8:
	%_12 = add [Ljava.lang.String;@5ef04b5, 1
	%_13 = getelementptr i32, [Ljava.lang.String;@1698c449, i32 %_12
	%_14 = load i32, i32* %_13
	call void (i32) @print_int(i32 %_14)
	%_15 = load i32, i32* %num
	%_16 = icmp slt i32 %_15, 1
	br i1 %_16, label %then17, label %else18

%then17:
	store i32 1, i32* %num_aux

	br  label %end19

%else18:
	%_20 = load i32, i32* %num
	; Fac.ComputeFac : 0
	%_21 = bitcast i8* %this to i8***
	%_22 = load i8**, i8*** %_21
	%_23 = getelementptr i8*, i8** %_22, i32 0
	%_24 = load i8*, i8** %_23
	%_25 = bitcast i8* %_24 to i32 (i8*, i32)*
	%_27 = load i32, i32* %num
	%_28 = sub i32 %_27, 1
	%_26 = call i32 %_25(i8* %this, i32 %_28)

	%_29 = mul i32 %_20, %_26
	store i32 %_29, i32* %num_aux
%end19:
	%_30 = load i32, i32* %num_aux
	ret i32 %_30
}

