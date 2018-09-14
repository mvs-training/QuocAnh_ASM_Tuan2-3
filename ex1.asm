.model small
.stack
.data

FileName db "*.*",0 ;thu muc hien tai
DTA 	 db 128 dup(?) ;buffer de luu tru DTA 

.code

mov ax,@data  
mov ds,ax 
mov es,ax 

mov dx,OFFSET DTA 	
mov ah,1AH 		; set DTA
int 21h 		

mov cx,3Fh 		; attribute mask
mov dx,OFFSET FileName 
mov ah,4Eh 		; Find First
int 21h 		

Loop1:

mov dx,OFFSET FileName 	
mov ah,4Fh 		; Find Next
int 21h 		

jc exit 	

mov cx,13 		; chieu dai filename
mov si,OFFSET DTA+30 	
xor bh,bh 		; video page - 0
mov ah,0Eh 		; Write Character

NextChar:

lodsb 		; AL = ki tu tiep theo
int 10h 	

loop NextChar

mov di,OFFSET DTA+30 	
mov cx,13 		; chieu dai filename
xor al,al 		
rep stosb 		; clear DTA

jmp Loop1 	


exit:

mov ax,4C00h 	; thoat DOS
int 21h

end