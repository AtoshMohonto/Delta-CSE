; 3.1
; a program to display a message by using MACRO

display macro msg	               	; display - user define macro						
   	mov ah, 09h					; display string function
   	mov dx, offset msg           		; initialize dx to msg	                   
   	int 21h						; call dos sevice
endm

clrscr macro                       	; to clear the screen
	mov ah, 00h
	mov al, 02h
	int 10h
endm

exit macro
     mov ah, 4ch
     mov al, 0h
     int 21h
endm

.data							; data – name of user defined segment
	cr     equ	0dh			
   	lf     equ	0ah
	msg1	db cr, lf,	'What do you want to display? - $' 
	msg2 db cr, lf,	'You wanted to display - $'
	msg3	db cr, lf, lf,	'Now press a if you want to input again or x to exit - $'
	msg4 db cr, lf, 	'You pressed x so the program has exit. $'
     msg5 db cr, lf, 	'Ah! Wrong choice! Its out of range! $'
     a 	db 100 dup(?)  			; maximum characters
endm

.code				          	; code – name of user defined segment
assume   ds: @data,   cs: @code		; initialize ds and cs to segments

start:
	mov ax, data
	mov ds, ax
	display msg1
	lea si, a
	mov cl, 00

up:
	mov ah, 01h
	int 21h
	cmp al, 0dh
	je display
	mov [si], al
	inc si
	inc cl             	
	cmp cl, 100         			; maximum characters
	jl up

display:
	lea si, a
	clrscr						; to clear the screen
	display msg2

l1:								; level 1
	cmp cl, 00
	je again
	mov dl, [si]
	mov ah, 02h
	int 21h
	inc si
	dec cl
	jmp l1

again:
     mov ax, @data
     mov ds, ax
     display msg3        			; Now press a if you want to input again or x to exit
     mov ah, 01h         			; get input from keyboard
     int 21h
     cmp al, 'a'         			; compare with ASCII value of s
     je start            			; if equal jump to start function
     cmp al, 'x'         			; compare with ASCII value of x
     je exit             			; if equal jump to exit function

wrong:
     display msg5					; Ah! Wrong choice! Its out of range!
     jmp again

exit:      
     display msg4	     			; You pressed x so the program has exit.
     exit					

endm								; end of code segment
end start