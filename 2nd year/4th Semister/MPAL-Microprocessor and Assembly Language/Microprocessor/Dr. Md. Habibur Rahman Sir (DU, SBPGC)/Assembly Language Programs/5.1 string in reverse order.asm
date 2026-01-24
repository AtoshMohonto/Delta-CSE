; 5.1
; a program to display any string in reverse order

display macro msg				; display - user defined macro
	mov ah,09h				; display string function
	mov dx,offset msg			; initialize dx to msg
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

.data					; data - name of user defined segment
	cr	equ	0dh			; ASCII code for carriage return
	lf	equ	0ah			; ASCII code for line feed
     msg1 db cr,lf,	'Enter your string: $'
	msg2 db cr,lf,	'The reversed string is: $'
	msg3 db cr, lf, lf,	'Now press a if you want to type again or x to exit - $'
	msg4 db cr, lf, 'You pressed x so the program has exit. $'
     msg5 db cr, lf, 'Ah! Wrong choice! Its out of range! $'
	temp      db   ?
	chartable db 100 dup (?)		; input character table
	rev 	     db 100 dup ('$')	; reversed character table
endm 						; end of data segment

.code						; code - name of user defined segment
assume ds: @data, cs: @code		; initialize ds and cs to segments

start:
	mov ax, @data				; initialize ds to  the data segment
	mov ds,ax				
     display msg1
	mov bx,0
	lea si,chartable			; load effective address of chartable

getchar:						; function to store input
	readchar temp
	mov ah,00h				; compare input character with
	cmp al,0dh				; ASCII value of enter
	je reverse				; if equal jump to reverse function
	inc bl
	mov [si+1],al				; store character in chartable
    	inc si					; advance input string pointer
	loop getchar
	
reverse:	
    	display msg2
	mov cx,bx

rev_strng:					; function to reverse the string
	mov al,[si]				; load the last character input in al
	mov rev,al
	display rev				; display the last character at first
    	dec si					; decrease output string pointer
	loop rev_strng

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
     display msg4        ; You pressed x so the program has exit.
     exit                ; exit program

endm					; end of code segment
end start				; end of program