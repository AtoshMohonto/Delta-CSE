; 6.2 problem - jmp to start hocche na
; a program to sort 10 numbers in ascending order

display macro msg				; display - user defined macro
	mov ah, 09h				; display string function
	mov dx, offset msg			; initialize dx to msg
	int 21h					; call DOS service
endm

readnum macro num				; macro to get a two digit input number
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

_data segment 					; data - name of user defined segment
	cr	equ	0dh			; ASCII code for carriage return
	lf	equ	0ah			; ASCII code for line feed
	tab	equ	09h			; ASCII code for tab

	msg  db cr,lf,'How many numbers are to be sorted (xx)?', '$'
	msg1 db cr, lf, 'Enter numbers to be sorted: ', '$'
    msg2 db cr, lf, 'Numbers after sorting:', cr, lf, '$'
    msg3 db tab, '$'
	msg4 db cr, lf, lf,	'Now press a if you want to type again or x to exit - $'
	msg5 db cr, lf, 'You pressed x so the program has exit. $'
    msg6 db cr, lf, 'Ah! Wrong choice! Its out of range! $'
	temp db   ?
	N    db   ?
    ntable db   50 dup (?)
    restable db   50 dup ('$')
endm   						; end of data segment

_code segment					; code - name of user defined segment
assume ds: _data, cs: _code		; initialize ds and cs to segments
start:
	    mov ax, _data				; initialize ds to  the data segment
	    mov ds, ax				
rstart: 
        display msg
      	readnum N
        mov ch, 0
        mov cl, N				; load N in count register - ekhane change kore number select korte hobe *
        cmp cx,0
        je again
        mov di, offset ntable		; load effective address of ntable in pointer
rdnxt:						; function to get the input numbers
        display msg1
      	readnum temp
      	mov al, temp
      	mov [di], al
      	inc di
      	loop rdnxt
        mov dh, 0
      	mov dl, N
sort: 						; function to sort the numbers
        dec dx
      	cmp dx, 0
     	je  print
        mov ch,0
        mov cl, N			; * for ascending
      	dec cx
      	mov di, offset ntable
      
lrgnum:						; function to compare two numbers
      	mov al, [di]
      	mov bl, [di+1]
      	cmp al, bl
      	jle skip 			; descending / ascending - jge/jle
      	mov [di], bl
      	mov [di+1], al
skip:
      	inc di
      	loop lrgnum
		jmp sort
print:						; function to print the sorted numbers      
        display msg2
      	mov ch, 0			; * for descending
      	mov cl, N
      	mov si, offset restable
      	mov di, offset ntable
loop1:
     	mov  ah, 0
      	mov  al, [di]
      	call hex2asc			; Hexadecimal to ASCII conversion 
      	display restable
      	inc  di
      	display msg3
      	loop loop1
again:
     display msg4        ; Now press a if you want to type again or x to exit -
     mov ah, 01h         ; get input from keyboard
     int 21h
     cmp al, 'a'         ; compare with ASCII value of s
     je rstart            ; if equal jump to start function
     cmp al, 'x'         ; compare with ASCII value of x
     je exit             ; if equal jump to exit function
wrong:
     display msg6		; Ah! Wrong choice! Its out of range!
     jmp again
exit:      
     display msg5        ; You pressed x so the program has exit.
     exit                ; exit program
hex2asc proc near		 ; function to convert hexadecimal to ASCII string
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
	jge rpt1				; if yes, perform conversion
	add al, '0'				; convert last digit to ASCII
	mov [si], al			; store last digit
rpt2:
	pop ax					; pop data
	inc si					; advance result string pointer
	mov [si], al			; store in result
	loop rpt2
	inc si
	mov al, '$'
	mov [si], al				; append end of string
    popa						; restore the registers
    ret						; return to the main function
hex2asc endp					; end of procedure
endm							; end of segment
end start						; end of program