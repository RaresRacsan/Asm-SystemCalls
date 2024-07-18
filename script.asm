section .bss
    buffer resb 1              ; buffer to store the keystroke

section .data
    filename db 'keystrokes.log', 0 ; name of the log file

section .text
    global _start

_start:
    ; sys_open (filename, O_WRONLY | O_CREAT | O_APPEND, 600)
    mov rax, 2                 ; syscall number for sys_open
    mov rdi, filename          ; filename
    mov rsi, 0x241             ; flags: O_WRONLY | O_CREAT | O_APPEND (octal 241 = 0x241)
    mov rdx, 600               ; mode: rw------- (600)
    syscall
    cmp rax, -1                ; check if the file was opened successfully
    jl  _exit                  ; if rax < 0, exit
    mov r12, rax               ; save the file descriptor in r12

read_loop:
    ; sys_read (stdin, buffer, 1)
    mov rax, 0                 ; syscall number for sys_read
    mov rdi, 0                 ; file descriptor 0 (stdin)
    mov rsi, buffer            ; buffer to store the input
    mov rdx, 1                 ; number of bytes to read
    syscall
    cmp rax, -1                ; check if read was successful
    jl  cleanup                ; if rax < 0, exit read loop

    ; sys_write (file, buffer, 1)
    mov rax, 1                 ; syscall number for sys_write
    mov rdi, r12               ; file descriptor of the log file
    mov rsi, buffer            ; buffer containing the input
    mov rdx, 1                 ; number of bytes to write
    syscall
    cmp rax, -1                ; check if write was successful
    jl  cleanup                ; if rax < 0, exit read loop

    jmp read_loop              ; repeat the read loop

cleanup:
    ; sys_close (file)
    mov rax, 3                 ; syscall number for sys_close
    mov rdi, r12               ; file descriptor of the log file
    syscall

_exit:
    ; sys_exit (0)
    mov rax, 60                ; syscall number for sys_exit
    xor rdi, rdi               ; exit code 0
    syscall
