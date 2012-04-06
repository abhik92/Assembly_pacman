.model small
.stack 100h

.data
grid db 600 dup(0)
food db 0

pac_r db 0
pac_c db 0
pac_idx dw 0

e_idx dw 0
e_r db 0
e_c db 0

row db 0
col db 0
index dw 0


row_pixel dw 0
col_pixel dw 0    

color db 1111b
pink db 1100b
blue db 0011b
green db 0010b
black db 0000b

.code

popAll macro
  pop ax
  pop bx
  pop cx
  pop dx
endm
  
pushAll macro
  push dx
  push cx
  push bx
  push ax
endm

;***********************************************
; code to print integer number
;***********************************************
printint proc
  push ax
  push bx
  push cx
  push dx
  
  mov dx, 0
  mov cx, 10
  div cx
  
  cmp ax,0
  jne print2
  
  add dl, '0'
  mov ah, 2h
  int 21h
  
  jmp ex
 

 print2:
   call printint
   
   add dl,'0'
   mov ah, 2h
   int 21h
   ;call putchar

ex:
  pop dx
  pop cx
  pop bx
  pop ax
  
  ret
printint endp
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
gridInit proc
  pushAll
  mov bx, 1
  looprow1:
    mov grid[bx], -1
    inc bx
    cmp bx, 21
    jl looprow1
  mov grid[bx], 1
  inc bx
  mov grid[bx], 1
  inc bx
  mov grid[bx], 1
  inc bx
  mov grid[bx], 1
  inc bx
  mov grid[bx], -1
  inc bx
  mov grid[bx], 1
  inc bx
  mov grid[bx], 1
  inc bx
  mov grid[bx], 1
  inc bx
  mov grid[bx], 1
  add bx, 10
  mov grid[bx], -1 
  inc bx
  mov grid[bx], 1
  inc bx
  mov grid[bx], -1
  inc bx
  mov grid[bx], -1
  inc bx
  mov grid[bx], 1
  inc bx
  mov grid[bx], -1
  inc bx
  mov grid[bx], 1
  inc bx
  mov grid[bx], -1
  inc bx
  mov grid[bx], -1
  inc bx
  mov grid[bx], -1
  add bx, 10
  mov grid[bx], -1
  inc bx
  mov grid[bx], 1
  inc bx
  mov grid[bx], 1
  inc bx
  mov grid[bx], 1
  inc bx
  mov grid[bx], 1
  inc bx
  mov grid[bx], 1
  inc bx
  mov grid[bx], 1
  inc bx
  mov grid[bx], 1
  inc bx
  mov grid[bx], 1
  inc bx
  mov grid[bx], 1
  add bx, 10
  mov grid[bx], -1
  inc bx
  mov grid[bx], -1
  inc bx
  mov grid[bx], 1
  inc bx
  mov grid[bx], -1
  inc bx
  mov grid[bx], 1
  inc bx
  mov grid[bx], -1
  inc bx
  mov grid[bx], -1
  inc bx
  mov grid[bx], -1
  inc bx
  mov grid[bx], 1
  inc bx
  mov grid[bx], -1
  add bx, 10
  row6:
  mov grid[bx], -1
  inc bx
  mov grid[bx], -1
  inc bx
  mov grid[bx], 1
  inc bx
  mov grid[bx], -1
  inc bx
  mov grid[bx], 1
  inc bx
  mov grid[bx], -1
  inc bx
  mov grid[bx], -1
  inc bx
  mov grid[bx], -1
  inc bx
  mov grid[bx], 1
  inc bx
  mov grid[bx], -1
  add bx, 10
  row7:
  mov grid[bx], 0
  inc bx
  mov grid[bx], 0
  inc bx
  mov grid[bx], 1
  inc bx
  mov grid[bx], -1
  inc bx
  mov grid[bx], 1
  inc bx
  mov grid[bx], 1
  inc bx
  mov grid[bx], 1
  inc bx
  mov grid[bx], 1
  inc bx
  mov grid[bx], 1
  inc bx
  mov grid[bx], -1
  add bx, 10
  row8:
  mov grid[bx], -1
  inc bx
  mov grid[bx], -1
  inc bx
  mov grid[bx], 1
  inc bx
  mov grid[bx], -1
  inc bx
  mov grid[bx], -1
  inc bx
  mov grid[bx], -1
  inc bx
  mov grid[bx], -1
  inc bx
  mov grid[bx], 0
  inc bx
  mov grid[bx], -1
  inc bx
  mov grid[bx], -1
  add bx, 10
  row9:
  mov grid[bx], -1
  inc bx
  mov grid[bx], -1
  inc bx
  mov grid[bx], 1
  inc bx
  mov grid[bx], 0
  inc bx
  mov grid[bx], 0
  inc bx
  mov grid[bx], 0
  inc bx
  mov grid[bx], 0
  inc bx
  mov grid[bx], 0
  inc bx
  mov grid[bx], 0
  inc bx
  mov grid[bx], 0
  add bx, 10
  row10:
  mov grid[bx], -1
  inc bx
  mov grid[bx], -1
  inc bx
  mov grid[bx], 1
  inc bx
  mov grid[bx], -1
  inc bx
  mov grid[bx], -1
  inc bx
  mov grid[bx], -1
  inc bx
  mov grid[bx], 0
  inc bx
  mov grid[bx], -1
  inc bx
  mov grid[bx], -1
  inc bx
  mov grid[bx], -1
  add bx, 10
  row11:
  mov grid[bx], -1
  inc bx
  mov grid[bx], -1
  inc bx
  mov grid[bx], 1
  inc bx
  mov grid[bx], 0
  inc bx
  mov grid[bx], 0
  inc bx
  mov grid[bx], 0
  inc bx
  mov grid[bx], 0
  inc bx
  mov grid[bx], -1
  inc bx
  mov grid[bx], 0
  inc bx
  mov grid[bx], 0
  row12:
  add bx, 10
  mov grid[bx], -1
  inc bx
  mov grid[bx], -1
  inc bx
  mov grid[bx], 1
  inc bx
  mov grid[bx], -1
  inc bx
  mov grid[bx], 0
  inc bx
  mov grid[bx], -1
  inc bx
  mov grid[bx], 0
  inc bx
  mov grid[bx], -1
  inc bx
  mov grid[bx], -1
  inc bx
  mov grid[bx], -1
  row13:
  add bx, 10
  mov grid[bx], 0
  inc bx
  mov grid[bx], 0
  inc bx
  mov grid[bx], 1
  inc bx
  mov grid[bx], 0
  inc bx
  mov grid[bx], 0
  inc bx
  mov grid[bx], -1
  inc bx
  mov grid[bx], 0
  inc bx
  mov grid[bx], 0
  inc bx
  mov grid[bx], 0
  inc bx
  mov grid[bx], 0
  row14:
  add bx, 10
  mov grid[bx], -1
  inc bx
  mov grid[bx], -1
  inc bx
  mov grid[bx], 1
  inc bx
  mov grid[bx], -1
  inc bx
  mov grid[bx], -1
  inc bx
  mov grid[bx], -1
  inc bx
  mov grid[bx], -1
  inc bx
  mov grid[bx], -1
  inc bx
  mov grid[bx], 0
  inc bx
  mov grid[bx], -1
  row15:
  add bx, 10
  mov grid[bx], -1
  inc bx
  mov grid[bx], -1
  inc bx
  mov grid[bx], 1
  inc bx
  mov grid[bx], 1
  inc bx
  mov grid[bx], 1
  inc bx
  mov grid[bx], 1
  inc bx
  mov grid[bx], 1
  inc bx
  mov grid[bx], 0
  inc bx
  mov grid[bx], 0
  inc bx
  mov grid[bx], -1
  row16:
  add bx, 10
  mov grid[bx], -1
  inc bx
  mov grid[bx], -1
  inc bx
  mov grid[bx], 1
  inc bx
  mov grid[bx], -1
  inc bx
  mov grid[bx], -1
  inc bx
  mov grid[bx], -1
  inc bx
  mov grid[bx], 1
  inc bx
  mov grid[bx], -1
  inc bx
  mov grid[bx], -1
  inc bx
  mov grid[bx], -1
  row17:
  add bx, 10
  mov grid[bx], -1
  inc bx
  mov grid[bx], 1
  inc bx
  mov grid[bx], 1
  inc bx
  mov grid[bx], 1
  inc bx
  mov grid[bx], 1
  inc bx
  mov grid[bx], 1
  inc bx
  mov grid[bx], 1
  inc bx
  mov grid[bx], 1
  inc bx
  mov grid[bx], 1
  inc bx
  mov grid[bx], 1
  row18:
  add bx, 10
  mov grid[bx], -1
  inc bx
  mov grid[bx], 1
  inc bx
  mov grid[bx], -1
  inc bx
  mov grid[bx], -1
  inc bx
  mov grid[bx], 1
  inc bx
  mov grid[bx], -1
  inc bx
  mov grid[bx], -1
  inc bx
  mov grid[bx], -1
  inc bx
  mov grid[bx], 1
  inc bx
  mov grid[bx], -1
  row19:
  add bx, 10
  mov grid[bx], -1
  inc bx
  mov grid[bx], 1
  inc bx
  mov grid[bx], -1
  inc bx
  mov grid[bx], -1
  inc bx
  mov grid[bx], 1
  inc bx
  mov grid[bx], -1
  inc bx
  mov grid[bx], 1
  inc bx
  mov grid[bx], 1
  inc bx
  mov grid[bx], 1
  inc bx
  mov grid[bx], -1
  row20:
  add bx, 10
  mov grid[bx], -1
  inc bx
  mov grid[bx], 1
  inc bx
  mov grid[bx], -1
  inc bx
  mov grid[bx], -1
  inc bx
  mov grid[bx], 1
  inc bx
  mov grid[bx], -1
  inc bx
  mov grid[bx], 1
  inc bx
  mov grid[bx], -1
  inc bx
  mov grid[bx], -1
  inc bx
  mov grid[bx], -1
  row21:
  add bx, 10
  mov grid[bx], -1
  inc bx
  mov grid[bx], 1
  inc bx
  mov grid[bx], 1
  inc bx
  mov grid[bx], 1
  inc bx
  mov grid[bx], 1
  inc bx
  mov grid[bx], 1
  inc bx
  mov grid[bx], 1
  inc bx
  mov grid[bx], 1
  inc bx
  mov grid[bx], 1
  inc bx
  mov grid[bx], 1
  add bx, 10
  mov grid[bx], -1
  inc bx
  mov grid[bx], -1
  inc bx
  mov grid[bx], -1
  inc bx
  mov grid[bx], -1
  inc bx
  mov grid[bx], -1
  inc bx
  mov grid[bx], -1
  inc bx
  mov grid[bx], -1
  inc bx
  mov grid[bx], -1
  inc bx
  mov grid[bx], -1
  inc bx
  mov grid[bx], -1
  
  ;mov dl, 'a'
  ;mov ah, 1h
  ;int 21h
  call gridCopy
  ;int 21h
  popAll
  ret
gridInit endp

gridCopy proc
  pushAll
  mov bx, 0
  loopCopy:
    mov si, 1
    add bx, 19
    loopCopyinner:
      mov dl, grid[si+bx]
      neg si
      mov grid[bx+si+20], dl
      neg si
      inc si
      mov ax, si
      cmp si, 9
      jle loopCopyinner
    mov ax, bx
    cmp bx, 390
    jl loopCopy
  ;mov ah, 1h
  ;int 21h
  popAll
  ret
gridCopy endp

drawGrid proc  
  pushAll
  mov dx, row_pixel
  mov cx, col_pixel
  mov al, color
  mov ah, 0ch
  mov bh, 7
  
  drawRow:
    mov bl, 7  
    drawCol:
      dec bl
      int 10h
      inc cx
      cmp bl,0
      jg drawCol
    inc dx
    sub cx, 7
    dec bh
    cmp bh, 0
    jg drawRow  
  
  popAll
  ret
drawGrid endp

caughtFood proc
  pushAll
  
  popAll
  ret
caughtFood endp

drawFood proc
  pushAll
  
  mov dx, row_pixel
  add dx, 3
  mov cx, col_pixel
  add cx, 3
  mov al, pink
  mov ah, 0ch
  int 10h

  popAll
  ret
drawFood endp

drawMaze proc
  pushAll
  ;mov al, blue
  ;mov color, al
  mov row_pixel, 13
  mov bx, 0
  drawRowMaze:
  mov si, 1
  mov col_pixel, 90
    drawColMaze:
      cmp grid[bx+si], 255
      je drawG
      cmp grid[bx+si], 1
      je drawF
      cmp grid[bx+si], 0
      je loopCol
      drawG:
        mov al, blue
        mov color, al
        call drawGrid 
        jmp loopCol
      drawF:
        call drawFood
      loopCol:
        add col_pixel, 8
        inc si
        cmp si, 19
        jle drawColMaze
    add bx, 19
    add row_pixel, 8
    cmp bx, 407
    jle drawRowMaze

  popAll
  ret
drawMaze endp

printGrid proc
  pushAll

  mov bx, 1
  loopPrint:
    mov al, grid[bx]
    mov ah, 0
    
    mov dl, ' '
    mov ah, 2h
    int 21h
    inc bx
    cmp bx, 418
    jle loopPrint
  popAll
  ret
printGrid endp
;;;;;;;;;;;;;;;;; get pixel of grid ;;;;;;;;;;;;;
getPixel proc
  pushAll
  
  ;mov bl, 90
  mov cl, 8
  mov al, col
  dec al
  mul cl
  add ax, 90
  mov col_pixel, ax
  mov al, row
  dec al
  mul cl
  add ax, 13
  mov row_pixel, ax
  popAll
  ret
getPixel endp

;;;;;;;;;;;;;;;;; draw Pacman ;;;;;;;;;;;;;;;;
drawPac proc 
  pushAll
  mov al, pac_r
  mov ah, 0
  
  mov row, al
  mov al, pac_c 
  mov col, al
  call getPixel
  
  call drawGrid 
  popAll
  ret
drawPac endp  
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
change proc near
	local up,right,down,finish,left

left:	
	cmp al,'a'
	jne right
	mov bx, pac_idx
	sub bx, 1
	cmp grid[bx], -1
	je finish
	jmp checkFood
right:
	cmp al,'d'
	jne down
	mov bx, pac_idx
	add bx, 1
	cmp grid[bx], -1
	je finish
	jmp checkFood
down:
	cmp al,'s'
	jne up
	mov bx, pac_idx
	add bx, 19
	cmp grid[bx], -1
	je finish
	jmp checkFood
up:
	cmp al,'w'
	jne finish
	mov bx, pac_idx
	sub bx, 19
	cmp grid[bx], -1
	je finish
checkFood:
	mov pac_idx, bx
	cmp grid[bx], 1
	jne updatePacPos
    inc food
	mov grid[bx], 0
updatePacPos:
    mov ax, pac_idx
    mov index, ax
    call getPos
    mov ah, 0 
    mov al, row
    mov pac_r, al
    mov al, col
    mov pac_c, al
finish:
  ret
change endp
;;;;;;;;;;;;convert index to Position;;;;;;;;;;;;
getPos proc 
  pushAll
  mov ax, index
  mov bx, 19
  dec ax
  mov dx, 0
  div bx
  inc ax
  mov row, al
  inc dl
  mov col, dl
  popAll
  ret
getPos endp
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
getIndex proc
  pushAll
  mov al, 19
  mov bl, row
  dec bl
  mul bl
  add ax, col
  mov index, ax
  popAll
  ret
getIndex endp  
;;;;;;;;;;;;;;;;;;;;start;;;;;;;;;;;;;;;
start:
  mov ax, @data
  mov ds, ax
;;;;;;;;;;;;;;;;;;;;;set graphic mode;;;;;;;;;
  mov al, 13h
  mov ah, 0
  int 10h
  
  call gridInit
  call drawMaze
  
  mov pac_r, 17
  mov pac_c, 10
  mov row, 17
  mov col, 10
  call getIndex
  
  mov ax, index
  mov pac_idx, ax
  
  run:		
	mov ah,00h
	int 16h
	cmp al,'p'		
	je fin
	mov bl, black
	mov color, bl
	call drawPac		
	call change 
	mov bl, green
	mov color, bl
	call drawPac 
	jmp run

  fin:		
    mov al, 3h
    mov ah, 0
    int 10h
    mov ax, 4c00h
    int 21h
end start
