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


;;*******************************************************************


emitirsom:       ;; Mova para ax o tom a ser emitido pelo sistema.

    pusha

	mov cx, ax	 ;; Som a ser emitido		

	mov al, 182  ;; Dado a ser enviado
	out 43h, al  
	mov ax, cx			
	out 42h, al
	mov al, ah
	out 42h, al

	in al, 61h			
	or al, 03h
	out 61h, al

	popa
	
	ret
	

;;*******************************************************************
	
	
desligarsom:      ;; Desliga o som do Computador

	
	pusha

	in al, 61h
	and al, 0FCh
	out 61h, al

	popa
	
	ret	
	

;;*******************************************************************	
	
