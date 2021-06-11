@.LinearSearch_vtable = global [0 x i8*] []
@.LS_vtable = global [4 x i8*] [i8* bitcast (i32 (i8*, i32)* @LS.Start to i8*), i8* bitcast (i32 (i8*)* @LS.Print to i8*), i8* bitcast (i32 (i8*, i32)* @LS.Search to i8*), i8* bitcast (i32 (i8*, i32)* @LS.Init to i8*)]

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
	%_2 = getelementptr [4 x i8*], [4 x i8*]* @.LS_vtable, i32 0, i32 0
	store i8** %_2, i8*** %_1

	; LS.Start : 0
	%_3 = bitcast i8* %_0 to i8***
	%_4 = load i8**, i8*** %_3
	%_5 = getelementptr i8*, i8** %_4, i32 0
	%_6 = load i8*, i8** %_5
	%_7 = bitcast i8* %_6 to i32 (i8*, i32)*
	%_8 = call i32 %_7(i8* %_0, i32 10)

	call void (i32) @print_int(i32 %_8)

	ret i32 0
}

define i32 @LS.Start(i8* %this, i32 %.sz) {
	%sz = alloca i32
	store i32 %.sz, i32* %sz
	%aux01 = alloca i32

	%aux02 = alloca i32

	; LS.Init : 3
	%_0 = bitcast i8* %this to i8***
	%_1 = load i8**, i8*** %_0
	%_2 = getelementptr i8*, i8** %_1, i32 3
	%_3 = load i8*, i8** %_2
	%_4 = bitcast i8* %_3 to i32 (i8*, i32)*
	%_6 = load i32, i32* %sz
	%_5 = call i32 %_4(i8* %this, i32 %_6)

	store i32 %_5, i32* %aux01
	; LS.Print : 1
	%_7 = bitcast i8* %this to i8***
	%_8 = load i8**, i8*** %_7
	%_9 = getelementptr i8*, i8** %_8, i32 1
	%_10 = load i8*, i8** %_9
	%_11 = bitcast i8* %_10 to i32 (i8*)*
	%_12 = call i32 %_11(i8* %this)

	store i32 %_12, i32* %aux02
	call void (i32) @print_int(i32 9999)
	; LS.Search : 2
	%_13 = bitcast i8* %this to i8***
	%_14 = load i8**, i8*** %_13
	%_15 = getelementptr i8*, i8** %_14, i32 2
	%_16 = load i8*, i8** %_15
	%_17 = bitcast i8* %_16 to i32 (i8*, i32)*
	%_18 = call i32 %_17(i8* %this, i32 8)

	call void (i32) @print_int(i32 %_18)
	; LS.Search : 2
	%_19 = bitcast i8* %this to i8***
	%_20 = load i8**, i8*** %_19
	%_21 = getelementptr i8*, i8** %_20, i32 2
	%_22 = load i8*, i8** %_21
	%_23 = bitcast i8* %_22 to i32 (i8*, i32)*
	%_24 = call i32 %_23(i8* %this, i32 12)

	call void (i32) @print_int(i32 %_24)
	; LS.Search : 2
	%_25 = bitcast i8* %this to i8***
	%_26 = load i8**, i8*** %_25
	%_27 = getelementptr i8*, i8** %_26, i32 2
	%_28 = load i8*, i8** %_27
	%_29 = bitcast i8* %_28 to i32 (i8*, i32)*
	%_30 = call i32 %_29(i8* %this, i32 17)

	call void (i32) @print_int(i32 %_30)
	; LS.Search : 2
	%_31 = bitcast i8* %this to i8***
	%_32 = load i8**, i8*** %_31
	%_33 = getelementptr i8*, i8** %_32, i32 2
	%_34 = load i8*, i8** %_33
	%_35 = bitcast i8* %_34 to i32 (i8*, i32)*
	%_36 = call i32 %_35(i8* %this, i32 50)

	call void (i32) @print_int(i32 %_36)
	ret i32 55
}

define i32 @LS.Print(i8* %this) {
	%j = alloca i32

	store i32 1, i32* %j
%cond0:
	%_3 = load i32, i32* %j
	%_4 = load i32, i32* %size
	%_5 = icmp slt i32 %_3, %_4
	br i1 %_5, label %while1, label %end2

%while1:
	%_6 = load i32*, i32** %number
	%_7 = load i32, i32* %j
	%_8 = load i32, [Ljava.lang.String;@5f4da5c3
	%_9 = icmp sge [Ljava.lang.String;@443b7951, 0
	%_12 = icmp slt [Ljava.lang.String;@443b7951, %_8
	%_13 = and i1 %_9, %_12
	br i1 %_13, label %oob_safe10, label %oob_error11

%oob_error11:
	call void @throw_oob()
	br label %oob_safe10

%oob_safe10:
	%_14 = add [Ljava.lang.String;@443b7951, 1
	%_15 = getelementptr i32, [Ljava.lang.String;@5f4da5c3, i32 %_14
	%_16 = load i32, i32* %_15
	call void (i32) @print_int(i32 %_16)
	%_17 = load i32, i32* %j
	%_18 = add i32 %_17, 1
	store i32 %_18, i32* %j
%end2:
	ret i32 0
}

define i32 @LS.Search(i8* %this, i32 %.num) {
	%num = alloca i32
	store i32 %.num, i32* %num
	%j = alloca i32

	%ls01 = alloca i1

	%ifound = alloca i32

	%aux01 = alloca i32

	%aux02 = alloca i32

	%nt = alloca i32

	store i32 1, i32* %j
	store i1 0, i1* %ls01
	store i32 0, i32* %ifound
%cond0:
	%_3 = load i32, i32* %j
	%_4 = load i32, i32* %size
	%_5 = icmp slt i32 %_3, %_4
	br i1 %_5, label %while1, label %end2

%while1:
	%_6 = load i32*, i32** %number
	%_7 = load i32, i32* %j
	%_8 = load i32, [Ljava.lang.String;@14514713
	%_9 = icmp sge [Ljava.lang.String;@69663380, 0
	%_12 = icmp slt [Ljava.lang.String;@69663380, %_8
	%_13 = and i1 %_9, %_12
	br i1 %_13, label %oob_safe10, label %oob_error11

%oob_error11:
	call void @throw_oob()
	br label %oob_safe10

%oob_safe10:
	%_14 = add [Ljava.lang.String;@69663380, 1
	%_15 = getelementptr i32, [Ljava.lang.String;@14514713, i32 %_14
	%_16 = load i32, i32* %_15
	store i32 %_16, i32* %aux01
	%_17 = load i32, i32* %num
	%_18 = add i32 %_17, 1
	store i32 %_18, i32* %aux02
	%_19 = load i32, i32* %aux01
	%_20 = load i32, i32* %num
	%_21 = icmp slt i32 %_19, %_20
	br i1 %_21, label %then22, label %else23

%then22:
	store i32 0, i32* %nt

	br  label %end24

%else23:
	%_25 = load i32, i32* %aux01
	%_26 = load i32, i32* %aux02
	%_27 = icmp slt i32 %_25, %_26
	%_28 = xor i1 1, %_27	br i1 %_28, label %then29, label %else30

%then29:
	store i32 0, i32* %nt

	br  label %end31

%else30:
	store i1 1, i1* %ls01
	store i32 1, i32* %ifound
	%_32 = load i32, i32* %size
	store i32 %_32, i32* %j
%end31:
%end24:
	%_33 = load i32, i32* %j
	%_34 = add i32 %_33, 1
	store i32 %_34, i32* %j
%end2:
	%_35 = load i32, i32* %ifound
	ret i32 %_35
}

define i32 @LS.Init(i8* %this, i32 %.sz) {
	%sz = alloca i32
	store i32 %.sz, i32* %sz
	%j = alloca i32

	%k = alloca i32

	%aux01 = alloca i32

	%aux02 = alloca i32

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
	store i32 1, i32* %j
	%_7 = load i32, i32* %size
	%_8 = add i32 %_7, 1
	store i32 %_8, i32* %k
%cond9:
	%_12 = load i32, i32* %j
	%_13 = load i32, i32* %size
	%_14 = icmp slt i32 %_12, %_13
	br i1 %_14, label %while10, label %end11

%while10:
	%_15 = load i32, i32* %j
	%_16 = mul i32 2, %_15
	store i32 %_16, i32* %aux01
	%_17 = load i32, i32* %k
	%_18 = sub i32 %_17, 3
	store i32 %_18, i32* %aux02
	%_19 = load i32, i32* %j
	%_20 = load i32, i32* %aux01
	%_21 = load i32, i32* %aux02
	%_22 = add i32 %_20, %_21
	%_23 = loadi32*, i32** %number
	%_24 = load i32, i32* %_23
	%_25 = icmp sge i32 %_19, 0
	%_26 = icmp slt i32 %_19, %_24
	%_27 = and i1 %_25, %_26
	br i1 %_27, label %l0, label %l1

%l1:
	call void @throw_oob()
%l0:
	%_28 = add i32 %_19, 1
	%_29 = getelementptr i32, i32* %_23, i32 %_28
	store i32 %_22, i32* %_29

	%_30 = load i32, i32* %j
	%_31 = add i32 %_30, 1
	store i32 %_31, i32* %j
	%_32 = load i32, i32* %k
	%_33 = sub i32 %_32, 1
	store i32 %_33, i32* %k
%end11:
	ret i32 0
}

