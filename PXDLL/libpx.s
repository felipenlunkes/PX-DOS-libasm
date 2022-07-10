;;*********************************************************************************
;;
;;           Cabe�alho da Biblioteca de V�nculo Din�mico do PX-DOS
;;
;;                Desenvolvido por Felipe Miguel Nery Lunkes
;;
;;   Copyright � 2014-2015 Felipe Miguel Nery Lunkes. Todos os direitos reservados.
;;
;;*********************************************************************************

[BITS 16]

org 123h ;; Offset de in�cio da Biblioteca de V�nculo Din�mico do PX-DOS

dw "LIBPX",0 ;; Assinatura da Biblioteca de V�nculo Din�mico do PX-DOS

db 7        ;; Arquitetura a qual se destina a Biblioteca de V�nculo Din�mico 
            ;; do PX-DOS. Leia abaixo para maiores 
            ;; informa��es sobre esta declara��o de cabe�alho.

;;*********************************************************************************
;;
;;
;; Arquitetura a que se destina a Biblioteca de V�nculo Din�mico do PX-DOS
;;
;; Esta declara��o identifica para qual arquitetura o aplicativo foi desenvolvido
;; para ser executado da forma apropriada.
;;
;; Lista de valores v�lidos e suas refer�ncias:
;;
;; 1 - Intel 8086 ou compat�vel
;; 2 - Intel 186 ou compat�vel
;; 3 - Intel 286 ou compat�vel
;; 4 - Intel Pentium ou superiores
;; 5 - AMD x86_x64 iu compat�veis
;; 6 - AMD K6 com 3D!Now
;; 7 - Sem especializa��o / otimiza��o - Usado para processadores gen�ricos quando
;; n�o necessita recursos de um processador e especial. Esta � a op��o mais usada,
;; visto que n�o � poss�vel prever em qual arquitetura o sistema e o aplicativo ser�o
;; instalados. Previlegie esta op��o.
;;
;;*********************************************************************************

db 0        ;; Vers�o maior do sistema requerido

db 9        ;; Vers�o menor do sistema requerido

mov ax, cs
mov bx, ax
mov ds, ax
mov cx ,ax
mov es, ax
mov gs, ax
mov fs, ax

xor eax, eax

push sp
push ss
push bp

mov dx, msg
mov ah, 03h
int 90h

mov ah, 02h
mov bx, 01h
int 90h

init:


pop bp
pop ss
pop sp

push ax
push bx
push cx
push dx
push di
push si
push ds
push cs


msg db "Este arquivo e uma Biblioteca, nao um executavel valido.",0
