; 4.2
; a program to find odd or even numbers

display macro msg				; display - user defined macro
	mov ah, 09h				; display string function
	mov dx, offset msg			; initialize dx to msg
	int 21h					; call DOS service
endm

readnum macro num				; macro to get a two digit input / number
	mov ah, 01h				; get character from keyboard
	int 21h					; call DOS service
	sub al, '0'				; ASCII number to decimal
	mov bx, 10				; load 10 in bx 
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

.data				; data - name of user defined segment
	cr	equ	0dh		; ASCII code for carriage return
	lf	equ	0ah		; ASCII code for line feed

	msg1 db cr, lf, 'Enter a two digit number: $'
	msg2 db cr, lf, 'The Number You Entered Is Even. $'
	msg3 db cr, lf, 'The Number You Entered Is Odd. $'
	msg4 db cr, lf, lf,	'Now press a if you want to type again or x to exit - $'
	msg5 db cr, lf, 'You pressed x so the program has exit. $'
	msg6 db cr, lf, 'Ah! Wrong choice! Its out of range! $'
    	N    db	?
endm   					; end of data segment

.code					; code - name of user defined segment
assume ds: @data, cs: @code	; initialize ds and cs to segments

start:
	mov ax, @data			; initialize ds to  the data segment
	mov ds, ax				
  	display msg1
	readnum N				; get number input
	mov al, N
	mov cl, 2				; load 2 in cl
	div cl				; divide al by cl
	cmp ah, 0				; compare remainder with zero
	je  Even				; if equal jump to Even function
	cmp ah, 1				; compare remainder with zero
	je  Odd				; if equal jump to Odd function

Even:					; function to display even number
	display msg2
	jmp again
	
Odd:
	display msg3
	jmp again

again:
     mov ax, @data
     mov ds, ax
     display msg4        ; Now press a if you want to type again or x to exit -
     mov ah, 01h         ; get input from keyboard
     int 21h
     cmp al, 'a'         ; compare with ASCII value of s
     je start            ; if equal jump to start function
     cmp al, 'x'         ; compare with ASCII value of x
     je exit             ; if equal jump to exit function

wrong:
     display msg6		; Ah! Wrong choice! Its out of range!
     jmp again	     

exit:      
     display msg5        ; You pressed x so the program has exit.
     exit                ; exit program

endm					; end of segment
end start				; end of program