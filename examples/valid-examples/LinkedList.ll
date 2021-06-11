@.LinkedList_vtable = global [0 x i8*] []
@.Element_vtable = global [6 x i8*] [i8* bitcast (i1 (i8*, i32, i32, i1)* @Element.Init to i8*), i8* bitcast (i32 (i8*)* @Element.GetAge to i8*), i8* bitcast (i32 (i8*)* @Element.GetSalary to i8*), i8* bitcast (i1 (i8*)* @Element.GetMarried to i8*), i8* bitcast (i1 (i8*, i8*)* @Element.Equal to i8*), i8* bitcast (i1 (i8*, i32, i32)* @Element.Compare to i8*)]
@.List_vtable = global [10 x i8*] [i8* bitcast (i1 (i8*)* @List.Init to i8*), i8* bitcast (i1 (i8*, i8*, i8*, i1)* @List.InitNew to i8*), i8* bitcast (i8* (i8*, i8*)* @List.Insert to i8*), i8* bitcast (i1 (i8*, i8*)* @List.SetNext to i8*), i8* bitcast (i8* (i8*, i8*)* @List.Delete to i8*), i8* bitcast (i32 (i8*, i8*)* @List.Search to i8*), i8* bitcast (i1 (i8*)* @List.GetEnd to i8*), i8* bitcast (i8* (i8*)* @List.GetElem to i8*), i8* bitcast (i8* (i8*)* @List.GetNext to i8*), i8* bitcast (i1 (i8*)* @List.Print to i8*)]
@.LL_vtable = global [1 x i8*] [i8* bitcast (i32 (i8*)* @LL.Start to i8*)]

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
	%_2 = getelementptr [1 x i8*], [1 x i8*]* @.LL_vtable, i32 0, i32 0
	store i8** %_2, i8*** %_1

	; LL.Start : 0
	%_3 = bitcast i8* %_0 to i8***
	%_4 = load i8**, i8*** %_3
	%_5 = getelementptr i8*, i8** %_4, i32 0
	%_6 = load i8*, i8** %_5
	%_7 = bitcast i8* %_6 to i32 (i8*)*
	%_8 = call i32 %_7(i8* %_0)

	call void (i32) @print_int(i32 %_8)

	ret i32 0
}

define i1 @Element.Init(i8* %this, i32 %.v_Age, i32 %.v_Salary, i1 %.v_Married) {
	%v_Age = alloca i32
	store i32 %.v_Age, i32* %v_Age
	%v_Salary = alloca i32
	store i32 %.v_Salary, i32* %v_Salary
	%v_Married = alloca i1
	store i1 %.v_Married, i1* %v_Married
	%_0 = load i32, i32* %v_Age
	store i32 %_0, i32* %Age
	%_1 = load i32, i32* %v_Salary
	store i32 %_1, i32* %Salary
	%_2 = load i1, i1* %v_Married
	store i1 %_2, i1* %Married
	ret i1 1
}

define i32 @Element.GetAge(i8* %this) {
	%_0 = load i32, i32* %Age
	ret i32 %_0
}

define i32 @Element.GetSalary(i8* %this) {
	%_0 = load i32, i32* %Salary
	ret i32 %_0
}

define i1 @Element.GetMarried(i8* %this) {
	%_0 = load i1, i1* %Married
	ret i1 %_0
}

define i1 @Element.Equal(i8* %this, i8* %.other) {
	%other = alloca i8*
	store i8* %.other, i8** %other
	%ret_val = alloca i1

	%aux01 = alloca i32

	%aux02 = alloca i32

	%nt = alloca i32

	store i1 1, i1* %ret_val
	%_0 = load i8*, i8** %other
	; Element.GetAge : 1
	%_1 = bitcast i8* %_0 to i8***
	%_2 = load i8**, i8*** %_1
	%_3 = getelementptr i8*, i8** %_2, i32 1
	%_4 = load i8*, i8** %_3
	%_5 = bitcast i8* %_4 to i32 (i8*)*
	%_6 = call i32 %_5(i8* %_0)

	store i32 %_6, i32* %aux01
	; Element.Compare : 5
	%_7 = bitcast i8* %this to i8***
	%_8 = load i8**, i8*** %_7
	%_9 = getelementptr i8*, i8** %_8, i32 5
	%_10 = load i8*, i8** %_9
	%_11 = bitcast i8* %_10 to i1 (i8*, i32, i32)*
	%_13 = load i32, i32* %aux01
	%_14 = load i32, i32* %Age
	%_12 = call i1 %_11(i8* %this, i32 %_13, i32 %_14)

	%_15 = xor i1 1, %_12	br i1 %_15, label %then16, label %else17

%then16:
	store i1 0, i1* %ret_val

	br  label %end18

%else17:
	%_19 = load i8*, i8** %other
	; Element.GetSalary : 2
	%_20 = bitcast i8* %_19 to i8***
	%_21 = load i8**, i8*** %_20
	%_22 = getelementptr i8*, i8** %_21, i32 2
	%_23 = load i8*, i8** %_22
	%_24 = bitcast i8* %_23 to i32 (i8*)*
	%_25 = call i32 %_24(i8* %_19)

	store i32 %_25, i32* %aux02
	; Element.Compare : 5
	%_26 = bitcast i8* %this to i8***
	%_27 = load i8**, i8*** %_26
	%_28 = getelementptr i8*, i8** %_27, i32 5
	%_29 = load i8*, i8** %_28
	%_30 = bitcast i8* %_29 to i1 (i8*, i32, i32)*
	%_32 = load i32, i32* %aux02
	%_33 = load i32, i32* %Salary
	%_31 = call i1 %_30(i8* %this, i32 %_32, i32 %_33)

	%_34 = xor i1 1, %_31	br i1 %_34, label %then35, label %else36

%then35:
	store i1 0, i1* %ret_val

	br  label %end37

%else36:
	%_38 = load i1, i1* %Married
	br i1 %_38, label %then39, label %else40

%then39:
	%_42 = load i8*, i8** %other
	; Element.GetMarried : 3
	%_43 = bitcast i8* %_42 to i8***
	%_44 = load i8**, i8*** %_43
	%_45 = getelementptr i8*, i8** %_44, i32 3
	%_46 = load i8*, i8** %_45
	%_47 = bitcast i8* %_46 to i1 (i8*)*
	%_48 = call i1 %_47(i8* %_42)

	%_49 = xor i1 1, %_48	br i1 %_49, label %then50, label %else51

%then50:
	store i1 0, i1* %ret_val

	br  label %end52

%else51:
	store i32 0, i32* %nt
%end52:

	br  label %end41

%else40:
	%_53 = load i8*, i8** %other
	; Element.GetMarried : 3
	%_54 = bitcast i8* %_53 to i8***
	%_55 = load i8**, i8*** %_54
	%_56 = getelementptr i8*, i8** %_55, i32 3
	%_57 = load i8*, i8** %_56
	%_58 = bitcast i8* %_57 to i1 (i8*)*
	%_59 = call i1 %_58(i8* %_53)

	br i1 %_59, label %then60, label %else61

%then60:
	store i1 0, i1* %ret_val

	br  label %end62

%else61:
	store i32 0, i32* %nt
%end62:
%end41:
%end37:
%end18:
	%_63 = load i1, i1* %ret_val
	ret i1 %_63
}

define i1 @Element.Compare(i8* %this, i32 %.num1, i32 %.num2) {
	%num1 = alloca i32
	store i32 %.num1, i32* %num1
	%num2 = alloca i32
	store i32 %.num2, i32* %num2
	%retval = alloca i1

	%aux02 = alloca i32

	store i1 0, i1* %retval
	%_0 = load i32, i32* %num2
	%_1 = add i32 %_0, 1
	store i32 %_1, i32* %aux02
	%_2 = load i32, i32* %num1
	%_3 = load i32, i32* %num2
	%_4 = icmp slt i32 %_2, %_3
	br i1 %_4, label %then5, label %else6

%then5:
	store i1 0, i1* %retval

	br  label %end7

%else6:
	%_8 = load i32, i32* %num1
	%_9 = load i32, i32* %aux02
	%_10 = icmp slt i32 %_8, %_9
	%_11 = xor i1 1, %_10	br i1 %_11, label %then12, label %else13

%then12:
	store i1 0, i1* %retval

	br  label %end14

%else13:
	store i1 1, i1* %retval
%end14:
%end7:
	%_15 = load i1, i1* %retval
	ret i1 %_15
}

define i1 @List.Init(i8* %this) {
	store i1 1, i1* %end
	ret i1 1
}

define i1 @List.InitNew(i8* %this, i8* %.v_elem, i8* %.v_next, i1 %.v_end) {
	%v_elem = alloca i8*
	store i8* %.v_elem, i8** %v_elem
	%v_next = alloca i8*
	store i8* %.v_next, i8** %v_next
	%v_end = alloca i1
	store i1 %.v_end, i1* %v_end
	%_0 = load i1, i1* %v_end
	store i1 %_0, i1* %end
	%_1 = load i8*, i8** %v_elem
	store i8* %_1, i8** %elem
	%_2 = load i8*, i8** %v_next
	store i8* %_2, i8** %next
	ret i1 1
}

define i8* @List.Insert(i8* %this, i8* %.new_elem) {
	%new_elem = alloca i8*
	store i8* %.new_elem, i8** %new_elem
	%ret_val = alloca i1

	%aux03 = alloca i8*

	%aux02 = alloca i8*

	store i8* %this, i8** %aux03
	%_0 = call i8* @calloc(i32 1, i32 25)
	%_1 = bitcast i8* %_0 to i8***
	%_2 = getelementptr [10 x i8*], [10 x i8*]* @.List_vtable, i32 0, i32 0
	store i8** %_2, i8*** %_1

	store i8* %_0, i8** %aux02
	%_3 = load i8*, i8** %aux02
	; List.InitNew : 1
	%_4 = bitcast i8* %_3 to i8***
	%_5 = load i8**, i8*** %_4
	%_6 = getelementptr i8*, i8** %_5, i32 1
	%_7 = load i8*, i8** %_6
	%_8 = bitcast i8* %_7 to i1 (i8*, i8*, i8*, i1)*
	%_10 = load i8*, i8** %new_elem
	%_11 = load i8*, i8** %aux03
	%_9 = call i1 %_8(i8* %_3, i8* %_10, i8* %_11, i1 0)

	store i1 %_9, i1* %ret_val
	%_12 = load i8*, i8** %aux02
	ret i8* %_12
}

define i1 @List.SetNext(i8* %this, i8* %.v_next) {
	%v_next = alloca i8*
	store i8* %.v_next, i8** %v_next
	%_0 = load i8*, i8** %v_next
	store i8* %_0, i8** %next
	ret i1 1
}

define i8* @List.Delete(i8* %this, i8* %.e) {
	%e = alloca i8*
	store i8* %.e, i8** %e
	%my_head = alloca i8*

	%ret_val = alloca i1

	%aux05 = alloca i1

	%aux01 = alloca i8*

	%prev = alloca i8*

	%var_end = alloca i1

	%var_elem = alloca i8*

	%aux04 = alloca i32

	%nt = alloca i32

	store i8* %this, i8** %my_head
	store i1 0, i1* %ret_val
	%_0 = sub i32 0, 1
	store i32 %_0, i32* %aux04
	store i8* %this, i8** %aux01
	store i8* %this, i8** %prev
	%_1 = load i1, i1* %end
	store i1 %_1, i1* %var_end
	%_2 = load i8*, i8** %elem
	store i8* %_2, i8** %var_elem
%cond3:
	%_6 = load i1, i1* %var_end
	%_7 = xor i1 1, %_6	store i1 %_7, i1 %_8
	br i1 %_7, label %l1, label %l0

%l1:
	%_9 = load i1, i1* %ret_val
	%_10 = xor i1 1, %_9	store i1 %_10, i1 %_8
%l0:
	br %_8, label %while4, label %end5

%while4:
	%_11 = load i8*, i8** %e
	; Element.Equal : 4
	%_12 = bitcast i8* %_11 to i8***
	%_13 = load i8**, i8*** %_12
	%_14 = getelementptr i8*, i8** %_13, i32 4
	%_15 = load i8*, i8** %_14
	%_16 = bitcast i8* %_15 to i1 (i8*, i8*)*
	%_18 = load i8*, i8** %var_elem
	%_17 = call i1 %_16(i8* %_11, i8* %_18)

	br i1 %_17, label %then19, label %else20

%then19:
	store i1 1, i1* %ret_val
	%_22 = load i32, i32* %aux04
	%_23 = icmp slt i32 %_22, 0
	br i1 %_23, label %then24, label %else25

%then24:
	%_27 = load i8*, i8** %aux01
	; List.GetNext : 8
	%_28 = bitcast i8* %_27 to i8***
	%_29 = load i8**, i8*** %_28
	%_30 = getelementptr i8*, i8** %_29, i32 8
	%_31 = load i8*, i8** %_30
	%_32 = bitcast i8* %_31 to i8* (i8*)*
	%_33 = call i8* %_32(i8* %_27)

	store i8* %_33, i8** %my_head

	br  label %end26

%else25:
	%_34 = sub i32 0, 555
	call void (i32) @print_int(i32 %_34)
	%_35 = load i8*, i8** %prev
	; List.SetNext : 3
	%_36 = bitcast i8* %_35 to i8***
	%_37 = load i8**, i8*** %_36
	%_38 = getelementptr i8*, i8** %_37, i32 3
	%_39 = load i8*, i8** %_38
	%_40 = bitcast i8* %_39 to i1 (i8*, i8*)*
	%_42 = load i8*, i8** %aux01
	; List.GetNext : 8
	%_43 = bitcast i8* %_42 to i8***
	%_44 = load i8**, i8*** %_43
	%_45 = getelementptr i8*, i8** %_44, i32 8
	%_46 = load i8*, i8** %_45
	%_47 = bitcast i8* %_46 to i8* (i8*)*
	%_48 = call i8* %_47(i8* %_42)

	%_41 = call i1 %_40(i8* %_35, i8* %_48)

	store i1 %_41, i1* %aux05
	%_49 = sub i32 0, 555
	call void (i32) @print_int(i32 %_49)
%end26:

	br  label %end21

%else20:
	store i32 0, i32* %nt
%end21:
	%_50 = load i1, i1* %ret_val
	%_51 = xor i1 1, %_50	br i1 %_51, label %then52, label %else53

%then52:
	%_55 = load i8*, i8** %aux01
	store i8* %_55, i8** %prev
	%_56 = load i8*, i8** %aux01
	; List.GetNext : 8
	%_57 = bitcast i8* %_56 to i8***
	%_58 = load i8**, i8*** %_57
	%_59 = getelementptr i8*, i8** %_58, i32 8
	%_60 = load i8*, i8** %_59
	%_61 = bitcast i8* %_60 to i8* (i8*)*
	%_62 = call i8* %_61(i8* %_56)

	store i8* %_62, i8** %aux01
	%_63 = load i8*, i8** %aux01
	; List.GetEnd : 6
	%_64 = bitcast i8* %_63 to i8***
	%_65 = load i8**, i8*** %_64
	%_66 = getelementptr i8*, i8** %_65, i32 6
	%_67 = load i8*, i8** %_66
	%_68 = bitcast i8* %_67 to i1 (i8*)*
	%_69 = call i1 %_68(i8* %_63)

	store i1 %_69, i1* %var_end
	%_70 = load i8*, i8** %aux01
	; List.GetElem : 7
	%_71 = bitcast i8* %_70 to i8***
	%_72 = load i8**, i8*** %_71
	%_73 = getelementptr i8*, i8** %_72, i32 7
	%_74 = load i8*, i8** %_73
	%_75 = bitcast i8* %_74 to i8* (i8*)*
	%_76 = call i8* %_75(i8* %_70)

	store i8* %_76, i8** %var_elem
	store i32 1, i32* %aux04

	br  label %end54

%else53:
	store i32 0, i32* %nt
%end54:
%end5:
	%_77 = load i8*, i8** %my_head
	ret i8* %_77
}

define i32 @List.Search(i8* %this, i8* %.e) {
	%e = alloca i8*
	store i8* %.e, i8** %e
	%int_ret_val = alloca i32

	%aux01 = alloca i8*

	%var_elem = alloca i8*

	%var_end = alloca i1

	%nt = alloca i32

	store i32 0, i32* %int_ret_val
	store i8* %this, i8** %aux01
	%_0 = load i1, i1* %end
	store i1 %_0, i1* %var_end
	%_1 = load i8*, i8** %elem
	store i8* %_1, i8** %var_elem
%cond2:
	%_5 = load i1, i1* %var_end
	%_6 = xor i1 1, %_5	br i1 %_6, label %while3, label %end4

%while3:
	%_7 = load i8*, i8** %e
	; Element.Equal : 4
	%_8 = bitcast i8* %_7 to i8***
	%_9 = load i8**, i8*** %_8
	%_10 = getelementptr i8*, i8** %_9, i32 4
	%_11 = load i8*, i8** %_10
	%_12 = bitcast i8* %_11 to i1 (i8*, i8*)*
	%_14 = load i8*, i8** %var_elem
	%_13 = call i1 %_12(i8* %_7, i8* %_14)

	br i1 %_13, label %then15, label %else16

%then15:
	store i32 1, i32* %int_ret_val

	br  label %end17

%else16:
	store i32 0, i32* %nt
%end17:
	%_18 = load i8*, i8** %aux01
	; List.GetNext : 8
	%_19 = bitcast i8* %_18 to i8***
	%_20 = load i8**, i8*** %_19
	%_21 = getelementptr i8*, i8** %_20, i32 8
	%_22 = load i8*, i8** %_21
	%_23 = bitcast i8* %_22 to i8* (i8*)*
	%_24 = call i8* %_23(i8* %_18)

	store i8* %_24, i8** %aux01
	%_25 = load i8*, i8** %aux01
	; List.GetEnd : 6
	%_26 = bitcast i8* %_25 to i8***
	%_27 = load i8**, i8*** %_26
	%_28 = getelementptr i8*, i8** %_27, i32 6
	%_29 = load i8*, i8** %_28
	%_30 = bitcast i8* %_29 to i1 (i8*)*
	%_31 = call i1 %_30(i8* %_25)

	store i1 %_31, i1* %var_end
	%_32 = load i8*, i8** %aux01
	; List.GetElem : 7
	%_33 = bitcast i8* %_32 to i8***
	%_34 = load i8**, i8*** %_33
	%_35 = getelementptr i8*, i8** %_34, i32 7
	%_36 = load i8*, i8** %_35
	%_37 = bitcast i8* %_36 to i8* (i8*)*
	%_38 = call i8* %_37(i8* %_32)

	store i8* %_38, i8** %var_elem
%end4:
	%_39 = load i32, i32* %int_ret_val
	ret i32 %_39
}

define i1 @List.GetEnd(i8* %this) {
	%_0 = load i1, i1* %end
	ret i1 %_0
}

define i8* @List.GetElem(i8* %this) {
	%_0 = load i8*, i8** %elem
	ret i8* %_0
}

define i8* @List.GetNext(i8* %this) {
	%_0 = load i8*, i8** %next
	ret i8* %_0
}

define i1 @List.Print(i8* %this) {
	%aux01 = alloca i8*

	%var_end = alloca i1

	%var_elem = alloca i8*

	store i8* %this, i8** %aux01
	%_0 = load i1, i1* %end
	store i1 %_0, i1* %var_end
	%_1 = load i8*, i8** %elem
	store i8* %_1, i8** %var_elem
%cond2:
	%_5 = load i1, i1* %var_end
	%_6 = xor i1 1, %_5	br i1 %_6, label %while3, label %end4

%while3:
	%_7 = load i8*, i8** %var_elem
	; Element.GetAge : 1
	%_8 = bitcast i8* %_7 to i8***
	%_9 = load i8**, i8*** %_8
	%_10 = getelementptr i8*, i8** %_9, i32 1
	%_11 = load i8*, i8** %_10
	%_12 = bitcast i8* %_11 to i32 (i8*)*
	%_13 = call i32 %_12(i8* %_7)

	call void (i32) @print_int(i32 %_13)
	%_14 = load i8*, i8** %aux01
	; List.GetNext : 8
	%_15 = bitcast i8* %_14 to i8***
	%_16 = load i8**, i8*** %_15
	%_17 = getelementptr i8*, i8** %_16, i32 8
	%_18 = load i8*, i8** %_17
	%_19 = bitcast i8* %_18 to i8* (i8*)*
	%_20 = call i8* %_19(i8* %_14)

	store i8* %_20, i8** %aux01
	%_21 = load i8*, i8** %aux01
	; List.GetEnd : 6
	%_22 = bitcast i8* %_21 to i8***
	%_23 = load i8**, i8*** %_22
	%_24 = getelementptr i8*, i8** %_23, i32 6
	%_25 = load i8*, i8** %_24
	%_26 = bitcast i8* %_25 to i1 (i8*)*
	%_27 = call i1 %_26(i8* %_21)

	store i1 %_27, i1* %var_end
	%_28 = load i8*, i8** %aux01
	; List.GetElem : 7
	%_29 = bitcast i8* %_28 to i8***
	%_30 = load i8**, i8*** %_29
	%_31 = getelementptr i8*, i8** %_30, i32 7
	%_32 = load i8*, i8** %_31
	%_33 = bitcast i8* %_32 to i8* (i8*)*
	%_34 = call i8* %_33(i8* %_28)

	store i8* %_34, i8** %var_elem
%end4:
	ret i1 1
}

define i32 @LL.Start(i8* %this) {
	%head = alloca i8*

	%last_elem = alloca i8*

	%aux01 = alloca i1

	%el01 = alloca i8*

	%el02 = alloca i8*

	%el03 = alloca i8*

	%_0 = call i8* @calloc(i32 1, i32 25)
	%_1 = bitcast i8* %_0 to i8***
	%_2 = getelementptr [10 x i8*], [10 x i8*]* @.List_vtable, i32 0, i32 0
	store i8** %_2, i8*** %_1

	store i8* %_0, i8** %last_elem
	%_3 = load i8*, i8** %last_elem
	; List.Init : 0
	%_4 = bitcast i8* %_3 to i8***
	%_5 = load i8**, i8*** %_4
	%_6 = getelementptr i8*, i8** %_5, i32 0
	%_7 = load i8*, i8** %_6
	%_8 = bitcast i8* %_7 to i1 (i8*)*
	%_9 = call i1 %_8(i8* %_3)

	store i1 %_9, i1* %aux01
	%_10 = load i8*, i8** %last_elem
	store i8* %_10, i8** %head
	%_11 = load i8*, i8** %head
	; List.Init : 0
	%_12 = bitcast i8* %_11 to i8***
	%_13 = load i8**, i8*** %_12
	%_14 = getelementptr i8*, i8** %_13, i32 0
	%_15 = load i8*, i8** %_14
	%_16 = bitcast i8* %_15 to i1 (i8*)*
	%_17 = call i1 %_16(i8* %_11)

	store i1 %_17, i1* %aux01
	%_18 = load i8*, i8** %head
	; List.Print : 9
	%_19 = bitcast i8* %_18 to i8***
	%_20 = load i8**, i8*** %_19
	%_21 = getelementptr i8*, i8** %_20, i32 9
	%_22 = load i8*, i8** %_21
	%_23 = bitcast i8* %_22 to i1 (i8*)*
	%_24 = call i1 %_23(i8* %_18)

	store i1 %_24, i1* %aux01
	%_25 = call i8* @calloc(i32 1, i32 17)
	%_26 = bitcast i8* %_25 to i8***
	%_27 = getelementptr [6 x i8*], [6 x i8*]* @.Element_vtable, i32 0, i32 0
	store i8** %_27, i8*** %_26

	store i8* %_25, i8** %el01
	%_28 = load i8*, i8** %el01
	; Element.Init : 0
	%_29 = bitcast i8* %_28 to i8***
	%_30 = load i8**, i8*** %_29
	%_31 = getelementptr i8*, i8** %_30, i32 0
	%_32 = load i8*, i8** %_31
	%_33 = bitcast i8* %_32 to i1 (i8*, i32, i32, i1)*
	%_34 = call i1 %_33(i8* %_28, i32 25, i32 37000, i1 0)

	store i1 %_34, i1* %aux01
	%_35 = load i8*, i8** %head
	; List.Insert : 2
	%_36 = bitcast i8* %_35 to i8***
	%_37 = load i8**, i8*** %_36
	%_38 = getelementptr i8*, i8** %_37, i32 2
	%_39 = load i8*, i8** %_38
	%_40 = bitcast i8* %_39 to i8* (i8*, i8*)*
	%_42 = load i8*, i8** %el01
	%_41 = call i8* %_40(i8* %_35, i8* %_42)

	store i8* %_41, i8** %head
	%_43 = load i8*, i8** %head
	; List.Print : 9
	%_44 = bitcast i8* %_43 to i8***
	%_45 = load i8**, i8*** %_44
	%_46 = getelementptr i8*, i8** %_45, i32 9
	%_47 = load i8*, i8** %_46
	%_48 = bitcast i8* %_47 to i1 (i8*)*
	%_49 = call i1 %_48(i8* %_43)

	store i1 %_49, i1* %aux01
	call void (i32) @print_int(i32 10000000)
	%_50 = call i8* @calloc(i32 1, i32 17)
	%_51 = bitcast i8* %_50 to i8***
	%_52 = getelementptr [6 x i8*], [6 x i8*]* @.Element_vtable, i32 0, i32 0
	store i8** %_52, i8*** %_51

	store i8* %_50, i8** %el01
	%_53 = load i8*, i8** %el01
	; Element.Init : 0
	%_54 = bitcast i8* %_53 to i8***
	%_55 = load i8**, i8*** %_54
	%_56 = getelementptr i8*, i8** %_55, i32 0
	%_57 = load i8*, i8** %_56
	%_58 = bitcast i8* %_57 to i1 (i8*, i32, i32, i1)*
	%_59 = call i1 %_58(i8* %_53, i32 39, i32 42000, i1 1)

	store i1 %_59, i1* %aux01
	%_60 = load i8*, i8** %el01
	store i8* %_60, i8** %el02
	%_61 = load i8*, i8** %head
	; List.Insert : 2
	%_62 = bitcast i8* %_61 to i8***
	%_63 = load i8**, i8*** %_62
	%_64 = getelementptr i8*, i8** %_63, i32 2
	%_65 = load i8*, i8** %_64
	%_66 = bitcast i8* %_65 to i8* (i8*, i8*)*
	%_68 = load i8*, i8** %el01
	%_67 = call i8* %_66(i8* %_61, i8* %_68)

	store i8* %_67, i8** %head
	%_69 = load i8*, i8** %head
	; List.Print : 9
	%_70 = bitcast i8* %_69 to i8***
	%_71 = load i8**, i8*** %_70
	%_72 = getelementptr i8*, i8** %_71, i32 9
	%_73 = load i8*, i8** %_72
	%_74 = bitcast i8* %_73 to i1 (i8*)*
	%_75 = call i1 %_74(i8* %_69)

	store i1 %_75, i1* %aux01
	call void (i32) @print_int(i32 10000000)
	%_76 = call i8* @calloc(i32 1, i32 17)
	%_77 = bitcast i8* %_76 to i8***
	%_78 = getelementptr [6 x i8*], [6 x i8*]* @.Element_vtable, i32 0, i32 0
	store i8** %_78, i8*** %_77

	store i8* %_76, i8** %el01
	%_79 = load i8*, i8** %el01
	; Element.Init : 0
	%_80 = bitcast i8* %_79 to i8***
	%_81 = load i8**, i8*** %_80
	%_82 = getelementptr i8*, i8** %_81, i32 0
	%_83 = load i8*, i8** %_82
	%_84 = bitcast i8* %_83 to i1 (i8*, i32, i32, i1)*
	%_85 = call i1 %_84(i8* %_79, i32 22, i32 34000, i1 0)

	store i1 %_85, i1* %aux01
	%_86 = load i8*, i8** %head
	; List.Insert : 2
	%_87 = bitcast i8* %_86 to i8***
	%_88 = load i8**, i8*** %_87
	%_89 = getelementptr i8*, i8** %_88, i32 2
	%_90 = load i8*, i8** %_89
	%_91 = bitcast i8* %_90 to i8* (i8*, i8*)*
	%_93 = load i8*, i8** %el01
	%_92 = call i8* %_91(i8* %_86, i8* %_93)

	store i8* %_92, i8** %head
	%_94 = load i8*, i8** %head
	; List.Print : 9
	%_95 = bitcast i8* %_94 to i8***
	%_96 = load i8**, i8*** %_95
	%_97 = getelementptr i8*, i8** %_96, i32 9
	%_98 = load i8*, i8** %_97
	%_99 = bitcast i8* %_98 to i1 (i8*)*
	%_100 = call i1 %_99(i8* %_94)

	store i1 %_100, i1* %aux01
	%_101 = call i8* @calloc(i32 1, i32 17)
	%_102 = bitcast i8* %_101 to i8***
	%_103 = getelementptr [6 x i8*], [6 x i8*]* @.Element_vtable, i32 0, i32 0
	store i8** %_103, i8*** %_102

	store i8* %_101, i8** %el03
	%_104 = load i8*, i8** %el03
	; Element.Init : 0
	%_105 = bitcast i8* %_104 to i8***
	%_106 = load i8**, i8*** %_105
	%_107 = getelementptr i8*, i8** %_106, i32 0
	%_108 = load i8*, i8** %_107
	%_109 = bitcast i8* %_108 to i1 (i8*, i32, i32, i1)*
	%_110 = call i1 %_109(i8* %_104, i32 27, i32 34000, i1 0)

	store i1 %_110, i1* %aux01
	%_111 = load i8*, i8** %head
	; List.Search : 5
	%_112 = bitcast i8* %_111 to i8***
	%_113 = load i8**, i8*** %_112
	%_114 = getelementptr i8*, i8** %_113, i32 5
	%_115 = load i8*, i8** %_114
	%_116 = bitcast i8* %_115 to i32 (i8*, i8*)*
	%_118 = load i8*, i8** %el02
	%_117 = call i32 %_116(i8* %_111, i8* %_118)

	call void (i32) @print_int(i32 %_117)
	%_119 = load i8*, i8** %head
	; List.Search : 5
	%_120 = bitcast i8* %_119 to i8***
	%_121 = load i8**, i8*** %_120
	%_122 = getelementptr i8*, i8** %_121, i32 5
	%_123 = load i8*, i8** %_122
	%_124 = bitcast i8* %_123 to i32 (i8*, i8*)*
	%_126 = load i8*, i8** %el03
	%_125 = call i32 %_124(i8* %_119, i8* %_126)

	call void (i32) @print_int(i32 %_125)
	call void (i32) @print_int(i32 10000000)
	%_127 = call i8* @calloc(i32 1, i32 17)
	%_128 = bitcast i8* %_127 to i8***
	%_129 = getelementptr [6 x i8*], [6 x i8*]* @.Element_vtable, i32 0, i32 0
	store i8** %_129, i8*** %_128

	store i8* %_127, i8** %el01
	%_130 = load i8*, i8** %el01
	; Element.Init : 0
	%_131 = bitcast i8* %_130 to i8***
	%_132 = load i8**, i8*** %_131
	%_133 = getelementptr i8*, i8** %_132, i32 0
	%_134 = load i8*, i8** %_133
	%_135 = bitcast i8* %_134 to i1 (i8*, i32, i32, i1)*
	%_136 = call i1 %_135(i8* %_130, i32 28, i32 35000, i1 0)

	store i1 %_136, i1* %aux01
	%_137 = load i8*, i8** %head
	; List.Insert : 2
	%_138 = bitcast i8* %_137 to i8***
	%_139 = load i8**, i8*** %_138
	%_140 = getelementptr i8*, i8** %_139, i32 2
	%_141 = load i8*, i8** %_140
	%_142 = bitcast i8* %_141 to i8* (i8*, i8*)*
	%_144 = load i8*, i8** %el01
	%_143 = call i8* %_142(i8* %_137, i8* %_144)

	store i8* %_143, i8** %head
	%_145 = load i8*, i8** %head
	; List.Print : 9
	%_146 = bitcast i8* %_145 to i8***
	%_147 = load i8**, i8*** %_146
	%_148 = getelementptr i8*, i8** %_147, i32 9
	%_149 = load i8*, i8** %_148
	%_150 = bitcast i8* %_149 to i1 (i8*)*
	%_151 = call i1 %_150(i8* %_145)

	store i1 %_151, i1* %aux01
	call void (i32) @print_int(i32 2220000)
	%_152 = load i8*, i8** %head
	; List.Delete : 4
	%_153 = bitcast i8* %_152 to i8***
	%_154 = load i8**, i8*** %_153
	%_155 = getelementptr i8*, i8** %_154, i32 4
	%_156 = load i8*, i8** %_155
	%_157 = bitcast i8* %_156 to i8* (i8*, i8*)*
	%_159 = load i8*, i8** %el02
	%_158 = call i8* %_157(i8* %_152, i8* %_159)

	store i8* %_158, i8** %head
	%_160 = load i8*, i8** %head
	; List.Print : 9
	%_161 = bitcast i8* %_160 to i8***
	%_162 = load i8**, i8*** %_161
	%_163 = getelementptr i8*, i8** %_162, i32 9
	%_164 = load i8*, i8** %_163
	%_165 = bitcast i8* %_164 to i1 (i8*)*
	%_166 = call i1 %_165(i8* %_160)

	store i1 %_166, i1* %aux01
	call void (i32) @print_int(i32 33300000)
	%_167 = load i8*, i8** %head
	; List.Delete : 4
	%_168 = bitcast i8* %_167 to i8***
	%_169 = load i8**, i8*** %_168
	%_170 = getelementptr i8*, i8** %_169, i32 4
	%_171 = load i8*, i8** %_170
	%_172 = bitcast i8* %_171 to i8* (i8*, i8*)*
	%_174 = load i8*, i8** %el01
	%_173 = call i8* %_172(i8* %_167, i8* %_174)

	store i8* %_173, i8** %head
	%_175 = load i8*, i8** %head
	; List.Print : 9
	%_176 = bitcast i8* %_175 to i8***
	%_177 = load i8**, i8*** %_176
	%_178 = getelementptr i8*, i8** %_177, i32 9
	%_179 = load i8*, i8** %_178
	%_180 = bitcast i8* %_179 to i1 (i8*)*
	%_181 = call i1 %_180(i8* %_175)

	store i1 %_181, i1* %aux01
	call void (i32) @print_int(i32 44440000)
	ret i32 0
}

