;;*****************************************************************************
;;
;;         ____
;;        / __ \           Ambiente de Desenvolvimento para PX-DOS®
;;       / |__| \       Copyright © 2012-2016 Felipe Miguel Nery Lunkes
;;      /  /  \  \               Todos os direitos reservados
;;     /__/    \__\ssembly 
;;
;;
;;*****************************************************************************
;;
;; Sistema Operacional PX-DOS®. Copyright © 2012-2016 Felipe Miguel Nery Lunkes.
;; O Sistema Operacional PX-DOS® é protegido por direitos autorais.
;;
;;*****************************************************************************

%define TECLADO_INCLUIDO

;; Mapeamento de teclado para uso com a interface

DEL equ 1Bh
F8 equ 4200h
CTRLC equ 03h
Espaco equ 20h
ESCAPE equ 1Bh
SHIFT1 equ 21h
SHIFT2 equ 22h
SHIFT3 equ 23h
SHIFT4 equ 24h
SHIFT5 equ 25h
SHIFT6 equ 26h
SHIFT7 equ 27h
SHIFT8 equ 28h
SHIFT9 equ 29h
SHIFT0 equ 2Ah
Mais equ 2Bh
Menos equ 2Dh
Igual equ 3Dh
AMai equ 41h
AMin equ 61h
BMai equ 42h
BMin equ 62h
CMai equ 43h
CMin equ 63h
DMai equ 44h
DMin equ 64h
EMai equ 45h
EMin equ 65h
FMai equ 46h
FMin equ 66h
GMai equ 47h
GMin equ 67h
HMai equ 48h
HMin equ 68h
IMai equ 49h
IMin equ 69h
JMai equ 4Ah
JMin equ 6Ah
KMai equ 4Bh
KMin equ 6Bh
LMai equ 4Ch
LMin equ 6Ch
MMai equ 4Dh
MMin equ 6Dh
NMai equ 4Eh
NMin equ 6Eh
OMai equ 4Fh
Omin equ 6Fh
PMai equ 50h
PMin equ 70h
QMai equ 51h
QMin equ 71h
RMai equ 52h
RMin equ 72h
SMai equ 53h
SMin equ 73h
TMai equ 54h
TMin equ 74h
UMai equ 55h
UMin equ 75h
VMai equ 56h
VMin equ 76h
WMai equ 57h
WMin equ 77h
XMai equ 58h
XMin equ 78h
YMai equ 59h
YMin equ 79h
ZMai equ 5Ah
ZMin equ 7Ah
Del equ 7fh
Backspace equ 08h
Interrogacao equ 3Fh
   
;;****************************************************************


ler:  

xor cl, cl


.loop:

mov ah, 0
int 0x16

cmp al, 0x08
je .apagar

cmp al, 0x0D
je .pronto

cmp cl, 0x3F
je .loop

mov ah, 0x0E
int 0x10

stosb

inc cl

jmp .loop


.apagar:          ;; Usa o Driver de Teclado Principal para apagar um caracter


cmp cl, 0
je .loop


dec di
mov byte [di], 0
dec cl

mov ah, 0x0E
mov al, 0x08
int 10h

mov al, ' '
int 10h

mov al, 0x08
int 10h

jmp .loop


.pronto:          ;; Tarefa ou rotina concluida


mov al, 0

stosb

mov ah, 0x0E
mov al, 0x0D
int 0x10

mov al, 0x0A
int 0x10

ret

;;****************************************************************

aguardar_tecla:

mov ax, 0
int 16h

ret

;;****************************************************************

identificar_tecla:

mov     ah, 1
int     16h
jz      identificar_tecla

mov     ah, 0
int     16h

ret

;;****************************************************************

para_Maiusculo: ;; Esta função requer um ponteiro para a string, em DS:SI

	pusha
	
	mov bx, 0xFFFF						;; Início em -1, dentro da String
	
para_Maiusculo_loop:	

	inc bx
	mov al, byte [ds:si+bx]				;; Em al, o caracter atual
	
	cmp al, 0							;; Caso no fim da String
	je para_Maiusculo_pronto			;; Está tudo pronto
	
	cmp al, 'a'
	jb para_Maiusculo_loop              ;; Código ASCII muito baixo para ser minúsculo
	
	cmp al, 'z'
	ja para_Maiusculo_loop              ;; Código ASCII muito alto para ser minúsculo
	
	sub al, 'a'-'A'
	mov byte [ds:si+bx], al				;; Subtraia e transformar em maiúsculo
	
	jmp para_Maiusculo_loop             ;; Próximo caractere
	
para_Maiusculo_pronto:	

	popa
	
	ret

;;****************************************************************
	
%macro input 1+
     section .data    
 
     mov di, ax
     call ler
	 
 %endmacro
