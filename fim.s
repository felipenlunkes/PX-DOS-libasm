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


SDK_fim:         ;; Fim do aplicativo

cli
clc
cld
std
sti

xor ax, ax

mov ah, 02h
mov bx, 00h

int 90h
