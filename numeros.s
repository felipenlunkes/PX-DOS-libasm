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

atoi:


mov bp, sp
mov bx, [ bp+0x2 ]
push bx
call tamanhoString

add bx, ax
xor di, di
mov al, 1
xor cx, cx

atoi_f1:


mov dl, [ bx ]

cmp dl, '0'
jl    atoi_sair

cmp dl, '9'
jg    atoi_sair

push dx
push ax
sub dl, 0x30
mul dl
add cx, ax
pop ax
mov dl, 10
mul dl
pop dx
dec bx

cmp bx, [ bp+0x2 ]
jz atoi_sair

jmp atoi_f1

atoi_sair:


mov ax, cx
ret 2

tamanhoString:


mov bp, sp
mov bx, [ bp+0x02 ]
xor di,di

tamanhoString_w1:


mov dl, [ bx+di ]
inc di

cmp dl, '$'
jne tamanhoString_w1

dec di
dec di
mov ax, di
ret 2

;;****************************************************************

