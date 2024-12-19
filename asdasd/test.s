	.text
	.file	"test.56cce0315692f355-cgu.0"
	.section	.text._ZN3std2rt10lang_start17h82442523f03a3fd7E,"ax",@progbits
	.hidden	_ZN3std2rt10lang_start17h82442523f03a3fd7E
	.globl	_ZN3std2rt10lang_start17h82442523f03a3fd7E
	.p2align	4, 0x90
	.type	_ZN3std2rt10lang_start17h82442523f03a3fd7E,@function
_ZN3std2rt10lang_start17h82442523f03a3fd7E:
	.cfi_startproc
	subq	$24, %rsp
	.cfi_def_cfa_offset 32
	movl	%ecx, %eax
	movq	%rdx, %rcx
	movq	%rsi, %rdx
	movq	%rdi, 16(%rsp)
	leaq	16(%rsp), %rdi
	leaq	.L__unnamed_1(%rip), %rsi
	movzbl	%al, %r8d
	callq	*_ZN3std2rt19lang_start_internal17h5e7c81cecd7f0954E@GOTPCREL(%rip)
	movq	%rax, 8(%rsp)
	movq	8(%rsp), %rax
	addq	$24, %rsp
	.cfi_def_cfa_offset 8
	retq
.Lfunc_end0:
	.size	_ZN3std2rt10lang_start17h82442523f03a3fd7E, .Lfunc_end0-_ZN3std2rt10lang_start17h82442523f03a3fd7E
	.cfi_endproc

	.section	".text._ZN3std2rt10lang_start28_$u7b$$u7b$closure$u7d$$u7d$17h69511e68c1840078E","ax",@progbits
	.p2align	4, 0x90
	.type	_ZN3std2rt10lang_start28_$u7b$$u7b$closure$u7d$$u7d$17h69511e68c1840078E,@function
_ZN3std2rt10lang_start28_$u7b$$u7b$closure$u7d$$u7d$17h69511e68c1840078E:
	.cfi_startproc
	pushq	%rax
	.cfi_def_cfa_offset 16
	movq	(%rdi), %rdi
	callq	_ZN3std3sys9backtrace28__rust_begin_short_backtrace17h31a850e0cf0a3772E
	callq	_ZN54_$LT$$LP$$RP$$u20$as$u20$std..process..Termination$GT$6report17h531bf418c26fc693E
	movb	%al, 7(%rsp)
	movzbl	7(%rsp), %eax
	popq	%rcx
	.cfi_def_cfa_offset 8
	retq
.Lfunc_end1:
	.size	_ZN3std2rt10lang_start28_$u7b$$u7b$closure$u7d$$u7d$17h69511e68c1840078E, .Lfunc_end1-_ZN3std2rt10lang_start28_$u7b$$u7b$closure$u7d$$u7d$17h69511e68c1840078E
	.cfi_endproc

	.section	.text._ZN3std3sys9backtrace28__rust_begin_short_backtrace17h31a850e0cf0a3772E,"ax",@progbits
	.p2align	4, 0x90
	.type	_ZN3std3sys9backtrace28__rust_begin_short_backtrace17h31a850e0cf0a3772E,@function
_ZN3std3sys9backtrace28__rust_begin_short_backtrace17h31a850e0cf0a3772E:
	.cfi_startproc
	pushq	%rax
	.cfi_def_cfa_offset 16
	callq	_ZN4core3ops8function6FnOnce9call_once17hc46e6687e4162435E
	#APP
	#NO_APP
	popq	%rax
	.cfi_def_cfa_offset 8
	retq
.Lfunc_end2:
	.size	_ZN3std3sys9backtrace28__rust_begin_short_backtrace17h31a850e0cf0a3772E, .Lfunc_end2-_ZN3std3sys9backtrace28__rust_begin_short_backtrace17h31a850e0cf0a3772E
	.cfi_endproc

	.section	.text._ZN4core10intrinsics19copy_nonoverlapping18precondition_check17ha6b37f6b331c479fE,"ax",@progbits
	.p2align	4, 0x90
	.type	_ZN4core10intrinsics19copy_nonoverlapping18precondition_check17ha6b37f6b331c479fE,@function
_ZN4core10intrinsics19copy_nonoverlapping18precondition_check17ha6b37f6b331c479fE:
.Lfunc_begin0:
	.cfi_startproc
	.cfi_personality 155, DW.ref.rust_eh_personality
	.cfi_lsda 27, .Lexception0
	subq	$152, %rsp
	.cfi_def_cfa_offset 160
	movq	%rdi, 8(%rsp)
	movq	%rsi, 16(%rsp)
	movq	%rdx, 24(%rsp)
	movq	%rcx, 32(%rsp)
	movq	%r8, 40(%rsp)
	cmpq	$0, %rdi
	jne	.LBB3_2
	jmp	.LBB3_3
.LBB3_2:
	movq	32(%rsp), %rcx
	movq	%rcx, %rax
	shrq	%rax
	movabsq	$6148914691236517205, %rdx
	andq	%rdx, %rax
	subq	%rax, %rcx
	movabsq	$3689348814741910323, %rdx
	movq	%rcx, %rax
	andq	%rdx, %rax
	shrq	$2, %rcx
	andq	%rdx, %rcx
	addq	%rcx, %rax
	movq	%rax, %rcx
	shrq	$4, %rcx
	addq	%rcx, %rax
	movabsq	$1085102592571150095, %rcx
	andq	%rcx, %rax
	movabsq	$72340172838076673, %rcx
	imulq	%rcx, %rax
	shrq	$56, %rax
	movl	%eax, 144(%rsp)
	cmpl	$1, 144(%rsp)
	je	.LBB3_4
	jmp	.LBB3_5
.LBB3_3:
	jmp	.LBB3_7
.LBB3_4:
	movq	8(%rsp), %rax
	movq	32(%rsp), %rcx
	subq	$1, %rcx
	andq	%rcx, %rax
	cmpq	$0, %rax
	je	.LBB3_6
	jmp	.LBB3_3
.LBB3_5:
	leaq	.L__unnamed_2(%rip), %rax
	movq	%rax, 48(%rsp)
	movq	$1, 56(%rsp)
	movq	.L__unnamed_3(%rip), %rcx
	movq	.L__unnamed_3+8(%rip), %rax
	movq	%rcx, 80(%rsp)
	movq	%rax, 88(%rsp)
	movq	$8, 64(%rsp)
	movq	$0, 72(%rsp)
.Ltmp0:
	leaq	.L__unnamed_4(%rip), %rsi
	movq	_ZN4core9panicking9panic_fmt17h3d8fc78294164da7E@GOTPCREL(%rip), %rax
	leaq	48(%rsp), %rdi
	callq	*%rax
.Ltmp1:
	jmp	.LBB3_18
.LBB3_6:
	movq	16(%rsp), %rax
	cmpq	$0, %rax
	je	.LBB3_8
	jmp	.LBB3_9
.LBB3_7:
	leaq	.L__unnamed_5(%rip), %rdi
	movq	_ZN4core9panicking14panic_nounwind17hb98133c151c787e4E@GOTPCREL(%rip), %rax
	movl	$166, %esi
	callq	*%rax
.LBB3_8:
	jmp	.LBB3_10
.LBB3_9:
	movq	32(%rsp), %rcx
	movq	%rcx, %rax
	shrq	%rax
	movabsq	$6148914691236517205, %rdx
	andq	%rdx, %rax
	subq	%rax, %rcx
	movabsq	$3689348814741910323, %rdx
	movq	%rcx, %rax
	andq	%rdx, %rax
	shrq	$2, %rcx
	andq	%rdx, %rcx
	addq	%rcx, %rax
	movq	%rax, %rcx
	shrq	$4, %rcx
	addq	%rcx, %rax
	movabsq	$1085102592571150095, %rcx
	andq	%rcx, %rax
	movabsq	$72340172838076673, %rcx
	imulq	%rcx, %rax
	shrq	$56, %rax
	movl	%eax, 148(%rsp)
	cmpl	$1, 148(%rsp)
	je	.LBB3_11
	jmp	.LBB3_12
.LBB3_10:
	jmp	.LBB3_7
.LBB3_11:
	movq	16(%rsp), %rax
	movq	32(%rsp), %rcx
	subq	$1, %rcx
	andq	%rcx, %rax
	cmpq	$0, %rax
	je	.LBB3_13
	jmp	.LBB3_10
.LBB3_12:
	leaq	.L__unnamed_2(%rip), %rax
	movq	%rax, 96(%rsp)
	movq	$1, 104(%rsp)
	movq	.L__unnamed_3(%rip), %rcx
	movq	.L__unnamed_3+8(%rip), %rax
	movq	%rcx, 128(%rsp)
	movq	%rax, 136(%rsp)
	movq	$8, 112(%rsp)
	movq	$0, 120(%rsp)
.Ltmp2:
	leaq	.L__unnamed_4(%rip), %rsi
	movq	_ZN4core9panicking9panic_fmt17h3d8fc78294164da7E@GOTPCREL(%rip), %rax
	leaq	96(%rsp), %rdi
	callq	*%rax
.Ltmp3:
	jmp	.LBB3_18
.LBB3_13:
.Ltmp4:
	movq	40(%rsp), %rcx
	movq	24(%rsp), %rdx
	movq	16(%rsp), %rsi
	movq	8(%rsp), %rdi
	callq	_ZN4core9ub_checks17is_nonoverlapping7runtime17h9f6df3659ea4d9c5E
.Ltmp5:
	movb	%al, 7(%rsp)
	jmp	.LBB3_15
.LBB3_14:
.Ltmp6:
	movq	_ZN4core9panicking19panic_cannot_unwind17he9511e6e72319a3eE@GOTPCREL(%rip), %rax
	callq	*%rax
.LBB3_15:
	movb	7(%rsp), %al
	testb	$1, %al
	jne	.LBB3_17
	jmp	.LBB3_16
.LBB3_16:
	jmp	.LBB3_7
.LBB3_17:
	addq	$152, %rsp
	.cfi_def_cfa_offset 8
	retq
.LBB3_18:
	.cfi_def_cfa_offset 160
	ud2
.Lfunc_end3:
	.size	_ZN4core10intrinsics19copy_nonoverlapping18precondition_check17ha6b37f6b331c479fE, .Lfunc_end3-_ZN4core10intrinsics19copy_nonoverlapping18precondition_check17ha6b37f6b331c479fE
	.cfi_endproc
	.section	.gcc_except_table._ZN4core10intrinsics19copy_nonoverlapping18precondition_check17ha6b37f6b331c479fE,"a",@progbits
	.p2align	2, 0x0
GCC_except_table3:
.Lexception0:
	.byte	255
	.byte	155
	.uleb128 .Lttbase0-.Lttbaseref0
.Lttbaseref0:
	.byte	1
	.uleb128 .Lcst_end0-.Lcst_begin0
.Lcst_begin0:
	.uleb128 .Ltmp0-.Lfunc_begin0
	.uleb128 .Ltmp1-.Ltmp0
	.uleb128 .Ltmp6-.Lfunc_begin0
	.byte	1
	.uleb128 .Ltmp1-.Lfunc_begin0
	.uleb128 .Ltmp2-.Ltmp1
	.byte	0
	.byte	0
	.uleb128 .Ltmp2-.Lfunc_begin0
	.uleb128 .Ltmp5-.Ltmp2
	.uleb128 .Ltmp6-.Lfunc_begin0
	.byte	1
	.uleb128 .Ltmp5-.Lfunc_begin0
	.uleb128 .Lfunc_end3-.Ltmp5
	.byte	0
	.byte	0
.Lcst_end0:
	.byte	127
	.byte	0
	.p2align	2, 0x0
.Lttbase0:
	.byte	0
	.p2align	2, 0x0

	.section	.text._ZN4core10intrinsics8unlikely17h08c91af1aaf64fcdE,"ax",@progbits
	.p2align	4, 0x90
	.type	_ZN4core10intrinsics8unlikely17h08c91af1aaf64fcdE,@function
_ZN4core10intrinsics8unlikely17h08c91af1aaf64fcdE:
	.cfi_startproc
	movb	%dil, %al
	andb	$1, %al
	movzbl	%al, %eax
	retq
.Lfunc_end4:
	.size	_ZN4core10intrinsics8unlikely17h08c91af1aaf64fcdE, .Lfunc_end4-_ZN4core10intrinsics8unlikely17h08c91af1aaf64fcdE
	.cfi_endproc

	.section	".text._ZN4core3num23_$LT$impl$u20$usize$GT$13unchecked_mul18precondition_check17hafab140d62053b64E","ax",@progbits
	.p2align	4, 0x90
	.type	_ZN4core3num23_$LT$impl$u20$usize$GT$13unchecked_mul18precondition_check17hafab140d62053b64E,@function
_ZN4core3num23_$LT$impl$u20$usize$GT$13unchecked_mul18precondition_check17hafab140d62053b64E:
	.cfi_startproc
	pushq	%rax
	.cfi_def_cfa_offset 16
	movq	%rdi, %rax
	mulq	%rsi
	seto	%al
	jo	.LBB5_2
	popq	%rax
	.cfi_def_cfa_offset 8
	retq
.LBB5_2:
	.cfi_def_cfa_offset 16
	leaq	.L__unnamed_6(%rip), %rdi
	movq	_ZN4core9panicking14panic_nounwind17hb98133c151c787e4E@GOTPCREL(%rip), %rax
	movl	$69, %esi
	callq	*%rax
.Lfunc_end5:
	.size	_ZN4core3num23_$LT$impl$u20$usize$GT$13unchecked_mul18precondition_check17hafab140d62053b64E, .Lfunc_end5-_ZN4core3num23_$LT$impl$u20$usize$GT$13unchecked_mul18precondition_check17hafab140d62053b64E
	.cfi_endproc

	.section	".text._ZN4core3ops8function6FnOnce40call_once$u7b$$u7b$vtable.shim$u7d$$u7d$17h26481ca4a7938697E","ax",@progbits
	.p2align	4, 0x90
	.type	_ZN4core3ops8function6FnOnce40call_once$u7b$$u7b$vtable.shim$u7d$$u7d$17h26481ca4a7938697E,@function
_ZN4core3ops8function6FnOnce40call_once$u7b$$u7b$vtable.shim$u7d$$u7d$17h26481ca4a7938697E:
	.cfi_startproc
	pushq	%rax
	.cfi_def_cfa_offset 16
	movq	(%rdi), %rdi
	callq	_ZN4core3ops8function6FnOnce9call_once17h9f38d27cd5262597E
	popq	%rcx
	.cfi_def_cfa_offset 8
	retq
.Lfunc_end6:
	.size	_ZN4core3ops8function6FnOnce40call_once$u7b$$u7b$vtable.shim$u7d$$u7d$17h26481ca4a7938697E, .Lfunc_end6-_ZN4core3ops8function6FnOnce40call_once$u7b$$u7b$vtable.shim$u7d$$u7d$17h26481ca4a7938697E
	.cfi_endproc

	.section	.text._ZN4core3ops8function6FnOnce9call_once17h9f38d27cd5262597E,"ax",@progbits
	.p2align	4, 0x90
	.type	_ZN4core3ops8function6FnOnce9call_once17h9f38d27cd5262597E,@function
_ZN4core3ops8function6FnOnce9call_once17h9f38d27cd5262597E:
.Lfunc_begin1:
	.cfi_startproc
	.cfi_personality 155, DW.ref.rust_eh_personality
	.cfi_lsda 27, .Lexception1
	subq	$40, %rsp
	.cfi_def_cfa_offset 48
	movq	%rdi, 8(%rsp)
.Ltmp7:
	leaq	8(%rsp), %rdi
	callq	_ZN3std2rt10lang_start28_$u7b$$u7b$closure$u7d$$u7d$17h69511e68c1840078E
.Ltmp8:
	movl	%eax, 4(%rsp)
	jmp	.LBB7_3
.LBB7_1:
	movq	24(%rsp), %rdi
	callq	_Unwind_Resume@PLT
.LBB7_2:
.Ltmp9:
	movq	%rax, %rcx
	movl	%edx, %eax
	movq	%rcx, 24(%rsp)
	movl	%eax, 32(%rsp)
	jmp	.LBB7_1
.LBB7_3:
	movl	4(%rsp), %eax
	addq	$40, %rsp
	.cfi_def_cfa_offset 8
	retq
.Lfunc_end7:
	.size	_ZN4core3ops8function6FnOnce9call_once17h9f38d27cd5262597E, .Lfunc_end7-_ZN4core3ops8function6FnOnce9call_once17h9f38d27cd5262597E
	.cfi_endproc
	.section	.gcc_except_table._ZN4core3ops8function6FnOnce9call_once17h9f38d27cd5262597E,"a",@progbits
	.p2align	2, 0x0
GCC_except_table7:
.Lexception1:
	.byte	255
	.byte	255
	.byte	1
	.uleb128 .Lcst_end1-.Lcst_begin1
.Lcst_begin1:
	.uleb128 .Ltmp7-.Lfunc_begin1
	.uleb128 .Ltmp8-.Ltmp7
	.uleb128 .Ltmp9-.Lfunc_begin1
	.byte	0
	.uleb128 .Ltmp8-.Lfunc_begin1
	.uleb128 .Lfunc_end7-.Ltmp8
	.byte	0
	.byte	0
.Lcst_end1:
	.p2align	2, 0x0

	.section	.text._ZN4core3ops8function6FnOnce9call_once17hc46e6687e4162435E,"ax",@progbits
	.p2align	4, 0x90
	.type	_ZN4core3ops8function6FnOnce9call_once17hc46e6687e4162435E,@function
_ZN4core3ops8function6FnOnce9call_once17hc46e6687e4162435E:
	.cfi_startproc
	pushq	%rax
	.cfi_def_cfa_offset 16
	callq	*%rdi
	popq	%rax
	.cfi_def_cfa_offset 8
	retq
.Lfunc_end8:
	.size	_ZN4core3ops8function6FnOnce9call_once17hc46e6687e4162435E, .Lfunc_end8-_ZN4core3ops8function6FnOnce9call_once17hc46e6687e4162435E
	.cfi_endproc

	.section	.text._ZN4core3ptr13read_volatile18precondition_check17h696761da07e38143E,"ax",@progbits
	.p2align	4, 0x90
	.type	_ZN4core3ptr13read_volatile18precondition_check17h696761da07e38143E,@function
_ZN4core3ptr13read_volatile18precondition_check17h696761da07e38143E:
.Lfunc_begin2:
	.cfi_startproc
	.cfi_personality 155, DW.ref.rust_eh_personality
	.cfi_lsda 27, .Lexception2
	subq	$72, %rsp
	.cfi_def_cfa_offset 80
	movq	%rdi, (%rsp)
	movq	%rsi, 8(%rsp)
	cmpq	$0, %rdi
	jne	.LBB9_2
	jmp	.LBB9_3
.LBB9_2:
	movq	8(%rsp), %rcx
	movq	%rcx, %rax
	shrq	%rax
	movabsq	$6148914691236517205, %rdx
	andq	%rdx, %rax
	subq	%rax, %rcx
	movabsq	$3689348814741910323, %rdx
	movq	%rcx, %rax
	andq	%rdx, %rax
	shrq	$2, %rcx
	andq	%rdx, %rcx
	addq	%rcx, %rax
	movq	%rax, %rcx
	shrq	$4, %rcx
	addq	%rcx, %rax
	movabsq	$1085102592571150095, %rcx
	andq	%rcx, %rax
	movabsq	$72340172838076673, %rcx
	imulq	%rcx, %rax
	shrq	$56, %rax
	movl	%eax, 68(%rsp)
	cmpl	$1, 68(%rsp)
	je	.LBB9_4
	jmp	.LBB9_5
.LBB9_3:
	leaq	.L__unnamed_7(%rip), %rdi
	movq	_ZN4core9panicking14panic_nounwind17hb98133c151c787e4E@GOTPCREL(%rip), %rax
	movl	$110, %esi
	callq	*%rax
.LBB9_4:
	movq	(%rsp), %rax
	movq	8(%rsp), %rcx
	subq	$1, %rcx
	andq	%rcx, %rax
	cmpq	$0, %rax
	je	.LBB9_6
	jmp	.LBB9_3
.LBB9_5:
	leaq	.L__unnamed_2(%rip), %rax
	movq	%rax, 16(%rsp)
	movq	$1, 24(%rsp)
	movq	.L__unnamed_3(%rip), %rcx
	movq	.L__unnamed_3+8(%rip), %rax
	movq	%rcx, 48(%rsp)
	movq	%rax, 56(%rsp)
	movq	$8, 32(%rsp)
	movq	$0, 40(%rsp)
.Ltmp10:
	leaq	.L__unnamed_4(%rip), %rsi
	movq	_ZN4core9panicking9panic_fmt17h3d8fc78294164da7E@GOTPCREL(%rip), %rax
	leaq	16(%rsp), %rdi
	callq	*%rax
.Ltmp11:
	jmp	.LBB9_8
.LBB9_6:
	addq	$72, %rsp
	.cfi_def_cfa_offset 8
	retq
.LBB9_7:
	.cfi_def_cfa_offset 80
.Ltmp12:
	movq	_ZN4core9panicking19panic_cannot_unwind17he9511e6e72319a3eE@GOTPCREL(%rip), %rax
	callq	*%rax
.LBB9_8:
	ud2
.Lfunc_end9:
	.size	_ZN4core3ptr13read_volatile18precondition_check17h696761da07e38143E, .Lfunc_end9-_ZN4core3ptr13read_volatile18precondition_check17h696761da07e38143E
	.cfi_endproc
	.section	.gcc_except_table._ZN4core3ptr13read_volatile18precondition_check17h696761da07e38143E,"a",@progbits
	.p2align	2, 0x0
GCC_except_table9:
.Lexception2:
	.byte	255
	.byte	155
	.uleb128 .Lttbase1-.Lttbaseref1
.Lttbaseref1:
	.byte	1
	.uleb128 .Lcst_end2-.Lcst_begin2
.Lcst_begin2:
	.uleb128 .Lfunc_begin2-.Lfunc_begin2
	.uleb128 .Ltmp10-.Lfunc_begin2
	.byte	0
	.byte	0
	.uleb128 .Ltmp10-.Lfunc_begin2
	.uleb128 .Ltmp11-.Ltmp10
	.uleb128 .Ltmp12-.Lfunc_begin2
	.byte	1
	.uleb128 .Ltmp11-.Lfunc_begin2
	.uleb128 .Lfunc_end9-.Ltmp11
	.byte	0
	.byte	0
.Lcst_end2:
	.byte	127
	.byte	0
	.p2align	2, 0x0
.Lttbase1:
	.byte	0
	.p2align	2, 0x0

	.section	".text._ZN4core3ptr42drop_in_place$LT$alloc..string..String$GT$17h936e75eee6fe0e7eE","ax",@progbits
	.p2align	4, 0x90
	.type	_ZN4core3ptr42drop_in_place$LT$alloc..string..String$GT$17h936e75eee6fe0e7eE,@function
_ZN4core3ptr42drop_in_place$LT$alloc..string..String$GT$17h936e75eee6fe0e7eE:
	.cfi_startproc
	pushq	%rax
	.cfi_def_cfa_offset 16
	callq	_ZN4core3ptr46drop_in_place$LT$alloc..vec..Vec$LT$u8$GT$$GT$17hf89c47acad7d8bf6E
	popq	%rax
	.cfi_def_cfa_offset 8
	retq
.Lfunc_end10:
	.size	_ZN4core3ptr42drop_in_place$LT$alloc..string..String$GT$17h936e75eee6fe0e7eE, .Lfunc_end10-_ZN4core3ptr42drop_in_place$LT$alloc..string..String$GT$17h936e75eee6fe0e7eE
	.cfi_endproc

	.section	".text._ZN4core3ptr46drop_in_place$LT$alloc..vec..Vec$LT$u8$GT$$GT$17hf89c47acad7d8bf6E","ax",@progbits
	.p2align	4, 0x90
	.type	_ZN4core3ptr46drop_in_place$LT$alloc..vec..Vec$LT$u8$GT$$GT$17hf89c47acad7d8bf6E,@function
_ZN4core3ptr46drop_in_place$LT$alloc..vec..Vec$LT$u8$GT$$GT$17hf89c47acad7d8bf6E:
.Lfunc_begin3:
	.cfi_startproc
	.cfi_personality 155, DW.ref.rust_eh_personality
	.cfi_lsda 27, .Lexception3
	subq	$24, %rsp
	.cfi_def_cfa_offset 32
	movq	%rdi, (%rsp)
.Ltmp13:
	callq	_ZN70_$LT$alloc..vec..Vec$LT$T$C$A$GT$$u20$as$u20$core..ops..drop..Drop$GT$4drop17h021f2c47474d366eE
.Ltmp14:
	jmp	.LBB11_3
.LBB11_1:
.Ltmp16:
	movq	(%rsp), %rdi
	callq	_ZN4core3ptr53drop_in_place$LT$alloc..raw_vec..RawVec$LT$u8$GT$$GT$17h0a36b080d6ee66b2E
.Ltmp17:
	jmp	.LBB11_5
.LBB11_2:
.Ltmp15:
	movq	%rax, %rcx
	movl	%edx, %eax
	movq	%rcx, 8(%rsp)
	movl	%eax, 16(%rsp)
	jmp	.LBB11_1
.LBB11_3:
	movq	(%rsp), %rdi
	callq	_ZN4core3ptr53drop_in_place$LT$alloc..raw_vec..RawVec$LT$u8$GT$$GT$17h0a36b080d6ee66b2E
	addq	$24, %rsp
	.cfi_def_cfa_offset 8
	retq
.LBB11_4:
	.cfi_def_cfa_offset 32
.Ltmp18:
	movq	_ZN4core9panicking16panic_in_cleanup17hfa05ef7d5107e16aE@GOTPCREL(%rip), %rax
	callq	*%rax
.LBB11_5:
	movq	8(%rsp), %rdi
	callq	_Unwind_Resume@PLT
.Lfunc_end11:
	.size	_ZN4core3ptr46drop_in_place$LT$alloc..vec..Vec$LT$u8$GT$$GT$17hf89c47acad7d8bf6E, .Lfunc_end11-_ZN4core3ptr46drop_in_place$LT$alloc..vec..Vec$LT$u8$GT$$GT$17hf89c47acad7d8bf6E
	.cfi_endproc
	.section	".gcc_except_table._ZN4core3ptr46drop_in_place$LT$alloc..vec..Vec$LT$u8$GT$$GT$17hf89c47acad7d8bf6E","a",@progbits
	.p2align	2, 0x0
GCC_except_table11:
.Lexception3:
	.byte	255
	.byte	155
	.uleb128 .Lttbase2-.Lttbaseref2
.Lttbaseref2:
	.byte	1
	.uleb128 .Lcst_end3-.Lcst_begin3
.Lcst_begin3:
	.uleb128 .Ltmp13-.Lfunc_begin3
	.uleb128 .Ltmp14-.Ltmp13
	.uleb128 .Ltmp15-.Lfunc_begin3
	.byte	0
	.uleb128 .Ltmp16-.Lfunc_begin3
	.uleb128 .Ltmp17-.Ltmp16
	.uleb128 .Ltmp18-.Lfunc_begin3
	.byte	1
	.uleb128 .Ltmp17-.Lfunc_begin3
	.uleb128 .Lfunc_end11-.Ltmp17
	.byte	0
	.byte	0
.Lcst_end3:
	.byte	127
	.byte	0
	.p2align	2, 0x0
.Lttbase2:
	.byte	0
	.p2align	2, 0x0

	.section	".text._ZN4core3ptr53drop_in_place$LT$alloc..raw_vec..RawVec$LT$u8$GT$$GT$17h0a36b080d6ee66b2E","ax",@progbits
	.p2align	4, 0x90
	.type	_ZN4core3ptr53drop_in_place$LT$alloc..raw_vec..RawVec$LT$u8$GT$$GT$17h0a36b080d6ee66b2E,@function
_ZN4core3ptr53drop_in_place$LT$alloc..raw_vec..RawVec$LT$u8$GT$$GT$17h0a36b080d6ee66b2E:
	.cfi_startproc
	pushq	%rax
	.cfi_def_cfa_offset 16
	callq	_ZN77_$LT$alloc..raw_vec..RawVec$LT$T$C$A$GT$$u20$as$u20$core..ops..drop..Drop$GT$4drop17hde6ca8c435bdd240E
	popq	%rax
	.cfi_def_cfa_offset 8
	retq
.Lfunc_end12:
	.size	_ZN4core3ptr53drop_in_place$LT$alloc..raw_vec..RawVec$LT$u8$GT$$GT$17h0a36b080d6ee66b2E, .Lfunc_end12-_ZN4core3ptr53drop_in_place$LT$alloc..raw_vec..RawVec$LT$u8$GT$$GT$17h0a36b080d6ee66b2E
	.cfi_endproc

	.section	".text._ZN4core3ptr85drop_in_place$LT$std..rt..lang_start$LT$$LP$$RP$$GT$..$u7b$$u7b$closure$u7d$$u7d$$GT$17h1642b29495717f55E","ax",@progbits
	.p2align	4, 0x90
	.type	_ZN4core3ptr85drop_in_place$LT$std..rt..lang_start$LT$$LP$$RP$$GT$..$u7b$$u7b$closure$u7d$$u7d$$GT$17h1642b29495717f55E,@function
_ZN4core3ptr85drop_in_place$LT$std..rt..lang_start$LT$$LP$$RP$$GT$..$u7b$$u7b$closure$u7d$$u7d$$GT$17h1642b29495717f55E:
	.cfi_startproc
	retq
.Lfunc_end13:
	.size	_ZN4core3ptr85drop_in_place$LT$std..rt..lang_start$LT$$LP$$RP$$GT$..$u7b$$u7b$closure$u7d$$u7d$$GT$17h1642b29495717f55E, .Lfunc_end13-_ZN4core3ptr85drop_in_place$LT$std..rt..lang_start$LT$$LP$$RP$$GT$..$u7b$$u7b$closure$u7d$$u7d$$GT$17h1642b29495717f55E
	.cfi_endproc

	.section	".text._ZN4core3ptr8non_null16NonNull$LT$T$GT$13new_unchecked18precondition_check17he8e7b6b93737b106E","ax",@progbits
	.p2align	4, 0x90
	.type	_ZN4core3ptr8non_null16NonNull$LT$T$GT$13new_unchecked18precondition_check17he8e7b6b93737b106E,@function
_ZN4core3ptr8non_null16NonNull$LT$T$GT$13new_unchecked18precondition_check17he8e7b6b93737b106E:
	.cfi_startproc
	pushq	%rax
	.cfi_def_cfa_offset 16
	cmpq	$0, %rdi
	jne	.LBB14_2
	leaq	.L__unnamed_8(%rip), %rdi
	movq	_ZN4core9panicking14panic_nounwind17hb98133c151c787e4E@GOTPCREL(%rip), %rax
	movl	$93, %esi
	callq	*%rax
.LBB14_2:
	popq	%rax
	.cfi_def_cfa_offset 8
	retq
.Lfunc_end14:
	.size	_ZN4core3ptr8non_null16NonNull$LT$T$GT$13new_unchecked18precondition_check17he8e7b6b93737b106E, .Lfunc_end14-_ZN4core3ptr8non_null16NonNull$LT$T$GT$13new_unchecked18precondition_check17he8e7b6b93737b106E
	.cfi_endproc

	.section	.text._ZN4core5alloc6layout6Layout5array5inner17h37a4fa89a90a3940E,"ax",@progbits
	.p2align	4, 0x90
	.type	_ZN4core5alloc6layout6Layout5array5inner17h37a4fa89a90a3940E,@function
_ZN4core5alloc6layout6Layout5array5inner17h37a4fa89a90a3940E:
	.cfi_startproc
	subq	$72, %rsp
	.cfi_def_cfa_offset 80
	movq	%rdi, 16(%rsp)
	movq	%rsi, 24(%rsp)
	movq	%rdx, 32(%rsp)
	cmpq	$0, %rdi
	jne	.LBB15_2
.LBB15_1:
	jmp	.LBB15_7
.LBB15_2:
	movq	16(%rsp), %rax
	movq	24(%rsp), %rcx
	movq	%rcx, 56(%rsp)
	movq	56(%rsp), %rdx
	subq	$1, %rdx
	movabsq	$9223372036854775807, %rcx
	subq	%rdx, %rcx
	movq	%rcx, 8(%rsp)
	cmpq	$0, %rax
	je	.LBB15_4
	movq	16(%rsp), %rcx
	movq	8(%rsp), %rax
	xorl	%edx, %edx
	divq	%rcx
	movq	%rax, %rcx
	movq	32(%rsp), %rax
	cmpq	%rcx, %rax
	ja	.LBB15_6
	jmp	.LBB15_5
.LBB15_4:
	leaq	.L__unnamed_9(%rip), %rdi
	movq	_ZN4core9panicking11panic_const23panic_const_div_by_zero17h5e45bd48e3e1455dE@GOTPCREL(%rip), %rax
	callq	*%rax
.LBB15_5:
	jmp	.LBB15_1
.LBB15_6:
	movq	.L__unnamed_3(%rip), %rcx
	movq	.L__unnamed_3+8(%rip), %rax
	movq	%rcx, 40(%rsp)
	movq	%rax, 48(%rsp)
	jmp	.LBB15_9
.LBB15_7:
	movq	32(%rsp), %rsi
	movq	16(%rsp), %rdi
	callq	_ZN4core3num23_$LT$impl$u20$usize$GT$13unchecked_mul18precondition_check17hafab140d62053b64E
	movq	24(%rsp), %rcx
	movq	32(%rsp), %rdx
	movq	16(%rsp), %rax
	imulq	%rdx, %rax
	movq	%rcx, 64(%rsp)
	movq	64(%rsp), %rcx
	movq	%rcx, 40(%rsp)
	movq	%rax, 48(%rsp)
.LBB15_9:
	movq	40(%rsp), %rax
	movq	48(%rsp), %rdx
	addq	$72, %rsp
	.cfi_def_cfa_offset 8
	retq
.Lfunc_end15:
	.size	_ZN4core5alloc6layout6Layout5array5inner17h37a4fa89a90a3940E, .Lfunc_end15-_ZN4core5alloc6layout6Layout5array5inner17h37a4fa89a90a3940E
	.cfi_endproc

	.section	.text._ZN4core9ub_checks17is_nonoverlapping7runtime17h9f6df3659ea4d9c5E,"ax",@progbits
	.p2align	4, 0x90
	.type	_ZN4core9ub_checks17is_nonoverlapping7runtime17h9f6df3659ea4d9c5E,@function
_ZN4core9ub_checks17is_nonoverlapping7runtime17h9f6df3659ea4d9c5E:
	.cfi_startproc
	subq	$72, %rsp
	.cfi_def_cfa_offset 80
	movq	%rdx, %rax
	movq	%rdi, 16(%rsp)
	movq	%rsi, 24(%rsp)
	mulq	%rcx
	movq	%rax, 32(%rsp)
	seto	%al
	andb	$1, %al
	movb	%al, 71(%rsp)
	testb	$1, 71(%rsp)
	jne	.LBB16_2
	movq	16(%rsp), %rax
	movq	24(%rsp), %rcx
	movq	32(%rsp), %rdx
	movq	%rdx, 48(%rsp)
	movq	$1, 40(%rsp)
	movq	48(%rsp), %rdx
	movq	%rdx, 8(%rsp)
	cmpq	%rcx, %rax
	jb	.LBB16_4
	jmp	.LBB16_3
.LBB16_2:
	leaq	.L__unnamed_10(%rip), %rdi
	movq	_ZN4core9panicking14panic_nounwind17hb98133c151c787e4E@GOTPCREL(%rip), %rax
	movl	$61, %esi
	callq	*%rax
.LBB16_3:
	movq	24(%rsp), %rcx
	movq	16(%rsp), %rax
	subq	%rcx, %rax
	movq	%rax, 56(%rsp)
	jmp	.LBB16_5
.LBB16_4:
	movq	16(%rsp), %rcx
	movq	24(%rsp), %rax
	subq	%rcx, %rax
	movq	%rax, 56(%rsp)
.LBB16_5:
	movq	8(%rsp), %rax
	cmpq	%rax, 56(%rsp)
	setae	%al
	andb	$1, %al
	movzbl	%al, %eax
	addq	$72, %rsp
	.cfi_def_cfa_offset 8
	retq
.Lfunc_end16:
	.size	_ZN4core9ub_checks17is_nonoverlapping7runtime17h9f6df3659ea4d9c5E, .Lfunc_end16-_ZN4core9ub_checks17is_nonoverlapping7runtime17h9f6df3659ea4d9c5E
	.cfi_endproc

	.section	".text._ZN52_$LT$T$u20$as$u20$alloc..slice..hack..ConvertVec$GT$6to_vec17hef2c8970f140b69bE","ax",@progbits
	.p2align	4, 0x90
	.type	_ZN52_$LT$T$u20$as$u20$alloc..slice..hack..ConvertVec$GT$6to_vec17hef2c8970f140b69bE,@function
_ZN52_$LT$T$u20$as$u20$alloc..slice..hack..ConvertVec$GT$6to_vec17hef2c8970f140b69bE:
	.cfi_startproc
	subq	$88, %rsp
	.cfi_def_cfa_offset 96
	movq	%rdx, 8(%rsp)
	movq	%rsi, %rax
	movq	8(%rsp), %rsi
	movq	%rax, 16(%rsp)
	movq	%rdi, 24(%rsp)
	movq	%rdi, 32(%rsp)
	leaq	64(%rsp), %rdi
	xorl	%edx, %edx
	callq	_ZN5alloc7raw_vec19RawVec$LT$T$C$A$GT$15try_allocate_in17hc10a9f6b9492fe1eE
	cmpq	$0, 64(%rsp)
	jne	.LBB17_2
	movq	72(%rsp), %rcx
	movq	80(%rsp), %rax
	movq	%rcx, 40(%rsp)
	movq	%rax, 48(%rsp)
	movq	$0, 56(%rsp)
	movq	48(%rsp), %rax
	movq	%rax, (%rsp)
	jmp	.LBB17_3
.LBB17_2:
	movq	72(%rsp), %rdi
	movq	80(%rsp), %rsi
	movq	_ZN5alloc7raw_vec12handle_error17hc0e4a0ae60df49a1E@GOTPCREL(%rip), %rax
	callq	*%rax
.LBB17_3:
	movq	8(%rsp), %r8
	movq	(%rsp), %rsi
	movq	16(%rsp), %rdi
	movl	$1, %ecx
	movq	%rcx, %rdx
	callq	_ZN4core10intrinsics19copy_nonoverlapping18precondition_check17ha6b37f6b331c479fE
	movq	8(%rsp), %rdx
	movq	16(%rsp), %rsi
	movq	(%rsp), %rdi
	shlq	$0, %rdx
	callq	memcpy@PLT
	movq	8(%rsp), %rdx
	movq	24(%rsp), %rcx
	movq	32(%rsp), %rax
	movq	%rdx, 56(%rsp)
	movq	40(%rsp), %rdx
	movq	%rdx, (%rcx)
	movq	48(%rsp), %rdx
	movq	%rdx, 8(%rcx)
	movq	56(%rsp), %rdx
	movq	%rdx, 16(%rcx)
	addq	$88, %rsp
	.cfi_def_cfa_offset 8
	retq
.Lfunc_end17:
	.size	_ZN52_$LT$T$u20$as$u20$alloc..slice..hack..ConvertVec$GT$6to_vec17hef2c8970f140b69bE, .Lfunc_end17-_ZN52_$LT$T$u20$as$u20$alloc..slice..hack..ConvertVec$GT$6to_vec17hef2c8970f140b69bE
	.cfi_endproc

	.section	".text._ZN54_$LT$$LP$$RP$$u20$as$u20$std..process..Termination$GT$6report17h531bf418c26fc693E","ax",@progbits
	.p2align	4, 0x90
	.type	_ZN54_$LT$$LP$$RP$$u20$as$u20$std..process..Termination$GT$6report17h531bf418c26fc693E,@function
_ZN54_$LT$$LP$$RP$$u20$as$u20$std..process..Termination$GT$6report17h531bf418c26fc693E:
	.cfi_startproc
	xorl	%eax, %eax
	retq
.Lfunc_end18:
	.size	_ZN54_$LT$$LP$$RP$$u20$as$u20$std..process..Termination$GT$6report17h531bf418c26fc693E, .Lfunc_end18-_ZN54_$LT$$LP$$RP$$u20$as$u20$std..process..Termination$GT$6report17h531bf418c26fc693E
	.cfi_endproc

	.section	.text._ZN5alloc5alloc5alloc17h65b7ed0c18c9d469E,"ax",@progbits
	.p2align	4, 0x90
	.type	_ZN5alloc5alloc5alloc17h65b7ed0c18c9d469E,@function
_ZN5alloc5alloc5alloc17h65b7ed0c18c9d469E:
	.cfi_startproc
	subq	$40, %rsp
	.cfi_def_cfa_offset 48
	movq	%rdi, 8(%rsp)
	movq	%rsi, 16(%rsp)
	movq	__rust_no_alloc_shim_is_unstable@GOTPCREL(%rip), %rdi
	movl	$1, %esi
	callq	_ZN4core3ptr13read_volatile18precondition_check17h696761da07e38143E
	movq	__rust_no_alloc_shim_is_unstable@GOTPCREL(%rip), %rax
	movb	(%rax), %al
	movb	%al, 39(%rsp)
	movq	16(%rsp), %rdi
	movq	8(%rsp), %rax
	movq	%rax, 24(%rsp)
	movq	24(%rsp), %rsi
	callq	*__rust_alloc@GOTPCREL(%rip)
	addq	$40, %rsp
	.cfi_def_cfa_offset 8
	retq
.Lfunc_end19:
	.size	_ZN5alloc5alloc5alloc17h65b7ed0c18c9d469E, .Lfunc_end19-_ZN5alloc5alloc5alloc17h65b7ed0c18c9d469E
	.cfi_endproc

	.section	.text._ZN5alloc5alloc6Global10alloc_impl17h37bcd71c9b04c7d6E,"ax",@progbits
	.p2align	4, 0x90
	.type	_ZN5alloc5alloc6Global10alloc_impl17h37bcd71c9b04c7d6E,@function
_ZN5alloc5alloc6Global10alloc_impl17h37bcd71c9b04c7d6E:
	.cfi_startproc
	subq	$184, %rsp
	.cfi_def_cfa_offset 192
	movb	%cl, %al
	movb	%al, 39(%rsp)
	movq	%rsi, 48(%rsp)
	movq	%rdx, 56(%rsp)
	movq	56(%rsp), %rax
	movq	%rax, 40(%rsp)
	cmpq	$0, %rax
	jne	.LBB20_2
	movq	48(%rsp), %rax
	movq	%rax, 136(%rsp)
	movq	136(%rsp), %rcx
	xorl	%eax, %eax
	addq	%rcx, %rax
	movq	%rax, 24(%rsp)
	jmp	.LBB20_3
.LBB20_2:
	movb	39(%rsp), %al
	testb	$1, %al
	jne	.LBB20_8
	jmp	.LBB20_7
.LBB20_3:
	movq	24(%rsp), %rdi
	callq	_ZN4core3ptr8non_null16NonNull$LT$T$GT$13new_unchecked18precondition_check17he8e7b6b93737b106E
	movq	24(%rsp), %rax
	movq	%rax, 144(%rsp)
	movq	144(%rsp), %rcx
	movq	%rcx, 80(%rsp)
	movq	%rax, 168(%rsp)
	movq	%rax, 152(%rsp)
	movq	$0, 160(%rsp)
	movq	24(%rsp), %rdi
	callq	_ZN4core3ptr8non_null16NonNull$LT$T$GT$13new_unchecked18precondition_check17he8e7b6b93737b106E
	movq	152(%rsp), %rcx
	movq	160(%rsp), %rax
	movq	%rcx, 64(%rsp)
	movq	%rax, 72(%rsp)
.LBB20_6:
	movq	64(%rsp), %rax
	movq	72(%rsp), %rdx
	addq	$184, %rsp
	.cfi_def_cfa_offset 8
	retq
.LBB20_7:
	.cfi_def_cfa_offset 192
	movq	48(%rsp), %rdi
	movq	56(%rsp), %rsi
	callq	_ZN5alloc5alloc5alloc17h65b7ed0c18c9d469E
	movq	%rax, 88(%rsp)
	jmp	.LBB20_9
.LBB20_8:
	movq	40(%rsp), %rdi
	movq	48(%rsp), %rcx
	movq	56(%rsp), %rax
	movq	%rcx, 96(%rsp)
	movq	%rax, 104(%rsp)
	movq	48(%rsp), %rax
	movq	%rax, 176(%rsp)
	movq	176(%rsp), %rsi
	callq	*__rust_alloc_zeroed@GOTPCREL(%rip)
	movq	%rax, 88(%rsp)
.LBB20_9:
	movq	88(%rsp), %rax
	movq	%rax, 16(%rsp)
	cmpq	$0, %rax
	jne	.LBB20_11
	movq	$0, 128(%rsp)
	movq	$0, 120(%rsp)
	movq	.L__unnamed_3(%rip), %rcx
	movq	.L__unnamed_3+8(%rip), %rax
	movq	%rcx, 64(%rsp)
	movq	%rax, 72(%rsp)
	jmp	.LBB20_6
.LBB20_11:
	jmp	.LBB20_12
.LBB20_12:
	movq	16(%rsp), %rdi
	callq	_ZN4core3ptr8non_null16NonNull$LT$T$GT$13new_unchecked18precondition_check17he8e7b6b93737b106E
	movq	16(%rsp), %rax
	movq	%rax, 128(%rsp)
	movq	128(%rsp), %rax
	movq	%rax, 120(%rsp)
	movq	120(%rsp), %rax
	movq	%rax, 112(%rsp)
	movq	112(%rsp), %rax
	movq	%rax, 8(%rsp)
	movq	8(%rsp), %rdi
	callq	_ZN4core3ptr8non_null16NonNull$LT$T$GT$13new_unchecked18precondition_check17he8e7b6b93737b106E
	movq	40(%rsp), %rax
	movq	8(%rsp), %rcx
	movq	%rcx, 64(%rsp)
	movq	%rax, 72(%rsp)
	jmp	.LBB20_6
.Lfunc_end20:
	.size	_ZN5alloc5alloc6Global10alloc_impl17h37bcd71c9b04c7d6E, .Lfunc_end20-_ZN5alloc5alloc6Global10alloc_impl17h37bcd71c9b04c7d6E
	.cfi_endproc

	.section	".text._ZN5alloc7raw_vec19RawVec$LT$T$C$A$GT$14current_memory17h6dabe0159c8bd9f6E","ax",@progbits
	.p2align	4, 0x90
	.type	_ZN5alloc7raw_vec19RawVec$LT$T$C$A$GT$14current_memory17h6dabe0159c8bd9f6E,@function
_ZN5alloc7raw_vec19RawVec$LT$T$C$A$GT$14current_memory17h6dabe0159c8bd9f6E:
	.cfi_startproc
	subq	$56, %rsp
	.cfi_def_cfa_offset 64
	movq	%rsi, 8(%rsp)
	movq	%rdi, 16(%rsp)
	movq	%rdi, 24(%rsp)
	movq	8(%rsp), %rax
	cmpq	$0, (%rax)
	jne	.LBB21_3
	jmp	.LBB21_4
.LBB21_3:
	movq	8(%rsp), %rax
	movq	(%rax), %rax
	movq	%rax, (%rsp)
	jmp	.LBB21_5
.LBB21_4:
	movq	16(%rsp), %rax
	movq	$0, 8(%rax)
	jmp	.LBB21_7
.LBB21_5:
	movq	(%rsp), %rsi
	movl	$1, %edi
	callq	_ZN4core3num23_$LT$impl$u20$usize$GT$13unchecked_mul18precondition_check17hafab140d62053b64E
	movq	16(%rsp), %rax
	movq	8(%rsp), %rdx
	movq	(%rsp), %rcx
	shlq	$0, %rcx
	movq	8(%rdx), %rdx
	movq	%rdx, 32(%rsp)
	movq	$1, 40(%rsp)
	movq	%rcx, 48(%rsp)
	movq	32(%rsp), %rcx
	movq	%rcx, (%rax)
	movq	40(%rsp), %rcx
	movq	%rcx, 8(%rax)
	movq	48(%rsp), %rcx
	movq	%rcx, 16(%rax)
.LBB21_7:
	movq	24(%rsp), %rax
	addq	$56, %rsp
	.cfi_def_cfa_offset 8
	retq
.Lfunc_end21:
	.size	_ZN5alloc7raw_vec19RawVec$LT$T$C$A$GT$14current_memory17h6dabe0159c8bd9f6E, .Lfunc_end21-_ZN5alloc7raw_vec19RawVec$LT$T$C$A$GT$14current_memory17h6dabe0159c8bd9f6E
	.cfi_endproc

	.section	".text._ZN5alloc7raw_vec19RawVec$LT$T$C$A$GT$15try_allocate_in17hc10a9f6b9492fe1eE","ax",@progbits
	.p2align	4, 0x90
	.type	_ZN5alloc7raw_vec19RawVec$LT$T$C$A$GT$15try_allocate_in17hc10a9f6b9492fe1eE,@function
_ZN5alloc7raw_vec19RawVec$LT$T$C$A$GT$15try_allocate_in17hc10a9f6b9492fe1eE:
.Lfunc_begin4:
	.cfi_startproc
	.cfi_personality 155, DW.ref.rust_eh_personality
	.cfi_lsda 27, .Lexception4
	subq	$184, %rsp
	.cfi_def_cfa_offset 192
	movq	%rsi, 72(%rsp)
	movq	%rdi, 80(%rsp)
	movb	%dl, %al
	movq	%rdi, 88(%rsp)
	andb	$1, %al
	movb	%al, 102(%rsp)
	movq	72(%rsp), %rax
	cmpq	$0, %rax
	jne	.LBB22_3
	jmp	.LBB22_19
.LBB22_3:
.Ltmp19:
	movq	72(%rsp), %rdx
	movl	$1, %esi
	movq	%rsi, %rdi
	callq	_ZN4core5alloc6layout6Layout5array5inner17h37a4fa89a90a3940E
.Ltmp20:
	movq	%rdx, 56(%rsp)
	movq	%rax, 64(%rsp)
	jmp	.LBB22_6
.LBB22_4:
	movq	168(%rsp), %rdi
	callq	_Unwind_Resume@PLT
.LBB22_5:
.Ltmp25:
	movq	%rax, %rcx
	movl	%edx, %eax
	movq	%rcx, 168(%rsp)
	movl	%eax, 176(%rsp)
	jmp	.LBB22_4
.LBB22_6:
	movq	56(%rsp), %rax
	movq	64(%rsp), %rcx
	movq	%rcx, 120(%rsp)
	movq	%rax, 128(%rsp)
	xorl	%eax, %eax
	movl	$1, %ecx
	cmpq	$0, 120(%rsp)
	cmoveq	%rcx, %rax
	cmpq	$0, %rax
	jne	.LBB22_8
	movq	120(%rsp), %rcx
	movq	%rcx, 40(%rsp)
	movq	128(%rsp), %rax
	movq	%rax, 48(%rsp)
	movq	%rcx, 104(%rsp)
	movq	%rax, 112(%rsp)
	movb	102(%rsp), %al
	andb	$1, %al
	movzbl	%al, %eax
	cmpq	$0, %rax
	je	.LBB22_9
	jmp	.LBB22_10
.LBB22_8:
	movq	80(%rsp), %rax
	movq	.L__unnamed_3(%rip), %rdx
	movq	.L__unnamed_3+8(%rip), %rcx
	movq	%rdx, 8(%rax)
	movq	%rcx, 16(%rax)
	movq	$1, (%rax)
	jmp	.LBB22_17
.LBB22_9:
.Ltmp23:
	movq	48(%rsp), %rdx
	movq	40(%rsp), %rsi
	leaq	103(%rsp), %rdi
	callq	_ZN63_$LT$alloc..alloc..Global$u20$as$u20$core..alloc..Allocator$GT$8allocate17h47d5bd8055322423E
.Ltmp24:
	movq	%rdx, 24(%rsp)
	movq	%rax, 32(%rsp)
	jmp	.LBB22_11
.LBB22_10:
.Ltmp21:
	movq	48(%rsp), %rdx
	movq	40(%rsp), %rsi
	leaq	103(%rsp), %rdi
	callq	_ZN63_$LT$alloc..alloc..Global$u20$as$u20$core..alloc..Allocator$GT$15allocate_zeroed17h533af29752e1838aE
.Ltmp22:
	movq	%rdx, 8(%rsp)
	movq	%rax, 16(%rsp)
	jmp	.LBB22_13
.LBB22_11:
	movq	24(%rsp), %rax
	movq	32(%rsp), %rcx
	movq	%rcx, 136(%rsp)
	movq	%rax, 144(%rsp)
.LBB22_12:
	movq	136(%rsp), %rdx
	xorl	%eax, %eax
	movl	$1, %ecx
	cmpq	$0, %rdx
	cmoveq	%rcx, %rax
	cmpq	$0, %rax
	je	.LBB22_14
	jmp	.LBB22_15
.LBB22_13:
	movq	8(%rsp), %rax
	movq	16(%rsp), %rcx
	movq	%rcx, 136(%rsp)
	movq	%rax, 144(%rsp)
	jmp	.LBB22_12
.LBB22_14:
	movq	80(%rsp), %rax
	movq	72(%rsp), %rdx
	movq	136(%rsp), %rcx
	movq	%rdx, 8(%rax)
	movq	%rcx, 16(%rax)
	movq	$0, (%rax)
	jmp	.LBB22_16
.LBB22_15:
	movq	80(%rsp), %rax
	movq	48(%rsp), %rcx
	movq	40(%rsp), %rdx
	movq	%rdx, 152(%rsp)
	movq	%rcx, 160(%rsp)
	movq	152(%rsp), %rdx
	movq	160(%rsp), %rcx
	movq	%rdx, 8(%rax)
	movq	%rcx, 16(%rax)
	movq	$1, (%rax)
	jmp	.LBB22_17
.LBB22_16:
	jmp	.LBB22_18
.LBB22_17:
	jmp	.LBB22_18
.LBB22_18:
	movq	88(%rsp), %rax
	addq	$184, %rsp
	.cfi_def_cfa_offset 8
	retq
.LBB22_19:
	.cfi_def_cfa_offset 192
	xorl	%eax, %eax
	movl	%eax, %edi
	addq	$1, %rdi
	callq	_ZN4core3ptr8non_null16NonNull$LT$T$GT$13new_unchecked18precondition_check17he8e7b6b93737b106E
	movq	80(%rsp), %rax
	movq	$0, 8(%rax)
	xorl	%ecx, %ecx
	addq	$1, %rcx
	movq	%rcx, 16(%rax)
	movq	$0, (%rax)
	jmp	.LBB22_16
.Lfunc_end22:
	.size	_ZN5alloc7raw_vec19RawVec$LT$T$C$A$GT$15try_allocate_in17hc10a9f6b9492fe1eE, .Lfunc_end22-_ZN5alloc7raw_vec19RawVec$LT$T$C$A$GT$15try_allocate_in17hc10a9f6b9492fe1eE
	.cfi_endproc
	.section	".gcc_except_table._ZN5alloc7raw_vec19RawVec$LT$T$C$A$GT$15try_allocate_in17hc10a9f6b9492fe1eE","a",@progbits
	.p2align	2, 0x0
GCC_except_table22:
.Lexception4:
	.byte	255
	.byte	255
	.byte	1
	.uleb128 .Lcst_end4-.Lcst_begin4
.Lcst_begin4:
	.uleb128 .Ltmp19-.Lfunc_begin4
	.uleb128 .Ltmp20-.Ltmp19
	.uleb128 .Ltmp25-.Lfunc_begin4
	.byte	0
	.uleb128 .Ltmp20-.Lfunc_begin4
	.uleb128 .Ltmp23-.Ltmp20
	.byte	0
	.byte	0
	.uleb128 .Ltmp23-.Lfunc_begin4
	.uleb128 .Ltmp22-.Ltmp23
	.uleb128 .Ltmp25-.Lfunc_begin4
	.byte	0
.Lcst_end4:
	.p2align	2, 0x0

	.section	".text._ZN63_$LT$alloc..alloc..Global$u20$as$u20$core..alloc..Allocator$GT$10deallocate17hecf450a2d906ffa5E","ax",@progbits
	.p2align	4, 0x90
	.type	_ZN63_$LT$alloc..alloc..Global$u20$as$u20$core..alloc..Allocator$GT$10deallocate17hecf450a2d906ffa5E,@function
_ZN63_$LT$alloc..alloc..Global$u20$as$u20$core..alloc..Allocator$GT$10deallocate17hecf450a2d906ffa5E:
	.cfi_startproc
	subq	$56, %rsp
	.cfi_def_cfa_offset 64
	movq	%rsi, (%rsp)
	movq	%rdx, 16(%rsp)
	movq	%rcx, 24(%rsp)
	movq	24(%rsp), %rax
	movq	%rax, 8(%rsp)
	cmpq	$0, %rax
	jne	.LBB23_2
.LBB23_1:
	addq	$56, %rsp
	.cfi_def_cfa_offset 8
	retq
.LBB23_2:
	.cfi_def_cfa_offset 64
	movq	8(%rsp), %rsi
	movq	(%rsp), %rdi
	movq	16(%rsp), %rcx
	movq	24(%rsp), %rax
	movq	%rcx, 32(%rsp)
	movq	%rax, 40(%rsp)
	movq	16(%rsp), %rax
	movq	%rax, 48(%rsp)
	movq	48(%rsp), %rdx
	callq	*__rust_dealloc@GOTPCREL(%rip)
	jmp	.LBB23_1
.Lfunc_end23:
	.size	_ZN63_$LT$alloc..alloc..Global$u20$as$u20$core..alloc..Allocator$GT$10deallocate17hecf450a2d906ffa5E, .Lfunc_end23-_ZN63_$LT$alloc..alloc..Global$u20$as$u20$core..alloc..Allocator$GT$10deallocate17hecf450a2d906ffa5E
	.cfi_endproc

	.section	".text._ZN63_$LT$alloc..alloc..Global$u20$as$u20$core..alloc..Allocator$GT$15allocate_zeroed17h533af29752e1838aE","ax",@progbits
	.p2align	4, 0x90
	.type	_ZN63_$LT$alloc..alloc..Global$u20$as$u20$core..alloc..Allocator$GT$15allocate_zeroed17h533af29752e1838aE,@function
_ZN63_$LT$alloc..alloc..Global$u20$as$u20$core..alloc..Allocator$GT$15allocate_zeroed17h533af29752e1838aE:
	.cfi_startproc
	pushq	%rax
	.cfi_def_cfa_offset 16
	movl	$1, %ecx
	callq	_ZN5alloc5alloc6Global10alloc_impl17h37bcd71c9b04c7d6E
	popq	%rcx
	.cfi_def_cfa_offset 8
	retq
.Lfunc_end24:
	.size	_ZN63_$LT$alloc..alloc..Global$u20$as$u20$core..alloc..Allocator$GT$15allocate_zeroed17h533af29752e1838aE, .Lfunc_end24-_ZN63_$LT$alloc..alloc..Global$u20$as$u20$core..alloc..Allocator$GT$15allocate_zeroed17h533af29752e1838aE
	.cfi_endproc

	.section	".text._ZN63_$LT$alloc..alloc..Global$u20$as$u20$core..alloc..Allocator$GT$8allocate17h47d5bd8055322423E","ax",@progbits
	.p2align	4, 0x90
	.type	_ZN63_$LT$alloc..alloc..Global$u20$as$u20$core..alloc..Allocator$GT$8allocate17h47d5bd8055322423E,@function
_ZN63_$LT$alloc..alloc..Global$u20$as$u20$core..alloc..Allocator$GT$8allocate17h47d5bd8055322423E:
	.cfi_startproc
	pushq	%rax
	.cfi_def_cfa_offset 16
	xorl	%ecx, %ecx
	callq	_ZN5alloc5alloc6Global10alloc_impl17h37bcd71c9b04c7d6E
	popq	%rcx
	.cfi_def_cfa_offset 8
	retq
.Lfunc_end25:
	.size	_ZN63_$LT$alloc..alloc..Global$u20$as$u20$core..alloc..Allocator$GT$8allocate17h47d5bd8055322423E, .Lfunc_end25-_ZN63_$LT$alloc..alloc..Global$u20$as$u20$core..alloc..Allocator$GT$8allocate17h47d5bd8055322423E
	.cfi_endproc

	.section	".text._ZN70_$LT$alloc..vec..Vec$LT$T$C$A$GT$$u20$as$u20$core..ops..drop..Drop$GT$4drop17h021f2c47474d366eE","ax",@progbits
	.p2align	4, 0x90
	.type	_ZN70_$LT$alloc..vec..Vec$LT$T$C$A$GT$$u20$as$u20$core..ops..drop..Drop$GT$4drop17h021f2c47474d366eE,@function
_ZN70_$LT$alloc..vec..Vec$LT$T$C$A$GT$$u20$as$u20$core..ops..drop..Drop$GT$4drop17h021f2c47474d366eE:
	.cfi_startproc
	retq
.Lfunc_end26:
	.size	_ZN70_$LT$alloc..vec..Vec$LT$T$C$A$GT$$u20$as$u20$core..ops..drop..Drop$GT$4drop17h021f2c47474d366eE, .Lfunc_end26-_ZN70_$LT$alloc..vec..Vec$LT$T$C$A$GT$$u20$as$u20$core..ops..drop..Drop$GT$4drop17h021f2c47474d366eE
	.cfi_endproc

	.section	".text._ZN76_$LT$alloc..string..String$u20$as$u20$core..convert..From$LT$$RF$str$GT$$GT$4from17h5b0bfb4264225136E","ax",@progbits
	.p2align	4, 0x90
	.type	_ZN76_$LT$alloc..string..String$u20$as$u20$core..convert..From$LT$$RF$str$GT$$GT$4from17h5b0bfb4264225136E,@function
_ZN76_$LT$alloc..string..String$u20$as$u20$core..convert..From$LT$$RF$str$GT$$GT$4from17h5b0bfb4264225136E:
	.cfi_startproc
	subq	$40, %rsp
	.cfi_def_cfa_offset 48
	movq	%rdi, (%rsp)
	movq	%rdi, 8(%rsp)
	leaq	16(%rsp), %rdi
	callq	_ZN52_$LT$T$u20$as$u20$alloc..slice..hack..ConvertVec$GT$6to_vec17hef2c8970f140b69bE
	movq	(%rsp), %rdi
	movq	8(%rsp), %rax
	movq	16(%rsp), %rcx
	movq	%rcx, (%rdi)
	movq	24(%rsp), %rcx
	movq	%rcx, 8(%rdi)
	movq	32(%rsp), %rcx
	movq	%rcx, 16(%rdi)
	addq	$40, %rsp
	.cfi_def_cfa_offset 8
	retq
.Lfunc_end27:
	.size	_ZN76_$LT$alloc..string..String$u20$as$u20$core..convert..From$LT$$RF$str$GT$$GT$4from17h5b0bfb4264225136E, .Lfunc_end27-_ZN76_$LT$alloc..string..String$u20$as$u20$core..convert..From$LT$$RF$str$GT$$GT$4from17h5b0bfb4264225136E
	.cfi_endproc

	.section	".text._ZN77_$LT$alloc..raw_vec..RawVec$LT$T$C$A$GT$$u20$as$u20$core..ops..drop..Drop$GT$4drop17hde6ca8c435bdd240E","ax",@progbits
	.p2align	4, 0x90
	.type	_ZN77_$LT$alloc..raw_vec..RawVec$LT$T$C$A$GT$$u20$as$u20$core..ops..drop..Drop$GT$4drop17hde6ca8c435bdd240E,@function
_ZN77_$LT$alloc..raw_vec..RawVec$LT$T$C$A$GT$$u20$as$u20$core..ops..drop..Drop$GT$4drop17hde6ca8c435bdd240E:
	.cfi_startproc
	subq	$40, %rsp
	.cfi_def_cfa_offset 48
	movq	%rdi, %rsi
	movq	%rsi, 8(%rsp)
	leaq	16(%rsp), %rdi
	callq	_ZN5alloc7raw_vec19RawVec$LT$T$C$A$GT$14current_memory17h6dabe0159c8bd9f6E
	movl	$1, %eax
	xorl	%ecx, %ecx
	cmpq	$0, 24(%rsp)
	cmoveq	%rcx, %rax
	cmpq	$1, %rax
	jne	.LBB28_2
	movq	8(%rsp), %rdi
	movq	16(%rsp), %rsi
	movq	24(%rsp), %rdx
	movq	32(%rsp), %rcx
	addq	$16, %rdi
	callq	_ZN63_$LT$alloc..alloc..Global$u20$as$u20$core..alloc..Allocator$GT$10deallocate17hecf450a2d906ffa5E
.LBB28_2:
	addq	$40, %rsp
	.cfi_def_cfa_offset 8
	retq
.Lfunc_end28:
	.size	_ZN77_$LT$alloc..raw_vec..RawVec$LT$T$C$A$GT$$u20$as$u20$core..ops..drop..Drop$GT$4drop17hde6ca8c435bdd240E, .Lfunc_end28-_ZN77_$LT$alloc..raw_vec..RawVec$LT$T$C$A$GT$$u20$as$u20$core..ops..drop..Drop$GT$4drop17hde6ca8c435bdd240E
	.cfi_endproc

	.section	.text._ZN4test10add_string17h250c55ad04f1b8c6E,"ax",@progbits
	.p2align	4, 0x90
	.type	_ZN4test10add_string17h250c55ad04f1b8c6E,@function
_ZN4test10add_string17h250c55ad04f1b8c6E:
	.cfi_startproc
	subq	$24, %rsp
	.cfi_def_cfa_offset 32
	movq	%rsi, 8(%rsp)
	movq	%rdi, %rax
	movq	8(%rsp), %rdi
	movq	%rax, %rcx
	movq	%rcx, 16(%rsp)
	movq	(%rdx), %rcx
	movq	%rcx, (%rax)
	movq	8(%rdx), %rcx
	movq	%rcx, 8(%rax)
	movq	16(%rdx), %rcx
	movq	%rcx, 16(%rax)
	callq	_ZN4core3ptr42drop_in_place$LT$alloc..string..String$GT$17h936e75eee6fe0e7eE
	movq	16(%rsp), %rax
	addq	$24, %rsp
	.cfi_def_cfa_offset 8
	retq
.Lfunc_end29:
	.size	_ZN4test10add_string17h250c55ad04f1b8c6E, .Lfunc_end29-_ZN4test10add_string17h250c55ad04f1b8c6E
	.cfi_endproc

	.section	.text._ZN4test4main17h6bcb51c607001b0aE,"ax",@progbits
	.p2align	4, 0x90
	.type	_ZN4test4main17h6bcb51c607001b0aE,@function
_ZN4test4main17h6bcb51c607001b0aE:
.Lfunc_begin5:
	.cfi_startproc
	.cfi_personality 155, DW.ref.rust_eh_personality
	.cfi_lsda 27, .Lexception5
	subq	$136, %rsp
	.cfi_def_cfa_offset 144
	movb	$0, 119(%rsp)
	movb	$1, 119(%rsp)
	leaq	.L__unnamed_11(%rip), %rsi
	leaq	8(%rsp), %rdi
	movl	$5, %edx
	movq	%rdx, (%rsp)
	callq	_ZN76_$LT$alloc..string..String$u20$as$u20$core..convert..From$LT$$RF$str$GT$$GT$4from17h5b0bfb4264225136E
	movq	(%rsp), %rdx
.Ltmp26:
	leaq	.L__unnamed_12(%rip), %rsi
	leaq	32(%rsp), %rdi
	callq	_ZN76_$LT$alloc..string..String$u20$as$u20$core..convert..From$LT$$RF$str$GT$$GT$4from17h5b0bfb4264225136E
.Ltmp27:
	jmp	.LBB30_3
.LBB30_1:
	testb	$1, 119(%rsp)
	jne	.LBB30_7
	jmp	.LBB30_6
.LBB30_2:
.Ltmp32:
	movq	%rax, %rcx
	movl	%edx, %eax
	movq	%rcx, 120(%rsp)
	movl	%eax, 128(%rsp)
	jmp	.LBB30_1
.LBB30_3:
	movb	$0, 119(%rsp)
	movq	24(%rsp), %rax
	movq	%rax, 96(%rsp)
	movups	8(%rsp), %xmm0
	movaps	%xmm0, 80(%rsp)
.Ltmp28:
	leaq	56(%rsp), %rdi
	leaq	80(%rsp), %rsi
	leaq	32(%rsp), %rdx
	callq	_ZN4test10add_string17h250c55ad04f1b8c6E
.Ltmp29:
	jmp	.LBB30_4
.LBB30_4:
.Ltmp30:
	leaq	56(%rsp), %rdi
	callq	_ZN4core3ptr42drop_in_place$LT$alloc..string..String$GT$17h936e75eee6fe0e7eE
.Ltmp31:
	jmp	.LBB30_5
.LBB30_5:
	movb	$0, 119(%rsp)
	addq	$136, %rsp
	.cfi_def_cfa_offset 8
	retq
.LBB30_6:
	.cfi_def_cfa_offset 144
	movq	120(%rsp), %rdi
	callq	_Unwind_Resume@PLT
.LBB30_7:
.Ltmp33:
	leaq	8(%rsp), %rdi
	callq	_ZN4core3ptr42drop_in_place$LT$alloc..string..String$GT$17h936e75eee6fe0e7eE
.Ltmp34:
	jmp	.LBB30_6
.LBB30_8:
.Ltmp35:
	movq	_ZN4core9panicking16panic_in_cleanup17hfa05ef7d5107e16aE@GOTPCREL(%rip), %rax
	callq	*%rax
.Lfunc_end30:
	.size	_ZN4test4main17h6bcb51c607001b0aE, .Lfunc_end30-_ZN4test4main17h6bcb51c607001b0aE
	.cfi_endproc
	.section	.gcc_except_table._ZN4test4main17h6bcb51c607001b0aE,"a",@progbits
	.p2align	2, 0x0
GCC_except_table30:
.Lexception5:
	.byte	255
	.byte	155
	.uleb128 .Lttbase3-.Lttbaseref3
.Lttbaseref3:
	.byte	1
	.uleb128 .Lcst_end5-.Lcst_begin5
.Lcst_begin5:
	.uleb128 .Lfunc_begin5-.Lfunc_begin5
	.uleb128 .Ltmp26-.Lfunc_begin5
	.byte	0
	.byte	0
	.uleb128 .Ltmp26-.Lfunc_begin5
	.uleb128 .Ltmp31-.Ltmp26
	.uleb128 .Ltmp32-.Lfunc_begin5
	.byte	0
	.uleb128 .Ltmp31-.Lfunc_begin5
	.uleb128 .Ltmp33-.Ltmp31
	.byte	0
	.byte	0
	.uleb128 .Ltmp33-.Lfunc_begin5
	.uleb128 .Ltmp34-.Ltmp33
	.uleb128 .Ltmp35-.Lfunc_begin5
	.byte	1
	.uleb128 .Ltmp34-.Lfunc_begin5
	.uleb128 .Lfunc_end30-.Ltmp34
	.byte	0
	.byte	0
.Lcst_end5:
	.byte	127
	.byte	0
	.p2align	2, 0x0
.Lttbase3:
	.byte	0
	.p2align	2, 0x0

	.section	.text.main,"ax",@progbits
	.globl	main
	.p2align	4, 0x90
	.type	main,@function
main:
	.cfi_startproc
	pushq	%rax
	.cfi_def_cfa_offset 16
	movq	%rsi, %rdx
	movslq	%edi, %rsi
	leaq	_ZN4test4main17h6bcb51c607001b0aE(%rip), %rdi
	xorl	%ecx, %ecx
	callq	_ZN3std2rt10lang_start17h82442523f03a3fd7E
	popq	%rcx
	.cfi_def_cfa_offset 8
	retq
.Lfunc_end31:
	.size	main, .Lfunc_end31-main
	.cfi_endproc

	.type	.L__unnamed_1,@object
	.section	.data.rel.ro..L__unnamed_1,"aw",@progbits
	.p2align	3, 0x0
.L__unnamed_1:
	.asciz	"\000\000\000\000\000\000\000\000\b\000\000\000\000\000\000\000\b\000\000\000\000\000\000"
	.quad	_ZN4core3ops8function6FnOnce40call_once$u7b$$u7b$vtable.shim$u7d$$u7d$17h26481ca4a7938697E
	.quad	_ZN3std2rt10lang_start28_$u7b$$u7b$closure$u7d$$u7d$17h69511e68c1840078E
	.quad	_ZN3std2rt10lang_start28_$u7b$$u7b$closure$u7d$$u7d$17h69511e68c1840078E
	.size	.L__unnamed_1, 48

	.type	.L__unnamed_5,@object
	.section	.rodata..L__unnamed_5,"a",@progbits
.L__unnamed_5:
	.ascii	"unsafe precondition(s) violated: ptr::copy_nonoverlapping requires that both pointer arguments are aligned and non-null and the specified memory ranges do not overlap"
	.size	.L__unnamed_5, 166

	.type	.L__unnamed_13,@object
	.section	.rodata..L__unnamed_13,"a",@progbits
.L__unnamed_13:
	.ascii	"is_aligned_to: align is not a power-of-two"
	.size	.L__unnamed_13, 42

	.type	.L__unnamed_2,@object
	.section	.data.rel.ro..L__unnamed_2,"aw",@progbits
	.p2align	3, 0x0
.L__unnamed_2:
	.quad	.L__unnamed_13
	.asciz	"*\000\000\000\000\000\000"
	.size	.L__unnamed_2, 16

	.type	.L__unnamed_3,@object
	.section	.rodata.cst16,"aM",@progbits,16
	.p2align	3, 0x0
.L__unnamed_3:
	.zero	8
	.zero	8
	.size	.L__unnamed_3, 16

	.type	.L__unnamed_14,@object
	.section	.rodata..L__unnamed_14,"a",@progbits
.L__unnamed_14:
	.ascii	"/rustc/eeb90cda1969383f56a2637cbd3037bdf598841c/library/core/src/ptr/const_ptr.rs"
	.size	.L__unnamed_14, 81

	.type	.L__unnamed_4,@object
	.section	.data.rel.ro..L__unnamed_4,"aw",@progbits
	.p2align	3, 0x0
.L__unnamed_4:
	.quad	.L__unnamed_14
	.asciz	"Q\000\000\000\000\000\000\000\031\006\000\000\r\000\000"
	.size	.L__unnamed_4, 24

	.type	.L__unnamed_6,@object
	.section	.rodata..L__unnamed_6,"a",@progbits
.L__unnamed_6:
	.ascii	"unsafe precondition(s) violated: usize::unchecked_mul cannot overflow"
	.size	.L__unnamed_6, 69

	.type	.L__unnamed_7,@object
	.section	.rodata..L__unnamed_7,"a",@progbits
.L__unnamed_7:
	.ascii	"unsafe precondition(s) violated: ptr::read_volatile requires that the pointer argument is aligned and non-null"
	.size	.L__unnamed_7, 110

	.type	.L__unnamed_8,@object
	.section	.rodata..L__unnamed_8,"a",@progbits
.L__unnamed_8:
	.ascii	"unsafe precondition(s) violated: NonNull::new_unchecked requires that the pointer is non-null"
	.size	.L__unnamed_8, 93

	.type	.L__unnamed_15,@object
	.section	.rodata..L__unnamed_15,"a",@progbits
.L__unnamed_15:
	.ascii	"/rustc/eeb90cda1969383f56a2637cbd3037bdf598841c/library/core/src/alloc/layout.rs"
	.size	.L__unnamed_15, 80

	.type	.L__unnamed_9,@object
	.section	.data.rel.ro..L__unnamed_9,"aw",@progbits
	.p2align	3, 0x0
.L__unnamed_9:
	.quad	.L__unnamed_15
	.asciz	"P\000\000\000\000\000\000\000\303\001\000\000)\000\000"
	.size	.L__unnamed_9, 24

	.type	.L__unnamed_10,@object
	.section	.rodata..L__unnamed_10,"a",@progbits
.L__unnamed_10:
	.ascii	"is_nonoverlapping: `size_of::<T>() * count` overflows a usize"
	.size	.L__unnamed_10, 61

	.type	.L__unnamed_11,@object
	.section	.rodata..L__unnamed_11,"a",@progbits
.L__unnamed_11:
	.ascii	"hello"
	.size	.L__unnamed_11, 5

	.type	.L__unnamed_12,@object
	.section	.rodata..L__unnamed_12,"a",@progbits
.L__unnamed_12:
	.ascii	"world"
	.size	.L__unnamed_12, 5

	.hidden	DW.ref.rust_eh_personality
	.weak	DW.ref.rust_eh_personality
	.section	.data.DW.ref.rust_eh_personality,"awG",@progbits,DW.ref.rust_eh_personality,comdat
	.p2align	3, 0x0
	.type	DW.ref.rust_eh_personality,@object
	.size	DW.ref.rust_eh_personality, 8
DW.ref.rust_eh_personality:
	.quad	rust_eh_personality
	.ident	"rustc version 1.81.0 (eeb90cda1 2024-09-04)"
	.section	".note.GNU-stack","",@progbits
