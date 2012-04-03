; Author : Abhik Mondal
; Roll no: CS10B061

.model small
.stack 100h
assume ds:data1 ,cs:code1

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
data1 segment
	input		db	10 dup('$'),'$'
	output      db  10 dup('$'),'$' 
	p_row		dw 99
	p_column	dw 99
data1 ends
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;         
DrawPixel macro row,column
	push ax
	push bx
	push cx
	push dx
	mov dx,row
	mov	cx,column	
	mov ah,0ch
	int 10h
	pop dx
	pop cx
	pop bx
	pop ax
	
endm

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
code1 segment
    start:

  	 	mov 	ax,data1
  		mov 	ds,ax   
		mov		al,13h              ; set text mode
		mov 	ah, 0               ; graphix mode
		int 	10h
		mov		al,1001b
		DrawPixel p_row,p_column
		call DrawPac
	run:		
		mov ah,00h
		int 16h
		cmp al,'p'		
		je fin
		call DrawPacClear		
		call change 
		call DrawPac
		jmp run
		fin:		
		mov 	ax,4c00h            ; termination
	    int 	21h		
;			PROCEDURES DEFINED HERE
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
change proc near
	local up,right,down,finish
	
	cmp al,'a'
	jne right
	cmp p_column,9
	jne else1
	mov p_column,319
	else1:		
	sub p_column,10
 	jmp	finish
right:
	cmp al,'d'
	jne down
	cmp p_column,319
	jne else2
	mov p_column,9
	else2:		
	add p_column,10
	jmp finish
down:
	cmp al,'s'
	jne up
	cmp p_row,199
	jne else3
	mov p_row,9
	else3:		
	add p_row,10
	jmp finish
up:
	cmp al,'w'
	jne finish
	cmp p_row,9
	jne else4
	mov p_row,209
	else4:
	sub p_row,10
finish:
ret
change endp

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;    
ClearScreen proc near
       push     ax
       push     bx
       push     cx
       push     dx
       mov      al,0000 
	   mov      dx,200
       mov      cx,320
clrscr: 
	   mov     ah,0ch
       int     10h     ; Set the Pixel
       dec      cx
       jnz      clrscr
       dec      dx
       mov      cx,320	
       cmp      dx,0
       jge      clrscr
       pop      dx
       pop      cx
       pop      bx
       pop      ax
		ret
 ClearScreen endp 
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;   SET COLOR OF BACKGROUND IN GRAPHICS MODE     

;   color is stored in al before calling   
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	color proc near
		mov 	al, 0001	
		mov 	cx,0            ; starting row
		mov 	dx,0            ; starting column
	a:
		mov 	ah, 0ch
		int 	10h     		; set pixel. 
		inc 	dx              ; increment till 200
		cmp 	dx,0C8h         ; color 200 pixels in a column
		jle		a	            
		mov 	dx,0            ; set row number to 0 again
		inc 	cx              ; increment till 320
		cmp 	cx,13Fh         ; color 320 pixels in each row
		jle 	a		
		ret	
	color endp

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;	
;	SET CURSOR TO COORDINATE
	
;	THE ROW AND COLUMN COORDINATES ARE STORED IN DH,DL BEFORE CALLING
	
	setcursor proc near
		mov 	bh, 0           ; page no.     
		mov 	ah, 2           ; set cursor
		int 	10h
		ret
	setcursor endp
	
DrawPac proc near	
		push ax
		push bx 
		push cx
		push dx
		mov ax,p_row
		mov bx,p_column
		mov cx,10            ; starting row
		mov dx,10           ; starting column
	it:
		DrawPixel p_row,p_column		
 		dec p_row
		dec dx		
		cmp dx,0
 		jne it
		mov dx,10
		dec cx
		dec p_column
		mov p_row,ax
		cmp cx,0
		jne it
		mov p_row,ax
		mov p_column,bx
		pop dx	
		pop cx
		pop bx
		pop ax
	ret
DrawPac endp

DrawPacClear proc near	
		push ax
		push bx 
		push cx
		push dx
		mov ax,0000
		mov bx,p_row
		mov cx,10            ; starting row
		mov dx,10           ; starting column
	itc:
		DrawPixel p_row,p_column		
 		dec p_row
		dec dx		
		cmp dx,0
 		jne itc
		mov dx,10
		dec cx
		dec p_column
		add p_row,10
		cmp cx,0
		jne itc
		add p_column,10
		pop dx	
		pop cx
		pop bx
		pop ax
	ret
DrawPacClear endp
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

code1 ends
    end start
