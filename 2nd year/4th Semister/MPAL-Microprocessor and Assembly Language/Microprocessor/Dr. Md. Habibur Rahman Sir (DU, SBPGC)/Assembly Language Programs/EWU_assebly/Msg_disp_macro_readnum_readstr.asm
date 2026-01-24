; A program to display message n time in different lines

;A macro to display a message
printf macro m
       mov ah, 09h  ; display the message
       mov dx, offset m
       int 21h
endm

;A macro to read a 2-digit number
readnum macro num
    mov ah, 01h
    int 21h
    sub al, '0'
    mov bh, 0ah
    mul bh
    mov num, al
    mov ah, 01h
    int 21h
    sub al, '0'
    add num, al
endm
        
;A macro to read a string
read_str macro msg
    mov di, offset msg
    mov ah,1
    int 21h
while1:
    cmp al, 0dh ;CR?
    je end_while1  ;Yes exit
;if character is back space?
    cmp al,8h     ;back space?
    jne else1     ;no, store in string
;then    
    dec di
    jmp read
else1:
    mov [di],al  ;store character in string
    inc di
read:
    int 21h
    jmp while1
end_while1:
endm

    
_DATA segment
    cr equ 0dh
    lf equ 10
    promptn db cr,lf,'Enter the value of N (00):','$'
    prompts db cr,lf, 'Enter the string','$'
    nwln db cr,lf,'$'
    n db ?
    msg db 100 dup('$')
_DATA ends


_CODE segment
    assume cs:_CODE, ds: _DATA 
start: mov ax, _DATA
       mov ds, ax
       
       printf promptn
       printf nwln        
       readnum n
       mov ch, 00h
       mov cl, n
       printf prompts
       printf nwln
       read_str msg
       printf nwln
       
 Reap: printf msg
       printf nwln
       
       loop Reap     ; looping
       
       mov ah,4ch  ; terminate the program
       mov al, 00h
       int 21h
_CODE ends
      end start