;;***********************************************************
;;
;; Cabe�alho de Driver para PX-DOS 0.9.0 ou superior
;;
;;
;;
;;
;;
;;
;;***********************************************************

[BITS 16]      ;; Define que o c�digo gerado dever� ser 16 Bits

org 0h          ;; Define o Offset para 0 (0h)

;; Aviso! Altere o c�digo abaixo para enquadrar a fun��o de seu Driver

;-----------------------------------------------+
;         DWORD - Assinatura do Driver          | 1 word
;                      PX                       | 
;-----------------------------------------------+
;            Tipo do Dispositivo                ; 1 word
;                                               ;
; 1h - Dispositivo de caracter (V�deo...)       ;
; 2h - M�dias de armazenamento de massa (HD, CD);
; 3h - M�dias de armazenamento (Disquete)       ;
; 4h - Rel�gio                                  ;
; 5h - Rede e acesso a perif�ricos              ;
; 6h - Configura��o                             ;
; 7h - Porta Serial COM                         ;
; 8h - Reservado ao Sistema                     ;
; 9h - Subsistema PX-DOS                        ;
; 10 - Porta Serial COM2                        ;
; 12 - Porta Paralela LPT1                      ;
; 12 - USB                                      ;
;-----------------------------------------------+
;            N�mero da interrup��o              ; 1 word
;          implementada pelo Driver             ;
;-----------------------------------------------+
;     Tipo de Driver e Dispositivo associado    ; 11 bytes
;                                               ;
; Deve conter at� letras, mais at� oito espacos,;
;         formando 11 bytes no total.           ;
;                                               ;
;   Pode ser (n�o se resumindo apenas a):       ;
;                                               ;
; "DEV        " - Dispositivo                   ;
; "ARMAZENAMEN" - Armazenamento                 ;
; "IO         " - Entrada e Sa�da               ;
; "REDE       " - Redes diversas                ;
; "RELOGIO    " - Relogio                       ;
;                                               ;
; Estes s�o nomes padr�o. Nomes customizados    ;
; podem ser utilizados.                         ;
;-----------------------------------------------+
;  Ponteiro para o ponto de entrada do Driver   ; 1 word
;-----------------------------------------------+
;     Ponteiro para a Interrup��o do Driver     ; 1 word
;-----------------------------------------------+
;  Vers�o do Sistema Requerida para a execu��o  ; 1 byte
;-----------------------------------------------;
;Subvers�o do Sistema Requerida para a execu��o ; 1 byte
;-----------------------------------------------;

Driver: ;; In�cio do Cabe�alho, que dever� estar presente no in�cio do arquivo
        ;; execut�vel.

.assinatura: dw "PX"           ;; A declara��o da assinatura deve estar aqui, no in�cio.
.tipo: dw 6h                   ;; Tipo do Driver
.numero: dw 0                  ;; N�mero da interrup��o implementada pelo Driver
.nome_driver: db "MEM        " ;; Tipo de fun��o v�lida a ser exercida pelo Driver   	
.estrategia: dw INICIO         ;; Ponto de Entrada para o in�cio
.interrupcao: dw INTE          ;; Ponto de Entrada para a Interrup��o     
.versao: dw 0                  ;; Vers�o Maior do sistema requerida
.subversao: dw 9               ;; Vers�o Menor do sistema requerida - Sendo assim, juntando
                               ;; as duas declara��es, o driver foi desenvolvido para a
                               ;; vers�o 0.9.0 do PX-DOS ou superiores 
			
;; Fim do cabe�alho

push sp
push ss
push bp
push cs
push ds

mov ax, cs
mov es, ax
mov gs, ax
mov fs, ax

xor ax, ax



					  