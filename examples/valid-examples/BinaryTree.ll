@.BinaryTree_vtable = global [0 x i8*] []
@.BT_vtable = global [1 x i8*] [i8* bitcast (i32 (i8*)* @BT.Start to i8*)]
@.Tree_vtable = global [20 x i8*] [i8* bitcast (i1 (i8*, i32)* @Tree.Init to i8*), i8* bitcast (i1 (i8*, i8*)* @Tree.SetRight to i8*), i8* bitcast (i1 (i8*, i8*)* @Tree.SetLeft to i8*), i8* bitcast (i8* (i8*)* @Tree.GetRight to i8*), i8* bitcast (i8* (i8*)* @Tree.GetLeft to i8*), i8* bitcast (i32 (i8*)* @Tree.GetKey to i8*), i8* bitcast (i1 (i8*, i32)* @Tree.SetKey to i8*), i8* bitcast (i1 (i8*)* @Tree.GetHas_Right to i8*), i8* bitcast (i1 (i8*)* @Tree.GetHas_Left to i8*), i8* bitcast (i1 (i8*, i1)* @Tree.SetHas_Left to i8*), i8* bitcast (i1 (i8*, i1)* @Tree.SetHas_Right to i8*), i8* bitcast (i1 (i8*, i32, i32)* @Tree.Compare to i8*), i8* bitcast (i1 (i8*, i32)* @Tree.Insert to i8*), i8* bitcast (i1 (i8*, i32)* @Tree.Delete to i8*), i8* bitcast (i1 (i8*, i8*, i8*)* @Tree.Remove to i8*), i8* bitcast (i1 (i8*, i8*, i8*)* @Tree.RemoveRight to i8*), i8* bitcast (i1 (i8*, i8*, i8*)* @Tree.RemoveLeft to i8*), i8* bitcast (i32 (i8*, i32)* @Tree.Search to i8*), i8* bitcast (i1 (i8*)* @Tree.Print to i8*), i8* bitcast (i1 (i8*, i8*)* @Tree.RecPrint to i8*)]

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
	%_2 = getelementptr [1 x i8*], [1 x i8*]* @.BT_vtable, i32 0, i32 0
	store i8** %_2, i8*** %_1
	; BT.Start : 0
	%_3 = bitcast i8* %_0 to i8***
	%_4 = load i8**, i8*** %_3
	%_5 = getelementptr i8*, i8** %_4, i32 0
	%_6 = load i8*, i8** %_5
	%_7 = bitcast i8* %_6 to i32 (i8*)*
	%_8 = call i32 %_7(i8* %_0)
	call void (i32) @print_int(i32 %_8)

	ret i32 0
}

define i32 @BT.Start(i8* %this) {
	%root = alloca i8*

	%ntb = alloca i1

	%nti = alloca i32


	%_0 = call i8* @calloc(i32 1, i32 38)
	%_1 = bitcast i8* %_0 to i8***
	%_2 = getelementptr [20 x i8*], [20 x i8*]* @.Tree_vtable, i32 0, i32 0
	store i8** %_2, i8*** %_1
	store i8* %_0, i8** %root

	%_3 = load i8*, i8** %root
	; Tree.Init : 0
	%_4 = bitcast i8* %_3 to i8***
	%_5 = load i8**, i8*** %_4
	%_6 = getelementptr i8*, i8** %_5, i32 0
	%_7 = load i8*, i8** %_6
	%_8 = bitcast i8* %_7 to i1 (i8*, i32)*
	%_9 = call i1 %_8(i8* %_3, i32 16)
	store i1 %_9, i1* %ntb

	%_10 = load i8*, i8** %root
	; Tree.Print : 18
	%_11 = bitcast i8* %_10 to i8***
	%_12 = load i8**, i8*** %_11
	%_13 = getelementptr i8*, i8** %_12, i32 18
	%_14 = load i8*, i8** %_13
	%_15 = bitcast i8* %_14 to i1 (i8*)*
	%_16 = call i1 %_15(i8* %_10)
	store i1 %_16, i1* %ntb

	call void (i32) @print_int(i32 100000000)

	%_17 = load i8*, i8** %root
	; Tree.Insert : 12
	%_18 = bitcast i8* %_17 to i8***
	%_19 = load i8**, i8*** %_18
	%_20 = getelementptr i8*, i8** %_19, i32 12
	%_21 = load i8*, i8** %_20
	%_22 = bitcast i8* %_21 to i1 (i8*, i32)*
	%_23 = call i1 %_22(i8* %_17, i32 8)
	store i1 %_23, i1* %ntb

	%_24 = load i8*, i8** %root
	; Tree.Print : 18
	%_25 = bitcast i8* %_24 to i8***
	%_26 = load i8**, i8*** %_25
	%_27 = getelementptr i8*, i8** %_26, i32 18
	%_28 = load i8*, i8** %_27
	%_29 = bitcast i8* %_28 to i1 (i8*)*
	%_30 = call i1 %_29(i8* %_24)
	store i1 %_30, i1* %ntb

	%_31 = load i8*, i8** %root
	; Tree.Insert : 12
	%_32 = bitcast i8* %_31 to i8***
	%_33 = load i8**, i8*** %_32
	%_34 = getelementptr i8*, i8** %_33, i32 12
	%_35 = load i8*, i8** %_34
	%_36 = bitcast i8* %_35 to i1 (i8*, i32)*
	%_37 = call i1 %_36(i8* %_31, i32 24)
	store i1 %_37, i1* %ntb

	%_38 = load i8*, i8** %root
	; Tree.Insert : 12
	%_39 = bitcast i8* %_38 to i8***
	%_40 = load i8**, i8*** %_39
	%_41 = getelementptr i8*, i8** %_40, i32 12
	%_42 = load i8*, i8** %_41
	%_43 = bitcast i8* %_42 to i1 (i8*, i32)*
	%_44 = call i1 %_43(i8* %_38, i32 4)
	store i1 %_44, i1* %ntb

	%_45 = load i8*, i8** %root
	; Tree.Insert : 12
	%_46 = bitcast i8* %_45 to i8***
	%_47 = load i8**, i8*** %_46
	%_48 = getelementptr i8*, i8** %_47, i32 12
	%_49 = load i8*, i8** %_48
	%_50 = bitcast i8* %_49 to i1 (i8*, i32)*
	%_51 = call i1 %_50(i8* %_45, i32 12)
	store i1 %_51, i1* %ntb

	%_52 = load i8*, i8** %root
	; Tree.Insert : 12
	%_53 = bitcast i8* %_52 to i8***
	%_54 = load i8**, i8*** %_53
	%_55 = getelementptr i8*, i8** %_54, i32 12
	%_56 = load i8*, i8** %_55
	%_57 = bitcast i8* %_56 to i1 (i8*, i32)*
	%_58 = call i1 %_57(i8* %_52, i32 20)
	store i1 %_58, i1* %ntb

	%_59 = load i8*, i8** %root
	; Tree.Insert : 12
	%_60 = bitcast i8* %_59 to i8***
	%_61 = load i8**, i8*** %_60
	%_62 = getelementptr i8*, i8** %_61, i32 12
	%_63 = load i8*, i8** %_62
	%_64 = bitcast i8* %_63 to i1 (i8*, i32)*
	%_65 = call i1 %_64(i8* %_59, i32 28)
	store i1 %_65, i1* %ntb

	%_66 = load i8*, i8** %root
	; Tree.Insert : 12
	%_67 = bitcast i8* %_66 to i8***
	%_68 = load i8**, i8*** %_67
	%_69 = getelementptr i8*, i8** %_68, i32 12
	%_70 = load i8*, i8** %_69
	%_71 = bitcast i8* %_70 to i1 (i8*, i32)*
	%_72 = call i1 %_71(i8* %_66, i32 14)
	store i1 %_72, i1* %ntb

	%_73 = load i8*, i8** %root
	; Tree.Print : 18
	%_74 = bitcast i8* %_73 to i8***
	%_75 = load i8**, i8*** %_74
	%_76 = getelementptr i8*, i8** %_75, i32 18
	%_77 = load i8*, i8** %_76
	%_78 = bitcast i8* %_77 to i1 (i8*)*
	%_79 = call i1 %_78(i8* %_73)
	store i1 %_79, i1* %ntb

	%_80 = load i8*, i8** %root
	; Tree.Search : 17
	%_81 = bitcast i8* %_80 to i8***
	%_82 = load i8**, i8*** %_81
	%_83 = getelementptr i8*, i8** %_82, i32 17
	%_84 = load i8*, i8** %_83
	%_85 = bitcast i8* %_84 to i32 (i8*, i32)*
	%_86 = call i32 %_85(i8* %_80, i32 24)
	call void (i32) @print_int(i32 %_86)

	%_87 = load i8*, i8** %root
	; Tree.Search : 17
	%_88 = bitcast i8* %_87 to i8***
	%_89 = load i8**, i8*** %_88
	%_90 = getelementptr i8*, i8** %_89, i32 17
	%_91 = load i8*, i8** %_90
	%_92 = bitcast i8* %_91 to i32 (i8*, i32)*
	%_93 = call i32 %_92(i8* %_87, i32 12)
	call void (i32) @print_int(i32 %_93)

	%_94 = load i8*, i8** %root
	; Tree.Search : 17
	%_95 = bitcast i8* %_94 to i8***
	%_96 = load i8**, i8*** %_95
	%_97 = getelementptr i8*, i8** %_96, i32 17
	%_98 = load i8*, i8** %_97
	%_99 = bitcast i8* %_98 to i32 (i8*, i32)*
	%_100 = call i32 %_99(i8* %_94, i32 16)
	call void (i32) @print_int(i32 %_100)

	%_101 = load i8*, i8** %root
	; Tree.Search : 17
	%_102 = bitcast i8* %_101 to i8***
	%_103 = load i8**, i8*** %_102
	%_104 = getelementptr i8*, i8** %_103, i32 17
	%_105 = load i8*, i8** %_104
	%_106 = bitcast i8* %_105 to i32 (i8*, i32)*
	%_107 = call i32 %_106(i8* %_101, i32 50)
	call void (i32) @print_int(i32 %_107)

	%_108 = load i8*, i8** %root
	; Tree.Search : 17
	%_109 = bitcast i8* %_108 to i8***
	%_110 = load i8**, i8*** %_109
	%_111 = getelementptr i8*, i8** %_110, i32 17
	%_112 = load i8*, i8** %_111
	%_113 = bitcast i8* %_112 to i32 (i8*, i32)*
	%_114 = call i32 %_113(i8* %_108, i32 12)
	call void (i32) @print_int(i32 %_114)

	%_115 = load i8*, i8** %root
	; Tree.Delete : 13
	%_116 = bitcast i8* %_115 to i8***
	%_117 = load i8**, i8*** %_116
	%_118 = getelementptr i8*, i8** %_117, i32 13
	%_119 = load i8*, i8** %_118
	%_120 = bitcast i8* %_119 to i1 (i8*, i32)*
	%_121 = call i1 %_120(i8* %_115, i32 12)
	store i1 %_121, i1* %ntb

	%_122 = load i8*, i8** %root
	; Tree.Print : 18
	%_123 = bitcast i8* %_122 to i8***
	%_124 = load i8**, i8*** %_123
	%_125 = getelementptr i8*, i8** %_124, i32 18
	%_126 = load i8*, i8** %_125
	%_127 = bitcast i8* %_126 to i1 (i8*)*
	%_128 = call i1 %_127(i8* %_122)
	store i1 %_128, i1* %ntb

	%_129 = load i8*, i8** %root
	; Tree.Search : 17
	%_130 = bitcast i8* %_129 to i8***
	%_131 = load i8**, i8*** %_130
	%_132 = getelementptr i8*, i8** %_131, i32 17
	%_133 = load i8*, i8** %_132
	%_134 = bitcast i8* %_133 to i32 (i8*, i32)*
	%_135 = call i32 %_134(i8* %_129, i32 12)
	call void (i32) @print_int(i32 %_135)
	ret i32 0
}

define i1 @Tree.Init(i8* %this, i32 %.v_key) {
	%v_key = alloca i32
	store i32 %.v_key, i32* %v_key

	%_0 = load i32, i32* %v_key
	%_1 = getelementptr i8, i8* %this, i32 24
	%_2 = bitcast i8* %_1 to i32*
	store i32 %_0, i32* %_2

	%_3 = getelementptr i8, i8* %this, i32 28
	%_4 = bitcast i8* %_3 to i1*
	store i1 0, i1* %_4

	%_5 = getelementptr i8, i8* %this, i32 29
	%_6 = bitcast i8* %_5 to i1*
	store i1 0, i1* %_6
	ret i1 1
}

define i1 @Tree.SetRight(i8* %this, i8* %.rn) {
	%rn = alloca i8*
	store i8* %.rn, i8** %rn

	%_0 = load i8*, i8** %rn
	%_1 = getelementptr i8, i8* %this, i32 16
	%_2 = bitcast i8* %_1 to i8**
	store i8* %_0, i8** %_2
	ret i1 1
}

define i1 @Tree.SetLeft(i8* %this, i8* %.ln) {
	%ln = alloca i8*
	store i8* %.ln, i8** %ln

	%_0 = load i8*, i8** %ln
	%_1 = getelementptr i8, i8* %this, i32 8
	%_2 = bitcast i8* %_1 to i8**
	store i8* %_0, i8** %_2
	ret i1 1
}

define i8* @Tree.GetRight(i8* %this) {
	%_0 = getelementptr i8, i8* %this, i32 16
	%_1 = bitcast i8* %_0 to i8**
	%_2 = load i8*, i8** %_1
	ret i8* %_2
}

define i8* @Tree.GetLeft(i8* %this) {
	%_0 = getelementptr i8, i8* %this, i32 8
	%_1 = bitcast i8* %_0 to i8**
	%_2 = load i8*, i8** %_1
	ret i8* %_2
}

define i32 @Tree.GetKey(i8* %this) {
	%_0 = getelementptr i8, i8* %this, i32 24
	%_1 = bitcast i8* %_0 to i32*
	%_2 = load i32, i32* %_1
	ret i32 %_2
}

define i1 @Tree.SetKey(i8* %this, i32 %.v_key) {
	%v_key = alloca i32
	store i32 %.v_key, i32* %v_key

	%_0 = load i32, i32* %v_key
	%_1 = getelementptr i8, i8* %this, i32 24
	%_2 = bitcast i8* %_1 to i32*
	store i32 %_0, i32* %_2
	ret i1 1
}

define i1 @Tree.GetHas_Right(i8* %this) {
	%_0 = getelementptr i8, i8* %this, i32 29
	%_1 = bitcast i8* %_0 to i1*
	%_2 = load i1, i1* %_1
	ret i1 %_2
}

define i1 @Tree.GetHas_Left(i8* %this) {
	%_0 = getelementptr i8, i8* %this, i32 28
	%_1 = bitcast i8* %_0 to i1*
	%_2 = load i1, i1* %_1
	ret i1 %_2
}

define i1 @Tree.SetHas_Left(i8* %this, i1 %.val) {
	%val = alloca i1
	store i1 %.val, i1* %val

	%_0 = load i1, i1* %val
	%_1 = getelementptr i8, i8* %this, i32 28
	%_2 = bitcast i8* %_1 to i1*
	store i1 %_0, i1* %_2
	ret i1 1
}

define i1 @Tree.SetHas_Right(i8* %this, i1 %.val) {
	%val = alloca i1
	store i1 %.val, i1* %val

	%_0 = load i1, i1* %val
	%_1 = getelementptr i8, i8* %this, i32 29
	%_2 = bitcast i8* %_1 to i1*
	store i1 %_0, i1* %_2
	ret i1 1
}

define i1 @Tree.Compare(i8* %this, i32 %.num1, i32 %.num2) {
	%num1 = alloca i32
	store i32 %.num1, i32* %num1
	%num2 = alloca i32
	store i32 %.num2, i32* %num2
	%ntb = alloca i1

	%nti = alloca i32


	store i1 0, i1* %ntb

	%_0 = load i32, i32* %num2
	%_1 = add i32 %_0, 1
	store i32 %_1, i32* %nti

	%_2 = load i32, i32* %num1
	%_3 = load i32, i32* %num2
	%_4 = icmp slt i32 %_2, %_3
	br i1 %_4, label %if_then5, label %if_else6

if_then5:

	store i1 0, i1* %ntb

	br label %if_end7

if_else6:

	%_8 = load i32, i32* %num1
	%_9 = load i32, i32* %nti
	%_10 = icmp slt i32 %_8, %_9
	%_11 = xor i1 1, %_10
	br i1 %_11, label %if_then12, label %if_else13

if_then12:

	store i1 0, i1* %ntb

	br label %if_end14

if_else13:

	store i1 1, i1* %ntb

	br label %if_end14

if_end14:

	br label %if_end7

if_end7:
	%_15 = load i1, i1* %ntb
	ret i1 %_15
}

define i1 @Tree.Insert(i8* %this, i32 %.v_key) {
	%v_key = alloca i32
	store i32 %.v_key, i32* %v_key
	%new_node = alloca i8*

	%ntb = alloca i1

	%cont = alloca i1

	%key_aux = alloca i32

	%current_node = alloca i8*


	%_0 = call i8* @calloc(i32 1, i32 38)
	%_1 = bitcast i8* %_0 to i8***
	%_2 = getelementptr [20 x i8*], [20 x i8*]* @.Tree_vtable, i32 0, i32 0
	store i8** %_2, i8*** %_1
	store i8* %_0, i8** %new_node

	%_3 = load i8*, i8** %new_node
	; Tree.Init : 0
	%_4 = bitcast i8* %_3 to i8***
	%_5 = load i8**, i8*** %_4
	%_6 = getelementptr i8*, i8** %_5, i32 0
	%_7 = load i8*, i8** %_6
	%_8 = bitcast i8* %_7 to i1 (i8*, i32)*
	%_10 = load i32, i32* %v_key
	%_9 = call i1 %_8(i8* %_3, i32 %_10)
	store i1 %_9, i1* %ntb

	store i8* %this, i8** %current_node

	store i1 1, i1* %cont


	br label %while_cond11

while_cond11:
	%_14 = load i1, i1* %cont
	br i1 %_14, label %while_body12, label %while_end13

while_body12:


	%_15 = load i8*, i8** %current_node
	; Tree.GetKey : 5
	%_16 = bitcast i8* %_15 to i8***
	%_17 = load i8**, i8*** %_16
	%_18 = getelementptr i8*, i8** %_17, i32 5
	%_19 = load i8*, i8** %_18
	%_20 = bitcast i8* %_19 to i32 (i8*)*
	%_21 = call i32 %_20(i8* %_15)
	store i32 %_21, i32* %key_aux

	%_22 = load i32, i32* %v_key
	%_23 = load i32, i32* %key_aux
	%_24 = icmp slt i32 %_22, %_23
	br i1 %_24, label %if_then25, label %if_else26

if_then25:


	%_28 = load i8*, i8** %current_node
	; Tree.GetHas_Left : 8
	%_29 = bitcast i8* %_28 to i8***
	%_30 = load i8**, i8*** %_29
	%_31 = getelementptr i8*, i8** %_30, i32 8
	%_32 = load i8*, i8** %_31
	%_33 = bitcast i8* %_32 to i1 (i8*)*
	%_34 = call i1 %_33(i8* %_28)
	br i1 %_34, label %if_then35, label %if_else36

if_then35:

	%_38 = load i8*, i8** %current_node
	; Tree.GetLeft : 4
	%_39 = bitcast i8* %_38 to i8***
	%_40 = load i8**, i8*** %_39
	%_41 = getelementptr i8*, i8** %_40, i32 4
	%_42 = load i8*, i8** %_41
	%_43 = bitcast i8* %_42 to i8* (i8*)*
	%_44 = call i8* %_43(i8* %_38)
	store i8* %_44, i8** %current_node

	br label %if_end37

if_else36:


	store i1 0, i1* %cont

	%_45 = load i8*, i8** %current_node
	; Tree.SetHas_Left : 9
	%_46 = bitcast i8* %_45 to i8***
	%_47 = load i8**, i8*** %_46
	%_48 = getelementptr i8*, i8** %_47, i32 9
	%_49 = load i8*, i8** %_48
	%_50 = bitcast i8* %_49 to i1 (i8*, i1)*
	%_51 = call i1 %_50(i8* %_45, i1 1)
	store i1 %_51, i1* %ntb

	%_52 = load i8*, i8** %current_node
	; Tree.SetLeft : 2
	%_53 = bitcast i8* %_52 to i8***
	%_54 = load i8**, i8*** %_53
	%_55 = getelementptr i8*, i8** %_54, i32 2
	%_56 = load i8*, i8** %_55
	%_57 = bitcast i8* %_56 to i1 (i8*, i8*)*
	%_59 = load i8*, i8** %new_node
	%_58 = call i1 %_57(i8* %_52, i8* %_59)
	store i1 %_58, i1* %ntb

	br label %if_end37

if_end37:

	br label %if_end27

if_else26:


	%_60 = load i8*, i8** %current_node
	; Tree.GetHas_Right : 7
	%_61 = bitcast i8* %_60 to i8***
	%_62 = load i8**, i8*** %_61
	%_63 = getelementptr i8*, i8** %_62, i32 7
	%_64 = load i8*, i8** %_63
	%_65 = bitcast i8* %_64 to i1 (i8*)*
	%_66 = call i1 %_65(i8* %_60)
	br i1 %_66, label %if_then67, label %if_else68

if_then67:

	%_70 = load i8*, i8** %current_node
	; Tree.GetRight : 3
	%_71 = bitcast i8* %_70 to i8***
	%_72 = load i8**, i8*** %_71
	%_73 = getelementptr i8*, i8** %_72, i32 3
	%_74 = load i8*, i8** %_73
	%_75 = bitcast i8* %_74 to i8* (i8*)*
	%_76 = call i8* %_75(i8* %_70)
	store i8* %_76, i8** %current_node

	br label %if_end69

if_else68:


	store i1 0, i1* %cont

	%_77 = load i8*, i8** %current_node
	; Tree.SetHas_Right : 10
	%_78 = bitcast i8* %_77 to i8***
	%_79 = load i8**, i8*** %_78
	%_80 = getelementptr i8*, i8** %_79, i32 10
	%_81 = load i8*, i8** %_80
	%_82 = bitcast i8* %_81 to i1 (i8*, i1)*
	%_83 = call i1 %_82(i8* %_77, i1 1)
	store i1 %_83, i1* %ntb

	%_84 = load i8*, i8** %current_node
	; Tree.SetRight : 1
	%_85 = bitcast i8* %_84 to i8***
	%_86 = load i8**, i8*** %_85
	%_87 = getelementptr i8*, i8** %_86, i32 1
	%_88 = load i8*, i8** %_87
	%_89 = bitcast i8* %_88 to i1 (i8*, i8*)*
	%_91 = load i8*, i8** %new_node
	%_90 = call i1 %_89(i8* %_84, i8* %_91)
	store i1 %_90, i1* %ntb

	br label %if_end69

if_end69:

	br label %if_end27

if_end27:

	br label %while_cond11

while_end13:
	ret i1 1
}

define i1 @Tree.Delete(i8* %this, i32 %.v_key) {
	%v_key = alloca i32
	store i32 %.v_key, i32* %v_key
	%current_node = alloca i8*

	%parent_node = alloca i8*

	%cont = alloca i1

	%found = alloca i1

	%is_root = alloca i1

	%key_aux = alloca i32

	%ntb = alloca i1


	store i8* %this, i8** %current_node

	store i8* %this, i8** %parent_node

	store i1 1, i1* %cont

	store i1 0, i1* %found

	store i1 1, i1* %is_root


	br label %while_cond0

while_cond0:
	%_3 = load i1, i1* %cont
	br i1 %_3, label %while_body1, label %while_end2

while_body1:


	%_4 = load i8*, i8** %current_node
	; Tree.GetKey : 5
	%_5 = bitcast i8* %_4 to i8***
	%_6 = load i8**, i8*** %_5
	%_7 = getelementptr i8*, i8** %_6, i32 5
	%_8 = load i8*, i8** %_7
	%_9 = bitcast i8* %_8 to i32 (i8*)*
	%_10 = call i32 %_9(i8* %_4)
	store i32 %_10, i32* %key_aux

	%_11 = load i32, i32* %v_key
	%_12 = load i32, i32* %key_aux
	%_13 = icmp slt i32 %_11, %_12
	br i1 %_13, label %if_then14, label %if_else15

if_then14:

	%_17 = load i8*, i8** %current_node
	; Tree.GetHas_Left : 8
	%_18 = bitcast i8* %_17 to i8***
	%_19 = load i8**, i8*** %_18
	%_20 = getelementptr i8*, i8** %_19, i32 8
	%_21 = load i8*, i8** %_20
	%_22 = bitcast i8* %_21 to i1 (i8*)*
	%_23 = call i1 %_22(i8* %_17)
	br i1 %_23, label %if_then24, label %if_else25

if_then24:


	%_27 = load i8*, i8** %current_node
	store i8* %_27, i8** %parent_node

	%_28 = load i8*, i8** %current_node
	; Tree.GetLeft : 4
	%_29 = bitcast i8* %_28 to i8***
	%_30 = load i8**, i8*** %_29
	%_31 = getelementptr i8*, i8** %_30, i32 4
	%_32 = load i8*, i8** %_31
	%_33 = bitcast i8* %_32 to i8* (i8*)*
	%_34 = call i8* %_33(i8* %_28)
	store i8* %_34, i8** %current_node

	br label %if_end26

if_else25:

	store i1 0, i1* %cont

	br label %if_end26

if_end26:

	br label %if_end16

if_else15:

	%_35 = load i32, i32* %key_aux
	%_36 = load i32, i32* %v_key
	%_37 = icmp slt i32 %_35, %_36
	br i1 %_37, label %if_then38, label %if_else39

if_then38:

	%_41 = load i8*, i8** %current_node
	; Tree.GetHas_Right : 7
	%_42 = bitcast i8* %_41 to i8***
	%_43 = load i8**, i8*** %_42
	%_44 = getelementptr i8*, i8** %_43, i32 7
	%_45 = load i8*, i8** %_44
	%_46 = bitcast i8* %_45 to i1 (i8*)*
	%_47 = call i1 %_46(i8* %_41)
	br i1 %_47, label %if_then48, label %if_else49

if_then48:


	%_51 = load i8*, i8** %current_node
	store i8* %_51, i8** %parent_node

	%_52 = load i8*, i8** %current_node
	; Tree.GetRight : 3
	%_53 = bitcast i8* %_52 to i8***
	%_54 = load i8**, i8*** %_53
	%_55 = getelementptr i8*, i8** %_54, i32 3
	%_56 = load i8*, i8** %_55
	%_57 = bitcast i8* %_56 to i8* (i8*)*
	%_58 = call i8* %_57(i8* %_52)
	store i8* %_58, i8** %current_node

	br label %if_end50

if_else49:

	store i1 0, i1* %cont

	br label %if_end50

if_end50:

	br label %if_end40

if_else39:


	%_59 = load i1, i1* %is_root
	br i1 %_59, label %if_then60, label %if_else61

if_then60:

	%_63 = load i8*, i8** %current_node
	; Tree.GetHas_Right : 7
	%_64 = bitcast i8* %_63 to i8***
	%_65 = load i8**, i8*** %_64
	%_66 = getelementptr i8*, i8** %_65, i32 7
	%_67 = load i8*, i8** %_66
	%_68 = bitcast i8* %_67 to i1 (i8*)*
	%_69 = call i1 %_68(i8* %_63)
	%_70 = xor i1 1, %_69
	br i1 %_70, label %l1, label %l0

l1:
	%_72 = load i8*, i8** %current_node
	; Tree.GetHas_Left : 8
	%_73 = bitcast i8* %_72 to i8***
	%_74 = load i8**, i8*** %_73
	%_75 = getelementptr i8*, i8** %_74, i32 8
	%_76 = load i8*, i8** %_75
	%_77 = bitcast i8* %_76 to i1 (i8*)*
	%_78 = call i1 %_77(i8* %_72)
	%_79 = xor i1 1, %_78
	br label %l2

l0:
	br label %l2

l2:
	%_71 = phi i1 [ 0, %l0], [ %_79, %l1]

	br i1 %_79, label %if_then80, label %if_else81

if_then80:

	store i1 1, i1* %ntb

	br label %if_end82

if_else81:

	; Tree.Remove : 14
	%_83 = bitcast i8* %this to i8***
	%_84 = load i8**, i8*** %_83
	%_85 = getelementptr i8*, i8** %_84, i32 14
	%_86 = load i8*, i8** %_85
	%_87 = bitcast i8* %_86 to i1 (i8*, i8*, i8*)*
	%_89 = load i8*, i8** %parent_node
	%_90 = load i8*, i8** %current_node
	%_88 = call i1 %_87(i8* %this, i8* %_89, i8* %_90)
	store i1 %_88, i1* %ntb

	br label %if_end82

if_end82:

	br label %if_end62

if_else61:

	; Tree.Remove : 14
	%_91 = bitcast i8* %this to i8***
	%_92 = load i8**, i8*** %_91
	%_93 = getelementptr i8*, i8** %_92, i32 14
	%_94 = load i8*, i8** %_93
	%_95 = bitcast i8* %_94 to i1 (i8*, i8*, i8*)*
	%_97 = load i8*, i8** %parent_node
	%_98 = load i8*, i8** %current_node
	%_96 = call i1 %_95(i8* %this, i8* %_97, i8* %_98)
	store i1 %_96, i1* %ntb

	br label %if_end62

if_end62:

	store i1 1, i1* %found

	store i1 0, i1* %cont

	br label %if_end40

if_end40:

	br label %if_end16

if_end16:

	store i1 0, i1* %is_root

	br label %while_cond0

while_end2:
	%_99 = load i1, i1* %found
	ret i1 %_99
}

define i1 @Tree.Remove(i8* %this, i8* %.p_node, i8* %.c_node) {
	%p_node = alloca i8*
	store i8* %.p_node, i8** %p_node
	%c_node = alloca i8*
	store i8* %.c_node, i8** %c_node
	%ntb = alloca i1

	%auxkey1 = alloca i32

	%auxkey2 = alloca i32


	%_0 = load i8*, i8** %c_node
	; Tree.GetHas_Left : 8
	%_1 = bitcast i8* %_0 to i8***
	%_2 = load i8**, i8*** %_1
	%_3 = getelementptr i8*, i8** %_2, i32 8
	%_4 = load i8*, i8** %_3
	%_5 = bitcast i8* %_4 to i1 (i8*)*
	%_6 = call i1 %_5(i8* %_0)
	br i1 %_6, label %if_then7, label %if_else8

if_then7:

	; Tree.RemoveLeft : 16
	%_10 = bitcast i8* %this to i8***
	%_11 = load i8**, i8*** %_10
	%_12 = getelementptr i8*, i8** %_11, i32 16
	%_13 = load i8*, i8** %_12
	%_14 = bitcast i8* %_13 to i1 (i8*, i8*, i8*)*
	%_16 = load i8*, i8** %p_node
	%_17 = load i8*, i8** %c_node
	%_15 = call i1 %_14(i8* %this, i8* %_16, i8* %_17)
	store i1 %_15, i1* %ntb

	br label %if_end9

if_else8:

	%_18 = load i8*, i8** %c_node
	; Tree.GetHas_Right : 7
	%_19 = bitcast i8* %_18 to i8***
	%_20 = load i8**, i8*** %_19
	%_21 = getelementptr i8*, i8** %_20, i32 7
	%_22 = load i8*, i8** %_21
	%_23 = bitcast i8* %_22 to i1 (i8*)*
	%_24 = call i1 %_23(i8* %_18)
	br i1 %_24, label %if_then25, label %if_else26

if_then25:

	; Tree.RemoveRight : 15
	%_28 = bitcast i8* %this to i8***
	%_29 = load i8**, i8*** %_28
	%_30 = getelementptr i8*, i8** %_29, i32 15
	%_31 = load i8*, i8** %_30
	%_32 = bitcast i8* %_31 to i1 (i8*, i8*, i8*)*
	%_34 = load i8*, i8** %p_node
	%_35 = load i8*, i8** %c_node
	%_33 = call i1 %_32(i8* %this, i8* %_34, i8* %_35)
	store i1 %_33, i1* %ntb

	br label %if_end27

if_else26:


	%_36 = load i8*, i8** %c_node
	; Tree.GetKey : 5
	%_37 = bitcast i8* %_36 to i8***
	%_38 = load i8**, i8*** %_37
	%_39 = getelementptr i8*, i8** %_38, i32 5
	%_40 = load i8*, i8** %_39
	%_41 = bitcast i8* %_40 to i32 (i8*)*
	%_42 = call i32 %_41(i8* %_36)
	store i32 %_42, i32* %auxkey1

	%_43 = load i8*, i8** %p_node
	; Tree.GetLeft : 4
	%_44 = bitcast i8* %_43 to i8***
	%_45 = load i8**, i8*** %_44
	%_46 = getelementptr i8*, i8** %_45, i32 4
	%_47 = load i8*, i8** %_46
	%_48 = bitcast i8* %_47 to i8* (i8*)*
	%_49 = call i8* %_48(i8* %_43)
	; Tree.GetKey : 5
	%_50 = bitcast i8* %_49 to i8***
	%_51 = load i8**, i8*** %_50
	%_52 = getelementptr i8*, i8** %_51, i32 5
	%_53 = load i8*, i8** %_52
	%_54 = bitcast i8* %_53 to i32 (i8*)*
	%_55 = call i32 %_54(i8* %_49)
	store i32 %_55, i32* %auxkey2

	; Tree.Compare : 11
	%_56 = bitcast i8* %this to i8***
	%_57 = load i8**, i8*** %_56
	%_58 = getelementptr i8*, i8** %_57, i32 11
	%_59 = load i8*, i8** %_58
	%_60 = bitcast i8* %_59 to i1 (i8*, i32, i32)*
	%_62 = load i32, i32* %auxkey1
	%_63 = load i32, i32* %auxkey2
	%_61 = call i1 %_60(i8* %this, i32 %_62, i32 %_63)
	br i1 %_61, label %if_then64, label %if_else65

if_then64:


	%_67 = load i8*, i8** %p_node
	; Tree.SetLeft : 2
	%_68 = bitcast i8* %_67 to i8***
	%_69 = load i8**, i8*** %_68
	%_70 = getelementptr i8*, i8** %_69, i32 2
	%_71 = load i8*, i8** %_70
	%_72 = bitcast i8* %_71 to i1 (i8*, i8*)*
	%_74 = getelementptr i8, i8* %this, i32 30
	%_75 = bitcast i8* %_74 to i8**
	%_76 = load i8*, i8** %_75
	%_73 = call i1 %_72(i8* %_67, i8* %_76)
	store i1 %_73, i1* %ntb

	%_77 = load i8*, i8** %p_node
	; Tree.SetHas_Left : 9
	%_78 = bitcast i8* %_77 to i8***
	%_79 = load i8**, i8*** %_78
	%_80 = getelementptr i8*, i8** %_79, i32 9
	%_81 = load i8*, i8** %_80
	%_82 = bitcast i8* %_81 to i1 (i8*, i1)*
	%_83 = call i1 %_82(i8* %_77, i1 0)
	store i1 %_83, i1* %ntb

	br label %if_end66

if_else65:


	%_84 = load i8*, i8** %p_node
	; Tree.SetRight : 1
	%_85 = bitcast i8* %_84 to i8***
	%_86 = load i8**, i8*** %_85
	%_87 = getelementptr i8*, i8** %_86, i32 1
	%_88 = load i8*, i8** %_87
	%_89 = bitcast i8* %_88 to i1 (i8*, i8*)*
	%_91 = getelementptr i8, i8* %this, i32 30
	%_92 = bitcast i8* %_91 to i8**
	%_93 = load i8*, i8** %_92
	%_90 = call i1 %_89(i8* %_84, i8* %_93)
	store i1 %_90, i1* %ntb

	%_94 = load i8*, i8** %p_node
	; Tree.SetHas_Right : 10
	%_95 = bitcast i8* %_94 to i8***
	%_96 = load i8**, i8*** %_95
	%_97 = getelementptr i8*, i8** %_96, i32 10
	%_98 = load i8*, i8** %_97
	%_99 = bitcast i8* %_98 to i1 (i8*, i1)*
	%_100 = call i1 %_99(i8* %_94, i1 0)
	store i1 %_100, i1* %ntb

	br label %if_end66

if_end66:

	br label %if_end27

if_end27:

	br label %if_end9

if_end9:
	ret i1 1
}

define i1 @Tree.RemoveRight(i8* %this, i8* %.p_node, i8* %.c_node) {
	%p_node = alloca i8*
	store i8* %.p_node, i8** %p_node
	%c_node = alloca i8*
	store i8* %.c_node, i8** %c_node
	%ntb = alloca i1



	br label %while_cond0

while_cond0:
	%_3 = load i8*, i8** %c_node
	; Tree.GetHas_Right : 7
	%_4 = bitcast i8* %_3 to i8***
	%_5 = load i8**, i8*** %_4
	%_6 = getelementptr i8*, i8** %_5, i32 7
	%_7 = load i8*, i8** %_6
	%_8 = bitcast i8* %_7 to i1 (i8*)*
	%_9 = call i1 %_8(i8* %_3)
	br i1 %_9, label %while_body1, label %while_end2

while_body1:


	%_10 = load i8*, i8** %c_node
	; Tree.SetKey : 6
	%_11 = bitcast i8* %_10 to i8***
	%_12 = load i8**, i8*** %_11
	%_13 = getelementptr i8*, i8** %_12, i32 6
	%_14 = load i8*, i8** %_13
	%_15 = bitcast i8* %_14 to i1 (i8*, i32)*
	%_17 = load i8*, i8** %c_node
	; Tree.GetRight : 3
	%_18 = bitcast i8* %_17 to i8***
	%_19 = load i8**, i8*** %_18
	%_20 = getelementptr i8*, i8** %_19, i32 3
	%_21 = load i8*, i8** %_20
	%_22 = bitcast i8* %_21 to i8* (i8*)*
	%_23 = call i8* %_22(i8* %_17)
	; Tree.GetKey : 5
	%_24 = bitcast i8* %_23 to i8***
	%_25 = load i8**, i8*** %_24
	%_26 = getelementptr i8*, i8** %_25, i32 5
	%_27 = load i8*, i8** %_26
	%_28 = bitcast i8* %_27 to i32 (i8*)*
	%_29 = call i32 %_28(i8* %_23)
	%_16 = call i1 %_15(i8* %_10, i32 %_29)
	store i1 %_16, i1* %ntb

	%_30 = load i8*, i8** %c_node
	store i8* %_30, i8** %p_node

	%_31 = load i8*, i8** %c_node
	; Tree.GetRight : 3
	%_32 = bitcast i8* %_31 to i8***
	%_33 = load i8**, i8*** %_32
	%_34 = getelementptr i8*, i8** %_33, i32 3
	%_35 = load i8*, i8** %_34
	%_36 = bitcast i8* %_35 to i8* (i8*)*
	%_37 = call i8* %_36(i8* %_31)
	store i8* %_37, i8** %c_node

	br label %while_cond0

while_end2:

	%_38 = load i8*, i8** %p_node
	; Tree.SetRight : 1
	%_39 = bitcast i8* %_38 to i8***
	%_40 = load i8**, i8*** %_39
	%_41 = getelementptr i8*, i8** %_40, i32 1
	%_42 = load i8*, i8** %_41
	%_43 = bitcast i8* %_42 to i1 (i8*, i8*)*
	%_45 = getelementptr i8, i8* %this, i32 30
	%_46 = bitcast i8* %_45 to i8**
	%_47 = load i8*, i8** %_46
	%_44 = call i1 %_43(i8* %_38, i8* %_47)
	store i1 %_44, i1* %ntb

	%_48 = load i8*, i8** %p_node
	; Tree.SetHas_Right : 10
	%_49 = bitcast i8* %_48 to i8***
	%_50 = load i8**, i8*** %_49
	%_51 = getelementptr i8*, i8** %_50, i32 10
	%_52 = load i8*, i8** %_51
	%_53 = bitcast i8* %_52 to i1 (i8*, i1)*
	%_54 = call i1 %_53(i8* %_48, i1 0)
	store i1 %_54, i1* %ntb
	ret i1 1
}

define i1 @Tree.RemoveLeft(i8* %this, i8* %.p_node, i8* %.c_node) {
	%p_node = alloca i8*
	store i8* %.p_node, i8** %p_node
	%c_node = alloca i8*
	store i8* %.c_node, i8** %c_node
	%ntb = alloca i1



	br label %while_cond0

while_cond0:
	%_3 = load i8*, i8** %c_node
	; Tree.GetHas_Left : 8
	%_4 = bitcast i8* %_3 to i8***
	%_5 = load i8**, i8*** %_4
	%_6 = getelementptr i8*, i8** %_5, i32 8
	%_7 = load i8*, i8** %_6
	%_8 = bitcast i8* %_7 to i1 (i8*)*
	%_9 = call i1 %_8(i8* %_3)
	br i1 %_9, label %while_body1, label %while_end2

while_body1:


	%_10 = load i8*, i8** %c_node
	; Tree.SetKey : 6
	%_11 = bitcast i8* %_10 to i8***
	%_12 = load i8**, i8*** %_11
	%_13 = getelementptr i8*, i8** %_12, i32 6
	%_14 = load i8*, i8** %_13
	%_15 = bitcast i8* %_14 to i1 (i8*, i32)*
	%_17 = load i8*, i8** %c_node
	; Tree.GetLeft : 4
	%_18 = bitcast i8* %_17 to i8***
	%_19 = load i8**, i8*** %_18
	%_20 = getelementptr i8*, i8** %_19, i32 4
	%_21 = load i8*, i8** %_20
	%_22 = bitcast i8* %_21 to i8* (i8*)*
	%_23 = call i8* %_22(i8* %_17)
	; Tree.GetKey : 5
	%_24 = bitcast i8* %_23 to i8***
	%_25 = load i8**, i8*** %_24
	%_26 = getelementptr i8*, i8** %_25, i32 5
	%_27 = load i8*, i8** %_26
	%_28 = bitcast i8* %_27 to i32 (i8*)*
	%_29 = call i32 %_28(i8* %_23)
	%_16 = call i1 %_15(i8* %_10, i32 %_29)
	store i1 %_16, i1* %ntb

	%_30 = load i8*, i8** %c_node
	store i8* %_30, i8** %p_node

	%_31 = load i8*, i8** %c_node
	; Tree.GetLeft : 4
	%_32 = bitcast i8* %_31 to i8***
	%_33 = load i8**, i8*** %_32
	%_34 = getelementptr i8*, i8** %_33, i32 4
	%_35 = load i8*, i8** %_34
	%_36 = bitcast i8* %_35 to i8* (i8*)*
	%_37 = call i8* %_36(i8* %_31)
	store i8* %_37, i8** %c_node

	br label %while_cond0

while_end2:

	%_38 = load i8*, i8** %p_node
	; Tree.SetLeft : 2
	%_39 = bitcast i8* %_38 to i8***
	%_40 = load i8**, i8*** %_39
	%_41 = getelementptr i8*, i8** %_40, i32 2
	%_42 = load i8*, i8** %_41
	%_43 = bitcast i8* %_42 to i1 (i8*, i8*)*
	%_45 = getelementptr i8, i8* %this, i32 30
	%_46 = bitcast i8* %_45 to i8**
	%_47 = load i8*, i8** %_46
	%_44 = call i1 %_43(i8* %_38, i8* %_47)
	store i1 %_44, i1* %ntb

	%_48 = load i8*, i8** %p_node
	; Tree.SetHas_Left : 9
	%_49 = bitcast i8* %_48 to i8***
	%_50 = load i8**, i8*** %_49
	%_51 = getelementptr i8*, i8** %_50, i32 9
	%_52 = load i8*, i8** %_51
	%_53 = bitcast i8* %_52 to i1 (i8*, i1)*
	%_54 = call i1 %_53(i8* %_48, i1 0)
	store i1 %_54, i1* %ntb
	ret i1 1
}

define i32 @Tree.Search(i8* %this, i32 %.v_key) {
	%v_key = alloca i32
	store i32 %.v_key, i32* %v_key
	%cont = alloca i1

	%ifound = alloca i32

	%current_node = alloca i8*

	%key_aux = alloca i32


	store i8* %this, i8** %current_node

	store i1 1, i1* %cont

	store i32 0, i32* %ifound


	br label %while_cond0

while_cond0:
	%_3 = load i1, i1* %cont
	br i1 %_3, label %while_body1, label %while_end2

while_body1:


	%_4 = load i8*, i8** %current_node
	; Tree.GetKey : 5
	%_5 = bitcast i8* %_4 to i8***
	%_6 = load i8**, i8*** %_5
	%_7 = getelementptr i8*, i8** %_6, i32 5
	%_8 = load i8*, i8** %_7
	%_9 = bitcast i8* %_8 to i32 (i8*)*
	%_10 = call i32 %_9(i8* %_4)
	store i32 %_10, i32* %key_aux

	%_11 = load i32, i32* %v_key
	%_12 = load i32, i32* %key_aux
	%_13 = icmp slt i32 %_11, %_12
	br i1 %_13, label %if_then14, label %if_else15

if_then14:

	%_17 = load i8*, i8** %current_node
	; Tree.GetHas_Left : 8
	%_18 = bitcast i8* %_17 to i8***
	%_19 = load i8**, i8*** %_18
	%_20 = getelementptr i8*, i8** %_19, i32 8
	%_21 = load i8*, i8** %_20
	%_22 = bitcast i8* %_21 to i1 (i8*)*
	%_23 = call i1 %_22(i8* %_17)
	br i1 %_23, label %if_then24, label %if_else25

if_then24:

	%_27 = load i8*, i8** %current_node
	; Tree.GetLeft : 4
	%_28 = bitcast i8* %_27 to i8***
	%_29 = load i8**, i8*** %_28
	%_30 = getelementptr i8*, i8** %_29, i32 4
	%_31 = load i8*, i8** %_30
	%_32 = bitcast i8* %_31 to i8* (i8*)*
	%_33 = call i8* %_32(i8* %_27)
	store i8* %_33, i8** %current_node

	br label %if_end26

if_else25:

	store i1 0, i1* %cont

	br label %if_end26

if_end26:

	br label %if_end16

if_else15:

	%_34 = load i32, i32* %key_aux
	%_35 = load i32, i32* %v_key
	%_36 = icmp slt i32 %_34, %_35
	br i1 %_36, label %if_then37, label %if_else38

if_then37:

	%_40 = load i8*, i8** %current_node
	; Tree.GetHas_Right : 7
	%_41 = bitcast i8* %_40 to i8***
	%_42 = load i8**, i8*** %_41
	%_43 = getelementptr i8*, i8** %_42, i32 7
	%_44 = load i8*, i8** %_43
	%_45 = bitcast i8* %_44 to i1 (i8*)*
	%_46 = call i1 %_45(i8* %_40)
	br i1 %_46, label %if_then47, label %if_else48

if_then47:

	%_50 = load i8*, i8** %current_node
	; Tree.GetRight : 3
	%_51 = bitcast i8* %_50 to i8***
	%_52 = load i8**, i8*** %_51
	%_53 = getelementptr i8*, i8** %_52, i32 3
	%_54 = load i8*, i8** %_53
	%_55 = bitcast i8* %_54 to i8* (i8*)*
	%_56 = call i8* %_55(i8* %_50)
	store i8* %_56, i8** %current_node

	br label %if_end49

if_else48:

	store i1 0, i1* %cont

	br label %if_end49

if_end49:

	br label %if_end39

if_else38:


	store i32 1, i32* %ifound

	store i1 0, i1* %cont

	br label %if_end39

if_end39:

	br label %if_end16

if_end16:

	br label %while_cond0

while_end2:
	%_57 = load i32, i32* %ifound
	ret i32 %_57
}

define i1 @Tree.Print(i8* %this) {
	%current_node = alloca i8*

	%ntb = alloca i1


	store i8* %this, i8** %current_node

	; Tree.RecPrint : 19
	%_0 = bitcast i8* %this to i8***
	%_1 = load i8**, i8*** %_0
	%_2 = getelementptr i8*, i8** %_1, i32 19
	%_3 = load i8*, i8** %_2
	%_4 = bitcast i8* %_3 to i1 (i8*, i8*)*
	%_6 = load i8*, i8** %current_node
	%_5 = call i1 %_4(i8* %this, i8* %_6)
	store i1 %_5, i1* %ntb
	ret i1 1
}

define i1 @Tree.RecPrint(i8* %this, i8* %.node) {
	%node = alloca i8*
	store i8* %.node, i8** %node
	%ntb = alloca i1


	%_0 = load i8*, i8** %node
	; Tree.GetHas_Left : 8
	%_1 = bitcast i8* %_0 to i8***
	%_2 = load i8**, i8*** %_1
	%_3 = getelementptr i8*, i8** %_2, i32 8
	%_4 = load i8*, i8** %_3
	%_5 = bitcast i8* %_4 to i1 (i8*)*
	%_6 = call i1 %_5(i8* %_0)
	br i1 %_6, label %if_then7, label %if_else8

if_then7:


	; Tree.RecPrint : 19
	%_10 = bitcast i8* %this to i8***
	%_11 = load i8**, i8*** %_10
	%_12 = getelementptr i8*, i8** %_11, i32 19
	%_13 = load i8*, i8** %_12
	%_14 = bitcast i8* %_13 to i1 (i8*, i8*)*
	%_16 = load i8*, i8** %node
	; Tree.GetLeft : 4
	%_17 = bitcast i8* %_16 to i8***
	%_18 = load i8**, i8*** %_17
	%_19 = getelementptr i8*, i8** %_18, i32 4
	%_20 = load i8*, i8** %_19
	%_21 = bitcast i8* %_20 to i8* (i8*)*
	%_22 = call i8* %_21(i8* %_16)
	%_15 = call i1 %_14(i8* %this, i8* %_22)
	store i1 %_15, i1* %ntb

	br label %if_end9

if_else8:

	store i1 1, i1* %ntb

	br label %if_end9

if_end9:

	%_23 = load i8*, i8** %node
	; Tree.GetKey : 5
	%_24 = bitcast i8* %_23 to i8***
	%_25 = load i8**, i8*** %_24
	%_26 = getelementptr i8*, i8** %_25, i32 5
	%_27 = load i8*, i8** %_26
	%_28 = bitcast i8* %_27 to i32 (i8*)*
	%_29 = call i32 %_28(i8* %_23)
	call void (i32) @print_int(i32 %_29)

	%_30 = load i8*, i8** %node
	; Tree.GetHas_Right : 7
	%_31 = bitcast i8* %_30 to i8***
	%_32 = load i8**, i8*** %_31
	%_33 = getelementptr i8*, i8** %_32, i32 7
	%_34 = load i8*, i8** %_33
	%_35 = bitcast i8* %_34 to i1 (i8*)*
	%_36 = call i1 %_35(i8* %_30)
	br i1 %_36, label %if_then37, label %if_else38

if_then37:


	; Tree.RecPrint : 19
	%_40 = bitcast i8* %this to i8***
	%_41 = load i8**, i8*** %_40
	%_42 = getelementptr i8*, i8** %_41, i32 19
	%_43 = load i8*, i8** %_42
	%_44 = bitcast i8* %_43 to i1 (i8*, i8*)*
	%_46 = load i8*, i8** %node
	; Tree.GetRight : 3
	%_47 = bitcast i8* %_46 to i8***
	%_48 = load i8**, i8*** %_47
	%_49 = getelementptr i8*, i8** %_48, i32 3
	%_50 = load i8*, i8** %_49
	%_51 = bitcast i8* %_50 to i8* (i8*)*
	%_52 = call i8* %_51(i8* %_46)
	%_45 = call i1 %_44(i8* %this, i8* %_52)
	store i1 %_45, i1* %ntb

	br label %if_end39

if_else38:

	store i1 1, i1* %ntb

	br label %if_end39

if_end39:
	ret i1 1
}

