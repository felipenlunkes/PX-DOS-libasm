;;*********************************************************************************
;;
;;                   Cabeçalho de Executável PX-DOS APPX
;;
;;                Desenvolvido por Felipe Miguel Nery Lunkes
;;
;;   Copyright © 2014-2015 Felipe Miguel Nery Lunkes. Todos os direitos reservados.
;;
;;*********************************************************************************

[BITS 16]

org 100h

cabecalho_appx:

.assinatura: dw 'APPX'    ; A assinatura 'APPX' 
.arquitetura: db 7        ; Nível de Arquitetura a qual se destina o aplicativo. Veja abaixo
.sis_versao: dw 0         ; Versão do PX-DOS mínima suportada
.sis_subversao: db 9      ; Subversão do PX-DOS mínima suportada
.valor_ss: dw 0           ; Valor inicial relativo de SS (segmento de pilha)
.valor_sp: dw 100h        ; Valor inicial de SP
.valor_ip: dw 100h        ; Valor inicial de IP - Sempre 100h!
.programa: dw 90h         ; Tipo de Arquivo Executável (90h = programa principal)
.offset: dw 0             ; Delocamento da tabela de realocação a partir do cabeçalho 
.paginas: dw 1            ; Número de páginas do arquivo incluindo a última parcial
.alocacao_minima: dw 0    ; Alocação mínima de memória, em Kbytes
.alocacao_maxima: dw 0x40 ; Alocação máxima de memória, em Kbytes

;;*********************************************************************************
;;
;;
;; Arquitetura a que se destina o executável APPX
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
;; 5 - AMD x86_x64 ou compatíveis
;; 6 - AMD K6 com 3D!Now
;; 7 - Sem especialização / otimização - Usado para processadores genéricos quando
;; não necessita recursos de um processador em especial. Esta é a opção mais usada,
;; visto que não é possível prever em qual arquitetura o sistema e o aplicativo será
;; instalado. Previlegie esta opção. Aviso! O nível de arquitetura 7 requer
;; um processador 186 ou mais recente. O nível 7 é habilitado automaticamente
;; ao se executar o serviço APPX.EPX, presente no disco do sistema.
;; Este é o serviço de gerenciamento mestre do formato APPX para PX-DOS.
;;
;;*********************************************************************************

;; times (32-$+$$) db 0 ;; Offset de Início do Aplicativo - Implementando

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

mov ah, 06h ;; Função para a alocação de memória do aplicativo
mov bx, 1
mov cx, 100h ;; Alocar 100h Kbytes para dados

int 90h
