; 2 expert version
; A program to read a character, if it’s ‘y’ or ‘n’ display it, otherwise terminate the program

display macro msg        ; display - user define macro
     mov ah, 09h         ; display string function
     mov dx, offset msg  ; initialize dx to msg
     int 21h             ; call dos sevice
endm

exit macro              ; program exit macro
     mov ah, 4ch
     mov al, 0h
     int 21h
endm

.data                    ; data - name of user define segment
     cr equ 0dh          ; ascii code for carriage return
     lf equ 0ah          ; ascii code for line feed
     msg1 db cr, lf, 'please chose yes or no - $'
     msg2 db cr, lf, 'wrong choice! $'
     msg3 db cr, lf, 'you have chossen - yes $'
     msg4 db cr, lf, 'you have chossen - no $'
     msg5 db cr, lf, 'press a to chose again or x to exit - $'
     msg6 db cr, lf, 'you have chossen x so the program will exit $'
endm                     ; end of data segment

.code                    ; code - name of user define segment
assume ds: @data, cs: @code; initialize ds and cs to segments

start:
     mov ax, @data       ; initialize ds to the data segment
     mov ds, ax
     display msg1        ; please chose yes or no
     mov ah, 01h         ; get input from keyboard
     int 21h
     cmp al, 'y'         ; compare with ASCII value of y
     je yes              ; if equal jump to yes function
     cmp al, 'n'         ; compare with ASCII value of n
     je no               ; if equal jump to no function
     jmp wrong

wrong:
     display msg2        ; wrong choice!
     jmp again

again:
     mov ax, @data
     mov ds, ax
     display msg5
     mov ah, 01h         ; get input from keyboard
     int 21h
     cmp al, 'a'         ; compare with ASCII value of a
     je start            ; if equal jump to start function
     cmp al, 'x'         ; compare with ASCII value of x
     je exit             ; if equal jump to exit function
     jmp wrong

exit:      
     display msg6
     exit                ; exit program

yes:                     ; function if input letter is y
     display msg3
     jmp again
     
no:                      ; function if input letter is n
     display msg4
     jmp again
endm                     ; end of code segment
end start             	; end of program