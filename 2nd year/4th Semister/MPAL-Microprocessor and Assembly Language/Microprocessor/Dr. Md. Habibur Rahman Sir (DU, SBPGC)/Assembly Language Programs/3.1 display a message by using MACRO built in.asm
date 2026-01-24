; 3.1 built in
; a program to display a message by using MACRO

display macro msg	               ; display - user define macro						
   	mov ah, 09h				; display string function
   	mov dx, offset msg           	; initialize dx to msg	                   
   	int 21h					; call dos sevice
endm

exit macro
     mov ah, 4ch
     mov al, 0h
     int 21h
endm

.data		                     ; data – name of user defined segment
   	cr     equ	0dh			
   	lf     equ	0ah			
   	msg1   db cr, lf,  'University of Dhaka$' 	
  	msg2   db	cr, lf,  'Fourth year, Honours Final Examination$'
   	msg3   db	cr, lf,  'Department of APECE$'
   	msg4   db	cr, lf,  'Center: Curzon Hall		Roll No:	2214$'
   	msg5   db	cr, lf,  'Registrtion No: Ha 1710	Session:	2007-2008$'
   	msg6   db	cr, lf,  'Date: 15.09.2012$'
     msg7	  db cr, lf, lf,'Now press a if you want to see it again or x to exit - $'
	msg8   db cr, lf, 	'You pressed x so the program has exit. $'
     msg9   db cr, lf, 	'Ah! Wrong choice! Its out of range! $'
endm							; end of segment
  
.code				          ; code – name of user defined segment
assume   ds: @data,   cs: @code  	; initialize ds and cs to segments	

start:
   	mov ax, @data                 ; initialize ds to  the data segment
   	mov ds, ax					
	display msg1					
	display msg2					
	display msg3
	display msg4
	display msg5
	display msg6					

again:
     mov ax, @data
     mov ds, ax
     display msg7        ; Now press a if you want to type again or x to exit -
     mov ah, 01h         ; get input from keyboard
     int 21h
     cmp al, 'a'         ; compare with ASCII value of s
     je start            ; if equal jump to start function
     cmp al, 'x'         ; compare with ASCII value of x
     je exit             ; if equal jump to exit function

wrong:
     display msg9		; Ah! Wrong choice! Its out of range!
     jmp again

exit:      
     display msg8	     ; You pressed x so the program has exit.
     exit					

endm					; end of segment
end start	               ; end of program