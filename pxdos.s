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

%include "C:\Dev\ASM\video.s"

%endif

%define PXDOS_INCLUIDO

BIOS:

cli
cld
clc
std
sti

ret


;;*********************************************************************


pxdoshlt:

cli
std 
clc
cld
sti

nop
nop

xor ax, ax
mov ax, 0

nop
hlt


;;*********************************************************************


%ifdef  VIDEO_INCLUIDO

printf:

call escrever
ret

%endif

%ifdef  VIDEO_INCLUIDO

printk:

call escrever

cli
cld
std
sti

ret

%endif

%ifdef TECLADO_INCLUIDO

scanf:

call ler
ret

%endif


;;*********************************************************************


binparadecimal:

;; AL = entrada
;; AX = Saída

	pusha

	mov bl, al			

	and ax, 0Fh			
	mov cx, ax			

	shr bl, 4		
	mov al, 10
	mul bl				

	add ax, cx			
	mov [.tmp], ax

	popa
	mov ax, [.tmp]			
	ret


	.tmp	dw 0
	
	
	
;;****************************************************************

	
pausar:
	
;; AX: Tempo para pausar a execução do programa
	
	
	pusha
	cmp ax, 0
	je .passou			

	mov cx, 0
	mov [.var_contar], cx		

	mov bx, ax
	mov ax, 0
	mov al, 2			
	mul bx				
	mov [.delayoriginal], ax	

	mov ah, 0
	int 1Ah				

	mov [.anterior], dx	

.checarloop:
	mov ah,0
	int 1Ah				

	cmp [.anterior], dx	

	jne .sincronizado			
	jmp .checarloop			

.passou:
	popa
	ret

.sincronizado:
	mov ax, [.var_contar]		
	inc ax
	mov [.var_contar], ax

	cmp ax, [.delayoriginal]
	jge .passou			

	mov [.anterior], dx	

	jmp .checarloop			


	.delayoriginal	dw	0
	.var_contar		dw	0
	.anterior	dw	0

;;*********************************************************************

paraString:


        pusha
        mov cx, 0
        mov bx, 10
        mov di, .tmp
		
.empurrar:

        mov dx, 0
        div bx
        inc cx
        push dx
        test ax,ax
        jnz .empurrar
		
.puxar:
        pop dx
        add dl, '0'
        mov [di], dl
		inc di
        dec cx
        jnz .puxar

        mov byte [di], 0
        popa
        mov ax, .tmp
		ret
		
        .tmp times 7 db 0

;;************************************************************
		
verificar_sistema:

mov ah, 13h
int 90h

cmp ax, VERSAO
je near Continua

jmp FIMVDI

;;************************************************************

Continua:

cmp bx, SUBVERSAO
je near correto

jmp FIMVDI

;;************************************************************

correto:

ret

;;************************************************************

FIMVDI:

print 10,13,"Versao incorreta do PX-DOS ou DOS",10,13,0

mov ah, 02h
mov bx, 1h
int 90h

;;************************************************************

;;************************************************************
;;
;; Inclui algumas funções úteis à biblioteca, como o
;; procedimento de fechamento de um aplicativo.
;;
;;************************************************************

%include "C:\Dev\ASM\fim.s"
%include "C:\Dev\ASM\Espec\px090.esp" ;; Arquivo com as especificações

;;************************************************************
		
kbs db " kbytes", 13, 10, 0 
mbs db " megabytes", 13, 10, 0