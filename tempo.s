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

;; Em AX, o tempo, em segundos, para esperar.

delay:

	pusha
	cmp ax, 0
	je .tempo_para			

	mov cx, 0
	mov [.var_contar], cx		

	mov bx, ax
	mov ax, 0
	mov al, 2			; 2 * 55ms = 110mS
	mul bx				
	mov [.delay_original], ax	

	mov ah, 0
	int 1Ah				

	mov [.contagem_anterior], dx

.checarLoop:
	mov ah,0
	int 1Ah				

	cmp [.contagem_anterior], dx	

	jne .na_hora			
	jmp .checarLoop			

.tempo_para:
	popa
	ret

.na_hora:
	mov ax, [.var_contar]		; Incrementar var_contar
	inc ax
	mov [.var_contar], ax

	cmp ax, [.delay_original]	
	jge .tempo_para		

	mov [.contagem_anterior], dx	

	jmp .checarLoop		


	.delay_original		dw	0
	.var_contar		dw	0
	.contagem_anterior	dw	0