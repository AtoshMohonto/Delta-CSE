; a program to find the largest number from N numbers

display macro msg			; display - user defined macro
	mov ah, 09h				; display string function
	mov dx, offset msg		; initialize dx to msg
	int 21h					; call DOS service
endm

readnum macro num			; macro to get a two digit input number
	mov ah, 01h				; get character from keyboard
	int 21h					; call DOS service
	sub al, '0'				; ASCII number to decimal
	mov bx, 10					; load 10 in bx 
	mul bl					; multiply with ten
	mov num, al				; store first digit in num

	mov ah, 01h				; get character from keyboard
	int 21h					; call DOS service
	sub al, '0'				; ASCII number to decimal
	add num, al				; add second digit
endm

exit macro
     mov ah, 4ch
     mov al, 0h
     int 21h
endm

_DATA segment				; data - name of user defined segment
	cr	equ	0dh			    ; ASCII code for carriage return
	lf	equ	0ah			    ; ASCII code for line feed
    msg1 db cr, lf, 'How many numbers do you want to compare? : $'
	msg2 db cr, lf, 'Enter numbers in two digits: $'
	msg3 db cr, lf, 'The largest number is: $'
	msg4 db cr, lf, lf,	'Now press a if you want to type again or x to exit - $'
    msg5 db cr, lf, 'You pressed x so the program has exit. $'
	msg6 db cr, lf, 'Ah! Wrong choice! Its out of range! $'
	N      db  ?
	temp   db  ?
	ntable db  100 dup (?)		; number table
	result db  20  dup ('$')
_DATA ends


_CODE segment
    assume cs:_CODE, ds: _DATA 
start: mov ax, _DATA
       mov ds, ax				
 st:
    display msg1
    readnum N					; How many numbers
   	mov si, offset ntable
   	mov ch, 0
   	mov cl, N	

nextread:						; function to get input numbers
    display msg2
   	readnum temp
   	mov al, temp
   	mov [si], al
   	inc si
    loop nextread
    
    lea si, ntable				; load effective address of ntable in pointer
    mov bl, [si]
   	mov cl, 01
    
nextchk:						; function to find largest number
   	inc si
    cmp cl, N
   	je nomore
    cmp bl, [si]
   	jge skip     				; ekhane change kore largest or lowest select korte hobe: jge/jle
   	mov bl, [si]
  
skip:
    inc cl
   	jmp nextchk
    	
nomore:						; function to display largest number
    mov ah, 0
    mov al, bl
    lea si, result
    call hex2asc 				; Hexadecimal to ASCII conversion call   
    display msg3
    display result
        
again:
     display msg4        ; Now press a if you want to type again or x to exit -
     mov ah, 01h         ; get input from keyboard
     int 21h
     cmp al, 'a'         ; compare with ASCII value of a
     je st            ; if equal jump to start function
     cmp al, 'x'         ; compare with ASCII value of x
     je exit             ; if equal jump to exit function

wrong:
     display msg6		; Ah! Wrong choice! Its out of range!
     jmp again	     

exit:      
     display msg5        ; You pressed x so the program has exit.
     exit                ; exit program		

hex2asc proc near				; function to convert hexadecimal to ASCII
	pusha					; save all registers
	mov cx, 00h				; counter for intermediate data pushed
	mov bx, 0ah				; load 10 in bl

rpt1:
	mov dx, 00h
	div bx					; divide deci by 10
	add dl, '0'				; convert remainder to ASCII
	push dx					; store ASCII digit on to the stack
	inc cx					; update counter
	cmp ax, 0ah				; is sum less than or equal to 10
	jge rpt1					; if yes, perform conversion
	add al, '0'				; convert last digit to ASCII
	mov [si], al				; store last digit

rpt2:
	pop ax					; pop data
	inc si					; advance result string pointer
	mov [si], al				; store in result
	loop rpt2
	inc si
	mov al, '$'
	mov [si], al				; append end of string
	popa						; restore the registers
	ret						; return to the main function
hex2asc endp					; end of procedure

endm							; end of segment
end start						; end of program