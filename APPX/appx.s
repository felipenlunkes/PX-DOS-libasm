;;*********************************************************************************
;;
;;                   Cabe�alho de Execut�vel PX-DOS APPX
;;
;;                Desenvolvido por Felipe Miguel Nery Lunkes
;;
;;   Copyright � 2014-2015 Felipe Miguel Nery Lunkes. Todos os direitos reservados.
;;
;;*********************************************************************************

[BITS 16]

org 100h

cabecalho_appx:

.assinatura: dw 'APPX'    ; A assinatura 'APPX' 
.arquitetura: db 7        ; N�vel de Arquitetura a qual se destina o aplicativo. Veja abaixo
.sis_versao: dw 0         ; Vers�o do PX-DOS m�nima suportada
.sis_subversao: db 9      ; Subvers�o do PX-DOS m�nima suportada
.valor_ss: dw 0           ; Valor inicial relativo de SS (segmento de pilha)
.valor_sp: dw 100h        ; Valor inicial de SP
.valor_ip: dw 100h        ; Valor inicial de IP - Sempre 100h!
.programa: dw 90h         ; Tipo de Arquivo Execut�vel (90h = programa principal)
.offset: dw 0             ; Delocamento da tabela de realoca��o a partir do cabe�alho 
.paginas: dw 1            ; N�mero de p�ginas do arquivo incluindo a �ltima parcial
.alocacao_minima: dw 0    ; Aloca��o m�nima de mem�ria, em Kbytes
.alocacao_maxima: dw 0x40 ; Aloca��o m�xima de mem�ria, em Kbytes

;;*********************************************************************************
;;
;;
;; Arquitetura a que se destina o execut�vel APPX
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
;; 5 - AMD x86_x64 ou compat�veis
;; 6 - AMD K6 com 3D!Now
;; 7 - Sem especializa��o / otimiza��o - Usado para processadores gen�ricos quando
;; n�o necessita recursos de um processador em especial. Esta � a op��o mais usada,
;; visto que n�o � poss�vel prever em qual arquitetura o sistema e o aplicativo ser�
;; instalado. Previlegie esta op��o. Aviso! O n�vel de arquitetura 7 requer
;; um processador 186 ou mais recente. O n�vel 7 � habilitado automaticamente
;; ao se executar o servi�o APPX.EPX, presente no disco do sistema.
;; Este � o servi�o de gerenciamento mestre do formato APPX para PX-DOS.
;;
;;*********************************************************************************

;; times (32-$+$$) db 0 ;; Offset de In�cio do Aplicativo - Implementando

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

mov ah, 06h ;; Fun��o para a aloca��o de mem�ria do aplicativo
mov bx, 1
mov cx, 100h ;; Alocar 100h Kbytes para dados

int 90h
