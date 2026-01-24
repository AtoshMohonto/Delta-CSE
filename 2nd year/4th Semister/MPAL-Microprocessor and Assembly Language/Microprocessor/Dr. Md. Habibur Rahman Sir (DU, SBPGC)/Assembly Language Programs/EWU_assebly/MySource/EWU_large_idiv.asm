;this program will explain a large integer divistion i.e. 16-bit division
mov dx,1110000011110000B ; dx-ax= 1110 0000 1111 0000 1100 1100 1100 1100B a 32-bit ninary number
mov ax,1100110011001100B ; dx-ax= -52,10,89,844 in decimal
mov bx,0110 1111 1010 1111B ; bx = 0110 1111 1010 1111B = 28591 in decimal
;-52,10,89,844 / 28591 = quotient = -18225 = B8CF, reminder = -18869 =B64B  
idiv bx
