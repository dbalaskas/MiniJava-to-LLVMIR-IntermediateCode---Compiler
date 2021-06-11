@.test20_vtable = global [0 x i8*] []
@.A23_vtable = global [3 x i8*] [i8* bitcast (i32 (i8*, i8*)* @A23.init to i8*), i8* bitcast (i32 (i8*)* @A23.getI1 to i8*), i8* bitcast (i32 (i8*, i32)* @A23.setI1 to i8*)]
@.B23_vtable = global [3 x i8*] [i8* bitcast (i32 (i8*, i8*)* @B23.init to i8*), i8* bitcast (i32 (i8*)* @B23.getI1 to i8*), i8* bitcast (i32 (i8*, i32)* @B23.setI1 to i8*)]
@.C23_vtable = global [3 x i8*] [i8* bitcast (i32 (i8*, i8*)* @C23.init to i8*), i8* bitcast (i32 (i8*)* @C23.getI1 to i8*), i8* bitcast (i32 (i8*, i32)* @C23.setI1 to i8*)]

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
	%_0 = call i8* @calloc(i32 1, i32 16)
	%_1 = bitcast i8* %_0 to i8***
	%_2 = getelementptr [3 x i8*], [3 x i8*]* @.C23_vtable, i32 0, i32 0
	store i8** %_2, i8*** %_1

	; C23.init : 0
	%_3 = bitcast i8* %_0 to i8***
	%_4 = load i8**, i8*** %_3
	%_5 = getelementptr i8*, i8** %_4, i32 0
	%_6 = load i8*, i8** %_5
	%_7 = bitcast i8* %_6 to i32 (i8*, i8*)*
	%_9 = call i8* @calloc(i32 1, i32 16)
	%_10 = bitcast i8* %_9 to i8***
	%_11 = getelementptr [3 x i8*], [3 x i8*]* @.B23_vtable, i32 0, i32 0
	store i8** %_11, i8*** %_10

	%_8 = call i32 %_7(i8* %_0, i8* %_9)

	call void (i32) @print_int(i32 %_8)

	ret i32 0
}

define i32 @A23.init(i8* %this, i8* %.a) {
	%a = alloca i8*
	store i8* %.a, i8** %a
	%_0 = load i8*, i8** %a
	; A23.getI1 : 1
	%_1 = bitcast i8* %_0 to i8***
	%_2 = load i8**, i8*** %_1
	%_3 = getelementptr i8*, i8** %_2, i32 1
	%_4 = load i8*, i8** %_3
	%_5 = bitcast i8* %_4 to i32 (i8*)*
	%_6 = call i32 %_5(i8* %_0)

	store i32 %_6, i32* %i2
	store i32 222, i32* %i3
	; A23.setI1 : 2
	%_7 = bitcast i8* %this to i8***
	%_8 = load i8**, i8*** %_7
	%_9 = getelementptr i8*, i8** %_8, i32 2
	%_10 = load i8*, i8** %_9
	%_11 = bitcast i8* %_10 to i32 (i8*, i32)*
	%_13 = load i32, i32* %i2
	%_14 = load i32, i32* %i3
	%_15 = add i32 %_13, %_14
	%_12 = call i32 %_11(i8* %this, i32 %_15)

	store i32 %_12, i32* %i1
	%_16 = load i32, i32* %i1
	ret i32 %_16
}

define i32 @A23.getI1(i8* %this) {
	%_0 = load i32, i32* %i1
	ret i32 %_0
}

define i32 @A23.setI1(i8* %this, i32 %.i) {
	%i = alloca i32
	store i32 %.i, i32* %i
	%_0 = load i32, i32* %i
	ret i32 %_0
}

define i32 @B23.init(i8* %this, i8* %.a) {
	%a = alloca i8*
	store i8* %.a, i8** %a
	%a_local = alloca i8*

	%_0 = call i8* @calloc(i32 1, i32 20)
	%_1 = bitcast i8* %_0 to i8***
	%_2 = getelementptr [3 x i8*], [3 x i8*]* @.A23_vtable, i32 0, i32 0
	store i8** %_2, i8*** %_1

	store i8* %_0, i8** %a_local
	%_3 = load i8*, i8** %a
	; A23.getI1 : 1
	%_4 = bitcast i8* %_3 to i8***
	%_5 = load i8**, i8*** %_4
	%_6 = getelementptr i8*, i8** %_5, i32 1
	%_7 = load i8*, i8** %_6
	%_8 = bitcast i8* %_7 to i32 (i8*)*
	%_9 = call i32 %_8(i8* %_3)

	store i32 %_9, i32* %i4
	; B23.setI1 : 2
	%_10 = bitcast i8* %this to i8***
	%_11 = load i8**, i8*** %_10
	%_12 = getelementptr i8*, i8** %_11, i32 2
	%_13 = load i8*, i8** %_12
	%_14 = bitcast i8* %_13 to i32 (i8*, i32)*
	%_16 = load i32, i32* %i4
	%_15 = call i32 %_14(i8* %this, i32 %_16)

	store i32 %_15, i32* %i1
	%_17 = load i8*, i8** %a_local
	; A23.init : 0
	%_18 = bitcast i8* %_17 to i8***
	%_19 = load i8**, i8*** %_18
	%_20 = getelementptr i8*, i8** %_19, i32 0
	%_21 = load i8*, i8** %_20
	%_22 = bitcast i8* %_21 to i32 (i8*, i8*)*
	%_23 = call i32 %_22(i8* %_17, i8* %this)

	ret i32 %_23
}

define i32 @B23.getI1(i8* %this) {
	%_0 = load i32, i32* %i1
	ret i32 %_0
}

define i32 @B23.setI1(i8* %this, i32 %.i) {
	%i = alloca i32
	store i32 %.i, i32* %i
	%_0 = load i32, i32* %i
	%_1 = add i32 %_0, 111
	ret i32 %_1
}

define i32 @C23.init(i8* %this, i8* %.a) {
	%a = alloca i8*
	store i8* %.a, i8** %a
	store i32 333, i32* %i5
	; C23.setI1 : 2
	%_0 = bitcast i8* %this to i8***
	%_1 = load i8**, i8*** %_0
	%_2 = getelementptr i8*, i8** %_1, i32 2
	%_3 = load i8*, i8** %_2
	%_4 = bitcast i8* %_3 to i32 (i8*, i32)*
	%_6 = load i32, i32* %i5
	%_5 = call i32 %_4(i8* %this, i32 %_6)

	store i32 %_5, i32* %i1
	%_7 = load i8*, i8** %a
	; A23.init : 0
	%_8 = bitcast i8* %_7 to i8***
	%_9 = load i8**, i8*** %_8
	%_10 = getelementptr i8*, i8** %_9, i32 0
	%_11 = load i8*, i8** %_10
	%_12 = bitcast i8* %_11 to i32 (i8*, i8*)*
	%_13 = call i32 %_12(i8* %_7, i8* %this)

	ret i32 %_13
}

define i32 @C23.getI1(i8* %this) {
	%_0 = load i32, i32* %i1
	ret i32 %_0
}

define i32 @C23.setI1(i8* %this, i32 %.i) {
	%i = alloca i32
	store i32 %.i, i32* %i
	%_0 = load i32, i32* %i
	%_1 = mul i32 %_0, 2
	ret i32 %_1
}

