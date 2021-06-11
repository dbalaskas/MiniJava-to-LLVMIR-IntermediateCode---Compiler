@.Main_vtable = global [0 x i8*] []
@.ArrayTest_vtable = global [1 x i8*] [i8* bitcast (i32 (i8*, i32)* @ArrayTest.test to i8*)]
@.B_vtable = global [1 x i8*] [i8* bitcast (i32 (i8*, i32)* @B.test to i8*)]

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
	%ab = alloca i8*

	%_0 = call i8* @calloc(i32 1, i32 20)
	%_1 = bitcast i8* %_0 to i8***
	%_2 = getelementptr [1 x i8*], [1 x i8*]* @.ArrayTest_vtable, i32 0, i32 0
	store i8** %_2, i8*** %_1

	store i8* %_0, i8** %ab
	%_3 = load i8*, i8** %ab
	; ArrayTest.test : 0
	%_4 = bitcast i8* %_3 to i8***
	%_5 = load i8**, i8*** %_4
	%_6 = getelementptr i8*, i8** %_5, i32 0
	%_7 = load i8*, i8** %_6
	%_8 = bitcast i8* %_7 to i32 (i8*, i32)*
	%_9 = call i32 %_8(i8* %_3, i32 3)

	call void (i32) @print_int(i32 %_9)

	ret i32 0
}

define i32 @ArrayTest.test(i8* %this, i32 %.num) {
	%num = alloca i32
	store i32 %.num, i32* %num
	%i = alloca i32

	%intArray = alloca i32*

	%_0 = load i32, i32* %num
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

	store i32* %_3, i32** %intArray
	store i32 0, i32* %aaa
	%_6 = load i32, i32* %aaa
	call void (i32) @print_int(i32 %_6)
	%_7 = load i32*, i32** %intArray
	%_8 = load i32, i32* %_7	call void (i32) @print_int(i32 %_8)
	store i32 0, i32* %i
	call void (i32) @print_int(i32 111)
%cond9:
	%_12 = load i32, i32* %i
	%_13 = load i32*, i32** %intArray
	%_14 = load i32, i32* %_13	%_15 = icmp slt i32 %_12, %_14
	br i1 %_15, label %while10, label %end11

%while10:
	%_16 = load i32, i32* %i
	%_17 = add i32 %_16, 1
	call void (i32) @print_int(i32 %_17)
	%_18 = load i32, i32* %i
	%_19 = load i32, i32* %i
	%_20 = add i32 %_19, 1
	%_21 = loadi32*, i32** %intArray
	%_22 = load i32, i32* %_21
	%_23 = icmp sge i32 %_18, 0
	%_24 = icmp slt i32 %_18, %_22
	%_25 = and i1 %_23, %_24
	br i1 %_25, label %l0, label %l1

%l1:
	call void @throw_oob()
%l0:
	%_26 = add i32 %_18, 1
	%_27 = getelementptr i32, i32* %_21, i32 %_26
	store i32 %_20, i32* %_27

	%_28 = load i32, i32* %i
	%_29 = add i32 %_28, 1
	store i32 %_29, i32* %i
%end11:
	call void (i32) @print_int(i32 222)
	store i32 0, i32* %i
%cond30:
	%_33 = load i32, i32* %i
	%_34 = load i32*, i32** %intArray
	%_35 = load i32, i32* %_34	%_36 = icmp slt i32 %_33, %_35
	br i1 %_36, label %while31, label %end32

%while31:
	%_37 = load i32*, i32** %intArray
	%_38 = load i32, i32* %i
	%_39 = load i32, [Ljava.lang.String;@41906a77
	%_40 = icmp sge [Ljava.lang.String;@4b9af9a9, 0
	%_43 = icmp slt [Ljava.lang.String;@4b9af9a9, %_39
	%_44 = and i1 %_40, %_43
	br i1 %_44, label %oob_safe41, label %oob_error42

%oob_error42:
	call void @throw_oob()
	br label %oob_safe41

%oob_safe41:
	%_45 = add [Ljava.lang.String;@4b9af9a9, 1
	%_46 = getelementptr i32, [Ljava.lang.String;@41906a77, i32 %_45
	%_47 = load i32, i32* %_46
	call void (i32) @print_int(i32 %_47)
	%_48 = load i32, i32* %i
	%_49 = add i32 %_48, 1
	store i32 %_49, i32* %i
%end32:
	call void (i32) @print_int(i32 333)
	%_50 = load i32*, i32** %intArray
	%_51 = load i32, i32* %_50	ret i32 %_51
}

define i32 @B.test(i8* %this, i32 %.num) {
	%num = alloca i32
	store i32 %.num, i32* %num
	%i = alloca i32

	%intArray = alloca i32*

	%_0 = load i32, i32* %num
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

	store i32* %_3, i32** %intArray
	store i32 12, i32* %aaa
	%_6 = load i32, i32* %aaa
	call void (i32) @print_int(i32 %_6)
	%_7 = load i32*, i32** %intArray
	%_8 = load i32, i32* %_7	call void (i32) @print_int(i32 %_8)
	store i32 0, i32* %i
	call void (i32) @print_int(i32 111)
%cond9:
	%_12 = load i32, i32* %i
	%_13 = load i32*, i32** %intArray
	%_14 = load i32, i32* %_13	%_15 = icmp slt i32 %_12, %_14
	br i1 %_15, label %while10, label %end11

%while10:
	%_16 = load i32, i32* %i
	%_17 = add i32 %_16, 1
	call void (i32) @print_int(i32 %_17)
	%_18 = load i32, i32* %i
	%_19 = load i32, i32* %i
	%_20 = add i32 %_19, 1
	%_21 = loadi32*, i32** %intArray
	%_22 = load i32, i32* %_21
	%_23 = icmp sge i32 %_18, 0
	%_24 = icmp slt i32 %_18, %_22
	%_25 = and i1 %_23, %_24
	br i1 %_25, label %l0, label %l1

%l1:
	call void @throw_oob()
%l0:
	%_26 = add i32 %_18, 1
	%_27 = getelementptr i32, i32* %_21, i32 %_26
	store i32 %_20, i32* %_27

	%_28 = load i32, i32* %i
	%_29 = add i32 %_28, 1
	store i32 %_29, i32* %i
%end11:
	call void (i32) @print_int(i32 222)
	store i32 0, i32* %i
%cond30:
	%_33 = load i32, i32* %i
	%_34 = load i32*, i32** %intArray
	%_35 = load i32, i32* %_34	%_36 = icmp slt i32 %_33, %_35
	br i1 %_36, label %while31, label %end32

%while31:
	%_37 = load i32*, i32** %intArray
	%_38 = load i32, i32* %i
	%_39 = load i32, [Ljava.lang.String;@5387f9e0
	%_40 = icmp sge [Ljava.lang.String;@6e5e91e4, 0
	%_43 = icmp slt [Ljava.lang.String;@6e5e91e4, %_39
	%_44 = and i1 %_40, %_43
	br i1 %_44, label %oob_safe41, label %oob_error42

%oob_error42:
	call void @throw_oob()
	br label %oob_safe41

%oob_safe41:
	%_45 = add [Ljava.lang.String;@6e5e91e4, 1
	%_46 = getelementptr i32, [Ljava.lang.String;@5387f9e0, i32 %_45
	%_47 = load i32, i32* %_46
	call void (i32) @print_int(i32 %_47)
	%_48 = load i32, i32* %i
	%_49 = add i32 %_48, 1
	store i32 %_49, i32* %i
%end32:
	call void (i32) @print_int(i32 333)
	%_50 = load i32*, i32** %intArray
	%_51 = load i32, i32* %_50	ret i32 %_51
}

