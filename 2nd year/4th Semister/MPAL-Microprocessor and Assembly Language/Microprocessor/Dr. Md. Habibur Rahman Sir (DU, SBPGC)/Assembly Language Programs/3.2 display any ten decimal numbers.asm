; 3.2
; a program to display any ten decimal numbers

display macro msg       		; display - user defined macro
	mov ah, 09h			; display string function
	mov dx, offset msg		; initialize dx to msg
	int 21h				; call DOS service
endm

exit macro
     mov ah, 4ch
     mov al, 0h
     int 21h
endm

.data 				     ; data - name of user defined segment
	cr	equ	0dh			; ASCII code for carriage return
	lf	equ	0ah			; ASCII code for line feed
	tab 	equ	09h			; ASCII code for tab

   	msg1 db cr, lf,   		'Ten consecutive decimal numbers to display.....$'
   	msg2 db cr, lf,   		'From which number You want to start? - $'
     msg3 db cr, lf, lf,		'Now press a if you want to type again or x to exit - $'
	msg4 db cr, lf, 		'You pressed x so the program has exit. $'
     msg5 db cr, lf, 		'Ah! Wrong choice! Its out of range! $'
   	newline	db cr, lf,  	'$'
   	result 	db 5 dup(?)	; result table
   	deci 	db	? 
endm   					; end of data segment

.code					; code - name of user defined segment
assume ds: @data, cs: @code   ; initialize ds and cs to segments

start:
   	mov ax, @data			; initialize ds to the data segment
   	mov ds, ax				
     display msg1
   	display msg2
     mov ah, 01h			; get character from keyboard
   	int 21h				; call DOS service
   	sub al, '0'			; ASCII number to decimal
   	mov bx, 10			; load 10 in bx 
   	mul bl				; multiply with ten
   	mov deci, al			; store first digit in num
     mov ah, 01h			; get character from keyboard
   	int 21h				; call DOS service
   	sub al, '0'			; ASCII number to decimal
   	add deci, al			; add second digit
   	mov cx, 10			; initialize count register - ekahne koto porjonto count korbe ta nirdharon kora hobe

next_deci:				; loop for printing ten numbers
   	mov ah, 00h
   	mov al, deci
     mov si, offset result
   	call hex2asc			; hexadecimal to ASCII conversion
     display newline
   	display result			; print first number
     inc deci
   	loop next_deci 

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
     display msg4	     ; You pressed x so the program has exit.
     exit

hex2asc proc near			; function to convert hexa to ASCII
   	pusha				; save all registers
   	mov cx, 00h			; counter for intermediate data pushed
   	mov bx, 0ah			; load 10 in bl

rpt1:
   	mov dx, 00h
   	div bx				; divide deci by 10
   	add dl, '0'			; convert remainder to ASCII
   	push dx				; store ASCII digit on to the stack
   	inc cx				; update counter
   	cmp ax, 0ah			; is sum less than or equal to 10
   	jge rpt1				; if yes, perform conversion
   	add al, '0'			; convert last digit to ASCII
   	mov [si], al			; store last digit

rpt2:
   	pop ax				; pop data
   	inc si				; advance result string pointer
   	mov [si], al			; store in result
   	loop rpt2
   	inc si
   	mov al, '$'
   	mov [si], al			; append end of string
     popa					; restore the registers
     ret					; return to the main function
hex2asc endp				; end of procedure - endp/endm o likha jeto

endm					     ; end of segment
end start					; end of program