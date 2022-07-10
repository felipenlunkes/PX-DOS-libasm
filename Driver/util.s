
;;*******************************************************************
;;                                                                  *
;;           														*
;;     Biblioteca de execução para a construção de Drivers para     *
;;																	*
;;                 o Sistema Operacional PX-DOS     				*
;;																	*
;;																	*
;;   Esta biblioteca implementa rotinas padrão compatíveis com o	*
;;																	*
;;                             sistema.								*
;;																	*
;;												 					*
;;																	*
;;         Copyright (C) 2015 Felipe Miguel Nery Lunkes				*
;;																	*
;;*******************************************************************
;;                    											    *
;;     Lista de Macros para a utilização em Drivers para PX-DOS     *
;;                                                                  *
;;																	*
;;*******************************************************************

[BITS 16]

;;*******************************************************************

%macro imprimir 1+

     section .data 
	 
 %%string:
 
     db %1,0
	 
     section .text    
 
     mov dx,%%string
	 mov ah, 03h
     int 90h
	 
 %endmacro
 
;;*******************************************************************
 
 %macro copyright 1+
 
     section .data 
	 
 %%string:
 
     db %1,0 
	 
 %endmacro

;;*******************************************************************
 
 %macro autor 1+
 
     section .data
	 
 %%string:
 
     db %1,0 
	 
 %endmacro
 
;;*******************************************************************

%macro licenca 1+

section .data

%%string:

db %1,0

%endmacro 

;;*******************************************************************

%macro descricao 1+

section .data

%%string:

db %1, 0

%endmacro 

;;*******************************************************************

%macro Instalar_Interrupcoes 2
	mov word [es: %1 * 4], %2
	mov word [es: %1 * 4 + 2], cs
%endm
