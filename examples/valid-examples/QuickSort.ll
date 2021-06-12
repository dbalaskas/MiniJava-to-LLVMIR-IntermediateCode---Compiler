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

	%_13 = getelementptr i8, i8* %this, i32 16
	%_14 = bitcast i8* %_13 to i32*
	%_15 = load i32, i32* %_14
	%_16 = sub i32 %_15, 1
	store i32 %_16, i32* %aux01

	; QS.Sort : 1
	%_17 = bitcast i8* %this to i8***
	%_18 = load i8**, i8*** %_17
	%_19 = getelementptr i8*, i8** %_18, i32 1
	%_20 = load i8*, i8** %_19
	%_21 = bitcast i8* %_20 to i32 (i8*, i32, i32)*
	%_23 = load i32, i32* %aux01
	%_22 = call i32 %_21(i8* %this, i32 0, i32 %_23)
	store i32 %_22, i32* %aux01

	; QS.Print : 2
	%_24 = bitcast i8* %this to i8***
	%_25 = load i8**, i8*** %_24
	%_26 = getelementptr i8*, i8** %_25, i32 2
	%_27 = load i8*, i8** %_26
	%_28 = bitcast i8* %_27 to i32 (i8*)*
	%_29 = call i32 %_28(i8* %this)
	store i32 %_29, i32* %aux01
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
	br i1 %_2, label %if_then3, label %if_else4

if_then3:


	%_6 = getelementptr i8, i8* %this, i32 8
	%_7 = bitcast i8* %_6 to i32**
	%_8 = load i32*, i32** %_7
	%_9 = load i32, i32* %right
	%_10 = load i32, i32* %_8
	%_11 = icmp sge i32 %_9, 0
	%_14 = icmp slt i32 %_9, %_10
	%_15 = and i1 %_11, %_14
	br i1 %_15, label %oob_safe12, label %oob_error13

oob_error13:
	call void @throw_oob()
	br label %oob_safe12

oob_safe12:
	%_16 = add i32 %_9, 1
	%_17 = getelementptr i32, i32* %_8, i32 %_16
	%_18 = load i32, i32* %_17
	store i32 %_18, i32* %v

	%_19 = load i32, i32* %left
	%_20 = sub i32 %_19, 1
	store i32 %_20, i32* %i

	%_21 = load i32, i32* %right
	store i32 %_21, i32* %j

	store i1 1, i1* %cont01


	br label %while_cond22

while_cond22:
	%_25 = load i1, i1* %cont01
	br i1 %_25, label %while_body23, label %while_end24

while_body23:


	store i1 1, i1* %cont02


	br label %while_cond26

while_cond26:
	%_29 = load i1, i1* %cont02
	br i1 %_29, label %while_body27, label %while_end28

while_body27:


	%_30 = load i32, i32* %i
	%_31 = add i32 %_30, 1
	store i32 %_31, i32* %i

	%_32 = getelementptr i8, i8* %this, i32 8
	%_33 = bitcast i8* %_32 to i32**
	%_34 = load i32*, i32** %_33
	%_35 = load i32, i32* %i
	%_36 = load i32, i32* %_34
	%_37 = icmp sge i32 %_35, 0
	%_40 = icmp slt i32 %_35, %_36
	%_41 = and i1 %_37, %_40
	br i1 %_41, label %oob_safe38, label %oob_error39

oob_error39:
	call void @throw_oob()
	br label %oob_safe38

oob_safe38:
	%_42 = add i32 %_35, 1
	%_43 = getelementptr i32, i32* %_34, i32 %_42
	%_44 = load i32, i32* %_43
	store i32 %_44, i32* %aux03

	%_45 = load i32, i32* %aux03
	%_46 = load i32, i32* %v
	%_47 = icmp slt i32 %_45, %_46
	%_48 = xor i1 1, %_47
	br i1 %_48, label %if_then49, label %if_else50

if_then49:

	store i1 0, i1* %cont02

	br label %if_end51

if_else50:

	store i1 1, i1* %cont02

	br label %if_end51

if_end51:

	br label %while_cond26

while_end28:

	store i1 1, i1* %cont02


	br label %while_cond52

while_cond52:
	%_55 = load i1, i1* %cont02
	br i1 %_55, label %while_body53, label %while_end54

while_body53:


	%_56 = load i32, i32* %j
	%_57 = sub i32 %_56, 1
	store i32 %_57, i32* %j

	%_58 = getelementptr i8, i8* %this, i32 8
	%_59 = bitcast i8* %_58 to i32**
	%_60 = load i32*, i32** %_59
	%_61 = load i32, i32* %j
	%_62 = load i32, i32* %_60
	%_63 = icmp sge i32 %_61, 0
	%_66 = icmp slt i32 %_61, %_62
	%_67 = and i1 %_63, %_66
	br i1 %_67, label %oob_safe64, label %oob_error65

oob_error65:
	call void @throw_oob()
	br label %oob_safe64

oob_safe64:
	%_68 = add i32 %_61, 1
	%_69 = getelementptr i32, i32* %_60, i32 %_68
	%_70 = load i32, i32* %_69
	store i32 %_70, i32* %aux03

	%_71 = load i32, i32* %v
	%_72 = load i32, i32* %aux03
	%_73 = icmp slt i32 %_71, %_72
	%_74 = xor i1 1, %_73
	br i1 %_74, label %if_then75, label %if_else76

if_then75:

	store i1 0, i1* %cont02

	br label %if_end77

if_else76:

	store i1 1, i1* %cont02

	br label %if_end77

if_end77:

	br label %while_cond52

while_end54:

	%_78 = getelementptr i8, i8* %this, i32 8
	%_79 = bitcast i8* %_78 to i32**
	%_80 = load i32*, i32** %_79
	%_81 = load i32, i32* %i
	%_82 = load i32, i32* %_80
	%_83 = icmp sge i32 %_81, 0
	%_86 = icmp slt i32 %_81, %_82
	%_87 = and i1 %_83, %_86
	br i1 %_87, label %oob_safe84, label %oob_error85

oob_error85:
	call void @throw_oob()
	br label %oob_safe84

oob_safe84:
	%_88 = add i32 %_81, 1
	%_89 = getelementptr i32, i32* %_80, i32 %_88
	%_90 = load i32, i32* %_89
	store i32 %_90, i32* %t

	%_91 = load i32, i32* %i
	%_92 = getelementptr i8, i8* %this, i32 8
	%_93 = bitcast i8* %_92 to i32**
	%_94 = load i32*, i32** %_93
	%_95 = load i32, i32* %j
	%_96 = load i32, i32* %_94
	%_97 = icmp sge i32 %_95, 0
	%_100 = icmp slt i32 %_95, %_96
	%_101 = and i1 %_97, %_100
	br i1 %_101, label %oob_safe98, label %oob_error99

oob_error99:
	call void @throw_oob()
	br label %oob_safe98

oob_safe98:
	%_102 = add i32 %_95, 1
	%_103 = getelementptr i32, i32* %_94, i32 %_102
	%_104 = load i32, i32* %_103
	%_105 = getelementptr i8, i8* %this, i32 8
	%_106 = bitcast i8* %_105 to i32**
	%_107 = load i32*, i32** %_106
	%_108 = load i32, i32* %_107
	%_109 = icmp sge i32 %_91, 0
	%_110 = icmp slt i32 %_91, %_108
	%_111 = and i1 %_109, %_110
	br i1 %_111, label %oob_safe112, label %oob_error113

oob_error113:
	call void @throw_oob()

	br label %oob_safe112

oob_safe112:
	%_114 = add i32 %_91, 1
	%_115 = getelementptr i32, i32* %_107, i32 %_114
	store i32 %_104, i32* %_115


	%_116 = load i32, i32* %j
	%_117 = load i32, i32* %t
	%_118 = getelementptr i8, i8* %this, i32 8
	%_119 = bitcast i8* %_118 to i32**
	%_120 = load i32*, i32** %_119
	%_121 = load i32, i32* %_120
	%_122 = icmp sge i32 %_116, 0
	%_123 = icmp slt i32 %_116, %_121
	%_124 = and i1 %_122, %_123
	br i1 %_124, label %oob_safe125, label %oob_error126

oob_error126:
	call void @throw_oob()

	br label %oob_safe125

oob_safe125:
	%_127 = add i32 %_116, 1
	%_128 = getelementptr i32, i32* %_120, i32 %_127
	store i32 %_117, i32* %_128


	%_129 = load i32, i32* %j
	%_130 = load i32, i32* %i
	%_131 = add i32 %_130, 1
	%_132 = icmp slt i32 %_129, %_131
	br i1 %_132, label %if_then133, label %if_else134

if_then133:

	store i1 0, i1* %cont01

	br label %if_end135

if_else134:

	store i1 1, i1* %cont01

	br label %if_end135

if_end135:

	br label %while_cond22

while_end24:

	%_136 = load i32, i32* %j
	%_137 = getelementptr i8, i8* %this, i32 8
	%_138 = bitcast i8* %_137 to i32**
	%_139 = load i32*, i32** %_138
	%_140 = load i32, i32* %i
	%_141 = load i32, i32* %_139
	%_142 = icmp sge i32 %_140, 0
	%_145 = icmp slt i32 %_140, %_141
	%_146 = and i1 %_142, %_145
	br i1 %_146, label %oob_safe143, label %oob_error144

oob_error144:
	call void @throw_oob()
	br label %oob_safe143

oob_safe143:
	%_147 = add i32 %_140, 1
	%_148 = getelementptr i32, i32* %_139, i32 %_147
	%_149 = load i32, i32* %_148
	%_150 = getelementptr i8, i8* %this, i32 8
	%_151 = bitcast i8* %_150 to i32**
	%_152 = load i32*, i32** %_151
	%_153 = load i32, i32* %_152
	%_154 = icmp sge i32 %_136, 0
	%_155 = icmp slt i32 %_136, %_153
	%_156 = and i1 %_154, %_155
	br i1 %_156, label %oob_safe157, label %oob_error158

oob_error158:
	call void @throw_oob()

	br label %oob_safe157

oob_safe157:
	%_159 = add i32 %_136, 1
	%_160 = getelementptr i32, i32* %_152, i32 %_159
	store i32 %_149, i32* %_160


	%_161 = load i32, i32* %i
	%_162 = getelementptr i8, i8* %this, i32 8
	%_163 = bitcast i8* %_162 to i32**
	%_164 = load i32*, i32** %_163
	%_165 = load i32, i32* %right
	%_166 = load i32, i32* %_164
	%_167 = icmp sge i32 %_165, 0
	%_170 = icmp slt i32 %_165, %_166
	%_171 = and i1 %_167, %_170
	br i1 %_171, label %oob_safe168, label %oob_error169

oob_error169:
	call void @throw_oob()
	br label %oob_safe168

oob_safe168:
	%_172 = add i32 %_165, 1
	%_173 = getelementptr i32, i32* %_164, i32 %_172
	%_174 = load i32, i32* %_173
	%_175 = getelementptr i8, i8* %this, i32 8
	%_176 = bitcast i8* %_175 to i32**
	%_177 = load i32*, i32** %_176
	%_178 = load i32, i32* %_177
	%_179 = icmp sge i32 %_161, 0
	%_180 = icmp slt i32 %_161, %_178
	%_181 = and i1 %_179, %_180
	br i1 %_181, label %oob_safe182, label %oob_error183

oob_error183:
	call void @throw_oob()

	br label %oob_safe182

oob_safe182:
	%_184 = add i32 %_161, 1
	%_185 = getelementptr i32, i32* %_177, i32 %_184
	store i32 %_174, i32* %_185


	%_186 = load i32, i32* %right
	%_187 = load i32, i32* %t
	%_188 = getelementptr i8, i8* %this, i32 8
	%_189 = bitcast i8* %_188 to i32**
	%_190 = load i32*, i32** %_189
	%_191 = load i32, i32* %_190
	%_192 = icmp sge i32 %_186, 0
	%_193 = icmp slt i32 %_186, %_191
	%_194 = and i1 %_192, %_193
	br i1 %_194, label %oob_safe195, label %oob_error196

oob_error196:
	call void @throw_oob()

	br label %oob_safe195

oob_safe195:
	%_197 = add i32 %_186, 1
	%_198 = getelementptr i32, i32* %_190, i32 %_197
	store i32 %_187, i32* %_198


	; QS.Sort : 1
	%_199 = bitcast i8* %this to i8***
	%_200 = load i8**, i8*** %_199
	%_201 = getelementptr i8*, i8** %_200, i32 1
	%_202 = load i8*, i8** %_201
	%_203 = bitcast i8* %_202 to i32 (i8*, i32, i32)*
	%_205 = load i32, i32* %left
	%_206 = load i32, i32* %i
	%_207 = sub i32 %_206, 1
	%_204 = call i32 %_203(i8* %this, i32 %_205, i32 %_207)
	store i32 %_204, i32* %nt

	; QS.Sort : 1
	%_208 = bitcast i8* %this to i8***
	%_209 = load i8**, i8*** %_208
	%_210 = getelementptr i8*, i8** %_209, i32 1
	%_211 = load i8*, i8** %_210
	%_212 = bitcast i8* %_211 to i32 (i8*, i32, i32)*
	%_214 = load i32, i32* %i
	%_215 = add i32 %_214, 1
	%_216 = load i32, i32* %right
	%_213 = call i32 %_212(i8* %this, i32 %_215, i32 %_216)
	store i32 %_213, i32* %nt

	br label %if_end5

if_else4:

	store i32 0, i32* %nt

	br label %if_end5

if_end5:
	ret i32 0
}

define i32 @QS.Print(i8* %this) {
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

define i32 @QS.Init(i8* %this, i32 %.sz) {
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

