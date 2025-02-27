	.file	"thttpd.c"
	.local	argv0
	.comm	argv0,4,4
	.local	debug
	.comm	debug,4,4
	.local	port
	.comm	port,2,2
	.local	dir
	.comm	dir,4,4
	.local	data_dir
	.comm	data_dir,4,4
	.local	do_chroot
	.comm	do_chroot,4,4
	.local	no_log
	.comm	no_log,4,4
	.local	no_symlink_check
	.comm	no_symlink_check,4,4
	.local	do_vhost
	.comm	do_vhost,4,4
	.local	do_global_passwd
	.comm	do_global_passwd,4,4
	.local	cgi_pattern
	.comm	cgi_pattern,4,4
	.local	cgi_limit
	.comm	cgi_limit,4,4
	.local	url_pattern
	.comm	url_pattern,4,4
	.local	no_empty_referers
	.comm	no_empty_referers,4,4
	.local	local_pattern
	.comm	local_pattern,4,4
	.local	logfile
	.comm	logfile,4,4
	.local	throttlefile
	.comm	throttlefile,4,4
	.local	hostname
	.comm	hostname,4,4
	.local	pidfile
	.comm	pidfile,4,4
	.local	user
	.comm	user,4,4
	.local	charset
	.comm	charset,4,4
	.local	p3p
	.comm	p3p,4,4
	.local	max_age
	.comm	max_age,4,4
	.local	throttles
	.comm	throttles,4,4
	.local	numthrottles
	.comm	numthrottles,4,4
	.local	maxthrottles
	.comm	maxthrottles,4,4
	.local	connects
	.comm	connects,4,4
	.local	num_connects
	.comm	num_connects,4,4
	.local	max_connects
	.comm	max_connects,4,4
	.local	first_free_connect
	.comm	first_free_connect,4,4
	.local	httpd_conn_count
	.comm	httpd_conn_count,4,4
	.local	hs
	.comm	hs,4,4
	.globl	terminate
	.bss
	.align 4
	.type	terminate, @object
	.size	terminate, 4
terminate:
	.zero	4
	.comm	start_time,4,4
	.comm	stats_time,4,4
	.comm	stats_connections,4,4
	.comm	stats_bytes,4,4
	.comm	stats_simultaneous,4,4
	.local	got_hup
	.comm	got_hup,4,4
	.local	got_usr1
	.comm	got_usr1,4,4
	.local	watchdog_flag
	.comm	watchdog_flag,4,4
	.section	.rodata
.LC0:
	.string	"exiting due to signal %d"
	.text
	.type	handle_term, @function
handle_term:
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
	subl	$12, %esp
	pushl	$1
	call	exit
	.size	handle_term, .-handle_term
	.section	.rodata
.LC1:
	.string	"child wait - %m"
	.text
	.type	handle_chld, @function
handle_chld:
	pushl	%ebp
	movl	%esp, %ebp
	subl	$24, %esp
	movl	%gs:20, %eax
	movl	%eax, -12(%ebp)
	xorl	%eax, %eax
	call	__errno_location
	movl	(%eax), %eax
	movl	%eax, -20(%ebp)
.L10:
	subl	$4, %esp
	pushl	$1
	leal	-24(%ebp), %eax
	pushl	%eax
	pushl	$-1
	call	waitpid
	addl	$16, %esp
	movl	%eax, -16(%ebp)
	cmpl	$0, -16(%ebp)
	jne	.L3
	jmp	.L4
.L3:
	cmpl	$0, -16(%ebp)
	jns	.L5
	call	__errno_location
	movl	(%eax), %eax
	cmpl	$4, %eax
	je	.L6
	call	__errno_location
	movl	(%eax), %eax
	cmpl	$11, %eax
	jne	.L7
.L6:
	jmp	.L8
.L7:
	call	__errno_location
	movl	(%eax), %eax
	cmpl	$10, %eax
	je	.L9
	subl	$8, %esp
	pushl	$.LC1
	pushl	$3
	call	syslog
	addl	$16, %esp
	jmp	.L4
.L9:
	jmp	.L4
.L5:
	movl	hs, %eax
	testl	%eax, %eax
	je	.L8
	movl	hs, %eax
	movl	20(%eax), %edx
	subl	$1, %edx
	movl	%edx, 20(%eax)
	movl	hs, %eax
	movl	20(%eax), %eax
	testl	%eax, %eax
	jns	.L8
	movl	hs, %eax
	movl	$0, 20(%eax)
.L8:
	jmp	.L10
.L4:
	call	__errno_location
	movl	%eax, %edx
	movl	-20(%ebp), %eax
	movl	%eax, (%edx)
	movl	-12(%ebp), %eax
	xorl	%gs:20, %eax
	je	.L11
	call	__stack_chk_fail
.L11:
	leave
	ret
	.size	handle_chld, .-handle_chld
	.type	handle_hup, @function
handle_hup:
	pushl	%ebp
	movl	%esp, %ebp
	subl	$24, %esp
	call	__errno_location
	movl	(%eax), %eax
	movl	%eax, -12(%ebp)
	movl	$1, got_hup
	call	__errno_location
	movl	%eax, %edx
	movl	-12(%ebp), %eax
	movl	%eax, (%edx)
	leave
	ret
	.size	handle_hup, .-handle_hup
	.section	.rodata
.LC2:
	.string	"exiting"
	.text
	.type	handle_usr1, @function
handle_usr1:
	pushl	%ebp
	movl	%esp, %ebp
	subl	$8, %esp
	movl	num_connects, %eax
	testl	%eax, %eax
	jne	.L14
	call	shut_down
	subl	$8, %esp
	pushl	$.LC2
	pushl	$5
	call	syslog
	addl	$16, %esp
	call	closelog
	subl	$12, %esp
	pushl	$0
	call	exit
.L14:
	movl	$1, got_usr1
	leave
	ret
	.size	handle_usr1, .-handle_usr1
	.type	handle_usr2, @function
handle_usr2:
	pushl	%ebp
	movl	%esp, %ebp
	subl	$24, %esp
	call	__errno_location
	movl	(%eax), %eax
	movl	%eax, -12(%ebp)
	subl	$12, %esp
	pushl	$0
	call	logstats
	addl	$16, %esp
	call	__errno_location
	movl	%eax, %edx
	movl	-12(%ebp), %eax
	movl	%eax, (%edx)
	leave
	ret
	.size	handle_usr2, .-handle_usr2
	.section	.rodata
.LC3:
	.string	"/tmp"
	.text
	.type	handle_alrm, @function
handle_alrm:
	pushl	%ebp
	movl	%esp, %ebp
	subl	$24, %esp
	call	__errno_location
	movl	(%eax), %eax
	movl	%eax, -12(%ebp)
	movl	watchdog_flag, %eax
	testl	%eax, %eax
	jne	.L17
	subl	$12, %esp
	pushl	$.LC3
	call	chdir
	addl	$16, %esp
	call	abort
.L17:
	movl	$0, watchdog_flag
	subl	$12, %esp
	pushl	$360
	call	alarm
	addl	$16, %esp
	call	__errno_location
	movl	%eax, %edx
	movl	-12(%ebp), %eax
	movl	%eax, (%edx)
	leave
	ret
	.size	handle_alrm, .-handle_alrm
	.section	.rodata
.LC4:
	.string	"-"
.LC5:
	.string	"re-opening logfile"
.LC6:
	.string	"a"
.LC7:
	.string	"re-opening %.80s - %m"
	.text
	.type	re_open_logfile, @function
re_open_logfile:
	pushl	%ebp
	movl	%esp, %ebp
	subl	$24, %esp
	movl	no_log, %eax
	testl	%eax, %eax
	jne	.L19
	movl	hs, %eax
	testl	%eax, %eax
	jne	.L20
.L19:
	jmp	.L18
.L20:
	movl	logfile, %eax
	testl	%eax, %eax
	je	.L18
	movl	logfile, %eax
	subl	$8, %esp
	pushl	$.LC4
	pushl	%eax
	call	strcmp
	addl	$16, %esp
	testl	%eax, %eax
	je	.L18
	subl	$8, %esp
	pushl	$.LC5
	pushl	$5
	call	syslog
	addl	$16, %esp
	movl	logfile, %eax
	subl	$8, %esp
	pushl	$.LC6
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
	je	.L22
	cmpl	$0, -12(%ebp)
	je	.L23
.L22:
	movl	logfile, %eax
	subl	$4, %esp
	pushl	%eax
	pushl	$.LC7
	pushl	$2
	call	syslog
	addl	$16, %esp
	jmp	.L18
.L23:
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
.L18:
	leave
	ret
	.size	re_open_logfile, .-re_open_logfile
	.section	.rodata
.LC8:
	.string	"can't find any valid address"
	.align 4
.LC9:
	.string	"%s: can't find any valid address\n"
.LC10:
	.string	"unknown user - '%.80s'"
.LC11:
	.string	"%s: unknown user - '%s'\n"
.LC12:
	.string	"/dev/null"
.LC13:
	.string	"%.80s - %m"
	.align 4
.LC14:
	.string	"logfile is not an absolute path, you may not be able to re-open it"
	.align 4
.LC15:
	.string	"%s: logfile is not an absolute path, you may not be able to re-open it\n"
.LC16:
	.string	"fchown logfile - %m"
.LC17:
	.string	"fchown logfile"
.LC18:
	.string	"chdir - %m"
.LC19:
	.string	"chdir"
.LC20:
	.string	"daemon - %m"
.LC21:
	.string	"w"
.LC22:
	.string	"%d\n"
	.align 4
.LC23:
	.string	"fdwatch initialization failure"
.LC24:
	.string	"chroot - %m"
.LC25:
	.string	"chroot"
	.align 4
.LC26:
	.string	"logfile is not within the chroot tree, you will not be able to re-open it"
	.align 4
.LC27:
	.string	"%s: logfile is not within the chroot tree, you will not be able to re-open it\n"
.LC28:
	.string	"chroot chdir - %m"
.LC29:
	.string	"chroot chdir"
.LC30:
	.string	"data_dir chdir - %m"
.LC31:
	.string	"data_dir chdir"
.LC32:
	.string	"tmr_create(occasional) failed"
.LC33:
	.string	"tmr_create(idle) failed"
	.align 4
.LC34:
	.string	"tmr_create(update_throttles) failed"
.LC35:
	.string	"tmr_create(show_stats) failed"
.LC36:
	.string	"setgroups - %m"
.LC37:
	.string	"setgid - %m"
.LC38:
	.string	"initgroups - %m"
.LC39:
	.string	"setuid - %m"
	.align 4
.LC40:
	.string	"started as root without requesting chroot(), warning only"
	.align 4
.LC41:
	.string	"out of memory allocating a connecttab"
.LC42:
	.string	"fdwatch - %m"
	.text
	.globl	main
	.type	main, @function
main:
	leal	4(%esp), %ecx
	andl	$-16, %esp
	pushl	-4(%ecx)
	pushl	%ebp
	movl	%esp, %ebp
	pushl	%edi
	pushl	%esi
	pushl	%ebx
	pushl	%ecx
	subl	$4488, %esp
	movl	%ecx, %ebx
	movl	4(%ebx), %eax
	movl	%eax, -4460(%ebp)
	movl	%gs:20, %eax
	movl	%eax, -28(%ebp)
	xorl	%eax, %eax
	movl	$32767, -4432(%ebp)
	movl	$32767, -4428(%ebp)
	movl	-4460(%ebp), %eax
	movl	(%eax), %eax
	movl	%eax, argv0
	movl	argv0, %eax
	subl	$8, %esp
	pushl	$47
	pushl	%eax
	call	strrchr
	addl	$16, %esp
	movl	%eax, -4436(%ebp)
	cmpl	$0, -4436(%ebp)
	je	.L25
	addl	$1, -4436(%ebp)
	jmp	.L26
.L25:
	movl	argv0, %eax
	movl	%eax, -4436(%ebp)
.L26:
	subl	$4, %esp
	pushl	$24
	pushl	$9
	pushl	-4436(%ebp)
	call	openlog
	addl	$16, %esp
	subl	$8, %esp
	pushl	-4460(%ebp)
	pushl	(%ebx)
	call	parse_args
	addl	$16, %esp
	call	tzset
	subl	$8, %esp
	leal	-4440(%ebp), %eax
	pushl	%eax
	pushl	$128
	leal	-4256(%ebp), %eax
	pushl	%eax
	leal	-4444(%ebp), %eax
	pushl	%eax
	pushl	$128
	leal	-4384(%ebp), %eax
	pushl	%eax
	call	lookup_hostname
	addl	$32, %esp
	movl	-4444(%ebp), %eax
	testl	%eax, %eax
	jne	.L27
	movl	-4440(%ebp), %eax
	testl	%eax, %eax
	jne	.L27
	subl	$8, %esp
	pushl	$.LC8
	pushl	$3
	call	syslog
	addl	$16, %esp
	movl	argv0, %edx
	movl	stderr, %eax
	subl	$4, %esp
	pushl	%edx
	pushl	$.LC9
	pushl	%eax
	call	fprintf
	addl	$16, %esp
	subl	$12, %esp
	pushl	$1
	call	exit
.L27:
	movl	$0, numthrottles
	movl	$0, maxthrottles
	movl	$0, throttles
	movl	throttlefile, %eax
	testl	%eax, %eax
	je	.L28
	movl	throttlefile, %eax
	subl	$12, %esp
	pushl	%eax
	call	read_throttlefile
	addl	$16, %esp
.L28:
	call	getuid
	testl	%eax, %eax
	jne	.L29
	movl	user, %eax
	subl	$12, %esp
	pushl	%eax
	call	getpwnam
	addl	$16, %esp
	movl	%eax, -4416(%ebp)
	cmpl	$0, -4416(%ebp)
	jne	.L30
	movl	user, %eax
	subl	$4, %esp
	pushl	%eax
	pushl	$.LC10
	pushl	$2
	call	syslog
	addl	$16, %esp
	movl	user, %ecx
	movl	argv0, %edx
	movl	stderr, %eax
	pushl	%ecx
	pushl	%edx
	pushl	$.LC11
	pushl	%eax
	call	fprintf
	addl	$16, %esp
	subl	$12, %esp
	pushl	$1
	call	exit
.L30:
	movl	-4416(%ebp), %eax
	movl	8(%eax), %eax
	movl	%eax, -4432(%ebp)
	movl	-4416(%ebp), %eax
	movl	12(%eax), %eax
	movl	%eax, -4428(%ebp)
.L29:
	movl	logfile, %eax
	testl	%eax, %eax
	je	.L31
	movl	logfile, %eax
	subl	$8, %esp
	pushl	$.LC12
	pushl	%eax
	call	strcmp
	addl	$16, %esp
	testl	%eax, %eax
	jne	.L32
	movl	$1, no_log
	movl	$0, -4424(%ebp)
	jmp	.L38
.L32:
	movl	logfile, %eax
	subl	$8, %esp
	pushl	$.LC4
	pushl	%eax
	call	strcmp
	addl	$16, %esp
	testl	%eax, %eax
	jne	.L34
	movl	stdout, %eax
	movl	%eax, -4424(%ebp)
	jmp	.L38
.L34:
	movl	logfile, %eax
	subl	$8, %esp
	pushl	$.LC6
	pushl	%eax
	call	fopen
	addl	$16, %esp
	movl	%eax, -4424(%ebp)
	movl	logfile, %eax
	subl	$8, %esp
	pushl	$384
	pushl	%eax
	call	chmod
	addl	$16, %esp
	movl	%eax, -4412(%ebp)
	cmpl	$0, -4424(%ebp)
	je	.L35
	cmpl	$0, -4412(%ebp)
	je	.L36
.L35:
	movl	logfile, %eax
	subl	$4, %esp
	pushl	%eax
	pushl	$.LC13
	pushl	$2
	call	syslog
	addl	$16, %esp
	movl	logfile, %eax
	subl	$12, %esp
	pushl	%eax
	call	perror
	addl	$16, %esp
	subl	$12, %esp
	pushl	$1
	call	exit
.L36:
	movl	logfile, %eax
	movzbl	(%eax), %eax
	cmpb	$47, %al
	je	.L37
	subl	$8, %esp
	pushl	$.LC14
	pushl	$4
	call	syslog
	addl	$16, %esp
	movl	argv0, %edx
	movl	stderr, %eax
	subl	$4, %esp
	pushl	%edx
	pushl	$.LC15
	pushl	%eax
	call	fprintf
	addl	$16, %esp
.L37:
	subl	$12, %esp
	pushl	-4424(%ebp)
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
	jne	.L38
	subl	$12, %esp
	pushl	-4424(%ebp)
	call	fileno
	addl	$16, %esp
	subl	$4, %esp
	pushl	-4428(%ebp)
	pushl	-4432(%ebp)
	pushl	%eax
	call	fchown
	addl	$16, %esp
	testl	%eax, %eax
	jns	.L38
	subl	$8, %esp
	pushl	$.LC16
	pushl	$4
	call	syslog
	addl	$16, %esp
	subl	$12, %esp
	pushl	$.LC17
	call	perror
	addl	$16, %esp
	jmp	.L38
.L31:
	movl	$0, -4424(%ebp)
.L38:
	movl	dir, %eax
	testl	%eax, %eax
	je	.L39
	movl	dir, %eax
	subl	$12, %esp
	pushl	%eax
	call	chdir
	addl	$16, %esp
	testl	%eax, %eax
	jns	.L39
	subl	$8, %esp
	pushl	$.LC18
	pushl	$2
	call	syslog
	addl	$16, %esp
	subl	$12, %esp
	pushl	$.LC19
	call	perror
	addl	$16, %esp
	subl	$12, %esp
	pushl	$1
	call	exit
.L39:
	subl	$8, %esp
	pushl	$4096
	leal	-4125(%ebp), %eax
	pushl	%eax
	call	getcwd
	addl	$16, %esp
	subl	$12, %esp
	leal	-4125(%ebp), %eax
	pushl	%eax
	call	strlen
	addl	$16, %esp
	subl	$1, %eax
	movzbl	-4125(%ebp,%eax), %eax
	cmpb	$47, %al
	je	.L40
	leal	-4125(%ebp), %eax
	movl	$-1, %ecx
	movl	%eax, %edx
	movl	$0, %eax
	movl	%edx, %edi
	repnz; scasb
	movl	%ecx, %eax
	notl	%eax
	leal	-1(%eax), %edx
	leal	-4125(%ebp), %eax
	addl	%edx, %eax
	movw	$47, (%eax)
.L40:
	movl	debug, %eax
	testl	%eax, %eax
	jne	.L41
	movl	stdin, %eax
	subl	$12, %esp
	pushl	%eax
	call	fclose
	addl	$16, %esp
	movl	stdout, %eax
	cmpl	%eax, -4424(%ebp)
	je	.L42
	movl	stdout, %eax
	subl	$12, %esp
	pushl	%eax
	call	fclose
	addl	$16, %esp
.L42:
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
	jns	.L43
	subl	$8, %esp
	pushl	$.LC20
	pushl	$2
	call	syslog
	addl	$16, %esp
	subl	$12, %esp
	pushl	$1
	call	exit
.L41:
	call	setsid
.L43:
	movl	pidfile, %eax
	testl	%eax, %eax
	je	.L44
	movl	pidfile, %eax
	subl	$8, %esp
	pushl	$.LC21
	pushl	%eax
	call	fopen
	addl	$16, %esp
	movl	%eax, -4408(%ebp)
	cmpl	$0, -4408(%ebp)
	jne	.L45
	movl	pidfile, %eax
	subl	$4, %esp
	pushl	%eax
	pushl	$.LC13
	pushl	$2
	call	syslog
	addl	$16, %esp
	subl	$12, %esp
	pushl	$1
	call	exit
.L45:
	call	getpid
	subl	$4, %esp
	pushl	%eax
	pushl	$.LC22
	pushl	-4408(%ebp)
	call	fprintf
	addl	$16, %esp
	subl	$12, %esp
	pushl	-4408(%ebp)
	call	fclose
	addl	$16, %esp
.L44:
	call	fdwatch_get_nfiles
	movl	%eax, max_connects
	movl	max_connects, %eax
	testl	%eax, %eax
	jns	.L46
	subl	$8, %esp
	pushl	$.LC23
	pushl	$2
	call	syslog
	addl	$16, %esp
	subl	$12, %esp
	pushl	$1
	call	exit
.L46:
	movl	max_connects, %eax
	subl	$10, %eax
	movl	%eax, max_connects
	movl	do_chroot, %eax
	testl	%eax, %eax
	je	.L47
	subl	$12, %esp
	leal	-4125(%ebp), %eax
	pushl	%eax
	call	chroot
	addl	$16, %esp
	testl	%eax, %eax
	jns	.L48
	subl	$8, %esp
	pushl	$.LC24
	pushl	$2
	call	syslog
	addl	$16, %esp
	subl	$12, %esp
	pushl	$.LC25
	call	perror
	addl	$16, %esp
	subl	$12, %esp
	pushl	$1
	call	exit
.L48:
	movl	logfile, %eax
	testl	%eax, %eax
	je	.L49
	movl	logfile, %eax
	subl	$8, %esp
	pushl	$.LC4
	pushl	%eax
	call	strcmp
	addl	$16, %esp
	testl	%eax, %eax
	je	.L49
	subl	$12, %esp
	leal	-4125(%ebp), %eax
	pushl	%eax
	call	strlen
	addl	$16, %esp
	movl	%eax, %edx
	movl	logfile, %eax
	subl	$4, %esp
	pushl	%edx
	leal	-4125(%ebp), %edx
	pushl	%edx
	pushl	%eax
	call	strncmp
	addl	$16, %esp
	testl	%eax, %eax
	jne	.L50
	movl	logfile, %ebx
	subl	$12, %esp
	leal	-4125(%ebp), %eax
	pushl	%eax
	call	strlen
	addl	$16, %esp
	subl	$1, %eax
	leal	(%ebx,%eax), %edx
	movl	logfile, %eax
	subl	$8, %esp
	pushl	%edx
	pushl	%eax
	call	strcpy
	addl	$16, %esp
	jmp	.L49
.L50:
	subl	$8, %esp
	pushl	$.LC26
	pushl	$4
	call	syslog
	addl	$16, %esp
	movl	argv0, %edx
	movl	stderr, %eax
	subl	$4, %esp
	pushl	%edx
	pushl	$.LC27
	pushl	%eax
	call	fprintf
	addl	$16, %esp
.L49:
	leal	-4125(%ebp), %eax
	movw	$47, (%eax)
	subl	$12, %esp
	leal	-4125(%ebp), %eax
	pushl	%eax
	call	chdir
	addl	$16, %esp
	testl	%eax, %eax
	jns	.L47
	subl	$8, %esp
	pushl	$.LC28
	pushl	$2
	call	syslog
	addl	$16, %esp
	subl	$12, %esp
	pushl	$.LC29
	call	perror
	addl	$16, %esp
	subl	$12, %esp
	pushl	$1
	call	exit
.L47:
	movl	data_dir, %eax
	testl	%eax, %eax
	je	.L51
	movl	data_dir, %eax
	subl	$12, %esp
	pushl	%eax
	call	chdir
	addl	$16, %esp
	testl	%eax, %eax
	jns	.L51
	subl	$8, %esp
	pushl	$.LC30
	pushl	$2
	call	syslog
	addl	$16, %esp
	subl	$12, %esp
	pushl	$.LC31
	call	perror
	addl	$16, %esp
	subl	$12, %esp
	pushl	$1
	call	exit
.L51:
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
	movl	%eax, -4464(%ebp)
	movl	do_global_passwd, %eax
	movl	%eax, -4468(%ebp)
	movl	do_vhost, %eax
	movl	%eax, -4472(%ebp)
	movl	no_symlink_check, %eax
	movl	%eax, -4476(%ebp)
	movl	no_log, %eax
	movl	%eax, -4480(%ebp)
	movl	max_age, %eax
	movl	%eax, -4484(%ebp)
	movl	p3p, %eax
	movl	%eax, -4488(%ebp)
	movl	charset, %eax
	movl	%eax, -4492(%ebp)
	movl	cgi_limit, %eax
	movl	%eax, -4496(%ebp)
	movl	cgi_pattern, %eax
	movl	%eax, -4500(%ebp)
	movzwl	port, %eax
	movzwl	%ax, %eax
	movl	%eax, -4504(%ebp)
	movl	-4440(%ebp), %eax
	testl	%eax, %eax
	je	.L52
	leal	-4256(%ebp), %ebx
	jmp	.L53
.L52:
	movl	$0, %ebx
.L53:
	movl	-4444(%ebp), %eax
	testl	%eax, %eax
	je	.L54
	leal	-4384(%ebp), %ecx
	jmp	.L55
.L54:
	movl	$0, %ecx
.L55:
	movl	hostname, %edx
	subl	$8, %esp
	pushl	%esi
	pushl	%edi
	pushl	-4464(%ebp)
	pushl	-4468(%ebp)
	pushl	-4472(%ebp)
	pushl	-4476(%ebp)
	pushl	-4424(%ebp)
	pushl	-4480(%ebp)
	leal	-4125(%ebp), %eax
	pushl	%eax
	pushl	-4484(%ebp)
	pushl	-4488(%ebp)
	pushl	-4492(%ebp)
	pushl	-4496(%ebp)
	pushl	-4500(%ebp)
	pushl	-4504(%ebp)
	pushl	%ebx
	pushl	%ecx
	pushl	%edx
	call	httpd_initialize
	addl	$80, %esp
	movl	%eax, hs
	movl	hs, %eax
	testl	%eax, %eax
	jne	.L56
	subl	$12, %esp
	pushl	$1
	call	exit
.L56:
	subl	$12, %esp
	pushl	$1
	pushl	$120000
	pushl	JunkClientData
	pushl	$occasional
	pushl	$0
	call	tmr_create
	addl	$32, %esp
	testl	%eax, %eax
	jne	.L57
	subl	$8, %esp
	pushl	$.LC32
	pushl	$2
	call	syslog
	addl	$16, %esp
	subl	$12, %esp
	pushl	$1
	call	exit
.L57:
	subl	$12, %esp
	pushl	$1
	pushl	$5000
	pushl	JunkClientData
	pushl	$idle
	pushl	$0
	call	tmr_create
	addl	$32, %esp
	testl	%eax, %eax
	jne	.L58
	subl	$8, %esp
	pushl	$.LC33
	pushl	$2
	call	syslog
	addl	$16, %esp
	subl	$12, %esp
	pushl	$1
	call	exit
.L58:
	movl	numthrottles, %eax
	testl	%eax, %eax
	jle	.L59
	subl	$12, %esp
	pushl	$1
	pushl	$2000
	pushl	JunkClientData
	pushl	$update_throttles
	pushl	$0
	call	tmr_create
	addl	$32, %esp
	testl	%eax, %eax
	jne	.L59
	subl	$8, %esp
	pushl	$.LC34
	pushl	$2
	call	syslog
	addl	$16, %esp
	subl	$12, %esp
	pushl	$1
	call	exit
.L59:
	subl	$12, %esp
	pushl	$1
	pushl	$3600000
	pushl	JunkClientData
	pushl	$show_stats
	pushl	$0
	call	tmr_create
	addl	$32, %esp
	testl	%eax, %eax
	jne	.L60
	subl	$8, %esp
	pushl	$.LC35
	pushl	$2
	call	syslog
	addl	$16, %esp
	subl	$12, %esp
	pushl	$1
	call	exit
.L60:
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
	jne	.L61
	subl	$8, %esp
	pushl	$0
	pushl	$0
	call	setgroups
	addl	$16, %esp
	testl	%eax, %eax
	jns	.L62
	subl	$8, %esp
	pushl	$.LC36
	pushl	$2
	call	syslog
	addl	$16, %esp
	subl	$12, %esp
	pushl	$1
	call	exit
.L62:
	subl	$12, %esp
	pushl	-4428(%ebp)
	call	setgid
	addl	$16, %esp
	testl	%eax, %eax
	jns	.L63
	subl	$8, %esp
	pushl	$.LC37
	pushl	$2
	call	syslog
	addl	$16, %esp
	subl	$12, %esp
	pushl	$1
	call	exit
.L63:
	movl	user, %eax
	subl	$8, %esp
	pushl	-4428(%ebp)
	pushl	%eax
	call	initgroups
	addl	$16, %esp
	testl	%eax, %eax
	jns	.L64
	subl	$8, %esp
	pushl	$.LC38
	pushl	$4
	call	syslog
	addl	$16, %esp
.L64:
	subl	$12, %esp
	pushl	-4432(%ebp)
	call	setuid
	addl	$16, %esp
	testl	%eax, %eax
	jns	.L65
	subl	$8, %esp
	pushl	$.LC39
	pushl	$2
	call	syslog
	addl	$16, %esp
	subl	$12, %esp
	pushl	$1
	call	exit
.L65:
	movl	do_chroot, %eax
	testl	%eax, %eax
	jne	.L61
	subl	$8, %esp
	pushl	$.LC40
	pushl	$4
	call	syslog
	addl	$16, %esp
.L61:
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
	jne	.L66
	subl	$8, %esp
	pushl	$.LC41
	pushl	$2
	call	syslog
	addl	$16, %esp
	subl	$12, %esp
	pushl	$1
	call	exit
.L66:
	movl	$0, -4420(%ebp)
	jmp	.L67
.L68:
	movl	connects, %ecx
	movl	-4420(%ebp), %edx
	movl	%edx, %eax
	addl	%eax, %eax
	addl	%edx, %eax
	sall	$5, %eax
	addl	%ecx, %eax
	movl	$0, (%eax)
	movl	connects, %ecx
	movl	-4420(%ebp), %edx
	movl	%edx, %eax
	addl	%eax, %eax
	addl	%edx, %eax
	sall	$5, %eax
	addl	%ecx, %eax
	movl	-4420(%ebp), %edx
	addl	$1, %edx
	movl	%edx, 4(%eax)
	movl	connects, %ecx
	movl	-4420(%ebp), %edx
	movl	%edx, %eax
	addl	%eax, %eax
	addl	%edx, %eax
	sall	$5, %eax
	addl	%ecx, %eax
	movl	$0, 8(%eax)
	addl	$1, -4420(%ebp)
.L67:
	movl	max_connects, %eax
	cmpl	%eax, -4420(%ebp)
	jl	.L68
	movl	connects, %edx
	movl	max_connects, %eax
	movl	%eax, %ecx
	movl	%ecx, %eax
	addl	%eax, %eax
	addl	%ecx, %eax
	sall	$5, %eax
	subl	$96, %eax
	addl	%edx, %eax
	movl	$-1, 4(%eax)
	movl	$0, first_free_connect
	movl	$0, num_connects
	movl	$0, httpd_conn_count
	movl	hs, %eax
	testl	%eax, %eax
	je	.L69
	movl	hs, %eax
	movl	40(%eax), %eax
	cmpl	$-1, %eax
	je	.L70
	movl	hs, %eax
	movl	40(%eax), %eax
	subl	$4, %esp
	pushl	$0
	pushl	$0
	pushl	%eax
	call	fdwatch_add_fd
	addl	$16, %esp
.L70:
	movl	hs, %eax
	movl	44(%eax), %eax
	cmpl	$-1, %eax
	je	.L69
	movl	hs, %eax
	movl	44(%eax), %eax
	subl	$4, %esp
	pushl	$0
	pushl	$0
	pushl	%eax
	call	fdwatch_add_fd
	addl	$16, %esp
.L69:
	subl	$12, %esp
	leal	-4392(%ebp), %eax
	pushl	%eax
	call	tmr_prepare_timeval
	addl	$16, %esp
	jmp	.L71
.L88:
	movl	got_hup, %eax
	testl	%eax, %eax
	je	.L72
	call	re_open_logfile
	movl	$0, got_hup
.L72:
	subl	$12, %esp
	leal	-4392(%ebp), %eax
	pushl	%eax
	call	tmr_mstimeout
	addl	$16, %esp
	subl	$12, %esp
	pushl	%eax
	call	fdwatch
	addl	$16, %esp
	movl	%eax, -4404(%ebp)
	cmpl	$0, -4404(%ebp)
	jns	.L73
	call	__errno_location
	movl	(%eax), %eax
	cmpl	$4, %eax
	je	.L74
	call	__errno_location
	movl	(%eax), %eax
	cmpl	$11, %eax
	jne	.L75
.L74:
	jmp	.L71
.L75:
	subl	$8, %esp
	pushl	$.LC42
	pushl	$3
	call	syslog
	addl	$16, %esp
	subl	$12, %esp
	pushl	$1
	call	exit
.L73:
	subl	$12, %esp
	leal	-4392(%ebp), %eax
	pushl	%eax
	call	tmr_prepare_timeval
	addl	$16, %esp
	cmpl	$0, -4404(%ebp)
	jne	.L76
	subl	$12, %esp
	leal	-4392(%ebp), %eax
	pushl	%eax
	call	tmr_run
	addl	$16, %esp
	jmp	.L71
.L76:
	movl	hs, %eax
	testl	%eax, %eax
	je	.L77
	movl	hs, %eax
	movl	44(%eax), %eax
	cmpl	$-1, %eax
	je	.L77
	movl	hs, %eax
	movl	44(%eax), %eax
	subl	$12, %esp
	pushl	%eax
	call	fdwatch_check_fd
	addl	$16, %esp
	testl	%eax, %eax
	je	.L77
	movl	hs, %eax
	movl	44(%eax), %eax
	subl	$8, %esp
	pushl	%eax
	leal	-4392(%ebp), %eax
	pushl	%eax
	call	handle_newconnect
	addl	$16, %esp
	testl	%eax, %eax
	je	.L77
	jmp	.L71
.L77:
	movl	hs, %eax
	testl	%eax, %eax
	je	.L78
	movl	hs, %eax
	movl	40(%eax), %eax
	cmpl	$-1, %eax
	je	.L78
	movl	hs, %eax
	movl	40(%eax), %eax
	subl	$12, %esp
	pushl	%eax
	call	fdwatch_check_fd
	addl	$16, %esp
	testl	%eax, %eax
	je	.L78
	movl	hs, %eax
	movl	40(%eax), %eax
	subl	$8, %esp
	pushl	%eax
	leal	-4392(%ebp), %eax
	pushl	%eax
	call	handle_newconnect
	addl	$16, %esp
	testl	%eax, %eax
	je	.L78
	jmp	.L71
.L78:
	jmp	.L79
.L85:
	cmpl	$0, -4400(%ebp)
	jne	.L80
	jmp	.L79
.L80:
	movl	-4400(%ebp), %eax
	movl	8(%eax), %eax
	movl	%eax, -4396(%ebp)
	movl	-4396(%ebp), %eax
	movl	448(%eax), %eax
	subl	$12, %esp
	pushl	%eax
	call	fdwatch_check_fd
	addl	$16, %esp
	testl	%eax, %eax
	jne	.L81
	subl	$8, %esp
	leal	-4392(%ebp), %eax
	pushl	%eax
	pushl	-4400(%ebp)
	call	clear_connection
	addl	$16, %esp
	jmp	.L79
.L81:
	movl	-4400(%ebp), %eax
	movl	(%eax), %eax
	cmpl	$2, %eax
	je	.L82
	cmpl	$4, %eax
	je	.L83
	cmpl	$1, %eax
	je	.L84
	jmp	.L79
.L84:
	subl	$8, %esp
	leal	-4392(%ebp), %eax
	pushl	%eax
	pushl	-4400(%ebp)
	call	handle_read
	addl	$16, %esp
	jmp	.L79
.L82:
	subl	$8, %esp
	leal	-4392(%ebp), %eax
	pushl	%eax
	pushl	-4400(%ebp)
	call	handle_send
	addl	$16, %esp
	jmp	.L79
.L83:
	subl	$8, %esp
	leal	-4392(%ebp), %eax
	pushl	%eax
	pushl	-4400(%ebp)
	call	handle_linger
	addl	$16, %esp
	nop
.L79:
	call	fdwatch_get_next_client_data
	movl	%eax, -4400(%ebp)
	cmpl	$-1, -4400(%ebp)
	jne	.L85
	subl	$12, %esp
	leal	-4392(%ebp), %eax
	pushl	%eax
	call	tmr_run
	addl	$16, %esp
	movl	got_usr1, %eax
	testl	%eax, %eax
	je	.L71
	movl	terminate, %eax
	testl	%eax, %eax
	jne	.L71
	movl	$1, terminate
	movl	hs, %eax
	testl	%eax, %eax
	je	.L71
	movl	hs, %eax
	movl	40(%eax), %eax
	cmpl	$-1, %eax
	je	.L86
	movl	hs, %eax
	movl	40(%eax), %eax
	subl	$12, %esp
	pushl	%eax
	call	fdwatch_del_fd
	addl	$16, %esp
.L86:
	movl	hs, %eax
	movl	44(%eax), %eax
	cmpl	$-1, %eax
	je	.L87
	movl	hs, %eax
	movl	44(%eax), %eax
	subl	$12, %esp
	pushl	%eax
	call	fdwatch_del_fd
	addl	$16, %esp
.L87:
	movl	hs, %eax
	subl	$12, %esp
	pushl	%eax
	call	httpd_unlisten
	addl	$16, %esp
.L71:
	movl	terminate, %eax
	testl	%eax, %eax
	je	.L88
	movl	num_connects, %eax
	testl	%eax, %eax
	jg	.L88
	call	shut_down
	subl	$8, %esp
	pushl	$.LC2
	pushl	$5
	call	syslog
	addl	$16, %esp
	call	closelog
	subl	$12, %esp
	pushl	$0
	call	exit
	.size	main, .-main
	.section	.rodata
.LC43:
	.string	"nobody"
.LC44:
	.string	"iso-8859-1"
.LC45:
	.string	""
.LC46:
	.string	"-V"
.LC47:
	.string	"thttpd/2.27.0 Oct 3, 2014"
.LC48:
	.string	"-C"
.LC49:
	.string	"-p"
.LC50:
	.string	"-d"
.LC51:
	.string	"-r"
.LC52:
	.string	"-nor"
.LC53:
	.string	"-dd"
.LC54:
	.string	"-s"
.LC55:
	.string	"-nos"
.LC56:
	.string	"-u"
.LC57:
	.string	"-c"
.LC58:
	.string	"-t"
.LC59:
	.string	"-h"
.LC60:
	.string	"-l"
.LC61:
	.string	"-v"
.LC62:
	.string	"-nov"
.LC63:
	.string	"-g"
.LC64:
	.string	"-nog"
.LC65:
	.string	"-i"
.LC66:
	.string	"-T"
.LC67:
	.string	"-P"
.LC68:
	.string	"-M"
.LC69:
	.string	"-D"
	.text
	.type	parse_args, @function
parse_args:
	pushl	%ebp
	movl	%esp, %ebp
	subl	$24, %esp
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
	movl	$.LC43, user
	movl	$.LC44, charset
	movl	$.LC45, p3p
	movl	$-1, max_age
	movl	$1, -12(%ebp)
	jmp	.L91
.L117:
	movl	-12(%ebp), %eax
	leal	0(,%eax,4), %edx
	movl	12(%ebp), %eax
	addl	%edx, %eax
	movl	(%eax), %eax
	subl	$8, %esp
	pushl	$.LC46
	pushl	%eax
	call	strcmp
	addl	$16, %esp
	testl	%eax, %eax
	jne	.L92
	subl	$12, %esp
	pushl	$.LC47
	call	puts
	addl	$16, %esp
	subl	$12, %esp
	pushl	$0
	call	exit
.L92:
	movl	-12(%ebp), %eax
	leal	0(,%eax,4), %edx
	movl	12(%ebp), %eax
	addl	%edx, %eax
	movl	(%eax), %eax
	subl	$8, %esp
	pushl	$.LC48
	pushl	%eax
	call	strcmp
	addl	$16, %esp
	testl	%eax, %eax
	jne	.L93
	movl	-12(%ebp), %eax
	addl	$1, %eax
	cmpl	8(%ebp), %eax
	jge	.L93
	addl	$1, -12(%ebp)
	movl	-12(%ebp), %eax
	leal	0(,%eax,4), %edx
	movl	12(%ebp), %eax
	addl	%edx, %eax
	movl	(%eax), %eax
	subl	$12, %esp
	pushl	%eax
	call	read_config
	addl	$16, %esp
	jmp	.L94
.L93:
	movl	-12(%ebp), %eax
	leal	0(,%eax,4), %edx
	movl	12(%ebp), %eax
	addl	%edx, %eax
	movl	(%eax), %eax
	subl	$8, %esp
	pushl	$.LC49
	pushl	%eax
	call	strcmp
	addl	$16, %esp
	testl	%eax, %eax
	jne	.L95
	movl	-12(%ebp), %eax
	addl	$1, %eax
	cmpl	8(%ebp), %eax
	jge	.L95
	addl	$1, -12(%ebp)
	movl	-12(%ebp), %eax
	leal	0(,%eax,4), %edx
	movl	12(%ebp), %eax
	addl	%edx, %eax
	movl	(%eax), %eax
	subl	$12, %esp
	pushl	%eax
	call	atoi
	addl	$16, %esp
	movw	%ax, port
	jmp	.L94
.L95:
	movl	-12(%ebp), %eax
	leal	0(,%eax,4), %edx
	movl	12(%ebp), %eax
	addl	%edx, %eax
	movl	(%eax), %eax
	subl	$8, %esp
	pushl	$.LC50
	pushl	%eax
	call	strcmp
	addl	$16, %esp
	testl	%eax, %eax
	jne	.L96
	movl	-12(%ebp), %eax
	addl	$1, %eax
	cmpl	8(%ebp), %eax
	jge	.L96
	addl	$1, -12(%ebp)
	movl	-12(%ebp), %eax
	leal	0(,%eax,4), %edx
	movl	12(%ebp), %eax
	addl	%edx, %eax
	movl	(%eax), %eax
	movl	%eax, dir
	jmp	.L94
.L96:
	movl	-12(%ebp), %eax
	leal	0(,%eax,4), %edx
	movl	12(%ebp), %eax
	addl	%edx, %eax
	movl	(%eax), %eax
	subl	$8, %esp
	pushl	$.LC51
	pushl	%eax
	call	strcmp
	addl	$16, %esp
	testl	%eax, %eax
	jne	.L97
	movl	$1, do_chroot
	movl	$1, no_symlink_check
	jmp	.L94
.L97:
	movl	-12(%ebp), %eax
	leal	0(,%eax,4), %edx
	movl	12(%ebp), %eax
	addl	%edx, %eax
	movl	(%eax), %eax
	subl	$8, %esp
	pushl	$.LC52
	pushl	%eax
	call	strcmp
	addl	$16, %esp
	testl	%eax, %eax
	jne	.L98
	movl	$0, do_chroot
	movl	$0, no_symlink_check
	jmp	.L94
.L98:
	movl	-12(%ebp), %eax
	leal	0(,%eax,4), %edx
	movl	12(%ebp), %eax
	addl	%edx, %eax
	movl	(%eax), %eax
	subl	$8, %esp
	pushl	$.LC53
	pushl	%eax
	call	strcmp
	addl	$16, %esp
	testl	%eax, %eax
	jne	.L99
	movl	-12(%ebp), %eax
	addl	$1, %eax
	cmpl	8(%ebp), %eax
	jge	.L99
	addl	$1, -12(%ebp)
	movl	-12(%ebp), %eax
	leal	0(,%eax,4), %edx
	movl	12(%ebp), %eax
	addl	%edx, %eax
	movl	(%eax), %eax
	movl	%eax, data_dir
	jmp	.L94
.L99:
	movl	-12(%ebp), %eax
	leal	0(,%eax,4), %edx
	movl	12(%ebp), %eax
	addl	%edx, %eax
	movl	(%eax), %eax
	subl	$8, %esp
	pushl	$.LC54
	pushl	%eax
	call	strcmp
	addl	$16, %esp
	testl	%eax, %eax
	jne	.L100
	movl	$0, no_symlink_check
	jmp	.L94
.L100:
	movl	-12(%ebp), %eax
	leal	0(,%eax,4), %edx
	movl	12(%ebp), %eax
	addl	%edx, %eax
	movl	(%eax), %eax
	subl	$8, %esp
	pushl	$.LC55
	pushl	%eax
	call	strcmp
	addl	$16, %esp
	testl	%eax, %eax
	jne	.L101
	movl	$1, no_symlink_check
	jmp	.L94
.L101:
	movl	-12(%ebp), %eax
	leal	0(,%eax,4), %edx
	movl	12(%ebp), %eax
	addl	%edx, %eax
	movl	(%eax), %eax
	subl	$8, %esp
	pushl	$.LC56
	pushl	%eax
	call	strcmp
	addl	$16, %esp
	testl	%eax, %eax
	jne	.L102
	movl	-12(%ebp), %eax
	addl	$1, %eax
	cmpl	8(%ebp), %eax
	jge	.L102
	addl	$1, -12(%ebp)
	movl	-12(%ebp), %eax
	leal	0(,%eax,4), %edx
	movl	12(%ebp), %eax
	addl	%edx, %eax
	movl	(%eax), %eax
	movl	%eax, user
	jmp	.L94
.L102:
	movl	-12(%ebp), %eax
	leal	0(,%eax,4), %edx
	movl	12(%ebp), %eax
	addl	%edx, %eax
	movl	(%eax), %eax
	subl	$8, %esp
	pushl	$.LC57
	pushl	%eax
	call	strcmp
	addl	$16, %esp
	testl	%eax, %eax
	jne	.L103
	movl	-12(%ebp), %eax
	addl	$1, %eax
	cmpl	8(%ebp), %eax
	jge	.L103
	addl	$1, -12(%ebp)
	movl	-12(%ebp), %eax
	leal	0(,%eax,4), %edx
	movl	12(%ebp), %eax
	addl	%edx, %eax
	movl	(%eax), %eax
	movl	%eax, cgi_pattern
	jmp	.L94
.L103:
	movl	-12(%ebp), %eax
	leal	0(,%eax,4), %edx
	movl	12(%ebp), %eax
	addl	%edx, %eax
	movl	(%eax), %eax
	subl	$8, %esp
	pushl	$.LC58
	pushl	%eax
	call	strcmp
	addl	$16, %esp
	testl	%eax, %eax
	jne	.L104
	movl	-12(%ebp), %eax
	addl	$1, %eax
	cmpl	8(%ebp), %eax
	jge	.L104
	addl	$1, -12(%ebp)
	movl	-12(%ebp), %eax
	leal	0(,%eax,4), %edx
	movl	12(%ebp), %eax
	addl	%edx, %eax
	movl	(%eax), %eax
	movl	%eax, throttlefile
	jmp	.L94
.L104:
	movl	-12(%ebp), %eax
	leal	0(,%eax,4), %edx
	movl	12(%ebp), %eax
	addl	%edx, %eax
	movl	(%eax), %eax
	subl	$8, %esp
	pushl	$.LC59
	pushl	%eax
	call	strcmp
	addl	$16, %esp
	testl	%eax, %eax
	jne	.L105
	movl	-12(%ebp), %eax
	addl	$1, %eax
	cmpl	8(%ebp), %eax
	jge	.L105
	addl	$1, -12(%ebp)
	movl	-12(%ebp), %eax
	leal	0(,%eax,4), %edx
	movl	12(%ebp), %eax
	addl	%edx, %eax
	movl	(%eax), %eax
	movl	%eax, hostname
	jmp	.L94
.L105:
	movl	-12(%ebp), %eax
	leal	0(,%eax,4), %edx
	movl	12(%ebp), %eax
	addl	%edx, %eax
	movl	(%eax), %eax
	subl	$8, %esp
	pushl	$.LC60
	pushl	%eax
	call	strcmp
	addl	$16, %esp
	testl	%eax, %eax
	jne	.L106
	movl	-12(%ebp), %eax
	addl	$1, %eax
	cmpl	8(%ebp), %eax
	jge	.L106
	addl	$1, -12(%ebp)
	movl	-12(%ebp), %eax
	leal	0(,%eax,4), %edx
	movl	12(%ebp), %eax
	addl	%edx, %eax
	movl	(%eax), %eax
	movl	%eax, logfile
	jmp	.L94
.L106:
	movl	-12(%ebp), %eax
	leal	0(,%eax,4), %edx
	movl	12(%ebp), %eax
	addl	%edx, %eax
	movl	(%eax), %eax
	subl	$8, %esp
	pushl	$.LC61
	pushl	%eax
	call	strcmp
	addl	$16, %esp
	testl	%eax, %eax
	jne	.L107
	movl	$1, do_vhost
	jmp	.L94
.L107:
	movl	-12(%ebp), %eax
	leal	0(,%eax,4), %edx
	movl	12(%ebp), %eax
	addl	%edx, %eax
	movl	(%eax), %eax
	subl	$8, %esp
	pushl	$.LC62
	pushl	%eax
	call	strcmp
	addl	$16, %esp
	testl	%eax, %eax
	jne	.L108
	movl	$0, do_vhost
	jmp	.L94
.L108:
	movl	-12(%ebp), %eax
	leal	0(,%eax,4), %edx
	movl	12(%ebp), %eax
	addl	%edx, %eax
	movl	(%eax), %eax
	subl	$8, %esp
	pushl	$.LC63
	pushl	%eax
	call	strcmp
	addl	$16, %esp
	testl	%eax, %eax
	jne	.L109
	movl	$1, do_global_passwd
	jmp	.L94
.L109:
	movl	-12(%ebp), %eax
	leal	0(,%eax,4), %edx
	movl	12(%ebp), %eax
	addl	%edx, %eax
	movl	(%eax), %eax
	subl	$8, %esp
	pushl	$.LC64
	pushl	%eax
	call	strcmp
	addl	$16, %esp
	testl	%eax, %eax
	jne	.L110
	movl	$0, do_global_passwd
	jmp	.L94
.L110:
	movl	-12(%ebp), %eax
	leal	0(,%eax,4), %edx
	movl	12(%ebp), %eax
	addl	%edx, %eax
	movl	(%eax), %eax
	subl	$8, %esp
	pushl	$.LC65
	pushl	%eax
	call	strcmp
	addl	$16, %esp
	testl	%eax, %eax
	jne	.L111
	movl	-12(%ebp), %eax
	addl	$1, %eax
	cmpl	8(%ebp), %eax
	jge	.L111
	addl	$1, -12(%ebp)
	movl	-12(%ebp), %eax
	leal	0(,%eax,4), %edx
	movl	12(%ebp), %eax
	addl	%edx, %eax
	movl	(%eax), %eax
	movl	%eax, pidfile
	jmp	.L94
.L111:
	movl	-12(%ebp), %eax
	leal	0(,%eax,4), %edx
	movl	12(%ebp), %eax
	addl	%edx, %eax
	movl	(%eax), %eax
	subl	$8, %esp
	pushl	$.LC66
	pushl	%eax
	call	strcmp
	addl	$16, %esp
	testl	%eax, %eax
	jne	.L112
	movl	-12(%ebp), %eax
	addl	$1, %eax
	cmpl	8(%ebp), %eax
	jge	.L112
	addl	$1, -12(%ebp)
	movl	-12(%ebp), %eax
	leal	0(,%eax,4), %edx
	movl	12(%ebp), %eax
	addl	%edx, %eax
	movl	(%eax), %eax
	movl	%eax, charset
	jmp	.L94
.L112:
	movl	-12(%ebp), %eax
	leal	0(,%eax,4), %edx
	movl	12(%ebp), %eax
	addl	%edx, %eax
	movl	(%eax), %eax
	subl	$8, %esp
	pushl	$.LC67
	pushl	%eax
	call	strcmp
	addl	$16, %esp
	testl	%eax, %eax
	jne	.L113
	movl	-12(%ebp), %eax
	addl	$1, %eax
	cmpl	8(%ebp), %eax
	jge	.L113
	addl	$1, -12(%ebp)
	movl	-12(%ebp), %eax
	leal	0(,%eax,4), %edx
	movl	12(%ebp), %eax
	addl	%edx, %eax
	movl	(%eax), %eax
	movl	%eax, p3p
	jmp	.L94
.L113:
	movl	-12(%ebp), %eax
	leal	0(,%eax,4), %edx
	movl	12(%ebp), %eax
	addl	%edx, %eax
	movl	(%eax), %eax
	subl	$8, %esp
	pushl	$.LC68
	pushl	%eax
	call	strcmp
	addl	$16, %esp
	testl	%eax, %eax
	jne	.L114
	movl	-12(%ebp), %eax
	addl	$1, %eax
	cmpl	8(%ebp), %eax
	jge	.L114
	addl	$1, -12(%ebp)
	movl	-12(%ebp), %eax
	leal	0(,%eax,4), %edx
	movl	12(%ebp), %eax
	addl	%edx, %eax
	movl	(%eax), %eax
	subl	$12, %esp
	pushl	%eax
	call	atoi
	addl	$16, %esp
	movl	%eax, max_age
	jmp	.L94
.L114:
	movl	-12(%ebp), %eax
	leal	0(,%eax,4), %edx
	movl	12(%ebp), %eax
	addl	%edx, %eax
	movl	(%eax), %eax
	subl	$8, %esp
	pushl	$.LC69
	pushl	%eax
	call	strcmp
	addl	$16, %esp
	testl	%eax, %eax
	jne	.L115
	movl	$1, debug
	jmp	.L94
.L115:
	call	usage
.L94:
	addl	$1, -12(%ebp)
.L91:
	movl	-12(%ebp), %eax
	cmpl	8(%ebp), %eax
	jge	.L116
	movl	-12(%ebp), %eax
	leal	0(,%eax,4), %edx
	movl	12(%ebp), %eax
	addl	%edx, %eax
	movl	(%eax), %eax
	movzbl	(%eax), %eax
	cmpb	$45, %al
	je	.L117
.L116:
	movl	-12(%ebp), %eax
	cmpl	8(%ebp), %eax
	je	.L90
	call	usage
.L90:
	leave
	ret
	.size	parse_args, .-parse_args
	.section	.rodata
	.align 4
.LC70:
	.string	"usage:  %s [-C configfile] [-p port] [-d dir] [-r|-nor] [-dd data_dir] [-s|-nos] [-v|-nov] [-g|-nog] [-u user] [-c cgipat] [-t throttles] [-h host] [-l logfile] [-i pidfile] [-T charset] [-P P3P] [-M maxage] [-V] [-D]\n"
	.text
	.type	usage, @function
usage:
	pushl	%ebp
	movl	%esp, %ebp
	subl	$8, %esp
	movl	argv0, %edx
	movl	stderr, %eax
	subl	$4, %esp
	pushl	%edx
	pushl	$.LC70
	pushl	%eax
	call	fprintf
	addl	$16, %esp
	subl	$12, %esp
	pushl	$1
	call	exit
	.size	usage, .-usage
	.section	.rodata
.LC71:
	.string	"r"
.LC72:
	.string	" \t\n\r"
.LC73:
	.string	"debug"
.LC74:
	.string	"port"
.LC75:
	.string	"dir"
.LC76:
	.string	"nochroot"
.LC77:
	.string	"data_dir"
.LC78:
	.string	"symlink"
.LC79:
	.string	"nosymlink"
.LC80:
	.string	"symlinks"
.LC81:
	.string	"nosymlinks"
.LC82:
	.string	"user"
.LC83:
	.string	"cgipat"
.LC84:
	.string	"cgilimit"
.LC85:
	.string	"urlpat"
.LC86:
	.string	"noemptyreferers"
.LC87:
	.string	"localpat"
.LC88:
	.string	"throttles"
.LC89:
	.string	"host"
.LC90:
	.string	"logfile"
.LC91:
	.string	"vhost"
.LC92:
	.string	"novhost"
.LC93:
	.string	"globalpasswd"
.LC94:
	.string	"noglobalpasswd"
.LC95:
	.string	"pidfile"
.LC96:
	.string	"charset"
.LC97:
	.string	"p3p"
.LC98:
	.string	"max_age"
	.align 4
.LC99:
	.string	"%s: unknown config option '%s'\n"
	.text
	.type	read_config, @function
read_config:
	pushl	%ebp
	movl	%esp, %ebp
	subl	$152, %esp
	movl	8(%ebp), %eax
	movl	%eax, -140(%ebp)
	movl	%gs:20, %eax
	movl	%eax, -12(%ebp)
	xorl	%eax, %eax
	subl	$8, %esp
	pushl	$.LC71
	pushl	-140(%ebp)
	call	fopen
	addl	$16, %esp
	movl	%eax, -120(%ebp)
	cmpl	$0, -120(%ebp)
	jne	.L121
	subl	$12, %esp
	pushl	-140(%ebp)
	call	perror
	addl	$16, %esp
	subl	$12, %esp
	pushl	$1
	call	exit
.L121:
	jmp	.L122
.L157:
	subl	$8, %esp
	pushl	$35
	leal	-112(%ebp), %eax
	pushl	%eax
	call	strchr
	addl	$16, %esp
	movl	%eax, -132(%ebp)
	cmpl	$0, -132(%ebp)
	je	.L123
	movl	-132(%ebp), %eax
	movb	$0, (%eax)
.L123:
	leal	-112(%ebp), %eax
	movl	%eax, -132(%ebp)
	subl	$8, %esp
	pushl	$.LC72
	pushl	-132(%ebp)
	call	strspn
	addl	$16, %esp
	addl	%eax, -132(%ebp)
	jmp	.L124
.L156:
	subl	$8, %esp
	pushl	$.LC72
	pushl	-132(%ebp)
	call	strcspn
	addl	$16, %esp
	movl	%eax, %edx
	movl	-132(%ebp), %eax
	addl	%edx, %eax
	movl	%eax, -128(%ebp)
	jmp	.L125
.L126:
	movl	-128(%ebp), %eax
	leal	1(%eax), %edx
	movl	%edx, -128(%ebp)
	movb	$0, (%eax)
.L125:
	movl	-128(%ebp), %eax
	movzbl	(%eax), %eax
	cmpb	$32, %al
	je	.L126
	movl	-128(%ebp), %eax
	movzbl	(%eax), %eax
	cmpb	$9, %al
	je	.L126
	movl	-128(%ebp), %eax
	movzbl	(%eax), %eax
	cmpb	$10, %al
	je	.L126
	movl	-128(%ebp), %eax
	movzbl	(%eax), %eax
	cmpb	$13, %al
	je	.L126
	movl	-132(%ebp), %eax
	movl	%eax, -116(%ebp)
	subl	$8, %esp
	pushl	$61
	pushl	-116(%ebp)
	call	strchr
	addl	$16, %esp
	movl	%eax, -124(%ebp)
	cmpl	$0, -124(%ebp)
	je	.L127
	movl	-124(%ebp), %eax
	leal	1(%eax), %edx
	movl	%edx, -124(%ebp)
	movb	$0, (%eax)
.L127:
	subl	$8, %esp
	pushl	$.LC73
	pushl	-116(%ebp)
	call	strcasecmp
	addl	$16, %esp
	testl	%eax, %eax
	jne	.L128
	subl	$8, %esp
	pushl	-124(%ebp)
	pushl	-116(%ebp)
	call	no_value_required
	addl	$16, %esp
	movl	$1, debug
	jmp	.L129
.L128:
	subl	$8, %esp
	pushl	$.LC74
	pushl	-116(%ebp)
	call	strcasecmp
	addl	$16, %esp
	testl	%eax, %eax
	jne	.L130
	subl	$8, %esp
	pushl	-124(%ebp)
	pushl	-116(%ebp)
	call	value_required
	addl	$16, %esp
	subl	$12, %esp
	pushl	-124(%ebp)
	call	atoi
	addl	$16, %esp
	movw	%ax, port
	jmp	.L129
.L130:
	subl	$8, %esp
	pushl	$.LC75
	pushl	-116(%ebp)
	call	strcasecmp
	addl	$16, %esp
	testl	%eax, %eax
	jne	.L131
	subl	$8, %esp
	pushl	-124(%ebp)
	pushl	-116(%ebp)
	call	value_required
	addl	$16, %esp
	subl	$12, %esp
	pushl	-124(%ebp)
	call	e_strdup
	addl	$16, %esp
	movl	%eax, dir
	jmp	.L129
.L131:
	subl	$8, %esp
	pushl	$.LC25
	pushl	-116(%ebp)
	call	strcasecmp
	addl	$16, %esp
	testl	%eax, %eax
	jne	.L132
	subl	$8, %esp
	pushl	-124(%ebp)
	pushl	-116(%ebp)
	call	no_value_required
	addl	$16, %esp
	movl	$1, do_chroot
	movl	$1, no_symlink_check
	jmp	.L129
.L132:
	subl	$8, %esp
	pushl	$.LC76
	pushl	-116(%ebp)
	call	strcasecmp
	addl	$16, %esp
	testl	%eax, %eax
	jne	.L133
	subl	$8, %esp
	pushl	-124(%ebp)
	pushl	-116(%ebp)
	call	no_value_required
	addl	$16, %esp
	movl	$0, do_chroot
	movl	$0, no_symlink_check
	jmp	.L129
.L133:
	subl	$8, %esp
	pushl	$.LC77
	pushl	-116(%ebp)
	call	strcasecmp
	addl	$16, %esp
	testl	%eax, %eax
	jne	.L134
	subl	$8, %esp
	pushl	-124(%ebp)
	pushl	-116(%ebp)
	call	value_required
	addl	$16, %esp
	subl	$12, %esp
	pushl	-124(%ebp)
	call	e_strdup
	addl	$16, %esp
	movl	%eax, data_dir
	jmp	.L129
.L134:
	subl	$8, %esp
	pushl	$.LC78
	pushl	-116(%ebp)
	call	strcasecmp
	addl	$16, %esp
	testl	%eax, %eax
	jne	.L135
	subl	$8, %esp
	pushl	-124(%ebp)
	pushl	-116(%ebp)
	call	no_value_required
	addl	$16, %esp
	movl	$0, no_symlink_check
	jmp	.L129
.L135:
	subl	$8, %esp
	pushl	$.LC79
	pushl	-116(%ebp)
	call	strcasecmp
	addl	$16, %esp
	testl	%eax, %eax
	jne	.L136
	subl	$8, %esp
	pushl	-124(%ebp)
	pushl	-116(%ebp)
	call	no_value_required
	addl	$16, %esp
	movl	$1, no_symlink_check
	jmp	.L129
.L136:
	subl	$8, %esp
	pushl	$.LC80
	pushl	-116(%ebp)
	call	strcasecmp
	addl	$16, %esp
	testl	%eax, %eax
	jne	.L137
	subl	$8, %esp
	pushl	-124(%ebp)
	pushl	-116(%ebp)
	call	no_value_required
	addl	$16, %esp
	movl	$0, no_symlink_check
	jmp	.L129
.L137:
	subl	$8, %esp
	pushl	$.LC81
	pushl	-116(%ebp)
	call	strcasecmp
	addl	$16, %esp
	testl	%eax, %eax
	jne	.L138
	subl	$8, %esp
	pushl	-124(%ebp)
	pushl	-116(%ebp)
	call	no_value_required
	addl	$16, %esp
	movl	$1, no_symlink_check
	jmp	.L129
.L138:
	subl	$8, %esp
	pushl	$.LC82
	pushl	-116(%ebp)
	call	strcasecmp
	addl	$16, %esp
	testl	%eax, %eax
	jne	.L139
	subl	$8, %esp
	pushl	-124(%ebp)
	pushl	-116(%ebp)
	call	value_required
	addl	$16, %esp
	subl	$12, %esp
	pushl	-124(%ebp)
	call	e_strdup
	addl	$16, %esp
	movl	%eax, user
	jmp	.L129
.L139:
	subl	$8, %esp
	pushl	$.LC83
	pushl	-116(%ebp)
	call	strcasecmp
	addl	$16, %esp
	testl	%eax, %eax
	jne	.L140
	subl	$8, %esp
	pushl	-124(%ebp)
	pushl	-116(%ebp)
	call	value_required
	addl	$16, %esp
	subl	$12, %esp
	pushl	-124(%ebp)
	call	e_strdup
	addl	$16, %esp
	movl	%eax, cgi_pattern
	jmp	.L129
.L140:
	subl	$8, %esp
	pushl	$.LC84
	pushl	-116(%ebp)
	call	strcasecmp
	addl	$16, %esp
	testl	%eax, %eax
	jne	.L141
	subl	$8, %esp
	pushl	-124(%ebp)
	pushl	-116(%ebp)
	call	value_required
	addl	$16, %esp
	subl	$12, %esp
	pushl	-124(%ebp)
	call	atoi
	addl	$16, %esp
	movl	%eax, cgi_limit
	jmp	.L129
.L141:
	subl	$8, %esp
	pushl	$.LC85
	pushl	-116(%ebp)
	call	strcasecmp
	addl	$16, %esp
	testl	%eax, %eax
	jne	.L142
	subl	$8, %esp
	pushl	-124(%ebp)
	pushl	-116(%ebp)
	call	value_required
	addl	$16, %esp
	subl	$12, %esp
	pushl	-124(%ebp)
	call	e_strdup
	addl	$16, %esp
	movl	%eax, url_pattern
	jmp	.L129
.L142:
	subl	$8, %esp
	pushl	$.LC86
	pushl	-116(%ebp)
	call	strcasecmp
	addl	$16, %esp
	testl	%eax, %eax
	jne	.L143
	subl	$8, %esp
	pushl	-124(%ebp)
	pushl	-116(%ebp)
	call	no_value_required
	addl	$16, %esp
	movl	$1, no_empty_referers
	jmp	.L129
.L143:
	subl	$8, %esp
	pushl	$.LC87
	pushl	-116(%ebp)
	call	strcasecmp
	addl	$16, %esp
	testl	%eax, %eax
	jne	.L144
	subl	$8, %esp
	pushl	-124(%ebp)
	pushl	-116(%ebp)
	call	value_required
	addl	$16, %esp
	subl	$12, %esp
	pushl	-124(%ebp)
	call	e_strdup
	addl	$16, %esp
	movl	%eax, local_pattern
	jmp	.L129
.L144:
	subl	$8, %esp
	pushl	$.LC88
	pushl	-116(%ebp)
	call	strcasecmp
	addl	$16, %esp
	testl	%eax, %eax
	jne	.L145
	subl	$8, %esp
	pushl	-124(%ebp)
	pushl	-116(%ebp)
	call	value_required
	addl	$16, %esp
	subl	$12, %esp
	pushl	-124(%ebp)
	call	e_strdup
	addl	$16, %esp
	movl	%eax, throttlefile
	jmp	.L129
.L145:
	subl	$8, %esp
	pushl	$.LC89
	pushl	-116(%ebp)
	call	strcasecmp
	addl	$16, %esp
	testl	%eax, %eax
	jne	.L146
	subl	$8, %esp
	pushl	-124(%ebp)
	pushl	-116(%ebp)
	call	value_required
	addl	$16, %esp
	subl	$12, %esp
	pushl	-124(%ebp)
	call	e_strdup
	addl	$16, %esp
	movl	%eax, hostname
	jmp	.L129
.L146:
	subl	$8, %esp
	pushl	$.LC90
	pushl	-116(%ebp)
	call	strcasecmp
	addl	$16, %esp
	testl	%eax, %eax
	jne	.L147
	subl	$8, %esp
	pushl	-124(%ebp)
	pushl	-116(%ebp)
	call	value_required
	addl	$16, %esp
	subl	$12, %esp
	pushl	-124(%ebp)
	call	e_strdup
	addl	$16, %esp
	movl	%eax, logfile
	jmp	.L129
.L147:
	subl	$8, %esp
	pushl	$.LC91
	pushl	-116(%ebp)
	call	strcasecmp
	addl	$16, %esp
	testl	%eax, %eax
	jne	.L148
	subl	$8, %esp
	pushl	-124(%ebp)
	pushl	-116(%ebp)
	call	no_value_required
	addl	$16, %esp
	movl	$1, do_vhost
	jmp	.L129
.L148:
	subl	$8, %esp
	pushl	$.LC92
	pushl	-116(%ebp)
	call	strcasecmp
	addl	$16, %esp
	testl	%eax, %eax
	jne	.L149
	subl	$8, %esp
	pushl	-124(%ebp)
	pushl	-116(%ebp)
	call	no_value_required
	addl	$16, %esp
	movl	$0, do_vhost
	jmp	.L129
.L149:
	subl	$8, %esp
	pushl	$.LC93
	pushl	-116(%ebp)
	call	strcasecmp
	addl	$16, %esp
	testl	%eax, %eax
	jne	.L150
	subl	$8, %esp
	pushl	-124(%ebp)
	pushl	-116(%ebp)
	call	no_value_required
	addl	$16, %esp
	movl	$1, do_global_passwd
	jmp	.L129
.L150:
	subl	$8, %esp
	pushl	$.LC94
	pushl	-116(%ebp)
	call	strcasecmp
	addl	$16, %esp
	testl	%eax, %eax
	jne	.L151
	subl	$8, %esp
	pushl	-124(%ebp)
	pushl	-116(%ebp)
	call	no_value_required
	addl	$16, %esp
	movl	$0, do_global_passwd
	jmp	.L129
.L151:
	subl	$8, %esp
	pushl	$.LC95
	pushl	-116(%ebp)
	call	strcasecmp
	addl	$16, %esp
	testl	%eax, %eax
	jne	.L152
	subl	$8, %esp
	pushl	-124(%ebp)
	pushl	-116(%ebp)
	call	value_required
	addl	$16, %esp
	subl	$12, %esp
	pushl	-124(%ebp)
	call	e_strdup
	addl	$16, %esp
	movl	%eax, pidfile
	jmp	.L129
.L152:
	subl	$8, %esp
	pushl	$.LC96
	pushl	-116(%ebp)
	call	strcasecmp
	addl	$16, %esp
	testl	%eax, %eax
	jne	.L153
	subl	$8, %esp
	pushl	-124(%ebp)
	pushl	-116(%ebp)
	call	value_required
	addl	$16, %esp
	subl	$12, %esp
	pushl	-124(%ebp)
	call	e_strdup
	addl	$16, %esp
	movl	%eax, charset
	jmp	.L129
.L153:
	subl	$8, %esp
	pushl	$.LC97
	pushl	-116(%ebp)
	call	strcasecmp
	addl	$16, %esp
	testl	%eax, %eax
	jne	.L154
	subl	$8, %esp
	pushl	-124(%ebp)
	pushl	-116(%ebp)
	call	value_required
	addl	$16, %esp
	subl	$12, %esp
	pushl	-124(%ebp)
	call	e_strdup
	addl	$16, %esp
	movl	%eax, p3p
	jmp	.L129
.L154:
	subl	$8, %esp
	pushl	$.LC98
	pushl	-116(%ebp)
	call	strcasecmp
	addl	$16, %esp
	testl	%eax, %eax
	jne	.L155
	subl	$8, %esp
	pushl	-124(%ebp)
	pushl	-116(%ebp)
	call	value_required
	addl	$16, %esp
	subl	$12, %esp
	pushl	-124(%ebp)
	call	atoi
	addl	$16, %esp
	movl	%eax, max_age
	jmp	.L129
.L155:
	movl	argv0, %edx
	movl	stderr, %eax
	pushl	-116(%ebp)
	pushl	%edx
	pushl	$.LC99
	pushl	%eax
	call	fprintf
	addl	$16, %esp
	subl	$12, %esp
	pushl	$1
	call	exit
.L129:
	movl	-128(%ebp), %eax
	movl	%eax, -132(%ebp)
	subl	$8, %esp
	pushl	$.LC72
	pushl	-132(%ebp)
	call	strspn
	addl	$16, %esp
	addl	%eax, -132(%ebp)
.L124:
	movl	-132(%ebp), %eax
	movzbl	(%eax), %eax
	testb	%al, %al
	jne	.L156
.L122:
	subl	$4, %esp
	pushl	-120(%ebp)
	pushl	$1000
	leal	-112(%ebp), %eax
	pushl	%eax
	call	fgets
	addl	$16, %esp
	testl	%eax, %eax
	jne	.L157
	subl	$12, %esp
	pushl	-120(%ebp)
	call	fclose
	addl	$16, %esp
	movl	-12(%ebp), %eax
	xorl	%gs:20, %eax
	je	.L158
	call	__stack_chk_fail
.L158:
	leave
	ret
	.size	read_config, .-read_config
	.section	.rodata
	.align 4
.LC100:
	.string	"%s: value required for %s option\n"
	.text
	.type	value_required, @function
value_required:
	pushl	%ebp
	movl	%esp, %ebp
	subl	$8, %esp
	cmpl	$0, 12(%ebp)
	jne	.L159
	movl	argv0, %edx
	movl	stderr, %eax
	pushl	8(%ebp)
	pushl	%edx
	pushl	$.LC100
	pushl	%eax
	call	fprintf
	addl	$16, %esp
	subl	$12, %esp
	pushl	$1
	call	exit
.L159:
	leave
	ret
	.size	value_required, .-value_required
	.section	.rodata
	.align 4
.LC101:
	.string	"%s: no value required for %s option\n"
	.text
	.type	no_value_required, @function
no_value_required:
	pushl	%ebp
	movl	%esp, %ebp
	subl	$8, %esp
	cmpl	$0, 12(%ebp)
	je	.L161
	movl	argv0, %edx
	movl	stderr, %eax
	pushl	8(%ebp)
	pushl	%edx
	pushl	$.LC101
	pushl	%eax
	call	fprintf
	addl	$16, %esp
	subl	$12, %esp
	pushl	$1
	call	exit
.L161:
	leave
	ret
	.size	no_value_required, .-no_value_required
	.section	.rodata
	.align 4
.LC102:
	.string	"out of memory copying a string"
	.align 4
.LC103:
	.string	"%s: out of memory copying a string\n"
	.text
	.type	e_strdup, @function
e_strdup:
	pushl	%ebp
	movl	%esp, %ebp
	subl	$24, %esp
	subl	$12, %esp
	pushl	8(%ebp)
	call	strdup
	addl	$16, %esp
	movl	%eax, -12(%ebp)
	cmpl	$0, -12(%ebp)
	jne	.L164
	subl	$8, %esp
	pushl	$.LC102
	pushl	$2
	call	syslog
	addl	$16, %esp
	movl	argv0, %edx
	movl	stderr, %eax
	subl	$4, %esp
	pushl	%edx
	pushl	$.LC103
	pushl	%eax
	call	fprintf
	addl	$16, %esp
	subl	$12, %esp
	pushl	$1
	call	exit
.L164:
	movl	-12(%ebp), %eax
	leave
	ret
	.size	e_strdup, .-e_strdup
	.section	.rodata
.LC104:
	.string	"%d"
.LC105:
	.string	"getaddrinfo %.80s - %.80s"
.LC106:
	.string	"%s: getaddrinfo %s - %s\n"
	.align 4
.LC107:
	.string	"%.80s - sockaddr too small (%lu < %lu)"
	.text
	.type	lookup_hostname, @function
lookup_hostname:
	pushl	%ebp
	movl	%esp, %ebp
	pushl	%ebx
	subl	$100, %esp
	movl	8(%ebp), %eax
	movl	%eax, -92(%ebp)
	movl	16(%ebp), %eax
	movl	%eax, -96(%ebp)
	movl	20(%ebp), %eax
	movl	%eax, -100(%ebp)
	movl	28(%ebp), %eax
	movl	%eax, -104(%ebp)
	movl	%gs:20, %eax
	movl	%eax, -12(%ebp)
	xorl	%eax, %eax
	subl	$4, %esp
	pushl	$32
	pushl	$0
	leal	-56(%ebp), %eax
	pushl	%eax
	call	memset
	addl	$16, %esp
	movl	$0, -52(%ebp)
	movl	$1, -56(%ebp)
	movl	$1, -48(%ebp)
	movzwl	port, %eax
	movzwl	%ax, %eax
	pushl	%eax
	pushl	$.LC104
	pushl	$10
	leal	-22(%ebp), %eax
	pushl	%eax
	call	snprintf
	addl	$16, %esp
	movl	hostname, %eax
	leal	-76(%ebp), %edx
	pushl	%edx
	leal	-56(%ebp), %edx
	pushl	%edx
	leal	-22(%ebp), %edx
	pushl	%edx
	pushl	%eax
	call	getaddrinfo
	addl	$16, %esp
	movl	%eax, -60(%ebp)
	cmpl	$0, -60(%ebp)
	je	.L167
	subl	$12, %esp
	pushl	-60(%ebp)
	call	gai_strerror
	addl	$16, %esp
	movl	%eax, %edx
	movl	hostname, %eax
	pushl	%edx
	pushl	%eax
	pushl	$.LC105
	pushl	$2
	call	syslog
	addl	$16, %esp
	subl	$12, %esp
	pushl	-60(%ebp)
	call	gai_strerror
	addl	$16, %esp
	movl	%eax, %ebx
	movl	hostname, %ecx
	movl	argv0, %edx
	movl	stderr, %eax
	subl	$12, %esp
	pushl	%ebx
	pushl	%ecx
	pushl	%edx
	pushl	$.LC106
	pushl	%eax
	call	fprintf
	addl	$32, %esp
	subl	$12, %esp
	pushl	$1
	call	exit
.L167:
	movl	$0, -68(%ebp)
	movl	$0, -64(%ebp)
	movl	-76(%ebp), %eax
	movl	%eax, -72(%ebp)
	jmp	.L168
.L174:
	movl	-72(%ebp), %eax
	movl	4(%eax), %eax
	cmpl	$2, %eax
	je	.L170
	cmpl	$10, %eax
	jne	.L169
	cmpl	$0, -68(%ebp)
	jne	.L172
	movl	-72(%ebp), %eax
	movl	%eax, -68(%ebp)
	jmp	.L169
.L172:
	jmp	.L169
.L170:
	cmpl	$0, -64(%ebp)
	jne	.L173
	movl	-72(%ebp), %eax
	movl	%eax, -64(%ebp)
	jmp	.L182
.L173:
.L182:
	nop
.L169:
	movl	-72(%ebp), %eax
	movl	28(%eax), %eax
	movl	%eax, -72(%ebp)
.L168:
	cmpl	$0, -72(%ebp)
	jne	.L174
	cmpl	$0, -68(%ebp)
	jne	.L175
	movl	-104(%ebp), %eax
	movl	$0, (%eax)
	jmp	.L176
.L175:
	movl	-68(%ebp), %eax
	movl	16(%eax), %eax
	cmpl	24(%ebp), %eax
	jbe	.L177
	movl	-68(%ebp), %eax
	movl	16(%eax), %edx
	movl	hostname, %eax
	subl	$12, %esp
	pushl	%edx
	pushl	24(%ebp)
	pushl	%eax
	pushl	$.LC107
	pushl	$2
	call	syslog
	addl	$32, %esp
	subl	$12, %esp
	pushl	$1
	call	exit
.L177:
	subl	$4, %esp
	pushl	24(%ebp)
	pushl	$0
	pushl	-100(%ebp)
	call	memset
	addl	$16, %esp
	movl	-68(%ebp), %eax
	movl	16(%eax), %edx
	movl	-68(%ebp), %eax
	movl	20(%eax), %eax
	subl	$4, %esp
	pushl	%edx
	pushl	%eax
	pushl	-100(%ebp)
	call	memmove
	addl	$16, %esp
	movl	-104(%ebp), %eax
	movl	$1, (%eax)
.L176:
	cmpl	$0, -64(%ebp)
	jne	.L178
	movl	-96(%ebp), %eax
	movl	$0, (%eax)
	jmp	.L179
.L178:
	movl	-64(%ebp), %eax
	movl	16(%eax), %eax
	cmpl	12(%ebp), %eax
	jbe	.L180
	movl	-64(%ebp), %eax
	movl	16(%eax), %edx
	movl	hostname, %eax
	subl	$12, %esp
	pushl	%edx
	pushl	12(%ebp)
	pushl	%eax
	pushl	$.LC107
	pushl	$2
	call	syslog
	addl	$32, %esp
	subl	$12, %esp
	pushl	$1
	call	exit
.L180:
	subl	$4, %esp
	pushl	12(%ebp)
	pushl	$0
	pushl	-92(%ebp)
	call	memset
	addl	$16, %esp
	movl	-64(%ebp), %eax
	movl	16(%eax), %edx
	movl	-64(%ebp), %eax
	movl	20(%eax), %eax
	subl	$4, %esp
	pushl	%edx
	pushl	%eax
	pushl	-92(%ebp)
	call	memmove
	addl	$16, %esp
	movl	-96(%ebp), %eax
	movl	$1, (%eax)
.L179:
	movl	-76(%ebp), %eax
	subl	$12, %esp
	pushl	%eax
	call	freeaddrinfo
	addl	$16, %esp
	movl	-12(%ebp), %eax
	xorl	%gs:20, %eax
	je	.L181
	call	__stack_chk_fail
.L181:
	movl	-4(%ebp), %ebx
	leave
	ret
	.size	lookup_hostname, .-lookup_hostname
	.section	.rodata
.LC108:
	.string	" %4900[^ \t] %ld-%ld"
.LC109:
	.string	" %4900[^ \t] %ld"
	.align 4
.LC110:
	.string	"unparsable line in %.80s - %.80s"
	.align 4
.LC111:
	.string	"%s: unparsable line in %.80s - %.80s\n"
.LC112:
	.string	"|/"
	.align 4
.LC113:
	.string	"out of memory allocating a throttletab"
	.align 4
.LC114:
	.string	"%s: out of memory allocating a throttletab\n"
	.text
	.type	read_throttlefile, @function
read_throttlefile:
	pushl	%ebp
	movl	%esp, %ebp
	pushl	%ebx
	subl	$10052, %esp
	movl	8(%ebp), %eax
	movl	%eax, -10044(%ebp)
	movl	%gs:20, %eax
	movl	%eax, -12(%ebp)
	xorl	%eax, %eax
	subl	$8, %esp
	pushl	$.LC71
	pushl	-10044(%ebp)
	call	fopen
	addl	$16, %esp
	movl	%eax, -10028(%ebp)
	cmpl	$0, -10028(%ebp)
	jne	.L184
	subl	$4, %esp
	pushl	-10044(%ebp)
	pushl	$.LC13
	pushl	$2
	call	syslog
	addl	$16, %esp
	subl	$12, %esp
	pushl	-10044(%ebp)
	call	perror
	addl	$16, %esp
	subl	$12, %esp
	pushl	$1
	call	exit
.L184:
	subl	$8, %esp
	pushl	$0
	leal	-10020(%ebp), %eax
	pushl	%eax
	call	gettimeofday
	addl	$16, %esp
	jmp	.L185
.L199:
	subl	$8, %esp
	pushl	$35
	leal	-10012(%ebp), %eax
	pushl	%eax
	call	strchr
	addl	$16, %esp
	movl	%eax, -10024(%ebp)
	cmpl	$0, -10024(%ebp)
	je	.L186
	movl	-10024(%ebp), %eax
	movb	$0, (%eax)
.L186:
	subl	$12, %esp
	leal	-10012(%ebp), %eax
	pushl	%eax
	call	strlen
	addl	$16, %esp
	movl	%eax, -10032(%ebp)
	jmp	.L187
.L189:
	subl	$1, -10032(%ebp)
	leal	-10012(%ebp), %edx
	movl	-10032(%ebp), %eax
	addl	%edx, %eax
	movb	$0, (%eax)
.L187:
	cmpl	$0, -10032(%ebp)
	jle	.L188
	movl	-10032(%ebp), %eax
	subl	$1, %eax
	movzbl	-10012(%ebp,%eax), %eax
	cmpb	$32, %al
	je	.L189
	movl	-10032(%ebp), %eax
	subl	$1, %eax
	movzbl	-10012(%ebp,%eax), %eax
	cmpb	$9, %al
	je	.L189
	movl	-10032(%ebp), %eax
	subl	$1, %eax
	movzbl	-10012(%ebp,%eax), %eax
	cmpb	$10, %al
	je	.L189
	movl	-10032(%ebp), %eax
	subl	$1, %eax
	movzbl	-10012(%ebp,%eax), %eax
	cmpb	$13, %al
	je	.L189
.L188:
	cmpl	$0, -10032(%ebp)
	jne	.L190
	jmp	.L185
.L190:
	subl	$12, %esp
	leal	-10040(%ebp), %eax
	pushl	%eax
	leal	-10036(%ebp), %eax
	pushl	%eax
	leal	-5012(%ebp), %eax
	pushl	%eax
	pushl	$.LC108
	leal	-10012(%ebp), %eax
	pushl	%eax
	call	__isoc99_sscanf
	addl	$32, %esp
	cmpl	$3, %eax
	je	.L191
	leal	-10040(%ebp), %eax
	pushl	%eax
	leal	-5012(%ebp), %eax
	pushl	%eax
	pushl	$.LC109
	leal	-10012(%ebp), %eax
	pushl	%eax
	call	__isoc99_sscanf
	addl	$16, %esp
	cmpl	$2, %eax
	jne	.L192
	movl	$0, -10036(%ebp)
	jmp	.L191
.L192:
	leal	-10012(%ebp), %eax
	pushl	%eax
	pushl	-10044(%ebp)
	pushl	$.LC110
	pushl	$2
	call	syslog
	addl	$16, %esp
	movl	argv0, %edx
	movl	stderr, %eax
	subl	$12, %esp
	leal	-10012(%ebp), %ecx
	pushl	%ecx
	pushl	-10044(%ebp)
	pushl	%edx
	pushl	$.LC111
	pushl	%eax
	call	fprintf
	addl	$32, %esp
	jmp	.L185
.L191:
	movzbl	-5012(%ebp), %eax
	cmpb	$47, %al
	jne	.L193
	subl	$8, %esp
	leal	-5012(%ebp), %eax
	addl	$1, %eax
	pushl	%eax
	leal	-5012(%ebp), %eax
	pushl	%eax
	call	strcpy
	addl	$16, %esp
.L193:
	jmp	.L194
.L195:
	movl	-10024(%ebp), %eax
	leal	2(%eax), %edx
	movl	-10024(%ebp), %eax
	addl	$1, %eax
	subl	$8, %esp
	pushl	%edx
	pushl	%eax
	call	strcpy
	addl	$16, %esp
.L194:
	subl	$8, %esp
	pushl	$.LC112
	leal	-5012(%ebp), %eax
	pushl	%eax
	call	strstr
	addl	$16, %esp
	movl	%eax, -10024(%ebp)
	cmpl	$0, -10024(%ebp)
	jne	.L195
	movl	numthrottles, %edx
	movl	maxthrottles, %eax
	cmpl	%eax, %edx
	jl	.L196
	movl	maxthrottles, %eax
	testl	%eax, %eax
	jne	.L197
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
	jmp	.L198
.L197:
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
.L198:
	movl	throttles, %eax
	testl	%eax, %eax
	jne	.L196
	subl	$8, %esp
	pushl	$.LC113
	pushl	$2
	call	syslog
	addl	$16, %esp
	movl	argv0, %edx
	movl	stderr, %eax
	subl	$4, %esp
	pushl	%edx
	pushl	$.LC114
	pushl	%eax
	call	fprintf
	addl	$16, %esp
	subl	$12, %esp
	pushl	$1
	call	exit
.L196:
	movl	throttles, %edx
	movl	numthrottles, %eax
	movl	%eax, %ecx
	movl	%ecx, %eax
	addl	%eax, %eax
	addl	%ecx, %eax
	sall	$3, %eax
	leal	(%edx,%eax), %ebx
	subl	$12, %esp
	leal	-5012(%ebp), %eax
	pushl	%eax
	call	e_strdup
	addl	$16, %esp
	movl	%eax, (%ebx)
	movl	throttles, %edx
	movl	numthrottles, %eax
	movl	%eax, %ecx
	movl	%ecx, %eax
	addl	%eax, %eax
	addl	%ecx, %eax
	sall	$3, %eax
	addl	%eax, %edx
	movl	-10040(%ebp), %eax
	movl	%eax, 4(%edx)
	movl	throttles, %edx
	movl	numthrottles, %eax
	movl	%eax, %ecx
	movl	%ecx, %eax
	addl	%eax, %eax
	addl	%ecx, %eax
	sall	$3, %eax
	addl	%eax, %edx
	movl	-10036(%ebp), %eax
	movl	%eax, 8(%edx)
	movl	throttles, %edx
	movl	numthrottles, %eax
	movl	%eax, %ecx
	movl	%ecx, %eax
	addl	%eax, %eax
	addl	%ecx, %eax
	sall	$3, %eax
	addl	%edx, %eax
	movl	$0, 12(%eax)
	movl	throttles, %edx
	movl	numthrottles, %eax
	movl	%eax, %ecx
	movl	%ecx, %eax
	addl	%eax, %eax
	addl	%ecx, %eax
	sall	$3, %eax
	addl	%edx, %eax
	movl	$0, 16(%eax)
	movl	throttles, %edx
	movl	numthrottles, %eax
	movl	%eax, %ecx
	movl	%ecx, %eax
	addl	%eax, %eax
	addl	%ecx, %eax
	sall	$3, %eax
	addl	%edx, %eax
	movl	$0, 20(%eax)
	movl	numthrottles, %eax
	addl	$1, %eax
	movl	%eax, numthrottles
.L185:
	subl	$4, %esp
	pushl	-10028(%ebp)
	pushl	$5000
	leal	-10012(%ebp), %eax
	pushl	%eax
	call	fgets
	addl	$16, %esp
	testl	%eax, %eax
	jne	.L199
	subl	$12, %esp
	pushl	-10028(%ebp)
	call	fclose
	addl	$16, %esp
	movl	-12(%ebp), %eax
	xorl	%gs:20, %eax
	je	.L200
	call	__stack_chk_fail
.L200:
	movl	-4(%ebp), %ebx
	leave
	ret
	.size	read_throttlefile, .-read_throttlefile
	.type	shut_down, @function
shut_down:
	pushl	%ebp
	movl	%esp, %ebp
	subl	$40, %esp
	movl	%gs:20, %eax
	movl	%eax, -12(%ebp)
	xorl	%eax, %eax
	subl	$8, %esp
	pushl	$0
	leal	-20(%ebp), %eax
	pushl	%eax
	call	gettimeofday
	addl	$16, %esp
	subl	$12, %esp
	leal	-20(%ebp), %eax
	pushl	%eax
	call	logstats
	addl	$16, %esp
	movl	$0, -28(%ebp)
	jmp	.L202
.L205:
	movl	connects, %ecx
	movl	-28(%ebp), %edx
	movl	%edx, %eax
	addl	%eax, %eax
	addl	%edx, %eax
	sall	$5, %eax
	addl	%ecx, %eax
	movl	(%eax), %eax
	testl	%eax, %eax
	je	.L203
	movl	connects, %ecx
	movl	-28(%ebp), %edx
	movl	%edx, %eax
	addl	%eax, %eax
	addl	%edx, %eax
	sall	$5, %eax
	addl	%ecx, %eax
	movl	8(%eax), %eax
	subl	$8, %esp
	leal	-20(%ebp), %edx
	pushl	%edx
	pushl	%eax
	call	httpd_close_conn
	addl	$16, %esp
.L203:
	movl	connects, %ecx
	movl	-28(%ebp), %edx
	movl	%edx, %eax
	addl	%eax, %eax
	addl	%edx, %eax
	sall	$5, %eax
	addl	%ecx, %eax
	movl	8(%eax), %eax
	testl	%eax, %eax
	je	.L204
	movl	connects, %ecx
	movl	-28(%ebp), %edx
	movl	%edx, %eax
	addl	%eax, %eax
	addl	%edx, %eax
	sall	$5, %eax
	addl	%ecx, %eax
	movl	8(%eax), %eax
	subl	$12, %esp
	pushl	%eax
	call	httpd_destroy_conn
	addl	$16, %esp
	movl	connects, %ecx
	movl	-28(%ebp), %edx
	movl	%edx, %eax
	addl	%eax, %eax
	addl	%edx, %eax
	sall	$5, %eax
	addl	%ecx, %eax
	movl	8(%eax), %eax
	subl	$12, %esp
	pushl	%eax
	call	free
	addl	$16, %esp
	movl	httpd_conn_count, %eax
	subl	$1, %eax
	movl	%eax, httpd_conn_count
	movl	connects, %ecx
	movl	-28(%ebp), %edx
	movl	%edx, %eax
	addl	%eax, %eax
	addl	%edx, %eax
	sall	$5, %eax
	addl	%ecx, %eax
	movl	$0, 8(%eax)
.L204:
	addl	$1, -28(%ebp)
.L202:
	movl	max_connects, %eax
	cmpl	%eax, -28(%ebp)
	jl	.L205
	movl	hs, %eax
	testl	%eax, %eax
	je	.L206
	movl	hs, %eax
	movl	%eax, -24(%ebp)
	movl	$0, hs
	movl	-24(%ebp), %eax
	movl	40(%eax), %eax
	cmpl	$-1, %eax
	je	.L207
	movl	-24(%ebp), %eax
	movl	40(%eax), %eax
	subl	$12, %esp
	pushl	%eax
	call	fdwatch_del_fd
	addl	$16, %esp
.L207:
	movl	-24(%ebp), %eax
	movl	44(%eax), %eax
	cmpl	$-1, %eax
	je	.L208
	movl	-24(%ebp), %eax
	movl	44(%eax), %eax
	subl	$12, %esp
	pushl	%eax
	call	fdwatch_del_fd
	addl	$16, %esp
.L208:
	subl	$12, %esp
	pushl	-24(%ebp)
	call	httpd_terminate
	addl	$16, %esp
.L206:
	call	mmc_destroy
	call	tmr_destroy
	movl	connects, %eax
	subl	$12, %esp
	pushl	%eax
	call	free
	addl	$16, %esp
	movl	throttles, %eax
	testl	%eax, %eax
	je	.L201
	movl	throttles, %eax
	subl	$12, %esp
	pushl	%eax
	call	free
	addl	$16, %esp
.L201:
	movl	-12(%ebp), %eax
	xorl	%gs:20, %eax
	je	.L210
	call	__stack_chk_fail
.L210:
	leave
	ret
	.size	shut_down, .-shut_down
	.section	.rodata
.LC115:
	.string	"too many connections!"
	.align 4
.LC116:
	.string	"the connects free list is messed up"
	.align 4
.LC117:
	.string	"out of memory allocating an httpd_conn"
	.text
	.type	handle_newconnect, @function
handle_newconnect:
	pushl	%ebp
	movl	%esp, %ebp
	subl	$24, %esp
.L222:
	movl	num_connects, %edx
	movl	max_connects, %eax
	cmpl	%eax, %edx
	jl	.L212
	subl	$8, %esp
	pushl	$.LC115
	pushl	$4
	call	syslog
	addl	$16, %esp
	subl	$12, %esp
	pushl	8(%ebp)
	call	tmr_run
	addl	$16, %esp
	movl	$0, %eax
	jmp	.L223
.L212:
	movl	first_free_connect, %eax
	cmpl	$-1, %eax
	je	.L214
	movl	connects, %edx
	movl	first_free_connect, %eax
	movl	%eax, %ecx
	movl	%ecx, %eax
	addl	%eax, %eax
	addl	%ecx, %eax
	sall	$5, %eax
	addl	%edx, %eax
	movl	(%eax), %eax
	testl	%eax, %eax
	je	.L215
.L214:
	subl	$8, %esp
	pushl	$.LC116
	pushl	$2
	call	syslog
	addl	$16, %esp
	subl	$12, %esp
	pushl	$1
	call	exit
.L215:
	movl	connects, %edx
	movl	first_free_connect, %eax
	movl	%eax, %ecx
	movl	%ecx, %eax
	addl	%eax, %eax
	addl	%ecx, %eax
	sall	$5, %eax
	addl	%edx, %eax
	movl	%eax, -12(%ebp)
	movl	-12(%ebp), %eax
	movl	8(%eax), %eax
	testl	%eax, %eax
	jne	.L216
	subl	$12, %esp
	pushl	$456
	call	malloc
	addl	$16, %esp
	movl	%eax, %edx
	movl	-12(%ebp), %eax
	movl	%edx, 8(%eax)
	movl	-12(%ebp), %eax
	movl	8(%eax), %eax
	testl	%eax, %eax
	jne	.L217
	subl	$8, %esp
	pushl	$.LC117
	pushl	$2
	call	syslog
	addl	$16, %esp
	subl	$12, %esp
	pushl	$1
	call	exit
.L217:
	movl	-12(%ebp), %eax
	movl	8(%eax), %eax
	movl	$0, (%eax)
	movl	httpd_conn_count, %eax
	addl	$1, %eax
	movl	%eax, httpd_conn_count
.L216:
	movl	-12(%ebp), %eax
	movl	8(%eax), %edx
	movl	hs, %eax
	subl	$4, %esp
	pushl	%edx
	pushl	12(%ebp)
	pushl	%eax
	call	httpd_get_conn
	addl	$16, %esp
	testl	%eax, %eax
	je	.L219
	cmpl	$2, %eax
	je	.L220
	jmp	.L224
.L219:
	subl	$12, %esp
	pushl	8(%ebp)
	call	tmr_run
	addl	$16, %esp
	movl	$0, %eax
	jmp	.L223
.L220:
	movl	$1, %eax
	jmp	.L223
.L224:
	movl	-12(%ebp), %eax
	movl	$1, (%eax)
	movl	-12(%ebp), %eax
	movl	4(%eax), %eax
	movl	%eax, first_free_connect
	movl	-12(%ebp), %eax
	movl	$-1, 4(%eax)
	movl	num_connects, %eax
	addl	$1, %eax
	movl	%eax, num_connects
	movl	-12(%ebp), %eax
	movl	%eax, -16(%ebp)
	movl	8(%ebp), %eax
	movl	(%eax), %edx
	movl	-12(%ebp), %eax
	movl	%edx, 68(%eax)
	movl	-12(%ebp), %eax
	movl	$0, 72(%eax)
	movl	-12(%ebp), %eax
	movl	$0, 76(%eax)
	movl	-12(%ebp), %eax
	movl	$0, 92(%eax)
	movl	-12(%ebp), %eax
	movl	$0, 52(%eax)
	movl	-12(%ebp), %eax
	movl	8(%eax), %eax
	movl	448(%eax), %eax
	subl	$12, %esp
	pushl	%eax
	call	httpd_set_ndelay
	addl	$16, %esp
	movl	-12(%ebp), %eax
	movl	8(%eax), %eax
	movl	448(%eax), %eax
	subl	$4, %esp
	pushl	$0
	pushl	-12(%ebp)
	pushl	%eax
	call	fdwatch_add_fd
	addl	$16, %esp
	movl	stats_connections, %eax
	addl	$1, %eax
	movl	%eax, stats_connections
	movl	num_connects, %edx
	movl	stats_simultaneous, %eax
	cmpl	%eax, %edx
	jle	.L221
	movl	num_connects, %eax
	movl	%eax, stats_simultaneous
.L221:
	jmp	.L222
.L223:
	leave
	ret
	.size	handle_newconnect, .-handle_newconnect
	.type	handle_read, @function
handle_read:
	pushl	%ebp
	movl	%esp, %ebp
	pushl	%ebx
	subl	$20, %esp
	movl	8(%ebp), %eax
	movl	8(%eax), %eax
	movl	%eax, -16(%ebp)
	movl	-16(%ebp), %eax
	movl	144(%eax), %edx
	movl	-16(%ebp), %eax
	movl	140(%eax), %eax
	cmpl	%eax, %edx
	jb	.L226
	movl	-16(%ebp), %eax
	movl	140(%eax), %eax
	cmpl	$5000, %eax
	jbe	.L227
	movl	httpd_err400form, %edx
	movl	httpd_err400title, %eax
	subl	$8, %esp
	pushl	$.LC45
	pushl	%edx
	pushl	$.LC45
	pushl	%eax
	pushl	$400
	pushl	-16(%ebp)
	call	httpd_send_err
	addl	$32, %esp
	subl	$8, %esp
	pushl	12(%ebp)
	pushl	8(%ebp)
	call	finish_connection
	addl	$16, %esp
	jmp	.L225
.L227:
	movl	-16(%ebp), %eax
	movl	140(%eax), %eax
	leal	1000(%eax), %ecx
	movl	-16(%ebp), %eax
	leal	140(%eax), %edx
	movl	-16(%ebp), %eax
	addl	$136, %eax
	subl	$4, %esp
	pushl	%ecx
	pushl	%edx
	pushl	%eax
	call	httpd_realloc_str
	addl	$16, %esp
.L226:
	movl	-16(%ebp), %eax
	movl	140(%eax), %edx
	movl	-16(%ebp), %eax
	movl	144(%eax), %eax
	movl	%edx, %ecx
	subl	%eax, %ecx
	movl	-16(%ebp), %eax
	movl	136(%eax), %edx
	movl	-16(%ebp), %eax
	movl	144(%eax), %eax
	addl	%eax, %edx
	movl	-16(%ebp), %eax
	movl	448(%eax), %eax
	subl	$4, %esp
	pushl	%ecx
	pushl	%edx
	pushl	%eax
	call	read
	addl	$16, %esp
	movl	%eax, -12(%ebp)
	cmpl	$0, -12(%ebp)
	jne	.L229
	movl	httpd_err400form, %edx
	movl	httpd_err400title, %eax
	subl	$8, %esp
	pushl	$.LC45
	pushl	%edx
	pushl	$.LC45
	pushl	%eax
	pushl	$400
	pushl	-16(%ebp)
	call	httpd_send_err
	addl	$32, %esp
	subl	$8, %esp
	pushl	12(%ebp)
	pushl	8(%ebp)
	call	finish_connection
	addl	$16, %esp
	jmp	.L225
.L229:
	cmpl	$0, -12(%ebp)
	jns	.L230
	call	__errno_location
	movl	(%eax), %eax
	cmpl	$4, %eax
	je	.L231
	call	__errno_location
	movl	(%eax), %eax
	cmpl	$11, %eax
	je	.L231
	call	__errno_location
	movl	(%eax), %eax
	cmpl	$11, %eax
	jne	.L232
.L231:
	jmp	.L225
.L232:
	movl	httpd_err400form, %edx
	movl	httpd_err400title, %eax
	subl	$8, %esp
	pushl	$.LC45
	pushl	%edx
	pushl	$.LC45
	pushl	%eax
	pushl	$400
	pushl	-16(%ebp)
	call	httpd_send_err
	addl	$32, %esp
	subl	$8, %esp
	pushl	12(%ebp)
	pushl	8(%ebp)
	call	finish_connection
	addl	$16, %esp
	jmp	.L225
.L230:
	movl	-16(%ebp), %eax
	movl	144(%eax), %edx
	movl	-12(%ebp), %eax
	addl	%eax, %edx
	movl	-16(%ebp), %eax
	movl	%edx, 144(%eax)
	movl	12(%ebp), %eax
	movl	(%eax), %edx
	movl	8(%ebp), %eax
	movl	%edx, 68(%eax)
	subl	$12, %esp
	pushl	-16(%ebp)
	call	httpd_got_request
	addl	$16, %esp
	testl	%eax, %eax
	je	.L248
	cmpl	$2, %eax
	jne	.L247
	movl	httpd_err400form, %edx
	movl	httpd_err400title, %eax
	subl	$8, %esp
	pushl	$.LC45
	pushl	%edx
	pushl	$.LC45
	pushl	%eax
	pushl	$400
	pushl	-16(%ebp)
	call	httpd_send_err
	addl	$32, %esp
	subl	$8, %esp
	pushl	12(%ebp)
	pushl	8(%ebp)
	call	finish_connection
	addl	$16, %esp
	jmp	.L225
.L247:
	subl	$12, %esp
	pushl	-16(%ebp)
	call	httpd_parse_request
	addl	$16, %esp
	testl	%eax, %eax
	jns	.L236
	subl	$8, %esp
	pushl	12(%ebp)
	pushl	8(%ebp)
	call	finish_connection
	addl	$16, %esp
	jmp	.L225
.L236:
	subl	$12, %esp
	pushl	8(%ebp)
	call	check_throttles
	addl	$16, %esp
	testl	%eax, %eax
	jne	.L237
	movl	-16(%ebp), %eax
	movl	172(%eax), %ecx
	movl	httpd_err503form, %edx
	movl	httpd_err503title, %eax
	subl	$8, %esp
	pushl	%ecx
	pushl	%edx
	pushl	$.LC45
	pushl	%eax
	pushl	$503
	pushl	-16(%ebp)
	call	httpd_send_err
	addl	$32, %esp
	subl	$8, %esp
	pushl	12(%ebp)
	pushl	8(%ebp)
	call	finish_connection
	addl	$16, %esp
	jmp	.L225
.L237:
	subl	$8, %esp
	pushl	12(%ebp)
	pushl	-16(%ebp)
	call	httpd_start_request
	addl	$16, %esp
	testl	%eax, %eax
	jns	.L238
	subl	$8, %esp
	pushl	12(%ebp)
	pushl	8(%ebp)
	call	finish_connection
	addl	$16, %esp
	jmp	.L225
.L238:
	movl	-16(%ebp), %eax
	movl	336(%eax), %eax
	testl	%eax, %eax
	je	.L239
	movl	-16(%ebp), %eax
	movl	344(%eax), %edx
	movl	8(%ebp), %eax
	movl	%edx, 92(%eax)
	movl	-16(%ebp), %eax
	movl	348(%eax), %eax
	leal	1(%eax), %edx
	movl	8(%ebp), %eax
	movl	%edx, 88(%eax)
	jmp	.L240
.L239:
	movl	-16(%ebp), %eax
	movl	164(%eax), %eax
	testl	%eax, %eax
	jns	.L241
	movl	8(%ebp), %eax
	movl	$0, 88(%eax)
	jmp	.L240
.L241:
	movl	-16(%ebp), %eax
	movl	164(%eax), %edx
	movl	8(%ebp), %eax
	movl	%edx, 88(%eax)
.L240:
	movl	-16(%ebp), %eax
	movl	452(%eax), %eax
	testl	%eax, %eax
	jne	.L242
	movl	$0, -20(%ebp)
	jmp	.L243
.L244:
	movl	throttles, %ecx
	movl	8(%ebp), %eax
	movl	-20(%ebp), %edx
	movl	12(%eax,%edx,4), %eax
	movl	%eax, %edx
	movl	%edx, %eax
	addl	%eax, %eax
	addl	%edx, %eax
	sall	$3, %eax
	addl	%eax, %ecx
	movl	throttles, %ebx
	movl	8(%ebp), %eax
	movl	-20(%ebp), %edx
	movl	12(%eax,%edx,4), %eax
	movl	%eax, %edx
	movl	%edx, %eax
	addl	%eax, %eax
	addl	%edx, %eax
	sall	$3, %eax
	addl	%ebx, %eax
	movl	16(%eax), %edx
	movl	-16(%ebp), %eax
	movl	168(%eax), %eax
	addl	%edx, %eax
	movl	%eax, 16(%ecx)
	addl	$1, -20(%ebp)
.L243:
	movl	8(%ebp), %eax
	movl	52(%eax), %eax
	cmpl	-20(%ebp), %eax
	jg	.L244
	movl	-16(%ebp), %eax
	movl	168(%eax), %edx
	movl	8(%ebp), %eax
	movl	%edx, 92(%eax)
	subl	$8, %esp
	pushl	12(%ebp)
	pushl	8(%ebp)
	call	finish_connection
	addl	$16, %esp
	jmp	.L225
.L242:
	movl	8(%ebp), %eax
	movl	92(%eax), %edx
	movl	8(%ebp), %eax
	movl	88(%eax), %eax
	cmpl	%eax, %edx
	jl	.L245
	subl	$8, %esp
	pushl	12(%ebp)
	pushl	8(%ebp)
	call	finish_connection
	addl	$16, %esp
	jmp	.L225
.L245:
	movl	8(%ebp), %eax
	movl	$2, (%eax)
	movl	12(%ebp), %eax
	movl	(%eax), %edx
	movl	8(%ebp), %eax
	movl	%edx, 64(%eax)
	movl	8(%ebp), %eax
	movl	$0, 80(%eax)
	movl	8(%ebp), %eax
	movl	%eax, -24(%ebp)
	movl	-16(%ebp), %eax
	movl	448(%eax), %eax
	subl	$12, %esp
	pushl	%eax
	call	fdwatch_del_fd
	addl	$16, %esp
	movl	-16(%ebp), %eax
	movl	448(%eax), %eax
	subl	$4, %esp
	pushl	$1
	pushl	8(%ebp)
	pushl	%eax
	call	fdwatch_add_fd
	addl	$16, %esp
	jmp	.L225
.L248:
	nop
.L225:
	movl	-4(%ebp), %ebx
	leave
	ret
	.size	handle_read, .-handle_read
	.section	.rodata
	.align 4
.LC118:
	.string	"replacing non-null wakeup_timer!"
	.align 4
.LC119:
	.string	"tmr_create(wakeup_connection) failed"
.LC120:
	.string	"write - %m sending %.80s"
	.text
	.type	handle_send, @function
handle_send:
	pushl	%ebp
	movl	%esp, %ebp
	pushl	%ebx
	subl	$84, %esp
	movl	8(%ebp), %eax
	movl	%eax, -76(%ebp)
	movl	12(%ebp), %eax
	movl	%eax, -80(%ebp)
	movl	%gs:20, %eax
	movl	%eax, -12(%ebp)
	xorl	%eax, %eax
	movl	-76(%ebp), %eax
	movl	8(%eax), %eax
	movl	%eax, -40(%ebp)
	movl	-76(%ebp), %eax
	movl	56(%eax), %eax
	cmpl	$-1, %eax
	jne	.L250
	movl	$1000000000, -56(%ebp)
	jmp	.L251
.L250:
	movl	-76(%ebp), %eax
	movl	56(%eax), %eax
	leal	3(%eax), %edx
	testl	%eax, %eax
	cmovs	%edx, %eax
	sarl	$2, %eax
	movl	%eax, -56(%ebp)
.L251:
	movl	-40(%ebp), %eax
	movl	304(%eax), %eax
	testl	%eax, %eax
	jne	.L252
	movl	-76(%ebp), %eax
	movl	88(%eax), %edx
	movl	-76(%ebp), %eax
	movl	92(%eax), %eax
	subl	%eax, %edx
	movl	%edx, %eax
	movl	%eax, %edx
	movl	-56(%ebp), %eax
	cmpl	%eax, %edx
	cmova	%eax, %edx
	movl	-40(%ebp), %eax
	movl	452(%eax), %ecx
	movl	-76(%ebp), %eax
	movl	92(%eax), %eax
	addl	%eax, %ecx
	movl	-40(%ebp), %eax
	movl	448(%eax), %eax
	subl	$4, %esp
	pushl	%edx
	pushl	%ecx
	pushl	%eax
	call	write
	addl	$16, %esp
	movl	%eax, -52(%ebp)
	jmp	.L253
.L252:
	movl	-40(%ebp), %eax
	movl	252(%eax), %eax
	movl	%eax, -28(%ebp)
	movl	-40(%ebp), %eax
	movl	304(%eax), %eax
	movl	%eax, -24(%ebp)
	movl	-40(%ebp), %eax
	movl	452(%eax), %edx
	movl	-76(%ebp), %eax
	movl	92(%eax), %eax
	addl	%edx, %eax
	movl	%eax, -20(%ebp)
	movl	-76(%ebp), %eax
	movl	88(%eax), %edx
	movl	-76(%ebp), %eax
	movl	92(%eax), %eax
	subl	%eax, %edx
	movl	%edx, %eax
	movl	%eax, %edx
	movl	-56(%ebp), %eax
	cmpl	%eax, %edx
	cmovbe	%edx, %eax
	movl	%eax, -16(%ebp)
	movl	-40(%ebp), %eax
	movl	448(%eax), %eax
	subl	$4, %esp
	pushl	$2
	leal	-28(%ebp), %edx
	pushl	%edx
	pushl	%eax
	call	writev
	addl	$16, %esp
	movl	%eax, -52(%ebp)
.L253:
	cmpl	$0, -52(%ebp)
	jns	.L254
	call	__errno_location
	movl	(%eax), %eax
	cmpl	$4, %eax
	jne	.L254
	jmp	.L249
.L254:
	cmpl	$0, -52(%ebp)
	je	.L256
	cmpl	$0, -52(%ebp)
	jns	.L257
	call	__errno_location
	movl	(%eax), %eax
	cmpl	$11, %eax
	je	.L256
	call	__errno_location
	movl	(%eax), %eax
	cmpl	$11, %eax
	jne	.L257
.L256:
	movl	-76(%ebp), %eax
	movl	80(%eax), %eax
	leal	100(%eax), %edx
	movl	-76(%ebp), %eax
	movl	%edx, 80(%eax)
	movl	-76(%ebp), %eax
	movl	$3, (%eax)
	movl	-40(%ebp), %eax
	movl	448(%eax), %eax
	subl	$12, %esp
	pushl	%eax
	call	fdwatch_del_fd
	addl	$16, %esp
	movl	-76(%ebp), %eax
	movl	%eax, -60(%ebp)
	movl	-76(%ebp), %eax
	movl	72(%eax), %eax
	testl	%eax, %eax
	je	.L258
	subl	$8, %esp
	pushl	$.LC118
	pushl	$3
	call	syslog
	addl	$16, %esp
.L258:
	movl	-76(%ebp), %eax
	movl	80(%eax), %eax
	subl	$12, %esp
	pushl	$0
	pushl	%eax
	pushl	-60(%ebp)
	pushl	$wakeup_connection
	pushl	-80(%ebp)
	call	tmr_create
	addl	$32, %esp
	movl	%eax, %edx
	movl	-76(%ebp), %eax
	movl	%edx, 72(%eax)
	movl	-76(%ebp), %eax
	movl	72(%eax), %eax
	testl	%eax, %eax
	jne	.L259
	subl	$8, %esp
	pushl	$.LC119
	pushl	$2
	call	syslog
	addl	$16, %esp
	subl	$12, %esp
	pushl	$1
	call	exit
.L259:
	jmp	.L249
.L257:
	cmpl	$0, -52(%ebp)
	jns	.L260
	call	__errno_location
	movl	(%eax), %eax
	cmpl	$32, %eax
	je	.L261
	call	__errno_location
	movl	(%eax), %eax
	cmpl	$22, %eax
	je	.L261
	call	__errno_location
	movl	(%eax), %eax
	cmpl	$104, %eax
	je	.L261
	movl	-40(%ebp), %eax
	movl	172(%eax), %eax
	subl	$4, %esp
	pushl	%eax
	pushl	$.LC120
	pushl	$3
	call	syslog
	addl	$16, %esp
.L261:
	subl	$8, %esp
	pushl	-80(%ebp)
	pushl	-76(%ebp)
	call	clear_connection
	addl	$16, %esp
	jmp	.L249
.L260:
	movl	-80(%ebp), %eax
	movl	(%eax), %edx
	movl	-76(%ebp), %eax
	movl	%edx, 68(%eax)
	movl	-40(%ebp), %eax
	movl	304(%eax), %eax
	testl	%eax, %eax
	je	.L262
	movl	-52(%ebp), %edx
	movl	-40(%ebp), %eax
	movl	304(%eax), %eax
	cmpl	%eax, %edx
	jae	.L263
	movl	-40(%ebp), %eax
	movl	304(%eax), %edx
	movl	-52(%ebp), %eax
	subl	%eax, %edx
	movl	%edx, %eax
	movl	%eax, -36(%ebp)
	movl	-36(%ebp), %edx
	movl	-40(%ebp), %eax
	movl	252(%eax), %ecx
	movl	-52(%ebp), %eax
	addl	%eax, %ecx
	movl	-40(%ebp), %eax
	movl	252(%eax), %eax
	subl	$4, %esp
	pushl	%edx
	pushl	%ecx
	pushl	%eax
	call	memmove
	addl	$16, %esp
	movl	-36(%ebp), %edx
	movl	-40(%ebp), %eax
	movl	%edx, 304(%eax)
	movl	$0, -52(%ebp)
	jmp	.L262
.L263:
	movl	-52(%ebp), %edx
	movl	-40(%ebp), %eax
	movl	304(%eax), %eax
	subl	%eax, %edx
	movl	%edx, %eax
	movl	%eax, -52(%ebp)
	movl	-40(%ebp), %eax
	movl	$0, 304(%eax)
.L262:
	movl	-76(%ebp), %eax
	movl	92(%eax), %edx
	movl	-52(%ebp), %eax
	addl	%eax, %edx
	movl	-76(%ebp), %eax
	movl	%edx, 92(%eax)
	movl	-76(%ebp), %eax
	movl	8(%eax), %eax
	movl	-76(%ebp), %edx
	movl	8(%edx), %edx
	movl	168(%edx), %ecx
	movl	-52(%ebp), %edx
	addl	%ecx, %edx
	movl	%edx, 168(%eax)
	movl	$0, -44(%ebp)
	jmp	.L264
.L265:
	movl	throttles, %ecx
	movl	-76(%ebp), %eax
	movl	-44(%ebp), %edx
	movl	12(%eax,%edx,4), %eax
	movl	%eax, %edx
	movl	%edx, %eax
	addl	%eax, %eax
	addl	%edx, %eax
	sall	$3, %eax
	addl	%eax, %ecx
	movl	throttles, %ebx
	movl	-76(%ebp), %eax
	movl	-44(%ebp), %edx
	movl	12(%eax,%edx,4), %eax
	movl	%eax, %edx
	movl	%edx, %eax
	addl	%eax, %eax
	addl	%edx, %eax
	sall	$3, %eax
	addl	%ebx, %eax
	movl	16(%eax), %edx
	movl	-52(%ebp), %eax
	addl	%edx, %eax
	movl	%eax, 16(%ecx)
	addl	$1, -44(%ebp)
.L264:
	movl	-76(%ebp), %eax
	movl	52(%eax), %eax
	cmpl	-44(%ebp), %eax
	jg	.L265
	movl	-76(%ebp), %eax
	movl	92(%eax), %edx
	movl	-76(%ebp), %eax
	movl	88(%eax), %eax
	cmpl	%eax, %edx
	jl	.L266
	subl	$8, %esp
	pushl	-80(%ebp)
	pushl	-76(%ebp)
	call	finish_connection
	addl	$16, %esp
	jmp	.L249
.L266:
	movl	-76(%ebp), %eax
	movl	80(%eax), %eax
	cmpl	$100, %eax
	jle	.L267
	movl	-76(%ebp), %eax
	movl	80(%eax), %eax
	leal	-100(%eax), %edx
	movl	-76(%ebp), %eax
	movl	%edx, 80(%eax)
.L267:
	movl	-76(%ebp), %eax
	movl	56(%eax), %eax
	cmpl	$-1, %eax
	je	.L249
	movl	-80(%ebp), %eax
	movl	(%eax), %edx
	movl	-76(%ebp), %eax
	movl	64(%eax), %eax
	subl	%eax, %edx
	movl	%edx, %eax
	movl	%eax, -48(%ebp)
	cmpl	$0, -48(%ebp)
	jne	.L269
	movl	$1, -48(%ebp)
.L269:
	movl	-76(%ebp), %eax
	movl	8(%eax), %eax
	movl	168(%eax), %eax
	cltd
	idivl	-48(%ebp)
	movl	%eax, %edx
	movl	-76(%ebp), %eax
	movl	56(%eax), %eax
	cmpl	%eax, %edx
	jle	.L249
	movl	-76(%ebp), %eax
	movl	$3, (%eax)
	movl	-40(%ebp), %eax
	movl	448(%eax), %eax
	subl	$12, %esp
	pushl	%eax
	call	fdwatch_del_fd
	addl	$16, %esp
	movl	-76(%ebp), %eax
	movl	8(%eax), %eax
	movl	168(%eax), %eax
	movl	-76(%ebp), %edx
	movl	56(%edx), %ebx
	cltd
	idivl	%ebx
	subl	-48(%ebp), %eax
	movl	%eax, -32(%ebp)
	movl	-76(%ebp), %eax
	movl	%eax, -60(%ebp)
	movl	-76(%ebp), %eax
	movl	72(%eax), %eax
	testl	%eax, %eax
	je	.L270
	subl	$8, %esp
	pushl	$.LC118
	pushl	$3
	call	syslog
	addl	$16, %esp
.L270:
	cmpl	$0, -32(%ebp)
	jle	.L271
	movl	-32(%ebp), %eax
	imull	$1000, %eax, %eax
	jmp	.L272
.L271:
	movl	$500, %eax
.L272:
	subl	$12, %esp
	pushl	$0
	pushl	%eax
	pushl	-60(%ebp)
	pushl	$wakeup_connection
	pushl	-80(%ebp)
	call	tmr_create
	addl	$32, %esp
	movl	%eax, %edx
	movl	-76(%ebp), %eax
	movl	%edx, 72(%eax)
	movl	-76(%ebp), %eax
	movl	72(%eax), %eax
	testl	%eax, %eax
	jne	.L249
	subl	$8, %esp
	pushl	$.LC119
	pushl	$2
	call	syslog
	addl	$16, %esp
	subl	$12, %esp
	pushl	$1
	call	exit
.L249:
	movl	-12(%ebp), %eax
	xorl	%gs:20, %eax
	je	.L274
	call	__stack_chk_fail
.L274:
	movl	-4(%ebp), %ebx
	leave
	ret
	.size	handle_send, .-handle_send
	.type	handle_linger, @function
handle_linger:
	pushl	%ebp
	movl	%esp, %ebp
	subl	$4136, %esp
	movl	8(%ebp), %eax
	movl	%eax, -4124(%ebp)
	movl	12(%ebp), %eax
	movl	%eax, -4128(%ebp)
	movl	%gs:20, %eax
	movl	%eax, -12(%ebp)
	xorl	%eax, %eax
	movl	-4124(%ebp), %eax
	movl	8(%eax), %eax
	movl	448(%eax), %eax
	subl	$4, %esp
	pushl	$4096
	leal	-4108(%ebp), %edx
	pushl	%edx
	pushl	%eax
	call	read
	addl	$16, %esp
	movl	%eax, -4112(%ebp)
	cmpl	$0, -4112(%ebp)
	jns	.L276
	call	__errno_location
	movl	(%eax), %eax
	cmpl	$4, %eax
	je	.L275
	call	__errno_location
	movl	(%eax), %eax
	cmpl	$11, %eax
	je	.L275
.L276:
	cmpl	$0, -4112(%ebp)
	jg	.L275
	subl	$8, %esp
	pushl	-4128(%ebp)
	pushl	-4124(%ebp)
	call	really_clear_connection
	addl	$16, %esp
.L275:
	movl	-12(%ebp), %eax
	xorl	%gs:20, %eax
	je	.L280
	call	__stack_chk_fail
.L280:
	leave
	ret
	.size	handle_linger, .-handle_linger
	.section	.rodata
	.align 4
.LC121:
	.string	"throttle sending count was negative - shouldn't happen!"
	.text
	.type	check_throttles, @function
check_throttles:
	pushl	%ebp
	movl	%esp, %ebp
	pushl	%ebx
	subl	$20, %esp
	movl	8(%ebp), %eax
	movl	$0, 52(%eax)
	movl	8(%ebp), %eax
	movl	$-1, 60(%eax)
	movl	8(%ebp), %eax
	movl	60(%eax), %edx
	movl	8(%ebp), %eax
	movl	%edx, 56(%eax)
	movl	$0, -16(%ebp)
	jmp	.L282
.L292:
	movl	8(%ebp), %eax
	movl	8(%eax), %eax
	movl	188(%eax), %ecx
	movl	throttles, %ebx
	movl	-16(%ebp), %edx
	movl	%edx, %eax
	addl	%eax, %eax
	addl	%edx, %eax
	sall	$3, %eax
	addl	%ebx, %eax
	movl	(%eax), %eax
	subl	$8, %esp
	pushl	%ecx
	pushl	%eax
	call	match
	addl	$16, %esp
	testl	%eax, %eax
	je	.L283
	movl	throttles, %ecx
	movl	-16(%ebp), %edx
	movl	%edx, %eax
	addl	%eax, %eax
	addl	%edx, %eax
	sall	$3, %eax
	addl	%ecx, %eax
	movl	12(%eax), %ecx
	movl	throttles, %ebx
	movl	-16(%ebp), %edx
	movl	%edx, %eax
	addl	%eax, %eax
	addl	%edx, %eax
	sall	$3, %eax
	addl	%ebx, %eax
	movl	4(%eax), %eax
	addl	%eax, %eax
	cmpl	%eax, %ecx
	jle	.L284
	movl	$0, %eax
	jmp	.L285
.L284:
	movl	throttles, %ecx
	movl	-16(%ebp), %edx
	movl	%edx, %eax
	addl	%eax, %eax
	addl	%edx, %eax
	sall	$3, %eax
	addl	%ecx, %eax
	movl	12(%eax), %ecx
	movl	throttles, %ebx
	movl	-16(%ebp), %edx
	movl	%edx, %eax
	addl	%eax, %eax
	addl	%edx, %eax
	sall	$3, %eax
	addl	%ebx, %eax
	movl	8(%eax), %eax
	cmpl	%eax, %ecx
	jge	.L286
	movl	$0, %eax
	jmp	.L285
.L286:
	movl	throttles, %ecx
	movl	-16(%ebp), %edx
	movl	%edx, %eax
	addl	%eax, %eax
	addl	%edx, %eax
	sall	$3, %eax
	addl	%ecx, %eax
	movl	20(%eax), %eax
	testl	%eax, %eax
	jns	.L287
	subl	$8, %esp
	pushl	$.LC121
	pushl	$3
	call	syslog
	addl	$16, %esp
	movl	throttles, %ecx
	movl	-16(%ebp), %edx
	movl	%edx, %eax
	addl	%eax, %eax
	addl	%edx, %eax
	sall	$3, %eax
	addl	%ecx, %eax
	movl	$0, 20(%eax)
.L287:
	movl	8(%ebp), %eax
	movl	52(%eax), %eax
	leal	1(%eax), %ecx
	movl	8(%ebp), %edx
	movl	%ecx, 52(%edx)
	movl	8(%ebp), %edx
	movl	-16(%ebp), %ecx
	movl	%ecx, 12(%edx,%eax,4)
	movl	throttles, %ecx
	movl	-16(%ebp), %edx
	movl	%edx, %eax
	addl	%eax, %eax
	addl	%edx, %eax
	sall	$3, %eax
	addl	%ecx, %eax
	movl	20(%eax), %edx
	addl	$1, %edx
	movl	%edx, 20(%eax)
	movl	throttles, %ecx
	movl	-16(%ebp), %edx
	movl	%edx, %eax
	addl	%eax, %eax
	addl	%edx, %eax
	sall	$3, %eax
	addl	%ecx, %eax
	movl	4(%eax), %ecx
	movl	throttles, %ebx
	movl	-16(%ebp), %edx
	movl	%edx, %eax
	addl	%eax, %eax
	addl	%edx, %eax
	sall	$3, %eax
	addl	%ebx, %eax
	movl	20(%eax), %ebx
	movl	%ecx, %eax
	cltd
	idivl	%ebx
	movl	%eax, -12(%ebp)
	movl	8(%ebp), %eax
	movl	56(%eax), %eax
	cmpl	$-1, %eax
	jne	.L288
	movl	8(%ebp), %eax
	movl	-12(%ebp), %edx
	movl	%edx, 56(%eax)
	jmp	.L289
.L288:
	movl	8(%ebp), %eax
	movl	56(%eax), %edx
	movl	-12(%ebp), %eax
	cmpl	%eax, %edx
	cmovg	%eax, %edx
	movl	8(%ebp), %eax
	movl	%edx, 56(%eax)
.L289:
	movl	throttles, %ecx
	movl	-16(%ebp), %edx
	movl	%edx, %eax
	addl	%eax, %eax
	addl	%edx, %eax
	sall	$3, %eax
	addl	%ecx, %eax
	movl	8(%eax), %eax
	movl	%eax, -12(%ebp)
	movl	8(%ebp), %eax
	movl	60(%eax), %eax
	cmpl	$-1, %eax
	jne	.L290
	movl	8(%ebp), %eax
	movl	-12(%ebp), %edx
	movl	%edx, 60(%eax)
	jmp	.L283
.L290:
	movl	8(%ebp), %eax
	movl	60(%eax), %edx
	movl	-12(%ebp), %eax
	cmpl	%eax, %edx
	cmovl	%eax, %edx
	movl	8(%ebp), %eax
	movl	%edx, 60(%eax)
.L283:
	addl	$1, -16(%ebp)
.L282:
	movl	numthrottles, %eax
	cmpl	%eax, -16(%ebp)
	jge	.L291
	movl	8(%ebp), %eax
	movl	52(%eax), %eax
	cmpl	$9, %eax
	jle	.L292
.L291:
	movl	$1, %eax
.L285:
	movl	-4(%ebp), %ebx
	leave
	ret
	.size	check_throttles, .-check_throttles
	.type	clear_throttles, @function
clear_throttles:
	pushl	%ebp
	movl	%esp, %ebp
	subl	$16, %esp
	movl	$0, -4(%ebp)
	jmp	.L294
.L295:
	movl	throttles, %ecx
	movl	8(%ebp), %eax
	movl	-4(%ebp), %edx
	movl	12(%eax,%edx,4), %eax
	movl	%eax, %edx
	movl	%edx, %eax
	addl	%eax, %eax
	addl	%edx, %eax
	sall	$3, %eax
	addl	%ecx, %eax
	movl	20(%eax), %edx
	subl	$1, %edx
	movl	%edx, 20(%eax)
	addl	$1, -4(%ebp)
.L294:
	movl	8(%ebp), %eax
	movl	52(%eax), %eax
	cmpl	-4(%ebp), %eax
	jg	.L295
	leave
	ret
	.size	clear_throttles, .-clear_throttles
	.section	.rodata
	.align 4
.LC122:
	.string	"throttle #%d '%.80s' rate %ld greatly exceeding limit %ld; %d sending"
	.align 4
.LC123:
	.string	"throttle #%d '%.80s' rate %ld exceeding limit %ld; %d sending"
	.align 4
.LC124:
	.string	"throttle #%d '%.80s' rate %ld lower than minimum %ld; %d sending"
	.text
	.type	update_throttles, @function
update_throttles:
	pushl	%ebp
	movl	%esp, %ebp
	pushl	%edi
	pushl	%esi
	pushl	%ebx
	subl	$44, %esp
	movl	$0, -44(%ebp)
	jmp	.L297
.L301:
	movl	throttles, %ecx
	movl	-44(%ebp), %edx
	movl	%edx, %eax
	addl	%eax, %eax
	addl	%edx, %eax
	sall	$3, %eax
	leal	(%ecx,%eax), %ebx
	movl	throttles, %ecx
	movl	-44(%ebp), %edx
	movl	%edx, %eax
	addl	%eax, %eax
	addl	%edx, %eax
	sall	$3, %eax
	addl	%ecx, %eax
	movl	12(%eax), %eax
	leal	(%eax,%eax), %esi
	movl	throttles, %ecx
	movl	-44(%ebp), %edx
	movl	%edx, %eax
	addl	%eax, %eax
	addl	%edx, %eax
	sall	$3, %eax
	addl	%ecx, %eax
	movl	16(%eax), %eax
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
	movl	%edx, %eax
	movl	%eax, 12(%ebx)
	movl	throttles, %ecx
	movl	-44(%ebp), %edx
	movl	%edx, %eax
	addl	%eax, %eax
	addl	%edx, %eax
	sall	$3, %eax
	addl	%ecx, %eax
	movl	$0, 16(%eax)
	movl	throttles, %ecx
	movl	-44(%ebp), %edx
	movl	%edx, %eax
	addl	%eax, %eax
	addl	%edx, %eax
	sall	$3, %eax
	addl	%ecx, %eax
	movl	12(%eax), %ecx
	movl	throttles, %ebx
	movl	-44(%ebp), %edx
	movl	%edx, %eax
	addl	%eax, %eax
	addl	%edx, %eax
	sall	$3, %eax
	addl	%ebx, %eax
	movl	4(%eax), %eax
	cmpl	%eax, %ecx
	jle	.L298
	movl	throttles, %ecx
	movl	-44(%ebp), %edx
	movl	%edx, %eax
	addl	%eax, %eax
	addl	%edx, %eax
	sall	$3, %eax
	addl	%ecx, %eax
	movl	20(%eax), %eax
	testl	%eax, %eax
	je	.L298
	movl	throttles, %ecx
	movl	-44(%ebp), %edx
	movl	%edx, %eax
	addl	%eax, %eax
	addl	%edx, %eax
	sall	$3, %eax
	addl	%ecx, %eax
	movl	12(%eax), %ecx
	movl	throttles, %ebx
	movl	-44(%ebp), %edx
	movl	%edx, %eax
	addl	%eax, %eax
	addl	%edx, %eax
	sall	$3, %eax
	addl	%ebx, %eax
	movl	4(%eax), %eax
	addl	%eax, %eax
	cmpl	%eax, %ecx
	jle	.L299
	movl	throttles, %ecx
	movl	-44(%ebp), %edx
	movl	%edx, %eax
	addl	%eax, %eax
	addl	%edx, %eax
	sall	$3, %eax
	addl	%ecx, %eax
	movl	20(%eax), %esi
	movl	throttles, %ecx
	movl	-44(%ebp), %edx
	movl	%edx, %eax
	addl	%eax, %eax
	addl	%edx, %eax
	sall	$3, %eax
	addl	%ecx, %eax
	movl	4(%eax), %ebx
	movl	throttles, %ecx
	movl	-44(%ebp), %edx
	movl	%edx, %eax
	addl	%eax, %eax
	addl	%edx, %eax
	sall	$3, %eax
	addl	%ecx, %eax
	movl	12(%eax), %ecx
	movl	throttles, %edi
	movl	-44(%ebp), %edx
	movl	%edx, %eax
	addl	%eax, %eax
	addl	%edx, %eax
	sall	$3, %eax
	addl	%edi, %eax
	movl	(%eax), %eax
	subl	$4, %esp
	pushl	%esi
	pushl	%ebx
	pushl	%ecx
	pushl	%eax
	pushl	-44(%ebp)
	pushl	$.LC122
	pushl	$5
	call	syslog
	addl	$32, %esp
	jmp	.L298
.L299:
	movl	throttles, %ecx
	movl	-44(%ebp), %edx
	movl	%edx, %eax
	addl	%eax, %eax
	addl	%edx, %eax
	sall	$3, %eax
	addl	%ecx, %eax
	movl	20(%eax), %esi
	movl	throttles, %ecx
	movl	-44(%ebp), %edx
	movl	%edx, %eax
	addl	%eax, %eax
	addl	%edx, %eax
	sall	$3, %eax
	addl	%ecx, %eax
	movl	4(%eax), %ebx
	movl	throttles, %ecx
	movl	-44(%ebp), %edx
	movl	%edx, %eax
	addl	%eax, %eax
	addl	%edx, %eax
	sall	$3, %eax
	addl	%ecx, %eax
	movl	12(%eax), %ecx
	movl	throttles, %edi
	movl	-44(%ebp), %edx
	movl	%edx, %eax
	addl	%eax, %eax
	addl	%edx, %eax
	sall	$3, %eax
	addl	%edi, %eax
	movl	(%eax), %eax
	subl	$4, %esp
	pushl	%esi
	pushl	%ebx
	pushl	%ecx
	pushl	%eax
	pushl	-44(%ebp)
	pushl	$.LC123
	pushl	$6
	call	syslog
	addl	$32, %esp
.L298:
	movl	throttles, %ecx
	movl	-44(%ebp), %edx
	movl	%edx, %eax
	addl	%eax, %eax
	addl	%edx, %eax
	sall	$3, %eax
	addl	%ecx, %eax
	movl	12(%eax), %ecx
	movl	throttles, %ebx
	movl	-44(%ebp), %edx
	movl	%edx, %eax
	addl	%eax, %eax
	addl	%edx, %eax
	sall	$3, %eax
	addl	%ebx, %eax
	movl	8(%eax), %eax
	cmpl	%eax, %ecx
	jge	.L300
	movl	throttles, %ecx
	movl	-44(%ebp), %edx
	movl	%edx, %eax
	addl	%eax, %eax
	addl	%edx, %eax
	sall	$3, %eax
	addl	%ecx, %eax
	movl	20(%eax), %eax
	testl	%eax, %eax
	je	.L300
	movl	throttles, %ecx
	movl	-44(%ebp), %edx
	movl	%edx, %eax
	addl	%eax, %eax
	addl	%edx, %eax
	sall	$3, %eax
	addl	%ecx, %eax
	movl	20(%eax), %esi
	movl	throttles, %ecx
	movl	-44(%ebp), %edx
	movl	%edx, %eax
	addl	%eax, %eax
	addl	%edx, %eax
	sall	$3, %eax
	addl	%ecx, %eax
	movl	8(%eax), %ebx
	movl	throttles, %ecx
	movl	-44(%ebp), %edx
	movl	%edx, %eax
	addl	%eax, %eax
	addl	%edx, %eax
	sall	$3, %eax
	addl	%ecx, %eax
	movl	12(%eax), %ecx
	movl	throttles, %edi
	movl	-44(%ebp), %edx
	movl	%edx, %eax
	addl	%eax, %eax
	addl	%edx, %eax
	sall	$3, %eax
	addl	%edi, %eax
	movl	(%eax), %eax
	subl	$4, %esp
	pushl	%esi
	pushl	%ebx
	pushl	%ecx
	pushl	%eax
	pushl	-44(%ebp)
	pushl	$.LC124
	pushl	$5
	call	syslog
	addl	$32, %esp
.L300:
	addl	$1, -44(%ebp)
.L297:
	movl	numthrottles, %eax
	cmpl	%eax, -44(%ebp)
	jl	.L301
	movl	$0, -36(%ebp)
	jmp	.L302
.L309:
	movl	connects, %ecx
	movl	-36(%ebp), %edx
	movl	%edx, %eax
	addl	%eax, %eax
	addl	%edx, %eax
	sall	$5, %eax
	addl	%ecx, %eax
	movl	%eax, -32(%ebp)
	movl	-32(%ebp), %eax
	movl	(%eax), %eax
	cmpl	$2, %eax
	je	.L303
	movl	-32(%ebp), %eax
	movl	(%eax), %eax
	cmpl	$3, %eax
	jne	.L304
.L303:
	movl	-32(%ebp), %eax
	movl	$-1, 56(%eax)
	movl	$0, -40(%ebp)
	jmp	.L305
.L308:
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
	addl	%ecx, %eax
	movl	4(%eax), %ecx
	movl	throttles, %ebx
	movl	-44(%ebp), %edx
	movl	%edx, %eax
	addl	%eax, %eax
	addl	%edx, %eax
	sall	$3, %eax
	addl	%ebx, %eax
	movl	20(%eax), %edi
	movl	%ecx, %eax
	cltd
	idivl	%edi
	movl	%eax, -28(%ebp)
	movl	-32(%ebp), %eax
	movl	56(%eax), %eax
	cmpl	$-1, %eax
	jne	.L306
	movl	-32(%ebp), %eax
	movl	-28(%ebp), %edx
	movl	%edx, 56(%eax)
	jmp	.L307
.L306:
	movl	-32(%ebp), %eax
	movl	56(%eax), %edx
	movl	-28(%ebp), %eax
	cmpl	%eax, %edx
	cmovg	%eax, %edx
	movl	-32(%ebp), %eax
	movl	%edx, 56(%eax)
.L307:
	addl	$1, -40(%ebp)
.L305:
	movl	-32(%ebp), %eax
	movl	52(%eax), %eax
	cmpl	-40(%ebp), %eax
	jg	.L308
.L304:
	addl	$1, -36(%ebp)
.L302:
	movl	max_connects, %eax
	cmpl	%eax, -36(%ebp)
	jl	.L309
	leal	-12(%ebp), %esp
	popl	%ebx
	popl	%esi
	popl	%edi
	popl	%ebp
	ret
	.size	update_throttles, .-update_throttles
	.type	finish_connection, @function
finish_connection:
	pushl	%ebp
	movl	%esp, %ebp
	subl	$8, %esp
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
	leave
	ret
	.size	finish_connection, .-finish_connection
	.section	.rodata
	.align 4
.LC125:
	.string	"replacing non-null linger_timer!"
	.align 4
.LC126:
	.string	"tmr_create(linger_clear_connection) failed"
	.text
	.type	clear_connection, @function
clear_connection:
	pushl	%ebp
	movl	%esp, %ebp
	subl	$24, %esp
	movl	8(%ebp), %eax
	movl	72(%eax), %eax
	testl	%eax, %eax
	je	.L312
	movl	8(%ebp), %eax
	movl	72(%eax), %eax
	subl	$12, %esp
	pushl	%eax
	call	tmr_cancel
	addl	$16, %esp
	movl	8(%ebp), %eax
	movl	$0, 72(%eax)
.L312:
	movl	8(%ebp), %eax
	movl	(%eax), %eax
	cmpl	$4, %eax
	jne	.L313
	movl	8(%ebp), %eax
	movl	76(%eax), %eax
	subl	$12, %esp
	pushl	%eax
	call	tmr_cancel
	addl	$16, %esp
	movl	8(%ebp), %eax
	movl	$0, 76(%eax)
	movl	8(%ebp), %eax
	movl	8(%eax), %eax
	movl	$0, 356(%eax)
.L313:
	movl	8(%ebp), %eax
	movl	8(%eax), %eax
	movl	356(%eax), %eax
	testl	%eax, %eax
	je	.L314
	movl	8(%ebp), %eax
	movl	(%eax), %eax
	cmpl	$3, %eax
	je	.L315
	movl	8(%ebp), %eax
	movl	8(%eax), %eax
	movl	448(%eax), %eax
	subl	$12, %esp
	pushl	%eax
	call	fdwatch_del_fd
	addl	$16, %esp
.L315:
	movl	8(%ebp), %eax
	movl	$4, (%eax)
	movl	8(%ebp), %eax
	movl	8(%eax), %eax
	movl	448(%eax), %eax
	subl	$8, %esp
	pushl	$1
	pushl	%eax
	call	shutdown
	addl	$16, %esp
	movl	8(%ebp), %eax
	movl	8(%eax), %eax
	movl	448(%eax), %eax
	subl	$4, %esp
	pushl	$0
	pushl	8(%ebp)
	pushl	%eax
	call	fdwatch_add_fd
	addl	$16, %esp
	movl	8(%ebp), %eax
	movl	%eax, -12(%ebp)
	movl	8(%ebp), %eax
	movl	76(%eax), %eax
	testl	%eax, %eax
	je	.L316
	subl	$8, %esp
	pushl	$.LC125
	pushl	$3
	call	syslog
	addl	$16, %esp
.L316:
	subl	$12, %esp
	pushl	$0
	pushl	$500
	pushl	-12(%ebp)
	pushl	$linger_clear_connection
	pushl	12(%ebp)
	call	tmr_create
	addl	$32, %esp
	movl	%eax, %edx
	movl	8(%ebp), %eax
	movl	%edx, 76(%eax)
	movl	8(%ebp), %eax
	movl	76(%eax), %eax
	testl	%eax, %eax
	jne	.L311
	subl	$8, %esp
	pushl	$.LC126
	pushl	$2
	call	syslog
	addl	$16, %esp
	subl	$12, %esp
	pushl	$1
	call	exit
.L314:
	subl	$8, %esp
	pushl	12(%ebp)
	pushl	8(%ebp)
	call	really_clear_connection
	addl	$16, %esp
.L311:
	leave
	ret
	.size	clear_connection, .-clear_connection
	.type	really_clear_connection, @function
really_clear_connection:
	pushl	%ebp
	movl	%esp, %ebp
	subl	$8, %esp
	movl	8(%ebp), %eax
	movl	8(%eax), %eax
	movl	168(%eax), %edx
	movl	stats_bytes, %eax
	addl	%edx, %eax
	movl	%eax, stats_bytes
	movl	8(%ebp), %eax
	movl	(%eax), %eax
	cmpl	$3, %eax
	je	.L319
	movl	8(%ebp), %eax
	movl	8(%eax), %eax
	movl	448(%eax), %eax
	subl	$12, %esp
	pushl	%eax
	call	fdwatch_del_fd
	addl	$16, %esp
.L319:
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
	movl	76(%eax), %eax
	testl	%eax, %eax
	je	.L320
	movl	8(%ebp), %eax
	movl	76(%eax), %eax
	subl	$12, %esp
	pushl	%eax
	call	tmr_cancel
	addl	$16, %esp
	movl	8(%ebp), %eax
	movl	$0, 76(%eax)
.L320:
	movl	8(%ebp), %eax
	movl	$0, (%eax)
	movl	first_free_connect, %edx
	movl	8(%ebp), %eax
	movl	%edx, 4(%eax)
	movl	8(%ebp), %eax
	movl	connects, %edx
	subl	%edx, %eax
	sarl	$5, %eax
	imull	$-1431655765, %eax, %eax
	movl	%eax, first_free_connect
	movl	num_connects, %eax
	subl	$1, %eax
	movl	%eax, num_connects
	leave
	ret
	.size	really_clear_connection, .-really_clear_connection
	.section	.rodata
	.align 4
.LC127:
	.string	"%.80s connection timed out reading"
	.align 4
.LC128:
	.string	"%.80s connection timed out sending"
	.text
	.type	idle, @function
idle:
	pushl	%ebp
	movl	%esp, %ebp
	subl	$24, %esp
	movl	$0, -16(%ebp)
	jmp	.L322
.L328:
	movl	connects, %ecx
	movl	-16(%ebp), %edx
	movl	%edx, %eax
	addl	%eax, %eax
	addl	%edx, %eax
	sall	$5, %eax
	addl	%ecx, %eax
	movl	%eax, -12(%ebp)
	movl	-12(%ebp), %eax
	movl	(%eax), %eax
	cmpl	$1, %eax
	je	.L324
	cmpl	$1, %eax
	jl	.L323
	cmpl	$3, %eax
	jg	.L323
	jmp	.L329
.L324:
	movl	12(%ebp), %eax
	movl	(%eax), %edx
	movl	-12(%ebp), %eax
	movl	68(%eax), %eax
	subl	%eax, %edx
	movl	%edx, %eax
	cmpl	$59, %eax
	jle	.L326
	movl	-12(%ebp), %eax
	movl	8(%eax), %eax
	addl	$8, %eax
	subl	$12, %esp
	pushl	%eax
	call	httpd_ntoa
	addl	$16, %esp
	subl	$4, %esp
	pushl	%eax
	pushl	$.LC127
	pushl	$6
	call	syslog
	addl	$16, %esp
	movl	httpd_err408form, %ecx
	movl	httpd_err408title, %edx
	movl	-12(%ebp), %eax
	movl	8(%eax), %eax
	subl	$8, %esp
	pushl	$.LC45
	pushl	%ecx
	pushl	$.LC45
	pushl	%edx
	pushl	$408
	pushl	%eax
	call	httpd_send_err
	addl	$32, %esp
	subl	$8, %esp
	pushl	12(%ebp)
	pushl	-12(%ebp)
	call	finish_connection
	addl	$16, %esp
	jmp	.L323
.L326:
	jmp	.L323
.L329:
	movl	12(%ebp), %eax
	movl	(%eax), %edx
	movl	-12(%ebp), %eax
	movl	68(%eax), %eax
	subl	%eax, %edx
	movl	%edx, %eax
	cmpl	$299, %eax
	jle	.L327
	movl	-12(%ebp), %eax
	movl	8(%eax), %eax
	addl	$8, %eax
	subl	$12, %esp
	pushl	%eax
	call	httpd_ntoa
	addl	$16, %esp
	subl	$4, %esp
	pushl	%eax
	pushl	$.LC128
	pushl	$6
	call	syslog
	addl	$16, %esp
	subl	$8, %esp
	pushl	12(%ebp)
	pushl	-12(%ebp)
	call	clear_connection
	addl	$16, %esp
	jmp	.L330
.L327:
.L330:
	nop
.L323:
	addl	$1, -16(%ebp)
.L322:
	movl	max_connects, %eax
	cmpl	%eax, -16(%ebp)
	jl	.L328
	leave
	ret
	.size	idle, .-idle
	.type	wakeup_connection, @function
wakeup_connection:
	pushl	%ebp
	movl	%esp, %ebp
	subl	$24, %esp
	movl	8(%ebp), %eax
	movl	%eax, -12(%ebp)
	movl	-12(%ebp), %eax
	movl	$0, 72(%eax)
	movl	-12(%ebp), %eax
	movl	(%eax), %eax
	cmpl	$3, %eax
	jne	.L331
	movl	-12(%ebp), %eax
	movl	$2, (%eax)
	movl	-12(%ebp), %eax
	movl	8(%eax), %eax
	movl	448(%eax), %eax
	subl	$4, %esp
	pushl	$1
	pushl	-12(%ebp)
	pushl	%eax
	call	fdwatch_add_fd
	addl	$16, %esp
.L331:
	leave
	ret
	.size	wakeup_connection, .-wakeup_connection
	.type	linger_clear_connection, @function
linger_clear_connection:
	pushl	%ebp
	movl	%esp, %ebp
	subl	$24, %esp
	movl	8(%ebp), %eax
	movl	%eax, -12(%ebp)
	movl	-12(%ebp), %eax
	movl	$0, 76(%eax)
	subl	$8, %esp
	pushl	12(%ebp)
	pushl	-12(%ebp)
	call	really_clear_connection
	addl	$16, %esp
	leave
	ret
	.size	linger_clear_connection, .-linger_clear_connection
	.type	occasional, @function
occasional:
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
	.align 4
.LC129:
	.string	"up %ld seconds, stats for %ld seconds:"
	.text
	.type	logstats, @function
logstats:
	pushl	%ebp
	movl	%esp, %ebp
	subl	$56, %esp
	movl	8(%ebp), %eax
	movl	%eax, -44(%ebp)
	movl	%gs:20, %eax
	movl	%eax, -12(%ebp)
	xorl	%eax, %eax
	cmpl	$0, -44(%ebp)
	jne	.L337
	subl	$8, %esp
	pushl	$0
	leal	-20(%ebp), %eax
	pushl	%eax
	call	gettimeofday
	addl	$16, %esp
	leal	-20(%ebp), %eax
	movl	%eax, -44(%ebp)
.L337:
	movl	-44(%ebp), %eax
	movl	(%eax), %eax
	movl	%eax, -28(%ebp)
	movl	start_time, %eax
	movl	-28(%ebp), %edx
	subl	%eax, %edx
	movl	%edx, %eax
	movl	%eax, -24(%ebp)
	movl	stats_time, %eax
	movl	-28(%ebp), %edx
	subl	%eax, %edx
	movl	%edx, %eax
	movl	%eax, -32(%ebp)
	cmpl	$0, -32(%ebp)
	jne	.L338
	movl	$1, -32(%ebp)
.L338:
	movl	-28(%ebp), %eax
	movl	%eax, stats_time
	pushl	-32(%ebp)
	pushl	-24(%ebp)
	pushl	$.LC129
	pushl	$6
	call	syslog
	addl	$16, %esp
	subl	$12, %esp
	pushl	-32(%ebp)
	call	thttpd_logstats
	addl	$16, %esp
	subl	$12, %esp
	pushl	-32(%ebp)
	call	httpd_logstats
	addl	$16, %esp
	subl	$12, %esp
	pushl	-32(%ebp)
	call	mmc_logstats
	addl	$16, %esp
	subl	$12, %esp
	pushl	-32(%ebp)
	call	fdwatch_logstats
	addl	$16, %esp
	subl	$12, %esp
	pushl	-32(%ebp)
	call	tmr_logstats
	addl	$16, %esp
	movl	-12(%ebp), %eax
	xorl	%gs:20, %eax
	je	.L339
	call	__stack_chk_fail
.L339:
	leave
	ret
	.size	logstats, .-logstats
	.section	.rodata
	.align 4
.LC130:
	.string	"  thttpd - %ld connections (%g/sec), %d max simultaneous, %lld bytes (%g/sec), %d httpd_conns allocated"
	.text
	.type	thttpd_logstats, @function
thttpd_logstats:
	pushl	%ebp
	movl	%esp, %ebp
	pushl	%esi
	pushl	%ebx
	subl	$16, %esp
	cmpl	$0, 8(%ebp)
	jle	.L341
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
	pushl	$.LC130
	pushl	$6
	call	syslog
	addl	$48, %esp
.L341:
	movl	$0, stats_connections
	movl	$0, stats_bytes
	movl	$0, stats_simultaneous
	leal	-8(%ebp), %esp
	popl	%ebx
	popl	%esi
	popl	%ebp
	ret
	.size	thttpd_logstats, .-thttpd_logstats
	.ident	"GCC: (GNU) 4.9.2"
	.section	.note.GNU-stack,"",@progbits
