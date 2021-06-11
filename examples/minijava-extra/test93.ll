@.test93_vtable = global [0 x i8*] []
@.Test_vtable = global [2 x i8*] [i8* bitcast (i32 (i8*)* @Test.start to i8*), i8* bitcast (i8* (i8*)* @Test.next to i8*)]

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
	%_0 = call i8* @calloc(i32 1, i32 24)
	%_1 = bitcast i8* %_0 to i8***
	%_2 = getelementptr [2 x i8*], [2 x i8*]* @.Test_vtable, i32 0, i32 0
	store i8** %_2, i8*** %_1

	; Test.start : 0
	%_3 = bitcast i8* %_0 to i8***
	%_4 = load i8**, i8*** %_3
	%_5 = getelementptr i8*, i8** %_4, i32 0
	%_6 = load i8*, i8** %_5
	%_7 = bitcast i8* %_6 to i32 (i8*)*
	%_8 = call i32 %_7(i8* %_0)

	call void (i32) @print_int(i32 %_8)

	ret i32 0
}

define i32 @Test.start(i8* %this) {
	%_0 = add i32 1, 10
	%_1 = icmp sge i32 %_0, 1
	br i1 %_1, label %oob_safe3, label %oob_error4

%oob_error4:
	call void @throw_oob()
%oob_safe3:
	%_0 = add i32 1, 10
	%_1 = call i8* @calloc(i32 %_0 , i32 4)
	%_2 = bitcast i8* %_1 to i32*
	store 10, i32* %_2

	store i32* %_2, i32** %i
	%_5 = call i8* @calloc(i32 1, i32 24)
	%_6 = bitcast i8* %_5 to i8***
	%_7 = getelementptr [2 x i8*], [2 x i8*]* @.Test_vtable, i32 0, i32 0
	store i8** %_7, i8*** %_6

	store i8* %_5, i8** %test
	%_8 = load i8*, i8** %test
	; Test.next : 1
	%_9 = bitcast i8* %_8 to i8***
	%_10 = load i8**, i8*** %_9
	%_11 = getelementptr i8*, i8** %_10, i32 1
	%_12 = load i8*, i8** %_11
	%_13 = bitcast i8* %_12 to i8* (i8*)*
	%_14 = call i8* %_13(i8* %_8)

	; Test.next : 1
	%_15 = bitcast i8* %_14 to i8***
	%_16 = load i8**, i8*** %_15
	%_17 = getelementptr i8*, i8** %_16, i32 1
	%_18 = load i8*, i8** %_17
	%_19 = bitcast i8* %_18 to i8* (i8*)*
	%_20 = call i8* %_19(i8* %_14)

	store i8* %_20, i8** %test
	ret i32 0
}

define i8* @Test.next(i8* %this) {
	%_0 = call i8* @calloc(i32 1, i32 24)
	%_1 = bitcast i8* %_0 to i8***
	%_2 = getelementptr [2 x i8*], [2 x i8*]* @.Test_vtable, i32 0, i32 0
	store i8** %_2, i8*** %_1

	store i8* %_0, i8** %test
	%_3 = load i8*, i8** %test
	ret i8* %_3
}

