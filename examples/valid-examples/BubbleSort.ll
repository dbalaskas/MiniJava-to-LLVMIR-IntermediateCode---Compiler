@.BubbleSort_vtable = global [0 x i8*] []
@.BBS_vtable = global [4 x i8*] [i8* bitcast (i32 (i8*, i32)* @BBS.Start to i8*), i8* bitcast (i32 (i8*)* @BBS.Sort to i8*), i8* bitcast (i32 (i8*)* @BBS.Print to i8*), i8* bitcast (i32 (i8*, i32)* @BBS.Init to i8*)]

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

	%_0 = call i8* @calloc(i32 1, i32 20)
	%_1 = bitcast i8* %_0 to i8***
	%_2 = getelementptr [4 x i8*], [4 x i8*]* @.BBS_vtable, i32 0, i32 0
	store i8** %_2, i8*** %_1
	; BBS.Start : 0
	%_3 = bitcast i8* %_0 to i8***
	%_4 = load i8**, i8*** %_3
	%_5 = getelementptr i8*, i8** %_4, i32 0
	%_6 = load i8*, i8** %_5
	%_7 = bitcast i8* %_6 to i32 (i8*, i32)*
	%_8 = call i32 %_7(i8* %_0, i32 10)
	call void (i32) @print_int(i32 %_8)

	ret i32 0
}

define i32 @BBS.Start(i8* %this, i32 %.sz) {
	%sz = alloca i32
	store i32 %.sz, i32* %sz
	%aux01 = alloca i32


	; BBS.Init : 3
	%_0 = bitcast i8* %this to i8***
	%_1 = load i8**, i8*** %_0
	%_2 = getelementptr i8*, i8** %_1, i32 3
	%_3 = load i8*, i8** %_2
	%_4 = bitcast i8* %_3 to i32 (i8*, i32)*
	%_6 = load i32, i32* %sz
	%_5 = call i32 %_4(i8* %this, i32 %_6)
	store i32 %_5, i32* %aux01

	; BBS.Print : 2
	%_7 = bitcast i8* %this to i8***
	%_8 = load i8**, i8*** %_7
	%_9 = getelementptr i8*, i8** %_8, i32 2
	%_10 = load i8*, i8** %_9
	%_11 = bitcast i8* %_10 to i32 (i8*)*
	%_12 = call i32 %_11(i8* %this)
	store i32 %_12, i32* %aux01

	call void (i32) @print_int(i32 99999)

	; BBS.Sort : 1
	%_13 = bitcast i8* %this to i8***
	%_14 = load i8**, i8*** %_13
	%_15 = getelementptr i8*, i8** %_14, i32 1
	%_16 = load i8*, i8** %_15
	%_17 = bitcast i8* %_16 to i32 (i8*)*
	%_18 = call i32 %_17(i8* %this)
	store i32 %_18, i32* %aux01

	; BBS.Print : 2
	%_19 = bitcast i8* %this to i8***
	%_20 = load i8**, i8*** %_19
	%_21 = getelementptr i8*, i8** %_20, i32 2
	%_22 = load i8*, i8** %_21
	%_23 = bitcast i8* %_22 to i32 (i8*)*
	%_24 = call i32 %_23(i8* %this)
	store i32 %_24, i32* %aux01
	ret i32 0
}

define i32 @BBS.Sort(i8* %this) {
	%nt = alloca i32

	%i = alloca i32

	%aux02 = alloca i32

	%aux04 = alloca i32

	%aux05 = alloca i32

	%aux06 = alloca i32

	%aux07 = alloca i32

	%j = alloca i32

	%t = alloca i32


	%_0 = getelementptr i8, i8* %this, i32 16
	%_1 = bitcast i8* %_0 to i32*
	%_2 = load i32, i32* %_1
	%_3 = sub i32 %_2, 1
	store i32 %_3, i32* %i

	%_4 = sub i32 0, 1
	store i32 %_4, i32* %aux02


	br label %while_cond5

while_cond5:
	%_8 = load i32, i32* %aux02
	%_9 = load i32, i32* %i
	%_10 = icmp slt i32 %_8, %_9
	br i1 %_10, label %while_body6, label %while_end7

while_body6:


	store i32 1, i32* %j


	br label %while_cond11

while_cond11:
	%_14 = load i32, i32* %j
	%_15 = load i32, i32* %i
	%_16 = add i32 %_15, 1
	%_17 = icmp slt i32 %_14, %_16
	br i1 %_17, label %while_body12, label %while_end13

while_body12:


	%_18 = load i32, i32* %j
	%_19 = sub i32 %_18, 1
	store i32 %_19, i32* %aux07

	%_20 = getelementptr i8, i8* %this, i32 8
	%_21 = bitcast i8* %_20 to i32**
	%_22 = load i32*, i32** %_21
	%_23 = load i32, i32* %aux07
	%_24 = load i32, i32* %_22
	%_25 = icmp sge i32 %_23, 0
	%_28 = icmp slt i32 %_23, %_24
	%_29 = and i1 %_25, %_28
	br i1 %_29, label %oob_safe26, label %oob_error27

oob_error27:
	call void @throw_oob()
	br label %oob_safe26

oob_safe26:
	%_30 = add i32 %_23, 1
	%_31 = getelementptr i32, i32* %_22, i32 %_30
	%_32 = load i32, i32* %_31
	store i32 %_32, i32* %aux04

	%_33 = getelementptr i8, i8* %this, i32 8
	%_34 = bitcast i8* %_33 to i32**
	%_35 = load i32*, i32** %_34
	%_36 = load i32, i32* %j
	%_37 = load i32, i32* %_35
	%_38 = icmp sge i32 %_36, 0
	%_41 = icmp slt i32 %_36, %_37
	%_42 = and i1 %_38, %_41
	br i1 %_42, label %oob_safe39, label %oob_error40

oob_error40:
	call void @throw_oob()
	br label %oob_safe39

oob_safe39:
	%_43 = add i32 %_36, 1
	%_44 = getelementptr i32, i32* %_35, i32 %_43
	%_45 = load i32, i32* %_44
	store i32 %_45, i32* %aux05

	%_46 = load i32, i32* %aux05
	%_47 = load i32, i32* %aux04
	%_48 = icmp slt i32 %_46, %_47
	br i1 %_48, label %if_then49, label %if_else50

if_then49:


	%_52 = load i32, i32* %j
	%_53 = sub i32 %_52, 1
	store i32 %_53, i32* %aux06

	%_54 = getelementptr i8, i8* %this, i32 8
	%_55 = bitcast i8* %_54 to i32**
	%_56 = load i32*, i32** %_55
	%_57 = load i32, i32* %aux06
	%_58 = load i32, i32* %_56
	%_59 = icmp sge i32 %_57, 0
	%_62 = icmp slt i32 %_57, %_58
	%_63 = and i1 %_59, %_62
	br i1 %_63, label %oob_safe60, label %oob_error61

oob_error61:
	call void @throw_oob()
	br label %oob_safe60

oob_safe60:
	%_64 = add i32 %_57, 1
	%_65 = getelementptr i32, i32* %_56, i32 %_64
	%_66 = load i32, i32* %_65
	store i32 %_66, i32* %t

	%_67 = load i32, i32* %aux06
	%_68 = getelementptr i8, i8* %this, i32 8
	%_69 = bitcast i8* %_68 to i32**
	%_70 = load i32*, i32** %_69
	%_71 = load i32, i32* %j
	%_72 = load i32, i32* %_70
	%_73 = icmp sge i32 %_71, 0
	%_76 = icmp slt i32 %_71, %_72
	%_77 = and i1 %_73, %_76
	br i1 %_77, label %oob_safe74, label %oob_error75

oob_error75:
	call void @throw_oob()
	br label %oob_safe74

oob_safe74:
	%_78 = add i32 %_71, 1
	%_79 = getelementptr i32, i32* %_70, i32 %_78
	%_80 = load i32, i32* %_79
	%_81 = getelementptr i8, i8* %this, i32 8
	%_82 = bitcast i8* %_81 to i32**
	%_83 = load i32*, i32** %_82
	%_84 = load i32, i32* %_83
	%_85 = icmp sge i32 %_67, 0
	%_86 = icmp slt i32 %_67, %_84
	%_87 = and i1 %_85, %_86
	br i1 %_87, label %oob_safe88, label %oob_error89

oob_error89:
	call void @throw_oob()

	br label %oob_safe88

oob_safe88:
	%_90 = add i32 %_67, 1
	%_91 = getelementptr i32, i32* %_83, i32 %_90
	store i32 %_80, i32* %_91


	%_92 = load i32, i32* %j
	%_93 = load i32, i32* %t
	%_94 = getelementptr i8, i8* %this, i32 8
	%_95 = bitcast i8* %_94 to i32**
	%_96 = load i32*, i32** %_95
	%_97 = load i32, i32* %_96
	%_98 = icmp sge i32 %_92, 0
	%_99 = icmp slt i32 %_92, %_97
	%_100 = and i1 %_98, %_99
	br i1 %_100, label %oob_safe101, label %oob_error102

oob_error102:
	call void @throw_oob()

	br label %oob_safe101

oob_safe101:
	%_103 = add i32 %_92, 1
	%_104 = getelementptr i32, i32* %_96, i32 %_103
	store i32 %_93, i32* %_104


	br label %if_end51

if_else50:

	store i32 0, i32* %nt

	br label %if_end51

if_end51:

	%_105 = load i32, i32* %j
	%_106 = add i32 %_105, 1
	store i32 %_106, i32* %j

	br label %while_cond11

while_end13:

	%_107 = load i32, i32* %i
	%_108 = sub i32 %_107, 1
	store i32 %_108, i32* %i

	br label %while_cond5

while_end7:
	ret i32 0
}

define i32 @BBS.Print(i8* %this) {
	%j = alloca i32


	store i32 0, i32* %j


	br label %while_cond0

while_cond0:
	%_3 = load i32, i32* %j
	%_4 = getelementptr i8, i8* %this, i32 16
	%_5 = bitcast i8* %_4 to i32*
	%_6 = load i32, i32* %_5
	%_7 = icmp slt i32 %_3, %_6
	br i1 %_7, label %while_body1, label %while_end2

while_body1:


	%_8 = getelementptr i8, i8* %this, i32 8
	%_9 = bitcast i8* %_8 to i32**
	%_10 = load i32*, i32** %_9
	%_11 = load i32, i32* %j
	%_12 = load i32, i32* %_10
	%_13 = icmp sge i32 %_11, 0
	%_16 = icmp slt i32 %_11, %_12
	%_17 = and i1 %_13, %_16
	br i1 %_17, label %oob_safe14, label %oob_error15

oob_error15:
	call void @throw_oob()
	br label %oob_safe14

oob_safe14:
	%_18 = add i32 %_11, 1
	%_19 = getelementptr i32, i32* %_10, i32 %_18
	%_20 = load i32, i32* %_19
	call void (i32) @print_int(i32 %_20)

	%_21 = load i32, i32* %j
	%_22 = add i32 %_21, 1
	store i32 %_22, i32* %j

	br label %while_cond0

while_end2:
	ret i32 0
}

define i32 @BBS.Init(i8* %this, i32 %.sz) {
	%sz = alloca i32
	store i32 %.sz, i32* %sz

	%_0 = load i32, i32* %sz
	%_1 = getelementptr i8, i8* %this, i32 16
	%_2 = bitcast i8* %_1 to i32*
	store i32 %_0, i32* %_2

	%_3 = load i32, i32* %sz
	%_4 = add i32 1, %_3
	%_5 = icmp sge i32 %_4, 1
	br i1 %_5, label %oob_safe6, label %oob_error7

oob_error7:
	call void @throw_oob()

	br label %oob_safe6

oob_safe6:
	%_8 = add i32 1, %_3
	%_9 = call i8* @calloc(i32 %_8 , i32 4)
	%_10 = bitcast i8* %_9 to i32*
	store i32 %_3, i32* %_10

	%_11 = getelementptr i8, i8* %this, i32 8
	%_12 = bitcast i8* %_11 to i32**
	store i32* %_10, i32** %_12

	%_13 = getelementptr i8, i8* %this, i32 8
	%_14 = bitcast i8* %_13 to i32**
	%_15 = load i32*, i32** %_14
	%_16 = load i32, i32* %_15
	%_17 = icmp sge i32 0, 0
	%_18 = icmp slt i32 0, %_16
	%_19 = and i1 %_17, %_18
	br i1 %_19, label %oob_safe20, label %oob_error21

oob_error21:
	call void @throw_oob()

	br label %oob_safe20

oob_safe20:
	%_22 = add i32 0, 1
	%_23 = getelementptr i32, i32* %_15, i32 %_22
	store i32 20, i32* %_23


	%_24 = getelementptr i8, i8* %this, i32 8
	%_25 = bitcast i8* %_24 to i32**
	%_26 = load i32*, i32** %_25
	%_27 = load i32, i32* %_26
	%_28 = icmp sge i32 1, 0
	%_29 = icmp slt i32 1, %_27
	%_30 = and i1 %_28, %_29
	br i1 %_30, label %oob_safe31, label %oob_error32

oob_error32:
	call void @throw_oob()

	br label %oob_safe31

oob_safe31:
	%_33 = add i32 1, 1
	%_34 = getelementptr i32, i32* %_26, i32 %_33
	store i32 7, i32* %_34


	%_35 = getelementptr i8, i8* %this, i32 8
	%_36 = bitcast i8* %_35 to i32**
	%_37 = load i32*, i32** %_36
	%_38 = load i32, i32* %_37
	%_39 = icmp sge i32 2, 0
	%_40 = icmp slt i32 2, %_38
	%_41 = and i1 %_39, %_40
	br i1 %_41, label %oob_safe42, label %oob_error43

oob_error43:
	call void @throw_oob()

	br label %oob_safe42

oob_safe42:
	%_44 = add i32 2, 1
	%_45 = getelementptr i32, i32* %_37, i32 %_44
	store i32 12, i32* %_45


	%_46 = getelementptr i8, i8* %this, i32 8
	%_47 = bitcast i8* %_46 to i32**
	%_48 = load i32*, i32** %_47
	%_49 = load i32, i32* %_48
	%_50 = icmp sge i32 3, 0
	%_51 = icmp slt i32 3, %_49
	%_52 = and i1 %_50, %_51
	br i1 %_52, label %oob_safe53, label %oob_error54

oob_error54:
	call void @throw_oob()

	br label %oob_safe53

oob_safe53:
	%_55 = add i32 3, 1
	%_56 = getelementptr i32, i32* %_48, i32 %_55
	store i32 18, i32* %_56


	%_57 = getelementptr i8, i8* %this, i32 8
	%_58 = bitcast i8* %_57 to i32**
	%_59 = load i32*, i32** %_58
	%_60 = load i32, i32* %_59
	%_61 = icmp sge i32 4, 0
	%_62 = icmp slt i32 4, %_60
	%_63 = and i1 %_61, %_62
	br i1 %_63, label %oob_safe64, label %oob_error65

oob_error65:
	call void @throw_oob()

	br label %oob_safe64

oob_safe64:
	%_66 = add i32 4, 1
	%_67 = getelementptr i32, i32* %_59, i32 %_66
	store i32 2, i32* %_67


	%_68 = getelementptr i8, i8* %this, i32 8
	%_69 = bitcast i8* %_68 to i32**
	%_70 = load i32*, i32** %_69
	%_71 = load i32, i32* %_70
	%_72 = icmp sge i32 5, 0
	%_73 = icmp slt i32 5, %_71
	%_74 = and i1 %_72, %_73
	br i1 %_74, label %oob_safe75, label %oob_error76

oob_error76:
	call void @throw_oob()

	br label %oob_safe75

oob_safe75:
	%_77 = add i32 5, 1
	%_78 = getelementptr i32, i32* %_70, i32 %_77
	store i32 11, i32* %_78


	%_79 = getelementptr i8, i8* %this, i32 8
	%_80 = bitcast i8* %_79 to i32**
	%_81 = load i32*, i32** %_80
	%_82 = load i32, i32* %_81
	%_83 = icmp sge i32 6, 0
	%_84 = icmp slt i32 6, %_82
	%_85 = and i1 %_83, %_84
	br i1 %_85, label %oob_safe86, label %oob_error87

oob_error87:
	call void @throw_oob()

	br label %oob_safe86

oob_safe86:
	%_88 = add i32 6, 1
	%_89 = getelementptr i32, i32* %_81, i32 %_88
	store i32 6, i32* %_89


	%_90 = getelementptr i8, i8* %this, i32 8
	%_91 = bitcast i8* %_90 to i32**
	%_92 = load i32*, i32** %_91
	%_93 = load i32, i32* %_92
	%_94 = icmp sge i32 7, 0
	%_95 = icmp slt i32 7, %_93
	%_96 = and i1 %_94, %_95
	br i1 %_96, label %oob_safe97, label %oob_error98

oob_error98:
	call void @throw_oob()

	br label %oob_safe97

oob_safe97:
	%_99 = add i32 7, 1
	%_100 = getelementptr i32, i32* %_92, i32 %_99
	store i32 9, i32* %_100


	%_101 = getelementptr i8, i8* %this, i32 8
	%_102 = bitcast i8* %_101 to i32**
	%_103 = load i32*, i32** %_102
	%_104 = load i32, i32* %_103
	%_105 = icmp sge i32 8, 0
	%_106 = icmp slt i32 8, %_104
	%_107 = and i1 %_105, %_106
	br i1 %_107, label %oob_safe108, label %oob_error109

oob_error109:
	call void @throw_oob()

	br label %oob_safe108

oob_safe108:
	%_110 = add i32 8, 1
	%_111 = getelementptr i32, i32* %_103, i32 %_110
	store i32 19, i32* %_111


	%_112 = getelementptr i8, i8* %this, i32 8
	%_113 = bitcast i8* %_112 to i32**
	%_114 = load i32*, i32** %_113
	%_115 = load i32, i32* %_114
	%_116 = icmp sge i32 9, 0
	%_117 = icmp slt i32 9, %_115
	%_118 = and i1 %_116, %_117
	br i1 %_118, label %oob_safe119, label %oob_error120

oob_error120:
	call void @throw_oob()

	br label %oob_safe119

oob_safe119:
	%_121 = add i32 9, 1
	%_122 = getelementptr i32, i32* %_114, i32 %_121
	store i32 5, i32* %_122

	ret i32 0
}

