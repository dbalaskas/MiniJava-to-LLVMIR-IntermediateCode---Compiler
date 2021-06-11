@.QuickSort_vtable = global [0 x i8*] []
@.QS_vtable = global [4 x i8*] [i8* bitcast (i32 (i8*, i32)* @QS.Start to i8*), i8* bitcast (i32 (i8*, i32, i32)* @QS.Sort to i8*), i8* bitcast (i32 (i8*)* @QS.Print to i8*), i8* bitcast (i32 (i8*, i32)* @QS.Init to i8*)]

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
	%_2 = getelementptr [4 x i8*], [4 x i8*]* @.QS_vtable, i32 0, i32 0
	store i8** %_2, i8*** %_1

	; QS.Start : 0
	%_3 = bitcast i8* %_0 to i8***
	%_4 = load i8**, i8*** %_3
	%_5 = getelementptr i8*, i8** %_4, i32 0
	%_6 = load i8*, i8** %_5
	%_7 = bitcast i8* %_6 to i32 (i8*, i32)*
	%_8 = call i32 %_7(i8* %_0, i32 10)

	call void (i32) @print_int(i32 %_8)

	ret i32 0
}

define i32 @QS.Start(i8* %this, i32 %.sz) {
	%sz = alloca i32
	store i32 %.sz, i32* %sz
	%aux01 = alloca i32

	; QS.Init : 3
	%_0 = bitcast i8* %this to i8***
	%_1 = load i8**, i8*** %_0
	%_2 = getelementptr i8*, i8** %_1, i32 3
	%_3 = load i8*, i8** %_2
	%_4 = bitcast i8* %_3 to i32 (i8*, i32)*
	%_6 = load i32, i32* %sz
	%_5 = call i32 %_4(i8* %this, i32 %_6)

	store i32 %_5, i32* %aux01
	; QS.Print : 2
	%_7 = bitcast i8* %this to i8***
	%_8 = load i8**, i8*** %_7
	%_9 = getelementptr i8*, i8** %_8, i32 2
	%_10 = load i8*, i8** %_9
	%_11 = bitcast i8* %_10 to i32 (i8*)*
	%_12 = call i32 %_11(i8* %this)

	store i32 %_12, i32* %aux01
	call void (i32) @print_int(i32 9999)
	%_13 = load i32, i32* %size
	%_14 = sub i32 %_13, 1
	store i32 %_14, i32* %aux01
	; QS.Sort : 1
	%_15 = bitcast i8* %this to i8***
	%_16 = load i8**, i8*** %_15
	%_17 = getelementptr i8*, i8** %_16, i32 1
	%_18 = load i8*, i8** %_17
	%_19 = bitcast i8* %_18 to i32 (i8*, i32, i32)*
	%_21 = load i32, i32* %aux01
	%_20 = call i32 %_19(i8* %this, i32 0, i32 %_21)

	store i32 %_20, i32* %aux01
	; QS.Print : 2
	%_22 = bitcast i8* %this to i8***
	%_23 = load i8**, i8*** %_22
	%_24 = getelementptr i8*, i8** %_23, i32 2
	%_25 = load i8*, i8** %_24
	%_26 = bitcast i8* %_25 to i32 (i8*)*
	%_27 = call i32 %_26(i8* %this)

	store i32 %_27, i32* %aux01
	ret i32 0
}

define i32 @QS.Sort(i8* %this, i32 %.left, i32 %.right) {
	%left = alloca i32
	store i32 %.left, i32* %left
	%right = alloca i32
	store i32 %.right, i32* %right
	%v = alloca i32

	%i = alloca i32

	%j = alloca i32

	%nt = alloca i32

	%t = alloca i32

	%cont01 = alloca i1

	%cont02 = alloca i1

	%aux03 = alloca i32

	store i32 0, i32* %t
	%_0 = load i32, i32* %left
	%_1 = load i32, i32* %right
	%_2 = icmp slt i32 %_0, %_1
	br i1 %_2, label %then3, label %else4

%then3:
	%_6 = load i32*, i32** %number
	%_7 = load i32, i32* %right
	%_8 = load i32, [Ljava.lang.String;@5b37e0d2
	%_9 = icmp sge [Ljava.lang.String;@4459eb14, 0
	%_12 = icmp slt [Ljava.lang.String;@4459eb14, %_8
	%_13 = and i1 %_9, %_12
	br i1 %_13, label %oob_safe10, label %oob_error11

%oob_error11:
	call void @throw_oob()
	br label %oob_safe10

%oob_safe10:
	%_14 = add [Ljava.lang.String;@4459eb14, 1
	%_15 = getelementptr i32, [Ljava.lang.String;@5b37e0d2, i32 %_14
	%_16 = load i32, i32* %_15
	store i32 %_16, i32* %v
	%_17 = load i32, i32* %left
	%_18 = sub i32 %_17, 1
	store i32 %_18, i32* %i
	%_19 = load i32, i32* %right
	store i32 %_19, i32* %j
	store i1 1, i1* %cont01
%cond20:
	%_23 = load i1, i1* %cont01
	br i1 %_23, label %while21, label %end22

%while21:
	store i1 1, i1* %cont02
%cond24:
	%_27 = load i1, i1* %cont02
	br i1 %_27, label %while25, label %end26

%while25:
	%_28 = load i32, i32* %i
	%_29 = add i32 %_28, 1
	store i32 %_29, i32* %i
	%_30 = load i32*, i32** %number
	%_31 = load i32, i32* %i
	%_32 = load i32, [Ljava.lang.String;@5a2e4553
	%_33 = icmp sge [Ljava.lang.String;@28c97a5, 0
	%_36 = icmp slt [Ljava.lang.String;@28c97a5, %_32
	%_37 = and i1 %_33, %_36
	br i1 %_37, label %oob_safe34, label %oob_error35

%oob_error35:
	call void @throw_oob()
	br label %oob_safe34

%oob_safe34:
	%_38 = add [Ljava.lang.String;@28c97a5, 1
	%_39 = getelementptr i32, [Ljava.lang.String;@5a2e4553, i32 %_38
	%_40 = load i32, i32* %_39
	store i32 %_40, i32* %aux03
	%_41 = load i32, i32* %aux03
	%_42 = load i32, i32* %v
	%_43 = icmp slt i32 %_41, %_42
	%_44 = xor i1 1, %_43	br i1 %_44, label %then45, label %else46

%then45:
	store i1 0, i1* %cont02

	br  label %end47

%else46:
	store i1 1, i1* %cont02
%end47:
%end26:
	store i1 1, i1* %cont02
%cond48:
	%_51 = load i1, i1* %cont02
	br i1 %_51, label %while49, label %end50

%while49:
	%_52 = load i32, i32* %j
	%_53 = sub i32 %_52, 1
	store i32 %_53, i32* %j
	%_54 = load i32*, i32** %number
	%_55 = load i32, i32* %j
	%_56 = load i32, [Ljava.lang.String;@6659c656
	%_57 = icmp sge [Ljava.lang.String;@6d5380c2, 0
	%_60 = icmp slt [Ljava.lang.String;@6d5380c2, %_56
	%_61 = and i1 %_57, %_60
	br i1 %_61, label %oob_safe58, label %oob_error59

%oob_error59:
	call void @throw_oob()
	br label %oob_safe58

%oob_safe58:
	%_62 = add [Ljava.lang.String;@6d5380c2, 1
	%_63 = getelementptr i32, [Ljava.lang.String;@6659c656, i32 %_62
	%_64 = load i32, i32* %_63
	store i32 %_64, i32* %aux03
	%_65 = load i32, i32* %v
	%_66 = load i32, i32* %aux03
	%_67 = icmp slt i32 %_65, %_66
	%_68 = xor i1 1, %_67	br i1 %_68, label %then69, label %else70

%then69:
	store i1 0, i1* %cont02

	br  label %end71

%else70:
	store i1 1, i1* %cont02
%end71:
%end50:
	%_72 = load i32*, i32** %number
	%_73 = load i32, i32* %i
	%_74 = load i32, [Ljava.lang.String;@45ff54e6
	%_75 = icmp sge [Ljava.lang.String;@2328c243, 0
	%_78 = icmp slt [Ljava.lang.String;@2328c243, %_74
	%_79 = and i1 %_75, %_78
	br i1 %_79, label %oob_safe76, label %oob_error77

%oob_error77:
	call void @throw_oob()
	br label %oob_safe76

%oob_safe76:
	%_80 = add [Ljava.lang.String;@2328c243, 1
	%_81 = getelementptr i32, [Ljava.lang.String;@45ff54e6, i32 %_80
	%_82 = load i32, i32* %_81
	store i32 %_82, i32* %t
	%_83 = load i32, i32* %i
	%_84 = load i32*, i32** %number
	%_85 = load i32, i32* %j
	%_86 = load i32, [Ljava.lang.String;@bebdb06
	%_87 = icmp sge [Ljava.lang.String;@7a4f0f29, 0
	%_90 = icmp slt [Ljava.lang.String;@7a4f0f29, %_86
	%_91 = and i1 %_87, %_90
	br i1 %_91, label %oob_safe88, label %oob_error89

%oob_error89:
	call void @throw_oob()
	br label %oob_safe88

%oob_safe88:
	%_92 = add [Ljava.lang.String;@7a4f0f29, 1
	%_93 = getelementptr i32, [Ljava.lang.String;@bebdb06, i32 %_92
	%_94 = load i32, i32* %_93
	%_95 = loadi32*, i32** %number
	%_96 = load i32, i32* %_95
	%_97 = icmp sge i32 %_83, 0
	%_98 = icmp slt i32 %_83, %_96
	%_99 = and i1 %_97, %_98
	br i1 %_99, label %l0, label %l1

%l1:
	call void @throw_oob()
%l0:
	%_100 = add i32 %_83, 1
	%_101 = getelementptr i32, i32* %_95, i32 %_100
	store i32 %_94, i32* %_101

	%_102 = load i32, i32* %j
	%_103 = load i32, i32* %t
	%_104 = loadi32*, i32** %number
	%_105 = load i32, i32* %_104
	%_106 = icmp sge i32 %_102, 0
	%_107 = icmp slt i32 %_102, %_105
	%_108 = and i1 %_106, %_107
	br i1 %_108, label %l2, label %l3

%l3:
	call void @throw_oob()
%l2:
	%_109 = add i32 %_102, 1
	%_110 = getelementptr i32, i32* %_104, i32 %_109
	store i32 %_103, i32* %_110

	%_111 = load i32, i32* %j
	%_112 = load i32, i32* %i
	%_113 = add i32 %_112, 1
	%_114 = icmp slt i32 %_111, %_113
	br i1 %_114, label %then115, label %else116

%then115:
	store i1 0, i1* %cont01

	br  label %end117

%else116:
	store i1 1, i1* %cont01
%end117:
%end22:
	%_118 = load i32, i32* %j
	%_119 = load i32*, i32** %number
	%_120 = load i32, i32* %i
	%_121 = load i32, [Ljava.lang.String;@45283ce2
	%_122 = icmp sge [Ljava.lang.String;@2077d4de, 0
	%_125 = icmp slt [Ljava.lang.String;@2077d4de, %_121
	%_126 = and i1 %_122, %_125
	br i1 %_126, label %oob_safe123, label %oob_error124

%oob_error124:
	call void @throw_oob()
	br label %oob_safe123

%oob_safe123:
	%_127 = add [Ljava.lang.String;@2077d4de, 1
	%_128 = getelementptr i32, [Ljava.lang.String;@45283ce2, i32 %_127
	%_129 = load i32, i32* %_128
	%_130 = loadi32*, i32** %number
	%_131 = load i32, i32* %_130
	%_132 = icmp sge i32 %_118, 0
	%_133 = icmp slt i32 %_118, %_131
	%_134 = and i1 %_132, %_133
	br i1 %_134, label %l4, label %l5

%l5:
	call void @throw_oob()
%l4:
	%_135 = add i32 %_118, 1
	%_136 = getelementptr i32, i32* %_130, i32 %_135
	store i32 %_129, i32* %_136

	%_137 = load i32, i32* %i
	%_138 = load i32*, i32** %number
	%_139 = load i32, i32* %right
	%_140 = load i32, [Ljava.lang.String;@7591083d
	%_141 = icmp sge [Ljava.lang.String;@77a567e1, 0
	%_144 = icmp slt [Ljava.lang.String;@77a567e1, %_140
	%_145 = and i1 %_141, %_144
	br i1 %_145, label %oob_safe142, label %oob_error143

%oob_error143:
	call void @throw_oob()
	br label %oob_safe142

%oob_safe142:
	%_146 = add [Ljava.lang.String;@77a567e1, 1
	%_147 = getelementptr i32, [Ljava.lang.String;@7591083d, i32 %_146
	%_148 = load i32, i32* %_147
	%_149 = loadi32*, i32** %number
	%_150 = load i32, i32* %_149
	%_151 = icmp sge i32 %_137, 0
	%_152 = icmp slt i32 %_137, %_150
	%_153 = and i1 %_151, %_152
	br i1 %_153, label %l6, label %l7

%l7:
	call void @throw_oob()
%l6:
	%_154 = add i32 %_137, 1
	%_155 = getelementptr i32, i32* %_149, i32 %_154
	store i32 %_148, i32* %_155

	%_156 = load i32, i32* %right
	%_157 = load i32, i32* %t
	%_158 = loadi32*, i32** %number
	%_159 = load i32, i32* %_158
	%_160 = icmp sge i32 %_156, 0
	%_161 = icmp slt i32 %_156, %_159
	%_162 = and i1 %_160, %_161
	br i1 %_162, label %l8, label %l9

%l9:
	call void @throw_oob()
%l8:
	%_163 = add i32 %_156, 1
	%_164 = getelementptr i32, i32* %_158, i32 %_163
	store i32 %_157, i32* %_164

	; QS.Sort : 1
	%_165 = bitcast i8* %this to i8***
	%_166 = load i8**, i8*** %_165
	%_167 = getelementptr i8*, i8** %_166, i32 1
	%_168 = load i8*, i8** %_167
	%_169 = bitcast i8* %_168 to i32 (i8*, i32, i32)*
	%_171 = load i32, i32* %left
	%_172 = load i32, i32* %i
	%_173 = sub i32 %_172, 1
	%_170 = call i32 %_169(i8* %this, i32 %_171, i32 %_173)

	store i32 %_170, i32* %nt
	; QS.Sort : 1
	%_174 = bitcast i8* %this to i8***
	%_175 = load i8**, i8*** %_174
	%_176 = getelementptr i8*, i8** %_175, i32 1
	%_177 = load i8*, i8** %_176
	%_178 = bitcast i8* %_177 to i32 (i8*, i32, i32)*
	%_180 = load i32, i32* %i
	%_181 = add i32 %_180, 1
	%_182 = load i32, i32* %right
	%_179 = call i32 %_178(i8* %this, i32 %_181, i32 %_182)

	store i32 %_179, i32* %nt

	br  label %end5

%else4:
	store i32 0, i32* %nt
%end5:
	ret i32 0
}

define i32 @QS.Print(i8* %this) {
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
	%_8 = load i32, [Ljava.lang.String;@736e9adb
	%_9 = icmp sge [Ljava.lang.String;@6d21714c, 0
	%_12 = icmp slt [Ljava.lang.String;@6d21714c, %_8
	%_13 = and i1 %_9, %_12
	br i1 %_13, label %oob_safe10, label %oob_error11

%oob_error11:
	call void @throw_oob()
	br label %oob_safe10

%oob_safe10:
	%_14 = add [Ljava.lang.String;@6d21714c, 1
	%_15 = getelementptr i32, [Ljava.lang.String;@736e9adb, i32 %_14
	%_16 = load i32, i32* %_15
	call void (i32) @print_int(i32 %_16)
	%_17 = load i32, i32* %j
	%_18 = add i32 %_17, 1
	store i32 %_18, i32* %j
%end2:
	ret i32 0
}

define i32 @QS.Init(i8* %this, i32 %.sz) {
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

