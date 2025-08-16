section .data
var1 db 0,0,0

section .text
bits 64
default rel
global ImageFlipHorizontal
ImageFlipHorizontal:
; inputArray@rcx, outputArray@rdx, height@r8, width@r9
    mov rsi, rcx  
    mov rdi, rdx  
    mov r13, 3 ; multiply 3 to get the total size of the image

    mov rax, r9   
    mul r8        
   
    mov rcx, rax  
   
    mov rax, rcx
    mul r13
    
    mov rcx, rax  ; stores the size of the image in rcx
   
    xor rbx, rbx  
    xor r12, r12 
    
    
    mov r14, rcx 
    mov rax, r14
    dec r14
    mov [var1+2], r14b ; gets size of the image - 1
    dec r14
    mov [var1+1], r14b ; gets size of the image - 2
    dec r14
    mov [var1], r14b ; gets size of the image - 3
     
    xor rbx, rbx
    xor r15, r15

    xor r10, r10
    xor r12, r12
    xor r13, r13
    
    sub rcx, 9 ; subtract rcx for first row
    
Last2Rows: 
    cmp r12, 8 
    jle ValuesLastRow ; values at the last row
    jmp n
    ValuesLastRow:
        lea r15, [var1+r13] ; get the offset value
        movzx rbx, byte [r15] ; store in rbx
        lea r14, [rsi+rbx] ; get the address of the inputArray+rbx
        mov byte al, [r14] ; store digit in al (byte size) 
        mov [rdi+r12+18], al ;move digit to the reversed form in the outputArray
    n: nop
  
    cmp r12, 9
    jge ValuesMiddleRow
    jmp s
    ValuesMiddleRow:
        lea r15, [var1+r13] 
        movzx rbx, byte [r15]  
        lea r14, [rsi+rbx] 
        mov byte al, [r14]     
        mov [rdi+r12], al   
    s: nop

    inc r13 ;0 1 2
    inc r10
    inc r12 
    
    cmp r10, 3 ;reset the value to 0 for every 3 bytes
    je sub_bytes
    jmp f
    sub_bytes: call subbytes ;subbytes deducts 3 for all values 
                      ;in var1 for the next set of 3 integers 
                      
    f: nop
    loop Last2Rows
    
    mov rcx, 9 ; 9 for the first row
    
FirstRow:
    cmp r12, 18
    jge ValuesFirstRow
    jmp ns
    ValuesFirstRow:
        lea r15, [var1+r13] 
        movzx rbx, byte [r15]  
        lea r14, [rsi+rbx] 
        mov byte al, [r14]     
        mov [rdi+r12-18], al   
    ns: nop
    
    
    inc r13
    inc r10
    inc r12
    cmp r10, 3
    je sub_bytes2
    jmp z
    sub_bytes2: call subbytes
    
    z: nop
    LOOP FirstRow

    ret
    
subbytes:
    sub byte [var1], 3
    sub byte [var1+1], 3
    sub byte [var1+2], 3
    mov r10, 0
    mov r13, 0
    ret 
    