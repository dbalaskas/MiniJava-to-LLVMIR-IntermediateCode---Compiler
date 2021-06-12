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
	br i1 %_1, label %oob_safe2, label %oob_error3

oob_error3:
	call void @throw_oob()

	br label %oob_safe2

oob_safe2:
	%_4 = add i32 1, 20
	%_5 = call i8* @calloc(i32 %_4 , i32 4)
	%_6 = bitcast i8* %_5 to i32*
	store i32 20, i32* %_6

	store i32* %_6, i32** %a

	%_7 = load i32*, i32** %a
	%_8 = load i32, i32* %_7
	%_9 = icmp sge i32 10, 0
	%_12 = icmp slt i32 10, %_8
	%_13 = and i1 %_9, %_12
	br i1 %_13, label %oob_safe10, label %oob_error11

oob_error11:
	call void @throw_oob()
	br label %oob_safe10

oob_safe10:
	%_14 = add i32 10, 1
	%_15 = getelementptr i32, i32* %_7, i32 %_14
	%_16 = load i32, i32* %_15
	call void (i32) @print_int(i32 %_16)
	%_17 = load i32*, i32** %a
	%_18 = load i32, i32* %_17
	%_19 = icmp sge i32 40, 0
	%_22 = icmp slt i32 40, %_18
	%_23 = and i1 %_19, %_22
	br i1 %_23, label %oob_safe20, label %oob_error21

oob_error21:
	call void @throw_oob()
	br label %oob_safe20

oob_safe20:
	%_24 = add i32 40, 1
	%_25 = getelementptr i32, i32* %_17, i32 %_24
	%_26 = load i32, i32* %_25
	ret i32 %_26
}

