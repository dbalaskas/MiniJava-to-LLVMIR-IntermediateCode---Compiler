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
	br i1 %_2, label %oob_safe3, label %oob_error4

oob_error4:
	call void @throw_oob()

	br label %oob_safe3

oob_safe3:
	%_5 = add i32 1, %_0
	%_6 = call i8* @calloc(i32 %_5 , i32 4)
	%_7 = bitcast i8* %_6 to i32*
	store i32 %_0, i32* %_7

	store i32* %_7, i32** %intArray

	%_8 = getelementptr i8, i8* %this, i32 16
	%_9 = bitcast i8* %_8 to i32*
	store i32 0, i32* %_9

	%_10 = getelementptr i8, i8* %this, i32 16
	%_11 = bitcast i8* %_10 to i32*
	%_12 = load i32, i32* %_11
	call void (i32) @print_int(i32 %_12)

	%_13 = load i32*, i32** %intArray
	%_14 = load i32, i32* %_13	call void (i32) @print_int(i32 %_14)

	store i32 0, i32* %i

	call void (i32) @print_int(i32 111)


	br label %while_cond15

while_cond15:
	%_18 = load i32, i32* %i
	%_19 = load i32*, i32** %intArray
	%_20 = load i32, i32* %_19	%_21 = icmp slt i32 %_18, %_20
	br i1 %_21, label %while_body16, label %while_end17

while_body16:


	%_22 = load i32, i32* %i
	%_23 = add i32 %_22, 1
	call void (i32) @print_int(i32 %_23)

	%_24 = load i32, i32* %i
	%_25 = load i32, i32* %i
	%_26 = add i32 %_25, 1
	%_27 = load i32*, i32** %intArray
	%_28 = load i32, i32* %_27
	%_29 = icmp sge i32 %_24, 0
	%_30 = icmp slt i32 %_24, %_28
	%_31 = and i1 %_29, %_30
	br i1 %_31, label %oob_safe32, label %oob_error33

oob_error33:
	call void @throw_oob()

	br label %oob_safe32

oob_safe32:
	%_34 = add i32 %_24, 1
	%_35 = getelementptr i32, i32* %_27, i32 %_34
	store i32 %_26, i32* %_35


	%_36 = load i32, i32* %i
	%_37 = add i32 %_36, 1
	store i32 %_37, i32* %i

	br label %while_cond15

while_end17:

	call void (i32) @print_int(i32 222)

	store i32 0, i32* %i


	br label %while_cond38

while_cond38:
	%_41 = load i32, i32* %i
	%_42 = load i32*, i32** %intArray
	%_43 = load i32, i32* %_42	%_44 = icmp slt i32 %_41, %_43
	br i1 %_44, label %while_body39, label %while_end40

while_body39:


	%_45 = load i32*, i32** %intArray
	%_46 = load i32, i32* %i
	%_47 = load i32, i32* %_45
	%_48 = icmp sge i32 %_46, 0
	%_51 = icmp slt i32 %_46, %_47
	%_52 = and i1 %_48, %_51
	br i1 %_52, label %oob_safe49, label %oob_error50

oob_error50:
	call void @throw_oob()
	br label %oob_safe49

oob_safe49:
	%_53 = add i32 %_46, 1
	%_54 = getelementptr i32, i32* %_45, i32 %_53
	%_55 = load i32, i32* %_54
	call void (i32) @print_int(i32 %_55)

	%_56 = load i32, i32* %i
	%_57 = add i32 %_56, 1
	store i32 %_57, i32* %i

	br label %while_cond38

while_end40:

	call void (i32) @print_int(i32 333)
	%_58 = load i32*, i32** %intArray
	%_59 = load i32, i32* %_58	ret i32 %_59
}

define i32 @B.test(i8* %this, i32 %.num) {
	%num = alloca i32
	store i32 %.num, i32* %num
	%i = alloca i32

	%intArray = alloca i32*


	%_0 = load i32, i32* %num
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

	store i32* %_7, i32** %intArray

	%_8 = getelementptr i8, i8* %this, i32 20
	%_9 = bitcast i8* %_8 to i32*
	store i32 12, i32* %_9

	%_10 = getelementptr i8, i8* %this, i32 20
	%_11 = bitcast i8* %_10 to i32*
	%_12 = load i32, i32* %_11
	call void (i32) @print_int(i32 %_12)

	%_13 = load i32*, i32** %intArray
	%_14 = load i32, i32* %_13	call void (i32) @print_int(i32 %_14)

	store i32 0, i32* %i

	call void (i32) @print_int(i32 111)


	br label %while_cond15

while_cond15:
	%_18 = load i32, i32* %i
	%_19 = load i32*, i32** %intArray
	%_20 = load i32, i32* %_19	%_21 = icmp slt i32 %_18, %_20
	br i1 %_21, label %while_body16, label %while_end17

while_body16:


	%_22 = load i32, i32* %i
	%_23 = add i32 %_22, 1
	call void (i32) @print_int(i32 %_23)

	%_24 = load i32, i32* %i
	%_25 = load i32, i32* %i
	%_26 = add i32 %_25, 1
	%_27 = load i32*, i32** %intArray
	%_28 = load i32, i32* %_27
	%_29 = icmp sge i32 %_24, 0
	%_30 = icmp slt i32 %_24, %_28
	%_31 = and i1 %_29, %_30
	br i1 %_31, label %oob_safe32, label %oob_error33

oob_error33:
	call void @throw_oob()

	br label %oob_safe32

oob_safe32:
	%_34 = add i32 %_24, 1
	%_35 = getelementptr i32, i32* %_27, i32 %_34
	store i32 %_26, i32* %_35


	%_36 = load i32, i32* %i
	%_37 = add i32 %_36, 1
	store i32 %_37, i32* %i

	br label %while_cond15

while_end17:

	call void (i32) @print_int(i32 222)

	store i32 0, i32* %i


	br label %while_cond38

while_cond38:
	%_41 = load i32, i32* %i
	%_42 = load i32*, i32** %intArray
	%_43 = load i32, i32* %_42	%_44 = icmp slt i32 %_41, %_43
	br i1 %_44, label %while_body39, label %while_end40

while_body39:


	%_45 = load i32*, i32** %intArray
	%_46 = load i32, i32* %i
	%_47 = load i32, i32* %_45
	%_48 = icmp sge i32 %_46, 0
	%_51 = icmp slt i32 %_46, %_47
	%_52 = and i1 %_48, %_51
	br i1 %_52, label %oob_safe49, label %oob_error50

oob_error50:
	call void @throw_oob()
	br label %oob_safe49

oob_safe49:
	%_53 = add i32 %_46, 1
	%_54 = getelementptr i32, i32* %_45, i32 %_53
	%_55 = load i32, i32* %_54
	call void (i32) @print_int(i32 %_55)

	%_56 = load i32, i32* %i
	%_57 = add i32 %_56, 1
	store i32 %_57, i32* %i

	br label %while_cond38

while_end40:

	call void (i32) @print_int(i32 333)
	%_58 = load i32*, i32** %intArray
	%_59 = load i32, i32* %_58	ret i32 %_59
}

