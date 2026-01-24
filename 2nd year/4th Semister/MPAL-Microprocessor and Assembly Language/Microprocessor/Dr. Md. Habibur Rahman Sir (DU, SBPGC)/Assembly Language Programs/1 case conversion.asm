; 1 x
; A program to read a character, and if it’s an uppercase letter, display it/
; to convert lowercase letter to uppercase

display macro msg   	; display - user define macro
     mov ah, 09h    	; display string function
     mov dx, offset msg  ; initialize dx to msg
     int 21h
endm

readchar macro char  	; character input macro
     mov ah, 01h     	; get input from keyboard
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
     msg1 db cr, lf, 'Type any character - $'
     msg2 db cr, lf, 'The uppercase of the character is - $'
     msg3 db cr, lf, 'Oh! Seems its already in uppercase! $'
     msg4 db cr, lf, 'Ah! Wrong choice! Its out of range! $'
     msg5 db cr, lf, lf,	'Now press a if you want to type again or x to exit - $'
     msg6 db cr, lf, 'You pressed x so the program has exit. $'
     
endm                        	; optional?
   
.code

assume ds: @data, cs: @code	; optional? ; initialize ds and cs to segments

start:
     mov ax, @data
     mov ds, ax
     display msg1		; Type any character -
     readchar char  	; get the character from keyboard
     mov bl, al
     cmp bl, 'z'    	; cmpare the character to ascii of z
     jg wrong       	; out of range
     cmp bl, 'A'
     jl wrong
     cmp bl, 'a'
     jge convert
     cmp bl, 'Z'
     jl ok
     
wrong:
     display msg4		; Ah! Wrong choice! Its out of range!
     jmp again

again:
     mov ax, @data
     mov ds, ax
     display msg5        ; Now press a if you want to type again or x to exit -
     mov ah, 01h         ; get input from keyboard
     int 21h
     cmp al, 'a'         ; compare with ASCII value of a
     je start            ; if equal jump to start function
     cmp al, 'x'         ; compare with ASCII value of x
     je exit             ; if equal jump to exit function
     jmp wrong
     
exit:      
     display msg6        ; You pressed x so the program has exit.
     exit                ; exit program

convert:
     display msg2        ; The uppercase of the character is -
     sub bl, 20h
     mov dl, bl
     mov ah, 02h
     int 21h
     jmp again
     
ok:
     display msg3        ; Oh! Seems its already in uppercase!
     jmp again
endm
end start