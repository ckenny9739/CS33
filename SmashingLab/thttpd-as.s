	.file	"thttpd.c"
	.bss
	.align 32
	.type	argv0, @object
	.size	argv0, 4
argv0:
	.zero	64
	.align 32
	.type	debug, @object
	.size	debug, 4
debug:
	.zero	64
	.align 32
	.type	port, @object
	.size	port, 2
port:
	.zero	64
	.align 32
	.type	dir, @object
	.size	dir, 4
dir:
	.zero	64
	.align 32
	.type	data_dir, @object
	.size	data_dir, 4
data_dir:
	.zero	64
	.align 32
	.type	do_chroot, @object
	.size	do_chroot, 4
do_chroot:
	.zero	64
	.align 32
	.type	no_log, @object
	.size	no_log, 4
no_log:
	.zero	64
	.align 32
	.type	no_symlink_check, @object
	.size	no_symlink_check, 4
no_symlink_check:
	.zero	64
	.align 32
	.type	do_vhost, @object
	.size	do_vhost, 4
do_vhost:
	.zero	64
	.align 32
	.type	do_global_passwd, @object
	.size	do_global_passwd, 4
do_global_passwd:
	.zero	64
	.align 32
	.type	cgi_pattern, @object
	.size	cgi_pattern, 4
cgi_pattern:
	.zero	64
	.align 32
	.type	cgi_limit, @object
	.size	cgi_limit, 4
cgi_limit:
	.zero	64
	.align 32
	.type	url_pattern, @object
	.size	url_pattern, 4
url_pattern:
	.zero	64
	.align 32
	.type	no_empty_referers, @object
	.size	no_empty_referers, 4
no_empty_referers:
	.zero	64
	.align 32
	.type	local_pattern, @object
	.size	local_pattern, 4
local_pattern:
	.zero	64
	.align 32
	.type	logfile, @object
	.size	logfile, 4
logfile:
	.zero	64
	.align 32
	.type	throttlefile, @object
	.size	throttlefile, 4
throttlefile:
	.zero	64
	.align 32
	.type	hostname, @object
	.size	hostname, 4
hostname:
	.zero	64
	.align 32
	.type	pidfile, @object
	.size	pidfile, 4
pidfile:
	.zero	64
	.align 32
	.type	user, @object
	.size	user, 4
user:
	.zero	64
	.align 32
	.type	charset, @object
	.size	charset, 4
charset:
	.zero	64
	.align 32
	.type	p3p, @object
	.size	p3p, 4
p3p:
	.zero	64
	.align 32
	.type	max_age, @object
	.size	max_age, 4
max_age:
	.zero	64
	.align 32
	.type	throttles, @object
	.size	throttles, 4
throttles:
	.zero	64
	.align 32
	.type	numthrottles, @object
	.size	numthrottles, 4
numthrottles:
	.zero	64
	.align 32
	.type	maxthrottles, @object
	.size	maxthrottles, 4
maxthrottles:
	.zero	64
	.align 32
	.type	connects, @object
	.size	connects, 4
connects:
	.zero	64
	.align 32
	.type	num_connects, @object
	.size	num_connects, 4
num_connects:
	.zero	64
	.align 32
	.type	max_connects, @object
	.size	max_connects, 4
max_connects:
	.zero	64
	.align 32
	.type	first_free_connect, @object
	.size	first_free_connect, 4
first_free_connect:
	.zero	64
	.align 32
	.type	httpd_conn_count, @object
	.size	httpd_conn_count, 4
httpd_conn_count:
	.zero	64
	.align 32
	.type	hs, @object
	.size	hs, 4
hs:
	.zero	64
	.globl	terminate
	.align 32
	.type	terminate, @object
	.size	terminate, 4
terminate:
	.zero	64
	.comm	start_time,4,4
	.comm	stats_time,4,4
	.comm	stats_connections,4,4
	.comm	stats_bytes,4,4
	.comm	stats_simultaneous,4,4
	.align 32
	.type	got_hup, @object
	.size	got_hup, 4
got_hup:
	.zero	64
	.align 32
	.type	got_usr1, @object
	.size	got_usr1, 4
got_usr1:
	.zero	64
	.align 32
	.type	watchdog_flag, @object
	.size	watchdog_flag, 4
watchdog_flag:
	.zero	64
	.section	.rodata
	.align 32
.LC0:
	.string	"exiting due to signal %d"
	.zero	39
	.text
	.type	handle_term, @function
handle_term:
.LASANPC0:
	pushl	%ebp
	movl	%esp, %ebp
	subl	$8, %esp
	call	shut_down
	subl	$4, %esp
	pushl	8(%ebp)
	pushl	$.LC0
	pushl	$5
	call	syslog
	addl	$16, %esp
	call	closelog
	call	__asan_handle_no_return
	subl	$12, %esp
	pushl	$1
	call	exit
	.size	handle_term, .-handle_term
	.globl	__asan_stack_malloc_1
	.section	.rodata
.LC1:
	.string	"1 32 4 6 status "
	.align 32
.LC2:
	.string	"child wait - %m"
	.zero	48
	.text
	.type	handle_chld, @function
handle_chld:
.LASANPC1:
	pushl	%ebp
	movl	%esp, %ebp
	pushl	%edi
	pushl	%esi
	pushl	%ebx
	subl	$140, %esp
	leal	-120(%ebp), %eax
	movl	%eax, -140(%ebp)
	movl	%eax, -148(%ebp)
	cmpl	$0, __asan_option_detect_stack_use_after_return
	je	.L2
	subl	$8, %esp
	pushl	-140(%ebp)
	pushl	$96
	call	__asan_stack_malloc_1
	addl	$16, %esp
	movl	%eax, -140(%ebp)
.L2:
	movl	-140(%ebp), %edi
	movl	%edi, %eax
	addl	$96, %eax
	movl	%eax, -144(%ebp)
	movl	%edi, %eax
	movl	$1102416563, (%eax)
	movl	%edi, %eax
	movl	$.LC1, 4(%eax)
	movl	$.LASANPC1, 8(%eax)
	shrl	$3, %eax
	movl	%eax, %edi
	movl	$-235802127, 536870912(%edi)
	movl	$-185273340, 536870916(%edi)
	movl	$-202116109, 536870920(%edi)
	call	__errno_location
	movl	%eax, %esi
	movl	%esi, %ecx
	movl	%ecx, %eax
	shrl	$3, %eax
	addl	$536870912, %eax
	movzbl	(%eax), %edx
	testb	%dl, %dl
	setne	%bl
	movl	%ecx, %eax
	andl	$7, %eax
	addl	$3, %eax
	cmpb	%dl, %al
	setge	%al
	andl	%ebx, %eax
	testb	%al, %al
	je	.L6
	subl	$12, %esp
	pushl	%ecx
	call	__asan_report_load4
.L6:
	movl	(%esi), %eax
	movl	%eax, -128(%ebp)
.L20:
	subl	$4, %esp
	pushl	$1
	movl	-144(%ebp), %eax
	subl	$64, %eax
	pushl	%eax
	pushl	$-1
	call	waitpid
	addl	$16, %esp
	movl	%eax, -124(%ebp)
	cmpl	$0, -124(%ebp)
	jne	.L7
	jmp	.L8
.L7:
	cmpl	$0, -124(%ebp)
	jns	.L9
	call	__errno_location
	movl	%eax, %esi
	movl	%esi, %ecx
	movl	%ecx, %eax
	shrl	$3, %eax
	addl	$536870912, %eax
	movzbl	(%eax), %edx
	testb	%dl, %dl
	setne	%bl
	movl	%ecx, %eax
	andl	$7, %eax
	addl	$3, %eax
	cmpb	%dl, %al
	setge	%al
	andl	%ebx, %eax
	testb	%al, %al
	je	.L10
	subl	$12, %esp
	pushl	%ecx
	call	__asan_report_load4
.L10:
	movl	(%esi), %eax
	cmpl	$4, %eax
	je	.L11
	call	__errno_location
	movl	%eax, %esi
	movl	%esi, %ecx
	movl	%ecx, %eax
	shrl	$3, %eax
	addl	$536870912, %eax
	movzbl	(%eax), %edx
	testb	%dl, %dl
	setne	%bl
	movl	%ecx, %eax
	andl	$7, %eax
	addl	$3, %eax
	cmpb	%dl, %al
	setge	%al
	andl	%ebx, %eax
	testb	%al, %al
	je	.L12
	subl	$12, %esp
	pushl	%ecx
	call	__asan_report_load4
.L12:
	movl	(%esi), %eax
	cmpl	$11, %eax
	jne	.L13
.L11:
	jmp	.L14
.L13:
	call	__errno_location
	movl	%eax, %ebx
	movl	%ebx, %edx
	movl	%edx, %eax
	shrl	$3, %eax
	addl	$536870912, %eax
	movzbl	(%eax), %ecx
	testb	%cl, %cl
	setne	%al
	movl	%eax, %esi
	movl	%edx, %eax
	andl	$7, %eax
	addl	$3, %eax
	cmpb	%cl, %al
	setge	%al
	andl	%esi, %eax
	testb	%al, %al
	je	.L15
	subl	$12, %esp
	pushl	%edx
	call	__asan_report_load4
.L15:
	movl	(%ebx), %eax
	cmpl	$10, %eax
	je	.L16
	subl	$8, %esp
	pushl	$.LC2
	pushl	$3
	call	syslog
	addl	$16, %esp
	jmp	.L8
.L16:
	jmp	.L8
.L9:
	movl	hs, %eax
	testl	%eax, %eax
	je	.L14
	movl	hs, %edx
	leal	20(%edx), %eax
	movl	%eax, %ebx
	movl	%ebx, %eax
	shrl	$3, %eax
	addl	$536870912, %eax
	movzbl	(%eax), %ecx
	testb	%cl, %cl
	setne	%al
	movl	%eax, %esi
	movl	%ebx, %eax
	andl	$7, %eax
	addl	$3, %eax
	cmpb	%cl, %al
	setge	%al
	andl	%esi, %eax
	testb	%al, %al
	je	.L17
	subl	$12, %esp
	pushl	%ebx
	call	__asan_report_load4
.L17:
	movl	20(%edx), %eax
	subl	$1, %eax
	movl	%eax, 20(%edx)
	movl	hs, %ebx
	leal	20(%ebx), %eax
	movl	%eax, %ecx
	movl	%ecx, %eax
	shrl	$3, %eax
	addl	$536870912, %eax
	movzbl	(%eax), %edx
	testb	%dl, %dl
	setne	%al
	movl	%eax, %esi
	movl	%ecx, %eax
	andl	$7, %eax
	addl	$3, %eax
	cmpb	%dl, %al
	setge	%al
	andl	%esi, %eax
	testb	%al, %al
	je	.L18
	subl	$12, %esp
	pushl	%ecx
	call	__asan_report_load4
.L18:
	movl	20(%ebx), %eax
	testl	%eax, %eax
	jns	.L14
	movl	hs, %ebx
	leal	20(%ebx), %eax
	movl	%eax, %ecx
	movl	%ecx, %eax
	shrl	$3, %eax
	addl	$536870912, %eax
	movzbl	(%eax), %edx
	testb	%dl, %dl
	setne	%al
	movl	%eax, %esi
	movl	%ecx, %eax
	andl	$7, %eax
	addl	$3, %eax
	cmpb	%dl, %al
	setge	%al
	andl	%esi, %eax
	testb	%al, %al
	je	.L19
	subl	$12, %esp
	pushl	%ecx
	call	__asan_report_store4
.L19:
	movl	$0, 20(%ebx)
.L14:
	jmp	.L20
.L8:
	call	__errno_location
	movl	%eax, %ebx
	movl	%ebx, %edx
	movl	%edx, %eax
	shrl	$3, %eax
	addl	$536870912, %eax
	movzbl	(%eax), %ecx
	testb	%cl, %cl
	setne	%al
	movl	%eax, %esi
	movl	%edx, %eax
	andl	$7, %eax
	addl	$3, %eax
	cmpb	%cl, %al
	setge	%al
	andl	%esi, %eax
	testb	%al, %al
	je	.L21
	subl	$12, %esp
	pushl	%edx
	call	__asan_report_store4
.L21:
	movl	-128(%ebp), %eax
	movl	%eax, (%ebx)
	movl	-140(%ebp), %esi
	cmpl	%esi, -148(%ebp)
	je	.L3
	movl	-140(%ebp), %eax
	movl	$1172321806, (%eax)
	movl	$-168430091, 536870912(%edi)
	movl	$-168430091, 536870916(%edi)
	movl	$-168430091, 536870920(%edi)
	jmp	.L4
.L3:
	movl	$0, 536870912(%edi)
	movl	$0, 536870916(%edi)
	movl	$0, 536870920(%edi)
.L4:
	leal	-12(%ebp), %esp
	popl	%ebx
	popl	%esi
	popl	%edi
	popl	%ebp
	ret
	.size	handle_chld, .-handle_chld
	.type	handle_hup, @function
handle_hup:
.LASANPC2:
	pushl	%ebp
	movl	%esp, %ebp
	pushl	%edi
	pushl	%esi
	pushl	%ebx
	subl	$28, %esp
	call	__errno_location
	movl	%eax, %ecx
	movl	%ecx, %eax
	movl	%eax, %edx
	shrl	$3, %edx
	addl	$536870912, %edx
	movzbl	(%edx), %edx
	testb	%dl, %dl
	setne	%bl
	movl	%ebx, %edi
	movl	%eax, %esi
	andl	$7, %esi
	addl	$3, %esi
	movl	%esi, %ebx
	cmpb	%dl, %bl
	setge	%dl
	andl	%edi, %edx
	testb	%dl, %dl
	je	.L23
	subl	$12, %esp
	pushl	%eax
	call	__asan_report_load4
.L23:
	movl	(%ecx), %eax
	movl	%eax, -28(%ebp)
	movl	$1, got_hup
	call	__errno_location
	movl	%eax, %ecx
	movl	%ecx, %eax
	movl	%eax, %edx
	shrl	$3, %edx
	addl	$536870912, %edx
	movzbl	(%edx), %edx
	testb	%dl, %dl
	setne	%bl
	movl	%ebx, %edi
	movl	%eax, %esi
	andl	$7, %esi
	addl	$3, %esi
	movl	%esi, %ebx
	cmpb	%dl, %bl
	setge	%dl
	andl	%edi, %edx
	testb	%dl, %dl
	je	.L24
	subl	$12, %esp
	pushl	%eax
	call	__asan_report_store4
.L24:
	movl	-28(%ebp), %eax
	movl	%eax, (%ecx)
	leal	-12(%ebp), %esp
	popl	%ebx
	popl	%esi
	popl	%edi
	popl	%ebp
	ret
	.size	handle_hup, .-handle_hup
	.section	.rodata
	.align 32
.LC3:
	.string	"exiting"
	.zero	56
	.text
	.type	handle_usr1, @function
handle_usr1:
.LASANPC3:
	pushl	%ebp
	movl	%esp, %ebp
	subl	$8, %esp
	movl	num_connects, %eax
	testl	%eax, %eax
	jne	.L26
	call	shut_down
	subl	$8, %esp
	pushl	$.LC3
	pushl	$5
	call	syslog
	addl	$16, %esp
	call	closelog
	call	__asan_handle_no_return
	subl	$12, %esp
	pushl	$0
	call	exit
.L26:
	movl	$1, got_usr1
	leave
	ret
	.size	handle_usr1, .-handle_usr1
	.type	handle_usr2, @function
handle_usr2:
.LASANPC4:
	pushl	%ebp
	movl	%esp, %ebp
	pushl	%edi
	pushl	%esi
	pushl	%ebx
	subl	$28, %esp
	call	__errno_location
	movl	%eax, %ecx
	movl	%ecx, %eax
	movl	%eax, %edx
	shrl	$3, %edx
	addl	$536870912, %edx
	movzbl	(%edx), %edx
	testb	%dl, %dl
	setne	%bl
	movl	%ebx, %edi
	movl	%eax, %esi
	andl	$7, %esi
	addl	$3, %esi
	movl	%esi, %ebx
	cmpb	%dl, %bl
	setge	%dl
	andl	%edi, %edx
	testb	%dl, %dl
	je	.L28
	subl	$12, %esp
	pushl	%eax
	call	__asan_report_load4
.L28:
	movl	(%ecx), %eax
	movl	%eax, -28(%ebp)
	subl	$12, %esp
	pushl	$0
	call	logstats
	addl	$16, %esp
	call	__errno_location
	movl	%eax, %ecx
	movl	%ecx, %eax
	movl	%eax, %edx
	shrl	$3, %edx
	addl	$536870912, %edx
	movzbl	(%edx), %edx
	testb	%dl, %dl
	setne	%bl
	movl	%ebx, %edi
	movl	%eax, %esi
	andl	$7, %esi
	addl	$3, %esi
	movl	%esi, %ebx
	cmpb	%dl, %bl
	setge	%dl
	andl	%edi, %edx
	testb	%dl, %dl
	je	.L29
	subl	$12, %esp
	pushl	%eax
	call	__asan_report_store4
.L29:
	movl	-28(%ebp), %eax
	movl	%eax, (%ecx)
	leal	-12(%ebp), %esp
	popl	%ebx
	popl	%esi
	popl	%edi
	popl	%ebp
	ret
	.size	handle_usr2, .-handle_usr2
	.section	.rodata
	.align 32
.LC4:
	.string	"/tmp"
	.zero	59
	.text
	.type	handle_alrm, @function
handle_alrm:
.LASANPC5:
	pushl	%ebp
	movl	%esp, %ebp
	pushl	%edi
	pushl	%esi
	pushl	%ebx
	subl	$28, %esp
	call	__errno_location
	movl	%eax, %ecx
	movl	%ecx, %eax
	movl	%eax, %edx
	shrl	$3, %edx
	addl	$536870912, %edx
	movzbl	(%edx), %edx
	testb	%dl, %dl
	setne	%bl
	movl	%ebx, %edi
	movl	%eax, %esi
	andl	$7, %esi
	addl	$3, %esi
	movl	%esi, %ebx
	cmpb	%dl, %bl
	setge	%dl
	andl	%edi, %edx
	testb	%dl, %dl
	je	.L31
	subl	$12, %esp
	pushl	%eax
	call	__asan_report_load4
.L31:
	movl	(%ecx), %eax
	movl	%eax, -28(%ebp)
	movl	watchdog_flag, %eax
	testl	%eax, %eax
	jne	.L32
	subl	$12, %esp
	pushl	$.LC4
	call	chdir
	addl	$16, %esp
	call	__asan_handle_no_return
	call	abort
.L32:
	movl	$0, watchdog_flag
	subl	$12, %esp
	pushl	$360
	call	alarm
	addl	$16, %esp
	call	__errno_location
	movl	%eax, %ecx
	movl	%ecx, %eax
	movl	%eax, %edx
	shrl	$3, %edx
	addl	$536870912, %edx
	movzbl	(%edx), %edx
	testb	%dl, %dl
	setne	%bl
	movl	%ebx, %edi
	movl	%eax, %esi
	andl	$7, %esi
	addl	$3, %esi
	movl	%esi, %ebx
	cmpb	%dl, %bl
	setge	%dl
	andl	%edi, %edx
	testb	%dl, %dl
	je	.L33
	subl	$12, %esp
	pushl	%eax
	call	__asan_report_store4
.L33:
	movl	-28(%ebp), %eax
	movl	%eax, (%ecx)
	leal	-12(%ebp), %esp
	popl	%ebx
	popl	%esi
	popl	%edi
	popl	%ebp
	ret
	.size	handle_alrm, .-handle_alrm
	.section	.rodata
	.align 32
.LC5:
	.string	"-"
	.zero	62
	.align 32
.LC6:
	.string	"re-opening logfile"
	.zero	45
	.align 32
.LC7:
	.string	"a"
	.zero	62
	.align 32
.LC8:
	.string	"re-opening %.80s - %m"
	.zero	42
	.text
	.type	re_open_logfile, @function
re_open_logfile:
.LASANPC6:
	pushl	%ebp
	movl	%esp, %ebp
	subl	$24, %esp
	movl	no_log, %eax
	testl	%eax, %eax
	jne	.L35
	movl	hs, %eax
	testl	%eax, %eax
	jne	.L36
.L35:
	jmp	.L34
.L36:
	movl	logfile, %eax
	testl	%eax, %eax
	je	.L34
	movl	logfile, %eax
	subl	$8, %esp
	pushl	$.LC5
	pushl	%eax
	call	strcmp
	addl	$16, %esp
	testl	%eax, %eax
	je	.L34
	subl	$8, %esp
	pushl	$.LC6
	pushl	$5
	call	syslog
	addl	$16, %esp
	movl	logfile, %eax
	subl	$8, %esp
	pushl	$.LC7
	pushl	%eax
	call	fopen
	addl	$16, %esp
	movl	%eax, -16(%ebp)
	movl	logfile, %eax
	subl	$8, %esp
	pushl	$384
	pushl	%eax
	call	chmod
	addl	$16, %esp
	movl	%eax, -12(%ebp)
	cmpl	$0, -16(%ebp)
	je	.L38
	cmpl	$0, -12(%ebp)
	je	.L39
.L38:
	movl	logfile, %eax
	subl	$4, %esp
	pushl	%eax
	pushl	$.LC8
	pushl	$2
	call	syslog
	addl	$16, %esp
	jmp	.L34
.L39:
	subl	$12, %esp
	pushl	-16(%ebp)
	call	fileno
	addl	$16, %esp
	subl	$4, %esp
	pushl	$1
	pushl	$2
	pushl	%eax
	call	fcntl
	addl	$16, %esp
	movl	hs, %eax
	subl	$8, %esp
	pushl	-16(%ebp)
	pushl	%eax
	call	httpd_set_logfp
	addl	$16, %esp
.L34:
	leave
	ret
	.size	re_open_logfile, .-re_open_logfile
	.globl	__asan_stack_malloc_7
	.section	.rodata
	.align 4
.LC9:
	.string	"6 32 4 5 gotv4 96 4 5 gotv6 160 8 2 tv 224 128 3 sa4 384 128 3 sa6 544 4097 3 cwd "
	.globl	__asan_stack_free_7
	.align 32
.LC10:
	.string	"can't find any valid address"
	.zero	35
	.align 32
.LC11:
	.string	"%s: can't find any valid address\n"
	.zero	62
	.align 32
.LC12:
	.string	"unknown user - '%.80s'"
	.zero	41
	.align 32
.LC13:
	.string	"%s: unknown user - '%s'\n"
	.zero	39
	.align 32
.LC14:
	.string	"/dev/null"
	.zero	54
	.align 32
.LC15:
	.string	"%.80s - %m"
	.zero	53
	.align 32
.LC16:
	.string	"logfile is not an absolute path, you may not be able to re-open it"
	.zero	61
	.align 32
.LC17:
	.string	"%s: logfile is not an absolute path, you may not be able to re-open it\n"
	.zero	56
	.align 32
.LC18:
	.string	"fchown logfile - %m"
	.zero	44
	.align 32
.LC19:
	.string	"fchown logfile"
	.zero	49
	.align 32
.LC20:
	.string	"chdir - %m"
	.zero	53
	.align 32
.LC21:
	.string	"chdir"
	.zero	58
	.align 32
.LC22:
	.string	"/"
	.zero	62
	.align 32
.LC23:
	.string	"daemon - %m"
	.zero	52
	.align 32
.LC24:
	.string	"w"
	.zero	62
	.align 32
.LC25:
	.string	"%d\n"
	.zero	60
	.align 32
.LC26:
	.string	"fdwatch initialization failure"
	.zero	33
	.align 32
.LC27:
	.string	"chroot - %m"
	.zero	52
	.align 32
.LC28:
	.string	"chroot"
	.zero	57
	.align 32
.LC29:
	.string	"logfile is not within the chroot tree, you will not be able to re-open it"
	.zero	54
	.align 32
.LC30:
	.string	"%s: logfile is not within the chroot tree, you will not be able to re-open it\n"
	.zero	49
	.align 32
.LC31:
	.string	"chroot chdir - %m"
	.zero	46
	.align 32
.LC32:
	.string	"chroot chdir"
	.zero	51
	.align 32
.LC33:
	.string	"data_dir chdir - %m"
	.zero	44
	.align 32
.LC34:
	.string	"data_dir chdir"
	.zero	49
	.align 32
.LC35:
	.string	"tmr_create(occasional) failed"
	.zero	34
	.align 32
.LC36:
	.string	"tmr_create(idle) failed"
	.zero	40
	.align 32
.LC37:
	.string	"tmr_create(update_throttles) failed"
	.zero	60
	.align 32
.LC38:
	.string	"tmr_create(show_stats) failed"
	.zero	34
	.align 32
.LC39:
	.string	"setgroups - %m"
	.zero	49
	.align 32
.LC40:
	.string	"setgid - %m"
	.zero	52
	.align 32
.LC41:
	.string	"initgroups - %m"
	.zero	48
	.align 32
.LC42:
	.string	"setuid - %m"
	.zero	52
	.align 32
.LC43:
	.string	"started as root without requesting chroot(), warning only"
	.zero	38
	.align 32
.LC44:
	.string	"out of memory allocating a connecttab"
	.zero	58
	.align 32
.LC45:
	.string	"fdwatch - %m"
	.zero	51
	.text
	.globl	main
	.type	main, @function
main:
.LASANPC7:
	leal	4(%esp), %ecx
	andl	$-16, %esp
	pushl	-4(%ecx)
	pushl	%ebp
	movl	%esp, %ebp
	pushl	%edi
	pushl	%esi
	pushl	%ebx
	pushl	%ecx
	subl	$4808, %esp
	movl	%ecx, %ebx
	leal	-4728(%ebp), %eax
	cmpl	$0, __asan_option_detect_stack_use_after_return
	je	.L40
	subl	$8, %esp
	pushl	%eax
	pushl	$4704
	call	__asan_stack_malloc_7
	addl	$16, %esp
.L40:
	leal	4704(%eax), %edx
	movl	%edx, -4780(%ebp)
	movl	$1102416563, (%eax)
	movl	$.LC9, 4(%eax)
	movl	$.LASANPC7, 8(%eax)
	shrl	$3, %eax
	movl	$-235802127, 536870912(%eax)
	movl	$-185273340, 536870916(%eax)
	movl	$-218959118, 536870920(%eax)
	movl	$-185273340, 536870924(%eax)
	movl	$-218959118, 536870928(%eax)
	movl	$-185273344, 536870932(%eax)
	movl	$-218959118, 536870936(%eax)
	movl	$-218959118, 536870956(%eax)
	movl	$-218959118, 536870976(%eax)
	movl	$-185273343, 536871492(%eax)
	movl	$-202116109, 536871496(%eax)
	movl	$32767, -4768(%ebp)
	movl	$32767, -4764(%ebp)
	movl	4(%ebx), %eax
	movl	%eax, %edx
	shrl	$3, %edx
	addl	$536870912, %edx
	movzbl	(%edx), %edx
	testb	%dl, %dl
	setne	%cl
	movl	%ecx, %edi
	movl	%eax, %esi
	andl	$7, %esi
	addl	$3, %esi
	movl	%esi, %ecx
	cmpb	%dl, %cl
	setge	%dl
	andl	%edi, %edx
	testb	%dl, %dl
	je	.L46
	subl	$12, %esp
	pushl	%eax
	call	__asan_report_load4
.L46:
	movl	4(%ebx), %eax
	movl	(%eax), %eax
	movl	%eax, argv0
	movl	argv0, %eax
	subl	$8, %esp
	pushl	$47
	pushl	%eax
	call	strrchr
	addl	$16, %esp
	movl	%eax, -4772(%ebp)
	cmpl	$0, -4772(%ebp)
	je	.L47
	addl	$1, -4772(%ebp)
	jmp	.L48
.L47:
	movl	argv0, %eax
	movl	%eax, -4772(%ebp)
.L48:
	subl	$4, %esp
	pushl	$24
	pushl	$9
	pushl	-4772(%ebp)
	call	openlog
	addl	$16, %esp
	subl	$8, %esp
	pushl	4(%ebx)
	pushl	(%ebx)
	call	parse_args
	addl	$16, %esp
	call	tzset
	subl	$8, %esp
	movl	-4780(%ebp), %edi
	movl	%edi, %eax
	subl	$4608, %eax
	pushl	%eax
	pushl	$128
	movl	%edi, %eax
	subl	$4320, %eax
	pushl	%eax
	movl	%edi, %eax
	subl	$4672, %eax
	pushl	%eax
	pushl	$128
	movl	%edi, %eax
	subl	$4480, %eax
	pushl	%eax
	call	lookup_hostname
	addl	$32, %esp
	movl	%edi, %eax
	movl	-4672(%eax), %eax
	testl	%eax, %eax
	jne	.L49
	movl	-4780(%ebp), %eax
	movl	-4608(%eax), %eax
	testl	%eax, %eax
	jne	.L49
	subl	$8, %esp
	pushl	$.LC10
	pushl	$3
	call	syslog
	addl	$16, %esp
	movl	argv0, %edi
	movl	$stderr, %eax
	movl	%eax, %edx
	shrl	$3, %edx
	addl	$536870912, %edx
	movzbl	(%edx), %edx
	testb	%dl, %dl
	setne	%bl
	movl	%eax, %esi
	andl	$7, %esi
	addl	$3, %esi
	movl	%esi, %ecx
	cmpb	%dl, %cl
	setge	%dl
	andl	%ebx, %edx
	testb	%dl, %dl
	je	.L50
	subl	$12, %esp
	pushl	%eax
	call	__asan_report_load4
.L50:
	movl	stderr, %eax
	subl	$4, %esp
	pushl	%edi
	pushl	$.LC11
	pushl	%eax
	call	fprintf
	addl	$16, %esp
	call	__asan_handle_no_return
	subl	$12, %esp
	pushl	$1
	call	exit
.L49:
	movl	$0, numthrottles
	movl	$0, maxthrottles
	movl	$0, throttles
	movl	throttlefile, %eax
	testl	%eax, %eax
	je	.L51
	movl	throttlefile, %eax
	subl	$12, %esp
	pushl	%eax
	call	read_throttlefile
	addl	$16, %esp
.L51:
	call	getuid
	testl	%eax, %eax
	jne	.L52
	movl	user, %eax
	subl	$12, %esp
	pushl	%eax
	call	getpwnam
	addl	$16, %esp
	movl	%eax, -4752(%ebp)
	cmpl	$0, -4752(%ebp)
	jne	.L53
	movl	user, %eax
	subl	$4, %esp
	pushl	%eax
	pushl	$.LC12
	pushl	$2
	call	syslog
	addl	$16, %esp
	movl	user, %ebx
	movl	argv0, %eax
	movl	%eax, -4780(%ebp)
	movl	$stderr, %eax
	movl	%eax, %edx
	shrl	$3, %edx
	addl	$536870912, %edx
	movzbl	(%edx), %edx
	testb	%dl, %dl
	setne	%cl
	movl	%ecx, %esi
	movl	%eax, %edi
	andl	$7, %edi
	addl	$3, %edi
	movl	%edi, %ecx
	cmpb	%dl, %cl
	setge	%dl
	andl	%esi, %edx
	testb	%dl, %dl
	je	.L54
	subl	$12, %esp
	pushl	%eax
	call	__asan_report_load4
.L54:
	movl	stderr, %eax
	pushl	%ebx
	pushl	-4780(%ebp)
	pushl	$.LC13
	pushl	%eax
	call	fprintf
	addl	$16, %esp
	call	__asan_handle_no_return
	subl	$12, %esp
	pushl	$1
	call	exit
.L53:
	movl	-4752(%ebp), %eax
	addl	$8, %eax
	movl	%eax, %edx
	shrl	$3, %edx
	addl	$536870912, %edx
	movzbl	(%edx), %edx
	testb	%dl, %dl
	setne	%cl
	movl	%eax, %ebx
	andl	$7, %ebx
	addl	$3, %ebx
	cmpb	%dl, %bl
	setge	%dl
	andl	%ecx, %edx
	testb	%dl, %dl
	je	.L55
	subl	$12, %esp
	pushl	%eax
	call	__asan_report_load4
.L55:
	movl	-4752(%ebp), %eax
	movl	8(%eax), %eax
	movl	%eax, -4768(%ebp)
	movl	-4752(%ebp), %eax
	addl	$12, %eax
	movl	%eax, %edx
	shrl	$3, %edx
	addl	$536870912, %edx
	movzbl	(%edx), %edx
	testb	%dl, %dl
	setne	%cl
	movl	%eax, %ebx
	andl	$7, %ebx
	addl	$3, %ebx
	cmpb	%dl, %bl
	setge	%dl
	andl	%ecx, %edx
	testb	%dl, %dl
	je	.L56
	subl	$12, %esp
	pushl	%eax
	call	__asan_report_load4
.L56:
	movl	-4752(%ebp), %eax
	movl	12(%eax), %eax
	movl	%eax, -4764(%ebp)
.L52:
	movl	logfile, %eax
	testl	%eax, %eax
	je	.L57
	movl	logfile, %eax
	subl	$8, %esp
	pushl	$.LC14
	pushl	%eax
	call	strcmp
	addl	$16, %esp
	testl	%eax, %eax
	jne	.L58
	movl	$1, no_log
	movl	$0, -4760(%ebp)
	jmp	.L67
.L58:
	movl	logfile, %eax
	subl	$8, %esp
	pushl	$.LC5
	pushl	%eax
	call	strcmp
	addl	$16, %esp
	testl	%eax, %eax
	jne	.L60
	movl	$stdout, %eax
	movl	%eax, %edx
	shrl	$3, %edx
	addl	$536870912, %edx
	movzbl	(%edx), %edx
	testb	%dl, %dl
	setne	%cl
	movl	%eax, %ebx
	andl	$7, %ebx
	addl	$3, %ebx
	cmpb	%dl, %bl
	setge	%dl
	andl	%ecx, %edx
	testb	%dl, %dl
	je	.L61
	subl	$12, %esp
	pushl	%eax
	call	__asan_report_load4
.L61:
	movl	stdout, %eax
	movl	%eax, -4760(%ebp)
	jmp	.L67
.L60:
	movl	logfile, %eax
	subl	$8, %esp
	pushl	$.LC7
	pushl	%eax
	call	fopen
	addl	$16, %esp
	movl	%eax, -4760(%ebp)
	movl	logfile, %eax
	subl	$8, %esp
	pushl	$384
	pushl	%eax
	call	chmod
	addl	$16, %esp
	movl	%eax, -4748(%ebp)
	cmpl	$0, -4760(%ebp)
	je	.L62
	cmpl	$0, -4748(%ebp)
	je	.L63
.L62:
	movl	logfile, %eax
	subl	$4, %esp
	pushl	%eax
	pushl	$.LC15
	pushl	$2
	call	syslog
	addl	$16, %esp
	movl	logfile, %eax
	subl	$12, %esp
	pushl	%eax
	call	perror
	addl	$16, %esp
	call	__asan_handle_no_return
	subl	$12, %esp
	pushl	$1
	call	exit
.L63:
	movl	logfile, %edx
	movl	%edx, %eax
	movl	%eax, %ecx
	shrl	$3, %ecx
	addl	$536870912, %ecx
	movzbl	(%ecx), %ecx
	testb	%cl, %cl
	setne	%bl
	movl	%ebx, %edi
	movl	%eax, %esi
	andl	$7, %esi
	movl	%esi, %ebx
	cmpb	%cl, %bl
	setge	%cl
	andl	%edi, %ecx
	testb	%cl, %cl
	je	.L64
	subl	$12, %esp
	pushl	%eax
	call	__asan_report_load1
.L64:
	movzbl	(%edx), %eax
	cmpb	$47, %al
	je	.L65
	subl	$8, %esp
	pushl	$.LC16
	pushl	$4
	call	syslog
	addl	$16, %esp
	movl	argv0, %edi
	movl	$stderr, %eax
	movl	%eax, %edx
	shrl	$3, %edx
	addl	$536870912, %edx
	movzbl	(%edx), %edx
	testb	%dl, %dl
	setne	%bl
	movl	%eax, %esi
	andl	$7, %esi
	addl	$3, %esi
	movl	%esi, %ecx
	cmpb	%dl, %cl
	setge	%dl
	andl	%ebx, %edx
	testb	%dl, %dl
	je	.L66
	subl	$12, %esp
	pushl	%eax
	call	__asan_report_load4
.L66:
	movl	stderr, %eax
	subl	$4, %esp
	pushl	%edi
	pushl	$.LC17
	pushl	%eax
	call	fprintf
	addl	$16, %esp
.L65:
	subl	$12, %esp
	pushl	-4760(%ebp)
	call	fileno
	addl	$16, %esp
	subl	$4, %esp
	pushl	$1
	pushl	$2
	pushl	%eax
	call	fcntl
	addl	$16, %esp
	call	getuid
	testl	%eax, %eax
	jne	.L67
	subl	$12, %esp
	pushl	-4760(%ebp)
	call	fileno
	addl	$16, %esp
	subl	$4, %esp
	pushl	-4764(%ebp)
	pushl	-4768(%ebp)
	pushl	%eax
	call	fchown
	addl	$16, %esp
	testl	%eax, %eax
	jns	.L67
	subl	$8, %esp
	pushl	$.LC18
	pushl	$4
	call	syslog
	addl	$16, %esp
	subl	$12, %esp
	pushl	$.LC19
	call	perror
	addl	$16, %esp
	jmp	.L67
.L57:
	movl	$0, -4760(%ebp)
.L67:
	movl	dir, %eax
	testl	%eax, %eax
	je	.L68
	movl	dir, %eax
	subl	$12, %esp
	pushl	%eax
	call	chdir
	addl	$16, %esp
	testl	%eax, %eax
	jns	.L68
	subl	$8, %esp
	pushl	$.LC20
	pushl	$2
	call	syslog
	addl	$16, %esp
	subl	$12, %esp
	pushl	$.LC21
	call	perror
	addl	$16, %esp
	call	__asan_handle_no_return
	subl	$12, %esp
	pushl	$1
	call	exit
.L68:
	subl	$8, %esp
	pushl	$4096
	movl	-4780(%ebp), %edi
	movl	%edi, %eax
	subl	$4160, %eax
	pushl	%eax
	call	getcwd
	addl	$16, %esp
	subl	$12, %esp
	movl	%edi, %eax
	subl	$4160, %eax
	pushl	%eax
	call	strlen
	addl	$16, %esp
	movl	%eax, %esi
	movl	%edi, %eax
	leal	-4160(%eax), %ebx
	movl	%ebx, %edx
	movl	%edx, %eax
	shrl	$3, %eax
	addl	$536870912, %eax
	movzbl	(%eax), %ecx
	testb	%cl, %cl
	setne	%al
	movl	%eax, %edi
	movl	%edx, %eax
	andl	$7, %eax
	cmpb	%cl, %al
	setge	%al
	andl	%edi, %eax
	testb	%al, %al
	je	.L69
	subl	$12, %esp
	pushl	%edx
	call	__asan_report_load1
.L69:
	movl	%esi, %eax
	addl	%ebx, %eax
	movl	%eax, %edx
	shrl	$3, %edx
	addl	$536870912, %edx
	movzbl	(%edx), %edx
	testb	%dl, %dl
	setne	%cl
	movl	%eax, %ebx
	andl	$7, %ebx
	cmpb	%dl, %bl
	setge	%dl
	andl	%ecx, %edx
	testb	%dl, %dl
	je	.L70
	subl	$12, %esp
	pushl	%eax
	call	__asan_report_load1
.L70:
	leal	-1(%esi), %ecx
	movl	-4780(%ebp), %eax
	subl	$4160, %eax
	addl	%ecx, %eax
	movl	%eax, %edx
	shrl	$3, %edx
	addl	$536870912, %edx
	movzbl	(%edx), %edx
	testb	%dl, %dl
	setne	%bl
	movl	%ebx, %edi
	movl	%eax, %esi
	andl	$7, %esi
	movl	%esi, %ebx
	cmpb	%dl, %bl
	setge	%dl
	andl	%edi, %edx
	testb	%dl, %dl
	je	.L71
	subl	$12, %esp
	pushl	%eax
	call	__asan_report_load1
.L71:
	movl	-4780(%ebp), %eax
	movzbl	-4160(%ecx,%eax), %eax
	cmpb	$47, %al
	je	.L72
	movl	-4780(%ebp), %ebx
	movl	%ebx, %eax
	subl	$4160, %eax
	movl	$-1, %ecx
	movl	%eax, %edx
	movl	$0, %eax
	movl	%edx, %edi
	repnz; scasb
	movl	%ecx, %eax
	notl	%eax
	leal	-1(%eax), %esi
	movl	%ebx, %eax
	leal	-4160(%eax), %ebx
	movl	%ebx, %edx
	movl	%edx, %eax
	shrl	$3, %eax
	addl	$536870912, %eax
	movzbl	(%eax), %ecx
	testb	%cl, %cl
	setne	%al
	movl	%eax, %edi
	movl	%edx, %eax
	andl	$7, %eax
	cmpb	%cl, %al
	setge	%al
	andl	%edi, %eax
	testb	%al, %al
	je	.L73
	subl	$12, %esp
	pushl	%edx
	call	__asan_report_load1
.L73:
	movl	%esi, %eax
	addl	%ebx, %eax
	movl	%eax, %edx
	shrl	$3, %edx
	addl	$536870912, %edx
	movzbl	(%edx), %edx
	testb	%dl, %dl
	setne	%cl
	movl	%eax, %ebx
	andl	$7, %ebx
	cmpb	%dl, %bl
	setge	%dl
	andl	%ecx, %edx
	testb	%dl, %dl
	je	.L74
	subl	$12, %esp
	pushl	%eax
	call	__asan_report_load1
.L74:
	movl	-4780(%ebp), %eax
	subl	$4160, %eax
	addl	%esi, %eax
	movl	%eax, -4784(%ebp)
	movl	$.LC22, %eax
	movl	$2, %edi
	movl	%eax, %ebx
	movl	%ebx, %eax
	shrl	$3, %eax
	addl	$536870912, %eax
	movzbl	(%eax), %edx
	testb	%dl, %dl
	setne	%cl
	movl	%ebx, %eax
	andl	$7, %eax
	cmpb	%dl, %al
	setge	%al
	andl	%eax, %ecx
	movb	%cl, -4788(%ebp)
	leal	-1(%edi), %eax
	leal	(%ebx,%eax), %esi
	movl	%esi, %eax
	shrl	$3, %eax
	addl	$536870912, %eax
	movzbl	(%eax), %edx
	testb	%dl, %dl
	setne	%cl
	movl	%esi, %eax
	andl	$7, %eax
	cmpb	%dl, %al
	setge	%al
	andl	%ecx, %eax
	orb	-4788(%ebp), %al
	testb	%al, %al
	je	.L75
	subl	$8, %esp
	pushl	%edi
	pushl	%ebx
	call	__asan_report_load_n
.L75:
	movl	$2, %edi
	movl	-4784(%ebp), %ebx
	movl	%ebx, %eax
	shrl	$3, %eax
	addl	$536870912, %eax
	movzbl	(%eax), %edx
	testb	%dl, %dl
	setne	%cl
	movl	%ebx, %eax
	andl	$7, %eax
	cmpb	%dl, %al
	setge	%al
	andl	%eax, %ecx
	movb	%cl, -4788(%ebp)
	leal	-1(%edi), %eax
	leal	(%ebx,%eax), %esi
	movl	%esi, %eax
	shrl	$3, %eax
	addl	$536870912, %eax
	movzbl	(%eax), %edx
	testb	%dl, %dl
	setne	%cl
	movl	%esi, %eax
	andl	$7, %eax
	cmpb	%dl, %al
	setge	%al
	andl	%ecx, %eax
	orb	-4788(%ebp), %al
	testb	%al, %al
	je	.L76
	subl	$8, %esp
	pushl	%edi
	pushl	%ebx
	call	__asan_report_store_n
.L76:
	movl	-4784(%ebp), %eax
	movw	$47, (%eax)
.L72:
	movl	debug, %eax
	testl	%eax, %eax
	jne	.L77
	movl	$stdin, %eax
	movl	%eax, %edx
	shrl	$3, %edx
	addl	$536870912, %edx
	movzbl	(%edx), %edx
	testb	%dl, %dl
	setne	%cl
	movl	%eax, %ebx
	andl	$7, %ebx
	addl	$3, %ebx
	cmpb	%dl, %bl
	setge	%dl
	andl	%ecx, %edx
	testb	%dl, %dl
	je	.L78
	subl	$12, %esp
	pushl	%eax
	call	__asan_report_load4
.L78:
	movl	stdin, %eax
	subl	$12, %esp
	pushl	%eax
	call	fclose
	addl	$16, %esp
	movl	$stdout, %eax
	movl	%eax, %edx
	shrl	$3, %edx
	addl	$536870912, %edx
	movzbl	(%edx), %edx
	testb	%dl, %dl
	setne	%cl
	movl	%eax, %ebx
	andl	$7, %ebx
	addl	$3, %ebx
	cmpb	%dl, %bl
	setge	%dl
	andl	%ecx, %edx
	testb	%dl, %dl
	je	.L79
	subl	$12, %esp
	pushl	%eax
	call	__asan_report_load4
.L79:
	movl	stdout, %eax
	cmpl	%eax, -4760(%ebp)
	je	.L80
	movl	stdout, %eax
	subl	$12, %esp
	pushl	%eax
	call	fclose
	addl	$16, %esp
.L80:
	movl	$stderr, %eax
	movl	%eax, %edx
	shrl	$3, %edx
	addl	$536870912, %edx
	movzbl	(%edx), %edx
	testb	%dl, %dl
	setne	%cl
	movl	%eax, %ebx
	andl	$7, %ebx
	addl	$3, %ebx
	cmpb	%dl, %bl
	setge	%dl
	andl	%ecx, %edx
	testb	%dl, %dl
	je	.L81
	subl	$12, %esp
	pushl	%eax
	call	__asan_report_load4
.L81:
	movl	stderr, %eax
	subl	$12, %esp
	pushl	%eax
	call	fclose
	addl	$16, %esp
	subl	$8, %esp
	pushl	$1
	pushl	$1
	call	daemon
	addl	$16, %esp
	testl	%eax, %eax
	jns	.L82
	subl	$8, %esp
	pushl	$.LC23
	pushl	$2
	call	syslog
	addl	$16, %esp
	call	__asan_handle_no_return
	subl	$12, %esp
	pushl	$1
	call	exit
.L77:
	call	setsid
.L82:
	movl	pidfile, %eax
	testl	%eax, %eax
	je	.L83
	movl	pidfile, %eax
	subl	$8, %esp
	pushl	$.LC24
	pushl	%eax
	call	fopen
	addl	$16, %esp
	movl	%eax, -4744(%ebp)
	cmpl	$0, -4744(%ebp)
	jne	.L84
	movl	pidfile, %eax
	subl	$4, %esp
	pushl	%eax
	pushl	$.LC15
	pushl	$2
	call	syslog
	addl	$16, %esp
	call	__asan_handle_no_return
	subl	$12, %esp
	pushl	$1
	call	exit
.L84:
	call	getpid
	subl	$4, %esp
	pushl	%eax
	pushl	$.LC25
	pushl	-4744(%ebp)
	call	fprintf
	addl	$16, %esp
	subl	$12, %esp
	pushl	-4744(%ebp)
	call	fclose
	addl	$16, %esp
.L83:
	call	fdwatch_get_nfiles
	movl	%eax, max_connects
	movl	max_connects, %eax
	testl	%eax, %eax
	jns	.L85
	subl	$8, %esp
	pushl	$.LC26
	pushl	$2
	call	syslog
	addl	$16, %esp
	call	__asan_handle_no_return
	subl	$12, %esp
	pushl	$1
	call	exit
.L85:
	movl	max_connects, %eax
	subl	$10, %eax
	movl	%eax, max_connects
	movl	do_chroot, %eax
	testl	%eax, %eax
	je	.L86
	subl	$12, %esp
	movl	-4780(%ebp), %eax
	subl	$4160, %eax
	pushl	%eax
	call	chroot
	addl	$16, %esp
	testl	%eax, %eax
	jns	.L87
	subl	$8, %esp
	pushl	$.LC27
	pushl	$2
	call	syslog
	addl	$16, %esp
	subl	$12, %esp
	pushl	$.LC28
	call	perror
	addl	$16, %esp
	call	__asan_handle_no_return
	subl	$12, %esp
	pushl	$1
	call	exit
.L87:
	movl	logfile, %eax
	testl	%eax, %eax
	je	.L88
	movl	logfile, %eax
	subl	$8, %esp
	pushl	$.LC5
	pushl	%eax
	call	strcmp
	addl	$16, %esp
	testl	%eax, %eax
	je	.L88
	subl	$12, %esp
	movl	-4780(%ebp), %edi
	movl	%edi, %eax
	subl	$4160, %eax
	pushl	%eax
	call	strlen
	addl	$16, %esp
	movl	%eax, %esi
	movl	%edi, %eax
	leal	-4160(%eax), %ebx
	movl	%ebx, %edx
	movl	%edx, %eax
	shrl	$3, %eax
	addl	$536870912, %eax
	movzbl	(%eax), %ecx
	testb	%cl, %cl
	setne	%al
	movl	%eax, %edi
	movl	%edx, %eax
	andl	$7, %eax
	cmpb	%cl, %al
	setge	%al
	andl	%edi, %eax
	testb	%al, %al
	je	.L89
	subl	$12, %esp
	pushl	%edx
	call	__asan_report_load1
.L89:
	movl	%esi, %eax
	addl	%ebx, %eax
	movl	%eax, %edx
	shrl	$3, %edx
	addl	$536870912, %edx
	movzbl	(%edx), %edx
	testb	%dl, %dl
	setne	%cl
	movl	%eax, %ebx
	andl	$7, %ebx
	cmpb	%dl, %bl
	setge	%dl
	andl	%ecx, %edx
	testb	%dl, %dl
	je	.L90
	subl	$12, %esp
	pushl	%eax
	call	__asan_report_load1
.L90:
	movl	logfile, %eax
	subl	$4, %esp
	pushl	%esi
	movl	-4780(%ebp), %edi
	leal	-4160(%edi), %edx
	pushl	%edx
	pushl	%eax
	call	strncmp
	addl	$16, %esp
	testl	%eax, %eax
	jne	.L91
	movl	logfile, %eax
	movl	%eax, -4784(%ebp)
	subl	$12, %esp
	movl	-4780(%ebp), %esi
	movl	%esi, %eax
	subl	$4160, %eax
	pushl	%eax
	call	strlen
	addl	$16, %esp
	movl	%eax, %edi
	movl	%esi, %eax
	leal	-4160(%eax), %ebx
	movl	%ebx, %edx
	movl	%edx, %eax
	shrl	$3, %eax
	addl	$536870912, %eax
	movzbl	(%eax), %ecx
	testb	%cl, %cl
	setne	%al
	movl	%eax, %esi
	movl	%edx, %eax
	andl	$7, %eax
	cmpb	%cl, %al
	setge	%al
	andl	%esi, %eax
	testb	%al, %al
	je	.L92
	subl	$12, %esp
	pushl	%edx
	call	__asan_report_load1
.L92:
	movl	%edi, %eax
	addl	%ebx, %eax
	movl	%eax, %edx
	movl	%edx, %eax
	shrl	$3, %eax
	addl	$536870912, %eax
	movzbl	(%eax), %ecx
	testb	%cl, %cl
	setne	%bl
	movl	%edx, %eax
	andl	$7, %eax
	cmpb	%cl, %al
	setge	%al
	andl	%ebx, %eax
	testb	%al, %al
	je	.L93
	subl	$12, %esp
	pushl	%edx
	call	__asan_report_load1
.L93:
	leal	-1(%edi), %eax
	movl	-4784(%ebp), %edx
	addl	%eax, %edx
	movl	logfile, %eax
	subl	$8, %esp
	pushl	%edx
	pushl	%eax
	call	strcpy
	addl	$16, %esp
	jmp	.L88
.L91:
	subl	$8, %esp
	pushl	$.LC29
	pushl	$4
	call	syslog
	addl	$16, %esp
	movl	argv0, %edi
	movl	$stderr, %eax
	movl	%eax, %edx
	shrl	$3, %edx
	addl	$536870912, %edx
	movzbl	(%edx), %edx
	testb	%dl, %dl
	setne	%bl
	movl	%eax, %esi
	andl	$7, %esi
	addl	$3, %esi
	movl	%esi, %ecx
	cmpb	%dl, %cl
	setge	%dl
	andl	%ebx, %edx
	testb	%dl, %dl
	je	.L94
	subl	$12, %esp
	pushl	%eax
	call	__asan_report_load4
.L94:
	movl	stderr, %eax
	subl	$4, %esp
	pushl	%edi
	pushl	$.LC30
	pushl	%eax
	call	fprintf
	addl	$16, %esp
.L88:
	movl	$.LC22, %eax
	movl	$2, %esi
	movl	%eax, %ebx
	movl	%ebx, %eax
	shrl	$3, %eax
	addl	$536870912, %eax
	movzbl	(%eax), %eax
	testb	%al, %al
	setne	%dl
	movl	%ebx, %ecx
	andl	$7, %ecx
	cmpb	%al, %cl
	setge	%al
	movl	%edx, %edi
	andl	%eax, %edi
	leal	-1(%esi), %eax
	leal	(%ebx,%eax), %edx
	movl	%edx, %eax
	shrl	$3, %eax
	addl	$536870912, %eax
	movzbl	(%eax), %ecx
	testb	%cl, %cl
	setne	-4784(%ebp)
	andl	$7, %edx
	movl	%edx, %eax
	cmpb	%cl, %al
	setge	%al
	andb	-4784(%ebp), %al
	orl	%edi, %eax
	testb	%al, %al
	je	.L95
	subl	$8, %esp
	pushl	%esi
	pushl	%ebx
	call	__asan_report_load_n
.L95:
	movl	-4780(%ebp), %eax
	subl	$4160, %eax
	movl	$2, %esi
	movl	%eax, %ebx
	movl	%ebx, %eax
	shrl	$3, %eax
	addl	$536870912, %eax
	movzbl	(%eax), %eax
	testb	%al, %al
	setne	%dl
	movl	%ebx, %ecx
	andl	$7, %ecx
	cmpb	%al, %cl
	setge	%al
	movl	%edx, %edi
	andl	%eax, %edi
	leal	-1(%esi), %eax
	leal	(%ebx,%eax), %edx
	movl	%edx, %eax
	shrl	$3, %eax
	addl	$536870912, %eax
	movzbl	(%eax), %ecx
	testb	%cl, %cl
	setne	-4784(%ebp)
	andl	$7, %edx
	movl	%edx, %eax
	cmpb	%cl, %al
	setge	%al
	andb	-4784(%ebp), %al
	orl	%edi, %eax
	testb	%al, %al
	je	.L96
	subl	$8, %esp
	pushl	%esi
	pushl	%ebx
	call	__asan_report_store_n
.L96:
	movl	-4780(%ebp), %edi
	movl	%edi, %eax
	subl	$4160, %eax
	movw	$47, (%eax)
	subl	$12, %esp
	movl	%edi, %eax
	subl	$4160, %eax
	pushl	%eax
	call	chdir
	addl	$16, %esp
	testl	%eax, %eax
	jns	.L86
	subl	$8, %esp
	pushl	$.LC31
	pushl	$2
	call	syslog
	addl	$16, %esp
	subl	$12, %esp
	pushl	$.LC32
	call	perror
	addl	$16, %esp
	call	__asan_handle_no_return
	subl	$12, %esp
	pushl	$1
	call	exit
.L86:
	movl	data_dir, %eax
	testl	%eax, %eax
	je	.L97
	movl	data_dir, %eax
	subl	$12, %esp
	pushl	%eax
	call	chdir
	addl	$16, %esp
	testl	%eax, %eax
	jns	.L97
	subl	$8, %esp
	pushl	$.LC33
	pushl	$2
	call	syslog
	addl	$16, %esp
	subl	$12, %esp
	pushl	$.LC34
	call	perror
	addl	$16, %esp
	call	__asan_handle_no_return
	subl	$12, %esp
	pushl	$1
	call	exit
.L97:
	subl	$8, %esp
	pushl	$handle_term
	pushl	$15
	call	sigset
	addl	$16, %esp
	subl	$8, %esp
	pushl	$handle_term
	pushl	$2
	call	sigset
	addl	$16, %esp
	subl	$8, %esp
	pushl	$handle_chld
	pushl	$17
	call	sigset
	addl	$16, %esp
	subl	$8, %esp
	pushl	$1
	pushl	$13
	call	sigset
	addl	$16, %esp
	subl	$8, %esp
	pushl	$handle_hup
	pushl	$1
	call	sigset
	addl	$16, %esp
	subl	$8, %esp
	pushl	$handle_usr1
	pushl	$10
	call	sigset
	addl	$16, %esp
	subl	$8, %esp
	pushl	$handle_usr2
	pushl	$12
	call	sigset
	addl	$16, %esp
	subl	$8, %esp
	pushl	$handle_alrm
	pushl	$14
	call	sigset
	addl	$16, %esp
	movl	$0, got_hup
	movl	$0, got_usr1
	movl	$0, watchdog_flag
	subl	$12, %esp
	pushl	$360
	call	alarm
	addl	$16, %esp
	call	tmr_init
	movl	no_empty_referers, %esi
	movl	local_pattern, %edi
	movl	url_pattern, %eax
	movl	%eax, -4784(%ebp)
	movl	do_global_passwd, %eax
	movl	%eax, -4788(%ebp)
	movl	do_vhost, %eax
	movl	%eax, -4792(%ebp)
	movl	no_symlink_check, %eax
	movl	%eax, -4796(%ebp)
	movl	no_log, %eax
	movl	%eax, -4800(%ebp)
	movl	max_age, %eax
	movl	%eax, -4804(%ebp)
	movl	p3p, %eax
	movl	%eax, -4808(%ebp)
	movl	charset, %eax
	movl	%eax, -4812(%ebp)
	movl	cgi_limit, %eax
	movl	%eax, -4816(%ebp)
	movl	cgi_pattern, %eax
	movl	%eax, -4820(%ebp)
	movzwl	port, %eax
	movzwl	%ax, %eax
	movl	%eax, -4824(%ebp)
	movl	-4780(%ebp), %eax
	movl	-4608(%eax), %eax
	testl	%eax, %eax
	je	.L98
	movl	-4780(%ebp), %eax
	leal	-4320(%eax), %ebx
	jmp	.L99
.L98:
	movl	$0, %ebx
.L99:
	movl	-4780(%ebp), %eax
	movl	-4672(%eax), %eax
	testl	%eax, %eax
	je	.L100
	movl	-4780(%ebp), %eax
	leal	-4480(%eax), %ecx
	jmp	.L101
.L100:
	movl	$0, %ecx
.L101:
	movl	hostname, %edx
	subl	$8, %esp
	pushl	%esi
	pushl	%edi
	pushl	-4784(%ebp)
	pushl	-4788(%ebp)
	pushl	-4792(%ebp)
	pushl	-4796(%ebp)
	pushl	-4760(%ebp)
	pushl	-4800(%ebp)
	movl	-4780(%ebp), %eax
	subl	$4160, %eax
	pushl	%eax
	pushl	-4804(%ebp)
	pushl	-4808(%ebp)
	pushl	-4812(%ebp)
	pushl	-4816(%ebp)
	pushl	-4820(%ebp)
	pushl	-4824(%ebp)
	pushl	%ebx
	pushl	%ecx
	pushl	%edx
	call	httpd_initialize
	addl	$80, %esp
	movl	%eax, hs
	movl	hs, %eax
	testl	%eax, %eax
	jne	.L102
	call	__asan_handle_no_return
	subl	$12, %esp
	pushl	$1
	call	exit
.L102:
	subl	$12, %esp
	pushl	$1
	pushl	$120000
	pushl	JunkClientData
	pushl	$occasional
	pushl	$0
	call	tmr_create
	addl	$32, %esp
	testl	%eax, %eax
	jne	.L103
	subl	$8, %esp
	pushl	$.LC35
	pushl	$2
	call	syslog
	addl	$16, %esp
	call	__asan_handle_no_return
	subl	$12, %esp
	pushl	$1
	call	exit
.L103:
	subl	$12, %esp
	pushl	$1
	pushl	$5000
	pushl	JunkClientData
	pushl	$idle
	pushl	$0
	call	tmr_create
	addl	$32, %esp
	testl	%eax, %eax
	jne	.L104
	subl	$8, %esp
	pushl	$.LC36
	pushl	$2
	call	syslog
	addl	$16, %esp
	call	__asan_handle_no_return
	subl	$12, %esp
	pushl	$1
	call	exit
.L104:
	movl	numthrottles, %eax
	testl	%eax, %eax
	jle	.L105
	subl	$12, %esp
	pushl	$1
	pushl	$2000
	pushl	JunkClientData
	pushl	$update_throttles
	pushl	$0
	call	tmr_create
	addl	$32, %esp
	testl	%eax, %eax
	jne	.L105
	subl	$8, %esp
	pushl	$.LC37
	pushl	$2
	call	syslog
	addl	$16, %esp
	call	__asan_handle_no_return
	subl	$12, %esp
	pushl	$1
	call	exit
.L105:
	subl	$12, %esp
	pushl	$1
	pushl	$3600000
	pushl	JunkClientData
	pushl	$show_stats
	pushl	$0
	call	tmr_create
	addl	$32, %esp
	testl	%eax, %eax
	jne	.L106
	subl	$8, %esp
	pushl	$.LC38
	pushl	$2
	call	syslog
	addl	$16, %esp
	call	__asan_handle_no_return
	subl	$12, %esp
	pushl	$1
	call	exit
.L106:
	subl	$12, %esp
	pushl	$0
	call	time
	addl	$16, %esp
	movl	%eax, stats_time
	movl	stats_time, %eax
	movl	%eax, start_time
	movl	$0, stats_connections
	movl	$0, stats_bytes
	movl	$0, stats_simultaneous
	call	getuid
	testl	%eax, %eax
	jne	.L107
	subl	$8, %esp
	pushl	$0
	pushl	$0
	call	setgroups
	addl	$16, %esp
	testl	%eax, %eax
	jns	.L108
	subl	$8, %esp
	pushl	$.LC39
	pushl	$2
	call	syslog
	addl	$16, %esp
	call	__asan_handle_no_return
	subl	$12, %esp
	pushl	$1
	call	exit
.L108:
	subl	$12, %esp
	pushl	-4764(%ebp)
	call	setgid
	addl	$16, %esp
	testl	%eax, %eax
	jns	.L109
	subl	$8, %esp
	pushl	$.LC40
	pushl	$2
	call	syslog
	addl	$16, %esp
	call	__asan_handle_no_return
	subl	$12, %esp
	pushl	$1
	call	exit
.L109:
	movl	user, %eax
	subl	$8, %esp
	pushl	-4764(%ebp)
	pushl	%eax
	call	initgroups
	addl	$16, %esp
	testl	%eax, %eax
	jns	.L110
	subl	$8, %esp
	pushl	$.LC41
	pushl	$4
	call	syslog
	addl	$16, %esp
.L110:
	subl	$12, %esp
	pushl	-4768(%ebp)
	call	setuid
	addl	$16, %esp
	testl	%eax, %eax
	jns	.L111
	subl	$8, %esp
	pushl	$.LC42
	pushl	$2
	call	syslog
	addl	$16, %esp
	call	__asan_handle_no_return
	subl	$12, %esp
	pushl	$1
	call	exit
.L111:
	movl	do_chroot, %eax
	testl	%eax, %eax
	jne	.L107
	subl	$8, %esp
	pushl	$.LC43
	pushl	$4
	call	syslog
	addl	$16, %esp
.L107:
	movl	max_connects, %eax
	movl	%eax, %edx
	movl	%edx, %eax
	addl	%eax, %eax
	addl	%edx, %eax
	sall	$5, %eax
	subl	$12, %esp
	pushl	%eax
	call	malloc
	addl	$16, %esp
	movl	%eax, connects
	movl	connects, %eax
	testl	%eax, %eax
	jne	.L112
	subl	$8, %esp
	pushl	$.LC44
	pushl	$2
	call	syslog
	addl	$16, %esp
	call	__asan_handle_no_return
	subl	$12, %esp
	pushl	$1
	call	exit
.L112:
	movl	$0, -4756(%ebp)
	jmp	.L113
.L117:
	movl	connects, %ecx
	movl	-4756(%ebp), %edx
	movl	%edx, %eax
	addl	%eax, %eax
	addl	%edx, %eax
	sall	$5, %eax
	addl	%eax, %ecx
	movl	%ecx, %eax
	movl	%eax, %edx
	shrl	$3, %edx
	addl	$536870912, %edx
	movzbl	(%edx), %edx
	testb	%dl, %dl
	setne	%bl
	movl	%ebx, %edi
	movl	%eax, %esi
	andl	$7, %esi
	addl	$3, %esi
	movl	%esi, %ebx
	cmpb	%dl, %bl
	setge	%dl
	andl	%edi, %edx
	testb	%dl, %dl
	je	.L114
	subl	$12, %esp
	pushl	%eax
	call	__asan_report_store4
.L114:
	movl	$0, (%ecx)
	movl	connects, %ecx
	movl	-4756(%ebp), %edx
	movl	%edx, %eax
	addl	%eax, %eax
	addl	%edx, %eax
	sall	$5, %eax
	addl	%eax, %ecx
	movl	-4756(%ebp), %eax
	leal	1(%eax), %esi
	leal	4(%ecx), %eax
	movl	%eax, %edx
	movl	%edx, %eax
	shrl	$3, %eax
	addl	$536870912, %eax
	movzbl	(%eax), %ebx
	testb	%bl, %bl
	setne	%al
	movl	%eax, %edi
	movl	%edx, %eax
	andl	$7, %eax
	addl	$3, %eax
	cmpb	%bl, %al
	setge	%al
	andl	%edi, %eax
	testb	%al, %al
	je	.L115
	subl	$12, %esp
	pushl	%edx
	call	__asan_report_store4
.L115:
	movl	%esi, 4(%ecx)
	movl	connects, %ecx
	movl	-4756(%ebp), %edx
	movl	%edx, %eax
	addl	%eax, %eax
	addl	%edx, %eax
	sall	$5, %eax
	leal	(%ecx,%eax), %edx
	leal	8(%edx), %eax
	movl	%eax, %ecx
	shrl	$3, %ecx
	addl	$536870912, %ecx
	movzbl	(%ecx), %ecx
	testb	%cl, %cl
	setne	%bl
	movl	%ebx, %edi
	movl	%eax, %esi
	andl	$7, %esi
	addl	$3, %esi
	movl	%esi, %ebx
	cmpb	%cl, %bl
	setge	%cl
	andl	%edi, %ecx
	testb	%cl, %cl
	je	.L116
	subl	$12, %esp
	pushl	%eax
	call	__asan_report_store4
.L116:
	movl	$0, 8(%edx)
	addl	$1, -4756(%ebp)
.L113:
	movl	max_connects, %eax
	cmpl	%eax, -4756(%ebp)
	jl	.L117
	movl	connects, %edx
	movl	max_connects, %eax
	movl	%eax, %ecx
	movl	%ecx, %eax
	addl	%eax, %eax
	addl	%ecx, %eax
	sall	$5, %eax
	subl	$96, %eax
	addl	%eax, %edx
	leal	4(%edx), %eax
	movl	%eax, %ecx
	shrl	$3, %ecx
	addl	$536870912, %ecx
	movzbl	(%ecx), %ecx
	testb	%cl, %cl
	setne	%bl
	movl	%ebx, %edi
	movl	%eax, %esi
	andl	$7, %esi
	addl	$3, %esi
	movl	%esi, %ebx
	cmpb	%cl, %bl
	setge	%cl
	andl	%edi, %ecx
	testb	%cl, %cl
	je	.L118
	subl	$12, %esp
	pushl	%eax
	call	__asan_report_store4
.L118:
	movl	$-1, 4(%edx)
	movl	$0, first_free_connect
	movl	$0, num_connects
	movl	$0, httpd_conn_count
	movl	hs, %eax
	testl	%eax, %eax
	je	.L119
	movl	hs, %edx
	leal	40(%edx), %eax
	movl	%eax, %ecx
	shrl	$3, %ecx
	addl	$536870912, %ecx
	movzbl	(%ecx), %ecx
	testb	%cl, %cl
	setne	%bl
	movl	%ebx, %edi
	movl	%eax, %esi
	andl	$7, %esi
	addl	$3, %esi
	movl	%esi, %ebx
	cmpb	%cl, %bl
	setge	%cl
	andl	%edi, %ecx
	testb	%cl, %cl
	je	.L120
	subl	$12, %esp
	pushl	%eax
	call	__asan_report_load4
.L120:
	movl	40(%edx), %eax
	cmpl	$-1, %eax
	je	.L121
	movl	hs, %edx
	leal	40(%edx), %eax
	movl	%eax, %ecx
	shrl	$3, %ecx
	addl	$536870912, %ecx
	movzbl	(%ecx), %ecx
	testb	%cl, %cl
	setne	%bl
	movl	%ebx, %edi
	movl	%eax, %esi
	andl	$7, %esi
	addl	$3, %esi
	movl	%esi, %ebx
	cmpb	%cl, %bl
	setge	%cl
	andl	%edi, %ecx
	testb	%cl, %cl
	je	.L122
	subl	$12, %esp
	pushl	%eax
	call	__asan_report_load4
.L122:
	movl	40(%edx), %eax
	subl	$4, %esp
	pushl	$0
	pushl	$0
	pushl	%eax
	call	fdwatch_add_fd
	addl	$16, %esp
.L121:
	movl	hs, %edx
	leal	44(%edx), %eax
	movl	%eax, %ecx
	shrl	$3, %ecx
	addl	$536870912, %ecx
	movzbl	(%ecx), %ecx
	testb	%cl, %cl
	setne	%bl
	movl	%ebx, %edi
	movl	%eax, %esi
	andl	$7, %esi
	addl	$3, %esi
	movl	%esi, %ebx
	cmpb	%cl, %bl
	setge	%cl
	andl	%edi, %ecx
	testb	%cl, %cl
	je	.L123
	subl	$12, %esp
	pushl	%eax
	call	__asan_report_load4
.L123:
	movl	44(%edx), %eax
	cmpl	$-1, %eax
	je	.L119
	movl	hs, %edx
	leal	44(%edx), %eax
	movl	%eax, %ecx
	shrl	$3, %ecx
	addl	$536870912, %ecx
	movzbl	(%ecx), %ecx
	testb	%cl, %cl
	setne	%bl
	movl	%ebx, %edi
	movl	%eax, %esi
	andl	$7, %esi
	addl	$3, %esi
	movl	%esi, %ebx
	cmpb	%cl, %bl
	setge	%cl
	andl	%edi, %ecx
	testb	%cl, %cl
	je	.L124
	subl	$12, %esp
	pushl	%eax
	call	__asan_report_load4
.L124:
	movl	44(%edx), %eax
	subl	$4, %esp
	pushl	$0
	pushl	$0
	pushl	%eax
	call	fdwatch_add_fd
	addl	$16, %esp
.L119:
	subl	$12, %esp
	movl	-4780(%ebp), %eax
	subl	$4544, %eax
	pushl	%eax
	call	tmr_prepare_timeval
	addl	$16, %esp
	jmp	.L125
.L157:
	movl	got_hup, %eax
	testl	%eax, %eax
	je	.L126
	call	re_open_logfile
	movl	$0, got_hup
.L126:
	subl	$12, %esp
	movl	-4780(%ebp), %eax
	subl	$4544, %eax
	pushl	%eax
	call	tmr_mstimeout
	addl	$16, %esp
	subl	$12, %esp
	pushl	%eax
	call	fdwatch
	addl	$16, %esp
	movl	%eax, -4740(%ebp)
	cmpl	$0, -4740(%ebp)
	jns	.L127
	call	__errno_location
	movl	%eax, %ecx
	movl	%ecx, %eax
	movl	%eax, %edx
	shrl	$3, %edx
	addl	$536870912, %edx
	movzbl	(%edx), %edx
	testb	%dl, %dl
	setne	%bl
	movl	%ebx, %edi
	movl	%eax, %esi
	andl	$7, %esi
	addl	$3, %esi
	movl	%esi, %ebx
	cmpb	%dl, %bl
	setge	%dl
	andl	%edi, %edx
	testb	%dl, %dl
	je	.L128
	subl	$12, %esp
	pushl	%eax
	call	__asan_report_load4
.L128:
	movl	(%ecx), %eax
	cmpl	$4, %eax
	je	.L129
	call	__errno_location
	movl	%eax, %ecx
	movl	%ecx, %eax
	movl	%eax, %edx
	shrl	$3, %edx
	addl	$536870912, %edx
	movzbl	(%edx), %edx
	testb	%dl, %dl
	setne	%bl
	movl	%ebx, %edi
	movl	%eax, %esi
	andl	$7, %esi
	addl	$3, %esi
	movl	%esi, %ebx
	cmpb	%dl, %bl
	setge	%dl
	andl	%edi, %edx
	testb	%dl, %dl
	je	.L130
	subl	$12, %esp
	pushl	%eax
	call	__asan_report_load4
.L130:
	movl	(%ecx), %eax
	cmpl	$11, %eax
	jne	.L131
.L129:
	jmp	.L125
.L131:
	subl	$8, %esp
	pushl	$.LC45
	pushl	$3
	call	syslog
	addl	$16, %esp
	call	__asan_handle_no_return
	subl	$12, %esp
	pushl	$1
	call	exit
.L127:
	subl	$12, %esp
	movl	-4780(%ebp), %eax
	subl	$4544, %eax
	pushl	%eax
	call	tmr_prepare_timeval
	addl	$16, %esp
	cmpl	$0, -4740(%ebp)
	jne	.L132
	subl	$12, %esp
	movl	-4780(%ebp), %eax
	subl	$4544, %eax
	pushl	%eax
	call	tmr_run
	addl	$16, %esp
	jmp	.L125
.L132:
	movl	hs, %eax
	testl	%eax, %eax
	je	.L133
	movl	hs, %edx
	leal	44(%edx), %eax
	movl	%eax, %ecx
	shrl	$3, %ecx
	addl	$536870912, %ecx
	movzbl	(%ecx), %ecx
	testb	%cl, %cl
	setne	%bl
	movl	%ebx, %edi
	movl	%eax, %esi
	andl	$7, %esi
	addl	$3, %esi
	movl	%esi, %ebx
	cmpb	%cl, %bl
	setge	%cl
	andl	%edi, %ecx
	testb	%cl, %cl
	je	.L134
	subl	$12, %esp
	pushl	%eax
	call	__asan_report_load4
.L134:
	movl	44(%edx), %eax
	cmpl	$-1, %eax
	je	.L133
	movl	hs, %edx
	leal	44(%edx), %eax
	movl	%eax, %ecx
	shrl	$3, %ecx
	addl	$536870912, %ecx
	movzbl	(%ecx), %ecx
	testb	%cl, %cl
	setne	%bl
	movl	%ebx, %edi
	movl	%eax, %esi
	andl	$7, %esi
	addl	$3, %esi
	movl	%esi, %ebx
	cmpb	%cl, %bl
	setge	%cl
	andl	%edi, %ecx
	testb	%cl, %cl
	je	.L135
	subl	$12, %esp
	pushl	%eax
	call	__asan_report_load4
.L135:
	movl	44(%edx), %eax
	subl	$12, %esp
	pushl	%eax
	call	fdwatch_check_fd
	addl	$16, %esp
	testl	%eax, %eax
	je	.L133
	movl	hs, %edx
	leal	44(%edx), %eax
	movl	%eax, %ecx
	shrl	$3, %ecx
	addl	$536870912, %ecx
	movzbl	(%ecx), %ecx
	testb	%cl, %cl
	setne	%bl
	movl	%ebx, %edi
	movl	%eax, %esi
	andl	$7, %esi
	addl	$3, %esi
	movl	%esi, %ebx
	cmpb	%cl, %bl
	setge	%cl
	andl	%edi, %ecx
	testb	%cl, %cl
	je	.L136
	subl	$12, %esp
	pushl	%eax
	call	__asan_report_load4
.L136:
	movl	44(%edx), %eax
	subl	$8, %esp
	pushl	%eax
	movl	-4780(%ebp), %eax
	subl	$4544, %eax
	pushl	%eax
	call	handle_newconnect
	addl	$16, %esp
	testl	%eax, %eax
	je	.L133
	jmp	.L125
.L133:
	movl	hs, %eax
	testl	%eax, %eax
	je	.L137
	movl	hs, %edx
	leal	40(%edx), %eax
	movl	%eax, %ecx
	shrl	$3, %ecx
	addl	$536870912, %ecx
	movzbl	(%ecx), %ecx
	testb	%cl, %cl
	setne	%bl
	movl	%ebx, %edi
	movl	%eax, %esi
	andl	$7, %esi
	addl	$3, %esi
	movl	%esi, %ebx
	cmpb	%cl, %bl
	setge	%cl
	andl	%edi, %ecx
	testb	%cl, %cl
	je	.L138
	subl	$12, %esp
	pushl	%eax
	call	__asan_report_load4
.L138:
	movl	40(%edx), %eax
	cmpl	$-1, %eax
	je	.L137
	movl	hs, %edx
	leal	40(%edx), %eax
	movl	%eax, %ecx
	shrl	$3, %ecx
	addl	$536870912, %ecx
	movzbl	(%ecx), %ecx
	testb	%cl, %cl
	setne	%bl
	movl	%ebx, %edi
	movl	%eax, %esi
	andl	$7, %esi
	addl	$3, %esi
	movl	%esi, %ebx
	cmpb	%cl, %bl
	setge	%cl
	andl	%edi, %ecx
	testb	%cl, %cl
	je	.L139
	subl	$12, %esp
	pushl	%eax
	call	__asan_report_load4
.L139:
	movl	40(%edx), %eax
	subl	$12, %esp
	pushl	%eax
	call	fdwatch_check_fd
	addl	$16, %esp
	testl	%eax, %eax
	je	.L137
	movl	hs, %edx
	leal	40(%edx), %eax
	movl	%eax, %ecx
	shrl	$3, %ecx
	addl	$536870912, %ecx
	movzbl	(%ecx), %ecx
	testb	%cl, %cl
	setne	%bl
	movl	%ebx, %edi
	movl	%eax, %esi
	andl	$7, %esi
	addl	$3, %esi
	movl	%esi, %ebx
	cmpb	%cl, %bl
	setge	%cl
	andl	%edi, %ecx
	testb	%cl, %cl
	je	.L140
	subl	$12, %esp
	pushl	%eax
	call	__asan_report_load4
.L140:
	movl	40(%edx), %eax
	subl	$8, %esp
	pushl	%eax
	movl	-4780(%ebp), %eax
	subl	$4544, %eax
	pushl	%eax
	call	handle_newconnect
	addl	$16, %esp
	testl	%eax, %eax
	je	.L137
	jmp	.L125
.L137:
	jmp	.L141
.L150:
	cmpl	$0, -4736(%ebp)
	jne	.L142
	jmp	.L141
.L142:
	movl	-4736(%ebp), %eax
	addl	$8, %eax
	movl	%eax, %edx
	shrl	$3, %edx
	addl	$536870912, %edx
	movzbl	(%edx), %edx
	testb	%dl, %dl
	setne	%cl
	movl	%eax, %ebx
	andl	$7, %ebx
	addl	$3, %ebx
	cmpb	%dl, %bl
	setge	%dl
	andl	%ecx, %edx
	testb	%dl, %dl
	je	.L143
	subl	$12, %esp
	pushl	%eax
	call	__asan_report_load4
.L143:
	movl	-4736(%ebp), %eax
	movl	8(%eax), %eax
	movl	%eax, -4732(%ebp)
	movl	-4732(%ebp), %eax
	addl	$448, %eax
	movl	%eax, %edx
	shrl	$3, %edx
	addl	$536870912, %edx
	movzbl	(%edx), %edx
	testb	%dl, %dl
	setne	%cl
	movl	%eax, %ebx
	andl	$7, %ebx
	addl	$3, %ebx
	cmpb	%dl, %bl
	setge	%dl
	andl	%ecx, %edx
	testb	%dl, %dl
	je	.L144
	subl	$12, %esp
	pushl	%eax
	call	__asan_report_load4
.L144:
	movl	-4732(%ebp), %eax
	movl	448(%eax), %eax
	subl	$12, %esp
	pushl	%eax
	call	fdwatch_check_fd
	addl	$16, %esp
	testl	%eax, %eax
	jne	.L145
	subl	$8, %esp
	movl	-4780(%ebp), %eax
	subl	$4544, %eax
	pushl	%eax
	pushl	-4736(%ebp)
	call	clear_connection
	addl	$16, %esp
	jmp	.L141
.L145:
	movl	-4736(%ebp), %eax
	movl	%eax, %edx
	shrl	$3, %edx
	addl	$536870912, %edx
	movzbl	(%edx), %edx
	testb	%dl, %dl
	setne	%cl
	movl	%eax, %ebx
	andl	$7, %ebx
	addl	$3, %ebx
	cmpb	%dl, %bl
	setge	%dl
	andl	%ecx, %edx
	testb	%dl, %dl
	je	.L146
	subl	$12, %esp
	pushl	%eax
	call	__asan_report_load4
.L146:
	movl	-4736(%ebp), %eax
	movl	(%eax), %eax
	cmpl	$2, %eax
	je	.L147
	cmpl	$4, %eax
	je	.L148
	cmpl	$1, %eax
	je	.L149
	jmp	.L141
.L149:
	subl	$8, %esp
	movl	-4780(%ebp), %eax
	subl	$4544, %eax
	pushl	%eax
	pushl	-4736(%ebp)
	call	handle_read
	addl	$16, %esp
	jmp	.L141
.L147:
	subl	$8, %esp
	movl	-4780(%ebp), %eax
	subl	$4544, %eax
	pushl	%eax
	pushl	-4736(%ebp)
	call	handle_send
	addl	$16, %esp
	jmp	.L141
.L148:
	subl	$8, %esp
	movl	-4780(%ebp), %eax
	subl	$4544, %eax
	pushl	%eax
	pushl	-4736(%ebp)
	call	handle_linger
	addl	$16, %esp
	nop
.L141:
	call	fdwatch_get_next_client_data
	movl	%eax, -4736(%ebp)
	cmpl	$-1, -4736(%ebp)
	jne	.L150
	subl	$12, %esp
	movl	-4780(%ebp), %eax
	subl	$4544, %eax
	pushl	%eax
	call	tmr_run
	addl	$16, %esp
	movl	got_usr1, %eax
	testl	%eax, %eax
	je	.L125
	movl	terminate, %eax
	testl	%eax, %eax
	jne	.L125
	movl	$1, terminate
	movl	hs, %eax
	testl	%eax, %eax
	je	.L125
	movl	hs, %edx
	leal	40(%edx), %eax
	movl	%eax, %ecx
	shrl	$3, %ecx
	addl	$536870912, %ecx
	movzbl	(%ecx), %ecx
	testb	%cl, %cl
	setne	%bl
	movl	%ebx, %edi
	movl	%eax, %esi
	andl	$7, %esi
	addl	$3, %esi
	movl	%esi, %ebx
	cmpb	%cl, %bl
	setge	%cl
	andl	%edi, %ecx
	testb	%cl, %cl
	je	.L151
	subl	$12, %esp
	pushl	%eax
	call	__asan_report_load4
.L151:
	movl	40(%edx), %eax
	cmpl	$-1, %eax
	je	.L152
	movl	hs, %edx
	leal	40(%edx), %eax
	movl	%eax, %ecx
	shrl	$3, %ecx
	addl	$536870912, %ecx
	movzbl	(%ecx), %ecx
	testb	%cl, %cl
	setne	%bl
	movl	%ebx, %edi
	movl	%eax, %esi
	andl	$7, %esi
	addl	$3, %esi
	movl	%esi, %ebx
	cmpb	%cl, %bl
	setge	%cl
	andl	%edi, %ecx
	testb	%cl, %cl
	je	.L153
	subl	$12, %esp
	pushl	%eax
	call	__asan_report_load4
.L153:
	movl	40(%edx), %eax
	subl	$12, %esp
	pushl	%eax
	call	fdwatch_del_fd
	addl	$16, %esp
.L152:
	movl	hs, %edx
	leal	44(%edx), %eax
	movl	%eax, %ecx
	shrl	$3, %ecx
	addl	$536870912, %ecx
	movzbl	(%ecx), %ecx
	testb	%cl, %cl
	setne	%bl
	movl	%ebx, %edi
	movl	%eax, %esi
	andl	$7, %esi
	addl	$3, %esi
	movl	%esi, %ebx
	cmpb	%cl, %bl
	setge	%cl
	andl	%edi, %ecx
	testb	%cl, %cl
	je	.L154
	subl	$12, %esp
	pushl	%eax
	call	__asan_report_load4
.L154:
	movl	44(%edx), %eax
	cmpl	$-1, %eax
	je	.L155
	movl	hs, %edx
	leal	44(%edx), %eax
	movl	%eax, %ecx
	shrl	$3, %ecx
	addl	$536870912, %ecx
	movzbl	(%ecx), %ecx
	testb	%cl, %cl
	setne	%bl
	movl	%ebx, %edi
	movl	%eax, %esi
	andl	$7, %esi
	addl	$3, %esi
	movl	%esi, %ebx
	cmpb	%cl, %bl
	setge	%cl
	andl	%edi, %ecx
	testb	%cl, %cl
	je	.L156
	subl	$12, %esp
	pushl	%eax
	call	__asan_report_load4
.L156:
	movl	44(%edx), %eax
	subl	$12, %esp
	pushl	%eax
	call	fdwatch_del_fd
	addl	$16, %esp
.L155:
	movl	hs, %eax
	subl	$12, %esp
	pushl	%eax
	call	httpd_unlisten
	addl	$16, %esp
.L125:
	movl	terminate, %eax
	testl	%eax, %eax
	je	.L157
	movl	num_connects, %eax
	testl	%eax, %eax
	jg	.L157
	call	shut_down
	subl	$8, %esp
	pushl	$.LC3
	pushl	$5
	call	syslog
	addl	$16, %esp
	call	closelog
	call	__asan_handle_no_return
	subl	$12, %esp
	pushl	$0
	call	exit
	.size	main, .-main
	.section	.rodata
	.align 32
.LC46:
	.string	"nobody"
	.zero	57
	.align 32
.LC47:
	.string	"iso-8859-1"
	.zero	53
	.align 32
.LC48:
	.string	""
	.zero	63
	.align 32
.LC49:
	.string	"-V"
	.zero	61
	.align 32
.LC50:
	.string	"thttpd/2.27.0 Oct 3, 2014"
	.zero	38
	.align 32
.LC51:
	.string	"-C"
	.zero	61
	.align 32
.LC52:
	.string	"-p"
	.zero	61
	.align 32
.LC53:
	.string	"-d"
	.zero	61
	.align 32
.LC54:
	.string	"-r"
	.zero	61
	.align 32
.LC55:
	.string	"-nor"
	.zero	59
	.align 32
.LC56:
	.string	"-dd"
	.zero	60
	.align 32
.LC57:
	.string	"-s"
	.zero	61
	.align 32
.LC58:
	.string	"-nos"
	.zero	59
	.align 32
.LC59:
	.string	"-u"
	.zero	61
	.align 32
.LC60:
	.string	"-c"
	.zero	61
	.align 32
.LC61:
	.string	"-t"
	.zero	61
	.align 32
.LC62:
	.string	"-h"
	.zero	61
	.align 32
.LC63:
	.string	"-l"
	.zero	61
	.align 32
.LC64:
	.string	"-v"
	.zero	61
	.align 32
.LC65:
	.string	"-nov"
	.zero	59
	.align 32
.LC66:
	.string	"-g"
	.zero	61
	.align 32
.LC67:
	.string	"-nog"
	.zero	59
	.align 32
.LC68:
	.string	"-i"
	.zero	61
	.align 32
.LC69:
	.string	"-T"
	.zero	61
	.align 32
.LC70:
	.string	"-P"
	.zero	61
	.align 32
.LC71:
	.string	"-M"
	.zero	61
	.align 32
.LC72:
	.string	"-D"
	.zero	61
	.text
	.type	parse_args, @function
parse_args:
.LASANPC8:
	pushl	%ebp
	movl	%esp, %ebp
	pushl	%edi
	pushl	%esi
	pushl	%ebx
	subl	$28, %esp
	movl	$0, debug
	movw	$80, port
	movl	$0, dir
	movl	$0, data_dir
	movl	$0, do_chroot
	movl	$0, no_log
	movl	do_chroot, %eax
	movl	%eax, no_symlink_check
	movl	$0, do_vhost
	movl	$0, do_global_passwd
	movl	$0, cgi_pattern
	movl	$0, cgi_limit
	movl	$0, url_pattern
	movl	$0, no_empty_referers
	movl	$0, local_pattern
	movl	$0, throttlefile
	movl	$0, hostname
	movl	$0, logfile
	movl	$0, pidfile
	movl	$.LC46, user
	movl	$.LC47, charset
	movl	$.LC48, p3p
	movl	$-1, max_age
	movl	$1, -28(%ebp)
	jmp	.L159
.L223:
	movl	-28(%ebp), %eax
	leal	0(,%eax,4), %edx
	movl	12(%ebp), %eax
	leal	(%edx,%eax), %ecx
	movl	%ecx, %eax
	movl	%eax, %edx
	shrl	$3, %edx
	addl	$536870912, %edx
	movzbl	(%edx), %edx
	testb	%dl, %dl
	setne	%bl
	movl	%ebx, %edi
	movl	%eax, %esi
	andl	$7, %esi
	addl	$3, %esi
	movl	%esi, %ebx
	cmpb	%dl, %bl
	setge	%dl
	andl	%edi, %edx
	testb	%dl, %dl
	je	.L160
	subl	$12, %esp
	pushl	%eax
	call	__asan_report_load4
.L160:
	movl	(%ecx), %eax
	subl	$8, %esp
	pushl	$.LC49
	pushl	%eax
	call	strcmp
	addl	$16, %esp
	testl	%eax, %eax
	jne	.L161
	subl	$12, %esp
	pushl	$.LC50
	call	puts
	addl	$16, %esp
	call	__asan_handle_no_return
	subl	$12, %esp
	pushl	$0
	call	exit
.L161:
	movl	-28(%ebp), %eax
	leal	0(,%eax,4), %edx
	movl	12(%ebp), %eax
	leal	(%edx,%eax), %ecx
	movl	%ecx, %eax
	movl	%eax, %edx
	shrl	$3, %edx
	addl	$536870912, %edx
	movzbl	(%edx), %edx
	testb	%dl, %dl
	setne	%bl
	movl	%ebx, %edi
	movl	%eax, %esi
	andl	$7, %esi
	addl	$3, %esi
	movl	%esi, %ebx
	cmpb	%dl, %bl
	setge	%dl
	andl	%edi, %edx
	testb	%dl, %dl
	je	.L162
	subl	$12, %esp
	pushl	%eax
	call	__asan_report_load4
.L162:
	movl	(%ecx), %eax
	subl	$8, %esp
	pushl	$.LC51
	pushl	%eax
	call	strcmp
	addl	$16, %esp
	testl	%eax, %eax
	jne	.L163
	movl	-28(%ebp), %eax
	addl	$1, %eax
	cmpl	8(%ebp), %eax
	jge	.L163
	addl	$1, -28(%ebp)
	movl	-28(%ebp), %eax
	leal	0(,%eax,4), %edx
	movl	12(%ebp), %eax
	leal	(%edx,%eax), %ecx
	movl	%ecx, %eax
	movl	%eax, %edx
	shrl	$3, %edx
	addl	$536870912, %edx
	movzbl	(%edx), %edx
	testb	%dl, %dl
	setne	%bl
	movl	%ebx, %edi
	movl	%eax, %esi
	andl	$7, %esi
	addl	$3, %esi
	movl	%esi, %ebx
	cmpb	%dl, %bl
	setge	%dl
	andl	%edi, %edx
	testb	%dl, %dl
	je	.L164
	subl	$12, %esp
	pushl	%eax
	call	__asan_report_load4
.L164:
	movl	(%ecx), %eax
	subl	$12, %esp
	pushl	%eax
	call	read_config
	addl	$16, %esp
	jmp	.L165
.L163:
	movl	-28(%ebp), %eax
	leal	0(,%eax,4), %edx
	movl	12(%ebp), %eax
	leal	(%edx,%eax), %ecx
	movl	%ecx, %eax
	movl	%eax, %edx
	shrl	$3, %edx
	addl	$536870912, %edx
	movzbl	(%edx), %edx
	testb	%dl, %dl
	setne	%bl
	movl	%ebx, %edi
	movl	%eax, %esi
	andl	$7, %esi
	addl	$3, %esi
	movl	%esi, %ebx
	cmpb	%dl, %bl
	setge	%dl
	andl	%edi, %edx
	testb	%dl, %dl
	je	.L166
	subl	$12, %esp
	pushl	%eax
	call	__asan_report_load4
.L166:
	movl	(%ecx), %eax
	subl	$8, %esp
	pushl	$.LC52
	pushl	%eax
	call	strcmp
	addl	$16, %esp
	testl	%eax, %eax
	jne	.L167
	movl	-28(%ebp), %eax
	addl	$1, %eax
	cmpl	8(%ebp), %eax
	jge	.L167
	addl	$1, -28(%ebp)
	movl	-28(%ebp), %eax
	leal	0(,%eax,4), %edx
	movl	12(%ebp), %eax
	leal	(%edx,%eax), %ecx
	movl	%ecx, %eax
	movl	%eax, %edx
	shrl	$3, %edx
	addl	$536870912, %edx
	movzbl	(%edx), %edx
	testb	%dl, %dl
	setne	%bl
	movl	%ebx, %edi
	movl	%eax, %esi
	andl	$7, %esi
	addl	$3, %esi
	movl	%esi, %ebx
	cmpb	%dl, %bl
	setge	%dl
	andl	%edi, %edx
	testb	%dl, %dl
	je	.L168
	subl	$12, %esp
	pushl	%eax
	call	__asan_report_load4
.L168:
	movl	(%ecx), %eax
	subl	$12, %esp
	pushl	%eax
	call	atoi
	addl	$16, %esp
	movw	%ax, port
	jmp	.L165
.L167:
	movl	-28(%ebp), %eax
	leal	0(,%eax,4), %edx
	movl	12(%ebp), %eax
	leal	(%edx,%eax), %ecx
	movl	%ecx, %eax
	movl	%eax, %edx
	shrl	$3, %edx
	addl	$536870912, %edx
	movzbl	(%edx), %edx
	testb	%dl, %dl
	setne	%bl
	movl	%ebx, %edi
	movl	%eax, %esi
	andl	$7, %esi
	addl	$3, %esi
	movl	%esi, %ebx
	cmpb	%dl, %bl
	setge	%dl
	andl	%edi, %edx
	testb	%dl, %dl
	je	.L169
	subl	$12, %esp
	pushl	%eax
	call	__asan_report_load4
.L169:
	movl	(%ecx), %eax
	subl	$8, %esp
	pushl	$.LC53
	pushl	%eax
	call	strcmp
	addl	$16, %esp
	testl	%eax, %eax
	jne	.L170
	movl	-28(%ebp), %eax
	addl	$1, %eax
	cmpl	8(%ebp), %eax
	jge	.L170
	addl	$1, -28(%ebp)
	movl	-28(%ebp), %eax
	leal	0(,%eax,4), %edx
	movl	12(%ebp), %eax
	leal	(%edx,%eax), %ecx
	movl	%ecx, %eax
	movl	%eax, %edx
	shrl	$3, %edx
	addl	$536870912, %edx
	movzbl	(%edx), %edx
	testb	%dl, %dl
	setne	%bl
	movl	%ebx, %edi
	movl	%eax, %esi
	andl	$7, %esi
	addl	$3, %esi
	movl	%esi, %ebx
	cmpb	%dl, %bl
	setge	%dl
	andl	%edi, %edx
	testb	%dl, %dl
	je	.L171
	subl	$12, %esp
	pushl	%eax
	call	__asan_report_load4
.L171:
	movl	(%ecx), %eax
	movl	%eax, dir
	jmp	.L165
.L170:
	movl	-28(%ebp), %eax
	leal	0(,%eax,4), %edx
	movl	12(%ebp), %eax
	leal	(%edx,%eax), %ecx
	movl	%ecx, %eax
	movl	%eax, %edx
	shrl	$3, %edx
	addl	$536870912, %edx
	movzbl	(%edx), %edx
	testb	%dl, %dl
	setne	%bl
	movl	%ebx, %edi
	movl	%eax, %esi
	andl	$7, %esi
	addl	$3, %esi
	movl	%esi, %ebx
	cmpb	%dl, %bl
	setge	%dl
	andl	%edi, %edx
	testb	%dl, %dl
	je	.L172
	subl	$12, %esp
	pushl	%eax
	call	__asan_report_load4
.L172:
	movl	(%ecx), %eax
	subl	$8, %esp
	pushl	$.LC54
	pushl	%eax
	call	strcmp
	addl	$16, %esp
	testl	%eax, %eax
	jne	.L173
	movl	$1, do_chroot
	movl	$1, no_symlink_check
	jmp	.L165
.L173:
	movl	-28(%ebp), %eax
	leal	0(,%eax,4), %edx
	movl	12(%ebp), %eax
	leal	(%edx,%eax), %ecx
	movl	%ecx, %eax
	movl	%eax, %edx
	shrl	$3, %edx
	addl	$536870912, %edx
	movzbl	(%edx), %edx
	testb	%dl, %dl
	setne	%bl
	movl	%ebx, %edi
	movl	%eax, %esi
	andl	$7, %esi
	addl	$3, %esi
	movl	%esi, %ebx
	cmpb	%dl, %bl
	setge	%dl
	andl	%edi, %edx
	testb	%dl, %dl
	je	.L174
	subl	$12, %esp
	pushl	%eax
	call	__asan_report_load4
.L174:
	movl	(%ecx), %eax
	subl	$8, %esp
	pushl	$.LC55
	pushl	%eax
	call	strcmp
	addl	$16, %esp
	testl	%eax, %eax
	jne	.L175
	movl	$0, do_chroot
	movl	$0, no_symlink_check
	jmp	.L165
.L175:
	movl	-28(%ebp), %eax
	leal	0(,%eax,4), %edx
	movl	12(%ebp), %eax
	leal	(%edx,%eax), %ecx
	movl	%ecx, %eax
	movl	%eax, %edx
	shrl	$3, %edx
	addl	$536870912, %edx
	movzbl	(%edx), %edx
	testb	%dl, %dl
	setne	%bl
	movl	%ebx, %edi
	movl	%eax, %esi
	andl	$7, %esi
	addl	$3, %esi
	movl	%esi, %ebx
	cmpb	%dl, %bl
	setge	%dl
	andl	%edi, %edx
	testb	%dl, %dl
	je	.L176
	subl	$12, %esp
	pushl	%eax
	call	__asan_report_load4
.L176:
	movl	(%ecx), %eax
	subl	$8, %esp
	pushl	$.LC56
	pushl	%eax
	call	strcmp
	addl	$16, %esp
	testl	%eax, %eax
	jne	.L177
	movl	-28(%ebp), %eax
	addl	$1, %eax
	cmpl	8(%ebp), %eax
	jge	.L177
	addl	$1, -28(%ebp)
	movl	-28(%ebp), %eax
	leal	0(,%eax,4), %edx
	movl	12(%ebp), %eax
	leal	(%edx,%eax), %ecx
	movl	%ecx, %eax
	movl	%eax, %edx
	shrl	$3, %edx
	addl	$536870912, %edx
	movzbl	(%edx), %edx
	testb	%dl, %dl
	setne	%bl
	movl	%ebx, %edi
	movl	%eax, %esi
	andl	$7, %esi
	addl	$3, %esi
	movl	%esi, %ebx
	cmpb	%dl, %bl
	setge	%dl
	andl	%edi, %edx
	testb	%dl, %dl
	je	.L178
	subl	$12, %esp
	pushl	%eax
	call	__asan_report_load4
.L178:
	movl	(%ecx), %eax
	movl	%eax, data_dir
	jmp	.L165
.L177:
	movl	-28(%ebp), %eax
	leal	0(,%eax,4), %edx
	movl	12(%ebp), %eax
	leal	(%edx,%eax), %ecx
	movl	%ecx, %eax
	movl	%eax, %edx
	shrl	$3, %edx
	addl	$536870912, %edx
	movzbl	(%edx), %edx
	testb	%dl, %dl
	setne	%bl
	movl	%ebx, %edi
	movl	%eax, %esi
	andl	$7, %esi
	addl	$3, %esi
	movl	%esi, %ebx
	cmpb	%dl, %bl
	setge	%dl
	andl	%edi, %edx
	testb	%dl, %dl
	je	.L179
	subl	$12, %esp
	pushl	%eax
	call	__asan_report_load4
.L179:
	movl	(%ecx), %eax
	subl	$8, %esp
	pushl	$.LC57
	pushl	%eax
	call	strcmp
	addl	$16, %esp
	testl	%eax, %eax
	jne	.L180
	movl	$0, no_symlink_check
	jmp	.L165
.L180:
	movl	-28(%ebp), %eax
	leal	0(,%eax,4), %edx
	movl	12(%ebp), %eax
	leal	(%edx,%eax), %ecx
	movl	%ecx, %eax
	movl	%eax, %edx
	shrl	$3, %edx
	addl	$536870912, %edx
	movzbl	(%edx), %edx
	testb	%dl, %dl
	setne	%bl
	movl	%ebx, %edi
	movl	%eax, %esi
	andl	$7, %esi
	addl	$3, %esi
	movl	%esi, %ebx
	cmpb	%dl, %bl
	setge	%dl
	andl	%edi, %edx
	testb	%dl, %dl
	je	.L181
	subl	$12, %esp
	pushl	%eax
	call	__asan_report_load4
.L181:
	movl	(%ecx), %eax
	subl	$8, %esp
	pushl	$.LC58
	pushl	%eax
	call	strcmp
	addl	$16, %esp
	testl	%eax, %eax
	jne	.L182
	movl	$1, no_symlink_check
	jmp	.L165
.L182:
	movl	-28(%ebp), %eax
	leal	0(,%eax,4), %edx
	movl	12(%ebp), %eax
	leal	(%edx,%eax), %ecx
	movl	%ecx, %eax
	movl	%eax, %edx
	shrl	$3, %edx
	addl	$536870912, %edx
	movzbl	(%edx), %edx
	testb	%dl, %dl
	setne	%bl
	movl	%ebx, %edi
	movl	%eax, %esi
	andl	$7, %esi
	addl	$3, %esi
	movl	%esi, %ebx
	cmpb	%dl, %bl
	setge	%dl
	andl	%edi, %edx
	testb	%dl, %dl
	je	.L183
	subl	$12, %esp
	pushl	%eax
	call	__asan_report_load4
.L183:
	movl	(%ecx), %eax
	subl	$8, %esp
	pushl	$.LC59
	pushl	%eax
	call	strcmp
	addl	$16, %esp
	testl	%eax, %eax
	jne	.L184
	movl	-28(%ebp), %eax
	addl	$1, %eax
	cmpl	8(%ebp), %eax
	jge	.L184
	addl	$1, -28(%ebp)
	movl	-28(%ebp), %eax
	leal	0(,%eax,4), %edx
	movl	12(%ebp), %eax
	leal	(%edx,%eax), %ecx
	movl	%ecx, %eax
	movl	%eax, %edx
	shrl	$3, %edx
	addl	$536870912, %edx
	movzbl	(%edx), %edx
	testb	%dl, %dl
	setne	%bl
	movl	%ebx, %edi
	movl	%eax, %esi
	andl	$7, %esi
	addl	$3, %esi
	movl	%esi, %ebx
	cmpb	%dl, %bl
	setge	%dl
	andl	%edi, %edx
	testb	%dl, %dl
	je	.L185
	subl	$12, %esp
	pushl	%eax
	call	__asan_report_load4
.L185:
	movl	(%ecx), %eax
	movl	%eax, user
	jmp	.L165
.L184:
	movl	-28(%ebp), %eax
	leal	0(,%eax,4), %edx
	movl	12(%ebp), %eax
	leal	(%edx,%eax), %ecx
	movl	%ecx, %eax
	movl	%eax, %edx
	shrl	$3, %edx
	addl	$536870912, %edx
	movzbl	(%edx), %edx
	testb	%dl, %dl
	setne	%bl
	movl	%ebx, %edi
	movl	%eax, %esi
	andl	$7, %esi
	addl	$3, %esi
	movl	%esi, %ebx
	cmpb	%dl, %bl
	setge	%dl
	andl	%edi, %edx
	testb	%dl, %dl
	je	.L186
	subl	$12, %esp
	pushl	%eax
	call	__asan_report_load4
.L186:
	movl	(%ecx), %eax
	subl	$8, %esp
	pushl	$.LC60
	pushl	%eax
	call	strcmp
	addl	$16, %esp
	testl	%eax, %eax
	jne	.L187
	movl	-28(%ebp), %eax
	addl	$1, %eax
	cmpl	8(%ebp), %eax
	jge	.L187
	addl	$1, -28(%ebp)
	movl	-28(%ebp), %eax
	leal	0(,%eax,4), %edx
	movl	12(%ebp), %eax
	leal	(%edx,%eax), %ecx
	movl	%ecx, %eax
	movl	%eax, %edx
	shrl	$3, %edx
	addl	$536870912, %edx
	movzbl	(%edx), %edx
	testb	%dl, %dl
	setne	%bl
	movl	%ebx, %edi
	movl	%eax, %esi
	andl	$7, %esi
	addl	$3, %esi
	movl	%esi, %ebx
	cmpb	%dl, %bl
	setge	%dl
	andl	%edi, %edx
	testb	%dl, %dl
	je	.L188
	subl	$12, %esp
	pushl	%eax
	call	__asan_report_load4
.L188:
	movl	(%ecx), %eax
	movl	%eax, cgi_pattern
	jmp	.L165
.L187:
	movl	-28(%ebp), %eax
	leal	0(,%eax,4), %edx
	movl	12(%ebp), %eax
	leal	(%edx,%eax), %ecx
	movl	%ecx, %eax
	movl	%eax, %edx
	shrl	$3, %edx
	addl	$536870912, %edx
	movzbl	(%edx), %edx
	testb	%dl, %dl
	setne	%bl
	movl	%ebx, %edi
	movl	%eax, %esi
	andl	$7, %esi
	addl	$3, %esi
	movl	%esi, %ebx
	cmpb	%dl, %bl
	setge	%dl
	andl	%edi, %edx
	testb	%dl, %dl
	je	.L189
	subl	$12, %esp
	pushl	%eax
	call	__asan_report_load4
.L189:
	movl	(%ecx), %eax
	subl	$8, %esp
	pushl	$.LC61
	pushl	%eax
	call	strcmp
	addl	$16, %esp
	testl	%eax, %eax
	jne	.L190
	movl	-28(%ebp), %eax
	addl	$1, %eax
	cmpl	8(%ebp), %eax
	jge	.L190
	addl	$1, -28(%ebp)
	movl	-28(%ebp), %eax
	leal	0(,%eax,4), %edx
	movl	12(%ebp), %eax
	leal	(%edx,%eax), %ecx
	movl	%ecx, %eax
	movl	%eax, %edx
	shrl	$3, %edx
	addl	$536870912, %edx
	movzbl	(%edx), %edx
	testb	%dl, %dl
	setne	%bl
	movl	%ebx, %edi
	movl	%eax, %esi
	andl	$7, %esi
	addl	$3, %esi
	movl	%esi, %ebx
	cmpb	%dl, %bl
	setge	%dl
	andl	%edi, %edx
	testb	%dl, %dl
	je	.L191
	subl	$12, %esp
	pushl	%eax
	call	__asan_report_load4
.L191:
	movl	(%ecx), %eax
	movl	%eax, throttlefile
	jmp	.L165
.L190:
	movl	-28(%ebp), %eax
	leal	0(,%eax,4), %edx
	movl	12(%ebp), %eax
	leal	(%edx,%eax), %ecx
	movl	%ecx, %eax
	movl	%eax, %edx
	shrl	$3, %edx
	addl	$536870912, %edx
	movzbl	(%edx), %edx
	testb	%dl, %dl
	setne	%bl
	movl	%ebx, %edi
	movl	%eax, %esi
	andl	$7, %esi
	addl	$3, %esi
	movl	%esi, %ebx
	cmpb	%dl, %bl
	setge	%dl
	andl	%edi, %edx
	testb	%dl, %dl
	je	.L192
	subl	$12, %esp
	pushl	%eax
	call	__asan_report_load4
.L192:
	movl	(%ecx), %eax
	subl	$8, %esp
	pushl	$.LC62
	pushl	%eax
	call	strcmp
	addl	$16, %esp
	testl	%eax, %eax
	jne	.L193
	movl	-28(%ebp), %eax
	addl	$1, %eax
	cmpl	8(%ebp), %eax
	jge	.L193
	addl	$1, -28(%ebp)
	movl	-28(%ebp), %eax
	leal	0(,%eax,4), %edx
	movl	12(%ebp), %eax
	leal	(%edx,%eax), %ecx
	movl	%ecx, %eax
	movl	%eax, %edx
	shrl	$3, %edx
	addl	$536870912, %edx
	movzbl	(%edx), %edx
	testb	%dl, %dl
	setne	%bl
	movl	%ebx, %edi
	movl	%eax, %esi
	andl	$7, %esi
	addl	$3, %esi
	movl	%esi, %ebx
	cmpb	%dl, %bl
	setge	%dl
	andl	%edi, %edx
	testb	%dl, %dl
	je	.L194
	subl	$12, %esp
	pushl	%eax
	call	__asan_report_load4
.L194:
	movl	(%ecx), %eax
	movl	%eax, hostname
	jmp	.L165
.L193:
	movl	-28(%ebp), %eax
	leal	0(,%eax,4), %edx
	movl	12(%ebp), %eax
	leal	(%edx,%eax), %ecx
	movl	%ecx, %eax
	movl	%eax, %edx
	shrl	$3, %edx
	addl	$536870912, %edx
	movzbl	(%edx), %edx
	testb	%dl, %dl
	setne	%bl
	movl	%ebx, %edi
	movl	%eax, %esi
	andl	$7, %esi
	addl	$3, %esi
	movl	%esi, %ebx
	cmpb	%dl, %bl
	setge	%dl
	andl	%edi, %edx
	testb	%dl, %dl
	je	.L195
	subl	$12, %esp
	pushl	%eax
	call	__asan_report_load4
.L195:
	movl	(%ecx), %eax
	subl	$8, %esp
	pushl	$.LC63
	pushl	%eax
	call	strcmp
	addl	$16, %esp
	testl	%eax, %eax
	jne	.L196
	movl	-28(%ebp), %eax
	addl	$1, %eax
	cmpl	8(%ebp), %eax
	jge	.L196
	addl	$1, -28(%ebp)
	movl	-28(%ebp), %eax
	leal	0(,%eax,4), %edx
	movl	12(%ebp), %eax
	leal	(%edx,%eax), %ecx
	movl	%ecx, %eax
	movl	%eax, %edx
	shrl	$3, %edx
	addl	$536870912, %edx
	movzbl	(%edx), %edx
	testb	%dl, %dl
	setne	%bl
	movl	%ebx, %edi
	movl	%eax, %esi
	andl	$7, %esi
	addl	$3, %esi
	movl	%esi, %ebx
	cmpb	%dl, %bl
	setge	%dl
	andl	%edi, %edx
	testb	%dl, %dl
	je	.L197
	subl	$12, %esp
	pushl	%eax
	call	__asan_report_load4
.L197:
	movl	(%ecx), %eax
	movl	%eax, logfile
	jmp	.L165
.L196:
	movl	-28(%ebp), %eax
	leal	0(,%eax,4), %edx
	movl	12(%ebp), %eax
	leal	(%edx,%eax), %ecx
	movl	%ecx, %eax
	movl	%eax, %edx
	shrl	$3, %edx
	addl	$536870912, %edx
	movzbl	(%edx), %edx
	testb	%dl, %dl
	setne	%bl
	movl	%ebx, %edi
	movl	%eax, %esi
	andl	$7, %esi
	addl	$3, %esi
	movl	%esi, %ebx
	cmpb	%dl, %bl
	setge	%dl
	andl	%edi, %edx
	testb	%dl, %dl
	je	.L198
	subl	$12, %esp
	pushl	%eax
	call	__asan_report_load4
.L198:
	movl	(%ecx), %eax
	subl	$8, %esp
	pushl	$.LC64
	pushl	%eax
	call	strcmp
	addl	$16, %esp
	testl	%eax, %eax
	jne	.L199
	movl	$1, do_vhost
	jmp	.L165
.L199:
	movl	-28(%ebp), %eax
	leal	0(,%eax,4), %edx
	movl	12(%ebp), %eax
	leal	(%edx,%eax), %ecx
	movl	%ecx, %eax
	movl	%eax, %edx
	shrl	$3, %edx
	addl	$536870912, %edx
	movzbl	(%edx), %edx
	testb	%dl, %dl
	setne	%bl
	movl	%ebx, %edi
	movl	%eax, %esi
	andl	$7, %esi
	addl	$3, %esi
	movl	%esi, %ebx
	cmpb	%dl, %bl
	setge	%dl
	andl	%edi, %edx
	testb	%dl, %dl
	je	.L200
	subl	$12, %esp
	pushl	%eax
	call	__asan_report_load4
.L200:
	movl	(%ecx), %eax
	subl	$8, %esp
	pushl	$.LC65
	pushl	%eax
	call	strcmp
	addl	$16, %esp
	testl	%eax, %eax
	jne	.L201
	movl	$0, do_vhost
	jmp	.L165
.L201:
	movl	-28(%ebp), %eax
	leal	0(,%eax,4), %edx
	movl	12(%ebp), %eax
	leal	(%edx,%eax), %ecx
	movl	%ecx, %eax
	movl	%eax, %edx
	shrl	$3, %edx
	addl	$536870912, %edx
	movzbl	(%edx), %edx
	testb	%dl, %dl
	setne	%bl
	movl	%ebx, %edi
	movl	%eax, %esi
	andl	$7, %esi
	addl	$3, %esi
	movl	%esi, %ebx
	cmpb	%dl, %bl
	setge	%dl
	andl	%edi, %edx
	testb	%dl, %dl
	je	.L202
	subl	$12, %esp
	pushl	%eax
	call	__asan_report_load4
.L202:
	movl	(%ecx), %eax
	subl	$8, %esp
	pushl	$.LC66
	pushl	%eax
	call	strcmp
	addl	$16, %esp
	testl	%eax, %eax
	jne	.L203
	movl	$1, do_global_passwd
	jmp	.L165
.L203:
	movl	-28(%ebp), %eax
	leal	0(,%eax,4), %edx
	movl	12(%ebp), %eax
	leal	(%edx,%eax), %ecx
	movl	%ecx, %eax
	movl	%eax, %edx
	shrl	$3, %edx
	addl	$536870912, %edx
	movzbl	(%edx), %edx
	testb	%dl, %dl
	setne	%bl
	movl	%ebx, %edi
	movl	%eax, %esi
	andl	$7, %esi
	addl	$3, %esi
	movl	%esi, %ebx
	cmpb	%dl, %bl
	setge	%dl
	andl	%edi, %edx
	testb	%dl, %dl
	je	.L204
	subl	$12, %esp
	pushl	%eax
	call	__asan_report_load4
.L204:
	movl	(%ecx), %eax
	subl	$8, %esp
	pushl	$.LC67
	pushl	%eax
	call	strcmp
	addl	$16, %esp
	testl	%eax, %eax
	jne	.L205
	movl	$0, do_global_passwd
	jmp	.L165
.L205:
	movl	-28(%ebp), %eax
	leal	0(,%eax,4), %edx
	movl	12(%ebp), %eax
	leal	(%edx,%eax), %ecx
	movl	%ecx, %eax
	movl	%eax, %edx
	shrl	$3, %edx
	addl	$536870912, %edx
	movzbl	(%edx), %edx
	testb	%dl, %dl
	setne	%bl
	movl	%ebx, %edi
	movl	%eax, %esi
	andl	$7, %esi
	addl	$3, %esi
	movl	%esi, %ebx
	cmpb	%dl, %bl
	setge	%dl
	andl	%edi, %edx
	testb	%dl, %dl
	je	.L206
	subl	$12, %esp
	pushl	%eax
	call	__asan_report_load4
.L206:
	movl	(%ecx), %eax
	subl	$8, %esp
	pushl	$.LC68
	pushl	%eax
	call	strcmp
	addl	$16, %esp
	testl	%eax, %eax
	jne	.L207
	movl	-28(%ebp), %eax
	addl	$1, %eax
	cmpl	8(%ebp), %eax
	jge	.L207
	addl	$1, -28(%ebp)
	movl	-28(%ebp), %eax
	leal	0(,%eax,4), %edx
	movl	12(%ebp), %eax
	leal	(%edx,%eax), %ecx
	movl	%ecx, %eax
	movl	%eax, %edx
	shrl	$3, %edx
	addl	$536870912, %edx
	movzbl	(%edx), %edx
	testb	%dl, %dl
	setne	%bl
	movl	%ebx, %edi
	movl	%eax, %esi
	andl	$7, %esi
	addl	$3, %esi
	movl	%esi, %ebx
	cmpb	%dl, %bl
	setge	%dl
	andl	%edi, %edx
	testb	%dl, %dl
	je	.L208
	subl	$12, %esp
	pushl	%eax
	call	__asan_report_load4
.L208:
	movl	(%ecx), %eax
	movl	%eax, pidfile
	jmp	.L165
.L207:
	movl	-28(%ebp), %eax
	leal	0(,%eax,4), %edx
	movl	12(%ebp), %eax
	leal	(%edx,%eax), %ecx
	movl	%ecx, %eax
	movl	%eax, %edx
	shrl	$3, %edx
	addl	$536870912, %edx
	movzbl	(%edx), %edx
	testb	%dl, %dl
	setne	%bl
	movl	%ebx, %edi
	movl	%eax, %esi
	andl	$7, %esi
	addl	$3, %esi
	movl	%esi, %ebx
	cmpb	%dl, %bl
	setge	%dl
	andl	%edi, %edx
	testb	%dl, %dl
	je	.L209
	subl	$12, %esp
	pushl	%eax
	call	__asan_report_load4
.L209:
	movl	(%ecx), %eax
	subl	$8, %esp
	pushl	$.LC69
	pushl	%eax
	call	strcmp
	addl	$16, %esp
	testl	%eax, %eax
	jne	.L210
	movl	-28(%ebp), %eax
	addl	$1, %eax
	cmpl	8(%ebp), %eax
	jge	.L210
	addl	$1, -28(%ebp)
	movl	-28(%ebp), %eax
	leal	0(,%eax,4), %edx
	movl	12(%ebp), %eax
	leal	(%edx,%eax), %ecx
	movl	%ecx, %eax
	movl	%eax, %edx
	shrl	$3, %edx
	addl	$536870912, %edx
	movzbl	(%edx), %edx
	testb	%dl, %dl
	setne	%bl
	movl	%ebx, %edi
	movl	%eax, %esi
	andl	$7, %esi
	addl	$3, %esi
	movl	%esi, %ebx
	cmpb	%dl, %bl
	setge	%dl
	andl	%edi, %edx
	testb	%dl, %dl
	je	.L211
	subl	$12, %esp
	pushl	%eax
	call	__asan_report_load4
.L211:
	movl	(%ecx), %eax
	movl	%eax, charset
	jmp	.L165
.L210:
	movl	-28(%ebp), %eax
	leal	0(,%eax,4), %edx
	movl	12(%ebp), %eax
	leal	(%edx,%eax), %ecx
	movl	%ecx, %eax
	movl	%eax, %edx
	shrl	$3, %edx
	addl	$536870912, %edx
	movzbl	(%edx), %edx
	testb	%dl, %dl
	setne	%bl
	movl	%ebx, %edi
	movl	%eax, %esi
	andl	$7, %esi
	addl	$3, %esi
	movl	%esi, %ebx
	cmpb	%dl, %bl
	setge	%dl
	andl	%edi, %edx
	testb	%dl, %dl
	je	.L212
	subl	$12, %esp
	pushl	%eax
	call	__asan_report_load4
.L212:
	movl	(%ecx), %eax
	subl	$8, %esp
	pushl	$.LC70
	pushl	%eax
	call	strcmp
	addl	$16, %esp
	testl	%eax, %eax
	jne	.L213
	movl	-28(%ebp), %eax
	addl	$1, %eax
	cmpl	8(%ebp), %eax
	jge	.L213
	addl	$1, -28(%ebp)
	movl	-28(%ebp), %eax
	leal	0(,%eax,4), %edx
	movl	12(%ebp), %eax
	leal	(%edx,%eax), %ecx
	movl	%ecx, %eax
	movl	%eax, %edx
	shrl	$3, %edx
	addl	$536870912, %edx
	movzbl	(%edx), %edx
	testb	%dl, %dl
	setne	%bl
	movl	%ebx, %edi
	movl	%eax, %esi
	andl	$7, %esi
	addl	$3, %esi
	movl	%esi, %ebx
	cmpb	%dl, %bl
	setge	%dl
	andl	%edi, %edx
	testb	%dl, %dl
	je	.L214
	subl	$12, %esp
	pushl	%eax
	call	__asan_report_load4
.L214:
	movl	(%ecx), %eax
	movl	%eax, p3p
	jmp	.L165
.L213:
	movl	-28(%ebp), %eax
	leal	0(,%eax,4), %edx
	movl	12(%ebp), %eax
	leal	(%edx,%eax), %ecx
	movl	%ecx, %eax
	movl	%eax, %edx
	shrl	$3, %edx
	addl	$536870912, %edx
	movzbl	(%edx), %edx
	testb	%dl, %dl
	setne	%bl
	movl	%ebx, %edi
	movl	%eax, %esi
	andl	$7, %esi
	addl	$3, %esi
	movl	%esi, %ebx
	cmpb	%dl, %bl
	setge	%dl
	andl	%edi, %edx
	testb	%dl, %dl
	je	.L215
	subl	$12, %esp
	pushl	%eax
	call	__asan_report_load4
.L215:
	movl	(%ecx), %eax
	subl	$8, %esp
	pushl	$.LC71
	pushl	%eax
	call	strcmp
	addl	$16, %esp
	testl	%eax, %eax
	jne	.L216
	movl	-28(%ebp), %eax
	addl	$1, %eax
	cmpl	8(%ebp), %eax
	jge	.L216
	addl	$1, -28(%ebp)
	movl	-28(%ebp), %eax
	leal	0(,%eax,4), %edx
	movl	12(%ebp), %eax
	leal	(%edx,%eax), %ecx
	movl	%ecx, %eax
	movl	%eax, %edx
	shrl	$3, %edx
	addl	$536870912, %edx
	movzbl	(%edx), %edx
	testb	%dl, %dl
	setne	%bl
	movl	%ebx, %edi
	movl	%eax, %esi
	andl	$7, %esi
	addl	$3, %esi
	movl	%esi, %ebx
	cmpb	%dl, %bl
	setge	%dl
	andl	%edi, %edx
	testb	%dl, %dl
	je	.L217
	subl	$12, %esp
	pushl	%eax
	call	__asan_report_load4
.L217:
	movl	(%ecx), %eax
	subl	$12, %esp
	pushl	%eax
	call	atoi
	addl	$16, %esp
	movl	%eax, max_age
	jmp	.L165
.L216:
	movl	-28(%ebp), %eax
	leal	0(,%eax,4), %edx
	movl	12(%ebp), %eax
	leal	(%edx,%eax), %ecx
	movl	%ecx, %eax
	movl	%eax, %edx
	shrl	$3, %edx
	addl	$536870912, %edx
	movzbl	(%edx), %edx
	testb	%dl, %dl
	setne	%bl
	movl	%ebx, %edi
	movl	%eax, %esi
	andl	$7, %esi
	addl	$3, %esi
	movl	%esi, %ebx
	cmpb	%dl, %bl
	setge	%dl
	andl	%edi, %edx
	testb	%dl, %dl
	je	.L218
	subl	$12, %esp
	pushl	%eax
	call	__asan_report_load4
.L218:
	movl	(%ecx), %eax
	subl	$8, %esp
	pushl	$.LC72
	pushl	%eax
	call	strcmp
	addl	$16, %esp
	testl	%eax, %eax
	jne	.L219
	movl	$1, debug
	jmp	.L165
.L219:
	call	usage
.L165:
	addl	$1, -28(%ebp)
.L159:
	movl	-28(%ebp), %eax
	cmpl	8(%ebp), %eax
	jge	.L220
	movl	-28(%ebp), %eax
	leal	0(,%eax,4), %edx
	movl	12(%ebp), %eax
	leal	(%edx,%eax), %ecx
	movl	%ecx, %eax
	movl	%eax, %edx
	shrl	$3, %edx
	addl	$536870912, %edx
	movzbl	(%edx), %edx
	testb	%dl, %dl
	setne	%bl
	movl	%ebx, %edi
	movl	%eax, %esi
	andl	$7, %esi
	addl	$3, %esi
	movl	%esi, %ebx
	cmpb	%dl, %bl
	setge	%dl
	andl	%edi, %edx
	testb	%dl, %dl
	je	.L221
	subl	$12, %esp
	pushl	%eax
	call	__asan_report_load4
.L221:
	movl	(%ecx), %edx
	movl	%edx, %eax
	movl	%eax, %ecx
	shrl	$3, %ecx
	addl	$536870912, %ecx
	movzbl	(%ecx), %ecx
	testb	%cl, %cl
	setne	%bl
	movl	%ebx, %edi
	movl	%eax, %esi
	andl	$7, %esi
	movl	%esi, %ebx
	cmpb	%cl, %bl
	setge	%cl
	andl	%edi, %ecx
	testb	%cl, %cl
	je	.L222
	subl	$12, %esp
	pushl	%eax
	call	__asan_report_load1
.L222:
	movzbl	(%edx), %eax
	cmpb	$45, %al
	je	.L223
.L220:
	movl	-28(%ebp), %eax
	cmpl	8(%ebp), %eax
	je	.L158
	call	usage
.L158:
	leal	-12(%ebp), %esp
	popl	%ebx
	popl	%esi
	popl	%edi
	popl	%ebp
	ret
	.size	parse_args, .-parse_args
	.section	.rodata
	.align 32
.LC73:
	.string	"usage:  %s [-C configfile] [-p port] [-d dir] [-r|-nor] [-dd data_dir] [-s|-nos] [-v|-nov] [-g|-nog] [-u user] [-c cgipat] [-t throttles] [-h host] [-l logfile] [-i pidfile] [-T charset] [-P P3P] [-M maxage] [-V] [-D]\n"
	.zero	37
	.text
	.type	usage, @function
usage:
.LASANPC9:
	pushl	%ebp
	movl	%esp, %ebp
	pushl	%edi
	pushl	%esi
	pushl	%ebx
	subl	$12, %esp
	movl	argv0, %edi
	movl	$stderr, %eax
	movl	%eax, %edx
	shrl	$3, %edx
	addl	$536870912, %edx
	movzbl	(%edx), %edx
	testb	%dl, %dl
	setne	%bl
	movl	%eax, %esi
	andl	$7, %esi
	addl	$3, %esi
	movl	%esi, %ecx
	cmpb	%dl, %cl
	setge	%dl
	andl	%ebx, %edx
	testb	%dl, %dl
	je	.L226
	subl	$12, %esp
	pushl	%eax
	call	__asan_report_load4
.L226:
	movl	stderr, %eax
	subl	$4, %esp
	pushl	%edi
	pushl	$.LC73
	pushl	%eax
	call	fprintf
	addl	$16, %esp
	call	__asan_handle_no_return
	subl	$12, %esp
	pushl	$1
	call	exit
	.size	usage, .-usage
	.globl	__asan_stack_malloc_2
	.section	.rodata
.LC74:
	.string	"1 32 100 4 line "
	.align 32
.LC75:
	.string	"r"
	.zero	62
	.align 32
.LC76:
	.string	" \t\n\r"
	.zero	59
	.align 32
.LC77:
	.string	"debug"
	.zero	58
	.align 32
.LC78:
	.string	"port"
	.zero	59
	.align 32
.LC79:
	.string	"dir"
	.zero	60
	.align 32
.LC80:
	.string	"nochroot"
	.zero	55
	.align 32
.LC81:
	.string	"data_dir"
	.zero	55
	.align 32
.LC82:
	.string	"symlink"
	.zero	56
	.align 32
.LC83:
	.string	"nosymlink"
	.zero	54
	.align 32
.LC84:
	.string	"symlinks"
	.zero	55
	.align 32
.LC85:
	.string	"nosymlinks"
	.zero	53
	.align 32
.LC86:
	.string	"user"
	.zero	59
	.align 32
.LC87:
	.string	"cgipat"
	.zero	57
	.align 32
.LC88:
	.string	"cgilimit"
	.zero	55
	.align 32
.LC89:
	.string	"urlpat"
	.zero	57
	.align 32
.LC90:
	.string	"noemptyreferers"
	.zero	48
	.align 32
.LC91:
	.string	"localpat"
	.zero	55
	.align 32
.LC92:
	.string	"throttles"
	.zero	54
	.align 32
.LC93:
	.string	"host"
	.zero	59
	.align 32
.LC94:
	.string	"logfile"
	.zero	56
	.align 32
.LC95:
	.string	"vhost"
	.zero	58
	.align 32
.LC96:
	.string	"novhost"
	.zero	56
	.align 32
.LC97:
	.string	"globalpasswd"
	.zero	51
	.align 32
.LC98:
	.string	"noglobalpasswd"
	.zero	49
	.align 32
.LC99:
	.string	"pidfile"
	.zero	56
	.align 32
.LC100:
	.string	"charset"
	.zero	56
	.align 32
.LC101:
	.string	"p3p"
	.zero	60
	.align 32
.LC102:
	.string	"max_age"
	.zero	56
	.align 32
.LC103:
	.string	"%s: unknown config option '%s'\n"
	.zero	32
	.text
	.type	read_config, @function
read_config:
.LASANPC10:
	pushl	%ebp
	movl	%esp, %ebp
	pushl	%edi
	pushl	%esi
	pushl	%ebx
	subl	$252, %esp
	leal	-216(%ebp), %esi
	movl	%esi, -260(%ebp)
	cmpl	$0, __asan_option_detect_stack_use_after_return
	je	.L227
	subl	$8, %esp
	pushl	%esi
	pushl	$192
	call	__asan_stack_malloc_2
	addl	$16, %esp
	movl	%eax, %esi
.L227:
	leal	192(%esi), %eax
	movl	%eax, -252(%ebp)
	movl	$1102416563, (%esi)
	movl	$.LC74, 4(%esi)
	movl	$.LASANPC10, 8(%esi)
	movl	%esi, %ebx
	shrl	$3, %ebx
	movl	$-235802127, 536870912(%ebx)
	movl	$-185273340, 536870928(%ebx)
	movl	$-202116109, 536870932(%ebx)
	subl	$8, %esp
	pushl	$.LC75
	pushl	8(%ebp)
	call	fopen
	addl	$16, %esp
	movl	%eax, -224(%ebp)
	cmpl	$0, -224(%ebp)
	jne	.L231
	subl	$12, %esp
	pushl	8(%ebp)
	call	perror
	addl	$16, %esp
	call	__asan_handle_no_return
	subl	$12, %esp
	pushl	$1
	call	exit
.L231:
	jmp	.L232
.L273:
	subl	$8, %esp
	pushl	$35
	movl	-252(%ebp), %eax
	subl	$160, %eax
	pushl	%eax
	call	strchr
	addl	$16, %esp
	movl	%eax, -236(%ebp)
	cmpl	$0, -236(%ebp)
	je	.L233
	movl	-236(%ebp), %edx
	movl	%edx, %eax
	shrl	$3, %eax
	addl	$536870912, %eax
	movzbl	(%eax), %ecx
	testb	%cl, %cl
	setne	%al
	movl	%eax, %edi
	movl	%edx, %eax
	andl	$7, %eax
	cmpb	%cl, %al
	setge	%al
	andl	%edi, %eax
	testb	%al, %al
	je	.L234
	subl	$12, %esp
	pushl	%edx
	call	__asan_report_store1
.L234:
	movl	-236(%ebp), %eax
	movb	$0, (%eax)
.L233:
	movl	-252(%ebp), %eax
	subl	$160, %eax
	movl	%eax, -236(%ebp)
	subl	$8, %esp
	pushl	$.LC76
	pushl	-236(%ebp)
	call	strspn
	addl	$16, %esp
	addl	%eax, -236(%ebp)
	jmp	.L235
.L272:
	subl	$8, %esp
	pushl	$.LC76
	pushl	-236(%ebp)
	call	strcspn
	addl	$16, %esp
	movl	%eax, %edx
	movl	-236(%ebp), %eax
	addl	%edx, %eax
	movl	%eax, -232(%ebp)
	jmp	.L236
.L239:
	movl	-232(%ebp), %ecx
	leal	1(%ecx), %eax
	movl	%eax, -232(%ebp)
	movl	%ecx, %edi
	movl	%edi, %eax
	shrl	$3, %eax
	addl	$536870912, %eax
	movzbl	(%eax), %edx
	testb	%dl, %dl
	setne	-253(%ebp)
	movl	%edi, %eax
	andl	$7, %eax
	cmpb	%dl, %al
	setge	%al
	andb	-253(%ebp), %al
	testb	%al, %al
	je	.L237
	subl	$12, %esp
	pushl	%edi
	call	__asan_report_store1
.L237:
	movb	$0, (%ecx)
.L236:
	movl	-232(%ebp), %edx
	movl	%edx, %eax
	shrl	$3, %eax
	addl	$536870912, %eax
	movzbl	(%eax), %ecx
	testb	%cl, %cl
	setne	%al
	movl	%eax, %edi
	movl	%edx, %eax
	andl	$7, %eax
	cmpb	%cl, %al
	setge	%al
	andl	%edi, %eax
	testb	%al, %al
	je	.L238
	subl	$12, %esp
	pushl	%edx
	call	__asan_report_load1
.L238:
	movl	-232(%ebp), %eax
	movzbl	(%eax), %eax
	cmpb	$32, %al
	je	.L239
	movl	-232(%ebp), %eax
	movzbl	(%eax), %eax
	cmpb	$9, %al
	je	.L239
	movl	-232(%ebp), %eax
	movzbl	(%eax), %eax
	cmpb	$10, %al
	je	.L239
	movl	-232(%ebp), %eax
	movzbl	(%eax), %eax
	cmpb	$13, %al
	je	.L239
	movl	-236(%ebp), %eax
	movl	%eax, -220(%ebp)
	subl	$8, %esp
	pushl	$61
	pushl	-220(%ebp)
	call	strchr
	addl	$16, %esp
	movl	%eax, -228(%ebp)
	cmpl	$0, -228(%ebp)
	je	.L240
	movl	-228(%ebp), %ecx
	leal	1(%ecx), %eax
	movl	%eax, -228(%ebp)
	movl	%ecx, %edi
	movl	%edi, %eax
	shrl	$3, %eax
	addl	$536870912, %eax
	movzbl	(%eax), %edx
	testb	%dl, %dl
	setne	-253(%ebp)
	movl	%edi, %eax
	andl	$7, %eax
	cmpb	%dl, %al
	setge	%al
	andb	-253(%ebp), %al
	testb	%al, %al
	je	.L241
	subl	$12, %esp
	pushl	%edi
	call	__asan_report_store1
.L241:
	movb	$0, (%ecx)
.L240:
	subl	$8, %esp
	pushl	$.LC77
	pushl	-220(%ebp)
	call	strcasecmp
	addl	$16, %esp
	testl	%eax, %eax
	jne	.L242
	subl	$8, %esp
	pushl	-228(%ebp)
	pushl	-220(%ebp)
	call	no_value_required
	addl	$16, %esp
	movl	$1, debug
	jmp	.L243
.L242:
	subl	$8, %esp
	pushl	$.LC78
	pushl	-220(%ebp)
	call	strcasecmp
	addl	$16, %esp
	testl	%eax, %eax
	jne	.L244
	subl	$8, %esp
	pushl	-228(%ebp)
	pushl	-220(%ebp)
	call	value_required
	addl	$16, %esp
	subl	$12, %esp
	pushl	-228(%ebp)
	call	atoi
	addl	$16, %esp
	movw	%ax, port
	jmp	.L243
.L244:
	subl	$8, %esp
	pushl	$.LC79
	pushl	-220(%ebp)
	call	strcasecmp
	addl	$16, %esp
	testl	%eax, %eax
	jne	.L245
	subl	$8, %esp
	pushl	-228(%ebp)
	pushl	-220(%ebp)
	call	value_required
	addl	$16, %esp
	subl	$12, %esp
	pushl	-228(%ebp)
	call	e_strdup
	addl	$16, %esp
	movl	%eax, dir
	jmp	.L243
.L245:
	subl	$8, %esp
	pushl	$.LC28
	pushl	-220(%ebp)
	call	strcasecmp
	addl	$16, %esp
	testl	%eax, %eax
	jne	.L246
	subl	$8, %esp
	pushl	-228(%ebp)
	pushl	-220(%ebp)
	call	no_value_required
	addl	$16, %esp
	movl	$1, do_chroot
	movl	$1, no_symlink_check
	jmp	.L243
.L246:
	subl	$8, %esp
	pushl	$.LC80
	pushl	-220(%ebp)
	call	strcasecmp
	addl	$16, %esp
	testl	%eax, %eax
	jne	.L247
	subl	$8, %esp
	pushl	-228(%ebp)
	pushl	-220(%ebp)
	call	no_value_required
	addl	$16, %esp
	movl	$0, do_chroot
	movl	$0, no_symlink_check
	jmp	.L243
.L247:
	subl	$8, %esp
	pushl	$.LC81
	pushl	-220(%ebp)
	call	strcasecmp
	addl	$16, %esp
	testl	%eax, %eax
	jne	.L248
	subl	$8, %esp
	pushl	-228(%ebp)
	pushl	-220(%ebp)
	call	value_required
	addl	$16, %esp
	subl	$12, %esp
	pushl	-228(%ebp)
	call	e_strdup
	addl	$16, %esp
	movl	%eax, data_dir
	jmp	.L243
.L248:
	subl	$8, %esp
	pushl	$.LC82
	pushl	-220(%ebp)
	call	strcasecmp
	addl	$16, %esp
	testl	%eax, %eax
	jne	.L249
	subl	$8, %esp
	pushl	-228(%ebp)
	pushl	-220(%ebp)
	call	no_value_required
	addl	$16, %esp
	movl	$0, no_symlink_check
	jmp	.L243
.L249:
	subl	$8, %esp
	pushl	$.LC83
	pushl	-220(%ebp)
	call	strcasecmp
	addl	$16, %esp
	testl	%eax, %eax
	jne	.L250
	subl	$8, %esp
	pushl	-228(%ebp)
	pushl	-220(%ebp)
	call	no_value_required
	addl	$16, %esp
	movl	$1, no_symlink_check
	jmp	.L243
.L250:
	subl	$8, %esp
	pushl	$.LC84
	pushl	-220(%ebp)
	call	strcasecmp
	addl	$16, %esp
	testl	%eax, %eax
	jne	.L251
	subl	$8, %esp
	pushl	-228(%ebp)
	pushl	-220(%ebp)
	call	no_value_required
	addl	$16, %esp
	movl	$0, no_symlink_check
	jmp	.L243
.L251:
	subl	$8, %esp
	pushl	$.LC85
	pushl	-220(%ebp)
	call	strcasecmp
	addl	$16, %esp
	testl	%eax, %eax
	jne	.L252
	subl	$8, %esp
	pushl	-228(%ebp)
	pushl	-220(%ebp)
	call	no_value_required
	addl	$16, %esp
	movl	$1, no_symlink_check
	jmp	.L243
.L252:
	subl	$8, %esp
	pushl	$.LC86
	pushl	-220(%ebp)
	call	strcasecmp
	addl	$16, %esp
	testl	%eax, %eax
	jne	.L253
	subl	$8, %esp
	pushl	-228(%ebp)
	pushl	-220(%ebp)
	call	value_required
	addl	$16, %esp
	subl	$12, %esp
	pushl	-228(%ebp)
	call	e_strdup
	addl	$16, %esp
	movl	%eax, user
	jmp	.L243
.L253:
	subl	$8, %esp
	pushl	$.LC87
	pushl	-220(%ebp)
	call	strcasecmp
	addl	$16, %esp
	testl	%eax, %eax
	jne	.L254
	subl	$8, %esp
	pushl	-228(%ebp)
	pushl	-220(%ebp)
	call	value_required
	addl	$16, %esp
	subl	$12, %esp
	pushl	-228(%ebp)
	call	e_strdup
	addl	$16, %esp
	movl	%eax, cgi_pattern
	jmp	.L243
.L254:
	subl	$8, %esp
	pushl	$.LC88
	pushl	-220(%ebp)
	call	strcasecmp
	addl	$16, %esp
	testl	%eax, %eax
	jne	.L255
	subl	$8, %esp
	pushl	-228(%ebp)
	pushl	-220(%ebp)
	call	value_required
	addl	$16, %esp
	subl	$12, %esp
	pushl	-228(%ebp)
	call	atoi
	addl	$16, %esp
	movl	%eax, cgi_limit
	jmp	.L243
.L255:
	subl	$8, %esp
	pushl	$.LC89
	pushl	-220(%ebp)
	call	strcasecmp
	addl	$16, %esp
	testl	%eax, %eax
	jne	.L256
	subl	$8, %esp
	pushl	-228(%ebp)
	pushl	-220(%ebp)
	call	value_required
	addl	$16, %esp
	subl	$12, %esp
	pushl	-228(%ebp)
	call	e_strdup
	addl	$16, %esp
	movl	%eax, url_pattern
	jmp	.L243
.L256:
	subl	$8, %esp
	pushl	$.LC90
	pushl	-220(%ebp)
	call	strcasecmp
	addl	$16, %esp
	testl	%eax, %eax
	jne	.L257
	subl	$8, %esp
	pushl	-228(%ebp)
	pushl	-220(%ebp)
	call	no_value_required
	addl	$16, %esp
	movl	$1, no_empty_referers
	jmp	.L243
.L257:
	subl	$8, %esp
	pushl	$.LC91
	pushl	-220(%ebp)
	call	strcasecmp
	addl	$16, %esp
	testl	%eax, %eax
	jne	.L258
	subl	$8, %esp
	pushl	-228(%ebp)
	pushl	-220(%ebp)
	call	value_required
	addl	$16, %esp
	subl	$12, %esp
	pushl	-228(%ebp)
	call	e_strdup
	addl	$16, %esp
	movl	%eax, local_pattern
	jmp	.L243
.L258:
	subl	$8, %esp
	pushl	$.LC92
	pushl	-220(%ebp)
	call	strcasecmp
	addl	$16, %esp
	testl	%eax, %eax
	jne	.L259
	subl	$8, %esp
	pushl	-228(%ebp)
	pushl	-220(%ebp)
	call	value_required
	addl	$16, %esp
	subl	$12, %esp
	pushl	-228(%ebp)
	call	e_strdup
	addl	$16, %esp
	movl	%eax, throttlefile
	jmp	.L243
.L259:
	subl	$8, %esp
	pushl	$.LC93
	pushl	-220(%ebp)
	call	strcasecmp
	addl	$16, %esp
	testl	%eax, %eax
	jne	.L260
	subl	$8, %esp
	pushl	-228(%ebp)
	pushl	-220(%ebp)
	call	value_required
	addl	$16, %esp
	subl	$12, %esp
	pushl	-228(%ebp)
	call	e_strdup
	addl	$16, %esp
	movl	%eax, hostname
	jmp	.L243
.L260:
	subl	$8, %esp
	pushl	$.LC94
	pushl	-220(%ebp)
	call	strcasecmp
	addl	$16, %esp
	testl	%eax, %eax
	jne	.L261
	subl	$8, %esp
	pushl	-228(%ebp)
	pushl	-220(%ebp)
	call	value_required
	addl	$16, %esp
	subl	$12, %esp
	pushl	-228(%ebp)
	call	e_strdup
	addl	$16, %esp
	movl	%eax, logfile
	jmp	.L243
.L261:
	subl	$8, %esp
	pushl	$.LC95
	pushl	-220(%ebp)
	call	strcasecmp
	addl	$16, %esp
	testl	%eax, %eax
	jne	.L262
	subl	$8, %esp
	pushl	-228(%ebp)
	pushl	-220(%ebp)
	call	no_value_required
	addl	$16, %esp
	movl	$1, do_vhost
	jmp	.L243
.L262:
	subl	$8, %esp
	pushl	$.LC96
	pushl	-220(%ebp)
	call	strcasecmp
	addl	$16, %esp
	testl	%eax, %eax
	jne	.L263
	subl	$8, %esp
	pushl	-228(%ebp)
	pushl	-220(%ebp)
	call	no_value_required
	addl	$16, %esp
	movl	$0, do_vhost
	jmp	.L243
.L263:
	subl	$8, %esp
	pushl	$.LC97
	pushl	-220(%ebp)
	call	strcasecmp
	addl	$16, %esp
	testl	%eax, %eax
	jne	.L264
	subl	$8, %esp
	pushl	-228(%ebp)
	pushl	-220(%ebp)
	call	no_value_required
	addl	$16, %esp
	movl	$1, do_global_passwd
	jmp	.L243
.L264:
	subl	$8, %esp
	pushl	$.LC98
	pushl	-220(%ebp)
	call	strcasecmp
	addl	$16, %esp
	testl	%eax, %eax
	jne	.L265
	subl	$8, %esp
	pushl	-228(%ebp)
	pushl	-220(%ebp)
	call	no_value_required
	addl	$16, %esp
	movl	$0, do_global_passwd
	jmp	.L243
.L265:
	subl	$8, %esp
	pushl	$.LC99
	pushl	-220(%ebp)
	call	strcasecmp
	addl	$16, %esp
	testl	%eax, %eax
	jne	.L266
	subl	$8, %esp
	pushl	-228(%ebp)
	pushl	-220(%ebp)
	call	value_required
	addl	$16, %esp
	subl	$12, %esp
	pushl	-228(%ebp)
	call	e_strdup
	addl	$16, %esp
	movl	%eax, pidfile
	jmp	.L243
.L266:
	subl	$8, %esp
	pushl	$.LC100
	pushl	-220(%ebp)
	call	strcasecmp
	addl	$16, %esp
	testl	%eax, %eax
	jne	.L267
	subl	$8, %esp
	pushl	-228(%ebp)
	pushl	-220(%ebp)
	call	value_required
	addl	$16, %esp
	subl	$12, %esp
	pushl	-228(%ebp)
	call	e_strdup
	addl	$16, %esp
	movl	%eax, charset
	jmp	.L243
.L267:
	subl	$8, %esp
	pushl	$.LC101
	pushl	-220(%ebp)
	call	strcasecmp
	addl	$16, %esp
	testl	%eax, %eax
	jne	.L268
	subl	$8, %esp
	pushl	-228(%ebp)
	pushl	-220(%ebp)
	call	value_required
	addl	$16, %esp
	subl	$12, %esp
	pushl	-228(%ebp)
	call	e_strdup
	addl	$16, %esp
	movl	%eax, p3p
	jmp	.L243
.L268:
	subl	$8, %esp
	pushl	$.LC102
	pushl	-220(%ebp)
	call	strcasecmp
	addl	$16, %esp
	testl	%eax, %eax
	jne	.L269
	subl	$8, %esp
	pushl	-228(%ebp)
	pushl	-220(%ebp)
	call	value_required
	addl	$16, %esp
	subl	$12, %esp
	pushl	-228(%ebp)
	call	atoi
	addl	$16, %esp
	movl	%eax, max_age
	jmp	.L243
.L269:
	movl	argv0, %edi
	movl	$stderr, %eax
	movl	%eax, %edx
	shrl	$3, %edx
	addl	$536870912, %edx
	movzbl	(%edx), %edx
	testb	%dl, %dl
	setne	%bl
	movl	%eax, %esi
	andl	$7, %esi
	addl	$3, %esi
	movl	%esi, %ecx
	cmpb	%dl, %cl
	setge	%dl
	andl	%ebx, %edx
	testb	%dl, %dl
	je	.L270
	subl	$12, %esp
	pushl	%eax
	call	__asan_report_load4
.L270:
	movl	stderr, %eax
	pushl	-220(%ebp)
	pushl	%edi
	pushl	$.LC103
	pushl	%eax
	call	fprintf
	addl	$16, %esp
	call	__asan_handle_no_return
	subl	$12, %esp
	pushl	$1
	call	exit
.L243:
	movl	-232(%ebp), %eax
	movl	%eax, -236(%ebp)
	subl	$8, %esp
	pushl	$.LC76
	pushl	-236(%ebp)
	call	strspn
	addl	$16, %esp
	addl	%eax, -236(%ebp)
.L235:
	movl	-236(%ebp), %edx
	movl	%edx, %eax
	shrl	$3, %eax
	addl	$536870912, %eax
	movzbl	(%eax), %ecx
	testb	%cl, %cl
	setne	%al
	movl	%eax, %edi
	movl	%edx, %eax
	andl	$7, %eax
	cmpb	%cl, %al
	setge	%al
	andl	%edi, %eax
	testb	%al, %al
	je	.L271
	subl	$12, %esp
	pushl	%edx
	call	__asan_report_load1
.L271:
	movl	-236(%ebp), %eax
	movzbl	(%eax), %eax
	testb	%al, %al
	jne	.L272
.L232:
	subl	$4, %esp
	pushl	-224(%ebp)
	pushl	$1000
	movl	-252(%ebp), %eax
	subl	$160, %eax
	pushl	%eax
	call	fgets
	addl	$16, %esp
	testl	%eax, %eax
	jne	.L273
	subl	$12, %esp
	pushl	-224(%ebp)
	call	fclose
	addl	$16, %esp
	cmpl	%esi, -260(%ebp)
	je	.L228
	movl	$1172321806, (%esi)
	movl	$-168430091, 536870912(%ebx)
	movl	$-168430091, 536870916(%ebx)
	movl	$-168430091, 536870920(%ebx)
	movl	$-168430091, 536870924(%ebx)
	movl	$-168430091, 536870928(%ebx)
	movl	$-168430091, 536870932(%ebx)
	jmp	.L229
.L228:
	movl	$0, 536870912(%ebx)
	movl	$0, 536870928(%ebx)
	movl	$0, 536870932(%ebx)
.L229:
	leal	-12(%ebp), %esp
	popl	%ebx
	popl	%esi
	popl	%edi
	popl	%ebp
	ret
	.size	read_config, .-read_config
	.section	.rodata
	.align 32
.LC104:
	.string	"%s: value required for %s option\n"
	.zero	62
	.text
	.type	value_required, @function
value_required:
.LASANPC11:
	pushl	%ebp
	movl	%esp, %ebp
	pushl	%edi
	pushl	%esi
	pushl	%ebx
	subl	$12, %esp
	cmpl	$0, 12(%ebp)
	jne	.L274
	movl	argv0, %edi
	movl	$stderr, %eax
	movl	%eax, %edx
	shrl	$3, %edx
	addl	$536870912, %edx
	movzbl	(%edx), %edx
	testb	%dl, %dl
	setne	%bl
	movl	%eax, %esi
	andl	$7, %esi
	addl	$3, %esi
	movl	%esi, %ecx
	cmpb	%dl, %cl
	setge	%dl
	andl	%ebx, %edx
	testb	%dl, %dl
	je	.L276
	subl	$12, %esp
	pushl	%eax
	call	__asan_report_load4
.L276:
	movl	stderr, %eax
	pushl	8(%ebp)
	pushl	%edi
	pushl	$.LC104
	pushl	%eax
	call	fprintf
	addl	$16, %esp
	call	__asan_handle_no_return
	subl	$12, %esp
	pushl	$1
	call	exit
.L274:
	leal	-12(%ebp), %esp
	popl	%ebx
	popl	%esi
	popl	%edi
	popl	%ebp
	ret
	.size	value_required, .-value_required
	.section	.rodata
	.align 32
.LC105:
	.string	"%s: no value required for %s option\n"
	.zero	59
	.text
	.type	no_value_required, @function
no_value_required:
.LASANPC12:
	pushl	%ebp
	movl	%esp, %ebp
	pushl	%edi
	pushl	%esi
	pushl	%ebx
	subl	$12, %esp
	cmpl	$0, 12(%ebp)
	je	.L277
	movl	argv0, %edi
	movl	$stderr, %eax
	movl	%eax, %edx
	shrl	$3, %edx
	addl	$536870912, %edx
	movzbl	(%edx), %edx
	testb	%dl, %dl
	setne	%bl
	movl	%eax, %esi
	andl	$7, %esi
	addl	$3, %esi
	movl	%esi, %ecx
	cmpb	%dl, %cl
	setge	%dl
	andl	%ebx, %edx
	testb	%dl, %dl
	je	.L279
	subl	$12, %esp
	pushl	%eax
	call	__asan_report_load4
.L279:
	movl	stderr, %eax
	pushl	8(%ebp)
	pushl	%edi
	pushl	$.LC105
	pushl	%eax
	call	fprintf
	addl	$16, %esp
	call	__asan_handle_no_return
	subl	$12, %esp
	pushl	$1
	call	exit
.L277:
	leal	-12(%ebp), %esp
	popl	%ebx
	popl	%esi
	popl	%edi
	popl	%ebp
	ret
	.size	no_value_required, .-no_value_required
	.section	.rodata
	.align 32
.LC106:
	.string	"out of memory copying a string"
	.zero	33
	.align 32
.LC107:
	.string	"%s: out of memory copying a string\n"
	.zero	60
	.text
	.type	e_strdup, @function
e_strdup:
.LASANPC13:
	pushl	%ebp
	movl	%esp, %ebp
	pushl	%edi
	pushl	%esi
	pushl	%ebx
	subl	$28, %esp
	subl	$12, %esp
	pushl	8(%ebp)
	call	strdup
	addl	$16, %esp
	movl	%eax, -28(%ebp)
	cmpl	$0, -28(%ebp)
	jne	.L281
	subl	$8, %esp
	pushl	$.LC106
	pushl	$2
	call	syslog
	addl	$16, %esp
	movl	argv0, %edi
	movl	$stderr, %eax
	movl	%eax, %edx
	shrl	$3, %edx
	addl	$536870912, %edx
	movzbl	(%edx), %edx
	testb	%dl, %dl
	setne	%bl
	movl	%eax, %esi
	andl	$7, %esi
	addl	$3, %esi
	movl	%esi, %ecx
	cmpb	%dl, %cl
	setge	%dl
	andl	%ebx, %edx
	testb	%dl, %dl
	je	.L282
	subl	$12, %esp
	pushl	%eax
	call	__asan_report_load4
.L282:
	movl	stderr, %eax
	subl	$4, %esp
	pushl	%edi
	pushl	$.LC107
	pushl	%eax
	call	fprintf
	addl	$16, %esp
	call	__asan_handle_no_return
	subl	$12, %esp
	pushl	$1
	call	exit
.L281:
	movl	-28(%ebp), %eax
	leal	-12(%ebp), %esp
	popl	%ebx
	popl	%esi
	popl	%edi
	popl	%ebp
	ret
	.size	e_strdup, .-e_strdup
	.section	.rodata
	.align 4
.LC108:
	.string	"3 32 4 2 ai 96 10 7 portstr 160 32 5 hints "
	.align 32
.LC109:
	.string	"%d"
	.zero	61
	.align 32
.LC110:
	.string	"getaddrinfo %.80s - %.80s"
	.zero	38
	.align 32
.LC111:
	.string	"%s: getaddrinfo %s - %s\n"
	.zero	39
	.align 32
.LC112:
	.string	"%.80s - sockaddr too small (%lu < %lu)"
	.zero	57
	.text
	.type	lookup_hostname, @function
lookup_hostname:
.LASANPC14:
	pushl	%ebp
	movl	%esp, %ebp
	pushl	%edi
	pushl	%esi
	pushl	%ebx
	subl	$284, %esp
	leal	-248(%ebp), %eax
	movl	%eax, -268(%ebp)
	movl	%eax, -292(%ebp)
	cmpl	$0, __asan_option_detect_stack_use_after_return
	je	.L284
	subl	$8, %esp
	pushl	-268(%ebp)
	pushl	$224
	call	__asan_stack_malloc_2
	addl	$16, %esp
	movl	%eax, -268(%ebp)
.L284:
	movl	-268(%ebp), %edi
	movl	%edi, %eax
	addl	$224, %eax
	movl	%eax, %esi
	movl	%esi, -276(%ebp)
	movl	%edi, %eax
	movl	$1102416563, (%eax)
	movl	%edi, %eax
	movl	$.LC108, 4(%eax)
	movl	$.LASANPC14, 8(%eax)
	shrl	$3, %eax
	movl	%eax, -280(%ebp)
	movl	$-235802127, 536870912(%eax)
	movl	$-185273340, 536870916(%eax)
	movl	$-218959118, 536870920(%eax)
	movl	$-185335296, 536870924(%eax)
	movl	$-218959118, 536870928(%eax)
	movl	$-202116109, 536870936(%eax)
	movl	%esi, %eax
	subl	$64, %eax
	movl	$32, %ebx
	movl	%ebx, -272(%ebp)
	movl	%eax, %esi
	movl	%esi, %eax
	shrl	$3, %eax
	addl	$536870912, %eax
	movzbl	(%eax), %edx
	testb	%dl, %dl
	setne	%cl
	movl	%esi, %eax
	andl	$7, %eax
	cmpb	%dl, %al
	setge	%al
	movl	%ecx, %edi
	andl	%eax, %edi
	movl	%ebx, %eax
	subl	$1, %eax
	leal	(%esi,%eax), %ecx
	movl	%ecx, %eax
	shrl	$3, %eax
	addl	$536870912, %eax
	movzbl	(%eax), %edx
	testb	%dl, %dl
	setne	%bl
	movl	%ecx, %eax
	andl	$7, %eax
	cmpb	%dl, %al
	setge	%al
	andl	%ebx, %eax
	orl	%edi, %eax
	testb	%al, %al
	je	.L288
	subl	$8, %esp
	pushl	-272(%ebp)
	pushl	%esi
	call	__asan_report_store_n
.L288:
	subl	$4, %esp
	pushl	$32
	pushl	$0
	movl	-276(%ebp), %edi
	movl	%edi, %eax
	subl	$64, %eax
	pushl	%eax
	call	memset
	addl	$16, %esp
	movl	%edi, %eax
	movl	$0, -60(%eax)
	movl	%edi, %eax
	movl	$1, -64(%eax)
	movl	%edi, %eax
	movl	$1, -56(%eax)
	movzwl	port, %eax
	movzwl	%ax, %eax
	pushl	%eax
	pushl	$.LC109
	pushl	$10
	movl	%edi, %eax
	addl	$-128, %eax
	pushl	%eax
	call	snprintf
	addl	$16, %esp
	movl	hostname, %eax
	leal	-192(%edi), %edx
	pushl	%edx
	leal	-64(%edi), %edx
	pushl	%edx
	leal	-128(%edi), %edx
	pushl	%edx
	pushl	%eax
	call	getaddrinfo
	addl	$16, %esp
	movl	%eax, -252(%ebp)
	cmpl	$0, -252(%ebp)
	je	.L289
	subl	$12, %esp
	pushl	-252(%ebp)
	call	gai_strerror
	addl	$16, %esp
	movl	%eax, %edx
	movl	hostname, %eax
	pushl	%edx
	pushl	%eax
	pushl	$.LC110
	pushl	$2
	call	syslog
	addl	$16, %esp
	subl	$12, %esp
	pushl	-252(%ebp)
	call	gai_strerror
	addl	$16, %esp
	movl	%eax, %edi
	movl	hostname, %esi
	movl	argv0, %ebx
	movl	$stderr, %eax
	movl	%eax, %edx
	movl	%edx, %eax
	shrl	$3, %eax
	addl	$536870912, %eax
	movzbl	(%eax), %ecx
	testb	%cl, %cl
	setne	-268(%ebp)
	movl	%edx, %eax
	andl	$7, %eax
	addl	$3, %eax
	cmpb	%cl, %al
	setge	%al
	andb	-268(%ebp), %al
	testb	%al, %al
	je	.L290
	subl	$12, %esp
	pushl	%edx
	call	__asan_report_load4
.L290:
	movl	stderr, %eax
	subl	$12, %esp
	pushl	%edi
	pushl	%esi
	pushl	%ebx
	pushl	$.LC111
	pushl	%eax
	call	fprintf
	addl	$32, %esp
	call	__asan_handle_no_return
	subl	$12, %esp
	pushl	$1
	call	exit
.L289:
	movl	$0, -260(%ebp)
	movl	$0, -256(%ebp)
	movl	-276(%ebp), %eax
	movl	-192(%eax), %eax
	movl	%eax, -264(%ebp)
	jmp	.L291
.L299:
	movl	-264(%ebp), %eax
	addl	$4, %eax
	movl	%eax, %edx
	movl	%edx, %eax
	shrl	$3, %eax
	addl	$536870912, %eax
	movzbl	(%eax), %ecx
	testb	%cl, %cl
	setne	%bl
	movl	%edx, %eax
	andl	$7, %eax
	addl	$3, %eax
	cmpb	%cl, %al
	setge	%al
	andl	%ebx, %eax
	testb	%al, %al
	je	.L292
	subl	$12, %esp
	pushl	%edx
	call	__asan_report_load4
.L292:
	movl	-264(%ebp), %eax
	movl	4(%eax), %eax
	cmpl	$2, %eax
	je	.L294
	cmpl	$10, %eax
	jne	.L293
	cmpl	$0, -260(%ebp)
	jne	.L296
	movl	-264(%ebp), %eax
	movl	%eax, -260(%ebp)
	jmp	.L293
.L296:
	jmp	.L293
.L294:
	cmpl	$0, -256(%ebp)
	jne	.L297
	movl	-264(%ebp), %eax
	movl	%eax, -256(%ebp)
	jmp	.L322
.L297:
.L322:
	nop
.L293:
	movl	-264(%ebp), %eax
	addl	$28, %eax
	movl	%eax, %edx
	movl	%edx, %eax
	shrl	$3, %eax
	addl	$536870912, %eax
	movzbl	(%eax), %ecx
	testb	%cl, %cl
	setne	%bl
	movl	%edx, %eax
	andl	$7, %eax
	addl	$3, %eax
	cmpb	%cl, %al
	setge	%al
	andl	%ebx, %eax
	testb	%al, %al
	je	.L298
	subl	$12, %esp
	pushl	%edx
	call	__asan_report_load4
.L298:
	movl	-264(%ebp), %eax
	movl	28(%eax), %eax
	movl	%eax, -264(%ebp)
.L291:
	cmpl	$0, -264(%ebp)
	jne	.L299
	cmpl	$0, -260(%ebp)
	jne	.L300
	movl	28(%ebp), %edx
	movl	%edx, %eax
	shrl	$3, %eax
	addl	$536870912, %eax
	movzbl	(%eax), %ecx
	testb	%cl, %cl
	setne	%bl
	movl	%edx, %eax
	andl	$7, %eax
	addl	$3, %eax
	cmpb	%cl, %al
	setge	%al
	andl	%ebx, %eax
	testb	%al, %al
	je	.L301
	subl	$12, %esp
	pushl	%edx
	call	__asan_report_store4
.L301:
	movl	28(%ebp), %eax
	movl	$0, (%eax)
	jmp	.L302
.L300:
	movl	-260(%ebp), %eax
	addl	$16, %eax
	movl	%eax, %edx
	movl	%edx, %eax
	shrl	$3, %eax
	addl	$536870912, %eax
	movzbl	(%eax), %ecx
	testb	%cl, %cl
	setne	%bl
	movl	%edx, %eax
	andl	$7, %eax
	addl	$3, %eax
	cmpb	%cl, %al
	setge	%al
	andl	%ebx, %eax
	testb	%al, %al
	je	.L303
	subl	$12, %esp
	pushl	%edx
	call	__asan_report_load4
.L303:
	movl	-260(%ebp), %eax
	movl	16(%eax), %eax
	cmpl	24(%ebp), %eax
	jbe	.L304
	movl	-260(%ebp), %eax
	movl	16(%eax), %edx
	movl	hostname, %eax
	subl	$12, %esp
	pushl	%edx
	pushl	24(%ebp)
	pushl	%eax
	pushl	$.LC112
	pushl	$2
	call	syslog
	addl	$32, %esp
	call	__asan_handle_no_return
	subl	$12, %esp
	pushl	$1
	call	exit
.L304:
	movl	24(%ebp), %edi
	testl	%edi, %edi
	je	.L305
	movl	20(%ebp), %esi
	movl	%esi, %eax
	shrl	$3, %eax
	addl	$536870912, %eax
	movzbl	(%eax), %edx
	testb	%dl, %dl
	setne	%cl
	movl	%esi, %eax
	andl	$7, %eax
	cmpb	%dl, %al
	setge	%al
	andl	%eax, %ecx
	movb	%cl, -272(%ebp)
	leal	-1(%edi), %eax
	leal	(%esi,%eax), %ecx
	movl	%ecx, %eax
	shrl	$3, %eax
	addl	$536870912, %eax
	movzbl	(%eax), %edx
	testb	%dl, %dl
	setne	%bl
	movl	%ecx, %eax
	andl	$7, %eax
	cmpb	%dl, %al
	setge	%al
	andl	%ebx, %eax
	orb	-272(%ebp), %al
	testb	%al, %al
	je	.L305
	subl	$8, %esp
	pushl	%edi
	pushl	%esi
	call	__asan_report_store_n
.L305:
	subl	$4, %esp
	pushl	24(%ebp)
	pushl	$0
	pushl	20(%ebp)
	call	memset
	addl	$16, %esp
	movl	-260(%ebp), %eax
	addl	$16, %eax
	movl	%eax, %edx
	movl	%edx, %eax
	shrl	$3, %eax
	addl	$536870912, %eax
	movzbl	(%eax), %ecx
	testb	%cl, %cl
	setne	%bl
	movl	%edx, %eax
	andl	$7, %eax
	addl	$3, %eax
	cmpb	%cl, %al
	setge	%al
	andl	%ebx, %eax
	testb	%al, %al
	je	.L306
	subl	$12, %esp
	pushl	%edx
	call	__asan_report_load4
.L306:
	movl	-260(%ebp), %eax
	movl	16(%eax), %eax
	movl	%eax, -272(%ebp)
	movl	-260(%ebp), %eax
	addl	$20, %eax
	movl	%eax, %ecx
	movl	%ecx, %eax
	shrl	$3, %eax
	addl	$536870912, %eax
	movzbl	(%eax), %edx
	testb	%dl, %dl
	setne	%bl
	movl	%ecx, %eax
	andl	$7, %eax
	addl	$3, %eax
	cmpb	%dl, %al
	setge	%al
	andl	%ebx, %eax
	testb	%al, %al
	je	.L307
	subl	$12, %esp
	pushl	%ecx
	call	__asan_report_load4
.L307:
	movl	-260(%ebp), %eax
	movl	20(%eax), %eax
	movl	%eax, -284(%ebp)
	movl	-272(%ebp), %edi
	testl	%edi, %edi
	je	.L308
	movl	%eax, %esi
	movl	%esi, %eax
	shrl	$3, %eax
	addl	$536870912, %eax
	movzbl	(%eax), %edx
	testb	%dl, %dl
	setne	%cl
	movl	%esi, %eax
	andl	$7, %eax
	cmpb	%dl, %al
	setge	%al
	andl	%eax, %ecx
	movb	%cl, -285(%ebp)
	leal	-1(%edi), %eax
	leal	(%esi,%eax), %ecx
	movl	%ecx, %eax
	shrl	$3, %eax
	addl	$536870912, %eax
	movzbl	(%eax), %edx
	testb	%dl, %dl
	setne	%bl
	movl	%ecx, %eax
	andl	$7, %eax
	cmpb	%dl, %al
	setge	%al
	andl	%ebx, %eax
	orb	-285(%ebp), %al
	testb	%al, %al
	je	.L308
	subl	$8, %esp
	pushl	%edi
	pushl	%esi
	call	__asan_report_load_n
.L308:
	movl	-272(%ebp), %esi
	testl	%esi, %esi
	je	.L309
	movl	20(%ebp), %edi
	leal	-1(%esi), %eax
	leal	(%edi,%eax), %ecx
	movl	%ecx, %eax
	shrl	$3, %eax
	addl	$536870912, %eax
	movzbl	(%eax), %edx
	testb	%dl, %dl
	setne	%bl
	movl	%ecx, %eax
	andl	$7, %eax
	cmpb	%dl, %al
	setge	%al
	andl	%ebx, %eax
	testb	%al, %al
	je	.L309
	subl	$8, %esp
	pushl	%esi
	pushl	%edi
	call	__asan_report_store_n
.L309:
	subl	$4, %esp
	pushl	-272(%ebp)
	pushl	-284(%ebp)
	pushl	20(%ebp)
	call	memmove
	addl	$16, %esp
	movl	28(%ebp), %edx
	movl	%edx, %eax
	shrl	$3, %eax
	addl	$536870912, %eax
	movzbl	(%eax), %ecx
	testb	%cl, %cl
	setne	%bl
	movl	%edx, %eax
	andl	$7, %eax
	addl	$3, %eax
	cmpb	%cl, %al
	setge	%al
	andl	%ebx, %eax
	testb	%al, %al
	je	.L310
	subl	$12, %esp
	pushl	%edx
	call	__asan_report_store4
.L310:
	movl	28(%ebp), %eax
	movl	$1, (%eax)
.L302:
	cmpl	$0, -256(%ebp)
	jne	.L311
	movl	16(%ebp), %edx
	movl	%edx, %eax
	shrl	$3, %eax
	addl	$536870912, %eax
	movzbl	(%eax), %ecx
	testb	%cl, %cl
	setne	%bl
	movl	%edx, %eax
	andl	$7, %eax
	addl	$3, %eax
	cmpb	%cl, %al
	setge	%al
	andl	%ebx, %eax
	testb	%al, %al
	je	.L312
	subl	$12, %esp
	pushl	%edx
	call	__asan_report_store4
.L312:
	movl	16(%ebp), %eax
	movl	$0, (%eax)
	jmp	.L313
.L311:
	movl	-256(%ebp), %eax
	addl	$16, %eax
	movl	%eax, %edx
	movl	%edx, %eax
	shrl	$3, %eax
	addl	$536870912, %eax
	movzbl	(%eax), %ecx
	testb	%cl, %cl
	setne	%bl
	movl	%edx, %eax
	andl	$7, %eax
	addl	$3, %eax
	cmpb	%cl, %al
	setge	%al
	andl	%ebx, %eax
	testb	%al, %al
	je	.L314
	subl	$12, %esp
	pushl	%edx
	call	__asan_report_load4
.L314:
	movl	-256(%ebp), %eax
	movl	16(%eax), %eax
	cmpl	12(%ebp), %eax
	jbe	.L315
	movl	-256(%ebp), %eax
	movl	16(%eax), %edx
	movl	hostname, %eax
	subl	$12, %esp
	pushl	%edx
	pushl	12(%ebp)
	pushl	%eax
	pushl	$.LC112
	pushl	$2
	call	syslog
	addl	$32, %esp
	call	__asan_handle_no_return
	subl	$12, %esp
	pushl	$1
	call	exit
.L315:
	movl	12(%ebp), %edi
	testl	%edi, %edi
	je	.L316
	movl	8(%ebp), %esi
	movl	%esi, %eax
	shrl	$3, %eax
	addl	$536870912, %eax
	movzbl	(%eax), %edx
	testb	%dl, %dl
	setne	%cl
	movl	%esi, %eax
	andl	$7, %eax
	cmpb	%dl, %al
	setge	%al
	andl	%eax, %ecx
	movb	%cl, -272(%ebp)
	leal	-1(%edi), %eax
	leal	(%esi,%eax), %ecx
	movl	%ecx, %eax
	shrl	$3, %eax
	addl	$536870912, %eax
	movzbl	(%eax), %edx
	testb	%dl, %dl
	setne	%bl
	movl	%ecx, %eax
	andl	$7, %eax
	cmpb	%dl, %al
	setge	%al
	andl	%ebx, %eax
	orb	-272(%ebp), %al
	testb	%al, %al
	je	.L316
	subl	$8, %esp
	pushl	%edi
	pushl	%esi
	call	__asan_report_store_n
.L316:
	subl	$4, %esp
	pushl	12(%ebp)
	pushl	$0
	pushl	8(%ebp)
	call	memset
	addl	$16, %esp
	movl	-256(%ebp), %eax
	addl	$16, %eax
	movl	%eax, %edx
	movl	%edx, %eax
	shrl	$3, %eax
	addl	$536870912, %eax
	movzbl	(%eax), %ecx
	testb	%cl, %cl
	setne	%bl
	movl	%edx, %eax
	andl	$7, %eax
	addl	$3, %eax
	cmpb	%cl, %al
	setge	%al
	andl	%ebx, %eax
	testb	%al, %al
	je	.L317
	subl	$12, %esp
	pushl	%edx
	call	__asan_report_load4
.L317:
	movl	-256(%ebp), %eax
	movl	16(%eax), %eax
	movl	%eax, -272(%ebp)
	movl	-256(%ebp), %eax
	addl	$20, %eax
	movl	%eax, %ecx
	movl	%ecx, %eax
	shrl	$3, %eax
	addl	$536870912, %eax
	movzbl	(%eax), %edx
	testb	%dl, %dl
	setne	%bl
	movl	%ecx, %eax
	andl	$7, %eax
	addl	$3, %eax
	cmpb	%dl, %al
	setge	%al
	andl	%ebx, %eax
	testb	%al, %al
	je	.L318
	subl	$12, %esp
	pushl	%ecx
	call	__asan_report_load4
.L318:
	movl	-256(%ebp), %eax
	movl	20(%eax), %eax
	movl	%eax, -284(%ebp)
	movl	-272(%ebp), %edi
	testl	%edi, %edi
	je	.L319
	movl	%eax, %esi
	movl	%esi, %eax
	shrl	$3, %eax
	addl	$536870912, %eax
	movzbl	(%eax), %edx
	testb	%dl, %dl
	setne	%cl
	movl	%esi, %eax
	andl	$7, %eax
	cmpb	%dl, %al
	setge	%al
	andl	%eax, %ecx
	movb	%cl, -285(%ebp)
	leal	-1(%edi), %eax
	leal	(%esi,%eax), %ecx
	movl	%ecx, %eax
	shrl	$3, %eax
	addl	$536870912, %eax
	movzbl	(%eax), %edx
	testb	%dl, %dl
	setne	%bl
	movl	%ecx, %eax
	andl	$7, %eax
	cmpb	%dl, %al
	setge	%al
	andl	%ebx, %eax
	orb	-285(%ebp), %al
	testb	%al, %al
	je	.L319
	subl	$8, %esp
	pushl	%edi
	pushl	%esi
	call	__asan_report_load_n
.L319:
	movl	-272(%ebp), %esi
	testl	%esi, %esi
	je	.L320
	movl	8(%ebp), %edi
	leal	-1(%esi), %eax
	leal	(%edi,%eax), %ecx
	movl	%ecx, %eax
	shrl	$3, %eax
	addl	$536870912, %eax
	movzbl	(%eax), %edx
	testb	%dl, %dl
	setne	%bl
	movl	%ecx, %eax
	andl	$7, %eax
	cmpb	%dl, %al
	setge	%al
	andl	%ebx, %eax
	testb	%al, %al
	je	.L320
	subl	$8, %esp
	pushl	%esi
	pushl	%edi
	call	__asan_report_store_n
.L320:
	subl	$4, %esp
	pushl	-272(%ebp)
	pushl	-284(%ebp)
	pushl	8(%ebp)
	call	memmove
	addl	$16, %esp
	movl	16(%ebp), %edx
	movl	%edx, %eax
	shrl	$3, %eax
	addl	$536870912, %eax
	movzbl	(%eax), %ecx
	testb	%cl, %cl
	setne	%bl
	movl	%edx, %eax
	andl	$7, %eax
	addl	$3, %eax
	cmpb	%cl, %al
	setge	%al
	andl	%ebx, %eax
	testb	%al, %al
	je	.L321
	subl	$12, %esp
	pushl	%edx
	call	__asan_report_store4
.L321:
	movl	16(%ebp), %eax
	movl	$1, (%eax)
.L313:
	movl	-276(%ebp), %eax
	movl	-192(%eax), %eax
	subl	$12, %esp
	pushl	%eax
	call	freeaddrinfo
	addl	$16, %esp
	movl	-268(%ebp), %esi
	cmpl	%esi, -292(%ebp)
	je	.L285
	movl	-268(%ebp), %eax
	movl	$1172321806, (%eax)
	movl	-280(%ebp), %eax
	movl	$-168430091, 536870912(%eax)
	movl	$-168430091, 536870916(%eax)
	movl	$-168430091, 536870920(%eax)
	movl	$-168430091, 536870924(%eax)
	movl	$-168430091, 536870928(%eax)
	movl	$-168430091, 536870932(%eax)
	movl	$-168430091, 536870936(%eax)
	jmp	.L286
.L285:
	movl	-280(%ebp), %eax
	movl	$0, 536870912(%eax)
	movl	$0, 536870916(%eax)
	movl	$0, 536870920(%eax)
	movl	$0, 536870924(%eax)
	movl	$0, 536870928(%eax)
	movl	$0, 536870936(%eax)
.L286:
	leal	-12(%ebp), %esp
	popl	%ebx
	popl	%esi
	popl	%edi
	popl	%ebp
	ret
	.size	lookup_hostname, .-lookup_hostname
	.globl	__asan_stack_malloc_8
	.section	.rodata
	.align 4
.LC113:
	.string	"5 32 4 9 max_limit 96 4 9 min_limit 160 8 2 tv 224 5000 3 buf 5280 5000 7 pattern "
	.globl	__asan_stack_free_8
	.align 32
.LC114:
	.string	" %4900[^ \t] %ld-%ld"
	.zero	44
	.align 32
.LC115:
	.string	" %4900[^ \t] %ld"
	.zero	48
	.align 32
.LC116:
	.string	"unparsable line in %.80s - %.80s"
	.zero	63
	.align 32
.LC117:
	.string	"%s: unparsable line in %.80s - %.80s\n"
	.zero	58
	.align 32
.LC118:
	.string	"|/"
	.zero	61
	.align 32
.LC119:
	.string	"out of memory allocating a throttletab"
	.zero	57
	.align 32
.LC120:
	.string	"%s: out of memory allocating a throttletab\n"
	.zero	52
	.text
	.type	read_throttlefile, @function
read_throttlefile:
.LASANPC15:
	pushl	%ebp
	movl	%esp, %ebp
	pushl	%edi
	pushl	%esi
	pushl	%ebx
	subl	$10380, %esp
	leal	-10360(%ebp), %eax
	movl	%eax, -10380(%ebp)
	movl	%eax, -10388(%ebp)
	cmpl	$0, __asan_option_detect_stack_use_after_return
	je	.L323
	subl	$8, %esp
	pushl	-10380(%ebp)
	pushl	$10336
	call	__asan_stack_malloc_8
	addl	$16, %esp
	movl	%eax, -10380(%ebp)
.L323:
	movl	-10380(%ebp), %edi
	movl	%edi, %eax
	addl	$10336, %eax
	movl	%eax, %ebx
	movl	%edi, %eax
	movl	$1102416563, (%eax)
	movl	%edi, %eax
	movl	$.LC113, 4(%eax)
	movl	$.LASANPC15, 8(%eax)
	shrl	$3, %eax
	movl	%eax, -10392(%ebp)
	movl	$-235802127, 536870912(%eax)
	movl	$-185273340, 536870916(%eax)
	movl	$-218959118, 536870920(%eax)
	movl	$-185273340, 536870924(%eax)
	movl	$-218959118, 536870928(%eax)
	movl	$-185273344, 536870932(%eax)
	movl	$-218959118, 536870936(%eax)
	movl	$-185273344, 536871564(%eax)
	movl	$-218959118, 536871568(%eax)
	movl	$-185273344, 536872196(%eax)
	movl	$-202116109, 536872200(%eax)
	subl	$8, %esp
	pushl	$.LC75
	pushl	8(%ebp)
	call	fopen
	addl	$16, %esp
	movl	%eax, -10368(%ebp)
	cmpl	$0, -10368(%ebp)
	jne	.L329
	subl	$4, %esp
	pushl	8(%ebp)
	pushl	$.LC15
	pushl	$2
	call	syslog
	addl	$16, %esp
	subl	$12, %esp
	pushl	8(%ebp)
	call	perror
	addl	$16, %esp
	call	__asan_handle_no_return
	subl	$12, %esp
	pushl	$1
	call	exit
.L329:
	subl	$8, %esp
	pushl	$0
	leal	-10176(%ebx), %eax
	pushl	%eax
	call	gettimeofday
	addl	$16, %esp
	jmp	.L330
.L360:
	subl	$8, %esp
	pushl	$35
	leal	-10112(%ebx), %eax
	pushl	%eax
	call	strchr
	addl	$16, %esp
	movl	%eax, -10364(%ebp)
	cmpl	$0, -10364(%ebp)
	je	.L331
	movl	-10364(%ebp), %edx
	movl	%edx, %eax
	shrl	$3, %eax
	addl	$536870912, %eax
	movzbl	(%eax), %ecx
	testb	%cl, %cl
	setne	%al
	movl	%eax, %esi
	movl	%edx, %eax
	andl	$7, %eax
	cmpb	%cl, %al
	setge	%al
	andl	%esi, %eax
	testb	%al, %al
	je	.L332
	subl	$12, %esp
	pushl	%edx
	call	__asan_report_store1
.L332:
	movl	-10364(%ebp), %eax
	movb	$0, (%eax)
.L331:
	subl	$12, %esp
	leal	-10112(%ebx), %eax
	pushl	%eax
	call	strlen
	addl	$16, %esp
	movl	%eax, -10384(%ebp)
	leal	-10112(%ebx), %edi
	movl	%edi, %ecx
	movl	%ecx, %eax
	shrl	$3, %eax
	addl	$536870912, %eax
	movzbl	(%eax), %edx
	testb	%dl, %dl
	setne	%al
	movl	%eax, %esi
	movl	%ecx, %eax
	andl	$7, %eax
	cmpb	%dl, %al
	setge	%al
	andl	%esi, %eax
	testb	%al, %al
	je	.L333
	subl	$12, %esp
	pushl	%ecx
	call	__asan_report_load1
.L333:
	movl	-10384(%ebp), %eax
	addl	%edi, %eax
	movl	%eax, %ecx
	movl	%ecx, %eax
	shrl	$3, %eax
	addl	$536870912, %eax
	movzbl	(%eax), %edx
	testb	%dl, %dl
	setne	%al
	movl	%eax, %esi
	movl	%ecx, %eax
	andl	$7, %eax
	cmpb	%dl, %al
	setge	%al
	andl	%esi, %eax
	testb	%al, %al
	je	.L334
	subl	$12, %esp
	pushl	%ecx
	call	__asan_report_load1
.L334:
	movl	-10384(%ebp), %eax
	movl	%eax, -10372(%ebp)
	jmp	.L335
.L339:
	subl	$1, -10372(%ebp)
	leal	-10112(%ebx), %edx
	movl	-10372(%ebp), %eax
	addl	%edx, %eax
	movl	%eax, %edx
	movl	%edx, %eax
	shrl	$3, %eax
	addl	$536870912, %eax
	movzbl	(%eax), %ecx
	testb	%cl, %cl
	setne	%al
	movl	%eax, %esi
	movl	%edx, %eax
	andl	$7, %eax
	cmpb	%cl, %al
	setge	%al
	andl	%esi, %eax
	testb	%al, %al
	je	.L336
	subl	$12, %esp
	pushl	%edx
	call	__asan_report_store1
.L336:
	movl	-10372(%ebp), %eax
	addl	%ebx, %eax
	subl	$10112, %eax
	movb	$0, (%eax)
.L335:
	cmpl	$0, -10372(%ebp)
	jle	.L337
	movl	-10372(%ebp), %eax
	leal	-1(%eax), %edi
	leal	-10112(%ebx), %eax
	addl	%edi, %eax
	movl	%eax, %ecx
	movl	%ecx, %eax
	shrl	$3, %eax
	addl	$536870912, %eax
	movzbl	(%eax), %edx
	testb	%dl, %dl
	setne	%al
	movl	%eax, %esi
	movl	%ecx, %eax
	andl	$7, %eax
	cmpb	%dl, %al
	setge	%al
	andl	%esi, %eax
	testb	%al, %al
	je	.L338
	subl	$12, %esp
	pushl	%ecx
	call	__asan_report_load1
.L338:
	movzbl	-10112(%edi,%ebx), %eax
	cmpb	$32, %al
	je	.L339
	movl	-10372(%ebp), %eax
	leal	-1(%eax), %edi
	leal	-10112(%ebx), %eax
	addl	%edi, %eax
	movl	%eax, %ecx
	movl	%ecx, %eax
	shrl	$3, %eax
	addl	$536870912, %eax
	movzbl	(%eax), %edx
	testb	%dl, %dl
	setne	%al
	movl	%eax, %esi
	movl	%ecx, %eax
	andl	$7, %eax
	cmpb	%dl, %al
	setge	%al
	andl	%esi, %eax
	testb	%al, %al
	je	.L340
	subl	$12, %esp
	pushl	%ecx
	call	__asan_report_load1
.L340:
	movzbl	-10112(%edi,%ebx), %eax
	cmpb	$9, %al
	je	.L339
	movl	-10372(%ebp), %eax
	leal	-1(%eax), %edi
	leal	-10112(%ebx), %eax
	addl	%edi, %eax
	movl	%eax, %ecx
	movl	%ecx, %eax
	shrl	$3, %eax
	addl	$536870912, %eax
	movzbl	(%eax), %edx
	testb	%dl, %dl
	setne	%al
	movl	%eax, %esi
	movl	%ecx, %eax
	andl	$7, %eax
	cmpb	%dl, %al
	setge	%al
	andl	%esi, %eax
	testb	%al, %al
	je	.L341
	subl	$12, %esp
	pushl	%ecx
	call	__asan_report_load1
.L341:
	movzbl	-10112(%edi,%ebx), %eax
	cmpb	$10, %al
	je	.L339
	movl	-10372(%ebp), %eax
	leal	-1(%eax), %edi
	leal	-10112(%ebx), %eax
	addl	%edi, %eax
	movl	%eax, %ecx
	movl	%ecx, %eax
	shrl	$3, %eax
	addl	$536870912, %eax
	movzbl	(%eax), %edx
	testb	%dl, %dl
	setne	%al
	movl	%eax, %esi
	movl	%ecx, %eax
	andl	$7, %eax
	cmpb	%dl, %al
	setge	%al
	andl	%esi, %eax
	testb	%al, %al
	je	.L342
	subl	$12, %esp
	pushl	%ecx
	call	__asan_report_load1
.L342:
	movzbl	-10112(%edi,%ebx), %eax
	cmpb	$13, %al
	je	.L339
.L337:
	cmpl	$0, -10372(%ebp)
	jne	.L343
	jmp	.L330
.L343:
	subl	$12, %esp
	leal	-10304(%ebx), %eax
	pushl	%eax
	leal	-10240(%ebx), %eax
	pushl	%eax
	leal	-5056(%ebx), %eax
	pushl	%eax
	pushl	$.LC114
	leal	-10112(%ebx), %eax
	pushl	%eax
	call	__isoc99_sscanf
	addl	$32, %esp
	cmpl	$3, %eax
	je	.L344
	leal	-10304(%ebx), %eax
	pushl	%eax
	leal	-5056(%ebx), %eax
	pushl	%eax
	pushl	$.LC115
	leal	-10112(%ebx), %eax
	pushl	%eax
	call	__isoc99_sscanf
	addl	$16, %esp
	cmpl	$2, %eax
	jne	.L345
	movl	$0, -10240(%ebx)
	jmp	.L344
.L345:
	leal	-10112(%ebx), %eax
	pushl	%eax
	pushl	8(%ebp)
	pushl	$.LC116
	pushl	$2
	call	syslog
	addl	$16, %esp
	movl	argv0, %edi
	movl	$stderr, %eax
	movl	%eax, %ecx
	movl	%ecx, %eax
	shrl	$3, %eax
	addl	$536870912, %eax
	movzbl	(%eax), %edx
	testb	%dl, %dl
	setne	%al
	movl	%eax, %esi
	movl	%ecx, %eax
	andl	$7, %eax
	addl	$3, %eax
	cmpb	%dl, %al
	setge	%al
	andl	%esi, %eax
	testb	%al, %al
	je	.L346
	subl	$12, %esp
	pushl	%ecx
	call	__asan_report_load4
.L346:
	movl	stderr, %eax
	subl	$12, %esp
	leal	-10112(%ebx), %edx
	pushl	%edx
	pushl	8(%ebp)
	pushl	%edi
	pushl	$.LC117
	pushl	%eax
	call	fprintf
	addl	$32, %esp
	jmp	.L330
.L344:
	movzbl	-5056(%ebx), %eax
	cmpb	$47, %al
	jne	.L347
	subl	$8, %esp
	leal	-5056(%ebx), %eax
	addl	$1, %eax
	pushl	%eax
	leal	-5056(%ebx), %eax
	pushl	%eax
	call	strcpy
	addl	$16, %esp
.L347:
	jmp	.L348
.L349:
	movl	-10364(%ebp), %eax
	leal	2(%eax), %edx
	movl	-10364(%ebp), %eax
	addl	$1, %eax
	subl	$8, %esp
	pushl	%edx
	pushl	%eax
	call	strcpy
	addl	$16, %esp
.L348:
	subl	$8, %esp
	pushl	$.LC118
	leal	-5056(%ebx), %eax
	pushl	%eax
	call	strstr
	addl	$16, %esp
	movl	%eax, -10364(%ebp)
	cmpl	$0, -10364(%ebp)
	jne	.L349
	movl	numthrottles, %edx
	movl	maxthrottles, %eax
	cmpl	%eax, %edx
	jl	.L350
	movl	maxthrottles, %eax
	testl	%eax, %eax
	jne	.L351
	movl	$100, maxthrottles
	movl	maxthrottles, %eax
	movl	%eax, %edx
	movl	%edx, %eax
	addl	%eax, %eax
	addl	%edx, %eax
	sall	$3, %eax
	subl	$12, %esp
	pushl	%eax
	call	malloc
	addl	$16, %esp
	movl	%eax, throttles
	jmp	.L352
.L351:
	movl	maxthrottles, %eax
	addl	%eax, %eax
	movl	%eax, maxthrottles
	movl	maxthrottles, %eax
	movl	%eax, %edx
	movl	%edx, %eax
	addl	%eax, %eax
	addl	%edx, %eax
	sall	$3, %eax
	movl	%eax, %edx
	movl	throttles, %eax
	subl	$8, %esp
	pushl	%edx
	pushl	%eax
	call	realloc
	addl	$16, %esp
	movl	%eax, throttles
.L352:
	movl	throttles, %eax
	testl	%eax, %eax
	jne	.L350
	subl	$8, %esp
	pushl	$.LC119
	pushl	$2
	call	syslog
	addl	$16, %esp
	movl	argv0, %edi
	movl	$stderr, %eax
	movl	%eax, %edx
	shrl	$3, %edx
	addl	$536870912, %edx
	movzbl	(%edx), %edx
	testb	%dl, %dl
	setne	%bl
	movl	%eax, %esi
	andl	$7, %esi
	addl	$3, %esi
	movl	%esi, %ecx
	cmpb	%dl, %cl
	setge	%dl
	andl	%ebx, %edx
	testb	%dl, %dl
	je	.L353
	subl	$12, %esp
	pushl	%eax
	call	__asan_report_load4
.L353:
	movl	stderr, %eax
	subl	$4, %esp
	pushl	%edi
	pushl	$.LC120
	pushl	%eax
	call	fprintf
	addl	$16, %esp
	call	__asan_handle_no_return
	subl	$12, %esp
	pushl	$1
	call	exit
.L350:
	movl	throttles, %edx
	movl	numthrottles, %eax
	movl	%eax, %ecx
	movl	%ecx, %eax
	addl	%eax, %eax
	addl	%ecx, %eax
	sall	$3, %eax
	leal	(%edx,%eax), %edi
	subl	$12, %esp
	leal	-5056(%ebx), %eax
	pushl	%eax
	call	e_strdup
	addl	$16, %esp
	movl	%eax, -10384(%ebp)
	movl	%edi, %eax
	movl	%eax, %ecx
	movl	%ecx, %eax
	shrl	$3, %eax
	addl	$536870912, %eax
	movzbl	(%eax), %edx
	testb	%dl, %dl
	setne	%al
	movl	%eax, %esi
	movl	%ecx, %eax
	andl	$7, %eax
	addl	$3, %eax
	cmpb	%dl, %al
	setge	%al
	andl	%esi, %eax
	testb	%al, %al
	je	.L354
	subl	$12, %esp
	pushl	%ecx
	call	__asan_report_store4
.L354:
	movl	-10384(%ebp), %eax
	movl	%eax, (%edi)
	movl	throttles, %edx
	movl	numthrottles, %eax
	movl	%eax, %ecx
	movl	%ecx, %eax
	addl	%eax, %eax
	addl	%ecx, %eax
	sall	$3, %eax
	leal	(%edx,%eax), %edi
	movl	-10304(%ebx), %eax
	movl	%eax, -10384(%ebp)
	leal	4(%edi), %eax
	movl	%eax, %ecx
	movl	%ecx, %eax
	shrl	$3, %eax
	addl	$536870912, %eax
	movzbl	(%eax), %edx
	testb	%dl, %dl
	setne	%al
	movl	%eax, %esi
	movl	%ecx, %eax
	andl	$7, %eax
	addl	$3, %eax
	cmpb	%dl, %al
	setge	%al
	andl	%esi, %eax
	testb	%al, %al
	je	.L355
	subl	$12, %esp
	pushl	%ecx
	call	__asan_report_store4
.L355:
	movl	-10384(%ebp), %eax
	movl	%eax, 4(%edi)
	movl	throttles, %edx
	movl	numthrottles, %eax
	movl	%eax, %ecx
	movl	%ecx, %eax
	addl	%eax, %eax
	addl	%ecx, %eax
	sall	$3, %eax
	leal	(%edx,%eax), %edi
	movl	-10240(%ebx), %eax
	movl	%eax, -10384(%ebp)
	leal	8(%edi), %eax
	movl	%eax, %ecx
	movl	%ecx, %eax
	shrl	$3, %eax
	addl	$536870912, %eax
	movzbl	(%eax), %edx
	testb	%dl, %dl
	setne	%al
	movl	%eax, %esi
	movl	%ecx, %eax
	andl	$7, %eax
	addl	$3, %eax
	cmpb	%dl, %al
	setge	%al
	andl	%esi, %eax
	testb	%al, %al
	je	.L356
	subl	$12, %esp
	pushl	%ecx
	call	__asan_report_store4
.L356:
	movl	-10384(%ebp), %eax
	movl	%eax, 8(%edi)
	movl	throttles, %edx
	movl	numthrottles, %eax
	movl	%eax, %ecx
	movl	%ecx, %eax
	addl	%eax, %eax
	addl	%ecx, %eax
	sall	$3, %eax
	leal	(%edx,%eax), %edi
	leal	12(%edi), %eax
	movl	%eax, %ecx
	movl	%ecx, %eax
	shrl	$3, %eax
	addl	$536870912, %eax
	movzbl	(%eax), %edx
	testb	%dl, %dl
	setne	%al
	movl	%eax, %esi
	movl	%ecx, %eax
	andl	$7, %eax
	addl	$3, %eax
	cmpb	%dl, %al
	setge	%al
	andl	%esi, %eax
	testb	%al, %al
	je	.L357
	subl	$12, %esp
	pushl	%ecx
	call	__asan_report_store4
.L357:
	movl	$0, 12(%edi)
	movl	throttles, %edx
	movl	numthrottles, %eax
	movl	%eax, %ecx
	movl	%ecx, %eax
	addl	%eax, %eax
	addl	%ecx, %eax
	sall	$3, %eax
	leal	(%edx,%eax), %edi
	leal	16(%edi), %eax
	movl	%eax, %ecx
	movl	%ecx, %eax
	shrl	$3, %eax
	addl	$536870912, %eax
	movzbl	(%eax), %edx
	testb	%dl, %dl
	setne	%al
	movl	%eax, %esi
	movl	%ecx, %eax
	andl	$7, %eax
	addl	$3, %eax
	cmpb	%dl, %al
	setge	%al
	andl	%esi, %eax
	testb	%al, %al
	je	.L358
	subl	$12, %esp
	pushl	%ecx
	call	__asan_report_store4
.L358:
	movl	$0, 16(%edi)
	movl	throttles, %edx
	movl	numthrottles, %eax
	movl	%eax, %ecx
	movl	%ecx, %eax
	addl	%eax, %eax
	addl	%ecx, %eax
	sall	$3, %eax
	leal	(%edx,%eax), %edi
	leal	20(%edi), %eax
	movl	%eax, %ecx
	movl	%ecx, %eax
	shrl	$3, %eax
	addl	$536870912, %eax
	movzbl	(%eax), %edx
	testb	%dl, %dl
	setne	%al
	movl	%eax, %esi
	movl	%ecx, %eax
	andl	$7, %eax
	addl	$3, %eax
	cmpb	%dl, %al
	setge	%al
	andl	%esi, %eax
	testb	%al, %al
	je	.L359
	subl	$12, %esp
	pushl	%ecx
	call	__asan_report_store4
.L359:
	movl	$0, 20(%edi)
	movl	numthrottles, %eax
	addl	$1, %eax
	movl	%eax, numthrottles
.L330:
	subl	$4, %esp
	pushl	-10368(%ebp)
	pushl	$5000
	leal	-10112(%ebx), %eax
	pushl	%eax
	call	fgets
	addl	$16, %esp
	testl	%eax, %eax
	jne	.L360
	subl	$12, %esp
	pushl	-10368(%ebp)
	call	fclose
	addl	$16, %esp
	movl	-10380(%ebp), %edi
	cmpl	%edi, -10388(%ebp)
	je	.L324
	movl	-10380(%ebp), %eax
	movl	$1172321806, (%eax)
	subl	$4, %esp
	pushl	-10388(%ebp)
	pushl	$10336
	pushl	%eax
	call	__asan_stack_free_8
	addl	$16, %esp
	jmp	.L325
.L324:
	movl	-10392(%ebp), %eax
	addl	$536870912, %eax
	movl	$28, %ecx
	movl	$0, %ebx
	movl	%ebx, (%eax)
	movl	%ebx, -4(%eax,%ecx)
	leal	4(%eax), %edx
	andl	$-4, %edx
	subl	%edx, %eax
	addl	%eax, %ecx
	andl	$-4, %ecx
	andl	$-4, %ecx
	movl	$0, %eax
.L326:
	movl	%ebx, (%edx,%eax)
	addl	$4, %eax
	cmpl	%ecx, %eax
	jb	.L326
	addl	%eax, %edx
	movl	-10392(%ebp), %eax
	movl	$0, 536871564(%eax)
	movl	$0, 536871568(%eax)
	movl	$0, 536872196(%eax)
	movl	$0, 536872200(%eax)
.L325:
	leal	-12(%ebp), %esp
	popl	%ebx
	popl	%esi
	popl	%edi
	popl	%ebp
	ret
	.size	read_throttlefile, .-read_throttlefile
	.section	.rodata
.LC121:
	.string	"1 32 8 2 tv "
	.text
	.type	shut_down, @function
shut_down:
.LASANPC16:
	pushl	%ebp
	movl	%esp, %ebp
	pushl	%edi
	pushl	%esi
	pushl	%ebx
	subl	$140, %esp
	leal	-120(%ebp), %eax
	movl	%eax, -140(%ebp)
	movl	%eax, -148(%ebp)
	cmpl	$0, __asan_option_detect_stack_use_after_return
	je	.L361
	subl	$8, %esp
	pushl	-140(%ebp)
	pushl	$96
	call	__asan_stack_malloc_1
	addl	$16, %esp
	movl	%eax, -140(%ebp)
.L361:
	movl	-140(%ebp), %edi
	movl	%edi, %eax
	addl	$96, %eax
	movl	%eax, %ebx
	movl	%ebx, -144(%ebp)
	movl	%edi, %eax
	movl	$1102416563, (%eax)
	movl	%edi, %eax
	movl	$.LC121, 4(%eax)
	movl	$.LASANPC16, 8(%eax)
	shrl	$3, %eax
	movl	%eax, %edi
	movl	$-235802127, 536870912(%edi)
	movl	$-185273344, 536870916(%edi)
	movl	$-202116109, 536870920(%edi)
	subl	$8, %esp
	pushl	$0
	movl	%ebx, %eax
	subl	$64, %eax
	pushl	%eax
	call	gettimeofday
	addl	$16, %esp
	subl	$12, %esp
	movl	%ebx, %eax
	subl	$64, %eax
	pushl	%eax
	call	logstats
	addl	$16, %esp
	movl	$0, -128(%ebp)
	jmp	.L365
.L374:
	movl	connects, %ecx
	movl	-128(%ebp), %edx
	movl	%edx, %eax
	addl	%eax, %eax
	addl	%edx, %eax
	sall	$5, %eax
	leal	(%ecx,%eax), %esi
	movl	%esi, %eax
	movl	%eax, %ecx
	movl	%ecx, %eax
	shrl	$3, %eax
	addl	$536870912, %eax
	movzbl	(%eax), %edx
	testb	%dl, %dl
	setne	%bl
	movl	%ecx, %eax
	andl	$7, %eax
	addl	$3, %eax
	cmpb	%dl, %al
	setge	%al
	andl	%ebx, %eax
	testb	%al, %al
	je	.L366
	subl	$12, %esp
	pushl	%ecx
	call	__asan_report_load4
.L366:
	movl	(%esi), %eax
	testl	%eax, %eax
	je	.L367
	movl	connects, %ecx
	movl	-128(%ebp), %edx
	movl	%edx, %eax
	addl	%eax, %eax
	addl	%edx, %eax
	sall	$5, %eax
	leal	(%ecx,%eax), %esi
	leal	8(%esi), %eax
	movl	%eax, %ecx
	movl	%ecx, %eax
	shrl	$3, %eax
	addl	$536870912, %eax
	movzbl	(%eax), %edx
	testb	%dl, %dl
	setne	%bl
	movl	%ecx, %eax
	andl	$7, %eax
	addl	$3, %eax
	cmpb	%dl, %al
	setge	%al
	andl	%ebx, %eax
	testb	%al, %al
	je	.L368
	subl	$12, %esp
	pushl	%ecx
	call	__asan_report_load4
.L368:
	movl	8(%esi), %eax
	subl	$8, %esp
	movl	-144(%ebp), %esi
	leal	-64(%esi), %edx
	pushl	%edx
	pushl	%eax
	call	httpd_close_conn
	addl	$16, %esp
.L367:
	movl	connects, %ecx
	movl	-128(%ebp), %edx
	movl	%edx, %eax
	addl	%eax, %eax
	addl	%edx, %eax
	sall	$5, %eax
	leal	(%ecx,%eax), %esi
	leal	8(%esi), %eax
	movl	%eax, %ecx
	movl	%ecx, %eax
	shrl	$3, %eax
	addl	$536870912, %eax
	movzbl	(%eax), %edx
	testb	%dl, %dl
	setne	%bl
	movl	%ecx, %eax
	andl	$7, %eax
	addl	$3, %eax
	cmpb	%dl, %al
	setge	%al
	andl	%ebx, %eax
	testb	%al, %al
	je	.L369
	subl	$12, %esp
	pushl	%ecx
	call	__asan_report_load4
.L369:
	movl	8(%esi), %eax
	testl	%eax, %eax
	je	.L370
	movl	connects, %ecx
	movl	-128(%ebp), %edx
	movl	%edx, %eax
	addl	%eax, %eax
	addl	%edx, %eax
	sall	$5, %eax
	leal	(%ecx,%eax), %esi
	leal	8(%esi), %eax
	movl	%eax, %ecx
	movl	%ecx, %eax
	shrl	$3, %eax
	addl	$536870912, %eax
	movzbl	(%eax), %edx
	testb	%dl, %dl
	setne	%bl
	movl	%ecx, %eax
	andl	$7, %eax
	addl	$3, %eax
	cmpb	%dl, %al
	setge	%al
	andl	%ebx, %eax
	testb	%al, %al
	je	.L371
	subl	$12, %esp
	pushl	%ecx
	call	__asan_report_load4
.L371:
	movl	8(%esi), %eax
	subl	$12, %esp
	pushl	%eax
	call	httpd_destroy_conn
	addl	$16, %esp
	movl	connects, %ecx
	movl	-128(%ebp), %edx
	movl	%edx, %eax
	addl	%eax, %eax
	addl	%edx, %eax
	sall	$5, %eax
	leal	(%ecx,%eax), %esi
	leal	8(%esi), %eax
	movl	%eax, %ecx
	movl	%ecx, %eax
	shrl	$3, %eax
	addl	$536870912, %eax
	movzbl	(%eax), %edx
	testb	%dl, %dl
	setne	%bl
	movl	%ecx, %eax
	andl	$7, %eax
	addl	$3, %eax
	cmpb	%dl, %al
	setge	%al
	andl	%ebx, %eax
	testb	%al, %al
	je	.L372
	subl	$12, %esp
	pushl	%ecx
	call	__asan_report_load4
.L372:
	movl	8(%esi), %eax
	subl	$12, %esp
	pushl	%eax
	call	free
	addl	$16, %esp
	movl	httpd_conn_count, %eax
	subl	$1, %eax
	movl	%eax, httpd_conn_count
	movl	connects, %ecx
	movl	-128(%ebp), %edx
	movl	%edx, %eax
	addl	%eax, %eax
	addl	%edx, %eax
	sall	$5, %eax
	leal	(%ecx,%eax), %esi
	leal	8(%esi), %eax
	movl	%eax, %ecx
	movl	%ecx, %eax
	shrl	$3, %eax
	addl	$536870912, %eax
	movzbl	(%eax), %edx
	testb	%dl, %dl
	setne	%bl
	movl	%ecx, %eax
	andl	$7, %eax
	addl	$3, %eax
	cmpb	%dl, %al
	setge	%al
	andl	%ebx, %eax
	testb	%al, %al
	je	.L373
	subl	$12, %esp
	pushl	%ecx
	call	__asan_report_store4
.L373:
	movl	$0, 8(%esi)
.L370:
	addl	$1, -128(%ebp)
.L365:
	movl	max_connects, %eax
	cmpl	%eax, -128(%ebp)
	jl	.L374
	movl	hs, %eax
	testl	%eax, %eax
	je	.L375
	movl	hs, %eax
	movl	%eax, -124(%ebp)
	movl	$0, hs
	movl	-124(%ebp), %eax
	addl	$40, %eax
	movl	%eax, %edx
	movl	%edx, %eax
	shrl	$3, %eax
	addl	$536870912, %eax
	movzbl	(%eax), %ecx
	testb	%cl, %cl
	setne	%bl
	movl	%edx, %eax
	andl	$7, %eax
	addl	$3, %eax
	cmpb	%cl, %al
	setge	%al
	andl	%ebx, %eax
	testb	%al, %al
	je	.L376
	subl	$12, %esp
	pushl	%edx
	call	__asan_report_load4
.L376:
	movl	-124(%ebp), %eax
	movl	40(%eax), %eax
	cmpl	$-1, %eax
	je	.L377
	movl	-124(%ebp), %eax
	movl	40(%eax), %eax
	subl	$12, %esp
	pushl	%eax
	call	fdwatch_del_fd
	addl	$16, %esp
.L377:
	movl	-124(%ebp), %eax
	addl	$44, %eax
	movl	%eax, %edx
	movl	%edx, %eax
	shrl	$3, %eax
	addl	$536870912, %eax
	movzbl	(%eax), %ecx
	testb	%cl, %cl
	setne	%bl
	movl	%edx, %eax
	andl	$7, %eax
	addl	$3, %eax
	cmpb	%cl, %al
	setge	%al
	andl	%ebx, %eax
	testb	%al, %al
	je	.L378
	subl	$12, %esp
	pushl	%edx
	call	__asan_report_load4
.L378:
	movl	-124(%ebp), %eax
	movl	44(%eax), %eax
	cmpl	$-1, %eax
	je	.L379
	movl	-124(%ebp), %eax
	movl	44(%eax), %eax
	subl	$12, %esp
	pushl	%eax
	call	fdwatch_del_fd
	addl	$16, %esp
.L379:
	subl	$12, %esp
	pushl	-124(%ebp)
	call	httpd_terminate
	addl	$16, %esp
.L375:
	call	mmc_destroy
	call	tmr_destroy
	movl	connects, %eax
	subl	$12, %esp
	pushl	%eax
	call	free
	addl	$16, %esp
	movl	throttles, %eax
	testl	%eax, %eax
	je	.L364
	movl	throttles, %eax
	subl	$12, %esp
	pushl	%eax
	call	free
	addl	$16, %esp
.L364:
	movl	-140(%ebp), %esi
	cmpl	%esi, -148(%ebp)
	je	.L362
	movl	-140(%ebp), %eax
	movl	$1172321806, (%eax)
	movl	$-168430091, 536870912(%edi)
	movl	$-168430091, 536870916(%edi)
	movl	$-168430091, 536870920(%edi)
	jmp	.L363
.L362:
	movl	$0, 536870912(%edi)
	movl	$0, 536870916(%edi)
	movl	$0, 536870920(%edi)
.L363:
	leal	-12(%ebp), %esp
	popl	%ebx
	popl	%esi
	popl	%edi
	popl	%ebp
	ret
	.size	shut_down, .-shut_down
	.section	.rodata
.LC122:
	.string	"1 32 4 11 client_data "
	.align 32
.LC123:
	.string	"too many connections!"
	.zero	42
	.align 32
.LC124:
	.string	"the connects free list is messed up"
	.zero	60
	.align 32
.LC125:
	.string	"out of memory allocating an httpd_conn"
	.zero	57
	.text
	.type	handle_newconnect, @function
handle_newconnect:
.LASANPC17:
	pushl	%ebp
	movl	%esp, %ebp
	pushl	%edi
	pushl	%esi
	pushl	%ebx
	subl	$140, %esp
	leal	-120(%ebp), %eax
	movl	%eax, -140(%ebp)
	movl	%eax, -148(%ebp)
	cmpl	$0, __asan_option_detect_stack_use_after_return
	je	.L381
	subl	$8, %esp
	pushl	-140(%ebp)
	pushl	$96
	call	__asan_stack_malloc_1
	addl	$16, %esp
	movl	%eax, -140(%ebp)
.L381:
	movl	-140(%ebp), %edi
	movl	%edi, %eax
	addl	$96, %eax
	movl	%eax, -144(%ebp)
	movl	%edi, %eax
	movl	$1102416563, (%eax)
	movl	%edi, %eax
	movl	$.LC122, 4(%eax)
	movl	$.LASANPC17, 8(%eax)
	shrl	$3, %eax
	movl	%eax, %edi
	movl	$-235802127, 536870912(%edi)
	movl	$-185273340, 536870916(%edi)
	movl	$-202116109, 536870920(%edi)
.L412:
	movl	num_connects, %edx
	movl	max_connects, %eax
	cmpl	%eax, %edx
	jl	.L385
	subl	$8, %esp
	pushl	$.LC123
	pushl	$4
	call	syslog
	addl	$16, %esp
	subl	$12, %esp
	pushl	8(%ebp)
	call	tmr_run
	addl	$16, %esp
	movl	$0, %eax
	jmp	.L413
.L385:
	movl	first_free_connect, %eax
	cmpl	$-1, %eax
	je	.L387
	movl	connects, %edx
	movl	first_free_connect, %eax
	movl	%eax, %ecx
	movl	%ecx, %eax
	addl	%eax, %eax
	addl	%ecx, %eax
	sall	$5, %eax
	leal	(%edx,%eax), %esi
	movl	%esi, %eax
	movl	%eax, %ecx
	movl	%ecx, %eax
	shrl	$3, %eax
	addl	$536870912, %eax
	movzbl	(%eax), %edx
	testb	%dl, %dl
	setne	%bl
	movl	%ecx, %eax
	andl	$7, %eax
	addl	$3, %eax
	cmpb	%dl, %al
	setge	%al
	andl	%ebx, %eax
	testb	%al, %al
	je	.L388
	subl	$12, %esp
	pushl	%ecx
	call	__asan_report_load4
.L388:
	movl	(%esi), %eax
	testl	%eax, %eax
	je	.L389
.L387:
	subl	$8, %esp
	pushl	$.LC124
	pushl	$2
	call	syslog
	addl	$16, %esp
	call	__asan_handle_no_return
	subl	$12, %esp
	pushl	$1
	call	exit
.L389:
	movl	connects, %edx
	movl	first_free_connect, %eax
	movl	%eax, %ecx
	movl	%ecx, %eax
	addl	%eax, %eax
	addl	%ecx, %eax
	sall	$5, %eax
	addl	%edx, %eax
	movl	%eax, -124(%ebp)
	movl	-124(%ebp), %eax
	addl	$8, %eax
	movl	%eax, %edx
	movl	%edx, %eax
	shrl	$3, %eax
	addl	$536870912, %eax
	movzbl	(%eax), %ecx
	testb	%cl, %cl
	setne	%bl
	movl	%edx, %eax
	andl	$7, %eax
	addl	$3, %eax
	cmpb	%cl, %al
	setge	%al
	andl	%ebx, %eax
	testb	%al, %al
	je	.L390
	subl	$12, %esp
	pushl	%edx
	call	__asan_report_load4
.L390:
	movl	-124(%ebp), %eax
	movl	8(%eax), %eax
	testl	%eax, %eax
	jne	.L391
	subl	$12, %esp
	pushl	$456
	call	malloc
	addl	$16, %esp
	movl	%eax, %edx
	movl	-124(%ebp), %eax
	movl	%edx, 8(%eax)
	movl	-124(%ebp), %eax
	movl	8(%eax), %eax
	testl	%eax, %eax
	jne	.L392
	subl	$8, %esp
	pushl	$.LC125
	pushl	$2
	call	syslog
	addl	$16, %esp
	call	__asan_handle_no_return
	subl	$12, %esp
	pushl	$1
	call	exit
.L392:
	movl	-124(%ebp), %eax
	addl	$8, %eax
	movl	%eax, %edx
	movl	%edx, %eax
	shrl	$3, %eax
	addl	$536870912, %eax
	movzbl	(%eax), %ecx
	testb	%cl, %cl
	setne	%bl
	movl	%edx, %eax
	andl	$7, %eax
	addl	$3, %eax
	cmpb	%cl, %al
	setge	%al
	andl	%ebx, %eax
	testb	%al, %al
	je	.L393
	subl	$12, %esp
	pushl	%edx
	call	__asan_report_load4
.L393:
	movl	-124(%ebp), %eax
	movl	8(%eax), %esi
	movl	%esi, %eax
	movl	%eax, %ecx
	movl	%ecx, %eax
	shrl	$3, %eax
	addl	$536870912, %eax
	movzbl	(%eax), %edx
	testb	%dl, %dl
	setne	%bl
	movl	%ecx, %eax
	andl	$7, %eax
	addl	$3, %eax
	cmpb	%dl, %al
	setge	%al
	andl	%ebx, %eax
	testb	%al, %al
	je	.L394
	subl	$12, %esp
	pushl	%ecx
	call	__asan_report_store4
.L394:
	movl	$0, (%esi)
	movl	httpd_conn_count, %eax
	addl	$1, %eax
	movl	%eax, httpd_conn_count
.L391:
	movl	-124(%ebp), %eax
	addl	$8, %eax
	movl	%eax, %edx
	movl	%edx, %eax
	shrl	$3, %eax
	addl	$536870912, %eax
	movzbl	(%eax), %ecx
	testb	%cl, %cl
	setne	%bl
	movl	%edx, %eax
	andl	$7, %eax
	addl	$3, %eax
	cmpb	%cl, %al
	setge	%al
	andl	%ebx, %eax
	testb	%al, %al
	je	.L395
	subl	$12, %esp
	pushl	%edx
	call	__asan_report_load4
.L395:
	movl	-124(%ebp), %eax
	movl	8(%eax), %edx
	movl	hs, %eax
	subl	$4, %esp
	pushl	%edx
	pushl	12(%ebp)
	pushl	%eax
	call	httpd_get_conn
	addl	$16, %esp
	testl	%eax, %eax
	je	.L397
	cmpl	$2, %eax
	je	.L398
	jmp	.L414
.L397:
	subl	$12, %esp
	pushl	8(%ebp)
	call	tmr_run
	addl	$16, %esp
	movl	$0, %eax
	jmp	.L413
.L398:
	movl	$1, %eax
	jmp	.L413
.L414:
	movl	-124(%ebp), %eax
	movl	%eax, %edx
	movl	%edx, %eax
	shrl	$3, %eax
	addl	$536870912, %eax
	movzbl	(%eax), %ecx
	testb	%cl, %cl
	setne	%bl
	movl	%edx, %eax
	andl	$7, %eax
	addl	$3, %eax
	cmpb	%cl, %al
	setge	%al
	andl	%ebx, %eax
	testb	%al, %al
	je	.L399
	subl	$12, %esp
	pushl	%edx
	call	__asan_report_store4
.L399:
	movl	-124(%ebp), %eax
	movl	$1, (%eax)
	movl	-124(%ebp), %eax
	addl	$4, %eax
	movl	%eax, %edx
	movl	%edx, %eax
	shrl	$3, %eax
	addl	$536870912, %eax
	movzbl	(%eax), %ecx
	testb	%cl, %cl
	setne	%bl
	movl	%edx, %eax
	andl	$7, %eax
	addl	$3, %eax
	cmpb	%cl, %al
	setge	%al
	andl	%ebx, %eax
	testb	%al, %al
	je	.L400
	subl	$12, %esp
	pushl	%edx
	call	__asan_report_load4
.L400:
	movl	-124(%ebp), %eax
	movl	4(%eax), %eax
	movl	%eax, first_free_connect
	movl	-124(%ebp), %eax
	movl	$-1, 4(%eax)
	movl	num_connects, %eax
	addl	$1, %eax
	movl	%eax, num_connects
	movl	-124(%ebp), %eax
	movl	-144(%ebp), %esi
	movl	%eax, -64(%esi)
	movl	8(%ebp), %eax
	movl	%eax, %edx
	movl	%edx, %eax
	shrl	$3, %eax
	addl	$536870912, %eax
	movzbl	(%eax), %ecx
	testb	%cl, %cl
	setne	%bl
	movl	%edx, %eax
	andl	$7, %eax
	addl	$3, %eax
	cmpb	%cl, %al
	setge	%al
	andl	%ebx, %eax
	testb	%al, %al
	je	.L401
	subl	$12, %esp
	pushl	%edx
	call	__asan_report_load4
.L401:
	movl	8(%ebp), %eax
	movl	(%eax), %esi
	movl	-124(%ebp), %eax
	addl	$68, %eax
	movl	%eax, %ecx
	movl	%ecx, %eax
	shrl	$3, %eax
	addl	$536870912, %eax
	movzbl	(%eax), %edx
	testb	%dl, %dl
	setne	%bl
	movl	%ecx, %eax
	andl	$7, %eax
	addl	$3, %eax
	cmpb	%dl, %al
	setge	%al
	andl	%ebx, %eax
	testb	%al, %al
	je	.L402
	subl	$12, %esp
	pushl	%ecx
	call	__asan_report_store4
.L402:
	movl	-124(%ebp), %eax
	movl	%esi, 68(%eax)
	movl	-124(%ebp), %eax
	addl	$72, %eax
	movl	%eax, %edx
	movl	%edx, %eax
	shrl	$3, %eax
	addl	$536870912, %eax
	movzbl	(%eax), %ecx
	testb	%cl, %cl
	setne	%bl
	movl	%edx, %eax
	andl	$7, %eax
	addl	$3, %eax
	cmpb	%cl, %al
	setge	%al
	andl	%ebx, %eax
	testb	%al, %al
	je	.L403
	subl	$12, %esp
	pushl	%edx
	call	__asan_report_store4
.L403:
	movl	-124(%ebp), %eax
	movl	$0, 72(%eax)
	movl	-124(%ebp), %eax
	addl	$76, %eax
	movl	%eax, %edx
	movl	%edx, %eax
	shrl	$3, %eax
	addl	$536870912, %eax
	movzbl	(%eax), %ecx
	testb	%cl, %cl
	setne	%bl
	movl	%edx, %eax
	andl	$7, %eax
	addl	$3, %eax
	cmpb	%cl, %al
	setge	%al
	andl	%ebx, %eax
	testb	%al, %al
	je	.L404
	subl	$12, %esp
	pushl	%edx
	call	__asan_report_store4
.L404:
	movl	-124(%ebp), %eax
	movl	$0, 76(%eax)
	movl	-124(%ebp), %eax
	addl	$92, %eax
	movl	%eax, %edx
	movl	%edx, %eax
	shrl	$3, %eax
	addl	$536870912, %eax
	movzbl	(%eax), %ecx
	testb	%cl, %cl
	setne	%bl
	movl	%edx, %eax
	andl	$7, %eax
	addl	$3, %eax
	cmpb	%cl, %al
	setge	%al
	andl	%ebx, %eax
	testb	%al, %al
	je	.L405
	subl	$12, %esp
	pushl	%edx
	call	__asan_report_store4
.L405:
	movl	-124(%ebp), %eax
	movl	$0, 92(%eax)
	movl	-124(%ebp), %eax
	addl	$52, %eax
	movl	%eax, %edx
	movl	%edx, %eax
	shrl	$3, %eax
	addl	$536870912, %eax
	movzbl	(%eax), %ecx
	testb	%cl, %cl
	setne	%bl
	movl	%edx, %eax
	andl	$7, %eax
	addl	$3, %eax
	cmpb	%cl, %al
	setge	%al
	andl	%ebx, %eax
	testb	%al, %al
	je	.L406
	subl	$12, %esp
	pushl	%edx
	call	__asan_report_store4
.L406:
	movl	-124(%ebp), %eax
	movl	$0, 52(%eax)
	movl	-124(%ebp), %eax
	addl	$8, %eax
	movl	%eax, %edx
	movl	%edx, %eax
	shrl	$3, %eax
	addl	$536870912, %eax
	movzbl	(%eax), %ecx
	testb	%cl, %cl
	setne	%bl
	movl	%edx, %eax
	andl	$7, %eax
	addl	$3, %eax
	cmpb	%cl, %al
	setge	%al
	andl	%ebx, %eax
	testb	%al, %al
	je	.L407
	subl	$12, %esp
	pushl	%edx
	call	__asan_report_load4
.L407:
	movl	-124(%ebp), %eax
	movl	8(%eax), %ebx
	leal	448(%ebx), %eax
	movl	%eax, %ecx
	movl	%ecx, %eax
	shrl	$3, %eax
	addl	$536870912, %eax
	movzbl	(%eax), %edx
	testb	%dl, %dl
	setne	%al
	movl	%eax, %esi
	movl	%ecx, %eax
	andl	$7, %eax
	addl	$3, %eax
	cmpb	%dl, %al
	setge	%al
	andl	%esi, %eax
	testb	%al, %al
	je	.L408
	subl	$12, %esp
	pushl	%ecx
	call	__asan_report_load4
.L408:
	movl	448(%ebx), %eax
	subl	$12, %esp
	pushl	%eax
	call	httpd_set_ndelay
	addl	$16, %esp
	movl	-124(%ebp), %eax
	addl	$8, %eax
	movl	%eax, %edx
	movl	%edx, %eax
	shrl	$3, %eax
	addl	$536870912, %eax
	movzbl	(%eax), %ecx
	testb	%cl, %cl
	setne	%bl
	movl	%edx, %eax
	andl	$7, %eax
	addl	$3, %eax
	cmpb	%cl, %al
	setge	%al
	andl	%ebx, %eax
	testb	%al, %al
	je	.L409
	subl	$12, %esp
	pushl	%edx
	call	__asan_report_load4
.L409:
	movl	-124(%ebp), %eax
	movl	8(%eax), %ebx
	leal	448(%ebx), %eax
	movl	%eax, %ecx
	movl	%ecx, %eax
	shrl	$3, %eax
	addl	$536870912, %eax
	movzbl	(%eax), %edx
	testb	%dl, %dl
	setne	%al
	movl	%eax, %esi
	movl	%ecx, %eax
	andl	$7, %eax
	addl	$3, %eax
	cmpb	%dl, %al
	setge	%al
	andl	%esi, %eax
	testb	%al, %al
	je	.L410
	subl	$12, %esp
	pushl	%ecx
	call	__asan_report_load4
.L410:
	movl	448(%ebx), %eax
	subl	$4, %esp
	pushl	$0
	pushl	-124(%ebp)
	pushl	%eax
	call	fdwatch_add_fd
	addl	$16, %esp
	movl	stats_connections, %eax
	addl	$1, %eax
	movl	%eax, stats_connections
	movl	num_connects, %edx
	movl	stats_simultaneous, %eax
	cmpl	%eax, %edx
	jle	.L411
	movl	num_connects, %eax
	movl	%eax, stats_simultaneous
.L411:
	jmp	.L412
.L413:
	movl	-140(%ebp), %ebx
	cmpl	%ebx, -148(%ebp)
	je	.L382
	movl	-140(%ebp), %esi
	movl	$1172321806, (%esi)
	movl	$-168430091, 536870912(%edi)
	movl	$-168430091, 536870916(%edi)
	movl	$-168430091, 536870920(%edi)
	jmp	.L383
.L382:
	movl	$0, 536870912(%edi)
	movl	$0, 536870916(%edi)
	movl	$0, 536870920(%edi)
.L383:
	leal	-12(%ebp), %esp
	popl	%ebx
	popl	%esi
	popl	%edi
	popl	%ebp
	ret
	.size	handle_newconnect, .-handle_newconnect
	.type	handle_read, @function
handle_read:
.LASANPC18:
	pushl	%ebp
	movl	%esp, %ebp
	pushl	%edi
	pushl	%esi
	pushl	%ebx
	subl	$140, %esp
	leal	-120(%ebp), %eax
	movl	%eax, -140(%ebp)
	movl	%eax, -152(%ebp)
	cmpl	$0, __asan_option_detect_stack_use_after_return
	je	.L415
	subl	$8, %esp
	pushl	-140(%ebp)
	pushl	$96
	call	__asan_stack_malloc_1
	addl	$16, %esp
	movl	%eax, -140(%ebp)
.L415:
	movl	-140(%ebp), %edi
	movl	%edi, %eax
	addl	$96, %eax
	movl	%eax, -148(%ebp)
	movl	%edi, %eax
	movl	$1102416563, (%eax)
	movl	%edi, %eax
	movl	$.LC122, 4(%eax)
	movl	$.LASANPC18, 8(%eax)
	shrl	$3, %eax
	movl	%eax, -144(%ebp)
	movl	$-235802127, 536870912(%eax)
	movl	$-185273340, 536870916(%eax)
	movl	$-202116109, 536870920(%eax)
	movl	8(%ebp), %eax
	addl	$8, %eax
	movl	%eax, %edx
	movl	%edx, %eax
	shrl	$3, %eax
	addl	$536870912, %eax
	movzbl	(%eax), %ecx
	testb	%cl, %cl
	setne	%bl
	movl	%edx, %eax
	andl	$7, %eax
	addl	$3, %eax
	cmpb	%cl, %al
	setge	%al
	andl	%ebx, %eax
	testb	%al, %al
	je	.L419
	subl	$12, %esp
	pushl	%edx
	call	__asan_report_load4
.L419:
	movl	8(%ebp), %eax
	movl	8(%eax), %eax
	movl	%eax, -128(%ebp)
	movl	-128(%ebp), %eax
	addl	$144, %eax
	movl	%eax, %edx
	movl	%edx, %eax
	shrl	$3, %eax
	addl	$536870912, %eax
	movzbl	(%eax), %ecx
	testb	%cl, %cl
	setne	%bl
	movl	%edx, %eax
	andl	$7, %eax
	addl	$3, %eax
	cmpb	%cl, %al
	setge	%al
	andl	%ebx, %eax
	testb	%al, %al
	je	.L420
	subl	$12, %esp
	pushl	%edx
	call	__asan_report_load4
.L420:
	movl	-128(%ebp), %eax
	movl	144(%eax), %esi
	movl	-128(%ebp), %eax
	addl	$140, %eax
	movl	%eax, %ecx
	movl	%ecx, %eax
	shrl	$3, %eax
	addl	$536870912, %eax
	movzbl	(%eax), %edx
	testb	%dl, %dl
	setne	%bl
	movl	%ecx, %eax
	andl	$7, %eax
	addl	$3, %eax
	cmpb	%dl, %al
	setge	%al
	andl	%ebx, %eax
	testb	%al, %al
	je	.L421
	subl	$12, %esp
	pushl	%ecx
	call	__asan_report_load4
.L421:
	movl	-128(%ebp), %eax
	movl	140(%eax), %eax
	cmpl	%eax, %esi
	jb	.L422
	movl	-128(%ebp), %eax
	movl	140(%eax), %eax
	cmpl	$5000, %eax
	jbe	.L423
	movl	$httpd_err400form, %eax
	movl	%eax, %edx
	movl	%edx, %eax
	shrl	$3, %eax
	addl	$536870912, %eax
	movzbl	(%eax), %ecx
	testb	%cl, %cl
	setne	%bl
	movl	%edx, %eax
	andl	$7, %eax
	addl	$3, %eax
	cmpb	%cl, %al
	setge	%al
	andl	%ebx, %eax
	testb	%al, %al
	je	.L424
	subl	$12, %esp
	pushl	%edx
	call	__asan_report_load4
.L424:
	movl	httpd_err400form, %ebx
	movl	$httpd_err400title, %eax
	movl	%eax, %edx
	movl	%edx, %eax
	shrl	$3, %eax
	addl	$536870912, %eax
	movzbl	(%eax), %ecx
	testb	%cl, %cl
	setne	%al
	movl	%eax, %esi
	movl	%edx, %eax
	andl	$7, %eax
	addl	$3, %eax
	cmpb	%cl, %al
	setge	%al
	andl	%esi, %eax
	testb	%al, %al
	je	.L425
	subl	$12, %esp
	pushl	%edx
	call	__asan_report_load4
.L425:
	movl	httpd_err400title, %eax
	subl	$8, %esp
	pushl	$.LC48
	pushl	%ebx
	pushl	$.LC48
	pushl	%eax
	pushl	$400
	pushl	-128(%ebp)
	call	httpd_send_err
	addl	$32, %esp
	subl	$8, %esp
	pushl	12(%ebp)
	pushl	8(%ebp)
	call	finish_connection
	addl	$16, %esp
	jmp	.L418
.L423:
	movl	-128(%ebp), %eax
	addl	$140, %eax
	movl	%eax, %edx
	movl	%edx, %eax
	shrl	$3, %eax
	addl	$536870912, %eax
	movzbl	(%eax), %ecx
	testb	%cl, %cl
	setne	%bl
	movl	%edx, %eax
	andl	$7, %eax
	addl	$3, %eax
	cmpb	%cl, %al
	setge	%al
	andl	%ebx, %eax
	testb	%al, %al
	je	.L427
	subl	$12, %esp
	pushl	%edx
	call	__asan_report_load4
.L427:
	movl	-128(%ebp), %eax
	movl	140(%eax), %eax
	leal	1000(%eax), %ecx
	movl	-128(%ebp), %eax
	leal	140(%eax), %edx
	movl	-128(%ebp), %eax
	addl	$136, %eax
	subl	$4, %esp
	pushl	%ecx
	pushl	%edx
	pushl	%eax
	call	httpd_realloc_str
	addl	$16, %esp
.L422:
	movl	-128(%ebp), %eax
	addl	$140, %eax
	movl	%eax, %edx
	movl	%edx, %eax
	shrl	$3, %eax
	addl	$536870912, %eax
	movzbl	(%eax), %ecx
	testb	%cl, %cl
	setne	%bl
	movl	%edx, %eax
	andl	$7, %eax
	addl	$3, %eax
	cmpb	%cl, %al
	setge	%al
	andl	%ebx, %eax
	testb	%al, %al
	je	.L428
	subl	$12, %esp
	pushl	%edx
	call	__asan_report_load4
.L428:
	movl	-128(%ebp), %eax
	movl	140(%eax), %esi
	movl	-128(%ebp), %eax
	addl	$144, %eax
	movl	%eax, %ecx
	movl	%ecx, %eax
	shrl	$3, %eax
	addl	$536870912, %eax
	movzbl	(%eax), %edx
	testb	%dl, %dl
	setne	%bl
	movl	%ecx, %eax
	andl	$7, %eax
	addl	$3, %eax
	cmpb	%dl, %al
	setge	%al
	andl	%ebx, %eax
	testb	%al, %al
	je	.L429
	subl	$12, %esp
	pushl	%ecx
	call	__asan_report_load4
.L429:
	movl	-128(%ebp), %eax
	movl	144(%eax), %eax
	movl	%esi, %edi
	subl	%eax, %edi
	movl	-128(%ebp), %eax
	addl	$136, %eax
	movl	%eax, %ecx
	movl	%ecx, %eax
	shrl	$3, %eax
	addl	$536870912, %eax
	movzbl	(%eax), %edx
	testb	%dl, %dl
	setne	%bl
	movl	%ecx, %eax
	andl	$7, %eax
	addl	$3, %eax
	cmpb	%dl, %al
	setge	%al
	andl	%ebx, %eax
	testb	%al, %al
	je	.L430
	subl	$12, %esp
	pushl	%ecx
	call	__asan_report_load4
.L430:
	movl	-128(%ebp), %eax
	movl	136(%eax), %edx
	movl	-128(%ebp), %eax
	movl	144(%eax), %eax
	leal	(%edx,%eax), %esi
	movl	-128(%ebp), %eax
	addl	$448, %eax
	movl	%eax, %ecx
	movl	%ecx, %eax
	shrl	$3, %eax
	addl	$536870912, %eax
	movzbl	(%eax), %edx
	testb	%dl, %dl
	setne	%bl
	movl	%ecx, %eax
	andl	$7, %eax
	addl	$3, %eax
	cmpb	%dl, %al
	setge	%al
	andl	%ebx, %eax
	testb	%al, %al
	je	.L431
	subl	$12, %esp
	pushl	%ecx
	call	__asan_report_load4
.L431:
	movl	-128(%ebp), %eax
	movl	448(%eax), %eax
	subl	$4, %esp
	pushl	%edi
	pushl	%esi
	pushl	%eax
	call	read
	addl	$16, %esp
	movl	%eax, -124(%ebp)
	cmpl	$0, -124(%ebp)
	jne	.L432
	movl	$httpd_err400form, %eax
	movl	%eax, %edx
	movl	%edx, %eax
	shrl	$3, %eax
	addl	$536870912, %eax
	movzbl	(%eax), %ecx
	testb	%cl, %cl
	setne	%bl
	movl	%edx, %eax
	andl	$7, %eax
	addl	$3, %eax
	cmpb	%cl, %al
	setge	%al
	andl	%ebx, %eax
	testb	%al, %al
	je	.L433
	subl	$12, %esp
	pushl	%edx
	call	__asan_report_load4
.L433:
	movl	httpd_err400form, %ebx
	movl	$httpd_err400title, %eax
	movl	%eax, %edx
	movl	%edx, %eax
	shrl	$3, %eax
	addl	$536870912, %eax
	movzbl	(%eax), %ecx
	testb	%cl, %cl
	setne	%al
	movl	%eax, %esi
	movl	%edx, %eax
	andl	$7, %eax
	addl	$3, %eax
	cmpb	%cl, %al
	setge	%al
	andl	%esi, %eax
	testb	%al, %al
	je	.L434
	subl	$12, %esp
	pushl	%edx
	call	__asan_report_load4
.L434:
	movl	httpd_err400title, %eax
	subl	$8, %esp
	pushl	$.LC48
	pushl	%ebx
	pushl	$.LC48
	pushl	%eax
	pushl	$400
	pushl	-128(%ebp)
	call	httpd_send_err
	addl	$32, %esp
	subl	$8, %esp
	pushl	12(%ebp)
	pushl	8(%ebp)
	call	finish_connection
	addl	$16, %esp
	jmp	.L418
.L432:
	cmpl	$0, -124(%ebp)
	jns	.L435
	call	__errno_location
	movl	%eax, %ebx
	movl	%ebx, %edx
	movl	%edx, %eax
	shrl	$3, %eax
	addl	$536870912, %eax
	movzbl	(%eax), %ecx
	testb	%cl, %cl
	setne	%al
	movl	%eax, %esi
	movl	%edx, %eax
	andl	$7, %eax
	addl	$3, %eax
	cmpb	%cl, %al
	setge	%al
	andl	%esi, %eax
	testb	%al, %al
	je	.L436
	subl	$12, %esp
	pushl	%edx
	call	__asan_report_load4
.L436:
	movl	(%ebx), %eax
	cmpl	$4, %eax
	je	.L437
	call	__errno_location
	movl	%eax, %ebx
	movl	%ebx, %edx
	movl	%edx, %eax
	shrl	$3, %eax
	addl	$536870912, %eax
	movzbl	(%eax), %ecx
	testb	%cl, %cl
	setne	%al
	movl	%eax, %esi
	movl	%edx, %eax
	andl	$7, %eax
	addl	$3, %eax
	cmpb	%cl, %al
	setge	%al
	andl	%esi, %eax
	testb	%al, %al
	je	.L438
	subl	$12, %esp
	pushl	%edx
	call	__asan_report_load4
.L438:
	movl	(%ebx), %eax
	cmpl	$11, %eax
	je	.L437
	call	__errno_location
	movl	%eax, %ebx
	movl	%ebx, %edx
	movl	%edx, %eax
	shrl	$3, %eax
	addl	$536870912, %eax
	movzbl	(%eax), %ecx
	testb	%cl, %cl
	setne	%al
	movl	%eax, %esi
	movl	%edx, %eax
	andl	$7, %eax
	addl	$3, %eax
	cmpb	%cl, %al
	setge	%al
	andl	%esi, %eax
	testb	%al, %al
	je	.L439
	subl	$12, %esp
	pushl	%edx
	call	__asan_report_load4
.L439:
	movl	(%ebx), %eax
	cmpl	$11, %eax
	jne	.L440
.L437:
	jmp	.L418
.L440:
	movl	$httpd_err400form, %eax
	movl	%eax, %edx
	movl	%edx, %eax
	shrl	$3, %eax
	addl	$536870912, %eax
	movzbl	(%eax), %ecx
	testb	%cl, %cl
	setne	%bl
	movl	%edx, %eax
	andl	$7, %eax
	addl	$3, %eax
	cmpb	%cl, %al
	setge	%al
	andl	%ebx, %eax
	testb	%al, %al
	je	.L441
	subl	$12, %esp
	pushl	%edx
	call	__asan_report_load4
.L441:
	movl	httpd_err400form, %ebx
	movl	$httpd_err400title, %eax
	movl	%eax, %edx
	movl	%edx, %eax
	shrl	$3, %eax
	addl	$536870912, %eax
	movzbl	(%eax), %ecx
	testb	%cl, %cl
	setne	%al
	movl	%eax, %esi
	movl	%edx, %eax
	andl	$7, %eax
	addl	$3, %eax
	cmpb	%cl, %al
	setge	%al
	andl	%esi, %eax
	testb	%al, %al
	je	.L442
	subl	$12, %esp
	pushl	%edx
	call	__asan_report_load4
.L442:
	movl	httpd_err400title, %eax
	subl	$8, %esp
	pushl	$.LC48
	pushl	%ebx
	pushl	$.LC48
	pushl	%eax
	pushl	$400
	pushl	-128(%ebp)
	call	httpd_send_err
	addl	$32, %esp
	subl	$8, %esp
	pushl	12(%ebp)
	pushl	8(%ebp)
	call	finish_connection
	addl	$16, %esp
	jmp	.L418
.L435:
	movl	-128(%ebp), %eax
	addl	$144, %eax
	movl	%eax, %edx
	movl	%edx, %eax
	shrl	$3, %eax
	addl	$536870912, %eax
	movzbl	(%eax), %ecx
	testb	%cl, %cl
	setne	%bl
	movl	%edx, %eax
	andl	$7, %eax
	addl	$3, %eax
	cmpb	%cl, %al
	setge	%al
	andl	%ebx, %eax
	testb	%al, %al
	je	.L443
	subl	$12, %esp
	pushl	%edx
	call	__asan_report_load4
.L443:
	movl	-128(%ebp), %eax
	movl	144(%eax), %edx
	movl	-124(%ebp), %eax
	addl	%eax, %edx
	movl	-128(%ebp), %eax
	movl	%edx, 144(%eax)
	movl	12(%ebp), %eax
	movl	%eax, %edx
	movl	%edx, %eax
	shrl	$3, %eax
	addl	$536870912, %eax
	movzbl	(%eax), %ecx
	testb	%cl, %cl
	setne	%bl
	movl	%edx, %eax
	andl	$7, %eax
	addl	$3, %eax
	cmpb	%cl, %al
	setge	%al
	andl	%ebx, %eax
	testb	%al, %al
	je	.L444
	subl	$12, %esp
	pushl	%edx
	call	__asan_report_load4
.L444:
	movl	12(%ebp), %eax
	movl	(%eax), %esi
	movl	8(%ebp), %eax
	addl	$68, %eax
	movl	%eax, %ecx
	movl	%ecx, %eax
	shrl	$3, %eax
	addl	$536870912, %eax
	movzbl	(%eax), %edx
	testb	%dl, %dl
	setne	%bl
	movl	%ecx, %eax
	andl	$7, %eax
	addl	$3, %eax
	cmpb	%dl, %al
	setge	%al
	andl	%ebx, %eax
	testb	%al, %al
	je	.L445
	subl	$12, %esp
	pushl	%ecx
	call	__asan_report_store4
.L445:
	movl	8(%ebp), %eax
	movl	%esi, 68(%eax)
	subl	$12, %esp
	pushl	-128(%ebp)
	call	httpd_got_request
	addl	$16, %esp
	testl	%eax, %eax
	je	.L491
	cmpl	$2, %eax
	jne	.L490
	movl	$httpd_err400form, %eax
	movl	%eax, %edx
	movl	%edx, %eax
	shrl	$3, %eax
	addl	$536870912, %eax
	movzbl	(%eax), %ecx
	testb	%cl, %cl
	setne	%bl
	movl	%edx, %eax
	andl	$7, %eax
	addl	$3, %eax
	cmpb	%cl, %al
	setge	%al
	andl	%ebx, %eax
	testb	%al, %al
	je	.L449
	subl	$12, %esp
	pushl	%edx
	call	__asan_report_load4
.L449:
	movl	httpd_err400form, %ebx
	movl	$httpd_err400title, %eax
	movl	%eax, %edx
	movl	%edx, %eax
	shrl	$3, %eax
	addl	$536870912, %eax
	movzbl	(%eax), %ecx
	testb	%cl, %cl
	setne	%al
	movl	%eax, %esi
	movl	%edx, %eax
	andl	$7, %eax
	addl	$3, %eax
	cmpb	%cl, %al
	setge	%al
	andl	%esi, %eax
	testb	%al, %al
	je	.L450
	subl	$12, %esp
	pushl	%edx
	call	__asan_report_load4
.L450:
	movl	httpd_err400title, %eax
	subl	$8, %esp
	pushl	$.LC48
	pushl	%ebx
	pushl	$.LC48
	pushl	%eax
	pushl	$400
	pushl	-128(%ebp)
	call	httpd_send_err
	addl	$32, %esp
	subl	$8, %esp
	pushl	12(%ebp)
	pushl	8(%ebp)
	call	finish_connection
	addl	$16, %esp
	jmp	.L418
.L490:
	subl	$12, %esp
	pushl	-128(%ebp)
	call	httpd_parse_request
	addl	$16, %esp
	testl	%eax, %eax
	jns	.L451
	subl	$8, %esp
	pushl	12(%ebp)
	pushl	8(%ebp)
	call	finish_connection
	addl	$16, %esp
	jmp	.L418
.L451:
	subl	$12, %esp
	pushl	8(%ebp)
	call	check_throttles
	addl	$16, %esp
	testl	%eax, %eax
	jne	.L452
	movl	-128(%ebp), %eax
	addl	$172, %eax
	movl	%eax, %edx
	movl	%edx, %eax
	shrl	$3, %eax
	addl	$536870912, %eax
	movzbl	(%eax), %ecx
	testb	%cl, %cl
	setne	%bl
	movl	%edx, %eax
	andl	$7, %eax
	addl	$3, %eax
	cmpb	%cl, %al
	setge	%al
	andl	%ebx, %eax
	testb	%al, %al
	je	.L453
	subl	$12, %esp
	pushl	%edx
	call	__asan_report_load4
.L453:
	movl	-128(%ebp), %eax
	movl	172(%eax), %edi
	movl	$httpd_err503form, %eax
	movl	%eax, %edx
	movl	%edx, %eax
	shrl	$3, %eax
	addl	$536870912, %eax
	movzbl	(%eax), %ecx
	testb	%cl, %cl
	setne	%bl
	movl	%edx, %eax
	andl	$7, %eax
	addl	$3, %eax
	cmpb	%cl, %al
	setge	%al
	andl	%ebx, %eax
	testb	%al, %al
	je	.L454
	subl	$12, %esp
	pushl	%edx
	call	__asan_report_load4
.L454:
	movl	httpd_err503form, %esi
	movl	$httpd_err503title, %eax
	movl	%eax, %ecx
	movl	%ecx, %eax
	shrl	$3, %eax
	addl	$536870912, %eax
	movzbl	(%eax), %edx
	testb	%dl, %dl
	setne	%bl
	movl	%ecx, %eax
	andl	$7, %eax
	addl	$3, %eax
	cmpb	%dl, %al
	setge	%al
	andl	%ebx, %eax
	testb	%al, %al
	je	.L455
	subl	$12, %esp
	pushl	%ecx
	call	__asan_report_load4
.L455:
	movl	httpd_err503title, %eax
	subl	$8, %esp
	pushl	%edi
	pushl	%esi
	pushl	$.LC48
	pushl	%eax
	pushl	$503
	pushl	-128(%ebp)
	call	httpd_send_err
	addl	$32, %esp
	subl	$8, %esp
	pushl	12(%ebp)
	pushl	8(%ebp)
	call	finish_connection
	addl	$16, %esp
	jmp	.L418
.L452:
	subl	$8, %esp
	pushl	12(%ebp)
	pushl	-128(%ebp)
	call	httpd_start_request
	addl	$16, %esp
	testl	%eax, %eax
	jns	.L456
	subl	$8, %esp
	pushl	12(%ebp)
	pushl	8(%ebp)
	call	finish_connection
	addl	$16, %esp
	jmp	.L418
.L456:
	movl	-128(%ebp), %eax
	addl	$336, %eax
	movl	%eax, %edx
	movl	%edx, %eax
	shrl	$3, %eax
	addl	$536870912, %eax
	movzbl	(%eax), %ecx
	testb	%cl, %cl
	setne	%bl
	movl	%edx, %eax
	andl	$7, %eax
	addl	$3, %eax
	cmpb	%cl, %al
	setge	%al
	andl	%ebx, %eax
	testb	%al, %al
	je	.L457
	subl	$12, %esp
	pushl	%edx
	call	__asan_report_load4
.L457:
	movl	-128(%ebp), %eax
	movl	336(%eax), %eax
	testl	%eax, %eax
	je	.L458
	movl	-128(%ebp), %eax
	addl	$344, %eax
	movl	%eax, %edx
	movl	%edx, %eax
	shrl	$3, %eax
	addl	$536870912, %eax
	movzbl	(%eax), %ecx
	testb	%cl, %cl
	setne	%bl
	movl	%edx, %eax
	andl	$7, %eax
	addl	$3, %eax
	cmpb	%cl, %al
	setge	%al
	andl	%ebx, %eax
	testb	%al, %al
	je	.L459
	subl	$12, %esp
	pushl	%edx
	call	__asan_report_load4
.L459:
	movl	-128(%ebp), %eax
	movl	344(%eax), %esi
	movl	8(%ebp), %eax
	addl	$92, %eax
	movl	%eax, %ecx
	movl	%ecx, %eax
	shrl	$3, %eax
	addl	$536870912, %eax
	movzbl	(%eax), %edx
	testb	%dl, %dl
	setne	%bl
	movl	%ecx, %eax
	andl	$7, %eax
	addl	$3, %eax
	cmpb	%dl, %al
	setge	%al
	andl	%ebx, %eax
	testb	%al, %al
	je	.L460
	subl	$12, %esp
	pushl	%ecx
	call	__asan_report_store4
.L460:
	movl	8(%ebp), %eax
	movl	%esi, 92(%eax)
	movl	-128(%ebp), %eax
	addl	$348, %eax
	movl	%eax, %edx
	movl	%edx, %eax
	shrl	$3, %eax
	addl	$536870912, %eax
	movzbl	(%eax), %ecx
	testb	%cl, %cl
	setne	%bl
	movl	%edx, %eax
	andl	$7, %eax
	addl	$3, %eax
	cmpb	%cl, %al
	setge	%al
	andl	%ebx, %eax
	testb	%al, %al
	je	.L461
	subl	$12, %esp
	pushl	%edx
	call	__asan_report_load4
.L461:
	movl	-128(%ebp), %eax
	movl	348(%eax), %eax
	leal	1(%eax), %esi
	movl	8(%ebp), %eax
	addl	$88, %eax
	movl	%eax, %ecx
	movl	%ecx, %eax
	shrl	$3, %eax
	addl	$536870912, %eax
	movzbl	(%eax), %edx
	testb	%dl, %dl
	setne	%bl
	movl	%ecx, %eax
	andl	$7, %eax
	addl	$3, %eax
	cmpb	%dl, %al
	setge	%al
	andl	%ebx, %eax
	testb	%al, %al
	je	.L462
	subl	$12, %esp
	pushl	%ecx
	call	__asan_report_store4
.L462:
	movl	8(%ebp), %eax
	movl	%esi, 88(%eax)
	jmp	.L463
.L458:
	movl	-128(%ebp), %eax
	addl	$164, %eax
	movl	%eax, %edx
	movl	%edx, %eax
	shrl	$3, %eax
	addl	$536870912, %eax
	movzbl	(%eax), %ecx
	testb	%cl, %cl
	setne	%bl
	movl	%edx, %eax
	andl	$7, %eax
	addl	$3, %eax
	cmpb	%cl, %al
	setge	%al
	andl	%ebx, %eax
	testb	%al, %al
	je	.L464
	subl	$12, %esp
	pushl	%edx
	call	__asan_report_load4
.L464:
	movl	-128(%ebp), %eax
	movl	164(%eax), %eax
	testl	%eax, %eax
	jns	.L465
	movl	8(%ebp), %eax
	addl	$88, %eax
	movl	%eax, %edx
	movl	%edx, %eax
	shrl	$3, %eax
	addl	$536870912, %eax
	movzbl	(%eax), %ecx
	testb	%cl, %cl
	setne	%bl
	movl	%edx, %eax
	andl	$7, %eax
	addl	$3, %eax
	cmpb	%cl, %al
	setge	%al
	andl	%ebx, %eax
	testb	%al, %al
	je	.L466
	subl	$12, %esp
	pushl	%edx
	call	__asan_report_store4
.L466:
	movl	8(%ebp), %eax
	movl	$0, 88(%eax)
	jmp	.L463
.L465:
	movl	-128(%ebp), %eax
	addl	$164, %eax
	movl	%eax, %edx
	movl	%edx, %eax
	shrl	$3, %eax
	addl	$536870912, %eax
	movzbl	(%eax), %ecx
	testb	%cl, %cl
	setne	%bl
	movl	%edx, %eax
	andl	$7, %eax
	addl	$3, %eax
	cmpb	%cl, %al
	setge	%al
	andl	%ebx, %eax
	testb	%al, %al
	je	.L467
	subl	$12, %esp
	pushl	%edx
	call	__asan_report_load4
.L467:
	movl	-128(%ebp), %eax
	movl	164(%eax), %esi
	movl	8(%ebp), %eax
	addl	$88, %eax
	movl	%eax, %ecx
	movl	%ecx, %eax
	shrl	$3, %eax
	addl	$536870912, %eax
	movzbl	(%eax), %edx
	testb	%dl, %dl
	setne	%bl
	movl	%ecx, %eax
	andl	$7, %eax
	addl	$3, %eax
	cmpb	%dl, %al
	setge	%al
	andl	%ebx, %eax
	testb	%al, %al
	je	.L468
	subl	$12, %esp
	pushl	%ecx
	call	__asan_report_store4
.L468:
	movl	8(%ebp), %eax
	movl	%esi, 88(%eax)
.L463:
	movl	-128(%ebp), %eax
	addl	$452, %eax
	movl	%eax, %edx
	movl	%edx, %eax
	shrl	$3, %eax
	addl	$536870912, %eax
	movzbl	(%eax), %ecx
	testb	%cl, %cl
	setne	%bl
	movl	%edx, %eax
	andl	$7, %eax
	addl	$3, %eax
	cmpb	%cl, %al
	setge	%al
	andl	%ebx, %eax
	testb	%al, %al
	je	.L469
	subl	$12, %esp
	pushl	%edx
	call	__asan_report_load4
.L469:
	movl	-128(%ebp), %eax
	movl	452(%eax), %eax
	testl	%eax, %eax
	jne	.L470
	movl	$0, -132(%ebp)
	jmp	.L471
.L477:
	movl	throttles, %ebx
	movl	-132(%ebp), %eax
	leal	0(,%eax,4), %edx
	movl	8(%ebp), %eax
	addl	%edx, %eax
	addl	$12, %eax
	movl	%eax, %edx
	movl	%edx, %eax
	shrl	$3, %eax
	addl	$536870912, %eax
	movzbl	(%eax), %ecx
	testb	%cl, %cl
	setne	%al
	movl	%eax, %esi
	movl	%edx, %eax
	andl	$7, %eax
	addl	$3, %eax
	cmpb	%cl, %al
	setge	%al
	andl	%esi, %eax
	testb	%al, %al
	je	.L472
	subl	$12, %esp
	pushl	%edx
	call	__asan_report_load4
.L472:
	movl	8(%ebp), %eax
	movl	-132(%ebp), %edx
	movl	12(%eax,%edx,4), %eax
	movl	%eax, %edx
	movl	%edx, %eax
	addl	%eax, %eax
	addl	%edx, %eax
	sall	$3, %eax
	leal	(%ebx,%eax), %edi
	movl	throttles, %ecx
	movl	8(%ebp), %eax
	movl	-132(%ebp), %edx
	movl	12(%eax,%edx,4), %eax
	movl	%eax, %edx
	movl	%edx, %eax
	addl	%eax, %eax
	addl	%edx, %eax
	sall	$3, %eax
	leal	(%ecx,%eax), %esi
	leal	16(%esi), %eax
	movl	%eax, %ecx
	movl	%ecx, %eax
	shrl	$3, %eax
	addl	$536870912, %eax
	movzbl	(%eax), %edx
	testb	%dl, %dl
	setne	%bl
	movl	%ecx, %eax
	andl	$7, %eax
	addl	$3, %eax
	cmpb	%dl, %al
	setge	%al
	andl	%ebx, %eax
	testb	%al, %al
	je	.L473
	subl	$12, %esp
	pushl	%ecx
	call	__asan_report_load4
.L473:
	movl	16(%esi), %esi
	movl	-128(%ebp), %eax
	addl	$168, %eax
	movl	%eax, %ecx
	movl	%ecx, %eax
	shrl	$3, %eax
	addl	$536870912, %eax
	movzbl	(%eax), %edx
	testb	%dl, %dl
	setne	%bl
	movl	%ecx, %eax
	andl	$7, %eax
	addl	$3, %eax
	cmpb	%dl, %al
	setge	%al
	andl	%ebx, %eax
	testb	%al, %al
	je	.L474
	subl	$12, %esp
	pushl	%ecx
	call	__asan_report_load4
.L474:
	movl	-128(%ebp), %eax
	movl	168(%eax), %eax
	addl	%eax, %esi
	leal	16(%edi), %eax
	movl	%eax, %ecx
	movl	%ecx, %eax
	shrl	$3, %eax
	addl	$536870912, %eax
	movzbl	(%eax), %edx
	testb	%dl, %dl
	setne	%bl
	movl	%ecx, %eax
	andl	$7, %eax
	addl	$3, %eax
	cmpb	%dl, %al
	setge	%al
	andl	%ebx, %eax
	testb	%al, %al
	je	.L475
	subl	$12, %esp
	pushl	%ecx
	call	__asan_report_store4
.L475:
	movl	%esi, 16(%edi)
	addl	$1, -132(%ebp)
.L471:
	movl	8(%ebp), %eax
	addl	$52, %eax
	movl	%eax, %edx
	movl	%edx, %eax
	shrl	$3, %eax
	addl	$536870912, %eax
	movzbl	(%eax), %ecx
	testb	%cl, %cl
	setne	%bl
	movl	%edx, %eax
	andl	$7, %eax
	addl	$3, %eax
	cmpb	%cl, %al
	setge	%al
	andl	%ebx, %eax
	testb	%al, %al
	je	.L476
	subl	$12, %esp
	pushl	%edx
	call	__asan_report_load4
.L476:
	movl	8(%ebp), %eax
	movl	52(%eax), %eax
	cmpl	-132(%ebp), %eax
	jg	.L477
	movl	-128(%ebp), %eax
	addl	$168, %eax
	movl	%eax, %edx
	movl	%edx, %eax
	shrl	$3, %eax
	addl	$536870912, %eax
	movzbl	(%eax), %ecx
	testb	%cl, %cl
	setne	%bl
	movl	%edx, %eax
	andl	$7, %eax
	addl	$3, %eax
	cmpb	%cl, %al
	setge	%al
	andl	%ebx, %eax
	testb	%al, %al
	je	.L478
	subl	$12, %esp
	pushl	%edx
	call	__asan_report_load4
.L478:
	movl	-128(%ebp), %eax
	movl	168(%eax), %ebx
	movl	8(%ebp), %eax
	addl	$92, %eax
	movl	%eax, %edx
	movl	%edx, %eax
	shrl	$3, %eax
	addl	$536870912, %eax
	movzbl	(%eax), %ecx
	testb	%cl, %cl
	setne	%al
	movl	%eax, %esi
	movl	%edx, %eax
	andl	$7, %eax
	addl	$3, %eax
	cmpb	%cl, %al
	setge	%al
	andl	%esi, %eax
	testb	%al, %al
	je	.L479
	subl	$12, %esp
	pushl	%edx
	call	__asan_report_store4
.L479:
	movl	8(%ebp), %eax
	movl	%ebx, 92(%eax)
	subl	$8, %esp
	pushl	12(%ebp)
	pushl	8(%ebp)
	call	finish_connection
	addl	$16, %esp
	jmp	.L418
.L470:
	movl	8(%ebp), %eax
	addl	$92, %eax
	movl	%eax, %edx
	movl	%edx, %eax
	shrl	$3, %eax
	addl	$536870912, %eax
	movzbl	(%eax), %ecx
	testb	%cl, %cl
	setne	%bl
	movl	%edx, %eax
	andl	$7, %eax
	addl	$3, %eax
	cmpb	%cl, %al
	setge	%al
	andl	%ebx, %eax
	testb	%al, %al
	je	.L480
	subl	$12, %esp
	pushl	%edx
	call	__asan_report_load4
.L480:
	movl	8(%ebp), %eax
	movl	92(%eax), %esi
	movl	8(%ebp), %eax
	addl	$88, %eax
	movl	%eax, %ecx
	movl	%ecx, %eax
	shrl	$3, %eax
	addl	$536870912, %eax
	movzbl	(%eax), %edx
	testb	%dl, %dl
	setne	%bl
	movl	%ecx, %eax
	andl	$7, %eax
	addl	$3, %eax
	cmpb	%dl, %al
	setge	%al
	andl	%ebx, %eax
	testb	%al, %al
	je	.L481
	subl	$12, %esp
	pushl	%ecx
	call	__asan_report_load4
.L481:
	movl	8(%ebp), %eax
	movl	88(%eax), %eax
	cmpl	%eax, %esi
	jl	.L482
	subl	$8, %esp
	pushl	12(%ebp)
	pushl	8(%ebp)
	call	finish_connection
	addl	$16, %esp
	jmp	.L418
.L482:
	movl	8(%ebp), %eax
	movl	%eax, %edx
	movl	%edx, %eax
	shrl	$3, %eax
	addl	$536870912, %eax
	movzbl	(%eax), %ecx
	testb	%cl, %cl
	setne	%bl
	movl	%edx, %eax
	andl	$7, %eax
	addl	$3, %eax
	cmpb	%cl, %al
	setge	%al
	andl	%ebx, %eax
	testb	%al, %al
	je	.L483
	subl	$12, %esp
	pushl	%edx
	call	__asan_report_store4
.L483:
	movl	8(%ebp), %eax
	movl	$2, (%eax)
	movl	12(%ebp), %eax
	movl	%eax, %edx
	movl	%edx, %eax
	shrl	$3, %eax
	addl	$536870912, %eax
	movzbl	(%eax), %ecx
	testb	%cl, %cl
	setne	%bl
	movl	%edx, %eax
	andl	$7, %eax
	addl	$3, %eax
	cmpb	%cl, %al
	setge	%al
	andl	%ebx, %eax
	testb	%al, %al
	je	.L484
	subl	$12, %esp
	pushl	%edx
	call	__asan_report_load4
.L484:
	movl	12(%ebp), %eax
	movl	(%eax), %esi
	movl	8(%ebp), %eax
	addl	$64, %eax
	movl	%eax, %ecx
	movl	%ecx, %eax
	shrl	$3, %eax
	addl	$536870912, %eax
	movzbl	(%eax), %edx
	testb	%dl, %dl
	setne	%bl
	movl	%ecx, %eax
	andl	$7, %eax
	addl	$3, %eax
	cmpb	%dl, %al
	setge	%al
	andl	%ebx, %eax
	testb	%al, %al
	je	.L485
	subl	$12, %esp
	pushl	%ecx
	call	__asan_report_store4
.L485:
	movl	8(%ebp), %eax
	movl	%esi, 64(%eax)
	movl	8(%ebp), %eax
	addl	$80, %eax
	movl	%eax, %edx
	movl	%edx, %eax
	shrl	$3, %eax
	addl	$536870912, %eax
	movzbl	(%eax), %ecx
	testb	%cl, %cl
	setne	%bl
	movl	%edx, %eax
	andl	$7, %eax
	addl	$3, %eax
	cmpb	%cl, %al
	setge	%al
	andl	%ebx, %eax
	testb	%al, %al
	je	.L486
	subl	$12, %esp
	pushl	%edx
	call	__asan_report_store4
.L486:
	movl	8(%ebp), %eax
	movl	$0, 80(%eax)
	movl	8(%ebp), %eax
	movl	-148(%ebp), %edi
	movl	%eax, -64(%edi)
	movl	-128(%ebp), %eax
	addl	$448, %eax
	movl	%eax, %edx
	movl	%edx, %eax
	shrl	$3, %eax
	addl	$536870912, %eax
	movzbl	(%eax), %ecx
	testb	%cl, %cl
	setne	%bl
	movl	%edx, %eax
	andl	$7, %eax
	addl	$3, %eax
	cmpb	%cl, %al
	setge	%al
	andl	%ebx, %eax
	testb	%al, %al
	je	.L487
	subl	$12, %esp
	pushl	%edx
	call	__asan_report_load4
.L487:
	movl	-128(%ebp), %eax
	movl	448(%eax), %eax
	subl	$12, %esp
	pushl	%eax
	call	fdwatch_del_fd
	addl	$16, %esp
	movl	-128(%ebp), %eax
	addl	$448, %eax
	movl	%eax, %edx
	movl	%edx, %eax
	shrl	$3, %eax
	addl	$536870912, %eax
	movzbl	(%eax), %ecx
	testb	%cl, %cl
	setne	%bl
	movl	%edx, %eax
	andl	$7, %eax
	addl	$3, %eax
	cmpb	%cl, %al
	setge	%al
	andl	%ebx, %eax
	testb	%al, %al
	je	.L488
	subl	$12, %esp
	pushl	%edx
	call	__asan_report_load4
.L488:
	movl	-128(%ebp), %eax
	movl	448(%eax), %eax
	subl	$4, %esp
	pushl	$1
	pushl	8(%ebp)
	pushl	%eax
	call	fdwatch_add_fd
	addl	$16, %esp
	jmp	.L418
.L491:
	nop
.L418:
	movl	-140(%ebp), %edi
	cmpl	%edi, -152(%ebp)
	je	.L416
	movl	-140(%ebp), %eax
	movl	$1172321806, (%eax)
	movl	-144(%ebp), %eax
	movl	$-168430091, 536870912(%eax)
	movl	$-168430091, 536870916(%eax)
	movl	$-168430091, 536870920(%eax)
	jmp	.L417
.L416:
	movl	-144(%ebp), %eax
	movl	$0, 536870912(%eax)
	movl	$0, 536870916(%eax)
	movl	$0, 536870920(%eax)
.L417:
	leal	-12(%ebp), %esp
	popl	%ebx
	popl	%esi
	popl	%edi
	popl	%ebp
	ret
	.size	handle_read, .-handle_read
	.section	.rodata
	.align 4
.LC126:
	.string	"2 32 4 11 client_data 96 16 2 iv "
	.align 32
.LC127:
	.string	"replacing non-null wakeup_timer!"
	.zero	63
	.align 32
.LC128:
	.string	"tmr_create(wakeup_connection) failed"
	.zero	59
	.align 32
.LC129:
	.string	"write - %m sending %.80s"
	.zero	39
	.text
	.type	handle_send, @function
handle_send:
.LASANPC19:
	pushl	%ebp
	movl	%esp, %ebp
	pushl	%edi
	pushl	%esi
	pushl	%ebx
	subl	$236, %esp
	leal	-184(%ebp), %eax
	movl	%eax, -224(%ebp)
	movl	%eax, -248(%ebp)
	cmpl	$0, __asan_option_detect_stack_use_after_return
	je	.L492
	subl	$8, %esp
	pushl	-224(%ebp)
	pushl	$160
	call	__asan_stack_malloc_2
	addl	$16, %esp
	movl	%eax, -224(%ebp)
.L492:
	movl	-224(%ebp), %edi
	movl	%edi, %eax
	addl	$160, %eax
	movl	%eax, -220(%ebp)
	movl	%edi, %eax
	movl	$1102416563, (%eax)
	movl	%edi, %eax
	movl	$.LC126, 4(%eax)
	movl	$.LASANPC19, 8(%eax)
	shrl	$3, %eax
	movl	%eax, -236(%ebp)
	movl	$-235802127, 536870912(%eax)
	movl	$-185273340, 536870916(%eax)
	movl	$-218959118, 536870920(%eax)
	movl	$-185335808, 536870924(%eax)
	movl	$-202116109, 536870928(%eax)
	movl	8(%ebp), %eax
	addl	$8, %eax
	movl	%eax, %edx
	movl	%edx, %eax
	shrl	$3, %eax
	addl	$536870912, %eax
	movzbl	(%eax), %ecx
	testb	%cl, %cl
	setne	%bl
	movl	%edx, %eax
	andl	$7, %eax
	addl	$3, %eax
	cmpb	%cl, %al
	setge	%al
	andl	%ebx, %eax
	testb	%al, %al
	je	.L496
	subl	$12, %esp
	pushl	%edx
	call	__asan_report_load4
.L496:
	movl	8(%ebp), %eax
	movl	8(%eax), %eax
	movl	%eax, -196(%ebp)
	movl	8(%ebp), %eax
	addl	$56, %eax
	movl	%eax, %edx
	movl	%edx, %eax
	shrl	$3, %eax
	addl	$536870912, %eax
	movzbl	(%eax), %ecx
	testb	%cl, %cl
	setne	%bl
	movl	%edx, %eax
	andl	$7, %eax
	addl	$3, %eax
	cmpb	%cl, %al
	setge	%al
	andl	%ebx, %eax
	testb	%al, %al
	je	.L497
	subl	$12, %esp
	pushl	%edx
	call	__asan_report_load4
.L497:
	movl	8(%ebp), %eax
	movl	56(%eax), %eax
	cmpl	$-1, %eax
	jne	.L498
	movl	$1000000000, -212(%ebp)
	jmp	.L499
.L498:
	movl	8(%ebp), %eax
	addl	$56, %eax
	movl	%eax, %edx
	movl	%edx, %eax
	shrl	$3, %eax
	addl	$536870912, %eax
	movzbl	(%eax), %ecx
	testb	%cl, %cl
	setne	%bl
	movl	%edx, %eax
	andl	$7, %eax
	addl	$3, %eax
	cmpb	%cl, %al
	setge	%al
	andl	%ebx, %eax
	testb	%al, %al
	je	.L500
	subl	$12, %esp
	pushl	%edx
	call	__asan_report_load4
.L500:
	movl	8(%ebp), %eax
	movl	56(%eax), %eax
	leal	3(%eax), %edx
	testl	%eax, %eax
	cmovs	%edx, %eax
	sarl	$2, %eax
	movl	%eax, -212(%ebp)
.L499:
	movl	-196(%ebp), %eax
	addl	$304, %eax
	movl	%eax, %edx
	movl	%edx, %eax
	shrl	$3, %eax
	addl	$536870912, %eax
	movzbl	(%eax), %ecx
	testb	%cl, %cl
	setne	%bl
	movl	%edx, %eax
	andl	$7, %eax
	addl	$3, %eax
	cmpb	%cl, %al
	setge	%al
	andl	%ebx, %eax
	testb	%al, %al
	je	.L501
	subl	$12, %esp
	pushl	%edx
	call	__asan_report_load4
.L501:
	movl	-196(%ebp), %eax
	movl	304(%eax), %eax
	testl	%eax, %eax
	jne	.L502
	movl	8(%ebp), %eax
	addl	$88, %eax
	movl	%eax, %edx
	movl	%edx, %eax
	shrl	$3, %eax
	addl	$536870912, %eax
	movzbl	(%eax), %ecx
	testb	%cl, %cl
	setne	%bl
	movl	%edx, %eax
	andl	$7, %eax
	addl	$3, %eax
	cmpb	%cl, %al
	setge	%al
	andl	%ebx, %eax
	testb	%al, %al
	je	.L503
	subl	$12, %esp
	pushl	%edx
	call	__asan_report_load4
.L503:
	movl	8(%ebp), %eax
	movl	88(%eax), %esi
	movl	8(%ebp), %eax
	addl	$92, %eax
	movl	%eax, %ecx
	movl	%ecx, %eax
	shrl	$3, %eax
	addl	$536870912, %eax
	movzbl	(%eax), %edx
	testb	%dl, %dl
	setne	%bl
	movl	%ecx, %eax
	andl	$7, %eax
	addl	$3, %eax
	cmpb	%dl, %al
	setge	%al
	andl	%ebx, %eax
	testb	%al, %al
	je	.L504
	subl	$12, %esp
	pushl	%ecx
	call	__asan_report_load4
.L504:
	movl	8(%ebp), %eax
	movl	92(%eax), %eax
	subl	%eax, %esi
	movl	%esi, %eax
	movl	%eax, %edx
	movl	-212(%ebp), %eax
	cmpl	%eax, %edx
	cmovbe	%edx, %eax
	movl	%eax, %edi
	movl	-196(%ebp), %eax
	addl	$452, %eax
	movl	%eax, %ecx
	movl	%ecx, %eax
	shrl	$3, %eax
	addl	$536870912, %eax
	movzbl	(%eax), %edx
	testb	%dl, %dl
	setne	%bl
	movl	%ecx, %eax
	andl	$7, %eax
	addl	$3, %eax
	cmpb	%dl, %al
	setge	%al
	andl	%ebx, %eax
	testb	%al, %al
	je	.L505
	subl	$12, %esp
	pushl	%ecx
	call	__asan_report_load4
.L505:
	movl	-196(%ebp), %eax
	movl	452(%eax), %edx
	movl	8(%ebp), %eax
	movl	92(%eax), %eax
	leal	(%edx,%eax), %esi
	movl	-196(%ebp), %eax
	addl	$448, %eax
	movl	%eax, %ecx
	movl	%ecx, %eax
	shrl	$3, %eax
	addl	$536870912, %eax
	movzbl	(%eax), %edx
	testb	%dl, %dl
	setne	%bl
	movl	%ecx, %eax
	andl	$7, %eax
	addl	$3, %eax
	cmpb	%dl, %al
	setge	%al
	andl	%ebx, %eax
	testb	%al, %al
	je	.L506
	subl	$12, %esp
	pushl	%ecx
	call	__asan_report_load4
.L506:
	movl	-196(%ebp), %eax
	movl	448(%eax), %eax
	subl	$4, %esp
	pushl	%edi
	pushl	%esi
	pushl	%eax
	call	write
	addl	$16, %esp
	movl	%eax, -208(%ebp)
	jmp	.L507
.L502:
	movl	-196(%ebp), %eax
	addl	$252, %eax
	movl	%eax, %edx
	movl	%edx, %eax
	shrl	$3, %eax
	addl	$536870912, %eax
	movzbl	(%eax), %ecx
	testb	%cl, %cl
	setne	%bl
	movl	%edx, %eax
	andl	$7, %eax
	addl	$3, %eax
	cmpb	%cl, %al
	setge	%al
	andl	%ebx, %eax
	testb	%al, %al
	je	.L508
	subl	$12, %esp
	pushl	%edx
	call	__asan_report_load4
.L508:
	movl	-196(%ebp), %eax
	movl	252(%eax), %eax
	movl	-220(%ebp), %edi
	movl	%eax, -64(%edi)
	movl	-196(%ebp), %eax
	addl	$304, %eax
	movl	%eax, %edx
	movl	%edx, %eax
	shrl	$3, %eax
	addl	$536870912, %eax
	movzbl	(%eax), %ecx
	testb	%cl, %cl
	setne	%bl
	movl	%edx, %eax
	andl	$7, %eax
	addl	$3, %eax
	cmpb	%cl, %al
	setge	%al
	andl	%ebx, %eax
	testb	%al, %al
	je	.L509
	subl	$12, %esp
	pushl	%edx
	call	__asan_report_load4
.L509:
	movl	-196(%ebp), %eax
	movl	304(%eax), %eax
	movl	-220(%ebp), %edi
	movl	%eax, -60(%edi)
	movl	-196(%ebp), %eax
	addl	$452, %eax
	movl	%eax, %edx
	movl	%edx, %eax
	shrl	$3, %eax
	addl	$536870912, %eax
	movzbl	(%eax), %ecx
	testb	%cl, %cl
	setne	%bl
	movl	%edx, %eax
	andl	$7, %eax
	addl	$3, %eax
	cmpb	%cl, %al
	setge	%al
	andl	%ebx, %eax
	testb	%al, %al
	je	.L510
	subl	$12, %esp
	pushl	%edx
	call	__asan_report_load4
.L510:
	movl	-196(%ebp), %eax
	movl	452(%eax), %esi
	movl	8(%ebp), %eax
	addl	$92, %eax
	movl	%eax, %ecx
	movl	%ecx, %eax
	shrl	$3, %eax
	addl	$536870912, %eax
	movzbl	(%eax), %edx
	testb	%dl, %dl
	setne	%bl
	movl	%ecx, %eax
	andl	$7, %eax
	addl	$3, %eax
	cmpb	%dl, %al
	setge	%al
	andl	%ebx, %eax
	testb	%al, %al
	je	.L511
	subl	$12, %esp
	pushl	%ecx
	call	__asan_report_load4
.L511:
	movl	8(%ebp), %eax
	movl	92(%eax), %eax
	addl	%esi, %eax
	movl	-220(%ebp), %edi
	movl	%eax, -56(%edi)
	movl	8(%ebp), %eax
	addl	$88, %eax
	movl	%eax, %edx
	movl	%edx, %eax
	shrl	$3, %eax
	addl	$536870912, %eax
	movzbl	(%eax), %ecx
	testb	%cl, %cl
	setne	%bl
	movl	%edx, %eax
	andl	$7, %eax
	addl	$3, %eax
	cmpb	%cl, %al
	setge	%al
	andl	%ebx, %eax
	testb	%al, %al
	je	.L512
	subl	$12, %esp
	pushl	%edx
	call	__asan_report_load4
.L512:
	movl	8(%ebp), %eax
	movl	88(%eax), %edx
	movl	8(%ebp), %eax
	movl	92(%eax), %eax
	subl	%eax, %edx
	movl	%edx, %eax
	movl	%eax, %edx
	movl	-212(%ebp), %eax
	cmpl	%eax, %edx
	cmovbe	%edx, %eax
	movl	-220(%ebp), %edi
	movl	%eax, -52(%edi)
	movl	-196(%ebp), %eax
	addl	$448, %eax
	movl	%eax, %edx
	movl	%edx, %eax
	shrl	$3, %eax
	addl	$536870912, %eax
	movzbl	(%eax), %ecx
	testb	%cl, %cl
	setne	%bl
	movl	%edx, %eax
	andl	$7, %eax
	addl	$3, %eax
	cmpb	%cl, %al
	setge	%al
	andl	%ebx, %eax
	testb	%al, %al
	je	.L513
	subl	$12, %esp
	pushl	%edx
	call	__asan_report_load4
.L513:
	movl	-196(%ebp), %eax
	movl	448(%eax), %eax
	subl	$4, %esp
	pushl	$2
	movl	-220(%ebp), %edi
	leal	-64(%edi), %edx
	pushl	%edx
	pushl	%eax
	call	writev
	addl	$16, %esp
	movl	%eax, -208(%ebp)
.L507:
	cmpl	$0, -208(%ebp)
	jns	.L514
	call	__errno_location
	movl	%eax, %esi
	movl	%esi, %ecx
	movl	%ecx, %eax
	shrl	$3, %eax
	addl	$536870912, %eax
	movzbl	(%eax), %edx
	testb	%dl, %dl
	setne	%bl
	movl	%ecx, %eax
	andl	$7, %eax
	addl	$3, %eax
	cmpb	%dl, %al
	setge	%al
	andl	%ebx, %eax
	testb	%al, %al
	je	.L515
	subl	$12, %esp
	pushl	%ecx
	call	__asan_report_load4
.L515:
	movl	(%esi), %eax
	cmpl	$4, %eax
	jne	.L514
	jmp	.L495
.L514:
	cmpl	$0, -208(%ebp)
	je	.L517
	cmpl	$0, -208(%ebp)
	jns	.L518
	call	__errno_location
	movl	%eax, %esi
	movl	%esi, %ecx
	movl	%ecx, %eax
	shrl	$3, %eax
	addl	$536870912, %eax
	movzbl	(%eax), %edx
	testb	%dl, %dl
	setne	%bl
	movl	%ecx, %eax
	andl	$7, %eax
	addl	$3, %eax
	cmpb	%dl, %al
	setge	%al
	andl	%ebx, %eax
	testb	%al, %al
	je	.L519
	subl	$12, %esp
	pushl	%ecx
	call	__asan_report_load4
.L519:
	movl	(%esi), %eax
	cmpl	$11, %eax
	je	.L517
	call	__errno_location
	movl	%eax, %esi
	movl	%esi, %ecx
	movl	%ecx, %eax
	shrl	$3, %eax
	addl	$536870912, %eax
	movzbl	(%eax), %edx
	testb	%dl, %dl
	setne	%bl
	movl	%ecx, %eax
	andl	$7, %eax
	addl	$3, %eax
	cmpb	%dl, %al
	setge	%al
	andl	%ebx, %eax
	testb	%al, %al
	je	.L520
	subl	$12, %esp
	pushl	%ecx
	call	__asan_report_load4
.L520:
	movl	(%esi), %eax
	cmpl	$11, %eax
	jne	.L518
.L517:
	movl	8(%ebp), %eax
	addl	$80, %eax
	movl	%eax, %edx
	movl	%edx, %eax
	shrl	$3, %eax
	addl	$536870912, %eax
	movzbl	(%eax), %ecx
	testb	%cl, %cl
	setne	%bl
	movl	%edx, %eax
	andl	$7, %eax
	addl	$3, %eax
	cmpb	%cl, %al
	setge	%al
	andl	%ebx, %eax
	testb	%al, %al
	je	.L521
	subl	$12, %esp
	pushl	%edx
	call	__asan_report_load4
.L521:
	movl	8(%ebp), %eax
	movl	80(%eax), %eax
	leal	100(%eax), %edx
	movl	8(%ebp), %eax
	movl	%edx, 80(%eax)
	movl	8(%ebp), %eax
	movl	%eax, %edx
	movl	%edx, %eax
	shrl	$3, %eax
	addl	$536870912, %eax
	movzbl	(%eax), %ecx
	testb	%cl, %cl
	setne	%bl
	movl	%edx, %eax
	andl	$7, %eax
	addl	$3, %eax
	cmpb	%cl, %al
	setge	%al
	andl	%ebx, %eax
	testb	%al, %al
	je	.L522
	subl	$12, %esp
	pushl	%edx
	call	__asan_report_store4
.L522:
	movl	8(%ebp), %eax
	movl	$3, (%eax)
	movl	-196(%ebp), %eax
	addl	$448, %eax
	movl	%eax, %edx
	movl	%edx, %eax
	shrl	$3, %eax
	addl	$536870912, %eax
	movzbl	(%eax), %ecx
	testb	%cl, %cl
	setne	%bl
	movl	%edx, %eax
	andl	$7, %eax
	addl	$3, %eax
	cmpb	%cl, %al
	setge	%al
	andl	%ebx, %eax
	testb	%al, %al
	je	.L523
	subl	$12, %esp
	pushl	%edx
	call	__asan_report_load4
.L523:
	movl	-196(%ebp), %eax
	movl	448(%eax), %eax
	subl	$12, %esp
	pushl	%eax
	call	fdwatch_del_fd
	addl	$16, %esp
	movl	8(%ebp), %eax
	movl	-220(%ebp), %edi
	movl	%eax, -128(%edi)
	movl	8(%ebp), %eax
	addl	$72, %eax
	movl	%eax, %edx
	movl	%edx, %eax
	shrl	$3, %eax
	addl	$536870912, %eax
	movzbl	(%eax), %ecx
	testb	%cl, %cl
	setne	%bl
	movl	%edx, %eax
	andl	$7, %eax
	addl	$3, %eax
	cmpb	%cl, %al
	setge	%al
	andl	%ebx, %eax
	testb	%al, %al
	je	.L524
	subl	$12, %esp
	pushl	%edx
	call	__asan_report_load4
.L524:
	movl	8(%ebp), %eax
	movl	72(%eax), %eax
	testl	%eax, %eax
	je	.L525
	subl	$8, %esp
	pushl	$.LC127
	pushl	$3
	call	syslog
	addl	$16, %esp
.L525:
	movl	8(%ebp), %eax
	addl	$80, %eax
	movl	%eax, %edx
	movl	%edx, %eax
	shrl	$3, %eax
	addl	$536870912, %eax
	movzbl	(%eax), %ecx
	testb	%cl, %cl
	setne	%bl
	movl	%edx, %eax
	andl	$7, %eax
	addl	$3, %eax
	cmpb	%cl, %al
	setge	%al
	andl	%ebx, %eax
	testb	%al, %al
	je	.L526
	subl	$12, %esp
	pushl	%edx
	call	__asan_report_load4
.L526:
	movl	8(%ebp), %eax
	movl	80(%eax), %eax
	subl	$12, %esp
	pushl	$0
	pushl	%eax
	movl	-220(%ebp), %eax
	pushl	-128(%eax)
	pushl	$wakeup_connection
	pushl	12(%ebp)
	call	tmr_create
	addl	$32, %esp
	movl	%eax, %ebx
	movl	8(%ebp), %eax
	addl	$72, %eax
	movl	%eax, %edx
	movl	%edx, %eax
	shrl	$3, %eax
	addl	$536870912, %eax
	movzbl	(%eax), %ecx
	testb	%cl, %cl
	setne	%al
	movl	%eax, %esi
	movl	%edx, %eax
	andl	$7, %eax
	addl	$3, %eax
	cmpb	%cl, %al
	setge	%al
	andl	%esi, %eax
	testb	%al, %al
	je	.L527
	subl	$12, %esp
	pushl	%edx
	call	__asan_report_store4
.L527:
	movl	8(%ebp), %eax
	movl	%ebx, 72(%eax)
	movl	8(%ebp), %eax
	movl	72(%eax), %eax
	testl	%eax, %eax
	jne	.L528
	subl	$8, %esp
	pushl	$.LC128
	pushl	$2
	call	syslog
	addl	$16, %esp
	call	__asan_handle_no_return
	subl	$12, %esp
	pushl	$1
	call	exit
.L528:
	jmp	.L495
.L518:
	cmpl	$0, -208(%ebp)
	jns	.L529
	call	__errno_location
	movl	%eax, %ebx
	movl	%ebx, %edx
	movl	%edx, %eax
	shrl	$3, %eax
	addl	$536870912, %eax
	movzbl	(%eax), %ecx
	testb	%cl, %cl
	setne	%al
	movl	%eax, %esi
	movl	%edx, %eax
	andl	$7, %eax
	addl	$3, %eax
	cmpb	%cl, %al
	setge	%al
	andl	%esi, %eax
	testb	%al, %al
	je	.L530
	subl	$12, %esp
	pushl	%edx
	call	__asan_report_load4
.L530:
	movl	(%ebx), %eax
	cmpl	$32, %eax
	je	.L531
	call	__errno_location
	movl	%eax, %ebx
	movl	%ebx, %edx
	movl	%edx, %eax
	shrl	$3, %eax
	addl	$536870912, %eax
	movzbl	(%eax), %ecx
	testb	%cl, %cl
	setne	%al
	movl	%eax, %esi
	movl	%edx, %eax
	andl	$7, %eax
	addl	$3, %eax
	cmpb	%cl, %al
	setge	%al
	andl	%esi, %eax
	testb	%al, %al
	je	.L532
	subl	$12, %esp
	pushl	%edx
	call	__asan_report_load4
.L532:
	movl	(%ebx), %eax
	cmpl	$22, %eax
	je	.L531
	call	__errno_location
	movl	%eax, %ebx
	movl	%ebx, %edx
	movl	%edx, %eax
	shrl	$3, %eax
	addl	$536870912, %eax
	movzbl	(%eax), %ecx
	testb	%cl, %cl
	setne	%al
	movl	%eax, %esi
	movl	%edx, %eax
	andl	$7, %eax
	addl	$3, %eax
	cmpb	%cl, %al
	setge	%al
	andl	%esi, %eax
	testb	%al, %al
	je	.L533
	subl	$12, %esp
	pushl	%edx
	call	__asan_report_load4
.L533:
	movl	(%ebx), %eax
	cmpl	$104, %eax
	je	.L531
	movl	-196(%ebp), %eax
	addl	$172, %eax
	movl	%eax, %edx
	movl	%edx, %eax
	shrl	$3, %eax
	addl	$536870912, %eax
	movzbl	(%eax), %ecx
	testb	%cl, %cl
	setne	%bl
	movl	%edx, %eax
	andl	$7, %eax
	addl	$3, %eax
	cmpb	%cl, %al
	setge	%al
	andl	%ebx, %eax
	testb	%al, %al
	je	.L534
	subl	$12, %esp
	pushl	%edx
	call	__asan_report_load4
.L534:
	movl	-196(%ebp), %eax
	movl	172(%eax), %eax
	subl	$4, %esp
	pushl	%eax
	pushl	$.LC129
	pushl	$3
	call	syslog
	addl	$16, %esp
.L531:
	subl	$8, %esp
	pushl	12(%ebp)
	pushl	8(%ebp)
	call	clear_connection
	addl	$16, %esp
	jmp	.L495
.L529:
	movl	12(%ebp), %eax
	movl	%eax, %edx
	movl	%edx, %eax
	shrl	$3, %eax
	addl	$536870912, %eax
	movzbl	(%eax), %ecx
	testb	%cl, %cl
	setne	%bl
	movl	%edx, %eax
	andl	$7, %eax
	addl	$3, %eax
	cmpb	%cl, %al
	setge	%al
	andl	%ebx, %eax
	testb	%al, %al
	je	.L535
	subl	$12, %esp
	pushl	%edx
	call	__asan_report_load4
.L535:
	movl	12(%ebp), %eax
	movl	(%eax), %esi
	movl	8(%ebp), %eax
	addl	$68, %eax
	movl	%eax, %ecx
	movl	%ecx, %eax
	shrl	$3, %eax
	addl	$536870912, %eax
	movzbl	(%eax), %edx
	testb	%dl, %dl
	setne	%bl
	movl	%ecx, %eax
	andl	$7, %eax
	addl	$3, %eax
	cmpb	%dl, %al
	setge	%al
	andl	%ebx, %eax
	testb	%al, %al
	je	.L536
	subl	$12, %esp
	pushl	%ecx
	call	__asan_report_store4
.L536:
	movl	8(%ebp), %eax
	movl	%esi, 68(%eax)
	movl	-196(%ebp), %eax
	addl	$304, %eax
	movl	%eax, %edx
	movl	%edx, %eax
	shrl	$3, %eax
	addl	$536870912, %eax
	movzbl	(%eax), %ecx
	testb	%cl, %cl
	setne	%bl
	movl	%edx, %eax
	andl	$7, %eax
	addl	$3, %eax
	cmpb	%cl, %al
	setge	%al
	andl	%ebx, %eax
	testb	%al, %al
	je	.L537
	subl	$12, %esp
	pushl	%edx
	call	__asan_report_load4
.L537:
	movl	-196(%ebp), %eax
	movl	304(%eax), %eax
	testl	%eax, %eax
	je	.L538
	movl	-208(%ebp), %edx
	movl	-196(%ebp), %eax
	movl	304(%eax), %eax
	cmpl	%eax, %edx
	jae	.L539
	movl	-196(%ebp), %eax
	movl	304(%eax), %edx
	movl	-208(%ebp), %eax
	subl	%eax, %edx
	movl	%edx, %eax
	movl	%eax, -192(%ebp)
	movl	-192(%ebp), %eax
	movl	%eax, -228(%ebp)
	movl	-196(%ebp), %eax
	addl	$252, %eax
	movl	%eax, %ecx
	movl	%ecx, %eax
	shrl	$3, %eax
	addl	$536870912, %eax
	movzbl	(%eax), %edx
	testb	%dl, %dl
	setne	%bl
	movl	%ecx, %eax
	andl	$7, %eax
	addl	$3, %eax
	cmpb	%dl, %al
	setge	%al
	andl	%ebx, %eax
	testb	%al, %al
	je	.L540
	subl	$12, %esp
	pushl	%ecx
	call	__asan_report_load4
.L540:
	movl	-196(%ebp), %eax
	movl	252(%eax), %edx
	movl	-208(%ebp), %eax
	addl	%edx, %eax
	movl	%eax, %esi
	movl	%esi, -240(%ebp)
	movl	-196(%ebp), %eax
	movl	252(%eax), %eax
	movl	%eax, -232(%ebp)
	movl	-228(%ebp), %edi
	testl	%edi, %edi
	je	.L541
	movl	%esi, %eax
	shrl	$3, %eax
	addl	$536870912, %eax
	movzbl	(%eax), %edx
	testb	%dl, %dl
	setne	%cl
	movl	%esi, %eax
	andl	$7, %eax
	cmpb	%dl, %al
	setge	%al
	andl	%eax, %ecx
	movb	%cl, -241(%ebp)
	leal	-1(%edi), %eax
	leal	(%esi,%eax), %ecx
	movl	%ecx, %eax
	shrl	$3, %eax
	addl	$536870912, %eax
	movzbl	(%eax), %edx
	testb	%dl, %dl
	setne	%bl
	movl	%ecx, %eax
	andl	$7, %eax
	cmpb	%dl, %al
	setge	%al
	andl	%ebx, %eax
	orb	-241(%ebp), %al
	testb	%al, %al
	je	.L541
	subl	$8, %esp
	pushl	%edi
	pushl	%esi
	call	__asan_report_load_n
.L541:
	movl	-228(%ebp), %edi
	testl	%edi, %edi
	je	.L542
	movl	-232(%ebp), %esi
	movl	%esi, %eax
	shrl	$3, %eax
	addl	$536870912, %eax
	movzbl	(%eax), %edx
	testb	%dl, %dl
	setne	%cl
	movl	%esi, %eax
	andl	$7, %eax
	cmpb	%dl, %al
	setge	%al
	andl	%eax, %ecx
	movb	%cl, -241(%ebp)
	leal	-1(%edi), %eax
	leal	(%esi,%eax), %ecx
	movl	%ecx, %eax
	shrl	$3, %eax
	addl	$536870912, %eax
	movzbl	(%eax), %edx
	testb	%dl, %dl
	setne	%bl
	movl	%ecx, %eax
	andl	$7, %eax
	cmpb	%dl, %al
	setge	%al
	andl	%ebx, %eax
	orb	-241(%ebp), %al
	testb	%al, %al
	je	.L542
	subl	$8, %esp
	pushl	%edi
	pushl	%esi
	call	__asan_report_store_n
.L542:
	subl	$4, %esp
	pushl	-228(%ebp)
	pushl	-240(%ebp)
	pushl	-232(%ebp)
	call	memmove
	addl	$16, %esp
	movl	-192(%ebp), %edx
	movl	-196(%ebp), %eax
	movl	%edx, 304(%eax)
	movl	$0, -208(%ebp)
	jmp	.L538
.L539:
	movl	-208(%ebp), %esi
	movl	-196(%ebp), %eax
	addl	$304, %eax
	movl	%eax, %ecx
	movl	%ecx, %eax
	shrl	$3, %eax
	addl	$536870912, %eax
	movzbl	(%eax), %edx
	testb	%dl, %dl
	setne	%bl
	movl	%ecx, %eax
	andl	$7, %eax
	addl	$3, %eax
	cmpb	%dl, %al
	setge	%al
	andl	%ebx, %eax
	testb	%al, %al
	je	.L543
	subl	$12, %esp
	pushl	%ecx
	call	__asan_report_load4
.L543:
	movl	-196(%ebp), %eax
	movl	304(%eax), %eax
	subl	%eax, %esi
	movl	%esi, %eax
	movl	%eax, -208(%ebp)
	movl	-196(%ebp), %eax
	movl	$0, 304(%eax)
.L538:
	movl	8(%ebp), %eax
	addl	$92, %eax
	movl	%eax, %edx
	movl	%edx, %eax
	shrl	$3, %eax
	addl	$536870912, %eax
	movzbl	(%eax), %ecx
	testb	%cl, %cl
	setne	%bl
	movl	%edx, %eax
	andl	$7, %eax
	addl	$3, %eax
	cmpb	%cl, %al
	setge	%al
	andl	%ebx, %eax
	testb	%al, %al
	je	.L544
	subl	$12, %esp
	pushl	%edx
	call	__asan_report_load4
.L544:
	movl	8(%ebp), %eax
	movl	92(%eax), %edx
	movl	-208(%ebp), %eax
	addl	%eax, %edx
	movl	8(%ebp), %eax
	movl	%edx, 92(%eax)
	movl	8(%ebp), %eax
	addl	$8, %eax
	movl	%eax, %edx
	movl	%edx, %eax
	shrl	$3, %eax
	addl	$536870912, %eax
	movzbl	(%eax), %ecx
	testb	%cl, %cl
	setne	%bl
	movl	%edx, %eax
	andl	$7, %eax
	addl	$3, %eax
	cmpb	%cl, %al
	setge	%al
	andl	%ebx, %eax
	testb	%al, %al
	je	.L545
	subl	$12, %esp
	pushl	%edx
	call	__asan_report_load4
.L545:
	movl	8(%ebp), %eax
	movl	8(%eax), %edi
	movl	8(%ebp), %eax
	movl	8(%eax), %esi
	leal	168(%esi), %eax
	movl	%eax, %ecx
	movl	%ecx, %eax
	shrl	$3, %eax
	addl	$536870912, %eax
	movzbl	(%eax), %edx
	testb	%dl, %dl
	setne	%bl
	movl	%ecx, %eax
	andl	$7, %eax
	addl	$3, %eax
	cmpb	%dl, %al
	setge	%al
	andl	%ebx, %eax
	testb	%al, %al
	je	.L546
	subl	$12, %esp
	pushl	%ecx
	call	__asan_report_load4
.L546:
	movl	168(%esi), %edx
	movl	-208(%ebp), %eax
	leal	(%edx,%eax), %esi
	leal	168(%edi), %eax
	movl	%eax, %ecx
	movl	%ecx, %eax
	shrl	$3, %eax
	addl	$536870912, %eax
	movzbl	(%eax), %edx
	testb	%dl, %dl
	setne	%bl
	movl	%ecx, %eax
	andl	$7, %eax
	addl	$3, %eax
	cmpb	%dl, %al
	setge	%al
	andl	%ebx, %eax
	testb	%al, %al
	je	.L547
	subl	$12, %esp
	pushl	%ecx
	call	__asan_report_store4
.L547:
	movl	%esi, 168(%edi)
	movl	$0, -200(%ebp)
	jmp	.L548
.L553:
	movl	throttles, %esi
	movl	-200(%ebp), %eax
	leal	0(,%eax,4), %edx
	movl	8(%ebp), %eax
	addl	%edx, %eax
	addl	$12, %eax
	movl	%eax, %ecx
	movl	%ecx, %eax
	shrl	$3, %eax
	addl	$536870912, %eax
	movzbl	(%eax), %edx
	testb	%dl, %dl
	setne	%bl
	movl	%ecx, %eax
	andl	$7, %eax
	addl	$3, %eax
	cmpb	%dl, %al
	setge	%al
	andl	%ebx, %eax
	testb	%al, %al
	je	.L549
	subl	$12, %esp
	pushl	%ecx
	call	__asan_report_load4
.L549:
	movl	8(%ebp), %eax
	movl	-200(%ebp), %edx
	movl	12(%eax,%edx,4), %eax
	movl	%eax, %edx
	movl	%edx, %eax
	addl	%eax, %eax
	addl	%edx, %eax
	sall	$3, %eax
	leal	(%esi,%eax), %edi
	movl	throttles, %ecx
	movl	8(%ebp), %edx
	movl	-200(%ebp), %eax
	movl	12(%edx,%eax,4), %eax
	movl	%eax, %edx
	movl	%edx, %eax
	addl	%eax, %eax
	addl	%edx, %eax
	sall	$3, %eax
	leal	(%ecx,%eax), %esi
	leal	16(%esi), %eax
	movl	%eax, %ecx
	movl	%ecx, %eax
	shrl	$3, %eax
	addl	$536870912, %eax
	movzbl	(%eax), %edx
	testb	%dl, %dl
	setne	%bl
	movl	%ecx, %eax
	andl	$7, %eax
	addl	$3, %eax
	cmpb	%dl, %al
	setge	%al
	andl	%ebx, %eax
	testb	%al, %al
	je	.L550
	subl	$12, %esp
	pushl	%ecx
	call	__asan_report_load4
.L550:
	movl	16(%esi), %edx
	movl	-208(%ebp), %eax
	leal	(%edx,%eax), %esi
	leal	16(%edi), %eax
	movl	%eax, %ecx
	movl	%ecx, %eax
	shrl	$3, %eax
	addl	$536870912, %eax
	movzbl	(%eax), %edx
	testb	%dl, %dl
	setne	%bl
	movl	%ecx, %eax
	andl	$7, %eax
	addl	$3, %eax
	cmpb	%dl, %al
	setge	%al
	andl	%ebx, %eax
	testb	%al, %al
	je	.L551
	subl	$12, %esp
	pushl	%ecx
	call	__asan_report_store4
.L551:
	movl	%esi, 16(%edi)
	addl	$1, -200(%ebp)
.L548:
	movl	8(%ebp), %eax
	addl	$52, %eax
	movl	%eax, %edx
	movl	%edx, %eax
	shrl	$3, %eax
	addl	$536870912, %eax
	movzbl	(%eax), %ecx
	testb	%cl, %cl
	setne	%bl
	movl	%edx, %eax
	andl	$7, %eax
	addl	$3, %eax
	cmpb	%cl, %al
	setge	%al
	andl	%ebx, %eax
	testb	%al, %al
	je	.L552
	subl	$12, %esp
	pushl	%edx
	call	__asan_report_load4
.L552:
	movl	8(%ebp), %eax
	movl	52(%eax), %eax
	cmpl	-200(%ebp), %eax
	jg	.L553
	movl	8(%ebp), %eax
	addl	$92, %eax
	movl	%eax, %edx
	movl	%edx, %eax
	shrl	$3, %eax
	addl	$536870912, %eax
	movzbl	(%eax), %ecx
	testb	%cl, %cl
	setne	%bl
	movl	%edx, %eax
	andl	$7, %eax
	addl	$3, %eax
	cmpb	%cl, %al
	setge	%al
	andl	%ebx, %eax
	testb	%al, %al
	je	.L554
	subl	$12, %esp
	pushl	%edx
	call	__asan_report_load4
.L554:
	movl	8(%ebp), %eax
	movl	92(%eax), %esi
	movl	8(%ebp), %eax
	addl	$88, %eax
	movl	%eax, %ecx
	movl	%ecx, %eax
	shrl	$3, %eax
	addl	$536870912, %eax
	movzbl	(%eax), %edx
	testb	%dl, %dl
	setne	%bl
	movl	%ecx, %eax
	andl	$7, %eax
	addl	$3, %eax
	cmpb	%dl, %al
	setge	%al
	andl	%ebx, %eax
	testb	%al, %al
	je	.L555
	subl	$12, %esp
	pushl	%ecx
	call	__asan_report_load4
.L555:
	movl	8(%ebp), %eax
	movl	88(%eax), %eax
	cmpl	%eax, %esi
	jl	.L556
	subl	$8, %esp
	pushl	12(%ebp)
	pushl	8(%ebp)
	call	finish_connection
	addl	$16, %esp
	jmp	.L495
.L556:
	movl	8(%ebp), %eax
	addl	$80, %eax
	movl	%eax, %edx
	movl	%edx, %eax
	shrl	$3, %eax
	addl	$536870912, %eax
	movzbl	(%eax), %ecx
	testb	%cl, %cl
	setne	%bl
	movl	%edx, %eax
	andl	$7, %eax
	addl	$3, %eax
	cmpb	%cl, %al
	setge	%al
	andl	%ebx, %eax
	testb	%al, %al
	je	.L557
	subl	$12, %esp
	pushl	%edx
	call	__asan_report_load4
.L557:
	movl	8(%ebp), %eax
	movl	80(%eax), %eax
	cmpl	$100, %eax
	jle	.L558
	movl	8(%ebp), %eax
	movl	80(%eax), %eax
	leal	-100(%eax), %edx
	movl	8(%ebp), %eax
	movl	%edx, 80(%eax)
.L558:
	movl	8(%ebp), %eax
	addl	$56, %eax
	movl	%eax, %edx
	movl	%edx, %eax
	shrl	$3, %eax
	addl	$536870912, %eax
	movzbl	(%eax), %ecx
	testb	%cl, %cl
	setne	%bl
	movl	%edx, %eax
	andl	$7, %eax
	addl	$3, %eax
	cmpb	%cl, %al
	setge	%al
	andl	%ebx, %eax
	testb	%al, %al
	je	.L559
	subl	$12, %esp
	pushl	%edx
	call	__asan_report_load4
.L559:
	movl	8(%ebp), %eax
	movl	56(%eax), %eax
	cmpl	$-1, %eax
	je	.L495
	movl	12(%ebp), %eax
	movl	%eax, %edx
	movl	%edx, %eax
	shrl	$3, %eax
	addl	$536870912, %eax
	movzbl	(%eax), %ecx
	testb	%cl, %cl
	setne	%bl
	movl	%edx, %eax
	andl	$7, %eax
	addl	$3, %eax
	cmpb	%cl, %al
	setge	%al
	andl	%ebx, %eax
	testb	%al, %al
	je	.L561
	subl	$12, %esp
	pushl	%edx
	call	__asan_report_load4
.L561:
	movl	12(%ebp), %eax
	movl	(%eax), %esi
	movl	8(%ebp), %eax
	addl	$64, %eax
	movl	%eax, %ecx
	movl	%ecx, %eax
	shrl	$3, %eax
	addl	$536870912, %eax
	movzbl	(%eax), %edx
	testb	%dl, %dl
	setne	%bl
	movl	%ecx, %eax
	andl	$7, %eax
	addl	$3, %eax
	cmpb	%dl, %al
	setge	%al
	andl	%ebx, %eax
	testb	%al, %al
	je	.L562
	subl	$12, %esp
	pushl	%ecx
	call	__asan_report_load4
.L562:
	movl	8(%ebp), %eax
	movl	64(%eax), %eax
	subl	%eax, %esi
	movl	%esi, %eax
	movl	%eax, -204(%ebp)
	cmpl	$0, -204(%ebp)
	jne	.L563
	movl	$1, -204(%ebp)
.L563:
	movl	8(%ebp), %eax
	addl	$8, %eax
	movl	%eax, %edx
	movl	%edx, %eax
	shrl	$3, %eax
	addl	$536870912, %eax
	movzbl	(%eax), %ecx
	testb	%cl, %cl
	setne	%bl
	movl	%edx, %eax
	andl	$7, %eax
	addl	$3, %eax
	cmpb	%cl, %al
	setge	%al
	andl	%ebx, %eax
	testb	%al, %al
	je	.L564
	subl	$12, %esp
	pushl	%edx
	call	__asan_report_load4
.L564:
	movl	8(%ebp), %eax
	movl	8(%eax), %ebx
	leal	168(%ebx), %eax
	movl	%eax, %ecx
	movl	%ecx, %eax
	shrl	$3, %eax
	addl	$536870912, %eax
	movzbl	(%eax), %edx
	testb	%dl, %dl
	setne	%al
	movl	%eax, %esi
	movl	%ecx, %eax
	andl	$7, %eax
	addl	$3, %eax
	cmpb	%dl, %al
	setge	%al
	andl	%esi, %eax
	testb	%al, %al
	je	.L565
	subl	$12, %esp
	pushl	%ecx
	call	__asan_report_load4
.L565:
	movl	168(%ebx), %eax
	cltd
	idivl	-204(%ebp)
	movl	%eax, %esi
	movl	8(%ebp), %eax
	addl	$56, %eax
	movl	%eax, %ecx
	movl	%ecx, %eax
	shrl	$3, %eax
	addl	$536870912, %eax
	movzbl	(%eax), %edx
	testb	%dl, %dl
	setne	%bl
	movl	%ecx, %eax
	andl	$7, %eax
	addl	$3, %eax
	cmpb	%dl, %al
	setge	%al
	andl	%ebx, %eax
	testb	%al, %al
	je	.L566
	subl	$12, %esp
	pushl	%ecx
	call	__asan_report_load4
.L566:
	movl	8(%ebp), %eax
	movl	56(%eax), %eax
	cmpl	%eax, %esi
	jle	.L495
	movl	8(%ebp), %eax
	movl	%eax, %edx
	movl	%edx, %eax
	shrl	$3, %eax
	addl	$536870912, %eax
	movzbl	(%eax), %ecx
	testb	%cl, %cl
	setne	%bl
	movl	%edx, %eax
	andl	$7, %eax
	addl	$3, %eax
	cmpb	%cl, %al
	setge	%al
	andl	%ebx, %eax
	testb	%al, %al
	je	.L567
	subl	$12, %esp
	pushl	%edx
	call	__asan_report_store4
.L567:
	movl	8(%ebp), %eax
	movl	$3, (%eax)
	movl	-196(%ebp), %eax
	addl	$448, %eax
	movl	%eax, %edx
	movl	%edx, %eax
	shrl	$3, %eax
	addl	$536870912, %eax
	movzbl	(%eax), %ecx
	testb	%cl, %cl
	setne	%bl
	movl	%edx, %eax
	andl	$7, %eax
	addl	$3, %eax
	cmpb	%cl, %al
	setge	%al
	andl	%ebx, %eax
	testb	%al, %al
	je	.L568
	subl	$12, %esp
	pushl	%edx
	call	__asan_report_load4
.L568:
	movl	-196(%ebp), %eax
	movl	448(%eax), %eax
	subl	$12, %esp
	pushl	%eax
	call	fdwatch_del_fd
	addl	$16, %esp
	movl	8(%ebp), %eax
	addl	$8, %eax
	movl	%eax, %edx
	movl	%edx, %eax
	shrl	$3, %eax
	addl	$536870912, %eax
	movzbl	(%eax), %ecx
	testb	%cl, %cl
	setne	%bl
	movl	%edx, %eax
	andl	$7, %eax
	addl	$3, %eax
	cmpb	%cl, %al
	setge	%al
	andl	%ebx, %eax
	testb	%al, %al
	je	.L569
	subl	$12, %esp
	pushl	%edx
	call	__asan_report_load4
.L569:
	movl	8(%ebp), %eax
	movl	8(%eax), %ebx
	leal	168(%ebx), %eax
	movl	%eax, %ecx
	movl	%ecx, %eax
	shrl	$3, %eax
	addl	$536870912, %eax
	movzbl	(%eax), %edx
	testb	%dl, %dl
	setne	%al
	movl	%eax, %esi
	movl	%ecx, %eax
	andl	$7, %eax
	addl	$3, %eax
	cmpb	%dl, %al
	setge	%al
	andl	%esi, %eax
	testb	%al, %al
	je	.L570
	subl	$12, %esp
	pushl	%ecx
	call	__asan_report_load4
.L570:
	movl	168(%ebx), %esi
	movl	8(%ebp), %eax
	addl	$56, %eax
	movl	%eax, %ecx
	movl	%ecx, %eax
	shrl	$3, %eax
	addl	$536870912, %eax
	movzbl	(%eax), %edx
	testb	%dl, %dl
	setne	%bl
	movl	%ecx, %eax
	andl	$7, %eax
	addl	$3, %eax
	cmpb	%dl, %al
	setge	%al
	andl	%ebx, %eax
	testb	%al, %al
	je	.L571
	subl	$12, %esp
	pushl	%ecx
	call	__asan_report_load4
.L571:
	movl	8(%ebp), %eax
	movl	56(%eax), %edi
	movl	%esi, %eax
	cltd
	idivl	%edi
	subl	-204(%ebp), %eax
	movl	%eax, -188(%ebp)
	movl	8(%ebp), %eax
	movl	-220(%ebp), %edi
	movl	%eax, -128(%edi)
	movl	8(%ebp), %eax
	addl	$72, %eax
	movl	%eax, %edx
	movl	%edx, %eax
	shrl	$3, %eax
	addl	$536870912, %eax
	movzbl	(%eax), %ecx
	testb	%cl, %cl
	setne	%bl
	movl	%edx, %eax
	andl	$7, %eax
	addl	$3, %eax
	cmpb	%cl, %al
	setge	%al
	andl	%ebx, %eax
	testb	%al, %al
	je	.L572
	subl	$12, %esp
	pushl	%edx
	call	__asan_report_load4
.L572:
	movl	8(%ebp), %eax
	movl	72(%eax), %eax
	testl	%eax, %eax
	je	.L573
	subl	$8, %esp
	pushl	$.LC127
	pushl	$3
	call	syslog
	addl	$16, %esp
.L573:
	cmpl	$0, -188(%ebp)
	jle	.L574
	movl	-188(%ebp), %eax
	imull	$1000, %eax, %eax
	jmp	.L575
.L574:
	movl	$500, %eax
.L575:
	subl	$12, %esp
	pushl	$0
	pushl	%eax
	movl	-220(%ebp), %eax
	pushl	-128(%eax)
	pushl	$wakeup_connection
	pushl	12(%ebp)
	call	tmr_create
	addl	$32, %esp
	movl	%eax, %ebx
	movl	8(%ebp), %eax
	addl	$72, %eax
	movl	%eax, %edx
	movl	%edx, %eax
	shrl	$3, %eax
	addl	$536870912, %eax
	movzbl	(%eax), %ecx
	testb	%cl, %cl
	setne	%al
	movl	%eax, %esi
	movl	%edx, %eax
	andl	$7, %eax
	addl	$3, %eax
	cmpb	%cl, %al
	setge	%al
	andl	%esi, %eax
	testb	%al, %al
	je	.L576
	subl	$12, %esp
	pushl	%edx
	call	__asan_report_store4
.L576:
	movl	8(%ebp), %eax
	movl	%ebx, 72(%eax)
	movl	8(%ebp), %eax
	movl	72(%eax), %eax
	testl	%eax, %eax
	jne	.L495
	subl	$8, %esp
	pushl	$.LC128
	pushl	$2
	call	syslog
	addl	$16, %esp
	call	__asan_handle_no_return
	subl	$12, %esp
	pushl	$1
	call	exit
.L495:
	movl	-224(%ebp), %edi
	cmpl	%edi, -248(%ebp)
	je	.L493
	movl	-224(%ebp), %eax
	movl	$1172321806, (%eax)
	movl	-236(%ebp), %eax
	movl	$-168430091, 536870912(%eax)
	movl	$-168430091, 536870916(%eax)
	movl	$-168430091, 536870920(%eax)
	movl	$-168430091, 536870924(%eax)
	movl	$-168430091, 536870928(%eax)
	jmp	.L494
.L493:
	movl	-236(%ebp), %eax
	movl	$0, 536870912(%eax)
	movl	$0, 536870916(%eax)
	movl	$0, 536870920(%eax)
	movl	$0, 536870924(%eax)
	movl	$0, 536870928(%eax)
.L494:
	leal	-12(%ebp), %esp
	popl	%ebx
	popl	%esi
	popl	%edi
	popl	%ebp
	ret
	.size	handle_send, .-handle_send
	.section	.rodata
.LC130:
	.string	"1 32 4096 3 buf "
	.text
	.type	handle_linger, @function
handle_linger:
.LASANPC20:
	pushl	%ebp
	movl	%esp, %ebp
	pushl	%edi
	pushl	%esi
	pushl	%ebx
	subl	$4204, %esp
	leal	-4184(%ebp), %ebx
	movl	%ebx, -4204(%ebp)
	cmpl	$0, __asan_option_detect_stack_use_after_return
	je	.L578
	subl	$8, %esp
	pushl	%ebx
	pushl	$4160
	call	__asan_stack_malloc_7
	addl	$16, %esp
	movl	%eax, %ebx
.L578:
	leal	4160(%ebx), %eax
	movl	%eax, -4208(%ebp)
	movl	$1102416563, (%ebx)
	movl	$.LC130, 4(%ebx)
	movl	$.LASANPC20, 8(%ebx)
	movl	%ebx, %eax
	shrl	$3, %eax
	movl	%eax, -4212(%ebp)
	movl	$-235802127, 536870912(%eax)
	movl	$-202116109, 536871428(%eax)
	movl	8(%ebp), %eax
	addl	$8, %eax
	movl	%eax, %edx
	movl	%edx, %eax
	shrl	$3, %eax
	addl	$536870912, %eax
	movzbl	(%eax), %ecx
	testb	%cl, %cl
	setne	%al
	movl	%eax, %esi
	movl	%edx, %eax
	andl	$7, %eax
	addl	$3, %eax
	cmpb	%cl, %al
	setge	%al
	andl	%esi, %eax
	testb	%al, %al
	je	.L582
	subl	$12, %esp
	pushl	%edx
	call	__asan_report_load4
.L582:
	movl	8(%ebp), %eax
	movl	8(%eax), %esi
	leal	448(%esi), %eax
	movl	%eax, %ecx
	movl	%ecx, %eax
	shrl	$3, %eax
	addl	$536870912, %eax
	movzbl	(%eax), %edx
	testb	%dl, %dl
	setne	%al
	movl	%eax, %edi
	movl	%ecx, %eax
	andl	$7, %eax
	addl	$3, %eax
	cmpb	%dl, %al
	setge	%al
	andl	%edi, %eax
	testb	%al, %al
	je	.L583
	subl	$12, %esp
	pushl	%ecx
	call	__asan_report_load4
.L583:
	movl	448(%esi), %eax
	subl	$4, %esp
	pushl	$4096
	movl	-4208(%ebp), %edx
	subl	$4128, %edx
	pushl	%edx
	pushl	%eax
	call	read
	addl	$16, %esp
	movl	%eax, -4188(%ebp)
	cmpl	$0, -4188(%ebp)
	jns	.L584
	call	__errno_location
	movl	%eax, %esi
	movl	%esi, %edx
	movl	%edx, %eax
	shrl	$3, %eax
	addl	$536870912, %eax
	movzbl	(%eax), %ecx
	testb	%cl, %cl
	setne	%al
	movl	%eax, %edi
	movl	%edx, %eax
	andl	$7, %eax
	addl	$3, %eax
	cmpb	%cl, %al
	setge	%al
	andl	%edi, %eax
	testb	%al, %al
	je	.L585
	subl	$12, %esp
	pushl	%edx
	call	__asan_report_load4
.L585:
	movl	(%esi), %eax
	cmpl	$4, %eax
	je	.L581
	call	__errno_location
	movl	%eax, %esi
	movl	%esi, %edx
	movl	%edx, %eax
	shrl	$3, %eax
	addl	$536870912, %eax
	movzbl	(%eax), %ecx
	testb	%cl, %cl
	setne	%al
	movl	%eax, %edi
	movl	%edx, %eax
	andl	$7, %eax
	addl	$3, %eax
	cmpb	%cl, %al
	setge	%al
	andl	%edi, %eax
	testb	%al, %al
	je	.L587
	subl	$12, %esp
	pushl	%edx
	call	__asan_report_load4
.L587:
	movl	(%esi), %eax
	cmpl	$11, %eax
	je	.L581
.L584:
	cmpl	$0, -4188(%ebp)
	jg	.L581
	subl	$8, %esp
	pushl	12(%ebp)
	pushl	8(%ebp)
	call	really_clear_connection
	addl	$16, %esp
.L581:
	cmpl	%ebx, -4204(%ebp)
	je	.L579
	movl	$1172321806, (%ebx)
	subl	$4, %esp
	pushl	-4204(%ebp)
	pushl	$4160
	pushl	%ebx
	call	__asan_stack_free_7
	addl	$16, %esp
	jmp	.L580
.L579:
	movl	-4212(%ebp), %eax
	movl	$0, 536870912(%eax)
	movl	$0, 536871428(%eax)
.L580:
	leal	-12(%ebp), %esp
	popl	%ebx
	popl	%esi
	popl	%edi
	popl	%ebp
	ret
	.size	handle_linger, .-handle_linger
	.section	.rodata
	.align 32
.LC131:
	.string	"throttle sending count was negative - shouldn't happen!"
	.zero	40
	.text
	.type	check_throttles, @function
check_throttles:
.LASANPC21:
	pushl	%ebp
	movl	%esp, %ebp
	pushl	%edi
	pushl	%esi
	pushl	%ebx
	subl	$44, %esp
	movl	8(%ebp), %eax
	addl	$52, %eax
	movl	%eax, %edx
	shrl	$3, %edx
	addl	$536870912, %edx
	movzbl	(%edx), %edx
	testb	%dl, %dl
	setne	%cl
	movl	%eax, %ebx
	andl	$7, %ebx
	addl	$3, %ebx
	cmpb	%dl, %bl
	setge	%dl
	andl	%ecx, %edx
	testb	%dl, %dl
	je	.L591
	subl	$12, %esp
	pushl	%eax
	call	__asan_report_store4
.L591:
	movl	8(%ebp), %eax
	movl	$0, 52(%eax)
	movl	8(%ebp), %eax
	addl	$60, %eax
	movl	%eax, %edx
	shrl	$3, %edx
	addl	$536870912, %edx
	movzbl	(%edx), %edx
	testb	%dl, %dl
	setne	%cl
	movl	%eax, %ebx
	andl	$7, %ebx
	addl	$3, %ebx
	cmpb	%dl, %bl
	setge	%dl
	andl	%ecx, %edx
	testb	%dl, %dl
	je	.L592
	subl	$12, %esp
	pushl	%eax
	call	__asan_report_store4
.L592:
	movl	8(%ebp), %eax
	movl	$-1, 60(%eax)
	movl	8(%ebp), %eax
	movl	60(%eax), %edi
	movl	8(%ebp), %eax
	addl	$56, %eax
	movl	%eax, %edx
	shrl	$3, %edx
	addl	$536870912, %edx
	movzbl	(%edx), %edx
	testb	%dl, %dl
	setne	%bl
	movl	%eax, %esi
	andl	$7, %esi
	addl	$3, %esi
	movl	%esi, %ecx
	cmpb	%dl, %cl
	setge	%dl
	andl	%ebx, %edx
	testb	%dl, %dl
	je	.L593
	subl	$12, %esp
	pushl	%eax
	call	__asan_report_store4
.L593:
	movl	8(%ebp), %eax
	movl	%edi, 56(%eax)
	movl	$0, -32(%ebp)
	jmp	.L594
.L624:
	movl	8(%ebp), %eax
	addl	$8, %eax
	movl	%eax, %edx
	shrl	$3, %edx
	addl	$536870912, %edx
	movzbl	(%edx), %edx
	testb	%dl, %dl
	setne	%cl
	movl	%eax, %ebx
	andl	$7, %ebx
	addl	$3, %ebx
	cmpb	%dl, %bl
	setge	%dl
	andl	%ecx, %edx
	testb	%dl, %dl
	je	.L595
	subl	$12, %esp
	pushl	%eax
	call	__asan_report_load4
.L595:
	movl	8(%ebp), %eax
	movl	8(%eax), %edx
	leal	188(%edx), %eax
	movl	%eax, %ecx
	shrl	$3, %ecx
	addl	$536870912, %ecx
	movzbl	(%ecx), %ecx
	testb	%cl, %cl
	setne	%bl
	movl	%ebx, %edi
	movl	%eax, %esi
	andl	$7, %esi
	addl	$3, %esi
	movl	%esi, %ebx
	cmpb	%cl, %bl
	setge	%cl
	andl	%edi, %ecx
	testb	%cl, %cl
	je	.L596
	subl	$12, %esp
	pushl	%eax
	call	__asan_report_load4
.L596:
	movl	188(%edx), %eax
	movl	%eax, -44(%ebp)
	movl	throttles, %ecx
	movl	-32(%ebp), %edx
	movl	%edx, %eax
	addl	%eax, %eax
	addl	%edx, %eax
	sall	$3, %eax
	addl	%eax, %ecx
	movl	%ecx, %eax
	movl	%eax, %edx
	shrl	$3, %edx
	addl	$536870912, %edx
	movzbl	(%edx), %edx
	testb	%dl, %dl
	setne	%bl
	movl	%ebx, %esi
	movl	%eax, %edi
	andl	$7, %edi
	addl	$3, %edi
	movl	%edi, %ebx
	cmpb	%dl, %bl
	setge	%dl
	andl	%esi, %edx
	testb	%dl, %dl
	je	.L597
	subl	$12, %esp
	pushl	%eax
	call	__asan_report_load4
.L597:
	movl	(%ecx), %eax
	subl	$8, %esp
	pushl	-44(%ebp)
	pushl	%eax
	call	match
	addl	$16, %esp
	testl	%eax, %eax
	je	.L598
	movl	throttles, %ecx
	movl	-32(%ebp), %edx
	movl	%edx, %eax
	addl	%eax, %eax
	addl	%edx, %eax
	sall	$3, %eax
	leal	(%ecx,%eax), %edx
	leal	12(%edx), %eax
	movl	%eax, %ecx
	shrl	$3, %ecx
	addl	$536870912, %ecx
	movzbl	(%ecx), %ecx
	testb	%cl, %cl
	setne	%bl
	movl	%ebx, %edi
	movl	%eax, %esi
	andl	$7, %esi
	addl	$3, %esi
	movl	%esi, %ebx
	cmpb	%cl, %bl
	setge	%cl
	andl	%edi, %ecx
	testb	%cl, %cl
	je	.L599
	subl	$12, %esp
	pushl	%eax
	call	__asan_report_load4
.L599:
	movl	12(%edx), %eax
	movl	%eax, -44(%ebp)
	movl	throttles, %ecx
	movl	-32(%ebp), %edx
	movl	%edx, %eax
	addl	%eax, %eax
	addl	%edx, %eax
	sall	$3, %eax
	leal	(%ecx,%eax), %edx
	leal	4(%edx), %eax
	movl	%eax, %ecx
	shrl	$3, %ecx
	addl	$536870912, %ecx
	movzbl	(%ecx), %ecx
	testb	%cl, %cl
	setne	%bl
	movl	%ebx, %esi
	movl	%eax, %edi
	andl	$7, %edi
	addl	$3, %edi
	movl	%edi, %ebx
	cmpb	%cl, %bl
	setge	%cl
	andl	%esi, %ecx
	testb	%cl, %cl
	je	.L600
	subl	$12, %esp
	pushl	%eax
	call	__asan_report_load4
.L600:
	movl	4(%edx), %eax
	addl	%eax, %eax
	cmpl	%eax, -44(%ebp)
	jle	.L601
	movl	$0, %eax
	jmp	.L602
.L601:
	movl	throttles, %ecx
	movl	-32(%ebp), %edx
	movl	%edx, %eax
	addl	%eax, %eax
	addl	%edx, %eax
	sall	$3, %eax
	leal	(%ecx,%eax), %edx
	leal	12(%edx), %eax
	movl	%eax, %ecx
	shrl	$3, %ecx
	addl	$536870912, %ecx
	movzbl	(%ecx), %ecx
	testb	%cl, %cl
	setne	%bl
	movl	%ebx, %edi
	movl	%eax, %esi
	andl	$7, %esi
	addl	$3, %esi
	movl	%esi, %ebx
	cmpb	%cl, %bl
	setge	%cl
	andl	%edi, %ecx
	testb	%cl, %cl
	je	.L603
	subl	$12, %esp
	pushl	%eax
	call	__asan_report_load4
.L603:
	movl	12(%edx), %eax
	movl	%eax, -44(%ebp)
	movl	throttles, %ecx
	movl	-32(%ebp), %edx
	movl	%edx, %eax
	addl	%eax, %eax
	addl	%edx, %eax
	sall	$3, %eax
	leal	(%ecx,%eax), %edx
	leal	8(%edx), %eax
	movl	%eax, %ecx
	shrl	$3, %ecx
	addl	$536870912, %ecx
	movzbl	(%ecx), %ecx
	testb	%cl, %cl
	setne	%bl
	movl	%ebx, %esi
	movl	%eax, %edi
	andl	$7, %edi
	addl	$3, %edi
	movl	%edi, %ebx
	cmpb	%cl, %bl
	setge	%cl
	andl	%esi, %ecx
	testb	%cl, %cl
	je	.L604
	subl	$12, %esp
	pushl	%eax
	call	__asan_report_load4
.L604:
	movl	8(%edx), %eax
	cmpl	%eax, -44(%ebp)
	jge	.L605
	movl	$0, %eax
	jmp	.L602
.L605:
	movl	throttles, %ecx
	movl	-32(%ebp), %edx
	movl	%edx, %eax
	addl	%eax, %eax
	addl	%edx, %eax
	sall	$3, %eax
	leal	(%ecx,%eax), %edx
	leal	20(%edx), %eax
	movl	%eax, %ecx
	shrl	$3, %ecx
	addl	$536870912, %ecx
	movzbl	(%ecx), %ecx
	testb	%cl, %cl
	setne	%bl
	movl	%ebx, %edi
	movl	%eax, %esi
	andl	$7, %esi
	addl	$3, %esi
	movl	%esi, %ebx
	cmpb	%cl, %bl
	setge	%cl
	andl	%edi, %ecx
	testb	%cl, %cl
	je	.L606
	subl	$12, %esp
	pushl	%eax
	call	__asan_report_load4
.L606:
	movl	20(%edx), %eax
	testl	%eax, %eax
	jns	.L607
	subl	$8, %esp
	pushl	$.LC131
	pushl	$3
	call	syslog
	addl	$16, %esp
	movl	throttles, %ecx
	movl	-32(%ebp), %edx
	movl	%edx, %eax
	addl	%eax, %eax
	addl	%edx, %eax
	sall	$3, %eax
	leal	(%ecx,%eax), %edx
	leal	20(%edx), %eax
	movl	%eax, %ecx
	shrl	$3, %ecx
	addl	$536870912, %ecx
	movzbl	(%ecx), %ecx
	testb	%cl, %cl
	setne	%bl
	movl	%ebx, %edi
	movl	%eax, %esi
	andl	$7, %esi
	addl	$3, %esi
	movl	%esi, %ebx
	cmpb	%cl, %bl
	setge	%cl
	andl	%edi, %ecx
	testb	%cl, %cl
	je	.L608
	subl	$12, %esp
	pushl	%eax
	call	__asan_report_store4
.L608:
	movl	$0, 20(%edx)
.L607:
	movl	8(%ebp), %eax
	addl	$52, %eax
	movl	%eax, %edx
	shrl	$3, %edx
	addl	$536870912, %edx
	movzbl	(%edx), %edx
	testb	%dl, %dl
	setne	%cl
	movl	%eax, %ebx
	andl	$7, %ebx
	addl	$3, %ebx
	cmpb	%dl, %bl
	setge	%dl
	andl	%ecx, %edx
	testb	%dl, %dl
	je	.L609
	subl	$12, %esp
	pushl	%eax
	call	__asan_report_load4
.L609:
	movl	8(%ebp), %eax
	movl	52(%eax), %eax
	leal	1(%eax), %ecx
	movl	8(%ebp), %edx
	movl	%ecx, 52(%edx)
	leal	0(,%eax,4), %ecx
	movl	8(%ebp), %edx
	addl	%ecx, %edx
	addl	$12, %edx
	movl	%edx, %ecx
	shrl	$3, %ecx
	addl	$536870912, %ecx
	movzbl	(%ecx), %ecx
	testb	%cl, %cl
	setne	%bl
	movl	%ebx, %edi
	movl	%edx, %esi
	andl	$7, %esi
	addl	$3, %esi
	movl	%esi, %ebx
	cmpb	%cl, %bl
	setge	%cl
	andl	%edi, %ecx
	testb	%cl, %cl
	je	.L610
	subl	$12, %esp
	pushl	%edx
	call	__asan_report_store4
.L610:
	movl	8(%ebp), %edx
	movl	-32(%ebp), %ecx
	movl	%ecx, 12(%edx,%eax,4)
	movl	throttles, %ecx
	movl	-32(%ebp), %edx
	movl	%edx, %eax
	addl	%eax, %eax
	addl	%edx, %eax
	sall	$3, %eax
	addl	%ecx, %eax
	leal	20(%eax), %edx
	movl	%edx, %ecx
	shrl	$3, %ecx
	addl	$536870912, %ecx
	movzbl	(%ecx), %ecx
	testb	%cl, %cl
	setne	%bl
	movl	%ebx, %edi
	movl	%edx, %esi
	andl	$7, %esi
	addl	$3, %esi
	movl	%esi, %ebx
	cmpb	%cl, %bl
	setge	%cl
	andl	%edi, %ecx
	testb	%cl, %cl
	je	.L611
	subl	$12, %esp
	pushl	%edx
	call	__asan_report_load4
.L611:
	movl	20(%eax), %edx
	addl	$1, %edx
	movl	%edx, 20(%eax)
	movl	throttles, %ecx
	movl	-32(%ebp), %edx
	movl	%edx, %eax
	addl	%eax, %eax
	addl	%edx, %eax
	sall	$3, %eax
	leal	(%ecx,%eax), %edx
	leal	4(%edx), %eax
	movl	%eax, %ecx
	shrl	$3, %ecx
	addl	$536870912, %ecx
	movzbl	(%ecx), %ecx
	testb	%cl, %cl
	setne	%bl
	movl	%ebx, %edi
	movl	%eax, %esi
	andl	$7, %esi
	addl	$3, %esi
	movl	%esi, %ebx
	cmpb	%cl, %bl
	setge	%cl
	andl	%edi, %ecx
	testb	%cl, %cl
	je	.L612
	subl	$12, %esp
	pushl	%eax
	call	__asan_report_load4
.L612:
	movl	4(%edx), %eax
	movl	%eax, -44(%ebp)
	movl	throttles, %ecx
	movl	-32(%ebp), %edx
	movl	%edx, %eax
	addl	%eax, %eax
	addl	%edx, %eax
	sall	$3, %eax
	leal	(%ecx,%eax), %edx
	leal	20(%edx), %eax
	movl	%eax, %ecx
	shrl	$3, %ecx
	addl	$536870912, %ecx
	movzbl	(%ecx), %ecx
	testb	%cl, %cl
	setne	%bl
	movl	%ebx, %esi
	movl	%eax, %edi
	andl	$7, %edi
	addl	$3, %edi
	movl	%edi, %ebx
	cmpb	%cl, %bl
	setge	%cl
	andl	%esi, %ecx
	testb	%cl, %cl
	je	.L613
	subl	$12, %esp
	pushl	%eax
	call	__asan_report_load4
.L613:
	movl	20(%edx), %edi
	movl	-44(%ebp), %eax
	cltd
	idivl	%edi
	movl	%eax, -28(%ebp)
	movl	8(%ebp), %eax
	addl	$56, %eax
	movl	%eax, %edx
	shrl	$3, %edx
	addl	$536870912, %edx
	movzbl	(%edx), %edx
	testb	%dl, %dl
	setne	%cl
	movl	%eax, %ebx
	andl	$7, %ebx
	addl	$3, %ebx
	cmpb	%dl, %bl
	setge	%dl
	andl	%ecx, %edx
	testb	%dl, %dl
	je	.L614
	subl	$12, %esp
	pushl	%eax
	call	__asan_report_load4
.L614:
	movl	8(%ebp), %eax
	movl	56(%eax), %eax
	cmpl	$-1, %eax
	jne	.L615
	movl	8(%ebp), %eax
	movl	-28(%ebp), %edx
	movl	%edx, 56(%eax)
	jmp	.L616
.L615:
	movl	8(%ebp), %eax
	addl	$56, %eax
	movl	%eax, %edx
	shrl	$3, %edx
	addl	$536870912, %edx
	movzbl	(%edx), %edx
	testb	%dl, %dl
	setne	%cl
	movl	%eax, %ebx
	andl	$7, %ebx
	addl	$3, %ebx
	cmpb	%dl, %bl
	setge	%dl
	andl	%ecx, %edx
	testb	%dl, %dl
	je	.L617
	subl	$12, %esp
	pushl	%eax
	call	__asan_report_load4
.L617:
	movl	8(%ebp), %eax
	movl	56(%eax), %edx
	movl	-28(%ebp), %eax
	cmpl	%eax, %edx
	cmovg	%eax, %edx
	movl	8(%ebp), %eax
	movl	%edx, 56(%eax)
.L616:
	movl	throttles, %ecx
	movl	-32(%ebp), %edx
	movl	%edx, %eax
	addl	%eax, %eax
	addl	%edx, %eax
	sall	$3, %eax
	leal	(%ecx,%eax), %edx
	leal	8(%edx), %eax
	movl	%eax, %ecx
	shrl	$3, %ecx
	addl	$536870912, %ecx
	movzbl	(%ecx), %ecx
	testb	%cl, %cl
	setne	%bl
	movl	%ebx, %edi
	movl	%eax, %esi
	andl	$7, %esi
	addl	$3, %esi
	movl	%esi, %ebx
	cmpb	%cl, %bl
	setge	%cl
	andl	%edi, %ecx
	testb	%cl, %cl
	je	.L618
	subl	$12, %esp
	pushl	%eax
	call	__asan_report_load4
.L618:
	movl	8(%edx), %eax
	movl	%eax, -28(%ebp)
	movl	8(%ebp), %eax
	addl	$60, %eax
	movl	%eax, %edx
	shrl	$3, %edx
	addl	$536870912, %edx
	movzbl	(%edx), %edx
	testb	%dl, %dl
	setne	%cl
	movl	%eax, %ebx
	andl	$7, %ebx
	addl	$3, %ebx
	cmpb	%dl, %bl
	setge	%dl
	andl	%ecx, %edx
	testb	%dl, %dl
	je	.L619
	subl	$12, %esp
	pushl	%eax
	call	__asan_report_load4
.L619:
	movl	8(%ebp), %eax
	movl	60(%eax), %eax
	cmpl	$-1, %eax
	jne	.L620
	movl	8(%ebp), %eax
	movl	-28(%ebp), %edx
	movl	%edx, 60(%eax)
	jmp	.L598
.L620:
	movl	8(%ebp), %eax
	addl	$60, %eax
	movl	%eax, %edx
	shrl	$3, %edx
	addl	$536870912, %edx
	movzbl	(%edx), %edx
	testb	%dl, %dl
	setne	%cl
	movl	%eax, %ebx
	andl	$7, %ebx
	addl	$3, %ebx
	cmpb	%dl, %bl
	setge	%dl
	andl	%ecx, %edx
	testb	%dl, %dl
	je	.L621
	subl	$12, %esp
	pushl	%eax
	call	__asan_report_load4
.L621:
	movl	8(%ebp), %eax
	movl	60(%eax), %edx
	movl	-28(%ebp), %eax
	cmpl	%eax, %edx
	cmovl	%eax, %edx
	movl	8(%ebp), %eax
	movl	%edx, 60(%eax)
.L598:
	addl	$1, -32(%ebp)
.L594:
	movl	numthrottles, %eax
	cmpl	%eax, -32(%ebp)
	jge	.L622
	movl	8(%ebp), %eax
	addl	$52, %eax
	movl	%eax, %edx
	shrl	$3, %edx
	addl	$536870912, %edx
	movzbl	(%edx), %edx
	testb	%dl, %dl
	setne	%cl
	movl	%eax, %ebx
	andl	$7, %ebx
	addl	$3, %ebx
	cmpb	%dl, %bl
	setge	%dl
	andl	%ecx, %edx
	testb	%dl, %dl
	je	.L623
	subl	$12, %esp
	pushl	%eax
	call	__asan_report_load4
.L623:
	movl	8(%ebp), %eax
	movl	52(%eax), %eax
	cmpl	$9, %eax
	jle	.L624
.L622:
	movl	$1, %eax
.L602:
	leal	-12(%ebp), %esp
	popl	%ebx
	popl	%esi
	popl	%edi
	popl	%ebp
	ret
	.size	check_throttles, .-check_throttles
	.type	clear_throttles, @function
clear_throttles:
.LASANPC22:
	pushl	%ebp
	movl	%esp, %ebp
	pushl	%edi
	pushl	%esi
	pushl	%ebx
	subl	$28, %esp
	movl	$0, -28(%ebp)
	jmp	.L626
.L630:
	movl	throttles, %edi
	movl	-28(%ebp), %eax
	leal	0(,%eax,4), %edx
	movl	8(%ebp), %eax
	addl	%edx, %eax
	addl	$12, %eax
	movl	%eax, %edx
	shrl	$3, %edx
	addl	$536870912, %edx
	movzbl	(%edx), %edx
	testb	%dl, %dl
	setne	%bl
	movl	%eax, %esi
	andl	$7, %esi
	addl	$3, %esi
	movl	%esi, %ecx
	cmpb	%dl, %cl
	setge	%dl
	andl	%ebx, %edx
	testb	%dl, %dl
	je	.L627
	subl	$12, %esp
	pushl	%eax
	call	__asan_report_load4
.L627:
	movl	8(%ebp), %eax
	movl	-28(%ebp), %edx
	movl	12(%eax,%edx,4), %eax
	movl	%eax, %edx
	movl	%edx, %eax
	addl	%eax, %eax
	addl	%edx, %eax
	sall	$3, %eax
	addl	%edi, %eax
	leal	20(%eax), %edx
	movl	%edx, %ecx
	shrl	$3, %ecx
	addl	$536870912, %ecx
	movzbl	(%ecx), %ecx
	testb	%cl, %cl
	setne	%bl
	movl	%ebx, %edi
	movl	%edx, %esi
	andl	$7, %esi
	addl	$3, %esi
	movl	%esi, %ebx
	cmpb	%cl, %bl
	setge	%cl
	andl	%edi, %ecx
	testb	%cl, %cl
	je	.L628
	subl	$12, %esp
	pushl	%edx
	call	__asan_report_load4
.L628:
	movl	20(%eax), %edx
	subl	$1, %edx
	movl	%edx, 20(%eax)
	addl	$1, -28(%ebp)
.L626:
	movl	8(%ebp), %eax
	addl	$52, %eax
	movl	%eax, %edx
	shrl	$3, %edx
	addl	$536870912, %edx
	movzbl	(%edx), %edx
	testb	%dl, %dl
	setne	%cl
	movl	%eax, %ebx
	andl	$7, %ebx
	addl	$3, %ebx
	cmpb	%dl, %bl
	setge	%dl
	andl	%ecx, %edx
	testb	%dl, %dl
	je	.L629
	subl	$12, %esp
	pushl	%eax
	call	__asan_report_load4
.L629:
	movl	8(%ebp), %eax
	movl	52(%eax), %eax
	cmpl	-28(%ebp), %eax
	jg	.L630
	leal	-12(%ebp), %esp
	popl	%ebx
	popl	%esi
	popl	%edi
	popl	%ebp
	ret
	.size	clear_throttles, .-clear_throttles
	.section	.rodata
	.align 32
.LC132:
	.string	"throttle #%d '%.80s' rate %ld greatly exceeding limit %ld; %d sending"
	.zero	58
	.align 32
.LC133:
	.string	"throttle #%d '%.80s' rate %ld exceeding limit %ld; %d sending"
	.zero	34
	.align 32
.LC134:
	.string	"throttle #%d '%.80s' rate %ld lower than minimum %ld; %d sending"
	.zero	63
	.text
	.type	update_throttles, @function
update_throttles:
.LASANPC23:
	pushl	%ebp
	movl	%esp, %ebp
	pushl	%edi
	pushl	%esi
	pushl	%ebx
	subl	$60, %esp
	movl	$0, -44(%ebp)
	jmp	.L632
.L660:
	movl	throttles, %ecx
	movl	-44(%ebp), %edx
	movl	%edx, %eax
	addl	%eax, %eax
	addl	%edx, %eax
	sall	$3, %eax
	leal	(%ecx,%eax), %edi
	movl	throttles, %ecx
	movl	-44(%ebp), %edx
	movl	%edx, %eax
	addl	%eax, %eax
	addl	%edx, %eax
	sall	$3, %eax
	leal	(%ecx,%eax), %edx
	leal	12(%edx), %eax
	movl	%eax, %ecx
	shrl	$3, %ecx
	addl	$536870912, %ecx
	movzbl	(%ecx), %ecx
	testb	%cl, %cl
	setne	-60(%ebp)
	movl	%eax, %esi
	andl	$7, %esi
	addl	$3, %esi
	movl	%esi, %ebx
	cmpb	%cl, %bl
	setge	%cl
	andb	-60(%ebp), %cl
	testb	%cl, %cl
	je	.L633
	subl	$12, %esp
	pushl	%eax
	call	__asan_report_load4
.L633:
	movl	12(%edx), %eax
	leal	(%eax,%eax), %esi
	movl	throttles, %ecx
	movl	-44(%ebp), %edx
	movl	%edx, %eax
	addl	%eax, %eax
	addl	%edx, %eax
	sall	$3, %eax
	addl	%eax, %ecx
	leal	16(%ecx), %eax
	movl	%eax, %edx
	movl	%edx, %eax
	shrl	$3, %eax
	addl	$536870912, %eax
	movzbl	(%eax), %ebx
	testb	%bl, %bl
	setne	-60(%ebp)
	movl	%edx, %eax
	andl	$7, %eax
	addl	$3, %eax
	cmpb	%bl, %al
	setge	%al
	andb	-60(%ebp), %al
	testb	%al, %al
	je	.L634
	subl	$12, %esp
	pushl	%edx
	call	__asan_report_load4
.L634:
	movl	16(%ecx), %eax
	movl	%eax, %edx
	shrl	$31, %edx
	addl	%edx, %eax
	sarl	%eax
	leal	(%esi,%eax), %ecx
	movl	$1431655766, %edx
	movl	%ecx, %eax
	imull	%edx
	movl	%ecx, %eax
	sarl	$31, %eax
	subl	%eax, %edx
	movl	%edx, -60(%ebp)
	leal	12(%edi), %eax
	movl	%eax, %edx
	shrl	$3, %edx
	addl	$536870912, %edx
	movzbl	(%edx), %edx
	testb	%dl, %dl
	setne	%bl
	movl	%eax, %esi
	andl	$7, %esi
	addl	$3, %esi
	movl	%esi, %ecx
	cmpb	%dl, %cl
	setge	%dl
	andl	%ebx, %edx
	testb	%dl, %dl
	je	.L635
	subl	$12, %esp
	pushl	%eax
	call	__asan_report_store4
.L635:
	movl	-60(%ebp), %eax
	movl	%eax, 12(%edi)
	movl	throttles, %ecx
	movl	-44(%ebp), %edx
	movl	%edx, %eax
	addl	%eax, %eax
	addl	%edx, %eax
	sall	$3, %eax
	leal	(%ecx,%eax), %edx
	leal	16(%edx), %eax
	movl	%eax, %ecx
	shrl	$3, %ecx
	addl	$536870912, %ecx
	movzbl	(%ecx), %ecx
	testb	%cl, %cl
	setne	%bl
	movl	%ebx, %edi
	movl	%eax, %esi
	andl	$7, %esi
	addl	$3, %esi
	movl	%esi, %ebx
	cmpb	%cl, %bl
	setge	%cl
	andl	%edi, %ecx
	testb	%cl, %cl
	je	.L636
	subl	$12, %esp
	pushl	%eax
	call	__asan_report_store4
.L636:
	movl	$0, 16(%edx)
	movl	throttles, %ecx
	movl	-44(%ebp), %edx
	movl	%edx, %eax
	addl	%eax, %eax
	addl	%edx, %eax
	sall	$3, %eax
	leal	(%ecx,%eax), %edx
	leal	12(%edx), %eax
	movl	%eax, %ecx
	shrl	$3, %ecx
	addl	$536870912, %ecx
	movzbl	(%ecx), %ecx
	testb	%cl, %cl
	setne	%bl
	movl	%ebx, %edi
	movl	%eax, %esi
	andl	$7, %esi
	addl	$3, %esi
	movl	%esi, %ebx
	cmpb	%cl, %bl
	setge	%cl
	andl	%edi, %ecx
	testb	%cl, %cl
	je	.L637
	subl	$12, %esp
	pushl	%eax
	call	__asan_report_load4
.L637:
	movl	12(%edx), %eax
	movl	%eax, -60(%ebp)
	movl	throttles, %ecx
	movl	-44(%ebp), %edx
	movl	%edx, %eax
	addl	%eax, %eax
	addl	%edx, %eax
	sall	$3, %eax
	leal	(%ecx,%eax), %edx
	leal	4(%edx), %eax
	movl	%eax, %ecx
	shrl	$3, %ecx
	addl	$536870912, %ecx
	movzbl	(%ecx), %ecx
	testb	%cl, %cl
	setne	%bl
	movl	%ebx, %esi
	movl	%eax, %edi
	andl	$7, %edi
	addl	$3, %edi
	movl	%edi, %ebx
	cmpb	%cl, %bl
	setge	%cl
	andl	%esi, %ecx
	testb	%cl, %cl
	je	.L638
	subl	$12, %esp
	pushl	%eax
	call	__asan_report_load4
.L638:
	movl	4(%edx), %eax
	cmpl	%eax, -60(%ebp)
	jle	.L639
	movl	throttles, %ecx
	movl	-44(%ebp), %edx
	movl	%edx, %eax
	addl	%eax, %eax
	addl	%edx, %eax
	sall	$3, %eax
	leal	(%ecx,%eax), %edx
	leal	20(%edx), %eax
	movl	%eax, %ecx
	shrl	$3, %ecx
	addl	$536870912, %ecx
	movzbl	(%ecx), %ecx
	testb	%cl, %cl
	setne	%bl
	movl	%ebx, %edi
	movl	%eax, %esi
	andl	$7, %esi
	addl	$3, %esi
	movl	%esi, %ebx
	cmpb	%cl, %bl
	setge	%cl
	andl	%edi, %ecx
	testb	%cl, %cl
	je	.L640
	subl	$12, %esp
	pushl	%eax
	call	__asan_report_load4
.L640:
	movl	20(%edx), %eax
	testl	%eax, %eax
	je	.L639
	movl	throttles, %ecx
	movl	-44(%ebp), %edx
	movl	%edx, %eax
	addl	%eax, %eax
	addl	%edx, %eax
	sall	$3, %eax
	leal	(%ecx,%eax), %edx
	leal	12(%edx), %eax
	movl	%eax, %ecx
	shrl	$3, %ecx
	addl	$536870912, %ecx
	movzbl	(%ecx), %ecx
	testb	%cl, %cl
	setne	%bl
	movl	%ebx, %edi
	movl	%eax, %esi
	andl	$7, %esi
	addl	$3, %esi
	movl	%esi, %ebx
	cmpb	%cl, %bl
	setge	%cl
	andl	%edi, %ecx
	testb	%cl, %cl
	je	.L641
	subl	$12, %esp
	pushl	%eax
	call	__asan_report_load4
.L641:
	movl	12(%edx), %eax
	movl	%eax, -60(%ebp)
	movl	throttles, %ecx
	movl	-44(%ebp), %edx
	movl	%edx, %eax
	addl	%eax, %eax
	addl	%edx, %eax
	sall	$3, %eax
	leal	(%ecx,%eax), %edx
	leal	4(%edx), %eax
	movl	%eax, %ecx
	shrl	$3, %ecx
	addl	$536870912, %ecx
	movzbl	(%ecx), %ecx
	testb	%cl, %cl
	setne	%bl
	movl	%ebx, %esi
	movl	%eax, %edi
	andl	$7, %edi
	addl	$3, %edi
	movl	%edi, %ebx
	cmpb	%cl, %bl
	setge	%cl
	andl	%esi, %ecx
	testb	%cl, %cl
	je	.L642
	subl	$12, %esp
	pushl	%eax
	call	__asan_report_load4
.L642:
	movl	4(%edx), %eax
	addl	%eax, %eax
	cmpl	%eax, -60(%ebp)
	jle	.L643
	movl	throttles, %ecx
	movl	-44(%ebp), %edx
	movl	%edx, %eax
	addl	%eax, %eax
	addl	%edx, %eax
	sall	$3, %eax
	leal	(%ecx,%eax), %edx
	leal	20(%edx), %eax
	movl	%eax, %ecx
	shrl	$3, %ecx
	addl	$536870912, %ecx
	movzbl	(%ecx), %ecx
	testb	%cl, %cl
	setne	%bl
	movl	%ebx, %edi
	movl	%eax, %esi
	andl	$7, %esi
	addl	$3, %esi
	movl	%esi, %ebx
	cmpb	%cl, %bl
	setge	%cl
	andl	%edi, %ecx
	testb	%cl, %cl
	je	.L644
	subl	$12, %esp
	pushl	%eax
	call	__asan_report_load4
.L644:
	movl	20(%edx), %eax
	movl	%eax, -60(%ebp)
	movl	throttles, %ecx
	movl	-44(%ebp), %edx
	movl	%edx, %eax
	addl	%eax, %eax
	addl	%edx, %eax
	sall	$3, %eax
	leal	(%ecx,%eax), %edx
	leal	4(%edx), %eax
	movl	%eax, %ecx
	shrl	$3, %ecx
	addl	$536870912, %ecx
	movzbl	(%ecx), %ecx
	testb	%cl, %cl
	setne	%bl
	movl	%ebx, %edi
	movl	%eax, %esi
	andl	$7, %esi
	addl	$3, %esi
	movl	%esi, %ebx
	cmpb	%cl, %bl
	setge	%cl
	andl	%edi, %ecx
	testb	%cl, %cl
	je	.L645
	subl	$12, %esp
	pushl	%eax
	call	__asan_report_load4
.L645:
	movl	4(%edx), %eax
	movl	%eax, -64(%ebp)
	movl	throttles, %ecx
	movl	-44(%ebp), %edx
	movl	%edx, %eax
	addl	%eax, %eax
	addl	%edx, %eax
	sall	$3, %eax
	addl	%eax, %ecx
	leal	12(%ecx), %eax
	movl	%eax, %edx
	movl	%edx, %eax
	shrl	$3, %eax
	addl	$536870912, %eax
	movzbl	(%eax), %ebx
	testb	%bl, %bl
	setne	%al
	movl	%eax, %esi
	movl	%edx, %eax
	andl	$7, %eax
	addl	$3, %eax
	cmpb	%bl, %al
	setge	%al
	andl	%esi, %eax
	testb	%al, %al
	je	.L646
	subl	$12, %esp
	pushl	%edx
	call	__asan_report_load4
.L646:
	movl	12(%ecx), %esi
	movl	throttles, %ecx
	movl	-44(%ebp), %edx
	movl	%edx, %eax
	addl	%eax, %eax
	addl	%edx, %eax
	sall	$3, %eax
	leal	(%ecx,%eax), %ebx
	movl	%ebx, %eax
	movl	%eax, %edx
	movl	%edx, %eax
	shrl	$3, %eax
	addl	$536870912, %eax
	movzbl	(%eax), %ecx
	testb	%cl, %cl
	setne	%al
	movl	%eax, %edi
	movl	%edx, %eax
	andl	$7, %eax
	addl	$3, %eax
	cmpb	%cl, %al
	setge	%al
	andl	%edi, %eax
	testb	%al, %al
	je	.L647
	subl	$12, %esp
	pushl	%edx
	call	__asan_report_load4
.L647:
	movl	(%ebx), %eax
	subl	$4, %esp
	pushl	-60(%ebp)
	pushl	-64(%ebp)
	pushl	%esi
	pushl	%eax
	pushl	-44(%ebp)
	pushl	$.LC132
	pushl	$5
	call	syslog
	addl	$32, %esp
	jmp	.L639
.L643:
	movl	throttles, %ecx
	movl	-44(%ebp), %edx
	movl	%edx, %eax
	addl	%eax, %eax
	addl	%edx, %eax
	sall	$3, %eax
	leal	(%ecx,%eax), %edx
	leal	20(%edx), %eax
	movl	%eax, %ecx
	shrl	$3, %ecx
	addl	$536870912, %ecx
	movzbl	(%ecx), %ecx
	testb	%cl, %cl
	setne	%bl
	movl	%ebx, %edi
	movl	%eax, %esi
	andl	$7, %esi
	addl	$3, %esi
	movl	%esi, %ebx
	cmpb	%cl, %bl
	setge	%cl
	andl	%edi, %ecx
	testb	%cl, %cl
	je	.L648
	subl	$12, %esp
	pushl	%eax
	call	__asan_report_load4
.L648:
	movl	20(%edx), %eax
	movl	%eax, -60(%ebp)
	movl	throttles, %ecx
	movl	-44(%ebp), %edx
	movl	%edx, %eax
	addl	%eax, %eax
	addl	%edx, %eax
	sall	$3, %eax
	leal	(%ecx,%eax), %edx
	leal	4(%edx), %eax
	movl	%eax, %ecx
	shrl	$3, %ecx
	addl	$536870912, %ecx
	movzbl	(%ecx), %ecx
	testb	%cl, %cl
	setne	%bl
	movl	%ebx, %edi
	movl	%eax, %esi
	andl	$7, %esi
	addl	$3, %esi
	movl	%esi, %ebx
	cmpb	%cl, %bl
	setge	%cl
	andl	%edi, %ecx
	testb	%cl, %cl
	je	.L649
	subl	$12, %esp
	pushl	%eax
	call	__asan_report_load4
.L649:
	movl	4(%edx), %eax
	movl	%eax, -64(%ebp)
	movl	throttles, %ecx
	movl	-44(%ebp), %edx
	movl	%edx, %eax
	addl	%eax, %eax
	addl	%edx, %eax
	sall	$3, %eax
	addl	%eax, %ecx
	leal	12(%ecx), %eax
	movl	%eax, %edx
	movl	%edx, %eax
	shrl	$3, %eax
	addl	$536870912, %eax
	movzbl	(%eax), %ebx
	testb	%bl, %bl
	setne	%al
	movl	%eax, %esi
	movl	%edx, %eax
	andl	$7, %eax
	addl	$3, %eax
	cmpb	%bl, %al
	setge	%al
	andl	%esi, %eax
	testb	%al, %al
	je	.L650
	subl	$12, %esp
	pushl	%edx
	call	__asan_report_load4
.L650:
	movl	12(%ecx), %esi
	movl	throttles, %ecx
	movl	-44(%ebp), %edx
	movl	%edx, %eax
	addl	%eax, %eax
	addl	%edx, %eax
	sall	$3, %eax
	leal	(%ecx,%eax), %ebx
	movl	%ebx, %eax
	movl	%eax, %edx
	movl	%edx, %eax
	shrl	$3, %eax
	addl	$536870912, %eax
	movzbl	(%eax), %ecx
	testb	%cl, %cl
	setne	%al
	movl	%eax, %edi
	movl	%edx, %eax
	andl	$7, %eax
	addl	$3, %eax
	cmpb	%cl, %al
	setge	%al
	andl	%edi, %eax
	testb	%al, %al
	je	.L651
	subl	$12, %esp
	pushl	%edx
	call	__asan_report_load4
.L651:
	movl	(%ebx), %eax
	subl	$4, %esp
	pushl	-60(%ebp)
	pushl	-64(%ebp)
	pushl	%esi
	pushl	%eax
	pushl	-44(%ebp)
	pushl	$.LC133
	pushl	$6
	call	syslog
	addl	$32, %esp
.L639:
	movl	throttles, %ecx
	movl	-44(%ebp), %edx
	movl	%edx, %eax
	addl	%eax, %eax
	addl	%edx, %eax
	sall	$3, %eax
	leal	(%ecx,%eax), %edx
	leal	12(%edx), %eax
	movl	%eax, %ecx
	shrl	$3, %ecx
	addl	$536870912, %ecx
	movzbl	(%ecx), %ecx
	testb	%cl, %cl
	setne	%bl
	movl	%ebx, %edi
	movl	%eax, %esi
	andl	$7, %esi
	addl	$3, %esi
	movl	%esi, %ebx
	cmpb	%cl, %bl
	setge	%cl
	andl	%edi, %ecx
	testb	%cl, %cl
	je	.L652
	subl	$12, %esp
	pushl	%eax
	call	__asan_report_load4
.L652:
	movl	12(%edx), %eax
	movl	%eax, -60(%ebp)
	movl	throttles, %ecx
	movl	-44(%ebp), %edx
	movl	%edx, %eax
	addl	%eax, %eax
	addl	%edx, %eax
	sall	$3, %eax
	leal	(%ecx,%eax), %edx
	leal	8(%edx), %eax
	movl	%eax, %ecx
	shrl	$3, %ecx
	addl	$536870912, %ecx
	movzbl	(%ecx), %ecx
	testb	%cl, %cl
	setne	%bl
	movl	%ebx, %esi
	movl	%eax, %edi
	andl	$7, %edi
	addl	$3, %edi
	movl	%edi, %ebx
	cmpb	%cl, %bl
	setge	%cl
	andl	%esi, %ecx
	testb	%cl, %cl
	je	.L653
	subl	$12, %esp
	pushl	%eax
	call	__asan_report_load4
.L653:
	movl	8(%edx), %eax
	cmpl	%eax, -60(%ebp)
	jge	.L654
	movl	throttles, %ecx
	movl	-44(%ebp), %edx
	movl	%edx, %eax
	addl	%eax, %eax
	addl	%edx, %eax
	sall	$3, %eax
	leal	(%ecx,%eax), %edx
	leal	20(%edx), %eax
	movl	%eax, %ecx
	shrl	$3, %ecx
	addl	$536870912, %ecx
	movzbl	(%ecx), %ecx
	testb	%cl, %cl
	setne	%bl
	movl	%ebx, %edi
	movl	%eax, %esi
	andl	$7, %esi
	addl	$3, %esi
	movl	%esi, %ebx
	cmpb	%cl, %bl
	setge	%cl
	andl	%edi, %ecx
	testb	%cl, %cl
	je	.L655
	subl	$12, %esp
	pushl	%eax
	call	__asan_report_load4
.L655:
	movl	20(%edx), %eax
	testl	%eax, %eax
	je	.L654
	movl	throttles, %ecx
	movl	-44(%ebp), %edx
	movl	%edx, %eax
	addl	%eax, %eax
	addl	%edx, %eax
	sall	$3, %eax
	leal	(%ecx,%eax), %edx
	leal	20(%edx), %eax
	movl	%eax, %ecx
	shrl	$3, %ecx
	addl	$536870912, %ecx
	movzbl	(%ecx), %ecx
	testb	%cl, %cl
	setne	%bl
	movl	%ebx, %edi
	movl	%eax, %esi
	andl	$7, %esi
	addl	$3, %esi
	movl	%esi, %ebx
	cmpb	%cl, %bl
	setge	%cl
	andl	%edi, %ecx
	testb	%cl, %cl
	je	.L656
	subl	$12, %esp
	pushl	%eax
	call	__asan_report_load4
.L656:
	movl	20(%edx), %eax
	movl	%eax, -60(%ebp)
	movl	throttles, %ecx
	movl	-44(%ebp), %edx
	movl	%edx, %eax
	addl	%eax, %eax
	addl	%edx, %eax
	sall	$3, %eax
	leal	(%ecx,%eax), %edx
	leal	8(%edx), %eax
	movl	%eax, %ecx
	shrl	$3, %ecx
	addl	$536870912, %ecx
	movzbl	(%ecx), %ecx
	testb	%cl, %cl
	setne	%bl
	movl	%ebx, %edi
	movl	%eax, %esi
	andl	$7, %esi
	addl	$3, %esi
	movl	%esi, %ebx
	cmpb	%cl, %bl
	setge	%cl
	andl	%edi, %ecx
	testb	%cl, %cl
	je	.L657
	subl	$12, %esp
	pushl	%eax
	call	__asan_report_load4
.L657:
	movl	8(%edx), %eax
	movl	%eax, -64(%ebp)
	movl	throttles, %ecx
	movl	-44(%ebp), %edx
	movl	%edx, %eax
	addl	%eax, %eax
	addl	%edx, %eax
	sall	$3, %eax
	addl	%eax, %ecx
	leal	12(%ecx), %eax
	movl	%eax, %edx
	movl	%edx, %eax
	shrl	$3, %eax
	addl	$536870912, %eax
	movzbl	(%eax), %ebx
	testb	%bl, %bl
	setne	%al
	movl	%eax, %esi
	movl	%edx, %eax
	andl	$7, %eax
	addl	$3, %eax
	cmpb	%bl, %al
	setge	%al
	andl	%esi, %eax
	testb	%al, %al
	je	.L658
	subl	$12, %esp
	pushl	%edx
	call	__asan_report_load4
.L658:
	movl	12(%ecx), %esi
	movl	throttles, %ecx
	movl	-44(%ebp), %edx
	movl	%edx, %eax
	addl	%eax, %eax
	addl	%edx, %eax
	sall	$3, %eax
	leal	(%ecx,%eax), %ebx
	movl	%ebx, %eax
	movl	%eax, %edx
	movl	%edx, %eax
	shrl	$3, %eax
	addl	$536870912, %eax
	movzbl	(%eax), %ecx
	testb	%cl, %cl
	setne	%al
	movl	%eax, %edi
	movl	%edx, %eax
	andl	$7, %eax
	addl	$3, %eax
	cmpb	%cl, %al
	setge	%al
	andl	%edi, %eax
	testb	%al, %al
	je	.L659
	subl	$12, %esp
	pushl	%edx
	call	__asan_report_load4
.L659:
	movl	(%ebx), %eax
	subl	$4, %esp
	pushl	-60(%ebp)
	pushl	-64(%ebp)
	pushl	%esi
	pushl	%eax
	pushl	-44(%ebp)
	pushl	$.LC134
	pushl	$5
	call	syslog
	addl	$32, %esp
.L654:
	addl	$1, -44(%ebp)
.L632:
	movl	numthrottles, %eax
	cmpl	%eax, -44(%ebp)
	jl	.L660
	movl	$0, -36(%ebp)
	jmp	.L661
.L676:
	movl	connects, %ecx
	movl	-36(%ebp), %edx
	movl	%edx, %eax
	addl	%eax, %eax
	addl	%edx, %eax
	sall	$5, %eax
	addl	%ecx, %eax
	movl	%eax, -32(%ebp)
	movl	-32(%ebp), %eax
	movl	%eax, %edx
	shrl	$3, %edx
	addl	$536870912, %edx
	movzbl	(%edx), %edx
	testb	%dl, %dl
	setne	%cl
	movl	%eax, %ebx
	andl	$7, %ebx
	addl	$3, %ebx
	cmpb	%dl, %bl
	setge	%dl
	andl	%ecx, %edx
	testb	%dl, %dl
	je	.L662
	subl	$12, %esp
	pushl	%eax
	call	__asan_report_load4
.L662:
	movl	-32(%ebp), %eax
	movl	(%eax), %eax
	cmpl	$2, %eax
	je	.L663
	movl	-32(%ebp), %eax
	movl	(%eax), %eax
	cmpl	$3, %eax
	jne	.L664
.L663:
	movl	-32(%ebp), %eax
	addl	$56, %eax
	movl	%eax, %edx
	shrl	$3, %edx
	addl	$536870912, %edx
	movzbl	(%edx), %edx
	testb	%dl, %dl
	setne	%cl
	movl	%eax, %ebx
	andl	$7, %ebx
	addl	$3, %ebx
	cmpb	%dl, %bl
	setge	%dl
	andl	%ecx, %edx
	testb	%dl, %dl
	je	.L665
	subl	$12, %esp
	pushl	%eax
	call	__asan_report_store4
.L665:
	movl	-32(%ebp), %eax
	movl	$-1, 56(%eax)
	movl	$0, -40(%ebp)
	jmp	.L666
.L675:
	movl	-40(%ebp), %eax
	leal	0(,%eax,4), %edx
	movl	-32(%ebp), %eax
	addl	%edx, %eax
	addl	$12, %eax
	movl	%eax, %edx
	shrl	$3, %edx
	addl	$536870912, %edx
	movzbl	(%edx), %edx
	testb	%dl, %dl
	setne	%cl
	movl	%eax, %ebx
	andl	$7, %ebx
	addl	$3, %ebx
	cmpb	%dl, %bl
	setge	%dl
	andl	%ecx, %edx
	testb	%dl, %dl
	je	.L667
	subl	$12, %esp
	pushl	%eax
	call	__asan_report_load4
.L667:
	movl	-32(%ebp), %eax
	movl	-40(%ebp), %edx
	movl	12(%eax,%edx,4), %eax
	movl	%eax, -44(%ebp)
	movl	throttles, %ecx
	movl	-44(%ebp), %edx
	movl	%edx, %eax
	addl	%eax, %eax
	addl	%edx, %eax
	sall	$3, %eax
	leal	(%ecx,%eax), %edx
	leal	4(%edx), %eax
	movl	%eax, %ecx
	shrl	$3, %ecx
	addl	$536870912, %ecx
	movzbl	(%ecx), %ecx
	testb	%cl, %cl
	setne	%bl
	movl	%ebx, %edi
	movl	%eax, %esi
	andl	$7, %esi
	addl	$3, %esi
	movl	%esi, %ebx
	cmpb	%cl, %bl
	setge	%cl
	andl	%edi, %ecx
	testb	%cl, %cl
	je	.L668
	subl	$12, %esp
	pushl	%eax
	call	__asan_report_load4
.L668:
	movl	4(%edx), %eax
	movl	%eax, -60(%ebp)
	movl	throttles, %ecx
	movl	-44(%ebp), %edx
	movl	%edx, %eax
	addl	%eax, %eax
	addl	%edx, %eax
	sall	$3, %eax
	leal	(%ecx,%eax), %edx
	leal	20(%edx), %eax
	movl	%eax, %ecx
	shrl	$3, %ecx
	addl	$536870912, %ecx
	movzbl	(%ecx), %ecx
	testb	%cl, %cl
	setne	%bl
	movl	%ebx, %esi
	movl	%eax, %edi
	andl	$7, %edi
	addl	$3, %edi
	movl	%edi, %ebx
	cmpb	%cl, %bl
	setge	%cl
	andl	%esi, %ecx
	testb	%cl, %cl
	je	.L669
	subl	$12, %esp
	pushl	%eax
	call	__asan_report_load4
.L669:
	movl	20(%edx), %edi
	movl	-60(%ebp), %eax
	cltd
	idivl	%edi
	movl	%eax, -28(%ebp)
	movl	-32(%ebp), %eax
	addl	$56, %eax
	movl	%eax, %edx
	shrl	$3, %edx
	addl	$536870912, %edx
	movzbl	(%edx), %edx
	testb	%dl, %dl
	setne	%cl
	movl	%eax, %ebx
	andl	$7, %ebx
	addl	$3, %ebx
	cmpb	%dl, %bl
	setge	%dl
	andl	%ecx, %edx
	testb	%dl, %dl
	je	.L670
	subl	$12, %esp
	pushl	%eax
	call	__asan_report_load4
.L670:
	movl	-32(%ebp), %eax
	movl	56(%eax), %eax
	cmpl	$-1, %eax
	jne	.L671
	movl	-32(%ebp), %eax
	movl	-28(%ebp), %edx
	movl	%edx, 56(%eax)
	jmp	.L672
.L671:
	movl	-32(%ebp), %eax
	addl	$56, %eax
	movl	%eax, %edx
	shrl	$3, %edx
	addl	$536870912, %edx
	movzbl	(%edx), %edx
	testb	%dl, %dl
	setne	%cl
	movl	%eax, %ebx
	andl	$7, %ebx
	addl	$3, %ebx
	cmpb	%dl, %bl
	setge	%dl
	andl	%ecx, %edx
	testb	%dl, %dl
	je	.L673
	subl	$12, %esp
	pushl	%eax
	call	__asan_report_load4
.L673:
	movl	-32(%ebp), %eax
	movl	56(%eax), %edx
	movl	-28(%ebp), %eax
	cmpl	%eax, %edx
	cmovg	%eax, %edx
	movl	-32(%ebp), %eax
	movl	%edx, 56(%eax)
.L672:
	addl	$1, -40(%ebp)
.L666:
	movl	-32(%ebp), %eax
	addl	$52, %eax
	movl	%eax, %edx
	shrl	$3, %edx
	addl	$536870912, %edx
	movzbl	(%edx), %edx
	testb	%dl, %dl
	setne	%cl
	movl	%eax, %ebx
	andl	$7, %ebx
	addl	$3, %ebx
	cmpb	%dl, %bl
	setge	%dl
	andl	%ecx, %edx
	testb	%dl, %dl
	je	.L674
	subl	$12, %esp
	pushl	%eax
	call	__asan_report_load4
.L674:
	movl	-32(%ebp), %eax
	movl	52(%eax), %eax
	cmpl	-40(%ebp), %eax
	jg	.L675
.L664:
	addl	$1, -36(%ebp)
.L661:
	movl	max_connects, %eax
	cmpl	%eax, -36(%ebp)
	jl	.L676
	leal	-12(%ebp), %esp
	popl	%ebx
	popl	%esi
	popl	%edi
	popl	%ebp
	ret
	.size	update_throttles, .-update_throttles
	.type	finish_connection, @function
finish_connection:
.LASANPC24:
	pushl	%ebp
	movl	%esp, %ebp
	pushl	%ebx
	subl	$4, %esp
	movl	8(%ebp), %eax
	addl	$8, %eax
	movl	%eax, %edx
	shrl	$3, %edx
	addl	$536870912, %edx
	movzbl	(%edx), %edx
	testb	%dl, %dl
	setne	%cl
	movl	%eax, %ebx
	andl	$7, %ebx
	addl	$3, %ebx
	cmpb	%dl, %bl
	setge	%dl
	andl	%ecx, %edx
	testb	%dl, %dl
	je	.L678
	subl	$12, %esp
	pushl	%eax
	call	__asan_report_load4
.L678:
	movl	8(%ebp), %eax
	movl	8(%eax), %eax
	subl	$12, %esp
	pushl	%eax
	call	httpd_write_response
	addl	$16, %esp
	subl	$8, %esp
	pushl	12(%ebp)
	pushl	8(%ebp)
	call	clear_connection
	addl	$16, %esp
	movl	-4(%ebp), %ebx
	leave
	ret
	.size	finish_connection, .-finish_connection
	.section	.rodata
	.align 32
.LC135:
	.string	"replacing non-null linger_timer!"
	.zero	63
	.align 32
.LC136:
	.string	"tmr_create(linger_clear_connection) failed"
	.zero	53
	.text
	.type	clear_connection, @function
clear_connection:
.LASANPC25:
	pushl	%ebp
	movl	%esp, %ebp
	pushl	%edi
	pushl	%esi
	pushl	%ebx
	subl	$124, %esp
	leal	-120(%ebp), %eax
	movl	%eax, -124(%ebp)
	movl	%eax, -132(%ebp)
	cmpl	$0, __asan_option_detect_stack_use_after_return
	je	.L679
	subl	$8, %esp
	pushl	-124(%ebp)
	pushl	$96
	call	__asan_stack_malloc_1
	addl	$16, %esp
	movl	%eax, -124(%ebp)
.L679:
	movl	-124(%ebp), %edi
	movl	%edi, %eax
	addl	$96, %eax
	movl	%eax, -128(%ebp)
	movl	%edi, %eax
	movl	$1102416563, (%eax)
	movl	%edi, %eax
	movl	$.LC122, 4(%eax)
	movl	$.LASANPC25, 8(%eax)
	shrl	$3, %eax
	movl	%eax, %edi
	movl	$-235802127, 536870912(%edi)
	movl	$-185273340, 536870916(%edi)
	movl	$-202116109, 536870920(%edi)
	movl	8(%ebp), %eax
	addl	$72, %eax
	movl	%eax, %edx
	movl	%edx, %eax
	shrl	$3, %eax
	addl	$536870912, %eax
	movzbl	(%eax), %ecx
	testb	%cl, %cl
	setne	%bl
	movl	%edx, %eax
	andl	$7, %eax
	addl	$3, %eax
	cmpb	%cl, %al
	setge	%al
	andl	%ebx, %eax
	testb	%al, %al
	je	.L683
	subl	$12, %esp
	pushl	%edx
	call	__asan_report_load4
.L683:
	movl	8(%ebp), %eax
	movl	72(%eax), %eax
	testl	%eax, %eax
	je	.L684
	movl	8(%ebp), %eax
	movl	72(%eax), %eax
	subl	$12, %esp
	pushl	%eax
	call	tmr_cancel
	addl	$16, %esp
	movl	8(%ebp), %eax
	addl	$72, %eax
	movl	%eax, %edx
	movl	%edx, %eax
	shrl	$3, %eax
	addl	$536870912, %eax
	movzbl	(%eax), %ecx
	testb	%cl, %cl
	setne	%bl
	movl	%edx, %eax
	andl	$7, %eax
	addl	$3, %eax
	cmpb	%cl, %al
	setge	%al
	andl	%ebx, %eax
	testb	%al, %al
	je	.L685
	subl	$12, %esp
	pushl	%edx
	call	__asan_report_store4
.L685:
	movl	8(%ebp), %eax
	movl	$0, 72(%eax)
.L684:
	movl	8(%ebp), %eax
	movl	%eax, %edx
	movl	%edx, %eax
	shrl	$3, %eax
	addl	$536870912, %eax
	movzbl	(%eax), %ecx
	testb	%cl, %cl
	setne	%bl
	movl	%edx, %eax
	andl	$7, %eax
	addl	$3, %eax
	cmpb	%cl, %al
	setge	%al
	andl	%ebx, %eax
	testb	%al, %al
	je	.L686
	subl	$12, %esp
	pushl	%edx
	call	__asan_report_load4
.L686:
	movl	8(%ebp), %eax
	movl	(%eax), %eax
	cmpl	$4, %eax
	jne	.L687
	movl	8(%ebp), %eax
	addl	$76, %eax
	movl	%eax, %edx
	movl	%edx, %eax
	shrl	$3, %eax
	addl	$536870912, %eax
	movzbl	(%eax), %ecx
	testb	%cl, %cl
	setne	%bl
	movl	%edx, %eax
	andl	$7, %eax
	addl	$3, %eax
	cmpb	%cl, %al
	setge	%al
	andl	%ebx, %eax
	testb	%al, %al
	je	.L688
	subl	$12, %esp
	pushl	%edx
	call	__asan_report_load4
.L688:
	movl	8(%ebp), %eax
	movl	76(%eax), %eax
	subl	$12, %esp
	pushl	%eax
	call	tmr_cancel
	addl	$16, %esp
	movl	8(%ebp), %eax
	addl	$76, %eax
	movl	%eax, %edx
	movl	%edx, %eax
	shrl	$3, %eax
	addl	$536870912, %eax
	movzbl	(%eax), %ecx
	testb	%cl, %cl
	setne	%bl
	movl	%edx, %eax
	andl	$7, %eax
	addl	$3, %eax
	cmpb	%cl, %al
	setge	%al
	andl	%ebx, %eax
	testb	%al, %al
	je	.L689
	subl	$12, %esp
	pushl	%edx
	call	__asan_report_store4
.L689:
	movl	8(%ebp), %eax
	movl	$0, 76(%eax)
	movl	8(%ebp), %eax
	addl	$8, %eax
	movl	%eax, %edx
	movl	%edx, %eax
	shrl	$3, %eax
	addl	$536870912, %eax
	movzbl	(%eax), %ecx
	testb	%cl, %cl
	setne	%bl
	movl	%edx, %eax
	andl	$7, %eax
	addl	$3, %eax
	cmpb	%cl, %al
	setge	%al
	andl	%ebx, %eax
	testb	%al, %al
	je	.L690
	subl	$12, %esp
	pushl	%edx
	call	__asan_report_load4
.L690:
	movl	8(%ebp), %eax
	movl	8(%eax), %ebx
	leal	356(%ebx), %eax
	movl	%eax, %ecx
	movl	%ecx, %eax
	shrl	$3, %eax
	addl	$536870912, %eax
	movzbl	(%eax), %edx
	testb	%dl, %dl
	setne	%al
	movl	%eax, %esi
	movl	%ecx, %eax
	andl	$7, %eax
	addl	$3, %eax
	cmpb	%dl, %al
	setge	%al
	andl	%esi, %eax
	testb	%al, %al
	je	.L691
	subl	$12, %esp
	pushl	%ecx
	call	__asan_report_store4
.L691:
	movl	$0, 356(%ebx)
.L687:
	movl	8(%ebp), %eax
	addl	$8, %eax
	movl	%eax, %edx
	movl	%edx, %eax
	shrl	$3, %eax
	addl	$536870912, %eax
	movzbl	(%eax), %ecx
	testb	%cl, %cl
	setne	%bl
	movl	%edx, %eax
	andl	$7, %eax
	addl	$3, %eax
	cmpb	%cl, %al
	setge	%al
	andl	%ebx, %eax
	testb	%al, %al
	je	.L692
	subl	$12, %esp
	pushl	%edx
	call	__asan_report_load4
.L692:
	movl	8(%ebp), %eax
	movl	8(%eax), %ebx
	leal	356(%ebx), %eax
	movl	%eax, %ecx
	movl	%ecx, %eax
	shrl	$3, %eax
	addl	$536870912, %eax
	movzbl	(%eax), %edx
	testb	%dl, %dl
	setne	%al
	movl	%eax, %esi
	movl	%ecx, %eax
	andl	$7, %eax
	addl	$3, %eax
	cmpb	%dl, %al
	setge	%al
	andl	%esi, %eax
	testb	%al, %al
	je	.L693
	subl	$12, %esp
	pushl	%ecx
	call	__asan_report_load4
.L693:
	movl	356(%ebx), %eax
	testl	%eax, %eax
	je	.L694
	movl	8(%ebp), %eax
	movl	%eax, %edx
	movl	%edx, %eax
	shrl	$3, %eax
	addl	$536870912, %eax
	movzbl	(%eax), %ecx
	testb	%cl, %cl
	setne	%bl
	movl	%edx, %eax
	andl	$7, %eax
	addl	$3, %eax
	cmpb	%cl, %al
	setge	%al
	andl	%ebx, %eax
	testb	%al, %al
	je	.L695
	subl	$12, %esp
	pushl	%edx
	call	__asan_report_load4
.L695:
	movl	8(%ebp), %eax
	movl	(%eax), %eax
	cmpl	$3, %eax
	je	.L696
	movl	8(%ebp), %eax
	movl	8(%eax), %ebx
	leal	448(%ebx), %eax
	movl	%eax, %ecx
	movl	%ecx, %eax
	shrl	$3, %eax
	addl	$536870912, %eax
	movzbl	(%eax), %edx
	testb	%dl, %dl
	setne	%al
	movl	%eax, %esi
	movl	%ecx, %eax
	andl	$7, %eax
	addl	$3, %eax
	cmpb	%dl, %al
	setge	%al
	andl	%esi, %eax
	testb	%al, %al
	je	.L697
	subl	$12, %esp
	pushl	%ecx
	call	__asan_report_load4
.L697:
	movl	448(%ebx), %eax
	subl	$12, %esp
	pushl	%eax
	call	fdwatch_del_fd
	addl	$16, %esp
.L696:
	movl	8(%ebp), %eax
	movl	%eax, %edx
	movl	%edx, %eax
	shrl	$3, %eax
	addl	$536870912, %eax
	movzbl	(%eax), %ecx
	testb	%cl, %cl
	setne	%bl
	movl	%edx, %eax
	andl	$7, %eax
	addl	$3, %eax
	cmpb	%cl, %al
	setge	%al
	andl	%ebx, %eax
	testb	%al, %al
	je	.L698
	subl	$12, %esp
	pushl	%edx
	call	__asan_report_store4
.L698:
	movl	8(%ebp), %eax
	movl	$4, (%eax)
	movl	8(%ebp), %eax
	addl	$8, %eax
	movl	%eax, %edx
	movl	%edx, %eax
	shrl	$3, %eax
	addl	$536870912, %eax
	movzbl	(%eax), %ecx
	testb	%cl, %cl
	setne	%bl
	movl	%edx, %eax
	andl	$7, %eax
	addl	$3, %eax
	cmpb	%cl, %al
	setge	%al
	andl	%ebx, %eax
	testb	%al, %al
	je	.L699
	subl	$12, %esp
	pushl	%edx
	call	__asan_report_load4
.L699:
	movl	8(%ebp), %eax
	movl	8(%eax), %ebx
	leal	448(%ebx), %eax
	movl	%eax, %ecx
	movl	%ecx, %eax
	shrl	$3, %eax
	addl	$536870912, %eax
	movzbl	(%eax), %edx
	testb	%dl, %dl
	setne	%al
	movl	%eax, %esi
	movl	%ecx, %eax
	andl	$7, %eax
	addl	$3, %eax
	cmpb	%dl, %al
	setge	%al
	andl	%esi, %eax
	testb	%al, %al
	je	.L700
	subl	$12, %esp
	pushl	%ecx
	call	__asan_report_load4
.L700:
	movl	448(%ebx), %eax
	subl	$8, %esp
	pushl	$1
	pushl	%eax
	call	shutdown
	addl	$16, %esp
	movl	8(%ebp), %eax
	addl	$8, %eax
	movl	%eax, %edx
	movl	%edx, %eax
	shrl	$3, %eax
	addl	$536870912, %eax
	movzbl	(%eax), %ecx
	testb	%cl, %cl
	setne	%bl
	movl	%edx, %eax
	andl	$7, %eax
	addl	$3, %eax
	cmpb	%cl, %al
	setge	%al
	andl	%ebx, %eax
	testb	%al, %al
	je	.L701
	subl	$12, %esp
	pushl	%edx
	call	__asan_report_load4
.L701:
	movl	8(%ebp), %eax
	movl	8(%eax), %ebx
	leal	448(%ebx), %eax
	movl	%eax, %ecx
	movl	%ecx, %eax
	shrl	$3, %eax
	addl	$536870912, %eax
	movzbl	(%eax), %edx
	testb	%dl, %dl
	setne	%al
	movl	%eax, %esi
	movl	%ecx, %eax
	andl	$7, %eax
	addl	$3, %eax
	cmpb	%dl, %al
	setge	%al
	andl	%esi, %eax
	testb	%al, %al
	je	.L702
	subl	$12, %esp
	pushl	%ecx
	call	__asan_report_load4
.L702:
	movl	448(%ebx), %eax
	subl	$4, %esp
	pushl	$0
	pushl	8(%ebp)
	pushl	%eax
	call	fdwatch_add_fd
	addl	$16, %esp
	movl	8(%ebp), %eax
	movl	-128(%ebp), %esi
	movl	%eax, -64(%esi)
	movl	8(%ebp), %eax
	addl	$76, %eax
	movl	%eax, %edx
	movl	%edx, %eax
	shrl	$3, %eax
	addl	$536870912, %eax
	movzbl	(%eax), %ecx
	testb	%cl, %cl
	setne	%bl
	movl	%edx, %eax
	andl	$7, %eax
	addl	$3, %eax
	cmpb	%cl, %al
	setge	%al
	andl	%ebx, %eax
	testb	%al, %al
	je	.L703
	subl	$12, %esp
	pushl	%edx
	call	__asan_report_load4
.L703:
	movl	8(%ebp), %eax
	movl	76(%eax), %eax
	testl	%eax, %eax
	je	.L704
	subl	$8, %esp
	pushl	$.LC135
	pushl	$3
	call	syslog
	addl	$16, %esp
.L704:
	subl	$12, %esp
	pushl	$0
	pushl	$500
	movl	-128(%ebp), %eax
	pushl	-64(%eax)
	pushl	$linger_clear_connection
	pushl	12(%ebp)
	call	tmr_create
	addl	$32, %esp
	movl	%eax, %ebx
	movl	8(%ebp), %eax
	addl	$76, %eax
	movl	%eax, %edx
	movl	%edx, %eax
	shrl	$3, %eax
	addl	$536870912, %eax
	movzbl	(%eax), %ecx
	testb	%cl, %cl
	setne	%al
	movl	%eax, %esi
	movl	%edx, %eax
	andl	$7, %eax
	addl	$3, %eax
	cmpb	%cl, %al
	setge	%al
	andl	%esi, %eax
	testb	%al, %al
	je	.L705
	subl	$12, %esp
	pushl	%edx
	call	__asan_report_store4
.L705:
	movl	8(%ebp), %eax
	movl	%ebx, 76(%eax)
	movl	8(%ebp), %eax
	movl	76(%eax), %eax
	testl	%eax, %eax
	jne	.L682
	subl	$8, %esp
	pushl	$.LC136
	pushl	$2
	call	syslog
	addl	$16, %esp
	call	__asan_handle_no_return
	subl	$12, %esp
	pushl	$1
	call	exit
.L694:
	subl	$8, %esp
	pushl	12(%ebp)
	pushl	8(%ebp)
	call	really_clear_connection
	addl	$16, %esp
.L682:
	movl	-124(%ebp), %esi
	cmpl	%esi, -132(%ebp)
	je	.L680
	movl	-124(%ebp), %eax
	movl	$1172321806, (%eax)
	movl	$-168430091, 536870912(%edi)
	movl	$-168430091, 536870916(%edi)
	movl	$-168430091, 536870920(%edi)
	jmp	.L681
.L680:
	movl	$0, 536870912(%edi)
	movl	$0, 536870916(%edi)
	movl	$0, 536870920(%edi)
.L681:
	leal	-12(%ebp), %esp
	popl	%ebx
	popl	%esi
	popl	%edi
	popl	%ebp
	ret
	.size	clear_connection, .-clear_connection
	.type	really_clear_connection, @function
really_clear_connection:
.LASANPC26:
	pushl	%ebp
	movl	%esp, %ebp
	pushl	%edi
	pushl	%esi
	pushl	%ebx
	subl	$12, %esp
	movl	8(%ebp), %eax
	addl	$8, %eax
	movl	%eax, %edx
	shrl	$3, %edx
	addl	$536870912, %edx
	movzbl	(%edx), %edx
	testb	%dl, %dl
	setne	%cl
	movl	%eax, %ebx
	andl	$7, %ebx
	addl	$3, %ebx
	cmpb	%dl, %bl
	setge	%dl
	andl	%ecx, %edx
	testb	%dl, %dl
	je	.L708
	subl	$12, %esp
	pushl	%eax
	call	__asan_report_load4
.L708:
	movl	8(%ebp), %eax
	movl	8(%eax), %edx
	leal	168(%edx), %eax
	movl	%eax, %ecx
	shrl	$3, %ecx
	addl	$536870912, %ecx
	movzbl	(%ecx), %ecx
	testb	%cl, %cl
	setne	%bl
	movl	%ebx, %edi
	movl	%eax, %esi
	andl	$7, %esi
	addl	$3, %esi
	movl	%esi, %ebx
	cmpb	%cl, %bl
	setge	%cl
	andl	%edi, %ecx
	testb	%cl, %cl
	je	.L709
	subl	$12, %esp
	pushl	%eax
	call	__asan_report_load4
.L709:
	movl	168(%edx), %edx
	movl	stats_bytes, %eax
	addl	%edx, %eax
	movl	%eax, stats_bytes
	movl	8(%ebp), %eax
	movl	%eax, %edx
	shrl	$3, %edx
	addl	$536870912, %edx
	movzbl	(%edx), %edx
	testb	%dl, %dl
	setne	%cl
	movl	%eax, %ebx
	andl	$7, %ebx
	addl	$3, %ebx
	cmpb	%dl, %bl
	setge	%dl
	andl	%ecx, %edx
	testb	%dl, %dl
	je	.L710
	subl	$12, %esp
	pushl	%eax
	call	__asan_report_load4
.L710:
	movl	8(%ebp), %eax
	movl	(%eax), %eax
	cmpl	$3, %eax
	je	.L711
	movl	8(%ebp), %eax
	movl	8(%eax), %edx
	leal	448(%edx), %eax
	movl	%eax, %ecx
	shrl	$3, %ecx
	addl	$536870912, %ecx
	movzbl	(%ecx), %ecx
	testb	%cl, %cl
	setne	%bl
	movl	%ebx, %edi
	movl	%eax, %esi
	andl	$7, %esi
	addl	$3, %esi
	movl	%esi, %ebx
	cmpb	%cl, %bl
	setge	%cl
	andl	%edi, %ecx
	testb	%cl, %cl
	je	.L712
	subl	$12, %esp
	pushl	%eax
	call	__asan_report_load4
.L712:
	movl	448(%edx), %eax
	subl	$12, %esp
	pushl	%eax
	call	fdwatch_del_fd
	addl	$16, %esp
.L711:
	movl	8(%ebp), %eax
	addl	$8, %eax
	movl	%eax, %edx
	shrl	$3, %edx
	addl	$536870912, %edx
	movzbl	(%edx), %edx
	testb	%dl, %dl
	setne	%cl
	movl	%eax, %ebx
	andl	$7, %ebx
	addl	$3, %ebx
	cmpb	%dl, %bl
	setge	%dl
	andl	%ecx, %edx
	testb	%dl, %dl
	je	.L713
	subl	$12, %esp
	pushl	%eax
	call	__asan_report_load4
.L713:
	movl	8(%ebp), %eax
	movl	8(%eax), %eax
	subl	$8, %esp
	pushl	12(%ebp)
	pushl	%eax
	call	httpd_close_conn
	addl	$16, %esp
	subl	$8, %esp
	pushl	12(%ebp)
	pushl	8(%ebp)
	call	clear_throttles
	addl	$16, %esp
	movl	8(%ebp), %eax
	addl	$76, %eax
	movl	%eax, %edx
	shrl	$3, %edx
	addl	$536870912, %edx
	movzbl	(%edx), %edx
	testb	%dl, %dl
	setne	%cl
	movl	%eax, %ebx
	andl	$7, %ebx
	addl	$3, %ebx
	cmpb	%dl, %bl
	setge	%dl
	andl	%ecx, %edx
	testb	%dl, %dl
	je	.L714
	subl	$12, %esp
	pushl	%eax
	call	__asan_report_load4
.L714:
	movl	8(%ebp), %eax
	movl	76(%eax), %eax
	testl	%eax, %eax
	je	.L715
	movl	8(%ebp), %eax
	movl	76(%eax), %eax
	subl	$12, %esp
	pushl	%eax
	call	tmr_cancel
	addl	$16, %esp
	movl	8(%ebp), %eax
	addl	$76, %eax
	movl	%eax, %edx
	shrl	$3, %edx
	addl	$536870912, %edx
	movzbl	(%edx), %edx
	testb	%dl, %dl
	setne	%cl
	movl	%eax, %ebx
	andl	$7, %ebx
	addl	$3, %ebx
	cmpb	%dl, %bl
	setge	%dl
	andl	%ecx, %edx
	testb	%dl, %dl
	je	.L716
	subl	$12, %esp
	pushl	%eax
	call	__asan_report_store4
.L716:
	movl	8(%ebp), %eax
	movl	$0, 76(%eax)
.L715:
	movl	8(%ebp), %eax
	movl	%eax, %edx
	shrl	$3, %edx
	addl	$536870912, %edx
	movzbl	(%edx), %edx
	testb	%dl, %dl
	setne	%cl
	movl	%eax, %ebx
	andl	$7, %ebx
	addl	$3, %ebx
	cmpb	%dl, %bl
	setge	%dl
	andl	%ecx, %edx
	testb	%dl, %dl
	je	.L717
	subl	$12, %esp
	pushl	%eax
	call	__asan_report_store4
.L717:
	movl	8(%ebp), %eax
	movl	$0, (%eax)
	movl	first_free_connect, %edi
	movl	8(%ebp), %eax
	addl	$4, %eax
	movl	%eax, %edx
	shrl	$3, %edx
	addl	$536870912, %edx
	movzbl	(%edx), %edx
	testb	%dl, %dl
	setne	%bl
	movl	%eax, %esi
	andl	$7, %esi
	addl	$3, %esi
	movl	%esi, %ecx
	cmpb	%dl, %cl
	setge	%dl
	andl	%ebx, %edx
	testb	%dl, %dl
	je	.L718
	subl	$12, %esp
	pushl	%eax
	call	__asan_report_store4
.L718:
	movl	8(%ebp), %eax
	movl	%edi, 4(%eax)
	movl	8(%ebp), %eax
	movl	connects, %edx
	subl	%edx, %eax
	sarl	$5, %eax
	imull	$-1431655765, %eax, %eax
	movl	%eax, first_free_connect
	movl	num_connects, %eax
	subl	$1, %eax
	movl	%eax, num_connects
	leal	-12(%ebp), %esp
	popl	%ebx
	popl	%esi
	popl	%edi
	popl	%ebp
	ret
	.size	really_clear_connection, .-really_clear_connection
	.section	.rodata
	.align 32
.LC137:
	.string	"%.80s connection timed out reading"
	.zero	61
	.align 32
.LC138:
	.string	"%.80s connection timed out sending"
	.zero	61
	.text
	.type	idle, @function
idle:
.LASANPC27:
	pushl	%ebp
	movl	%esp, %ebp
	pushl	%edi
	pushl	%esi
	pushl	%ebx
	subl	$44, %esp
	movl	$0, -32(%ebp)
	jmp	.L720
.L736:
	movl	connects, %ecx
	movl	-32(%ebp), %edx
	movl	%edx, %eax
	addl	%eax, %eax
	addl	%edx, %eax
	sall	$5, %eax
	addl	%ecx, %eax
	movl	%eax, -28(%ebp)
	movl	-28(%ebp), %eax
	movl	%eax, %edx
	shrl	$3, %edx
	addl	$536870912, %edx
	movzbl	(%edx), %edx
	testb	%dl, %dl
	setne	%cl
	movl	%eax, %ebx
	andl	$7, %ebx
	addl	$3, %ebx
	cmpb	%dl, %bl
	setge	%dl
	andl	%ecx, %edx
	testb	%dl, %dl
	je	.L721
	subl	$12, %esp
	pushl	%eax
	call	__asan_report_load4
.L721:
	movl	-28(%ebp), %eax
	movl	(%eax), %eax
	cmpl	$1, %eax
	je	.L723
	cmpl	$1, %eax
	jl	.L722
	cmpl	$3, %eax
	jg	.L722
	jmp	.L737
.L723:
	movl	12(%ebp), %eax
	movl	%eax, %edx
	shrl	$3, %edx
	addl	$536870912, %edx
	movzbl	(%edx), %edx
	testb	%dl, %dl
	setne	%cl
	movl	%eax, %ebx
	andl	$7, %ebx
	addl	$3, %ebx
	cmpb	%dl, %bl
	setge	%dl
	andl	%ecx, %edx
	testb	%dl, %dl
	je	.L725
	subl	$12, %esp
	pushl	%eax
	call	__asan_report_load4
.L725:
	movl	12(%ebp), %eax
	movl	(%eax), %edi
	movl	-28(%ebp), %eax
	addl	$68, %eax
	movl	%eax, %edx
	shrl	$3, %edx
	addl	$536870912, %edx
	movzbl	(%edx), %edx
	testb	%dl, %dl
	setne	%bl
	movl	%eax, %esi
	andl	$7, %esi
	addl	$3, %esi
	movl	%esi, %ecx
	cmpb	%dl, %cl
	setge	%dl
	andl	%ebx, %edx
	testb	%dl, %dl
	je	.L726
	subl	$12, %esp
	pushl	%eax
	call	__asan_report_load4
.L726:
	movl	-28(%ebp), %eax
	movl	68(%eax), %eax
	movl	%edi, %ecx
	subl	%eax, %ecx
	movl	%ecx, %eax
	cmpl	$59, %eax
	jle	.L727
	movl	-28(%ebp), %eax
	addl	$8, %eax
	movl	%eax, %edx
	shrl	$3, %edx
	addl	$536870912, %edx
	movzbl	(%edx), %edx
	testb	%dl, %dl
	setne	%cl
	movl	%eax, %ebx
	andl	$7, %ebx
	addl	$3, %ebx
	cmpb	%dl, %bl
	setge	%dl
	andl	%ecx, %edx
	testb	%dl, %dl
	je	.L728
	subl	$12, %esp
	pushl	%eax
	call	__asan_report_load4
.L728:
	movl	-28(%ebp), %eax
	movl	8(%eax), %eax
	addl	$8, %eax
	subl	$12, %esp
	pushl	%eax
	call	httpd_ntoa
	addl	$16, %esp
	subl	$4, %esp
	pushl	%eax
	pushl	$.LC137
	pushl	$6
	call	syslog
	addl	$16, %esp
	movl	$httpd_err408form, %eax
	movl	%eax, %edx
	shrl	$3, %edx
	addl	$536870912, %edx
	movzbl	(%edx), %edx
	testb	%dl, %dl
	setne	%cl
	movl	%eax, %ebx
	andl	$7, %ebx
	addl	$3, %ebx
	cmpb	%dl, %bl
	setge	%dl
	andl	%ecx, %edx
	testb	%dl, %dl
	je	.L729
	subl	$12, %esp
	pushl	%eax
	call	__asan_report_load4
.L729:
	movl	httpd_err408form, %eax
	movl	%eax, -44(%ebp)
	movl	$httpd_err408title, %eax
	movl	%eax, %edx
	shrl	$3, %edx
	addl	$536870912, %edx
	movzbl	(%edx), %edx
	testb	%dl, %dl
	setne	%cl
	movl	%eax, %esi
	andl	$7, %esi
	addl	$3, %esi
	movl	%esi, %ebx
	cmpb	%dl, %bl
	setge	%dl
	andl	%ecx, %edx
	testb	%dl, %dl
	je	.L730
	subl	$12, %esp
	pushl	%eax
	call	__asan_report_load4
.L730:
	movl	httpd_err408title, %ecx
	movl	-28(%ebp), %eax
	addl	$8, %eax
	movl	%eax, %edx
	shrl	$3, %edx
	addl	$536870912, %edx
	movzbl	(%edx), %edx
	testb	%dl, %dl
	setne	%bl
	movl	%ebx, %esi
	movl	%eax, %edi
	andl	$7, %edi
	addl	$3, %edi
	movl	%edi, %ebx
	cmpb	%dl, %bl
	setge	%dl
	andl	%esi, %edx
	testb	%dl, %dl
	je	.L731
	subl	$12, %esp
	pushl	%eax
	call	__asan_report_load4
.L731:
	movl	-28(%ebp), %eax
	movl	8(%eax), %eax
	subl	$8, %esp
	pushl	$.LC48
	pushl	-44(%ebp)
	pushl	$.LC48
	pushl	%ecx
	pushl	$408
	pushl	%eax
	call	httpd_send_err
	addl	$32, %esp
	subl	$8, %esp
	pushl	12(%ebp)
	pushl	-28(%ebp)
	call	finish_connection
	addl	$16, %esp
	jmp	.L722
.L727:
	jmp	.L722
.L737:
	movl	12(%ebp), %eax
	movl	%eax, %edx
	shrl	$3, %edx
	addl	$536870912, %edx
	movzbl	(%edx), %edx
	testb	%dl, %dl
	setne	%cl
	movl	%eax, %ebx
	andl	$7, %ebx
	addl	$3, %ebx
	cmpb	%dl, %bl
	setge	%dl
	andl	%ecx, %edx
	testb	%dl, %dl
	je	.L732
	subl	$12, %esp
	pushl	%eax
	call	__asan_report_load4
.L732:
	movl	12(%ebp), %eax
	movl	(%eax), %edi
	movl	-28(%ebp), %eax
	addl	$68, %eax
	movl	%eax, %edx
	shrl	$3, %edx
	addl	$536870912, %edx
	movzbl	(%edx), %edx
	testb	%dl, %dl
	setne	%bl
	movl	%eax, %esi
	andl	$7, %esi
	addl	$3, %esi
	movl	%esi, %ecx
	cmpb	%dl, %cl
	setge	%dl
	andl	%ebx, %edx
	testb	%dl, %dl
	je	.L733
	subl	$12, %esp
	pushl	%eax
	call	__asan_report_load4
.L733:
	movl	-28(%ebp), %eax
	movl	68(%eax), %eax
	movl	%edi, %ecx
	subl	%eax, %ecx
	movl	%ecx, %eax
	cmpl	$299, %eax
	jle	.L734
	movl	-28(%ebp), %eax
	addl	$8, %eax
	movl	%eax, %edx
	shrl	$3, %edx
	addl	$536870912, %edx
	movzbl	(%edx), %edx
	testb	%dl, %dl
	setne	%cl
	movl	%eax, %ebx
	andl	$7, %ebx
	addl	$3, %ebx
	cmpb	%dl, %bl
	setge	%dl
	andl	%ecx, %edx
	testb	%dl, %dl
	je	.L735
	subl	$12, %esp
	pushl	%eax
	call	__asan_report_load4
.L735:
	movl	-28(%ebp), %eax
	movl	8(%eax), %eax
	addl	$8, %eax
	subl	$12, %esp
	pushl	%eax
	call	httpd_ntoa
	addl	$16, %esp
	subl	$4, %esp
	pushl	%eax
	pushl	$.LC138
	pushl	$6
	call	syslog
	addl	$16, %esp
	subl	$8, %esp
	pushl	12(%ebp)
	pushl	-28(%ebp)
	call	clear_connection
	addl	$16, %esp
	jmp	.L738
.L734:
.L738:
	nop
.L722:
	addl	$1, -32(%ebp)
.L720:
	movl	max_connects, %eax
	cmpl	%eax, -32(%ebp)
	jl	.L736
	leal	-12(%ebp), %esp
	popl	%ebx
	popl	%esi
	popl	%edi
	popl	%ebp
	ret
	.size	idle, .-idle
	.type	wakeup_connection, @function
wakeup_connection:
.LASANPC28:
	pushl	%ebp
	movl	%esp, %ebp
	pushl	%edi
	pushl	%esi
	pushl	%ebx
	subl	$28, %esp
	leal	8(%ebp), %eax
	movl	%eax, %edx
	shrl	$3, %edx
	addl	$536870912, %edx
	movzbl	(%edx), %edx
	testb	%dl, %dl
	setne	%cl
	movl	%eax, %ebx
	andl	$7, %ebx
	addl	$3, %ebx
	cmpb	%dl, %bl
	setge	%dl
	andl	%ecx, %edx
	testb	%dl, %dl
	je	.L740
	subl	$12, %esp
	pushl	%eax
	call	__asan_report_load4
.L740:
	movl	8(%ebp), %eax
	movl	%eax, -28(%ebp)
	movl	-28(%ebp), %eax
	addl	$72, %eax
	movl	%eax, %edx
	shrl	$3, %edx
	addl	$536870912, %edx
	movzbl	(%edx), %edx
	testb	%dl, %dl
	setne	%cl
	movl	%eax, %ebx
	andl	$7, %ebx
	addl	$3, %ebx
	cmpb	%dl, %bl
	setge	%dl
	andl	%ecx, %edx
	testb	%dl, %dl
	je	.L741
	subl	$12, %esp
	pushl	%eax
	call	__asan_report_store4
.L741:
	movl	-28(%ebp), %eax
	movl	$0, 72(%eax)
	movl	-28(%ebp), %eax
	movl	%eax, %edx
	shrl	$3, %edx
	addl	$536870912, %edx
	movzbl	(%edx), %edx
	testb	%dl, %dl
	setne	%cl
	movl	%eax, %ebx
	andl	$7, %ebx
	addl	$3, %ebx
	cmpb	%dl, %bl
	setge	%dl
	andl	%ecx, %edx
	testb	%dl, %dl
	je	.L742
	subl	$12, %esp
	pushl	%eax
	call	__asan_report_load4
.L742:
	movl	-28(%ebp), %eax
	movl	(%eax), %eax
	cmpl	$3, %eax
	jne	.L739
	movl	-28(%ebp), %eax
	movl	$2, (%eax)
	movl	-28(%ebp), %eax
	addl	$8, %eax
	movl	%eax, %edx
	shrl	$3, %edx
	addl	$536870912, %edx
	movzbl	(%edx), %edx
	testb	%dl, %dl
	setne	%cl
	movl	%eax, %ebx
	andl	$7, %ebx
	addl	$3, %ebx
	cmpb	%dl, %bl
	setge	%dl
	andl	%ecx, %edx
	testb	%dl, %dl
	je	.L744
	subl	$12, %esp
	pushl	%eax
	call	__asan_report_load4
.L744:
	movl	-28(%ebp), %eax
	movl	8(%eax), %edx
	leal	448(%edx), %eax
	movl	%eax, %ecx
	shrl	$3, %ecx
	addl	$536870912, %ecx
	movzbl	(%ecx), %ecx
	testb	%cl, %cl
	setne	%bl
	movl	%ebx, %edi
	movl	%eax, %esi
	andl	$7, %esi
	addl	$3, %esi
	movl	%esi, %ebx
	cmpb	%cl, %bl
	setge	%cl
	andl	%edi, %ecx
	testb	%cl, %cl
	je	.L745
	subl	$12, %esp
	pushl	%eax
	call	__asan_report_load4
.L745:
	movl	448(%edx), %eax
	subl	$4, %esp
	pushl	$1
	pushl	-28(%ebp)
	pushl	%eax
	call	fdwatch_add_fd
	addl	$16, %esp
.L739:
	leal	-12(%ebp), %esp
	popl	%ebx
	popl	%esi
	popl	%edi
	popl	%ebp
	ret
	.size	wakeup_connection, .-wakeup_connection
	.type	linger_clear_connection, @function
linger_clear_connection:
.LASANPC29:
	pushl	%ebp
	movl	%esp, %ebp
	pushl	%ebx
	subl	$20, %esp
	leal	8(%ebp), %eax
	movl	%eax, %edx
	shrl	$3, %edx
	addl	$536870912, %edx
	movzbl	(%edx), %edx
	testb	%dl, %dl
	setne	%cl
	movl	%eax, %ebx
	andl	$7, %ebx
	addl	$3, %ebx
	cmpb	%dl, %bl
	setge	%dl
	andl	%ecx, %edx
	testb	%dl, %dl
	je	.L747
	subl	$12, %esp
	pushl	%eax
	call	__asan_report_load4
.L747:
	movl	8(%ebp), %eax
	movl	%eax, -12(%ebp)
	movl	-12(%ebp), %eax
	addl	$76, %eax
	movl	%eax, %edx
	shrl	$3, %edx
	addl	$536870912, %edx
	movzbl	(%edx), %edx
	testb	%dl, %dl
	setne	%cl
	movl	%eax, %ebx
	andl	$7, %ebx
	addl	$3, %ebx
	cmpb	%dl, %bl
	setge	%dl
	andl	%ecx, %edx
	testb	%dl, %dl
	je	.L748
	subl	$12, %esp
	pushl	%eax
	call	__asan_report_store4
.L748:
	movl	-12(%ebp), %eax
	movl	$0, 76(%eax)
	subl	$8, %esp
	pushl	12(%ebp)
	pushl	-12(%ebp)
	call	really_clear_connection
	addl	$16, %esp
	movl	-4(%ebp), %ebx
	leave
	ret
	.size	linger_clear_connection, .-linger_clear_connection
	.type	occasional, @function
occasional:
.LASANPC30:
	pushl	%ebp
	movl	%esp, %ebp
	subl	$8, %esp
	subl	$12, %esp
	pushl	12(%ebp)
	call	mmc_cleanup
	addl	$16, %esp
	call	tmr_cleanup
	movl	$1, watchdog_flag
	leave
	ret
	.size	occasional, .-occasional
	.type	show_stats, @function
show_stats:
.LASANPC31:
	pushl	%ebp
	movl	%esp, %ebp
	subl	$8, %esp
	subl	$12, %esp
	pushl	12(%ebp)
	call	logstats
	addl	$16, %esp
	leave
	ret
	.size	show_stats, .-show_stats
	.section	.rodata
	.align 32
.LC139:
	.string	"up %ld seconds, stats for %ld seconds:"
	.zero	57
	.text
	.type	logstats, @function
logstats:
.LASANPC32:
	pushl	%ebp
	movl	%esp, %ebp
	pushl	%edi
	pushl	%esi
	pushl	%ebx
	subl	$140, %esp
	leal	-120(%ebp), %esi
	movl	%esi, -140(%ebp)
	cmpl	$0, __asan_option_detect_stack_use_after_return
	je	.L751
	subl	$8, %esp
	pushl	%esi
	pushl	$96
	call	__asan_stack_malloc_1
	addl	$16, %esp
	movl	%eax, %esi
.L751:
	leal	96(%esi), %eax
	movl	%eax, %edi
	movl	$1102416563, (%esi)
	movl	$.LC121, 4(%esi)
	movl	$.LASANPC32, 8(%esi)
	movl	%esi, %ebx
	shrl	$3, %ebx
	movl	$-235802127, 536870912(%ebx)
	movl	$-185273344, 536870916(%ebx)
	movl	$-202116109, 536870920(%ebx)
	cmpl	$0, 8(%ebp)
	jne	.L755
	subl	$8, %esp
	pushl	$0
	leal	-64(%edi), %eax
	pushl	%eax
	call	gettimeofday
	addl	$16, %esp
	leal	-64(%edi), %eax
	movl	%eax, 8(%ebp)
.L755:
	movl	8(%ebp), %eax
	movl	%eax, %edx
	movl	%edx, %eax
	shrl	$3, %eax
	addl	$536870912, %eax
	movzbl	(%eax), %ecx
	testb	%cl, %cl
	setne	%al
	movl	%eax, %edi
	movl	%edx, %eax
	andl	$7, %eax
	addl	$3, %eax
	cmpb	%cl, %al
	setge	%al
	andl	%edi, %eax
	testb	%al, %al
	je	.L756
	subl	$12, %esp
	pushl	%edx
	call	__asan_report_load4
.L756:
	movl	8(%ebp), %eax
	movl	(%eax), %eax
	movl	%eax, -128(%ebp)
	movl	start_time, %eax
	movl	-128(%ebp), %edx
	subl	%eax, %edx
	movl	%edx, %eax
	movl	%eax, -124(%ebp)
	movl	stats_time, %eax
	movl	-128(%ebp), %edx
	subl	%eax, %edx
	movl	%edx, %eax
	movl	%eax, -132(%ebp)
	cmpl	$0, -132(%ebp)
	jne	.L757
	movl	$1, -132(%ebp)
.L757:
	movl	-128(%ebp), %eax
	movl	%eax, stats_time
	pushl	-132(%ebp)
	pushl	-124(%ebp)
	pushl	$.LC139
	pushl	$6
	call	syslog
	addl	$16, %esp
	subl	$12, %esp
	pushl	-132(%ebp)
	call	thttpd_logstats
	addl	$16, %esp
	subl	$12, %esp
	pushl	-132(%ebp)
	call	httpd_logstats
	addl	$16, %esp
	subl	$12, %esp
	pushl	-132(%ebp)
	call	mmc_logstats
	addl	$16, %esp
	subl	$12, %esp
	pushl	-132(%ebp)
	call	fdwatch_logstats
	addl	$16, %esp
	subl	$12, %esp
	pushl	-132(%ebp)
	call	tmr_logstats
	addl	$16, %esp
	cmpl	%esi, -140(%ebp)
	je	.L752
	movl	$1172321806, (%esi)
	movl	$-168430091, 536870912(%ebx)
	movl	$-168430091, 536870916(%ebx)
	movl	$-168430091, 536870920(%ebx)
	jmp	.L753
.L752:
	movl	$0, 536870912(%ebx)
	movl	$0, 536870916(%ebx)
	movl	$0, 536870920(%ebx)
.L753:
	leal	-12(%ebp), %esp
	popl	%ebx
	popl	%esi
	popl	%edi
	popl	%ebp
	ret
	.size	logstats, .-logstats
	.section	.rodata
	.align 32
.LC140:
	.string	"  thttpd - %ld connections (%g/sec), %d max simultaneous, %lld bytes (%g/sec), %d httpd_conns allocated"
	.zero	56
	.text
	.type	thttpd_logstats, @function
thttpd_logstats:
.LASANPC33:
	pushl	%ebp
	movl	%esp, %ebp
	pushl	%esi
	pushl	%ebx
	subl	$16, %esp
	cmpl	$0, 8(%ebp)
	jle	.L759
	movl	httpd_conn_count, %esi
	movl	stats_bytes, %eax
	movl	%eax, -12(%ebp)
	fildl	-12(%ebp)
	fildl	8(%ebp)
	fdivrp	%st, %st(1)
	movl	stats_bytes, %eax
	cltd
	movl	stats_simultaneous, %ebx
	movl	stats_connections, %ecx
	movl	%ecx, -12(%ebp)
	fildl	-12(%ebp)
	fildl	8(%ebp)
	fdivrp	%st, %st(1)
	fxch	%st(1)
	movl	stats_connections, %ecx
	subl	$4, %esp
	pushl	%esi
	leal	-8(%esp), %esp
	fstpl	(%esp)
	pushl	%edx
	pushl	%eax
	pushl	%ebx
	leal	-8(%esp), %esp
	fstpl	(%esp)
	pushl	%ecx
	pushl	$.LC140
	pushl	$6
	call	syslog
	addl	$48, %esp
.L759:
	movl	$0, stats_connections
	movl	$0, stats_bytes
	movl	$0, stats_simultaneous
	leal	-8(%ebp), %esp
	popl	%ebx
	popl	%esi
	popl	%ebp
	ret
	.size	thttpd_logstats, .-thttpd_logstats
	.section	.rodata
.LC142:
	.string	"watchdog_flag"
.LC143:
	.string	"thttpd.c"
.LC144:
	.string	"got_usr1"
.LC145:
	.string	"got_hup"
.LC146:
	.string	"terminate"
.LC147:
	.string	"hs"
.LC148:
	.string	"httpd_conn_count"
.LC149:
	.string	"first_free_connect"
.LC150:
	.string	"max_connects"
.LC151:
	.string	"num_connects"
.LC152:
	.string	"connects"
.LC153:
	.string	"maxthrottles"
.LC154:
	.string	"numthrottles"
.LC155:
	.string	"hostname"
.LC156:
	.string	"throttlefile"
.LC157:
	.string	"local_pattern"
.LC158:
	.string	"no_empty_referers"
.LC159:
	.string	"url_pattern"
.LC160:
	.string	"cgi_limit"
.LC161:
	.string	"cgi_pattern"
.LC162:
	.string	"do_global_passwd"
.LC163:
	.string	"do_vhost"
.LC164:
	.string	"no_symlink_check"
.LC165:
	.string	"no_log"
.LC166:
	.string	"do_chroot"
.LC167:
	.string	"argv0"
.LC168:
	.string	"*.LC138"
.LC169:
	.string	"*.LC20"
.LC170:
	.string	"*.LC97"
.LC171:
	.string	"*.LC6"
.LC172:
	.string	"*.LC41"
.LC173:
	.string	"*.LC118"
.LC174:
	.string	"*.LC119"
.LC175:
	.string	"*.LC107"
.LC176:
	.string	"*.LC132"
.LC177:
	.string	"*.LC33"
.LC178:
	.string	"*.LC36"
.LC179:
	.string	"*.LC69"
.LC180:
	.string	"*.LC93"
.LC181:
	.string	"*.LC60"
.LC182:
	.string	"*.LC115"
.LC183:
	.string	"*.LC10"
.LC184:
	.string	"*.LC5"
.LC185:
	.string	"*.LC54"
.LC186:
	.string	"*.LC27"
.LC187:
	.string	"*.LC34"
.LC188:
	.string	"*.LC94"
.LC189:
	.string	"*.LC28"
.LC190:
	.string	"*.LC90"
.LC191:
	.string	"*.LC40"
.LC192:
	.string	"*.LC55"
.LC193:
	.string	"*.LC103"
.LC194:
	.string	"*.LC110"
.LC195:
	.string	"*.LC87"
.LC196:
	.string	"*.LC73"
.LC197:
	.string	"*.LC134"
.LC198:
	.string	"*.LC62"
.LC199:
	.string	"*.LC112"
.LC200:
	.string	"*.LC114"
.LC201:
	.string	"*.LC116"
.LC202:
	.string	"*.LC19"
.LC203:
	.string	"*.LC89"
.LC204:
	.string	"*.LC98"
.LC205:
	.string	"*.LC49"
.LC206:
	.string	"*.LC56"
.LC207:
	.string	"*.LC99"
.LC208:
	.string	"*.LC22"
.LC209:
	.string	"*.LC61"
.LC210:
	.string	"*.LC88"
.LC211:
	.string	"*.LC21"
.LC212:
	.string	"*.LC7"
.LC213:
	.string	"*.LC42"
.LC214:
	.string	"*.LC25"
.LC215:
	.string	"*.LC2"
.LC216:
	.string	"*.LC39"
.LC217:
	.string	"*.LC47"
.LC218:
	.string	"*.LC109"
.LC219:
	.string	"*.LC32"
.LC220:
	.string	"*.LC101"
.LC221:
	.string	"*.LC128"
.LC222:
	.string	"*.LC13"
.LC223:
	.string	"*.LC83"
.LC224:
	.string	"*.LC31"
.LC225:
	.string	"*.LC12"
.LC226:
	.string	"*.LC45"
.LC227:
	.string	"*.LC79"
.LC228:
	.string	"*.LC50"
.LC229:
	.string	"*.LC72"
.LC230:
	.string	"*.LC125"
.LC231:
	.string	"*.LC66"
.LC232:
	.string	"*.LC63"
.LC233:
	.string	"*.LC64"
.LC234:
	.string	"*.LC17"
.LC235:
	.string	"*.LC75"
.LC236:
	.string	"*.LC24"
.LC237:
	.string	"*.LC23"
.LC238:
	.string	"*.LC140"
.LC239:
	.string	"*.LC117"
.LC240:
	.string	"*.LC26"
.LC241:
	.string	"*.LC105"
.LC242:
	.string	"*.LC29"
.LC243:
	.string	"*.LC76"
.LC244:
	.string	"*.LC67"
.LC245:
	.string	"*.LC80"
.LC246:
	.string	"*.LC100"
.LC247:
	.string	"*.LC65"
.LC248:
	.string	"*.LC84"
.LC249:
	.string	"*.LC8"
.LC250:
	.string	"*.LC91"
.LC251:
	.string	"*.LC48"
.LC252:
	.string	"*.LC30"
.LC253:
	.string	"*.LC111"
.LC254:
	.string	"*.LC129"
.LC255:
	.string	"*.LC43"
.LC256:
	.string	"*.LC137"
.LC257:
	.string	"*.LC15"
.LC258:
	.string	"*.LC139"
.LC259:
	.string	"*.LC78"
.LC260:
	.string	"*.LC70"
.LC261:
	.string	"*.LC120"
.LC262:
	.string	"*.LC53"
.LC263:
	.string	"*.LC68"
.LC264:
	.string	"*.LC57"
.LC265:
	.string	"*.LC136"
.LC266:
	.string	"*.LC131"
.LC267:
	.string	"*.LC44"
.LC268:
	.string	"*.LC133"
.LC269:
	.string	"*.LC135"
.LC270:
	.string	"*.LC104"
.LC271:
	.string	"*.LC38"
.LC272:
	.string	"*.LC37"
.LC273:
	.string	"*.LC127"
.LC274:
	.string	"*.LC3"
.LC275:
	.string	"*.LC81"
.LC276:
	.string	"*.LC58"
.LC277:
	.string	"*.LC4"
.LC278:
	.string	"*.LC18"
.LC279:
	.string	"*.LC14"
.LC280:
	.string	"*.LC123"
.LC281:
	.string	"*.LC92"
.LC282:
	.string	"*.LC35"
.LC283:
	.string	"*.LC102"
.LC284:
	.string	"*.LC85"
.LC285:
	.string	"*.LC124"
.LC286:
	.string	"*.LC0"
.LC287:
	.string	"*.LC51"
.LC288:
	.string	"*.LC71"
.LC289:
	.string	"*.LC96"
.LC290:
	.string	"*.LC52"
.LC291:
	.string	"*.LC59"
.LC292:
	.string	"*.LC95"
.LC293:
	.string	"*.LC86"
.LC294:
	.string	"*.LC106"
.LC295:
	.string	"*.LC46"
.LC296:
	.string	"*.LC11"
.LC297:
	.string	"*.LC82"
.LC298:
	.string	"*.LC16"
.LC299:
	.string	"*.LC77"
	.data
	.align 64
	.type	.LASAN0, @object
	.size	.LASAN0, 4032
.LASAN0:
	.long	watchdog_flag
	.long	4
	.long	64
	.long	.LC142
	.long	.LC143
	.long	0
	.long	got_usr1
	.long	4
	.long	64
	.long	.LC144
	.long	.LC143
	.long	0
	.long	got_hup
	.long	4
	.long	64
	.long	.LC145
	.long	.LC143
	.long	0
	.long	terminate
	.long	4
	.long	64
	.long	.LC146
	.long	.LC143
	.long	0
	.long	hs
	.long	4
	.long	64
	.long	.LC147
	.long	.LC143
	.long	0
	.long	httpd_conn_count
	.long	4
	.long	64
	.long	.LC148
	.long	.LC143
	.long	0
	.long	first_free_connect
	.long	4
	.long	64
	.long	.LC149
	.long	.LC143
	.long	0
	.long	max_connects
	.long	4
	.long	64
	.long	.LC150
	.long	.LC143
	.long	0
	.long	num_connects
	.long	4
	.long	64
	.long	.LC151
	.long	.LC143
	.long	0
	.long	connects
	.long	4
	.long	64
	.long	.LC152
	.long	.LC143
	.long	0
	.long	maxthrottles
	.long	4
	.long	64
	.long	.LC153
	.long	.LC143
	.long	0
	.long	numthrottles
	.long	4
	.long	64
	.long	.LC154
	.long	.LC143
	.long	0
	.long	throttles
	.long	4
	.long	64
	.long	.LC92
	.long	.LC143
	.long	0
	.long	max_age
	.long	4
	.long	64
	.long	.LC102
	.long	.LC143
	.long	0
	.long	p3p
	.long	4
	.long	64
	.long	.LC101
	.long	.LC143
	.long	0
	.long	charset
	.long	4
	.long	64
	.long	.LC100
	.long	.LC143
	.long	0
	.long	user
	.long	4
	.long	64
	.long	.LC86
	.long	.LC143
	.long	0
	.long	pidfile
	.long	4
	.long	64
	.long	.LC99
	.long	.LC143
	.long	0
	.long	hostname
	.long	4
	.long	64
	.long	.LC155
	.long	.LC143
	.long	0
	.long	throttlefile
	.long	4
	.long	64
	.long	.LC156
	.long	.LC143
	.long	0
	.long	logfile
	.long	4
	.long	64
	.long	.LC94
	.long	.LC143
	.long	0
	.long	local_pattern
	.long	4
	.long	64
	.long	.LC157
	.long	.LC143
	.long	0
	.long	no_empty_referers
	.long	4
	.long	64
	.long	.LC158
	.long	.LC143
	.long	0
	.long	url_pattern
	.long	4
	.long	64
	.long	.LC159
	.long	.LC143
	.long	0
	.long	cgi_limit
	.long	4
	.long	64
	.long	.LC160
	.long	.LC143
	.long	0
	.long	cgi_pattern
	.long	4
	.long	64
	.long	.LC161
	.long	.LC143
	.long	0
	.long	do_global_passwd
	.long	4
	.long	64
	.long	.LC162
	.long	.LC143
	.long	0
	.long	do_vhost
	.long	4
	.long	64
	.long	.LC163
	.long	.LC143
	.long	0
	.long	no_symlink_check
	.long	4
	.long	64
	.long	.LC164
	.long	.LC143
	.long	0
	.long	no_log
	.long	4
	.long	64
	.long	.LC165
	.long	.LC143
	.long	0
	.long	do_chroot
	.long	4
	.long	64
	.long	.LC166
	.long	.LC143
	.long	0
	.long	data_dir
	.long	4
	.long	64
	.long	.LC81
	.long	.LC143
	.long	0
	.long	dir
	.long	4
	.long	64
	.long	.LC79
	.long	.LC143
	.long	0
	.long	port
	.long	2
	.long	64
	.long	.LC78
	.long	.LC143
	.long	0
	.long	debug
	.long	4
	.long	64
	.long	.LC77
	.long	.LC143
	.long	0
	.long	argv0
	.long	4
	.long	64
	.long	.LC167
	.long	.LC143
	.long	0
	.long	.LC138
	.long	35
	.long	96
	.long	.LC168
	.long	.LC143
	.long	0
	.long	.LC20
	.long	11
	.long	64
	.long	.LC169
	.long	.LC143
	.long	0
	.long	.LC97
	.long	13
	.long	64
	.long	.LC170
	.long	.LC143
	.long	0
	.long	.LC6
	.long	19
	.long	64
	.long	.LC171
	.long	.LC143
	.long	0
	.long	.LC41
	.long	16
	.long	64
	.long	.LC172
	.long	.LC143
	.long	0
	.long	.LC118
	.long	3
	.long	64
	.long	.LC173
	.long	.LC143
	.long	0
	.long	.LC119
	.long	39
	.long	96
	.long	.LC174
	.long	.LC143
	.long	0
	.long	.LC107
	.long	36
	.long	96
	.long	.LC175
	.long	.LC143
	.long	0
	.long	.LC132
	.long	70
	.long	128
	.long	.LC176
	.long	.LC143
	.long	0
	.long	.LC33
	.long	20
	.long	64
	.long	.LC177
	.long	.LC143
	.long	0
	.long	.LC36
	.long	24
	.long	64
	.long	.LC178
	.long	.LC143
	.long	0
	.long	.LC69
	.long	3
	.long	64
	.long	.LC179
	.long	.LC143
	.long	0
	.long	.LC93
	.long	5
	.long	64
	.long	.LC180
	.long	.LC143
	.long	0
	.long	.LC60
	.long	3
	.long	64
	.long	.LC181
	.long	.LC143
	.long	0
	.long	.LC115
	.long	16
	.long	64
	.long	.LC182
	.long	.LC143
	.long	0
	.long	.LC10
	.long	29
	.long	64
	.long	.LC183
	.long	.LC143
	.long	0
	.long	.LC5
	.long	2
	.long	64
	.long	.LC184
	.long	.LC143
	.long	0
	.long	.LC54
	.long	3
	.long	64
	.long	.LC185
	.long	.LC143
	.long	0
	.long	.LC27
	.long	12
	.long	64
	.long	.LC186
	.long	.LC143
	.long	0
	.long	.LC34
	.long	15
	.long	64
	.long	.LC187
	.long	.LC143
	.long	0
	.long	.LC94
	.long	8
	.long	64
	.long	.LC188
	.long	.LC143
	.long	0
	.long	.LC28
	.long	7
	.long	64
	.long	.LC189
	.long	.LC143
	.long	0
	.long	.LC90
	.long	16
	.long	64
	.long	.LC190
	.long	.LC143
	.long	0
	.long	.LC40
	.long	12
	.long	64
	.long	.LC191
	.long	.LC143
	.long	0
	.long	.LC55
	.long	5
	.long	64
	.long	.LC192
	.long	.LC143
	.long	0
	.long	.LC103
	.long	32
	.long	64
	.long	.LC193
	.long	.LC143
	.long	0
	.long	.LC110
	.long	26
	.long	64
	.long	.LC194
	.long	.LC143
	.long	0
	.long	.LC87
	.long	7
	.long	64
	.long	.LC195
	.long	.LC143
	.long	0
	.long	.LC73
	.long	219
	.long	256
	.long	.LC196
	.long	.LC143
	.long	0
	.long	.LC134
	.long	65
	.long	128
	.long	.LC197
	.long	.LC143
	.long	0
	.long	.LC62
	.long	3
	.long	64
	.long	.LC198
	.long	.LC143
	.long	0
	.long	.LC112
	.long	39
	.long	96
	.long	.LC199
	.long	.LC143
	.long	0
	.long	.LC114
	.long	20
	.long	64
	.long	.LC200
	.long	.LC143
	.long	0
	.long	.LC116
	.long	33
	.long	96
	.long	.LC201
	.long	.LC143
	.long	0
	.long	.LC19
	.long	15
	.long	64
	.long	.LC202
	.long	.LC143
	.long	0
	.long	.LC89
	.long	7
	.long	64
	.long	.LC203
	.long	.LC143
	.long	0
	.long	.LC98
	.long	15
	.long	64
	.long	.LC204
	.long	.LC143
	.long	0
	.long	.LC49
	.long	3
	.long	64
	.long	.LC205
	.long	.LC143
	.long	0
	.long	.LC56
	.long	4
	.long	64
	.long	.LC206
	.long	.LC143
	.long	0
	.long	.LC99
	.long	8
	.long	64
	.long	.LC207
	.long	.LC143
	.long	0
	.long	.LC22
	.long	2
	.long	64
	.long	.LC208
	.long	.LC143
	.long	0
	.long	.LC61
	.long	3
	.long	64
	.long	.LC209
	.long	.LC143
	.long	0
	.long	.LC88
	.long	9
	.long	64
	.long	.LC210
	.long	.LC143
	.long	0
	.long	.LC21
	.long	6
	.long	64
	.long	.LC211
	.long	.LC143
	.long	0
	.long	.LC7
	.long	2
	.long	64
	.long	.LC212
	.long	.LC143
	.long	0
	.long	.LC42
	.long	12
	.long	64
	.long	.LC213
	.long	.LC143
	.long	0
	.long	.LC25
	.long	4
	.long	64
	.long	.LC214
	.long	.LC143
	.long	0
	.long	.LC2
	.long	16
	.long	64
	.long	.LC215
	.long	.LC143
	.long	0
	.long	.LC39
	.long	15
	.long	64
	.long	.LC216
	.long	.LC143
	.long	0
	.long	.LC47
	.long	11
	.long	64
	.long	.LC217
	.long	.LC143
	.long	0
	.long	.LC109
	.long	3
	.long	64
	.long	.LC218
	.long	.LC143
	.long	0
	.long	.LC32
	.long	13
	.long	64
	.long	.LC219
	.long	.LC143
	.long	0
	.long	.LC101
	.long	4
	.long	64
	.long	.LC220
	.long	.LC143
	.long	0
	.long	.LC128
	.long	37
	.long	96
	.long	.LC221
	.long	.LC143
	.long	0
	.long	.LC13
	.long	25
	.long	64
	.long	.LC222
	.long	.LC143
	.long	0
	.long	.LC83
	.long	10
	.long	64
	.long	.LC223
	.long	.LC143
	.long	0
	.long	.LC31
	.long	18
	.long	64
	.long	.LC224
	.long	.LC143
	.long	0
	.long	.LC12
	.long	23
	.long	64
	.long	.LC225
	.long	.LC143
	.long	0
	.long	.LC45
	.long	13
	.long	64
	.long	.LC226
	.long	.LC143
	.long	0
	.long	.LC79
	.long	4
	.long	64
	.long	.LC227
	.long	.LC143
	.long	0
	.long	.LC50
	.long	26
	.long	64
	.long	.LC228
	.long	.LC143
	.long	0
	.long	.LC72
	.long	3
	.long	64
	.long	.LC229
	.long	.LC143
	.long	0
	.long	.LC125
	.long	39
	.long	96
	.long	.LC230
	.long	.LC143
	.long	0
	.long	.LC66
	.long	3
	.long	64
	.long	.LC231
	.long	.LC143
	.long	0
	.long	.LC63
	.long	3
	.long	64
	.long	.LC232
	.long	.LC143
	.long	0
	.long	.LC64
	.long	3
	.long	64
	.long	.LC233
	.long	.LC143
	.long	0
	.long	.LC17
	.long	72
	.long	128
	.long	.LC234
	.long	.LC143
	.long	0
	.long	.LC75
	.long	2
	.long	64
	.long	.LC235
	.long	.LC143
	.long	0
	.long	.LC24
	.long	2
	.long	64
	.long	.LC236
	.long	.LC143
	.long	0
	.long	.LC23
	.long	12
	.long	64
	.long	.LC237
	.long	.LC143
	.long	0
	.long	.LC140
	.long	104
	.long	160
	.long	.LC238
	.long	.LC143
	.long	0
	.long	.LC117
	.long	38
	.long	96
	.long	.LC239
	.long	.LC143
	.long	0
	.long	.LC26
	.long	31
	.long	64
	.long	.LC240
	.long	.LC143
	.long	0
	.long	.LC105
	.long	37
	.long	96
	.long	.LC241
	.long	.LC143
	.long	0
	.long	.LC29
	.long	74
	.long	128
	.long	.LC242
	.long	.LC143
	.long	0
	.long	.LC76
	.long	5
	.long	64
	.long	.LC243
	.long	.LC143
	.long	0
	.long	.LC67
	.long	5
	.long	64
	.long	.LC244
	.long	.LC143
	.long	0
	.long	.LC80
	.long	9
	.long	64
	.long	.LC245
	.long	.LC143
	.long	0
	.long	.LC100
	.long	8
	.long	64
	.long	.LC246
	.long	.LC143
	.long	0
	.long	.LC65
	.long	5
	.long	64
	.long	.LC247
	.long	.LC143
	.long	0
	.long	.LC84
	.long	9
	.long	64
	.long	.LC248
	.long	.LC143
	.long	0
	.long	.LC8
	.long	22
	.long	64
	.long	.LC249
	.long	.LC143
	.long	0
	.long	.LC91
	.long	9
	.long	64
	.long	.LC250
	.long	.LC143
	.long	0
	.long	.LC48
	.long	1
	.long	64
	.long	.LC251
	.long	.LC143
	.long	0
	.long	.LC30
	.long	79
	.long	128
	.long	.LC252
	.long	.LC143
	.long	0
	.long	.LC111
	.long	25
	.long	64
	.long	.LC253
	.long	.LC143
	.long	0
	.long	.LC129
	.long	25
	.long	64
	.long	.LC254
	.long	.LC143
	.long	0
	.long	.LC43
	.long	58
	.long	96
	.long	.LC255
	.long	.LC143
	.long	0
	.long	.LC137
	.long	35
	.long	96
	.long	.LC256
	.long	.LC143
	.long	0
	.long	.LC15
	.long	11
	.long	64
	.long	.LC257
	.long	.LC143
	.long	0
	.long	.LC139
	.long	39
	.long	96
	.long	.LC258
	.long	.LC143
	.long	0
	.long	.LC78
	.long	5
	.long	64
	.long	.LC259
	.long	.LC143
	.long	0
	.long	.LC70
	.long	3
	.long	64
	.long	.LC260
	.long	.LC143
	.long	0
	.long	.LC120
	.long	44
	.long	96
	.long	.LC261
	.long	.LC143
	.long	0
	.long	.LC53
	.long	3
	.long	64
	.long	.LC262
	.long	.LC143
	.long	0
	.long	.LC68
	.long	3
	.long	64
	.long	.LC263
	.long	.LC143
	.long	0
	.long	.LC57
	.long	3
	.long	64
	.long	.LC264
	.long	.LC143
	.long	0
	.long	.LC136
	.long	43
	.long	96
	.long	.LC265
	.long	.LC143
	.long	0
	.long	.LC131
	.long	56
	.long	96
	.long	.LC266
	.long	.LC143
	.long	0
	.long	.LC44
	.long	38
	.long	96
	.long	.LC267
	.long	.LC143
	.long	0
	.long	.LC133
	.long	62
	.long	96
	.long	.LC268
	.long	.LC143
	.long	0
	.long	.LC135
	.long	33
	.long	96
	.long	.LC269
	.long	.LC143
	.long	0
	.long	.LC104
	.long	34
	.long	96
	.long	.LC270
	.long	.LC143
	.long	0
	.long	.LC38
	.long	30
	.long	64
	.long	.LC271
	.long	.LC143
	.long	0
	.long	.LC37
	.long	36
	.long	96
	.long	.LC272
	.long	.LC143
	.long	0
	.long	.LC127
	.long	33
	.long	96
	.long	.LC273
	.long	.LC143
	.long	0
	.long	.LC3
	.long	8
	.long	64
	.long	.LC274
	.long	.LC143
	.long	0
	.long	.LC81
	.long	9
	.long	64
	.long	.LC275
	.long	.LC143
	.long	0
	.long	.LC58
	.long	5
	.long	64
	.long	.LC276
	.long	.LC143
	.long	0
	.long	.LC4
	.long	5
	.long	64
	.long	.LC277
	.long	.LC143
	.long	0
	.long	.LC18
	.long	20
	.long	64
	.long	.LC278
	.long	.LC143
	.long	0
	.long	.LC14
	.long	10
	.long	64
	.long	.LC279
	.long	.LC143
	.long	0
	.long	.LC123
	.long	22
	.long	64
	.long	.LC280
	.long	.LC143
	.long	0
	.long	.LC92
	.long	10
	.long	64
	.long	.LC281
	.long	.LC143
	.long	0
	.long	.LC35
	.long	30
	.long	64
	.long	.LC282
	.long	.LC143
	.long	0
	.long	.LC102
	.long	8
	.long	64
	.long	.LC283
	.long	.LC143
	.long	0
	.long	.LC85
	.long	11
	.long	64
	.long	.LC284
	.long	.LC143
	.long	0
	.long	.LC124
	.long	36
	.long	96
	.long	.LC285
	.long	.LC143
	.long	0
	.long	.LC0
	.long	25
	.long	64
	.long	.LC286
	.long	.LC143
	.long	0
	.long	.LC51
	.long	3
	.long	64
	.long	.LC287
	.long	.LC143
	.long	0
	.long	.LC71
	.long	3
	.long	64
	.long	.LC288
	.long	.LC143
	.long	0
	.long	.LC96
	.long	8
	.long	64
	.long	.LC289
	.long	.LC143
	.long	0
	.long	.LC52
	.long	3
	.long	64
	.long	.LC290
	.long	.LC143
	.long	0
	.long	.LC59
	.long	3
	.long	64
	.long	.LC291
	.long	.LC143
	.long	0
	.long	.LC95
	.long	6
	.long	64
	.long	.LC292
	.long	.LC143
	.long	0
	.long	.LC86
	.long	5
	.long	64
	.long	.LC293
	.long	.LC143
	.long	0
	.long	.LC106
	.long	31
	.long	64
	.long	.LC294
	.long	.LC143
	.long	0
	.long	.LC46
	.long	7
	.long	64
	.long	.LC295
	.long	.LC143
	.long	0
	.long	.LC11
	.long	34
	.long	96
	.long	.LC296
	.long	.LC143
	.long	0
	.long	.LC82
	.long	8
	.long	64
	.long	.LC297
	.long	.LC143
	.long	0
	.long	.LC16
	.long	67
	.long	128
	.long	.LC298
	.long	.LC143
	.long	0
	.long	.LC77
	.long	6
	.long	64
	.long	.LC299
	.long	.LC143
	.long	0
	.text
	.type	_GLOBAL__sub_D_00099_0_terminate, @function
_GLOBAL__sub_D_00099_0_terminate:
	pushl	%ebp
	movl	%esp, %ebp
	subl	$8, %esp
	subl	$8, %esp
	pushl	$168
	pushl	$.LASAN0
	call	__asan_unregister_globals
	addl	$16, %esp
	leave
	ret
	.size	_GLOBAL__sub_D_00099_0_terminate, .-_GLOBAL__sub_D_00099_0_terminate
	.section	.dtors.65436,"aw",@progbits
	.align 4
	.long	_GLOBAL__sub_D_00099_0_terminate
	.text
	.type	_GLOBAL__sub_I_00099_1_terminate, @function
_GLOBAL__sub_I_00099_1_terminate:
	pushl	%ebp
	movl	%esp, %ebp
	subl	$8, %esp
	call	__asan_init_v3
	subl	$8, %esp
	pushl	$168
	pushl	$.LASAN0
	call	__asan_register_globals
	addl	$16, %esp
	leave
	ret
	.size	_GLOBAL__sub_I_00099_1_terminate, .-_GLOBAL__sub_I_00099_1_terminate
	.section	.ctors.65436,"aw",@progbits
	.align 4
	.long	_GLOBAL__sub_I_00099_1_terminate
	.ident	"GCC: (GNU) 4.9.2"
	.section	.note.GNU-stack,"",@progbits
