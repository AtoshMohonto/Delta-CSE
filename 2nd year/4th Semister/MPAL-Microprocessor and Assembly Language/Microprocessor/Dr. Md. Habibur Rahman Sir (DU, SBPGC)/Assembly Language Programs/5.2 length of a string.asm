; 5.2
; a program to determine the length of a string

display macro msg				; display - user defined macro
	mov ah, 09h				; display string function
	mov dx, offset msg			; initialize dx to msg
	int 21h					; call DOS service
endm

readchar macro char
	mov ah,01h				; get a character from keyboard
	int 21h					; call DOS service
endm

exit macro
     mov ah, 4ch
     mov al, 0h
     int 21h
endm

.data					; data – name of user defined segment
	cr	equ	0dh			; ASCII code for carriage return
	lf	equ	0ah			; ASCII code for line feed
     msg1 db cr, lf, 'Enter Your String: $'
	msg2 db cr, lf, 'String length     : $'
	msg3 db cr, lf, lf,	'Now press a if you want to type again or x to exit - $'
	msg4 db cr, lf, 'You pressed x so the program has exit. $'
     msg5 db cr, lf, 'Ah! Wrong choice! Its out of range! $'
	temp 		db 	?
	stringlength 	db 	10 dup ('$')
endm   						; end of data segment

.code 						; code - name of user defined segment
assume ds: @data, cs: @code		; initialize ds and cs to segments

start:
	mov ax, @data				; initialize ds to  the data segment
	mov ds, ax				
	display msg1
	mov bx, 0
	
getchar:						; function to store input
	readchar temp
	cmp al, 0dh				; compare “input” with “enter”
	je count
	inc bl
	loop getchar

count:						; function to determine length of string
    	mov cx, bx
	display msg2
	mov ax, bx
	lea si, stringlength
	call hex2asc				; hexadecimal to ASCII conversion call    
	display stringlength

again:
     mov ax, @data
     mov ds, ax
     display msg3        ; Now press a if you want to type again or x to exit -
     mov ah, 01h         ; get input from keyboard
     int 21h
     cmp al, 'a'         ; compare with ASCII value of s
     je start            ; if equal jump to start function
     cmp al, 'x'         ; compare with ASCII value of x
     je exit             ; if equal jump to exit function

wrong:
     display msg5		; Ah! Wrong choice! Its out of range!
     jmp again

exit:      
     display msg4	      	; You pressed x so the program has exit.
     exit         	       	; exit program

hex2asc proc near			; function to convert hexadecimal to ASCII string
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

hex2asc endp				; end of procedure   

endm						; end of segment
end start					; end of program