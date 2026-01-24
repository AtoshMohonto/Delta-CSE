; A program to display message n time in different lines

;A macro to display a message
printf macro m
       mov ah, 09h  ; display the message
       mov dx, offset m
       int 21h
endm

   
_DATA segment
    cr equ 0dh
    lf equ 10
    msg1 db cr,lf,'Upper case characters:','$'
    msg2 db cr,lf, 'Lower case characters:','$'   
    nwln db cr,lf,'$'
    
_DATA ends


_CODE segment
    assume cs:_CODE, ds: _DATA 
start: mov ax, _DATA
       mov ds, ax
       
       printf msg1
       printf nwln        
       
       mov cx,26
       mov bl,65
       mov ah, 02h
reap:  mov dl,bl
       int 21h
       inc bl
       mov dl,' '
       int 21h
       loop reap 
       
       printf msg2
       printf nwln
       
       mov cx,26
       mov bl,97
       mov ah, 02h
reap1:  mov dl,bl
       int 21h
       inc bl
       mov dl,' '
       int 21h
       loop reap1
          
       
       mov ah,4ch  ; terminate the program
       mov al, 00h
       int 21h
_CODE ends
      end start