;;*****************************************************************************
;;
;;         ____
;;        / __ \           Ambiente de Desenvolvimento para PX-DOS�
;;       / |__| \       Copyright � 2012-2016 Felipe Miguel Nery Lunkes
;;      /  /  \  \               Todos os direitos reservados
;;     /__/    \__\ssembly 
;;
;;
;;*****************************************************************************
;;
;; Sistema Operacional PX-DOS�. Copyright � 2012-2016 Felipe Miguel Nery Lunkes.
;; O Sistema Operacional PX-DOS� � protegido por direitos autorais.
;;
;;*****************************************************************************
;;
;;         A presente biblioteca est� protegida por direitos autorais.
;;   Sendo assim, medidas judiciais podem ser tomadas ap�s a reprodu��o de
;;  qualquer trecho do c�digo nela presente, salvo permiss�o por escrito de
;;                       seu desenvolvedor, acima citado.
;;
;;
;;******************************************************************************

%ifndef PXDOS_INCLUIDO

%include "C:\Dev\ASM\pxdos.s"

%endif
	
detectar_sistema_atual:

mov ah, 13h
int 90h

call paraString

mov si, ax
call escrever

print ".",0

jmp subver

;;************************************************************

subver:

mov ah, 13h
int 90h

cmp bx, SUBVERSAO

mov ax, bx
call paraString

mov si, ax
call escrever

print ".",0

jmp revisao

;;************************************************************

revisao:

mov ah, 13h
int 90h

mov ax, cx
call paraString

mov si, ax
call escrever

ret

;;************************************************************