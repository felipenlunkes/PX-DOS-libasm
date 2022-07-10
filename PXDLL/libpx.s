;;*********************************************************************************
;;
;;           Cabeçalho da Biblioteca de Vínculo Dinâmico do PX-DOS
;;
;;                Desenvolvido por Felipe Miguel Nery Lunkes
;;
;;   Copyright © 2014-2015 Felipe Miguel Nery Lunkes. Todos os direitos reservados.
;;
;;*********************************************************************************

[BITS 16]

org 123h ;; Offset de início da Biblioteca de Vínculo Dinâmico do PX-DOS

dw "LIBPX",0 ;; Assinatura da Biblioteca de Vínculo Dinâmico do PX-DOS

db 7        ;; Arquitetura a qual se destina a Biblioteca de Vínculo Dinâmico 
            ;; do PX-DOS. Leia abaixo para maiores 
            ;; informações sobre esta declaração de cabeçalho.

;;*********************************************************************************
;;
;;
;; Arquitetura a que se destina a Biblioteca de Vínculo Dinâmico do PX-DOS
;;
;; Esta declaração identifica para qual arquitetura o aplicativo foi desenvolvido
;; para ser executado da forma apropriada.
;;
;; Lista de valores válidos e suas referências:
;;
;; 1 - Intel 8086 ou compatível
;; 2 - Intel 186 ou compatível
;; 3 - Intel 286 ou compatível
;; 4 - Intel Pentium ou superiores
;; 5 - AMD x86_x64 iu compatíveis
;; 6 - AMD K6 com 3D!Now
;; 7 - Sem especialização / otimização - Usado para processadores genéricos quando
;; não necessita recursos de um processador e especial. Esta é a opção mais usada,
;; visto que não é possível prever em qual arquitetura o sistema e o aplicativo serão
;; instalados. Previlegie esta opção.
;;
;;*********************************************************************************

db 0        ;; Versão maior do sistema requerido

db 9        ;; Versão menor do sistema requerido

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
