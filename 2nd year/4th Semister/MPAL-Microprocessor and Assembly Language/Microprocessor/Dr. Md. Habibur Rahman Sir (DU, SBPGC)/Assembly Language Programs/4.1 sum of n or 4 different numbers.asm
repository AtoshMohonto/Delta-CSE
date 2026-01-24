; 4.1
; a program to sum of n/4 different numbers

display macro msg
    mov ah, 09h
    mov dx, offset msg	; lea dx, msg
    int 21h
endm

exit macro
     mov ah, 4ch
     mov al, 0h
     int 21h
endm

.data
    	cr equ 0dh
    	lf equ 0ah
   	msg1 db cr, lf,'How many numbers do you want to sum? N = $'
    	msg2 db cr, lf,'Enter value:$'
   	msg3 db cr, lf,'Sum = $'
    	msg4 db cr, lf, lf,	'Now press a if you want to type again or x to exit - $'
    	msg5 db cr, lf, 'You pressed x so the program has exit. $'
	msg6 db cr, lf, 'Ah! Wrong choice! Its out of range! $'
    	N db ?
    	num db ?
    	Buffer db 5 dup('$')
    	sum db 5 dup('$')
endm

.code 
assume ds: @data, cs: @code	; initialize ds and cs to segments

start:
    	mov ax, @data
    	mov ds,ax
    	display msg1
    	call readnum
    	mov al, N     ; N er jaygay aage thekei value dite pari
    	mov num, al
   	mov ch, 00h
    	mov cl, num 
    	mov si, offset buffer

Rd_nums:
    	display msg2
    	call readnum
    	mov al, N
    	mov [si],al
    	inc si
    	loop Rd_nums
     mov si, offset buffer
    	mov cl, num
    	mov al, [si]
    	mov ah, 00h
    	dec cl

le1:
    	inc si
    	mov bl, [si]
    	mov bh, 00h
    	add ax, bx
    	loop le1
     mov si, offset sum
    	call hex2asc
     display msg3
    	display sum
    
again:
     mov ax, @data
     mov ds, ax
     display msg4        ; Now press a if you want to type again or x to exit -
     mov ah, 01h         ; get input from keyboard
     int 21h
     cmp al, 'a'         ; compare with ASCII value of a
     je start            ; if equal jump to start function
     cmp al, 'x'         ; compare with ASCII value of x
     je exit             ; if equal jump to exit function

wrong:
     display msg6		; Ah! Wrong choice! Its out of range!
     jmp again	     

exit:      
     display msg5        ; You pressed x so the program has exit.
     exit
     
readnum proc near
    	push ax
    	push bx
    	mov ah, 01h
    	int 21h
    	sub al, '0'
    	mov bh, 0ah
    	mul bh
    	mov N, al
    	mov ah, 01h
    	int 21h
    	cmp al, cr
    	je e1
    	sub al,'0'
    	add N, al
    	jmp e2

e1:
    	mov al, N
    	mov ah, 00h
    	div bh
    	mov N, al
            
e2:
    	pop bx
    	pop ax
    	ret
readnum endp  

hex2asc proc near
    	push ax
    	push bx
    	push cx
    	push dx
    	push si
    	mov cx, 00h
    	mov bx, 0ah

rpt1:
    	mov dx, 00h
    	div bx
    	add dl, '0'
    	push dx
    	inc cx
    	cmp ax, 0ah
    	jge rpt1
    	add al, '0'
    	mov [si], al

rpt2:
    	pop ax
    	inc si
    	mov [si], al
    	loop rpt2
    	inc si
    	mov al, '$'
    	mov [si], al
     pop si
    	pop dx
    	pop cx
    	pop bx
    	pop ax
    	ret
hex2asc endp

endm
end start