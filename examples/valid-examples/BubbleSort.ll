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

	%_0 = load i32, i32* %size
	%_1 = sub i32 %_0, 1
	store i32 %_1, i32* %i
	%_2 = sub i32 0, 1
	store i32 %_2, i32* %aux02
%cond3:
	%_6 = load i32, i32* %aux02
	%_7 = load i32, i32* %i
	%_8 = icmp slt i32 %_6, %_7
	br i1 %_8, label %while4, label %end5

%while4:
	store i32 1, i32* %j
%cond9:
	%_12 = load i32, i32* %j
	%_13 = load i32, i32* %i
	%_14 = add i32 %_13, 1
	%_15 = icmp slt i32 %_12, %_14
	br i1 %_15, label %while10, label %end11

%while10:
	%_16 = load i32, i32* %j
	%_17 = sub i32 %_16, 1
	store i32 %_17, i32* %aux07
	%_18 = load i32*, i32** %number
	%_19 = load i32, i32* %aux07
	%_20 = load i32, [Ljava.lang.String;@579bb367
	%_21 = icmp sge [Ljava.lang.String;@1de0aca6, 0
	%_24 = icmp slt [Ljava.lang.String;@1de0aca6, %_20
	%_25 = and i1 %_21, %_24
	br i1 %_25, label %oob_safe22, label %oob_error23

%oob_error23:
	call void @throw_oob()
	br label %oob_safe22

%oob_safe22:
	%_26 = add [Ljava.lang.String;@1de0aca6, 1
	%_27 = getelementptr i32, [Ljava.lang.String;@579bb367, i32 %_26
	%_28 = load i32, i32* %_27
	store i32 %_28, i32* %aux04
	%_29 = load i32*, i32** %number
	%_30 = load i32, i32* %j
	%_31 = load i32, [Ljava.lang.String;@255316f2
	%_32 = icmp sge [Ljava.lang.String;@41906a77, 0
	%_35 = icmp slt [Ljava.lang.String;@41906a77, %_31
	%_36 = and i1 %_32, %_35
	br i1 %_36, label %oob_safe33, label %oob_error34

%oob_error34:
	call void @throw_oob()
	br label %oob_safe33

%oob_safe33:
	%_37 = add [Ljava.lang.String;@41906a77, 1
	%_38 = getelementptr i32, [Ljava.lang.String;@255316f2, i32 %_37
	%_39 = load i32, i32* %_38
	store i32 %_39, i32* %aux05
	%_40 = load i32, i32* %aux05
	%_41 = load i32, i32* %aux04
	%_42 = icmp slt i32 %_40, %_41
	br i1 %_42, label %then43, label %else44

%then43:
	%_46 = load i32, i32* %j
	%_47 = sub i32 %_46, 1
	store i32 %_47, i32* %aux06
	%_48 = load i32*, i32** %number
	%_49 = load i32, i32* %aux06
	%_50 = load i32, [Ljava.lang.String;@4b9af9a9
	%_51 = icmp sge [Ljava.lang.String;@5387f9e0, 0
	%_54 = icmp slt [Ljava.lang.String;@5387f9e0, %_50
	%_55 = and i1 %_51, %_54
	br i1 %_55, label %oob_safe52, label %oob_error53

%oob_error53:
	call void @throw_oob()
	br label %oob_safe52

%oob_safe52:
	%_56 = add [Ljava.lang.String;@5387f9e0, 1
	%_57 = getelementptr i32, [Ljava.lang.String;@4b9af9a9, i32 %_56
	%_58 = load i32, i32* %_57
	store i32 %_58, i32* %t
	%_59 = load i32, i32* %aux06
	%_60 = load i32*, i32** %number
	%_61 = load i32, i32* %j
	%_62 = load i32, [Ljava.lang.String;@6e5e91e4
	%_63 = icmp sge [Ljava.lang.String;@2cdf8d8a, 0
	%_66 = icmp slt [Ljava.lang.String;@2cdf8d8a, %_62
	%_67 = and i1 %_63, %_66
	br i1 %_67, label %oob_safe64, label %oob_error65

%oob_error65:
	call void @throw_oob()
	br label %oob_safe64

%oob_safe64:
	%_68 = add [Ljava.lang.String;@2cdf8d8a, 1
	%_69 = getelementptr i32, [Ljava.lang.String;@6e5e91e4, i32 %_68
	%_70 = load i32, i32* %_69
	%_71 = loadi32*, i32** %number
	%_72 = load i32, i32* %_71
	%_73 = icmp sge i32 %_59, 0
	%_74 = icmp slt i32 %_59, %_72
	%_75 = and i1 %_73, %_74
	br i1 %_75, label %l0, label %l1

%l1:
	call void @throw_oob()
%l0:
	%_76 = add i32 %_59, 1
	%_77 = getelementptr i32, i32* %_71, i32 %_76
	store i32 %_70, i32* %_77

	%_78 = load i32, i32* %j
	%_79 = load i32, i32* %t
	%_80 = loadi32*, i32** %number
	%_81 = load i32, i32* %_80
	%_82 = icmp sge i32 %_78, 0
	%_83 = icmp slt i32 %_78, %_81
	%_84 = and i1 %_82, %_83
	br i1 %_84, label %l2, label %l3

%l3:
	call void @throw_oob()
%l2:
	%_85 = add i32 %_78, 1
	%_86 = getelementptr i32, i32* %_80, i32 %_85
	store i32 %_79, i32* %_86


	br  label %end45

%else44:
	store i32 0, i32* %nt
%end45:
	%_87 = load i32, i32* %j
	%_88 = add i32 %_87, 1
	store i32 %_88, i32* %j
%end11:
	%_89 = load i32, i32* %i
	%_90 = sub i32 %_89, 1
	store i32 %_90, i32* %i
%end5:
	ret i32 0
}

define i32 @BBS.Print(i8* %this) {
	%j = alloca i32

	store i32 0, i32* %j
%cond0:
	%_3 = load i32, i32* %j
	%_4 = load i32, i32* %size
	%_5 = icmp slt i32 %_3, %_4
	br i1 %_5, label %while1, label %end2

%while1:
	%_6 = load i32*, i32** %number
	%_7 = load i32, i32* %j
	%_8 = load i32, [Ljava.lang.String;@30946e09
	%_9 = icmp sge [Ljava.lang.String;@5cb0d902, 0
	%_12 = icmp slt [Ljava.lang.String;@5cb0d902, %_8
	%_13 = and i1 %_9, %_12
	br i1 %_13, label %oob_safe10, label %oob_error11

%oob_error11:
	call void @throw_oob()
	br label %oob_safe10

%oob_safe10:
	%_14 = add [Ljava.lang.String;@5cb0d902, 1
	%_15 = getelementptr i32, [Ljava.lang.String;@30946e09, i32 %_14
	%_16 = load i32, i32* %_15
	call void (i32) @print_int(i32 %_16)
	%_17 = load i32, i32* %j
	%_18 = add i32 %_17, 1
	store i32 %_18, i32* %j
%end2:
	ret i32 0
}

define i32 @BBS.Init(i8* %this, i32 %.sz) {
	%sz = alloca i32
	store i32 %.sz, i32* %sz
	%_0 = load i32, i32* %sz
	store i32 %_0, i32* %size
	%_1 = load i32, i32* %sz
	%_2 = add i32 1, %_1
	%_3 = icmp sge i32 %_2, 1
	br i1 %_3, label %oob_safe5, label %oob_error6

%oob_error6:
	call void @throw_oob()
%oob_safe5:
	%_2 = add i32 1, %_1
	%_3 = call i8* @calloc(i32 %_2 , i32 4)
	%_4 = bitcast i8* %_3 to i32*
	store %_1, i32* %_4

	store i32* %_4, i32** %number
	%_7 = loadi32*, i32** %number
	%_8 = load i32, i32* %_7
	%_9 = icmp sge i32 0, 0
	%_10 = icmp slt i32 0, %_8
	%_11 = and i1 %_9, %_10
	br i1 %_11, label %l0, label %l1

%l1:
	call void @throw_oob()
%l0:
	%_12 = add i32 0, 1
	%_13 = getelementptr i32, i32* %_7, i32 %_12
	store i32 20, i32* %_13

	%_14 = loadi32*, i32** %number
	%_15 = load i32, i32* %_14
	%_16 = icmp sge i32 1, 0
	%_17 = icmp slt i32 1, %_15
	%_18 = and i1 %_16, %_17
	br i1 %_18, label %l2, label %l3

%l3:
	call void @throw_oob()
%l2:
	%_19 = add i32 1, 1
	%_20 = getelementptr i32, i32* %_14, i32 %_19
	store i32 7, i32* %_20

	%_21 = loadi32*, i32** %number
	%_22 = load i32, i32* %_21
	%_23 = icmp sge i32 2, 0
	%_24 = icmp slt i32 2, %_22
	%_25 = and i1 %_23, %_24
	br i1 %_25, label %l4, label %l5

%l5:
	call void @throw_oob()
%l4:
	%_26 = add i32 2, 1
	%_27 = getelementptr i32, i32* %_21, i32 %_26
	store i32 12, i32* %_27

	%_28 = loadi32*, i32** %number
	%_29 = load i32, i32* %_28
	%_30 = icmp sge i32 3, 0
	%_31 = icmp slt i32 3, %_29
	%_32 = and i1 %_30, %_31
	br i1 %_32, label %l6, label %l7

%l7:
	call void @throw_oob()
%l6:
	%_33 = add i32 3, 1
	%_34 = getelementptr i32, i32* %_28, i32 %_33
	store i32 18, i32* %_34

	%_35 = loadi32*, i32** %number
	%_36 = load i32, i32* %_35
	%_37 = icmp sge i32 4, 0
	%_38 = icmp slt i32 4, %_36
	%_39 = and i1 %_37, %_38
	br i1 %_39, label %l8, label %l9

%l9:
	call void @throw_oob()
%l8:
	%_40 = add i32 4, 1
	%_41 = getelementptr i32, i32* %_35, i32 %_40
	store i32 2, i32* %_41

	%_42 = loadi32*, i32** %number
	%_43 = load i32, i32* %_42
	%_44 = icmp sge i32 5, 0
	%_45 = icmp slt i32 5, %_43
	%_46 = and i1 %_44, %_45
	br i1 %_46, label %l10, label %l11

%l11:
	call void @throw_oob()
%l10:
	%_47 = add i32 5, 1
	%_48 = getelementptr i32, i32* %_42, i32 %_47
	store i32 11, i32* %_48

	%_49 = loadi32*, i32** %number
	%_50 = load i32, i32* %_49
	%_51 = icmp sge i32 6, 0
	%_52 = icmp slt i32 6, %_50
	%_53 = and i1 %_51, %_52
	br i1 %_53, label %l12, label %l13

%l13:
	call void @throw_oob()
%l12:
	%_54 = add i32 6, 1
	%_55 = getelementptr i32, i32* %_49, i32 %_54
	store i32 6, i32* %_55

	%_56 = loadi32*, i32** %number
	%_57 = load i32, i32* %_56
	%_58 = icmp sge i32 7, 0
	%_59 = icmp slt i32 7, %_57
	%_60 = and i1 %_58, %_59
	br i1 %_60, label %l14, label %l15

%l15:
	call void @throw_oob()
%l14:
	%_61 = add i32 7, 1
	%_62 = getelementptr i32, i32* %_56, i32 %_61
	store i32 9, i32* %_62

	%_63 = loadi32*, i32** %number
	%_64 = load i32, i32* %_63
	%_65 = icmp sge i32 8, 0
	%_66 = icmp slt i32 8, %_64
	%_67 = and i1 %_65, %_66
	br i1 %_67, label %l16, label %l17

%l17:
	call void @throw_oob()
%l16:
	%_68 = add i32 8, 1
	%_69 = getelementptr i32, i32* %_63, i32 %_68
	store i32 19, i32* %_69

	%_70 = loadi32*, i32** %number
	%_71 = load i32, i32* %_70
	%_72 = icmp sge i32 9, 0
	%_73 = icmp slt i32 9, %_71
	%_74 = and i1 %_72, %_73
	br i1 %_74, label %l18, label %l19

%l19:
	call void @throw_oob()
%l18:
	%_75 = add i32 9, 1
	%_76 = getelementptr i32, i32* %_70, i32 %_75
	store i32 5, i32* %_76

	ret i32 0
}

