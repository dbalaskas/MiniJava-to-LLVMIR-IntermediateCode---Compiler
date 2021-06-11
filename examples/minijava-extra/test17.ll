@.test17_vtable = global [0 x i8*] []
@.Test_vtable = global [3 x i8*] [i8* bitcast (i32 (i8*)* @Test.start to i8*), i8* bitcast (i8* (i8*, i8*)* @Test.first to i8*), i8* bitcast (i32 (i8*)* @Test.second to i8*)]

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
	%_2 = getelementptr [3 x i8*], [3 x i8*]* @.Test_vtable, i32 0, i32 0
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
	%test = alloca i8*

	%_0 = call i8* @calloc(i32 1, i32 12)
	%_1 = bitcast i8* %_0 to i8***
	%_2 = getelementptr [3 x i8*], [3 x i8*]* @.Test_vtable, i32 0, i32 0
	store i8** %_2, i8*** %_1

	store i8* %_0, i8** %test
	store i32 10, i32* %i
	%_3 = load i32, i32* %i
	%_4 = load i8*, i8** %test
	; Test.first : 1
	%_5 = bitcast i8* %_4 to i8***
	%_6 = load i8**, i8*** %_5
	%_7 = getelementptr i8*, i8** %_6, i32 1
	%_8 = load i8*, i8** %_7
	%_9 = bitcast i8* %_8 to i8* (i8*, i8*)*
	%_10 = call i8* %_9(i8* %_4, i8* %this)

	; Test.second : 2
	%_11 = bitcast i8* %_10 to i8***
	%_12 = load i8**, i8*** %_11
	%_13 = getelementptr i8*, i8** %_12, i32 2
	%_14 = load i8*, i8** %_13
	%_15 = bitcast i8* %_14 to i32 (i8*)*
	%_16 = call i32 %_15(i8* %_10)

	%_17 = add i32 %_3, %_16
	store i32 %_17, i32* %i
	%_18 = load i32, i32* %i
	ret i32 %_18
}

define i8* @Test.first(i8* %this, i8* %.test2) {
	%test2 = alloca i8*
	store i8* %.test2, i8** %test2
	%test3 = alloca i8*

	%_0 = load i8*, i8** %test2
	store i8* %_0, i8** %test3
	%_1 = load i8*, i8** %test3
	ret i8* %_1
}

define i32 @Test.second(i8* %this) {
	%_0 = load i32, i32* %i
	%_1 = add i32 %_0, 10
	store i32 %_1, i32* %i
	%_2 = load i32, i32* %i
	ret i32 %_2
}

