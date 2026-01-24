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
    msg1 db cr,lf,'Enter a letter:','$'
    msg2 db cr,lf, 'Given character in lower case:','$'   
    msg3 db cr,lf, 'Given character in upper case:','$'
    nwln db cr,lf,'$'
    
_DATA ends


_CODE segment
    assume cs:_CODE, ds: _DATA 
start: mov ax, _DATA
       mov ds, ax
       
       printf msg1
       printf nwln        
       
       ;read character
       mov ah, 01h
       int 21h
       mov bl,al
       
       cmp bl,96
       jl upper
       printf msg3           
       
       sub bl,32
       mov dl,bl
       mov ah,02h
       int 21h
       jmp skip
       
upper: printf msg2
       add bl,32
       mov dl,bl
       mov ah,02h
       int 21h       
       
skip:  mov ah,4ch  ; terminate the program
       mov al, 00h
       int 21h
_CODE ends
      end start