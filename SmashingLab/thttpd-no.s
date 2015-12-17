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
	call	__errno_location
	movl	(%eax), %eax
	movl	%eax, -12(%ebp)
.L10:
	subl	$4, %esp
	pushl	$1
	leal	-20(%ebp), %eax
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
	movl	-12(%ebp), %eax
	movl	%eax, (%edx)
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
	jne	.L13
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
.L13:
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
	jne	.L16
	subl	$12, %esp
	pushl	$.LC3
	call	chdir
	addl	$16, %esp
	call	abort
.L16:
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
	jne	.L18
	movl	hs, %eax
	testl	%eax, %eax
	jne	.L19
.L18:
	jmp	.L17
.L19:
	movl	logfile, %eax
	testl	%eax, %eax
	je	.L17
	movl	logfile, %eax
	subl	$8, %esp
	pushl	$.LC4
	pushl	%eax
	call	strcmp
	addl	$16, %esp
	testl	%eax, %eax
	je	.L17
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
	movl	%eax, -12(%ebp)
	movl	logfile, %eax
	subl	$8, %esp
	pushl	$384
	pushl	%eax
	call	chmod
	addl	$16, %esp
	movl	%eax, -16(%ebp)
	cmpl	$0, -12(%ebp)
	je	.L21
	cmpl	$0, -16(%ebp)
	je	.L22
.L21:
	movl	logfile, %eax
	subl	$4, %esp
	pushl	%eax
	pushl	$.LC7
	pushl	$2
	call	syslog
	addl	$16, %esp
	jmp	.L17
.L22:
	subl	$12, %esp
	pushl	-12(%ebp)
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
	pushl	-12(%ebp)
	pushl	%eax
	call	httpd_set_logfp
	addl	$16, %esp
.L17:
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
	subl	$4472, %esp
	movl	%ecx, %ebx
	movl	$32767, -32(%ebp)
	movl	$32767, -36(%ebp)
	movl	4(%ebx), %eax
	movl	(%eax), %eax
	movl	%eax, argv0
	movl	argv0, %eax
	subl	$8, %esp
	pushl	$47
	pushl	%eax
	call	strrchr
	addl	$16, %esp
	movl	%eax, -28(%ebp)
	cmpl	$0, -28(%ebp)
	je	.L24
	addl	$1, -28(%ebp)
	jmp	.L25
.L24:
	movl	argv0, %eax
	movl	%eax, -28(%ebp)
.L25:
	subl	$4, %esp
	pushl	$24
	pushl	$9
	pushl	-28(%ebp)
	call	openlog
	addl	$16, %esp
	subl	$8, %esp
	pushl	4(%ebx)
	pushl	(%ebx)
	call	parse_args
	addl	$16, %esp
	call	tzset
	subl	$8, %esp
	leal	-4432(%ebp), %eax
	pushl	%eax
	pushl	$128
	leal	-4424(%ebp), %eax
	pushl	%eax
	leal	-4428(%ebp), %eax
	pushl	%eax
	pushl	$128
	leal	-4296(%ebp), %eax
	pushl	%eax
	call	lookup_hostname
	addl	$32, %esp
	movl	-4428(%ebp), %eax
	testl	%eax, %eax
	jne	.L26
	movl	-4432(%ebp), %eax
	testl	%eax, %eax
	jne	.L26
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
.L26:
	movl	$0, numthrottles
	movl	$0, maxthrottles
	movl	$0, throttles
	movl	throttlefile, %eax
	testl	%eax, %eax
	je	.L27
	movl	throttlefile, %eax
	subl	$12, %esp
	pushl	%eax
	call	read_throttlefile
	addl	$16, %esp
.L27:
	call	getuid
	testl	%eax, %eax
	jne	.L28
	movl	user, %eax
	subl	$12, %esp
	pushl	%eax
	call	getpwnam
	addl	$16, %esp
	movl	%eax, -48(%ebp)
	cmpl	$0, -48(%ebp)
	jne	.L29
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
.L29:
	movl	-48(%ebp), %eax
	movl	8(%eax), %eax
	movl	%eax, -32(%ebp)
	movl	-48(%ebp), %eax
	movl	12(%eax), %eax
	movl	%eax, -36(%ebp)
.L28:
	movl	logfile, %eax
	testl	%eax, %eax
	je	.L30
	movl	logfile, %eax
	subl	$8, %esp
	pushl	$.LC12
	pushl	%eax
	call	strcmp
	addl	$16, %esp
	testl	%eax, %eax
	jne	.L31
	movl	$1, no_log
	movl	$0, -40(%ebp)
	jmp	.L37
.L31:
	movl	logfile, %eax
	subl	$8, %esp
	pushl	$.LC4
	pushl	%eax
	call	strcmp
	addl	$16, %esp
	testl	%eax, %eax
	jne	.L33
	movl	stdout, %eax
	movl	%eax, -40(%ebp)
	jmp	.L37
.L33:
	movl	logfile, %eax
	subl	$8, %esp
	pushl	$.LC6
	pushl	%eax
	call	fopen
	addl	$16, %esp
	movl	%eax, -40(%ebp)
	movl	logfile, %eax
	subl	$8, %esp
	pushl	$384
	pushl	%eax
	call	chmod
	addl	$16, %esp
	movl	%eax, -52(%ebp)
	cmpl	$0, -40(%ebp)
	je	.L34
	cmpl	$0, -52(%ebp)
	je	.L35
.L34:
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
.L35:
	movl	logfile, %eax
	movzbl	(%eax), %eax
	cmpb	$47, %al
	je	.L36
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
.L36:
	subl	$12, %esp
	pushl	-40(%ebp)
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
	jne	.L37
	subl	$12, %esp
	pushl	-40(%ebp)
	call	fileno
	addl	$16, %esp
	subl	$4, %esp
	pushl	-36(%ebp)
	pushl	-32(%ebp)
	pushl	%eax
	call	fchown
	addl	$16, %esp
	testl	%eax, %eax
	jns	.L37
	subl	$8, %esp
	pushl	$.LC16
	pushl	$4
	call	syslog
	addl	$16, %esp
	subl	$12, %esp
	pushl	$.LC17
	call	perror
	addl	$16, %esp
	jmp	.L37
.L30:
	movl	$0, -40(%ebp)
.L37:
	movl	dir, %eax
	testl	%eax, %eax
	je	.L38
	movl	dir, %eax
	subl	$12, %esp
	pushl	%eax
	call	chdir
	addl	$16, %esp
	testl	%eax, %eax
	jns	.L38
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
.L38:
	subl	$8, %esp
	pushl	$4096
	leal	-4165(%ebp), %eax
	pushl	%eax
	call	getcwd
	addl	$16, %esp
	subl	$12, %esp
	leal	-4165(%ebp), %eax
	pushl	%eax
	call	strlen
	addl	$16, %esp
	subl	$1, %eax
	movzbl	-4165(%ebp,%eax), %eax
	cmpb	$47, %al
	je	.L39
	leal	-4165(%ebp), %eax
	movl	$-1, %ecx
	movl	%eax, %edx
	movl	$0, %eax
	movl	%edx, %edi
	repnz; scasb
	movl	%ecx, %eax
	notl	%eax
	leal	-1(%eax), %edx
	leal	-4165(%ebp), %eax
	addl	%edx, %eax
	movw	$47, (%eax)
.L39:
	movl	debug, %eax
	testl	%eax, %eax
	jne	.L40
	movl	stdin, %eax
	subl	$12, %esp
	pushl	%eax
	call	fclose
	addl	$16, %esp
	movl	stdout, %eax
	cmpl	%eax, -40(%ebp)
	je	.L41
	movl	stdout, %eax
	subl	$12, %esp
	pushl	%eax
	call	fclose
	addl	$16, %esp
.L41:
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
	jns	.L42
	subl	$8, %esp
	pushl	$.LC20
	pushl	$2
	call	syslog
	addl	$16, %esp
	subl	$12, %esp
	pushl	$1
	call	exit
.L40:
	call	setsid
.L42:
	movl	pidfile, %eax
	testl	%eax, %eax
	je	.L43
	movl	pidfile, %eax
	subl	$8, %esp
	pushl	$.LC21
	pushl	%eax
	call	fopen
	addl	$16, %esp
	movl	%eax, -56(%ebp)
	cmpl	$0, -56(%ebp)
	jne	.L44
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
.L44:
	call	getpid
	subl	$4, %esp
	pushl	%eax
	pushl	$.LC22
	pushl	-56(%ebp)
	call	fprintf
	addl	$16, %esp
	subl	$12, %esp
	pushl	-56(%ebp)
	call	fclose
	addl	$16, %esp
.L43:
	call	fdwatch_get_nfiles
	movl	%eax, max_connects
	movl	max_connects, %eax
	testl	%eax, %eax
	jns	.L45
	subl	$8, %esp
	pushl	$.LC23
	pushl	$2
	call	syslog
	addl	$16, %esp
	subl	$12, %esp
	pushl	$1
	call	exit
.L45:
	movl	max_connects, %eax
	subl	$10, %eax
	movl	%eax, max_connects
	movl	do_chroot, %eax
	testl	%eax, %eax
	je	.L46
	subl	$12, %esp
	leal	-4165(%ebp), %eax
	pushl	%eax
	call	chroot
	addl	$16, %esp
	testl	%eax, %eax
	jns	.L47
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
.L47:
	movl	logfile, %eax
	testl	%eax, %eax
	je	.L48
	movl	logfile, %eax
	subl	$8, %esp
	pushl	$.LC4
	pushl	%eax
	call	strcmp
	addl	$16, %esp
	testl	%eax, %eax
	je	.L48
	subl	$12, %esp
	leal	-4165(%ebp), %eax
	pushl	%eax
	call	strlen
	addl	$16, %esp
	movl	%eax, %edx
	movl	logfile, %eax
	subl	$4, %esp
	pushl	%edx
	leal	-4165(%ebp), %edx
	pushl	%edx
	pushl	%eax
	call	strncmp
	addl	$16, %esp
	testl	%eax, %eax
	jne	.L49
	movl	logfile, %ebx
	subl	$12, %esp
	leal	-4165(%ebp), %eax
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
	jmp	.L48
.L49:
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
.L48:
	leal	-4165(%ebp), %eax
	movw	$47, (%eax)
	subl	$12, %esp
	leal	-4165(%ebp), %eax
	pushl	%eax
	call	chdir
	addl	$16, %esp
	testl	%eax, %eax
	jns	.L46
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
.L46:
	movl	data_dir, %eax
	testl	%eax, %eax
	je	.L50
	movl	data_dir, %eax
	subl	$12, %esp
	pushl	%eax
	call	chdir
	addl	$16, %esp
	testl	%eax, %eax
	jns	.L50
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
.L50:
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
	movl	%eax, -4444(%ebp)
	movl	do_global_passwd, %eax
	movl	%eax, -4448(%ebp)
	movl	do_vhost, %eax
	movl	%eax, -4452(%ebp)
	movl	no_symlink_check, %eax
	movl	%eax, -4456(%ebp)
	movl	no_log, %eax
	movl	%eax, -4460(%ebp)
	movl	max_age, %eax
	movl	%eax, -4464(%ebp)
	movl	p3p, %eax
	movl	%eax, -4468(%ebp)
	movl	charset, %eax
	movl	%eax, -4472(%ebp)
	movl	cgi_limit, %eax
	movl	%eax, -4476(%ebp)
	movl	cgi_pattern, %eax
	movl	%eax, -4480(%ebp)
	movzwl	port, %eax
	movzwl	%ax, %eax
	movl	%eax, -4484(%ebp)
	movl	-4432(%ebp), %eax
	testl	%eax, %eax
	je	.L51
	leal	-4424(%ebp), %ebx
	jmp	.L52
.L51:
	movl	$0, %ebx
.L52:
	movl	-4428(%ebp), %eax
	testl	%eax, %eax
	je	.L53
	leal	-4296(%ebp), %ecx
	jmp	.L54
.L53:
	movl	$0, %ecx
.L54:
	movl	hostname, %edx
	subl	$8, %esp
	pushl	%esi
	pushl	%edi
	pushl	-4444(%ebp)
	pushl	-4448(%ebp)
	pushl	-4452(%ebp)
	pushl	-4456(%ebp)
	pushl	-40(%ebp)
	pushl	-4460(%ebp)
	leal	-4165(%ebp), %eax
	pushl	%eax
	pushl	-4464(%ebp)
	pushl	-4468(%ebp)
	pushl	-4472(%ebp)
	pushl	-4476(%ebp)
	pushl	-4480(%ebp)
	pushl	-4484(%ebp)
	pushl	%ebx
	pushl	%ecx
	pushl	%edx
	call	httpd_initialize
	addl	$80, %esp
	movl	%eax, hs
	movl	hs, %eax
	testl	%eax, %eax
	jne	.L55
	subl	$12, %esp
	pushl	$1
	call	exit
.L55:
	subl	$12, %esp
	pushl	$1
	pushl	$120000
	pushl	JunkClientData
	pushl	$occasional
	pushl	$0
	call	tmr_create
	addl	$32, %esp
	testl	%eax, %eax
	jne	.L56
	subl	$8, %esp
	pushl	$.LC32
	pushl	$2
	call	syslog
	addl	$16, %esp
	subl	$12, %esp
	pushl	$1
	call	exit
.L56:
	subl	$12, %esp
	pushl	$1
	pushl	$5000
	pushl	JunkClientData
	pushl	$idle
	pushl	$0
	call	tmr_create
	addl	$32, %esp
	testl	%eax, %eax
	jne	.L57
	subl	$8, %esp
	pushl	$.LC33
	pushl	$2
	call	syslog
	addl	$16, %esp
	subl	$12, %esp
	pushl	$1
	call	exit
.L57:
	movl	numthrottles, %eax
	testl	%eax, %eax
	jle	.L58
	subl	$12, %esp
	pushl	$1
	pushl	$2000
	pushl	JunkClientData
	pushl	$update_throttles
	pushl	$0
	call	tmr_create
	addl	$32, %esp
	testl	%eax, %eax
	jne	.L58
	subl	$8, %esp
	pushl	$.LC34
	pushl	$2
	call	syslog
	addl	$16, %esp
	subl	$12, %esp
	pushl	$1
	call	exit
.L58:
	subl	$12, %esp
	pushl	$1
	pushl	$3600000
	pushl	JunkClientData
	pushl	$show_stats
	pushl	$0
	call	tmr_create
	addl	$32, %esp
	testl	%eax, %eax
	jne	.L59
	subl	$8, %esp
	pushl	$.LC35
	pushl	$2
	call	syslog
	addl	$16, %esp
	subl	$12, %esp
	pushl	$1
	call	exit
.L59:
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
	jne	.L60
	subl	$8, %esp
	pushl	$0
	pushl	$0
	call	setgroups
	addl	$16, %esp
	testl	%eax, %eax
	jns	.L61
	subl	$8, %esp
	pushl	$.LC36
	pushl	$2
	call	syslog
	addl	$16, %esp
	subl	$12, %esp
	pushl	$1
	call	exit
.L61:
	subl	$12, %esp
	pushl	-36(%ebp)
	call	setgid
	addl	$16, %esp
	testl	%eax, %eax
	jns	.L62
	subl	$8, %esp
	pushl	$.LC37
	pushl	$2
	call	syslog
	addl	$16, %esp
	subl	$12, %esp
	pushl	$1
	call	exit
.L62:
	movl	user, %eax
	subl	$8, %esp
	pushl	-36(%ebp)
	pushl	%eax
	call	initgroups
	addl	$16, %esp
	testl	%eax, %eax
	jns	.L63
	subl	$8, %esp
	pushl	$.LC38
	pushl	$4
	call	syslog
	addl	$16, %esp
.L63:
	subl	$12, %esp
	pushl	-32(%ebp)
	call	setuid
	addl	$16, %esp
	testl	%eax, %eax
	jns	.L64
	subl	$8, %esp
	pushl	$.LC39
	pushl	$2
	call	syslog
	addl	$16, %esp
	subl	$12, %esp
	pushl	$1
	call	exit
.L64:
	movl	do_chroot, %eax
	testl	%eax, %eax
	jne	.L60
	subl	$8, %esp
	pushl	$.LC40
	pushl	$4
	call	syslog
	addl	$16, %esp
.L60:
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
	jne	.L65
	subl	$8, %esp
	pushl	$.LC41
	pushl	$2
	call	syslog
	addl	$16, %esp
	subl	$12, %esp
	pushl	$1
	call	exit
.L65:
	movl	$0, -44(%ebp)
	jmp	.L66
.L67:
	movl	connects, %ecx
	movl	-44(%ebp), %edx
	movl	%edx, %eax
	addl	%eax, %eax
	addl	%edx, %eax
	sall	$5, %eax
	addl	%ecx, %eax
	movl	$0, (%eax)
	movl	connects, %ecx
	movl	-44(%ebp), %edx
	movl	%edx, %eax
	addl	%eax, %eax
	addl	%edx, %eax
	sall	$5, %eax
	addl	%ecx, %eax
	movl	-44(%ebp), %edx
	addl	$1, %edx
	movl	%edx, 4(%eax)
	movl	connects, %ecx
	movl	-44(%ebp), %edx
	movl	%edx, %eax
	addl	%eax, %eax
	addl	%edx, %eax
	sall	$5, %eax
	addl	%ecx, %eax
	movl	$0, 8(%eax)
	addl	$1, -44(%ebp)
.L66:
	movl	max_connects, %eax
	cmpl	%eax, -44(%ebp)
	jl	.L67
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
	je	.L68
	movl	hs, %eax
	movl	40(%eax), %eax
	cmpl	$-1, %eax
	je	.L69
	movl	hs, %eax
	movl	40(%eax), %eax
	subl	$4, %esp
	pushl	$0
	pushl	$0
	pushl	%eax
	call	fdwatch_add_fd
	addl	$16, %esp
.L69:
	movl	hs, %eax
	movl	44(%eax), %eax
	cmpl	$-1, %eax
	je	.L68
	movl	hs, %eax
	movl	44(%eax), %eax
	subl	$4, %esp
	pushl	$0
	pushl	$0
	pushl	%eax
	call	fdwatch_add_fd
	addl	$16, %esp
.L68:
	subl	$12, %esp
	leal	-4440(%ebp), %eax
	pushl	%eax
	call	tmr_prepare_timeval
	addl	$16, %esp
	jmp	.L70
.L87:
	movl	got_hup, %eax
	testl	%eax, %eax
	je	.L71
	call	re_open_logfile
	movl	$0, got_hup
.L71:
	subl	$12, %esp
	leal	-4440(%ebp), %eax
	pushl	%eax
	call	tmr_mstimeout
	addl	$16, %esp
	subl	$12, %esp
	pushl	%eax
	call	fdwatch
	addl	$16, %esp
	movl	%eax, -60(%ebp)
	cmpl	$0, -60(%ebp)
	jns	.L72
	call	__errno_location
	movl	(%eax), %eax
	cmpl	$4, %eax
	je	.L73
	call	__errno_location
	movl	(%eax), %eax
	cmpl	$11, %eax
	jne	.L74
.L73:
	jmp	.L70
.L74:
	subl	$8, %esp
	pushl	$.LC42
	pushl	$3
	call	syslog
	addl	$16, %esp
	subl	$12, %esp
	pushl	$1
	call	exit
.L72:
	subl	$12, %esp
	leal	-4440(%ebp), %eax
	pushl	%eax
	call	tmr_prepare_timeval
	addl	$16, %esp
	cmpl	$0, -60(%ebp)
	jne	.L75
	subl	$12, %esp
	leal	-4440(%ebp), %eax
	pushl	%eax
	call	tmr_run
	addl	$16, %esp
	jmp	.L70
.L75:
	movl	hs, %eax
	testl	%eax, %eax
	je	.L76
	movl	hs, %eax
	movl	44(%eax), %eax
	cmpl	$-1, %eax
	je	.L76
	movl	hs, %eax
	movl	44(%eax), %eax
	subl	$12, %esp
	pushl	%eax
	call	fdwatch_check_fd
	addl	$16, %esp
	testl	%eax, %eax
	je	.L76
	movl	hs, %eax
	movl	44(%eax), %eax
	subl	$8, %esp
	pushl	%eax
	leal	-4440(%ebp), %eax
	pushl	%eax
	call	handle_newconnect
	addl	$16, %esp
	testl	%eax, %eax
	je	.L76
	jmp	.L70
.L76:
	movl	hs, %eax
	testl	%eax, %eax
	je	.L77
	movl	hs, %eax
	movl	40(%eax), %eax
	cmpl	$-1, %eax
	je	.L77
	movl	hs, %eax
	movl	40(%eax), %eax
	subl	$12, %esp
	pushl	%eax
	call	fdwatch_check_fd
	addl	$16, %esp
	testl	%eax, %eax
	je	.L77
	movl	hs, %eax
	movl	40(%eax), %eax
	subl	$8, %esp
	pushl	%eax
	leal	-4440(%ebp), %eax
	pushl	%eax
	call	handle_newconnect
	addl	$16, %esp
	testl	%eax, %eax
	je	.L77
	jmp	.L70
.L77:
	jmp	.L78
.L84:
	cmpl	$0, -64(%ebp)
	jne	.L79
	jmp	.L78
.L79:
	movl	-64(%ebp), %eax
	movl	8(%eax), %eax
	movl	%eax, -68(%ebp)
	movl	-68(%ebp), %eax
	movl	448(%eax), %eax
	subl	$12, %esp
	pushl	%eax
	call	fdwatch_check_fd
	addl	$16, %esp
	testl	%eax, %eax
	jne	.L80
	subl	$8, %esp
	leal	-4440(%ebp), %eax
	pushl	%eax
	pushl	-64(%ebp)
	call	clear_connection
	addl	$16, %esp
	jmp	.L78
.L80:
	movl	-64(%ebp), %eax
	movl	(%eax), %eax
	cmpl	$2, %eax
	je	.L81
	cmpl	$4, %eax
	je	.L82
	cmpl	$1, %eax
	je	.L83
	jmp	.L78
.L83:
	subl	$8, %esp
	leal	-4440(%ebp), %eax
	pushl	%eax
	pushl	-64(%ebp)
	call	handle_read
	addl	$16, %esp
	jmp	.L78
.L81:
	subl	$8, %esp
	leal	-4440(%ebp), %eax
	pushl	%eax
	pushl	-64(%ebp)
	call	handle_send
	addl	$16, %esp
	jmp	.L78
.L82:
	subl	$8, %esp
	leal	-4440(%ebp), %eax
	pushl	%eax
	pushl	-64(%ebp)
	call	handle_linger
	addl	$16, %esp
	nop
.L78:
	call	fdwatch_get_next_client_data
	movl	%eax, -64(%ebp)
	cmpl	$-1, -64(%ebp)
	jne	.L84
	subl	$12, %esp
	leal	-4440(%ebp), %eax
	pushl	%eax
	call	tmr_run
	addl	$16, %esp
	movl	got_usr1, %eax
	testl	%eax, %eax
	je	.L70
	movl	terminate, %eax
	testl	%eax, %eax
	jne	.L70
	movl	$1, terminate
	movl	hs, %eax
	testl	%eax, %eax
	je	.L70
	movl	hs, %eax
	movl	40(%eax), %eax
	cmpl	$-1, %eax
	je	.L85
	movl	hs, %eax
	movl	40(%eax), %eax
	subl	$12, %esp
	pushl	%eax
	call	fdwatch_del_fd
	addl	$16, %esp
.L85:
	movl	hs, %eax
	movl	44(%eax), %eax
	cmpl	$-1, %eax
	je	.L86
	movl	hs, %eax
	movl	44(%eax), %eax
	subl	$12, %esp
	pushl	%eax
	call	fdwatch_del_fd
	addl	$16, %esp
.L86:
	movl	hs, %eax
	subl	$12, %esp
	pushl	%eax
	call	httpd_unlisten
	addl	$16, %esp
.L70:
	movl	terminate, %eax
	testl	%eax, %eax
	je	.L87
	movl	num_connects, %eax
	testl	%eax, %eax
	jg	.L87
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
	jmp	.L89
.L115:
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
	jne	.L90
	subl	$12, %esp
	pushl	$.LC47
	call	puts
	addl	$16, %esp
	subl	$12, %esp
	pushl	$0
	call	exit
.L90:
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
	jne	.L91
	movl	-12(%ebp), %eax
	addl	$1, %eax
	cmpl	8(%ebp), %eax
	jge	.L91
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
	jmp	.L92
.L91:
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
	call	atoi
	addl	$16, %esp
	movw	%ax, port
	jmp	.L92
.L93:
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
	jne	.L94
	movl	-12(%ebp), %eax
	addl	$1, %eax
	cmpl	8(%ebp), %eax
	jge	.L94
	addl	$1, -12(%ebp)
	movl	-12(%ebp), %eax
	leal	0(,%eax,4), %edx
	movl	12(%ebp), %eax
	addl	%edx, %eax
	movl	(%eax), %eax
	movl	%eax, dir
	jmp	.L92
.L94:
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
	jne	.L95
	movl	$1, do_chroot
	movl	$1, no_symlink_check
	jmp	.L92
.L95:
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
	jne	.L96
	movl	$0, do_chroot
	movl	$0, no_symlink_check
	jmp	.L92
.L96:
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
	jne	.L97
	movl	-12(%ebp), %eax
	addl	$1, %eax
	cmpl	8(%ebp), %eax
	jge	.L97
	addl	$1, -12(%ebp)
	movl	-12(%ebp), %eax
	leal	0(,%eax,4), %edx
	movl	12(%ebp), %eax
	addl	%edx, %eax
	movl	(%eax), %eax
	movl	%eax, data_dir
	jmp	.L92
.L97:
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
	jne	.L98
	movl	$0, no_symlink_check
	jmp	.L92
.L98:
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
	jne	.L99
	movl	$1, no_symlink_check
	jmp	.L92
.L99:
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
	jne	.L100
	movl	-12(%ebp), %eax
	addl	$1, %eax
	cmpl	8(%ebp), %eax
	jge	.L100
	addl	$1, -12(%ebp)
	movl	-12(%ebp), %eax
	leal	0(,%eax,4), %edx
	movl	12(%ebp), %eax
	addl	%edx, %eax
	movl	(%eax), %eax
	movl	%eax, user
	jmp	.L92
.L100:
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
	jne	.L101
	movl	-12(%ebp), %eax
	addl	$1, %eax
	cmpl	8(%ebp), %eax
	jge	.L101
	addl	$1, -12(%ebp)
	movl	-12(%ebp), %eax
	leal	0(,%eax,4), %edx
	movl	12(%ebp), %eax
	addl	%edx, %eax
	movl	(%eax), %eax
	movl	%eax, cgi_pattern
	jmp	.L92
.L101:
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
	movl	%eax, throttlefile
	jmp	.L92
.L102:
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
	movl	%eax, hostname
	jmp	.L92
.L103:
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
	movl	%eax, logfile
	jmp	.L92
.L104:
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
	jne	.L105
	movl	$1, do_vhost
	jmp	.L92
.L105:
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
	jne	.L106
	movl	$0, do_vhost
	jmp	.L92
.L106:
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
	jne	.L107
	movl	$1, do_global_passwd
	jmp	.L92
.L107:
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
	jne	.L108
	movl	$0, do_global_passwd
	jmp	.L92
.L108:
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
	jne	.L109
	movl	-12(%ebp), %eax
	addl	$1, %eax
	cmpl	8(%ebp), %eax
	jge	.L109
	addl	$1, -12(%ebp)
	movl	-12(%ebp), %eax
	leal	0(,%eax,4), %edx
	movl	12(%ebp), %eax
	addl	%edx, %eax
	movl	(%eax), %eax
	movl	%eax, pidfile
	jmp	.L92
.L109:
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
	jne	.L110
	movl	-12(%ebp), %eax
	addl	$1, %eax
	cmpl	8(%ebp), %eax
	jge	.L110
	addl	$1, -12(%ebp)
	movl	-12(%ebp), %eax
	leal	0(,%eax,4), %edx
	movl	12(%ebp), %eax
	addl	%edx, %eax
	movl	(%eax), %eax
	movl	%eax, charset
	jmp	.L92
.L110:
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
	movl	%eax, p3p
	jmp	.L92
.L111:
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
	subl	$12, %esp
	pushl	%eax
	call	atoi
	addl	$16, %esp
	movl	%eax, max_age
	jmp	.L92
.L112:
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
	jne	.L113
	movl	$1, debug
	jmp	.L92
.L113:
	call	usage
.L92:
	addl	$1, -12(%ebp)
.L89:
	movl	-12(%ebp), %eax
	cmpl	8(%ebp), %eax
	jge	.L114
	movl	-12(%ebp), %eax
	leal	0(,%eax,4), %edx
	movl	12(%ebp), %eax
	addl	%edx, %eax
	movl	(%eax), %eax
	movzbl	(%eax), %eax
	cmpb	$45, %al
	je	.L115
.L114:
	movl	-12(%ebp), %eax
	cmpl	8(%ebp), %eax
	je	.L88
	call	usage
.L88:
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
	subl	$136, %esp
	subl	$8, %esp
	pushl	$.LC71
	pushl	8(%ebp)
	call	fopen
	addl	$16, %esp
	movl	%eax, -24(%ebp)
	cmpl	$0, -24(%ebp)
	jne	.L119
	subl	$12, %esp
	pushl	8(%ebp)
	call	perror
	addl	$16, %esp
	subl	$12, %esp
	pushl	$1
	call	exit
.L119:
	jmp	.L120
.L155:
	subl	$8, %esp
	pushl	$35
	leal	-128(%ebp), %eax
	pushl	%eax
	call	strchr
	addl	$16, %esp
	movl	%eax, -12(%ebp)
	cmpl	$0, -12(%ebp)
	je	.L121
	movl	-12(%ebp), %eax
	movb	$0, (%eax)
.L121:
	leal	-128(%ebp), %eax
	movl	%eax, -12(%ebp)
	subl	$8, %esp
	pushl	$.LC72
	pushl	-12(%ebp)
	call	strspn
	addl	$16, %esp
	addl	%eax, -12(%ebp)
	jmp	.L122
.L154:
	subl	$8, %esp
	pushl	$.LC72
	pushl	-12(%ebp)
	call	strcspn
	addl	$16, %esp
	movl	%eax, %edx
	movl	-12(%ebp), %eax
	addl	%edx, %eax
	movl	%eax, -16(%ebp)
	jmp	.L123
.L124:
	movl	-16(%ebp), %eax
	leal	1(%eax), %edx
	movl	%edx, -16(%ebp)
	movb	$0, (%eax)
.L123:
	movl	-16(%ebp), %eax
	movzbl	(%eax), %eax
	cmpb	$32, %al
	je	.L124
	movl	-16(%ebp), %eax
	movzbl	(%eax), %eax
	cmpb	$9, %al
	je	.L124
	movl	-16(%ebp), %eax
	movzbl	(%eax), %eax
	cmpb	$10, %al
	je	.L124
	movl	-16(%ebp), %eax
	movzbl	(%eax), %eax
	cmpb	$13, %al
	je	.L124
	movl	-12(%ebp), %eax
	movl	%eax, -28(%ebp)
	subl	$8, %esp
	pushl	$61
	pushl	-28(%ebp)
	call	strchr
	addl	$16, %esp
	movl	%eax, -20(%ebp)
	cmpl	$0, -20(%ebp)
	je	.L125
	movl	-20(%ebp), %eax
	leal	1(%eax), %edx
	movl	%edx, -20(%ebp)
	movb	$0, (%eax)
.L125:
	subl	$8, %esp
	pushl	$.LC73
	pushl	-28(%ebp)
	call	strcasecmp
	addl	$16, %esp
	testl	%eax, %eax
	jne	.L126
	subl	$8, %esp
	pushl	-20(%ebp)
	pushl	-28(%ebp)
	call	no_value_required
	addl	$16, %esp
	movl	$1, debug
	jmp	.L127
.L126:
	subl	$8, %esp
	pushl	$.LC74
	pushl	-28(%ebp)
	call	strcasecmp
	addl	$16, %esp
	testl	%eax, %eax
	jne	.L128
	subl	$8, %esp
	pushl	-20(%ebp)
	pushl	-28(%ebp)
	call	value_required
	addl	$16, %esp
	subl	$12, %esp
	pushl	-20(%ebp)
	call	atoi
	addl	$16, %esp
	movw	%ax, port
	jmp	.L127
.L128:
	subl	$8, %esp
	pushl	$.LC75
	pushl	-28(%ebp)
	call	strcasecmp
	addl	$16, %esp
	testl	%eax, %eax
	jne	.L129
	subl	$8, %esp
	pushl	-20(%ebp)
	pushl	-28(%ebp)
	call	value_required
	addl	$16, %esp
	subl	$12, %esp
	pushl	-20(%ebp)
	call	e_strdup
	addl	$16, %esp
	movl	%eax, dir
	jmp	.L127
.L129:
	subl	$8, %esp
	pushl	$.LC25
	pushl	-28(%ebp)
	call	strcasecmp
	addl	$16, %esp
	testl	%eax, %eax
	jne	.L130
	subl	$8, %esp
	pushl	-20(%ebp)
	pushl	-28(%ebp)
	call	no_value_required
	addl	$16, %esp
	movl	$1, do_chroot
	movl	$1, no_symlink_check
	jmp	.L127
.L130:
	subl	$8, %esp
	pushl	$.LC76
	pushl	-28(%ebp)
	call	strcasecmp
	addl	$16, %esp
	testl	%eax, %eax
	jne	.L131
	subl	$8, %esp
	pushl	-20(%ebp)
	pushl	-28(%ebp)
	call	no_value_required
	addl	$16, %esp
	movl	$0, do_chroot
	movl	$0, no_symlink_check
	jmp	.L127
.L131:
	subl	$8, %esp
	pushl	$.LC77
	pushl	-28(%ebp)
	call	strcasecmp
	addl	$16, %esp
	testl	%eax, %eax
	jne	.L132
	subl	$8, %esp
	pushl	-20(%ebp)
	pushl	-28(%ebp)
	call	value_required
	addl	$16, %esp
	subl	$12, %esp
	pushl	-20(%ebp)
	call	e_strdup
	addl	$16, %esp
	movl	%eax, data_dir
	jmp	.L127
.L132:
	subl	$8, %esp
	pushl	$.LC78
	pushl	-28(%ebp)
	call	strcasecmp
	addl	$16, %esp
	testl	%eax, %eax
	jne	.L133
	subl	$8, %esp
	pushl	-20(%ebp)
	pushl	-28(%ebp)
	call	no_value_required
	addl	$16, %esp
	movl	$0, no_symlink_check
	jmp	.L127
.L133:
	subl	$8, %esp
	pushl	$.LC79
	pushl	-28(%ebp)
	call	strcasecmp
	addl	$16, %esp
	testl	%eax, %eax
	jne	.L134
	subl	$8, %esp
	pushl	-20(%ebp)
	pushl	-28(%ebp)
	call	no_value_required
	addl	$16, %esp
	movl	$1, no_symlink_check
	jmp	.L127
.L134:
	subl	$8, %esp
	pushl	$.LC80
	pushl	-28(%ebp)
	call	strcasecmp
	addl	$16, %esp
	testl	%eax, %eax
	jne	.L135
	subl	$8, %esp
	pushl	-20(%ebp)
	pushl	-28(%ebp)
	call	no_value_required
	addl	$16, %esp
	movl	$0, no_symlink_check
	jmp	.L127
.L135:
	subl	$8, %esp
	pushl	$.LC81
	pushl	-28(%ebp)
	call	strcasecmp
	addl	$16, %esp
	testl	%eax, %eax
	jne	.L136
	subl	$8, %esp
	pushl	-20(%ebp)
	pushl	-28(%ebp)
	call	no_value_required
	addl	$16, %esp
	movl	$1, no_symlink_check
	jmp	.L127
.L136:
	subl	$8, %esp
	pushl	$.LC82
	pushl	-28(%ebp)
	call	strcasecmp
	addl	$16, %esp
	testl	%eax, %eax
	jne	.L137
	subl	$8, %esp
	pushl	-20(%ebp)
	pushl	-28(%ebp)
	call	value_required
	addl	$16, %esp
	subl	$12, %esp
	pushl	-20(%ebp)
	call	e_strdup
	addl	$16, %esp
	movl	%eax, user
	jmp	.L127
.L137:
	subl	$8, %esp
	pushl	$.LC83
	pushl	-28(%ebp)
	call	strcasecmp
	addl	$16, %esp
	testl	%eax, %eax
	jne	.L138
	subl	$8, %esp
	pushl	-20(%ebp)
	pushl	-28(%ebp)
	call	value_required
	addl	$16, %esp
	subl	$12, %esp
	pushl	-20(%ebp)
	call	e_strdup
	addl	$16, %esp
	movl	%eax, cgi_pattern
	jmp	.L127
.L138:
	subl	$8, %esp
	pushl	$.LC84
	pushl	-28(%ebp)
	call	strcasecmp
	addl	$16, %esp
	testl	%eax, %eax
	jne	.L139
	subl	$8, %esp
	pushl	-20(%ebp)
	pushl	-28(%ebp)
	call	value_required
	addl	$16, %esp
	subl	$12, %esp
	pushl	-20(%ebp)
	call	atoi
	addl	$16, %esp
	movl	%eax, cgi_limit
	jmp	.L127
.L139:
	subl	$8, %esp
	pushl	$.LC85
	pushl	-28(%ebp)
	call	strcasecmp
	addl	$16, %esp
	testl	%eax, %eax
	jne	.L140
	subl	$8, %esp
	pushl	-20(%ebp)
	pushl	-28(%ebp)
	call	value_required
	addl	$16, %esp
	subl	$12, %esp
	pushl	-20(%ebp)
	call	e_strdup
	addl	$16, %esp
	movl	%eax, url_pattern
	jmp	.L127
.L140:
	subl	$8, %esp
	pushl	$.LC86
	pushl	-28(%ebp)
	call	strcasecmp
	addl	$16, %esp
	testl	%eax, %eax
	jne	.L141
	subl	$8, %esp
	pushl	-20(%ebp)
	pushl	-28(%ebp)
	call	no_value_required
	addl	$16, %esp
	movl	$1, no_empty_referers
	jmp	.L127
.L141:
	subl	$8, %esp
	pushl	$.LC87
	pushl	-28(%ebp)
	call	strcasecmp
	addl	$16, %esp
	testl	%eax, %eax
	jne	.L142
	subl	$8, %esp
	pushl	-20(%ebp)
	pushl	-28(%ebp)
	call	value_required
	addl	$16, %esp
	subl	$12, %esp
	pushl	-20(%ebp)
	call	e_strdup
	addl	$16, %esp
	movl	%eax, local_pattern
	jmp	.L127
.L142:
	subl	$8, %esp
	pushl	$.LC88
	pushl	-28(%ebp)
	call	strcasecmp
	addl	$16, %esp
	testl	%eax, %eax
	jne	.L143
	subl	$8, %esp
	pushl	-20(%ebp)
	pushl	-28(%ebp)
	call	value_required
	addl	$16, %esp
	subl	$12, %esp
	pushl	-20(%ebp)
	call	e_strdup
	addl	$16, %esp
	movl	%eax, throttlefile
	jmp	.L127
.L143:
	subl	$8, %esp
	pushl	$.LC89
	pushl	-28(%ebp)
	call	strcasecmp
	addl	$16, %esp
	testl	%eax, %eax
	jne	.L144
	subl	$8, %esp
	pushl	-20(%ebp)
	pushl	-28(%ebp)
	call	value_required
	addl	$16, %esp
	subl	$12, %esp
	pushl	-20(%ebp)
	call	e_strdup
	addl	$16, %esp
	movl	%eax, hostname
	jmp	.L127
.L144:
	subl	$8, %esp
	pushl	$.LC90
	pushl	-28(%ebp)
	call	strcasecmp
	addl	$16, %esp
	testl	%eax, %eax
	jne	.L145
	subl	$8, %esp
	pushl	-20(%ebp)
	pushl	-28(%ebp)
	call	value_required
	addl	$16, %esp
	subl	$12, %esp
	pushl	-20(%ebp)
	call	e_strdup
	addl	$16, %esp
	movl	%eax, logfile
	jmp	.L127
.L145:
	subl	$8, %esp
	pushl	$.LC91
	pushl	-28(%ebp)
	call	strcasecmp
	addl	$16, %esp
	testl	%eax, %eax
	jne	.L146
	subl	$8, %esp
	pushl	-20(%ebp)
	pushl	-28(%ebp)
	call	no_value_required
	addl	$16, %esp
	movl	$1, do_vhost
	jmp	.L127
.L146:
	subl	$8, %esp
	pushl	$.LC92
	pushl	-28(%ebp)
	call	strcasecmp
	addl	$16, %esp
	testl	%eax, %eax
	jne	.L147
	subl	$8, %esp
	pushl	-20(%ebp)
	pushl	-28(%ebp)
	call	no_value_required
	addl	$16, %esp
	movl	$0, do_vhost
	jmp	.L127
.L147:
	subl	$8, %esp
	pushl	$.LC93
	pushl	-28(%ebp)
	call	strcasecmp
	addl	$16, %esp
	testl	%eax, %eax
	jne	.L148
	subl	$8, %esp
	pushl	-20(%ebp)
	pushl	-28(%ebp)
	call	no_value_required
	addl	$16, %esp
	movl	$1, do_global_passwd
	jmp	.L127
.L148:
	subl	$8, %esp
	pushl	$.LC94
	pushl	-28(%ebp)
	call	strcasecmp
	addl	$16, %esp
	testl	%eax, %eax
	jne	.L149
	subl	$8, %esp
	pushl	-20(%ebp)
	pushl	-28(%ebp)
	call	no_value_required
	addl	$16, %esp
	movl	$0, do_global_passwd
	jmp	.L127
.L149:
	subl	$8, %esp
	pushl	$.LC95
	pushl	-28(%ebp)
	call	strcasecmp
	addl	$16, %esp
	testl	%eax, %eax
	jne	.L150
	subl	$8, %esp
	pushl	-20(%ebp)
	pushl	-28(%ebp)
	call	value_required
	addl	$16, %esp
	subl	$12, %esp
	pushl	-20(%ebp)
	call	e_strdup
	addl	$16, %esp
	movl	%eax, pidfile
	jmp	.L127
.L150:
	subl	$8, %esp
	pushl	$.LC96
	pushl	-28(%ebp)
	call	strcasecmp
	addl	$16, %esp
	testl	%eax, %eax
	jne	.L151
	subl	$8, %esp
	pushl	-20(%ebp)
	pushl	-28(%ebp)
	call	value_required
	addl	$16, %esp
	subl	$12, %esp
	pushl	-20(%ebp)
	call	e_strdup
	addl	$16, %esp
	movl	%eax, charset
	jmp	.L127
.L151:
	subl	$8, %esp
	pushl	$.LC97
	pushl	-28(%ebp)
	call	strcasecmp
	addl	$16, %esp
	testl	%eax, %eax
	jne	.L152
	subl	$8, %esp
	pushl	-20(%ebp)
	pushl	-28(%ebp)
	call	value_required
	addl	$16, %esp
	subl	$12, %esp
	pushl	-20(%ebp)
	call	e_strdup
	addl	$16, %esp
	movl	%eax, p3p
	jmp	.L127
.L152:
	subl	$8, %esp
	pushl	$.LC98
	pushl	-28(%ebp)
	call	strcasecmp
	addl	$16, %esp
	testl	%eax, %eax
	jne	.L153
	subl	$8, %esp
	pushl	-20(%ebp)
	pushl	-28(%ebp)
	call	value_required
	addl	$16, %esp
	subl	$12, %esp
	pushl	-20(%ebp)
	call	atoi
	addl	$16, %esp
	movl	%eax, max_age
	jmp	.L127
.L153:
	movl	argv0, %edx
	movl	stderr, %eax
	pushl	-28(%ebp)
	pushl	%edx
	pushl	$.LC99
	pushl	%eax
	call	fprintf
	addl	$16, %esp
	subl	$12, %esp
	pushl	$1
	call	exit
.L127:
	movl	-16(%ebp), %eax
	movl	%eax, -12(%ebp)
	subl	$8, %esp
	pushl	$.LC72
	pushl	-12(%ebp)
	call	strspn
	addl	$16, %esp
	addl	%eax, -12(%ebp)
.L122:
	movl	-12(%ebp), %eax
	movzbl	(%eax), %eax
	testb	%al, %al
	jne	.L154
.L120:
	subl	$4, %esp
	pushl	-24(%ebp)
	pushl	$1000
	leal	-128(%ebp), %eax
	pushl	%eax
	call	fgets
	addl	$16, %esp
	testl	%eax, %eax
	jne	.L155
	subl	$12, %esp
	pushl	-24(%ebp)
	call	fclose
	addl	$16, %esp
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
	jne	.L156
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
.L156:
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
	je	.L158
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
.L158:
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
	jne	.L161
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
.L161:
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
	subl	$68, %esp
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
	leal	-66(%ebp), %eax
	pushl	%eax
	call	snprintf
	addl	$16, %esp
	movl	hostname, %eax
	leal	-72(%ebp), %edx
	pushl	%edx
	leal	-56(%ebp), %edx
	pushl	%edx
	leal	-66(%ebp), %edx
	pushl	%edx
	pushl	%eax
	call	getaddrinfo
	addl	$16, %esp
	movl	%eax, -24(%ebp)
	cmpl	$0, -24(%ebp)
	je	.L164
	subl	$12, %esp
	pushl	-24(%ebp)
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
	pushl	-24(%ebp)
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
.L164:
	movl	$0, -16(%ebp)
	movl	$0, -20(%ebp)
	movl	-72(%ebp), %eax
	movl	%eax, -12(%ebp)
	jmp	.L165
.L171:
	movl	-12(%ebp), %eax
	movl	4(%eax), %eax
	cmpl	$2, %eax
	je	.L167
	cmpl	$10, %eax
	jne	.L166
	cmpl	$0, -16(%ebp)
	jne	.L169
	movl	-12(%ebp), %eax
	movl	%eax, -16(%ebp)
	jmp	.L166
.L169:
	jmp	.L166
.L167:
	cmpl	$0, -20(%ebp)
	jne	.L170
	movl	-12(%ebp), %eax
	movl	%eax, -20(%ebp)
	jmp	.L178
.L170:
.L178:
	nop
.L166:
	movl	-12(%ebp), %eax
	movl	28(%eax), %eax
	movl	%eax, -12(%ebp)
.L165:
	cmpl	$0, -12(%ebp)
	jne	.L171
	cmpl	$0, -16(%ebp)
	jne	.L172
	movl	28(%ebp), %eax
	movl	$0, (%eax)
	jmp	.L173
.L172:
	movl	-16(%ebp), %eax
	movl	16(%eax), %eax
	cmpl	24(%ebp), %eax
	jbe	.L174
	movl	-16(%ebp), %eax
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
.L174:
	subl	$4, %esp
	pushl	24(%ebp)
	pushl	$0
	pushl	20(%ebp)
	call	memset
	addl	$16, %esp
	movl	-16(%ebp), %eax
	movl	16(%eax), %edx
	movl	-16(%ebp), %eax
	movl	20(%eax), %eax
	subl	$4, %esp
	pushl	%edx
	pushl	%eax
	pushl	20(%ebp)
	call	memmove
	addl	$16, %esp
	movl	28(%ebp), %eax
	movl	$1, (%eax)
.L173:
	cmpl	$0, -20(%ebp)
	jne	.L175
	movl	16(%ebp), %eax
	movl	$0, (%eax)
	jmp	.L176
.L175:
	movl	-20(%ebp), %eax
	movl	16(%eax), %eax
	cmpl	12(%ebp), %eax
	jbe	.L177
	movl	-20(%ebp), %eax
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
.L177:
	subl	$4, %esp
	pushl	12(%ebp)
	pushl	$0
	pushl	8(%ebp)
	call	memset
	addl	$16, %esp
	movl	-20(%ebp), %eax
	movl	16(%eax), %edx
	movl	-20(%ebp), %eax
	movl	20(%eax), %eax
	subl	$4, %esp
	pushl	%edx
	pushl	%eax
	pushl	8(%ebp)
	call	memmove
	addl	$16, %esp
	movl	16(%ebp), %eax
	movl	$1, (%eax)
.L176:
	movl	-72(%ebp), %eax
	subl	$12, %esp
	pushl	%eax
	call	freeaddrinfo
	addl	$16, %esp
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
	subl	$10036, %esp
	subl	$8, %esp
	pushl	$.LC71
	pushl	8(%ebp)
	call	fopen
	addl	$16, %esp
	movl	%eax, -16(%ebp)
	cmpl	$0, -16(%ebp)
	jne	.L180
	subl	$4, %esp
	pushl	8(%ebp)
	pushl	$.LC13
	pushl	$2
	call	syslog
	addl	$16, %esp
	subl	$12, %esp
	pushl	8(%ebp)
	call	perror
	addl	$16, %esp
	subl	$12, %esp
	pushl	$1
	call	exit
.L180:
	subl	$8, %esp
	pushl	$0
	leal	-10036(%ebp), %eax
	pushl	%eax
	call	gettimeofday
	addl	$16, %esp
	jmp	.L181
.L195:
	subl	$8, %esp
	pushl	$35
	leal	-5020(%ebp), %eax
	pushl	%eax
	call	strchr
	addl	$16, %esp
	movl	%eax, -20(%ebp)
	cmpl	$0, -20(%ebp)
	je	.L182
	movl	-20(%ebp), %eax
	movb	$0, (%eax)
.L182:
	subl	$12, %esp
	leal	-5020(%ebp), %eax
	pushl	%eax
	call	strlen
	addl	$16, %esp
	movl	%eax, -12(%ebp)
	jmp	.L183
.L185:
	subl	$1, -12(%ebp)
	leal	-5020(%ebp), %edx
	movl	-12(%ebp), %eax
	addl	%edx, %eax
	movb	$0, (%eax)
.L183:
	cmpl	$0, -12(%ebp)
	jle	.L184
	movl	-12(%ebp), %eax
	subl	$1, %eax
	movzbl	-5020(%ebp,%eax), %eax
	cmpb	$32, %al
	je	.L185
	movl	-12(%ebp), %eax
	subl	$1, %eax
	movzbl	-5020(%ebp,%eax), %eax
	cmpb	$9, %al
	je	.L185
	movl	-12(%ebp), %eax
	subl	$1, %eax
	movzbl	-5020(%ebp,%eax), %eax
	cmpb	$10, %al
	je	.L185
	movl	-12(%ebp), %eax
	subl	$1, %eax
	movzbl	-5020(%ebp,%eax), %eax
	cmpb	$13, %al
	je	.L185
.L184:
	cmpl	$0, -12(%ebp)
	jne	.L186
	jmp	.L181
.L186:
	subl	$12, %esp
	leal	-10024(%ebp), %eax
	pushl	%eax
	leal	-10028(%ebp), %eax
	pushl	%eax
	leal	-10020(%ebp), %eax
	pushl	%eax
	pushl	$.LC108
	leal	-5020(%ebp), %eax
	pushl	%eax
	call	__isoc99_sscanf
	addl	$32, %esp
	cmpl	$3, %eax
	je	.L187
	leal	-10024(%ebp), %eax
	pushl	%eax
	leal	-10020(%ebp), %eax
	pushl	%eax
	pushl	$.LC109
	leal	-5020(%ebp), %eax
	pushl	%eax
	call	__isoc99_sscanf
	addl	$16, %esp
	cmpl	$2, %eax
	jne	.L188
	movl	$0, -10028(%ebp)
	jmp	.L187
.L188:
	leal	-5020(%ebp), %eax
	pushl	%eax
	pushl	8(%ebp)
	pushl	$.LC110
	pushl	$2
	call	syslog
	addl	$16, %esp
	movl	argv0, %edx
	movl	stderr, %eax
	subl	$12, %esp
	leal	-5020(%ebp), %ecx
	pushl	%ecx
	pushl	8(%ebp)
	pushl	%edx
	pushl	$.LC111
	pushl	%eax
	call	fprintf
	addl	$32, %esp
	jmp	.L181
.L187:
	movzbl	-10020(%ebp), %eax
	cmpb	$47, %al
	jne	.L189
	subl	$8, %esp
	leal	-10020(%ebp), %eax
	addl	$1, %eax
	pushl	%eax
	leal	-10020(%ebp), %eax
	pushl	%eax
	call	strcpy
	addl	$16, %esp
.L189:
	jmp	.L190
.L191:
	movl	-20(%ebp), %eax
	leal	2(%eax), %edx
	movl	-20(%ebp), %eax
	addl	$1, %eax
	subl	$8, %esp
	pushl	%edx
	pushl	%eax
	call	strcpy
	addl	$16, %esp
.L190:
	subl	$8, %esp
	pushl	$.LC112
	leal	-10020(%ebp), %eax
	pushl	%eax
	call	strstr
	addl	$16, %esp
	movl	%eax, -20(%ebp)
	cmpl	$0, -20(%ebp)
	jne	.L191
	movl	numthrottles, %edx
	movl	maxthrottles, %eax
	cmpl	%eax, %edx
	jl	.L192
	movl	maxthrottles, %eax
	testl	%eax, %eax
	jne	.L193
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
	jmp	.L194
.L193:
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
.L194:
	movl	throttles, %eax
	testl	%eax, %eax
	jne	.L192
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
.L192:
	movl	throttles, %edx
	movl	numthrottles, %eax
	movl	%eax, %ecx
	movl	%ecx, %eax
	addl	%eax, %eax
	addl	%ecx, %eax
	sall	$3, %eax
	leal	(%edx,%eax), %ebx
	subl	$12, %esp
	leal	-10020(%ebp), %eax
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
	movl	-10024(%ebp), %eax
	movl	%eax, 4(%edx)
	movl	throttles, %edx
	movl	numthrottles, %eax
	movl	%eax, %ecx
	movl	%ecx, %eax
	addl	%eax, %eax
	addl	%ecx, %eax
	sall	$3, %eax
	addl	%eax, %edx
	movl	-10028(%ebp), %eax
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
.L181:
	subl	$4, %esp
	pushl	-16(%ebp)
	pushl	$5000
	leal	-5020(%ebp), %eax
	pushl	%eax
	call	fgets
	addl	$16, %esp
	testl	%eax, %eax
	jne	.L195
	subl	$12, %esp
	pushl	-16(%ebp)
	call	fclose
	addl	$16, %esp
	movl	-4(%ebp), %ebx
	leave
	ret
	.size	read_throttlefile, .-read_throttlefile
	.type	shut_down, @function
shut_down:
	pushl	%ebp
	movl	%esp, %ebp
	subl	$24, %esp
	subl	$8, %esp
	pushl	$0
	leal	-24(%ebp), %eax
	pushl	%eax
	call	gettimeofday
	addl	$16, %esp
	subl	$12, %esp
	leal	-24(%ebp), %eax
	pushl	%eax
	call	logstats
	addl	$16, %esp
	movl	$0, -12(%ebp)
	jmp	.L197
.L200:
	movl	connects, %ecx
	movl	-12(%ebp), %edx
	movl	%edx, %eax
	addl	%eax, %eax
	addl	%edx, %eax
	sall	$5, %eax
	addl	%ecx, %eax
	movl	(%eax), %eax
	testl	%eax, %eax
	je	.L198
	movl	connects, %ecx
	movl	-12(%ebp), %edx
	movl	%edx, %eax
	addl	%eax, %eax
	addl	%edx, %eax
	sall	$5, %eax
	addl	%ecx, %eax
	movl	8(%eax), %eax
	subl	$8, %esp
	leal	-24(%ebp), %edx
	pushl	%edx
	pushl	%eax
	call	httpd_close_conn
	addl	$16, %esp
.L198:
	movl	connects, %ecx
	movl	-12(%ebp), %edx
	movl	%edx, %eax
	addl	%eax, %eax
	addl	%edx, %eax
	sall	$5, %eax
	addl	%ecx, %eax
	movl	8(%eax), %eax
	testl	%eax, %eax
	je	.L199
	movl	connects, %ecx
	movl	-12(%ebp), %edx
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
	movl	-12(%ebp), %edx
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
	movl	-12(%ebp), %edx
	movl	%edx, %eax
	addl	%eax, %eax
	addl	%edx, %eax
	sall	$5, %eax
	addl	%ecx, %eax
	movl	$0, 8(%eax)
.L199:
	addl	$1, -12(%ebp)
.L197:
	movl	max_connects, %eax
	cmpl	%eax, -12(%ebp)
	jl	.L200
	movl	hs, %eax
	testl	%eax, %eax
	je	.L201
	movl	hs, %eax
	movl	%eax, -16(%ebp)
	movl	$0, hs
	movl	-16(%ebp), %eax
	movl	40(%eax), %eax
	cmpl	$-1, %eax
	je	.L202
	movl	-16(%ebp), %eax
	movl	40(%eax), %eax
	subl	$12, %esp
	pushl	%eax
	call	fdwatch_del_fd
	addl	$16, %esp
.L202:
	movl	-16(%ebp), %eax
	movl	44(%eax), %eax
	cmpl	$-1, %eax
	je	.L203
	movl	-16(%ebp), %eax
	movl	44(%eax), %eax
	subl	$12, %esp
	pushl	%eax
	call	fdwatch_del_fd
	addl	$16, %esp
.L203:
	subl	$12, %esp
	pushl	-16(%ebp)
	call	httpd_terminate
	addl	$16, %esp
.L201:
	call	mmc_destroy
	call	tmr_destroy
	movl	connects, %eax
	subl	$12, %esp
	pushl	%eax
	call	free
	addl	$16, %esp
	movl	throttles, %eax
	testl	%eax, %eax
	je	.L196
	movl	throttles, %eax
	subl	$12, %esp
	pushl	%eax
	call	free
	addl	$16, %esp
.L196:
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
.L216:
	movl	num_connects, %edx
	movl	max_connects, %eax
	cmpl	%eax, %edx
	jl	.L206
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
	jmp	.L217
.L206:
	movl	first_free_connect, %eax
	cmpl	$-1, %eax
	je	.L208
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
	je	.L209
.L208:
	subl	$8, %esp
	pushl	$.LC116
	pushl	$2
	call	syslog
	addl	$16, %esp
	subl	$12, %esp
	pushl	$1
	call	exit
.L209:
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
	jne	.L210
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
	jne	.L211
	subl	$8, %esp
	pushl	$.LC117
	pushl	$2
	call	syslog
	addl	$16, %esp
	subl	$12, %esp
	pushl	$1
	call	exit
.L211:
	movl	-12(%ebp), %eax
	movl	8(%eax), %eax
	movl	$0, (%eax)
	movl	httpd_conn_count, %eax
	addl	$1, %eax
	movl	%eax, httpd_conn_count
.L210:
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
	je	.L213
	cmpl	$2, %eax
	je	.L214
	jmp	.L218
.L213:
	subl	$12, %esp
	pushl	8(%ebp)
	call	tmr_run
	addl	$16, %esp
	movl	$0, %eax
	jmp	.L217
.L214:
	movl	$1, %eax
	jmp	.L217
.L218:
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
	jle	.L215
	movl	num_connects, %eax
	movl	%eax, stats_simultaneous
.L215:
	jmp	.L216
.L217:
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
	jb	.L220
	movl	-16(%ebp), %eax
	movl	140(%eax), %eax
	cmpl	$5000, %eax
	jbe	.L221
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
	jmp	.L219
.L221:
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
.L220:
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
	movl	%eax, -20(%ebp)
	cmpl	$0, -20(%ebp)
	jne	.L223
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
	jmp	.L219
.L223:
	cmpl	$0, -20(%ebp)
	jns	.L224
	call	__errno_location
	movl	(%eax), %eax
	cmpl	$4, %eax
	je	.L225
	call	__errno_location
	movl	(%eax), %eax
	cmpl	$11, %eax
	je	.L225
	call	__errno_location
	movl	(%eax), %eax
	cmpl	$11, %eax
	jne	.L226
.L225:
	jmp	.L219
.L226:
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
	jmp	.L219
.L224:
	movl	-16(%ebp), %eax
	movl	144(%eax), %edx
	movl	-20(%ebp), %eax
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
	je	.L242
	cmpl	$2, %eax
	jne	.L241
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
	jmp	.L219
.L241:
	subl	$12, %esp
	pushl	-16(%ebp)
	call	httpd_parse_request
	addl	$16, %esp
	testl	%eax, %eax
	jns	.L230
	subl	$8, %esp
	pushl	12(%ebp)
	pushl	8(%ebp)
	call	finish_connection
	addl	$16, %esp
	jmp	.L219
.L230:
	subl	$12, %esp
	pushl	8(%ebp)
	call	check_throttles
	addl	$16, %esp
	testl	%eax, %eax
	jne	.L231
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
	jmp	.L219
.L231:
	subl	$8, %esp
	pushl	12(%ebp)
	pushl	-16(%ebp)
	call	httpd_start_request
	addl	$16, %esp
	testl	%eax, %eax
	jns	.L232
	subl	$8, %esp
	pushl	12(%ebp)
	pushl	8(%ebp)
	call	finish_connection
	addl	$16, %esp
	jmp	.L219
.L232:
	movl	-16(%ebp), %eax
	movl	336(%eax), %eax
	testl	%eax, %eax
	je	.L233
	movl	-16(%ebp), %eax
	movl	344(%eax), %edx
	movl	8(%ebp), %eax
	movl	%edx, 92(%eax)
	movl	-16(%ebp), %eax
	movl	348(%eax), %eax
	leal	1(%eax), %edx
	movl	8(%ebp), %eax
	movl	%edx, 88(%eax)
	jmp	.L234
.L233:
	movl	-16(%ebp), %eax
	movl	164(%eax), %eax
	testl	%eax, %eax
	jns	.L235
	movl	8(%ebp), %eax
	movl	$0, 88(%eax)
	jmp	.L234
.L235:
	movl	-16(%ebp), %eax
	movl	164(%eax), %edx
	movl	8(%ebp), %eax
	movl	%edx, 88(%eax)
.L234:
	movl	-16(%ebp), %eax
	movl	452(%eax), %eax
	testl	%eax, %eax
	jne	.L236
	movl	$0, -12(%ebp)
	jmp	.L237
.L238:
	movl	throttles, %ecx
	movl	8(%ebp), %eax
	movl	-12(%ebp), %edx
	movl	12(%eax,%edx,4), %eax
	movl	%eax, %edx
	movl	%edx, %eax
	addl	%eax, %eax
	addl	%edx, %eax
	sall	$3, %eax
	addl	%eax, %ecx
	movl	throttles, %ebx
	movl	8(%ebp), %eax
	movl	-12(%ebp), %edx
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
	addl	$1, -12(%ebp)
.L237:
	movl	8(%ebp), %eax
	movl	52(%eax), %eax
	cmpl	-12(%ebp), %eax
	jg	.L238
	movl	-16(%ebp), %eax
	movl	168(%eax), %edx
	movl	8(%ebp), %eax
	movl	%edx, 92(%eax)
	subl	$8, %esp
	pushl	12(%ebp)
	pushl	8(%ebp)
	call	finish_connection
	addl	$16, %esp
	jmp	.L219
.L236:
	movl	8(%ebp), %eax
	movl	92(%eax), %edx
	movl	8(%ebp), %eax
	movl	88(%eax), %eax
	cmpl	%eax, %edx
	jl	.L239
	subl	$8, %esp
	pushl	12(%ebp)
	pushl	8(%ebp)
	call	finish_connection
	addl	$16, %esp
	jmp	.L219
.L239:
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
	jmp	.L219
.L242:
	nop
.L219:
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
	subl	$52, %esp
	movl	8(%ebp), %eax
	movl	8(%eax), %eax
	movl	%eax, -28(%ebp)
	movl	8(%ebp), %eax
	movl	56(%eax), %eax
	cmpl	$-1, %eax
	jne	.L244
	movl	$1000000000, -12(%ebp)
	jmp	.L245
.L244:
	movl	8(%ebp), %eax
	movl	56(%eax), %eax
	leal	3(%eax), %edx
	testl	%eax, %eax
	cmovs	%edx, %eax
	sarl	$2, %eax
	movl	%eax, -12(%ebp)
.L245:
	movl	-28(%ebp), %eax
	movl	304(%eax), %eax
	testl	%eax, %eax
	jne	.L246
	movl	8(%ebp), %eax
	movl	88(%eax), %edx
	movl	8(%ebp), %eax
	movl	92(%eax), %eax
	subl	%eax, %edx
	movl	%edx, %eax
	movl	%eax, %edx
	movl	-12(%ebp), %eax
	cmpl	%eax, %edx
	cmova	%eax, %edx
	movl	-28(%ebp), %eax
	movl	452(%eax), %ecx
	movl	8(%ebp), %eax
	movl	92(%eax), %eax
	addl	%eax, %ecx
	movl	-28(%ebp), %eax
	movl	448(%eax), %eax
	subl	$4, %esp
	pushl	%edx
	pushl	%ecx
	pushl	%eax
	call	write
	addl	$16, %esp
	movl	%eax, -16(%ebp)
	jmp	.L247
.L246:
	movl	-28(%ebp), %eax
	movl	252(%eax), %eax
	movl	%eax, -56(%ebp)
	movl	-28(%ebp), %eax
	movl	304(%eax), %eax
	movl	%eax, -52(%ebp)
	movl	-28(%ebp), %eax
	movl	452(%eax), %edx
	movl	8(%ebp), %eax
	movl	92(%eax), %eax
	addl	%edx, %eax
	movl	%eax, -48(%ebp)
	movl	8(%ebp), %eax
	movl	88(%eax), %edx
	movl	8(%ebp), %eax
	movl	92(%eax), %eax
	subl	%eax, %edx
	movl	%edx, %eax
	movl	%eax, %edx
	movl	-12(%ebp), %eax
	cmpl	%eax, %edx
	cmovbe	%edx, %eax
	movl	%eax, -44(%ebp)
	movl	-28(%ebp), %eax
	movl	448(%eax), %eax
	subl	$4, %esp
	pushl	$2
	leal	-56(%ebp), %edx
	pushl	%edx
	pushl	%eax
	call	writev
	addl	$16, %esp
	movl	%eax, -16(%ebp)
.L247:
	cmpl	$0, -16(%ebp)
	jns	.L248
	call	__errno_location
	movl	(%eax), %eax
	cmpl	$4, %eax
	jne	.L248
	jmp	.L243
.L248:
	cmpl	$0, -16(%ebp)
	je	.L250
	cmpl	$0, -16(%ebp)
	jns	.L251
	call	__errno_location
	movl	(%eax), %eax
	cmpl	$11, %eax
	je	.L250
	call	__errno_location
	movl	(%eax), %eax
	cmpl	$11, %eax
	jne	.L251
.L250:
	movl	8(%ebp), %eax
	movl	80(%eax), %eax
	leal	100(%eax), %edx
	movl	8(%ebp), %eax
	movl	%edx, 80(%eax)
	movl	8(%ebp), %eax
	movl	$3, (%eax)
	movl	-28(%ebp), %eax
	movl	448(%eax), %eax
	subl	$12, %esp
	pushl	%eax
	call	fdwatch_del_fd
	addl	$16, %esp
	movl	8(%ebp), %eax
	movl	%eax, -40(%ebp)
	movl	8(%ebp), %eax
	movl	72(%eax), %eax
	testl	%eax, %eax
	je	.L252
	subl	$8, %esp
	pushl	$.LC118
	pushl	$3
	call	syslog
	addl	$16, %esp
.L252:
	movl	8(%ebp), %eax
	movl	80(%eax), %eax
	subl	$12, %esp
	pushl	$0
	pushl	%eax
	pushl	-40(%ebp)
	pushl	$wakeup_connection
	pushl	12(%ebp)
	call	tmr_create
	addl	$32, %esp
	movl	%eax, %edx
	movl	8(%ebp), %eax
	movl	%edx, 72(%eax)
	movl	8(%ebp), %eax
	movl	72(%eax), %eax
	testl	%eax, %eax
	jne	.L253
	subl	$8, %esp
	pushl	$.LC119
	pushl	$2
	call	syslog
	addl	$16, %esp
	subl	$12, %esp
	pushl	$1
	call	exit
.L253:
	jmp	.L243
.L251:
	cmpl	$0, -16(%ebp)
	jns	.L254
	call	__errno_location
	movl	(%eax), %eax
	cmpl	$32, %eax
	je	.L255
	call	__errno_location
	movl	(%eax), %eax
	cmpl	$22, %eax
	je	.L255
	call	__errno_location
	movl	(%eax), %eax
	cmpl	$104, %eax
	je	.L255
	movl	-28(%ebp), %eax
	movl	172(%eax), %eax
	subl	$4, %esp
	pushl	%eax
	pushl	$.LC120
	pushl	$3
	call	syslog
	addl	$16, %esp
.L255:
	subl	$8, %esp
	pushl	12(%ebp)
	pushl	8(%ebp)
	call	clear_connection
	addl	$16, %esp
	jmp	.L243
.L254:
	movl	12(%ebp), %eax
	movl	(%eax), %edx
	movl	8(%ebp), %eax
	movl	%edx, 68(%eax)
	movl	-28(%ebp), %eax
	movl	304(%eax), %eax
	testl	%eax, %eax
	je	.L256
	movl	-16(%ebp), %edx
	movl	-28(%ebp), %eax
	movl	304(%eax), %eax
	cmpl	%eax, %edx
	jae	.L257
	movl	-28(%ebp), %eax
	movl	304(%eax), %edx
	movl	-16(%ebp), %eax
	subl	%eax, %edx
	movl	%edx, %eax
	movl	%eax, -32(%ebp)
	movl	-32(%ebp), %edx
	movl	-28(%ebp), %eax
	movl	252(%eax), %ecx
	movl	-16(%ebp), %eax
	addl	%eax, %ecx
	movl	-28(%ebp), %eax
	movl	252(%eax), %eax
	subl	$4, %esp
	pushl	%edx
	pushl	%ecx
	pushl	%eax
	call	memmove
	addl	$16, %esp
	movl	-32(%ebp), %edx
	movl	-28(%ebp), %eax
	movl	%edx, 304(%eax)
	movl	$0, -16(%ebp)
	jmp	.L256
.L257:
	movl	-16(%ebp), %edx
	movl	-28(%ebp), %eax
	movl	304(%eax), %eax
	subl	%eax, %edx
	movl	%edx, %eax
	movl	%eax, -16(%ebp)
	movl	-28(%ebp), %eax
	movl	$0, 304(%eax)
.L256:
	movl	8(%ebp), %eax
	movl	92(%eax), %edx
	movl	-16(%ebp), %eax
	addl	%eax, %edx
	movl	8(%ebp), %eax
	movl	%edx, 92(%eax)
	movl	8(%ebp), %eax
	movl	8(%eax), %eax
	movl	8(%ebp), %edx
	movl	8(%edx), %edx
	movl	168(%edx), %ecx
	movl	-16(%ebp), %edx
	addl	%ecx, %edx
	movl	%edx, 168(%eax)
	movl	$0, -24(%ebp)
	jmp	.L258
.L259:
	movl	throttles, %ecx
	movl	8(%ebp), %eax
	movl	-24(%ebp), %edx
	movl	12(%eax,%edx,4), %eax
	movl	%eax, %edx
	movl	%edx, %eax
	addl	%eax, %eax
	addl	%edx, %eax
	sall	$3, %eax
	addl	%eax, %ecx
	movl	throttles, %ebx
	movl	8(%ebp), %eax
	movl	-24(%ebp), %edx
	movl	12(%eax,%edx,4), %eax
	movl	%eax, %edx
	movl	%edx, %eax
	addl	%eax, %eax
	addl	%edx, %eax
	sall	$3, %eax
	addl	%ebx, %eax
	movl	16(%eax), %edx
	movl	-16(%ebp), %eax
	addl	%edx, %eax
	movl	%eax, 16(%ecx)
	addl	$1, -24(%ebp)
.L258:
	movl	8(%ebp), %eax
	movl	52(%eax), %eax
	cmpl	-24(%ebp), %eax
	jg	.L259
	movl	8(%ebp), %eax
	movl	92(%eax), %edx
	movl	8(%ebp), %eax
	movl	88(%eax), %eax
	cmpl	%eax, %edx
	jl	.L260
	subl	$8, %esp
	pushl	12(%ebp)
	pushl	8(%ebp)
	call	finish_connection
	addl	$16, %esp
	jmp	.L243
.L260:
	movl	8(%ebp), %eax
	movl	80(%eax), %eax
	cmpl	$100, %eax
	jle	.L261
	movl	8(%ebp), %eax
	movl	80(%eax), %eax
	leal	-100(%eax), %edx
	movl	8(%ebp), %eax
	movl	%edx, 80(%eax)
.L261:
	movl	8(%ebp), %eax
	movl	56(%eax), %eax
	cmpl	$-1, %eax
	je	.L243
	movl	12(%ebp), %eax
	movl	(%eax), %edx
	movl	8(%ebp), %eax
	movl	64(%eax), %eax
	subl	%eax, %edx
	movl	%edx, %eax
	movl	%eax, -20(%ebp)
	cmpl	$0, -20(%ebp)
	jne	.L263
	movl	$1, -20(%ebp)
.L263:
	movl	8(%ebp), %eax
	movl	8(%eax), %eax
	movl	168(%eax), %eax
	cltd
	idivl	-20(%ebp)
	movl	%eax, %edx
	movl	8(%ebp), %eax
	movl	56(%eax), %eax
	cmpl	%eax, %edx
	jle	.L243
	movl	8(%ebp), %eax
	movl	$3, (%eax)
	movl	-28(%ebp), %eax
	movl	448(%eax), %eax
	subl	$12, %esp
	pushl	%eax
	call	fdwatch_del_fd
	addl	$16, %esp
	movl	8(%ebp), %eax
	movl	8(%eax), %eax
	movl	168(%eax), %eax
	movl	8(%ebp), %edx
	movl	56(%edx), %ebx
	cltd
	idivl	%ebx
	subl	-20(%ebp), %eax
	movl	%eax, -36(%ebp)
	movl	8(%ebp), %eax
	movl	%eax, -40(%ebp)
	movl	8(%ebp), %eax
	movl	72(%eax), %eax
	testl	%eax, %eax
	je	.L264
	subl	$8, %esp
	pushl	$.LC118
	pushl	$3
	call	syslog
	addl	$16, %esp
.L264:
	cmpl	$0, -36(%ebp)
	jle	.L265
	movl	-36(%ebp), %eax
	imull	$1000, %eax, %eax
	jmp	.L266
.L265:
	movl	$500, %eax
.L266:
	subl	$12, %esp
	pushl	$0
	pushl	%eax
	pushl	-40(%ebp)
	pushl	$wakeup_connection
	pushl	12(%ebp)
	call	tmr_create
	addl	$32, %esp
	movl	%eax, %edx
	movl	8(%ebp), %eax
	movl	%edx, 72(%eax)
	movl	8(%ebp), %eax
	movl	72(%eax), %eax
	testl	%eax, %eax
	jne	.L243
	subl	$8, %esp
	pushl	$.LC119
	pushl	$2
	call	syslog
	addl	$16, %esp
	subl	$12, %esp
	pushl	$1
	call	exit
.L243:
	movl	-4(%ebp), %ebx
	leave
	ret
	.size	handle_send, .-handle_send
	.type	handle_linger, @function
handle_linger:
	pushl	%ebp
	movl	%esp, %ebp
	subl	$4120, %esp
	movl	8(%ebp), %eax
	movl	8(%eax), %eax
	movl	448(%eax), %eax
	subl	$4, %esp
	pushl	$4096
	leal	-4108(%ebp), %edx
	pushl	%edx
	pushl	%eax
	call	read
	addl	$16, %esp
	movl	%eax, -12(%ebp)
	cmpl	$0, -12(%ebp)
	jns	.L269
	call	__errno_location
	movl	(%eax), %eax
	cmpl	$4, %eax
	je	.L268
	call	__errno_location
	movl	(%eax), %eax
	cmpl	$11, %eax
	je	.L268
.L269:
	cmpl	$0, -12(%ebp)
	jg	.L268
	subl	$8, %esp
	pushl	12(%ebp)
	pushl	8(%ebp)
	call	really_clear_connection
	addl	$16, %esp
.L268:
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
	movl	$0, -12(%ebp)
	jmp	.L274
.L284:
	movl	8(%ebp), %eax
	movl	8(%eax), %eax
	movl	188(%eax), %ecx
	movl	throttles, %ebx
	movl	-12(%ebp), %edx
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
	je	.L275
	movl	throttles, %ecx
	movl	-12(%ebp), %edx
	movl	%edx, %eax
	addl	%eax, %eax
	addl	%edx, %eax
	sall	$3, %eax
	addl	%ecx, %eax
	movl	12(%eax), %ecx
	movl	throttles, %ebx
	movl	-12(%ebp), %edx
	movl	%edx, %eax
	addl	%eax, %eax
	addl	%edx, %eax
	sall	$3, %eax
	addl	%ebx, %eax
	movl	4(%eax), %eax
	addl	%eax, %eax
	cmpl	%eax, %ecx
	jle	.L276
	movl	$0, %eax
	jmp	.L277
.L276:
	movl	throttles, %ecx
	movl	-12(%ebp), %edx
	movl	%edx, %eax
	addl	%eax, %eax
	addl	%edx, %eax
	sall	$3, %eax
	addl	%ecx, %eax
	movl	12(%eax), %ecx
	movl	throttles, %ebx
	movl	-12(%ebp), %edx
	movl	%edx, %eax
	addl	%eax, %eax
	addl	%edx, %eax
	sall	$3, %eax
	addl	%ebx, %eax
	movl	8(%eax), %eax
	cmpl	%eax, %ecx
	jge	.L278
	movl	$0, %eax
	jmp	.L277
.L278:
	movl	throttles, %ecx
	movl	-12(%ebp), %edx
	movl	%edx, %eax
	addl	%eax, %eax
	addl	%edx, %eax
	sall	$3, %eax
	addl	%ecx, %eax
	movl	20(%eax), %eax
	testl	%eax, %eax
	jns	.L279
	subl	$8, %esp
	pushl	$.LC121
	pushl	$3
	call	syslog
	addl	$16, %esp
	movl	throttles, %ecx
	movl	-12(%ebp), %edx
	movl	%edx, %eax
	addl	%eax, %eax
	addl	%edx, %eax
	sall	$3, %eax
	addl	%ecx, %eax
	movl	$0, 20(%eax)
.L279:
	movl	8(%ebp), %eax
	movl	52(%eax), %eax
	leal	1(%eax), %ecx
	movl	8(%ebp), %edx
	movl	%ecx, 52(%edx)
	movl	8(%ebp), %edx
	movl	-12(%ebp), %ecx
	movl	%ecx, 12(%edx,%eax,4)
	movl	throttles, %ecx
	movl	-12(%ebp), %edx
	movl	%edx, %eax
	addl	%eax, %eax
	addl	%edx, %eax
	sall	$3, %eax
	addl	%ecx, %eax
	movl	20(%eax), %edx
	addl	$1, %edx
	movl	%edx, 20(%eax)
	movl	throttles, %ecx
	movl	-12(%ebp), %edx
	movl	%edx, %eax
	addl	%eax, %eax
	addl	%edx, %eax
	sall	$3, %eax
	addl	%ecx, %eax
	movl	4(%eax), %ecx
	movl	throttles, %ebx
	movl	-12(%ebp), %edx
	movl	%edx, %eax
	addl	%eax, %eax
	addl	%edx, %eax
	sall	$3, %eax
	addl	%ebx, %eax
	movl	20(%eax), %ebx
	movl	%ecx, %eax
	cltd
	idivl	%ebx
	movl	%eax, -16(%ebp)
	movl	8(%ebp), %eax
	movl	56(%eax), %eax
	cmpl	$-1, %eax
	jne	.L280
	movl	8(%ebp), %eax
	movl	-16(%ebp), %edx
	movl	%edx, 56(%eax)
	jmp	.L281
.L280:
	movl	8(%ebp), %eax
	movl	56(%eax), %edx
	movl	-16(%ebp), %eax
	cmpl	%eax, %edx
	cmovg	%eax, %edx
	movl	8(%ebp), %eax
	movl	%edx, 56(%eax)
.L281:
	movl	throttles, %ecx
	movl	-12(%ebp), %edx
	movl	%edx, %eax
	addl	%eax, %eax
	addl	%edx, %eax
	sall	$3, %eax
	addl	%ecx, %eax
	movl	8(%eax), %eax
	movl	%eax, -16(%ebp)
	movl	8(%ebp), %eax
	movl	60(%eax), %eax
	cmpl	$-1, %eax
	jne	.L282
	movl	8(%ebp), %eax
	movl	-16(%ebp), %edx
	movl	%edx, 60(%eax)
	jmp	.L275
.L282:
	movl	8(%ebp), %eax
	movl	60(%eax), %edx
	movl	-16(%ebp), %eax
	cmpl	%eax, %edx
	cmovl	%eax, %edx
	movl	8(%ebp), %eax
	movl	%edx, 60(%eax)
.L275:
	addl	$1, -12(%ebp)
.L274:
	movl	numthrottles, %eax
	cmpl	%eax, -12(%ebp)
	jge	.L283
	movl	8(%ebp), %eax
	movl	52(%eax), %eax
	cmpl	$9, %eax
	jle	.L284
.L283:
	movl	$1, %eax
.L277:
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
	jmp	.L286
.L287:
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
.L286:
	movl	8(%ebp), %eax
	movl	52(%eax), %eax
	cmpl	-4(%ebp), %eax
	jg	.L287
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
	movl	$0, -28(%ebp)
	jmp	.L289
.L293:
	movl	throttles, %ecx
	movl	-28(%ebp), %edx
	movl	%edx, %eax
	addl	%eax, %eax
	addl	%edx, %eax
	sall	$3, %eax
	leal	(%ecx,%eax), %ebx
	movl	throttles, %ecx
	movl	-28(%ebp), %edx
	movl	%edx, %eax
	addl	%eax, %eax
	addl	%edx, %eax
	sall	$3, %eax
	addl	%ecx, %eax
	movl	12(%eax), %eax
	leal	(%eax,%eax), %esi
	movl	throttles, %ecx
	movl	-28(%ebp), %edx
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
	movl	-28(%ebp), %edx
	movl	%edx, %eax
	addl	%eax, %eax
	addl	%edx, %eax
	sall	$3, %eax
	addl	%ecx, %eax
	movl	$0, 16(%eax)
	movl	throttles, %ecx
	movl	-28(%ebp), %edx
	movl	%edx, %eax
	addl	%eax, %eax
	addl	%edx, %eax
	sall	$3, %eax
	addl	%ecx, %eax
	movl	12(%eax), %ecx
	movl	throttles, %ebx
	movl	-28(%ebp), %edx
	movl	%edx, %eax
	addl	%eax, %eax
	addl	%edx, %eax
	sall	$3, %eax
	addl	%ebx, %eax
	movl	4(%eax), %eax
	cmpl	%eax, %ecx
	jle	.L290
	movl	throttles, %ecx
	movl	-28(%ebp), %edx
	movl	%edx, %eax
	addl	%eax, %eax
	addl	%edx, %eax
	sall	$3, %eax
	addl	%ecx, %eax
	movl	20(%eax), %eax
	testl	%eax, %eax
	je	.L290
	movl	throttles, %ecx
	movl	-28(%ebp), %edx
	movl	%edx, %eax
	addl	%eax, %eax
	addl	%edx, %eax
	sall	$3, %eax
	addl	%ecx, %eax
	movl	12(%eax), %ecx
	movl	throttles, %ebx
	movl	-28(%ebp), %edx
	movl	%edx, %eax
	addl	%eax, %eax
	addl	%edx, %eax
	sall	$3, %eax
	addl	%ebx, %eax
	movl	4(%eax), %eax
	addl	%eax, %eax
	cmpl	%eax, %ecx
	jle	.L291
	movl	throttles, %ecx
	movl	-28(%ebp), %edx
	movl	%edx, %eax
	addl	%eax, %eax
	addl	%edx, %eax
	sall	$3, %eax
	addl	%ecx, %eax
	movl	20(%eax), %esi
	movl	throttles, %ecx
	movl	-28(%ebp), %edx
	movl	%edx, %eax
	addl	%eax, %eax
	addl	%edx, %eax
	sall	$3, %eax
	addl	%ecx, %eax
	movl	4(%eax), %ebx
	movl	throttles, %ecx
	movl	-28(%ebp), %edx
	movl	%edx, %eax
	addl	%eax, %eax
	addl	%edx, %eax
	sall	$3, %eax
	addl	%ecx, %eax
	movl	12(%eax), %ecx
	movl	throttles, %edi
	movl	-28(%ebp), %edx
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
	pushl	-28(%ebp)
	pushl	$.LC122
	pushl	$5
	call	syslog
	addl	$32, %esp
	jmp	.L290
.L291:
	movl	throttles, %ecx
	movl	-28(%ebp), %edx
	movl	%edx, %eax
	addl	%eax, %eax
	addl	%edx, %eax
	sall	$3, %eax
	addl	%ecx, %eax
	movl	20(%eax), %esi
	movl	throttles, %ecx
	movl	-28(%ebp), %edx
	movl	%edx, %eax
	addl	%eax, %eax
	addl	%edx, %eax
	sall	$3, %eax
	addl	%ecx, %eax
	movl	4(%eax), %ebx
	movl	throttles, %ecx
	movl	-28(%ebp), %edx
	movl	%edx, %eax
	addl	%eax, %eax
	addl	%edx, %eax
	sall	$3, %eax
	addl	%ecx, %eax
	movl	12(%eax), %ecx
	movl	throttles, %edi
	movl	-28(%ebp), %edx
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
	pushl	-28(%ebp)
	pushl	$.LC123
	pushl	$6
	call	syslog
	addl	$32, %esp
.L290:
	movl	throttles, %ecx
	movl	-28(%ebp), %edx
	movl	%edx, %eax
	addl	%eax, %eax
	addl	%edx, %eax
	sall	$3, %eax
	addl	%ecx, %eax
	movl	12(%eax), %ecx
	movl	throttles, %ebx
	movl	-28(%ebp), %edx
	movl	%edx, %eax
	addl	%eax, %eax
	addl	%edx, %eax
	sall	$3, %eax
	addl	%ebx, %eax
	movl	8(%eax), %eax
	cmpl	%eax, %ecx
	jge	.L292
	movl	throttles, %ecx
	movl	-28(%ebp), %edx
	movl	%edx, %eax
	addl	%eax, %eax
	addl	%edx, %eax
	sall	$3, %eax
	addl	%ecx, %eax
	movl	20(%eax), %eax
	testl	%eax, %eax
	je	.L292
	movl	throttles, %ecx
	movl	-28(%ebp), %edx
	movl	%edx, %eax
	addl	%eax, %eax
	addl	%edx, %eax
	sall	$3, %eax
	addl	%ecx, %eax
	movl	20(%eax), %esi
	movl	throttles, %ecx
	movl	-28(%ebp), %edx
	movl	%edx, %eax
	addl	%eax, %eax
	addl	%edx, %eax
	sall	$3, %eax
	addl	%ecx, %eax
	movl	8(%eax), %ebx
	movl	throttles, %ecx
	movl	-28(%ebp), %edx
	movl	%edx, %eax
	addl	%eax, %eax
	addl	%edx, %eax
	sall	$3, %eax
	addl	%ecx, %eax
	movl	12(%eax), %ecx
	movl	throttles, %edi
	movl	-28(%ebp), %edx
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
	pushl	-28(%ebp)
	pushl	$.LC124
	pushl	$5
	call	syslog
	addl	$32, %esp
.L292:
	addl	$1, -28(%ebp)
.L289:
	movl	numthrottles, %eax
	cmpl	%eax, -28(%ebp)
	jl	.L293
	movl	$0, -36(%ebp)
	jmp	.L294
.L301:
	movl	connects, %ecx
	movl	-36(%ebp), %edx
	movl	%edx, %eax
	addl	%eax, %eax
	addl	%edx, %eax
	sall	$5, %eax
	addl	%ecx, %eax
	movl	%eax, -40(%ebp)
	movl	-40(%ebp), %eax
	movl	(%eax), %eax
	cmpl	$2, %eax
	je	.L295
	movl	-40(%ebp), %eax
	movl	(%eax), %eax
	cmpl	$3, %eax
	jne	.L296
.L295:
	movl	-40(%ebp), %eax
	movl	$-1, 56(%eax)
	movl	$0, -32(%ebp)
	jmp	.L297
.L300:
	movl	-40(%ebp), %eax
	movl	-32(%ebp), %edx
	movl	12(%eax,%edx,4), %eax
	movl	%eax, -28(%ebp)
	movl	throttles, %ecx
	movl	-28(%ebp), %edx
	movl	%edx, %eax
	addl	%eax, %eax
	addl	%edx, %eax
	sall	$3, %eax
	addl	%ecx, %eax
	movl	4(%eax), %ecx
	movl	throttles, %ebx
	movl	-28(%ebp), %edx
	movl	%edx, %eax
	addl	%eax, %eax
	addl	%edx, %eax
	sall	$3, %eax
	addl	%ebx, %eax
	movl	20(%eax), %edi
	movl	%ecx, %eax
	cltd
	idivl	%edi
	movl	%eax, -44(%ebp)
	movl	-40(%ebp), %eax
	movl	56(%eax), %eax
	cmpl	$-1, %eax
	jne	.L298
	movl	-40(%ebp), %eax
	movl	-44(%ebp), %edx
	movl	%edx, 56(%eax)
	jmp	.L299
.L298:
	movl	-40(%ebp), %eax
	movl	56(%eax), %edx
	movl	-44(%ebp), %eax
	cmpl	%eax, %edx
	cmovg	%eax, %edx
	movl	-40(%ebp), %eax
	movl	%edx, 56(%eax)
.L299:
	addl	$1, -32(%ebp)
.L297:
	movl	-40(%ebp), %eax
	movl	52(%eax), %eax
	cmpl	-32(%ebp), %eax
	jg	.L300
.L296:
	addl	$1, -36(%ebp)
.L294:
	movl	max_connects, %eax
	cmpl	%eax, -36(%ebp)
	jl	.L301
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
	je	.L304
	movl	8(%ebp), %eax
	movl	72(%eax), %eax
	subl	$12, %esp
	pushl	%eax
	call	tmr_cancel
	addl	$16, %esp
	movl	8(%ebp), %eax
	movl	$0, 72(%eax)
.L304:
	movl	8(%ebp), %eax
	movl	(%eax), %eax
	cmpl	$4, %eax
	jne	.L305
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
.L305:
	movl	8(%ebp), %eax
	movl	8(%eax), %eax
	movl	356(%eax), %eax
	testl	%eax, %eax
	je	.L306
	movl	8(%ebp), %eax
	movl	(%eax), %eax
	cmpl	$3, %eax
	je	.L307
	movl	8(%ebp), %eax
	movl	8(%eax), %eax
	movl	448(%eax), %eax
	subl	$12, %esp
	pushl	%eax
	call	fdwatch_del_fd
	addl	$16, %esp
.L307:
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
	je	.L308
	subl	$8, %esp
	pushl	$.LC125
	pushl	$3
	call	syslog
	addl	$16, %esp
.L308:
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
	jne	.L303
	subl	$8, %esp
	pushl	$.LC126
	pushl	$2
	call	syslog
	addl	$16, %esp
	subl	$12, %esp
	pushl	$1
	call	exit
.L306:
	subl	$8, %esp
	pushl	12(%ebp)
	pushl	8(%ebp)
	call	really_clear_connection
	addl	$16, %esp
.L303:
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
	je	.L311
	movl	8(%ebp), %eax
	movl	8(%eax), %eax
	movl	448(%eax), %eax
	subl	$12, %esp
	pushl	%eax
	call	fdwatch_del_fd
	addl	$16, %esp
.L311:
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
	je	.L312
	movl	8(%ebp), %eax
	movl	76(%eax), %eax
	subl	$12, %esp
	pushl	%eax
	call	tmr_cancel
	addl	$16, %esp
	movl	8(%ebp), %eax
	movl	$0, 76(%eax)
.L312:
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
	movl	$0, -12(%ebp)
	jmp	.L314
.L320:
	movl	connects, %ecx
	movl	-12(%ebp), %edx
	movl	%edx, %eax
	addl	%eax, %eax
	addl	%edx, %eax
	sall	$5, %eax
	addl	%ecx, %eax
	movl	%eax, -16(%ebp)
	movl	-16(%ebp), %eax
	movl	(%eax), %eax
	cmpl	$1, %eax
	je	.L316
	cmpl	$1, %eax
	jl	.L315
	cmpl	$3, %eax
	jg	.L315
	jmp	.L321
.L316:
	movl	12(%ebp), %eax
	movl	(%eax), %edx
	movl	-16(%ebp), %eax
	movl	68(%eax), %eax
	subl	%eax, %edx
	movl	%edx, %eax
	cmpl	$59, %eax
	jle	.L318
	movl	-16(%ebp), %eax
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
	movl	-16(%ebp), %eax
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
	pushl	-16(%ebp)
	call	finish_connection
	addl	$16, %esp
	jmp	.L315
.L318:
	jmp	.L315
.L321:
	movl	12(%ebp), %eax
	movl	(%eax), %edx
	movl	-16(%ebp), %eax
	movl	68(%eax), %eax
	subl	%eax, %edx
	movl	%edx, %eax
	cmpl	$299, %eax
	jle	.L319
	movl	-16(%ebp), %eax
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
	pushl	-16(%ebp)
	call	clear_connection
	addl	$16, %esp
	jmp	.L322
.L319:
.L322:
	nop
.L315:
	addl	$1, -12(%ebp)
.L314:
	movl	max_connects, %eax
	cmpl	%eax, -12(%ebp)
	jl	.L320
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
	jne	.L323
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
.L323:
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
	subl	$40, %esp
	cmpl	$0, 8(%ebp)
	jne	.L329
	subl	$8, %esp
	pushl	$0
	leal	-28(%ebp), %eax
	pushl	%eax
	call	gettimeofday
	addl	$16, %esp
	leal	-28(%ebp), %eax
	movl	%eax, 8(%ebp)
.L329:
	movl	8(%ebp), %eax
	movl	(%eax), %eax
	movl	%eax, -16(%ebp)
	movl	start_time, %eax
	movl	-16(%ebp), %edx
	subl	%eax, %edx
	movl	%edx, %eax
	movl	%eax, -20(%ebp)
	movl	stats_time, %eax
	movl	-16(%ebp), %edx
	subl	%eax, %edx
	movl	%edx, %eax
	movl	%eax, -12(%ebp)
	cmpl	$0, -12(%ebp)
	jne	.L330
	movl	$1, -12(%ebp)
.L330:
	movl	-16(%ebp), %eax
	movl	%eax, stats_time
	pushl	-12(%ebp)
	pushl	-20(%ebp)
	pushl	$.LC129
	pushl	$6
	call	syslog
	addl	$16, %esp
	subl	$12, %esp
	pushl	-12(%ebp)
	call	thttpd_logstats
	addl	$16, %esp
	subl	$12, %esp
	pushl	-12(%ebp)
	call	httpd_logstats
	addl	$16, %esp
	subl	$12, %esp
	pushl	-12(%ebp)
	call	mmc_logstats
	addl	$16, %esp
	subl	$12, %esp
	pushl	-12(%ebp)
	call	fdwatch_logstats
	addl	$16, %esp
	subl	$12, %esp
	pushl	-12(%ebp)
	call	tmr_logstats
	addl	$16, %esp
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
	jle	.L332
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
.L332:
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
