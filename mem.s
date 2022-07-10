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
;;
;;
;; Necessita de video.s e teclado.s
;;
;;
;; Podem ocorrer incompatibilidades com gui.s
;;
;;
;;*********************************************************************

%ifndef TECLADO_INCLUIDO

%warning "A biblioteca teclado.s deve ser importada primeiro."
%warning "Assim sendo, algumas funcoes nao estarao disponiveis."
%warning "As funcoes que exigem a inclusao dessa biblioteca serao desativadas."

%endif

%ifndef VIDEO_INCLUIDO

%warning "A biblioteca video.s deve ser importada primeiro."
%warning "Assim sendo, algumas funcoes nao estarao disponiveis."
%warning "As funcoes que exigem a inclusao dessa biblioteca serao desativadas."

%endif


pxdosbug:

cli
cld
clc
std
sti

ret

;;*********************************************************************


limpar_memoria:			;; Limpa a memória RAM usando os parâmetros de início e fim

	mov ax,0		;; Em - dx, último endereço, si, endereço inicial
	add dx,1
	
.loop:

	cmp si,dx
	je .pronto
	mov ax,'0'
	mov [si],ax
	add si,1
	jmp .loop
	
jmp .loop

.pronto:

ret


;;*********************************************************************


marcar_memoria:	;; Marca enderecos de memoria RAM

	mov ax,0		;; Em - dx, último endereço, si, endereço inicial
	add dx,1
	
.loop:

	cmp si,dx
	je .pronto
	mov ax,'*'
	mov [si],ax
	add si,1
	jmp .loop
	
jmp .loop

.pronto:

ret

;;*********************************************************************

uso_aplicativo:

;; Em dx, fim da área de memória para o aplicativo
;; Em si, inicio da área de memória para o aplicativo

push dx
push si

mov ax, dx
mov [tabela_inicial], ax

pop si

mov ax, si
mov [tabela_final], ax

pop dx

call limpar_memoria
call marcar_memoria

ret

;;*********************************************************************

ativar_A20:

        cli
 
        call    .aguardarA20
        mov     al,0xAD
        out     0x64,al
 
        call    .aguardarA20
        mov     al,0xD0
        out     0x64,al
 
        call    .aguardarA202
        in      al,0x60
        push    eax
 
        call    .aguardarA20
        mov     al,0xD1
        out     0x64,al
 
        call    .aguardarA20
        pop     eax
        or      al,2
        out     0x60,al
 
        call    .aguardarA20
        mov     al,0xAE
        out     0x64,al
 
        call    .aguardarA20
        sti
        ret
 
.aguardarA20:
        in      al,0x64
        test    al,2
        jnz     .aguardarA20
        ret
 
 
.aguardarA202:
        in      al,0x64
        test    al,1
        jz      .aguardarA202
        ret

;;*********************************************************************  

%ifdef VIDEO_INCLUIDO

parahexa:


	pusha
	mov bp, sp
	mov dx, [ bp +20 ]
	push dx	
	call escrever
	mov dx, [ bp+18 ]

	mov cx, 4
	mov si, hexc
	mov di, hex+2
	
	guardar:
	
	
	rol dx, 4
	mov bx, 15
	and bx, dx
	mov al, [ si+bx ]
	stosb
	loop guardar
	push hex
	call escrever
	mov sp, bp
	popa
	ret

%endif	
	
;;*******************************************************************

	
hex db "0x0000",10,13,0
hexc db "0123456789ABCDEF"
testt db 'Ola!',10,13,0

%ifdef MEM_EXTENSOES

SISTEMA db 'PX-DOS',0
APPAPI db "1.0",0
versaoapi db '1.0',0
		kbs db " kbytes", 13, 10, 0 
		mbs db " megabytes", 13, 10, 0
		
		
%endif		

tabela_inicial equ 30000
tabela_final equ 32768