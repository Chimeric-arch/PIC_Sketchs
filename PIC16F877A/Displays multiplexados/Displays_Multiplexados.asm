
_interrupt:
	MOVWF      R15+0
	SWAPF      STATUS+0, 0
	CLRF       STATUS+0
	MOVWF      ___saveSTATUS+0
	MOVF       PCLATH+0, 0
	MOVWF      ___savePCLATH+0
	CLRF       PCLATH+0

;Displays_Multiplexados.c,38 :: 		void interrupt()
;Displays_Multiplexados.c,40 :: 		if (TMR0IF_bit)                                                               // Overflow do TIMER0 configurado para 1ms
	BTFSS      TMR0IF_bit+0, BitPos(TMR0IF_bit+0)
	GOTO       L_interrupt0
;Displays_Multiplexados.c,42 :: 		TMR0 = 0x06;
	MOVLW      6
	MOVWF      TMR0+0
;Displays_Multiplexados.c,43 :: 		TMR0IF_bit = 0x00;
	BCF        TMR0IF_bit+0, BitPos(TMR0IF_bit+0)
;Displays_Multiplexados.c,44 :: 		DispMultiplex(valor);
	MOVF       _valor+0, 0
	MOVWF      FARG_DispMultiplex_num+0
	MOVF       _valor+1, 0
	MOVWF      FARG_DispMultiplex_num+1
	CALL       _DispMultiplex+0
;Displays_Multiplexados.c,45 :: 		}
L_interrupt0:
;Displays_Multiplexados.c,46 :: 		}
L_end_interrupt:
L__interrupt43:
	MOVF       ___savePCLATH+0, 0
	MOVWF      PCLATH+0
	SWAPF      ___saveSTATUS+0, 0
	MOVWF      STATUS+0
	SWAPF      R15+0, 1
	SWAPF      R15+0, 0
	RETFIE
; end of _interrupt

_main:

;Displays_Multiplexados.c,49 :: 		void main()
;Displays_Multiplexados.c,51 :: 		displayInit();
	CALL       _displayInit+0
;Displays_Multiplexados.c,52 :: 		while(1)
L_main1:
;Displays_Multiplexados.c,54 :: 		valor++;                                                                    // Variável com o valor a ser printado no display / 4 DIGITOS
	INCF       _valor+0, 1
	BTFSC      STATUS+0, 2
	INCF       _valor+1, 1
;Displays_Multiplexados.c,55 :: 		delay_ms(100);
	MOVLW      2
	MOVWF      R11+0
	MOVLW      4
	MOVWF      R12+0
	MOVLW      186
	MOVWF      R13+0
L_main3:
	DECFSZ     R13+0, 1
	GOTO       L_main3
	DECFSZ     R12+0, 1
	GOTO       L_main3
	DECFSZ     R11+0, 1
	GOTO       L_main3
	NOP
;Displays_Multiplexados.c,56 :: 		}
	GOTO       L_main1
;Displays_Multiplexados.c,57 :: 		}
L_end_main:
	GOTO       $+0
; end of _main

_displayInit:

;Displays_Multiplexados.c,60 :: 		void displayInit()                                                              // Inicializa display e configura timer0
;Displays_Multiplexados.c,62 :: 		TRISB = 0x00;                                                                 // Configura PORTB como saida
	CLRF       TRISB+0
;Displays_Multiplexados.c,63 :: 		PORTB = 0x00;                                                                 // Configura PORTD como saida
	CLRF       PORTB+0
;Displays_Multiplexados.c,65 :: 		TRISD = 0x00;
	CLRF       TRISD+0
;Displays_Multiplexados.c,66 :: 		PORTD = 0x0F;
	MOVLW      15
	MOVWF      PORTD+0
;Displays_Multiplexados.c,68 :: 		GIE_bit = 0x01;                                                               // Habilita interrupção global
	BSF        GIE_bit+0, BitPos(GIE_bit+0)
;Displays_Multiplexados.c,69 :: 		PEIE_bit = 0x01;                                                              // Habilita interrupção periférica
	BSF        PEIE_bit+0, BitPos(PEIE_bit+0)
;Displays_Multiplexados.c,70 :: 		TMR0IE_bit = 0x01;                                                            // Habilita interrupção do TIMER0
	BSF        TMR0IE_bit+0, BitPos(TMR0IE_bit+0)
;Displays_Multiplexados.c,71 :: 		TMR0 = 0x06;                                                                  // Inicializa TIMER0 EM 6
	MOVLW      6
	MOVWF      TMR0+0
;Displays_Multiplexados.c,72 :: 		OPTION_REG = 0x02;                                                            // Configura prescaler para 1:8
	MOVLW      2
	MOVWF      OPTION_REG+0
;Displays_Multiplexados.c,73 :: 		}
L_end_displayInit:
	RETURN
; end of _displayInit

_DispMultiplex:

;Displays_Multiplexados.c,76 :: 		void DispMultiplex(int num)
;Displays_Multiplexados.c,80 :: 		if (display == 0x01 && dsp1)                                                  // Multiplexa display 1
	MOVF       DispMultiplex_display_L0+0, 0
	XORLW      1
	BTFSS      STATUS+0, 2
	GOTO       L_DispMultiplex6
	BTFSS      RD0_bit+0, BitPos(RD0_bit+0)
	GOTO       L_DispMultiplex6
L__DispMultiplex41:
;Displays_Multiplexados.c,82 :: 		display =  0x02;
	MOVLW      2
	MOVWF      DispMultiplex_display_L0+0
;Displays_Multiplexados.c,83 :: 		dsp2 = 0x01;
	BSF        RD1_bit+0, BitPos(RD1_bit+0)
;Displays_Multiplexados.c,84 :: 		dsp3 = 0x01;
	BSF        RD2_bit+0, BitPos(RD2_bit+0)
;Displays_Multiplexados.c,85 :: 		dsp4 = 0x01;
	BSF        RD3_bit+0, BitPos(RD3_bit+0)
;Displays_Multiplexados.c,86 :: 		clearData();
	CALL       _clearData+0
;Displays_Multiplexados.c,87 :: 		dsp1 = 0x00;
	BCF        RD0_bit+0, BitPos(RD0_bit+0)
;Displays_Multiplexados.c,88 :: 		decodeDisplay (num/1000);
	MOVLW      232
	MOVWF      R4+0
	MOVLW      3
	MOVWF      R4+1
	MOVF       FARG_DispMultiplex_num+0, 0
	MOVWF      R0+0
	MOVF       FARG_DispMultiplex_num+1, 0
	MOVWF      R0+1
	CALL       _Div_16x16_S+0
	MOVF       R0+0, 0
	MOVWF      FARG_decodeDisplay_num+0
	MOVF       R0+1, 0
	MOVWF      FARG_decodeDisplay_num+1
	CALL       _decodeDisplay+0
;Displays_Multiplexados.c,89 :: 		}
	GOTO       L_DispMultiplex7
L_DispMultiplex6:
;Displays_Multiplexados.c,91 :: 		else if (display == 0x02 && dsp2)                                             // Multiplexa display 2
	MOVF       DispMultiplex_display_L0+0, 0
	XORLW      2
	BTFSS      STATUS+0, 2
	GOTO       L_DispMultiplex10
	BTFSS      RD1_bit+0, BitPos(RD1_bit+0)
	GOTO       L_DispMultiplex10
L__DispMultiplex40:
;Displays_Multiplexados.c,93 :: 		display =  0x03;
	MOVLW      3
	MOVWF      DispMultiplex_display_L0+0
;Displays_Multiplexados.c,94 :: 		dsp1 = 0x01;
	BSF        RD0_bit+0, BitPos(RD0_bit+0)
;Displays_Multiplexados.c,95 :: 		dsp3 = 0x01;
	BSF        RD2_bit+0, BitPos(RD2_bit+0)
;Displays_Multiplexados.c,96 :: 		dsp4 = 0x01;
	BSF        RD3_bit+0, BitPos(RD3_bit+0)
;Displays_Multiplexados.c,97 :: 		clearData();
	CALL       _clearData+0
;Displays_Multiplexados.c,98 :: 		dsp2 = 0x00;
	BCF        RD1_bit+0, BitPos(RD1_bit+0)
;Displays_Multiplexados.c,99 :: 		decodeDisplay ((num % 1000)/100);
	MOVLW      232
	MOVWF      R4+0
	MOVLW      3
	MOVWF      R4+1
	MOVF       FARG_DispMultiplex_num+0, 0
	MOVWF      R0+0
	MOVF       FARG_DispMultiplex_num+1, 0
	MOVWF      R0+1
	CALL       _Div_16x16_S+0
	MOVF       R8+0, 0
	MOVWF      R0+0
	MOVF       R8+1, 0
	MOVWF      R0+1
	MOVLW      100
	MOVWF      R4+0
	MOVLW      0
	MOVWF      R4+1
	CALL       _Div_16x16_S+0
	MOVF       R0+0, 0
	MOVWF      FARG_decodeDisplay_num+0
	MOVF       R0+1, 0
	MOVWF      FARG_decodeDisplay_num+1
	CALL       _decodeDisplay+0
;Displays_Multiplexados.c,100 :: 		}
	GOTO       L_DispMultiplex11
L_DispMultiplex10:
;Displays_Multiplexados.c,102 :: 		else if (display == 0x03 && dsp3)                                             // Multiplexa display 3
	MOVF       DispMultiplex_display_L0+0, 0
	XORLW      3
	BTFSS      STATUS+0, 2
	GOTO       L_DispMultiplex14
	BTFSS      RD2_bit+0, BitPos(RD2_bit+0)
	GOTO       L_DispMultiplex14
L__DispMultiplex39:
;Displays_Multiplexados.c,104 :: 		display =  0x04;
	MOVLW      4
	MOVWF      DispMultiplex_display_L0+0
;Displays_Multiplexados.c,105 :: 		dsp1 = 0x01;
	BSF        RD0_bit+0, BitPos(RD0_bit+0)
;Displays_Multiplexados.c,106 :: 		dsp2 = 0x01;
	BSF        RD1_bit+0, BitPos(RD1_bit+0)
;Displays_Multiplexados.c,107 :: 		dsp4 = 0x01;
	BSF        RD3_bit+0, BitPos(RD3_bit+0)
;Displays_Multiplexados.c,108 :: 		clearData();
	CALL       _clearData+0
;Displays_Multiplexados.c,109 :: 		dsp3 = 0x00;
	BCF        RD2_bit+0, BitPos(RD2_bit+0)
;Displays_Multiplexados.c,110 :: 		decodeDisplay (((num % 1000)%100)/10);
	MOVLW      232
	MOVWF      R4+0
	MOVLW      3
	MOVWF      R4+1
	MOVF       FARG_DispMultiplex_num+0, 0
	MOVWF      R0+0
	MOVF       FARG_DispMultiplex_num+1, 0
	MOVWF      R0+1
	CALL       _Div_16x16_S+0
	MOVF       R8+0, 0
	MOVWF      R0+0
	MOVF       R8+1, 0
	MOVWF      R0+1
	MOVLW      100
	MOVWF      R4+0
	MOVLW      0
	MOVWF      R4+1
	CALL       _Div_16x16_S+0
	MOVF       R8+0, 0
	MOVWF      R0+0
	MOVF       R8+1, 0
	MOVWF      R0+1
	MOVLW      10
	MOVWF      R4+0
	MOVLW      0
	MOVWF      R4+1
	CALL       _Div_16x16_S+0
	MOVF       R0+0, 0
	MOVWF      FARG_decodeDisplay_num+0
	MOVF       R0+1, 0
	MOVWF      FARG_decodeDisplay_num+1
	CALL       _decodeDisplay+0
;Displays_Multiplexados.c,111 :: 		}
	GOTO       L_DispMultiplex15
L_DispMultiplex14:
;Displays_Multiplexados.c,113 :: 		else if (display == 0x04 && dsp4)                                             // Multiplexa display 4
	MOVF       DispMultiplex_display_L0+0, 0
	XORLW      4
	BTFSS      STATUS+0, 2
	GOTO       L_DispMultiplex18
	BTFSS      RD3_bit+0, BitPos(RD3_bit+0)
	GOTO       L_DispMultiplex18
L__DispMultiplex38:
;Displays_Multiplexados.c,115 :: 		display =  0x01;
	MOVLW      1
	MOVWF      DispMultiplex_display_L0+0
;Displays_Multiplexados.c,116 :: 		dsp1 = 0x01;
	BSF        RD0_bit+0, BitPos(RD0_bit+0)
;Displays_Multiplexados.c,117 :: 		dsp2 = 0x01;
	BSF        RD1_bit+0, BitPos(RD1_bit+0)
;Displays_Multiplexados.c,118 :: 		dsp3 = 0x01;
	BSF        RD2_bit+0, BitPos(RD2_bit+0)
;Displays_Multiplexados.c,119 :: 		clearData();
	CALL       _clearData+0
;Displays_Multiplexados.c,120 :: 		dsp4 = 0x00;
	BCF        RD3_bit+0, BitPos(RD3_bit+0)
;Displays_Multiplexados.c,121 :: 		decodeDisplay (num % 10);
	MOVLW      10
	MOVWF      R4+0
	MOVLW      0
	MOVWF      R4+1
	MOVF       FARG_DispMultiplex_num+0, 0
	MOVWF      R0+0
	MOVF       FARG_DispMultiplex_num+1, 0
	MOVWF      R0+1
	CALL       _Div_16x16_S+0
	MOVF       R8+0, 0
	MOVWF      R0+0
	MOVF       R8+1, 0
	MOVWF      R0+1
	MOVF       R0+0, 0
	MOVWF      FARG_decodeDisplay_num+0
	MOVF       R0+1, 0
	MOVWF      FARG_decodeDisplay_num+1
	CALL       _decodeDisplay+0
;Displays_Multiplexados.c,122 :: 		}
L_DispMultiplex18:
L_DispMultiplex15:
L_DispMultiplex11:
L_DispMultiplex7:
;Displays_Multiplexados.c,123 :: 		}
L_end_DispMultiplex:
	RETURN
; end of _DispMultiplex

_clearData:

;Displays_Multiplexados.c,126 :: 		void clearData()                                                                // Função auxiliar que limpa o barramento de dados
;Displays_Multiplexados.c,128 :: 		A = 0x00;
	BCF        RB0_bit+0, BitPos(RB0_bit+0)
;Displays_Multiplexados.c,129 :: 		B = 0x00;
	BCF        RB1_bit+0, BitPos(RB1_bit+0)
;Displays_Multiplexados.c,130 :: 		C = 0x00;
	BCF        RB2_bit+0, BitPos(RB2_bit+0)
;Displays_Multiplexados.c,131 :: 		D = 0x00;
	BCF        RB3_bit+0, BitPos(RB3_bit+0)
;Displays_Multiplexados.c,132 :: 		E = 0x00;
	BCF        RB4_bit+0, BitPos(RB4_bit+0)
;Displays_Multiplexados.c,133 :: 		F = 0x00;
	BCF        RB5_bit+0, BitPos(RB5_bit+0)
;Displays_Multiplexados.c,134 :: 		G = 0x00;
	BCF        RB6_bit+0, BitPos(RB6_bit+0)
;Displays_Multiplexados.c,135 :: 		}
L_end_clearData:
	RETURN
; end of _clearData

_decodeDisplay:

;Displays_Multiplexados.c,138 :: 		void decodeDisplay(int num)                                                     // Função auxiliar que decodifica display
;Displays_Multiplexados.c,140 :: 		if (num == 0x00)
	MOVLW      0
	XORWF      FARG_decodeDisplay_num+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__decodeDisplay49
	MOVLW      0
	XORWF      FARG_decodeDisplay_num+0, 0
L__decodeDisplay49:
	BTFSS      STATUS+0, 2
	GOTO       L_decodeDisplay19
;Displays_Multiplexados.c,142 :: 		A = 0x01;
	BSF        RB0_bit+0, BitPos(RB0_bit+0)
;Displays_Multiplexados.c,143 :: 		B = 0x01;
	BSF        RB1_bit+0, BitPos(RB1_bit+0)
;Displays_Multiplexados.c,144 :: 		C = 0x01;
	BSF        RB2_bit+0, BitPos(RB2_bit+0)
;Displays_Multiplexados.c,145 :: 		D = 0x01;
	BSF        RB3_bit+0, BitPos(RB3_bit+0)
;Displays_Multiplexados.c,146 :: 		E = 0x01;
	BSF        RB4_bit+0, BitPos(RB4_bit+0)
;Displays_Multiplexados.c,147 :: 		F = 0x01;
	BSF        RB5_bit+0, BitPos(RB5_bit+0)
;Displays_Multiplexados.c,148 :: 		G = 0x00;
	BCF        RB6_bit+0, BitPos(RB6_bit+0)
;Displays_Multiplexados.c,149 :: 		}
	GOTO       L_decodeDisplay20
L_decodeDisplay19:
;Displays_Multiplexados.c,152 :: 		else if (num == 0x01)
	MOVLW      0
	XORWF      FARG_decodeDisplay_num+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__decodeDisplay50
	MOVLW      1
	XORWF      FARG_decodeDisplay_num+0, 0
L__decodeDisplay50:
	BTFSS      STATUS+0, 2
	GOTO       L_decodeDisplay21
;Displays_Multiplexados.c,154 :: 		A = 0x00;
	BCF        RB0_bit+0, BitPos(RB0_bit+0)
;Displays_Multiplexados.c,155 :: 		B = 0x01;
	BSF        RB1_bit+0, BitPos(RB1_bit+0)
;Displays_Multiplexados.c,156 :: 		C = 0x01;
	BSF        RB2_bit+0, BitPos(RB2_bit+0)
;Displays_Multiplexados.c,157 :: 		D = 0x00;
	BCF        RB3_bit+0, BitPos(RB3_bit+0)
;Displays_Multiplexados.c,158 :: 		E = 0x00;
	BCF        RB4_bit+0, BitPos(RB4_bit+0)
;Displays_Multiplexados.c,159 :: 		F = 0x00;
	BCF        RB5_bit+0, BitPos(RB5_bit+0)
;Displays_Multiplexados.c,160 :: 		G = 0x00;
	BCF        RB6_bit+0, BitPos(RB6_bit+0)
;Displays_Multiplexados.c,161 :: 		}
	GOTO       L_decodeDisplay22
L_decodeDisplay21:
;Displays_Multiplexados.c,164 :: 		else if (num == 0x02)
	MOVLW      0
	XORWF      FARG_decodeDisplay_num+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__decodeDisplay51
	MOVLW      2
	XORWF      FARG_decodeDisplay_num+0, 0
L__decodeDisplay51:
	BTFSS      STATUS+0, 2
	GOTO       L_decodeDisplay23
;Displays_Multiplexados.c,166 :: 		A = 0x01;
	BSF        RB0_bit+0, BitPos(RB0_bit+0)
;Displays_Multiplexados.c,167 :: 		B = 0x01;
	BSF        RB1_bit+0, BitPos(RB1_bit+0)
;Displays_Multiplexados.c,168 :: 		C = 0x00;
	BCF        RB2_bit+0, BitPos(RB2_bit+0)
;Displays_Multiplexados.c,169 :: 		D = 0x01;
	BSF        RB3_bit+0, BitPos(RB3_bit+0)
;Displays_Multiplexados.c,170 :: 		E = 0x01;
	BSF        RB4_bit+0, BitPos(RB4_bit+0)
;Displays_Multiplexados.c,171 :: 		F = 0x00;
	BCF        RB5_bit+0, BitPos(RB5_bit+0)
;Displays_Multiplexados.c,172 :: 		G = 0x01;
	BSF        RB6_bit+0, BitPos(RB6_bit+0)
;Displays_Multiplexados.c,173 :: 		}
	GOTO       L_decodeDisplay24
L_decodeDisplay23:
;Displays_Multiplexados.c,176 :: 		else if (num == 0x03)
	MOVLW      0
	XORWF      FARG_decodeDisplay_num+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__decodeDisplay52
	MOVLW      3
	XORWF      FARG_decodeDisplay_num+0, 0
L__decodeDisplay52:
	BTFSS      STATUS+0, 2
	GOTO       L_decodeDisplay25
;Displays_Multiplexados.c,178 :: 		A = 0x01;
	BSF        RB0_bit+0, BitPos(RB0_bit+0)
;Displays_Multiplexados.c,179 :: 		B = 0x01;
	BSF        RB1_bit+0, BitPos(RB1_bit+0)
;Displays_Multiplexados.c,180 :: 		C = 0x01;
	BSF        RB2_bit+0, BitPos(RB2_bit+0)
;Displays_Multiplexados.c,181 :: 		D = 0x01;
	BSF        RB3_bit+0, BitPos(RB3_bit+0)
;Displays_Multiplexados.c,182 :: 		E = 0x00;
	BCF        RB4_bit+0, BitPos(RB4_bit+0)
;Displays_Multiplexados.c,183 :: 		F = 0x00;
	BCF        RB5_bit+0, BitPos(RB5_bit+0)
;Displays_Multiplexados.c,184 :: 		G = 0x01;
	BSF        RB6_bit+0, BitPos(RB6_bit+0)
;Displays_Multiplexados.c,185 :: 		}
	GOTO       L_decodeDisplay26
L_decodeDisplay25:
;Displays_Multiplexados.c,188 :: 		else if (num == 0x04)
	MOVLW      0
	XORWF      FARG_decodeDisplay_num+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__decodeDisplay53
	MOVLW      4
	XORWF      FARG_decodeDisplay_num+0, 0
L__decodeDisplay53:
	BTFSS      STATUS+0, 2
	GOTO       L_decodeDisplay27
;Displays_Multiplexados.c,190 :: 		A = 0x00;
	BCF        RB0_bit+0, BitPos(RB0_bit+0)
;Displays_Multiplexados.c,191 :: 		B = 0x01;
	BSF        RB1_bit+0, BitPos(RB1_bit+0)
;Displays_Multiplexados.c,192 :: 		C = 0x01;
	BSF        RB2_bit+0, BitPos(RB2_bit+0)
;Displays_Multiplexados.c,193 :: 		D = 0x00;
	BCF        RB3_bit+0, BitPos(RB3_bit+0)
;Displays_Multiplexados.c,194 :: 		E = 0x00;
	BCF        RB4_bit+0, BitPos(RB4_bit+0)
;Displays_Multiplexados.c,195 :: 		F = 0x01;
	BSF        RB5_bit+0, BitPos(RB5_bit+0)
;Displays_Multiplexados.c,196 :: 		G = 0x01;
	BSF        RB6_bit+0, BitPos(RB6_bit+0)
;Displays_Multiplexados.c,197 :: 		}
	GOTO       L_decodeDisplay28
L_decodeDisplay27:
;Displays_Multiplexados.c,200 :: 		else if (num == 0x05)
	MOVLW      0
	XORWF      FARG_decodeDisplay_num+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__decodeDisplay54
	MOVLW      5
	XORWF      FARG_decodeDisplay_num+0, 0
L__decodeDisplay54:
	BTFSS      STATUS+0, 2
	GOTO       L_decodeDisplay29
;Displays_Multiplexados.c,202 :: 		A = 0x01;
	BSF        RB0_bit+0, BitPos(RB0_bit+0)
;Displays_Multiplexados.c,203 :: 		B = 0x00;
	BCF        RB1_bit+0, BitPos(RB1_bit+0)
;Displays_Multiplexados.c,204 :: 		C = 0x01;
	BSF        RB2_bit+0, BitPos(RB2_bit+0)
;Displays_Multiplexados.c,205 :: 		D = 0x01;
	BSF        RB3_bit+0, BitPos(RB3_bit+0)
;Displays_Multiplexados.c,206 :: 		E = 0x00;
	BCF        RB4_bit+0, BitPos(RB4_bit+0)
;Displays_Multiplexados.c,207 :: 		F = 0x01;
	BSF        RB5_bit+0, BitPos(RB5_bit+0)
;Displays_Multiplexados.c,208 :: 		G = 0x01;
	BSF        RB6_bit+0, BitPos(RB6_bit+0)
;Displays_Multiplexados.c,209 :: 		}
	GOTO       L_decodeDisplay30
L_decodeDisplay29:
;Displays_Multiplexados.c,212 :: 		else if (num == 0x06)
	MOVLW      0
	XORWF      FARG_decodeDisplay_num+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__decodeDisplay55
	MOVLW      6
	XORWF      FARG_decodeDisplay_num+0, 0
L__decodeDisplay55:
	BTFSS      STATUS+0, 2
	GOTO       L_decodeDisplay31
;Displays_Multiplexados.c,214 :: 		A = 0x01;
	BSF        RB0_bit+0, BitPos(RB0_bit+0)
;Displays_Multiplexados.c,215 :: 		B = 0x00;
	BCF        RB1_bit+0, BitPos(RB1_bit+0)
;Displays_Multiplexados.c,216 :: 		C = 0x01;
	BSF        RB2_bit+0, BitPos(RB2_bit+0)
;Displays_Multiplexados.c,217 :: 		D = 0x01;
	BSF        RB3_bit+0, BitPos(RB3_bit+0)
;Displays_Multiplexados.c,218 :: 		E = 0x01;
	BSF        RB4_bit+0, BitPos(RB4_bit+0)
;Displays_Multiplexados.c,219 :: 		F = 0x01;
	BSF        RB5_bit+0, BitPos(RB5_bit+0)
;Displays_Multiplexados.c,220 :: 		G = 0x01;
	BSF        RB6_bit+0, BitPos(RB6_bit+0)
;Displays_Multiplexados.c,221 :: 		}
	GOTO       L_decodeDisplay32
L_decodeDisplay31:
;Displays_Multiplexados.c,223 :: 		else if (num == 0x07)
	MOVLW      0
	XORWF      FARG_decodeDisplay_num+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__decodeDisplay56
	MOVLW      7
	XORWF      FARG_decodeDisplay_num+0, 0
L__decodeDisplay56:
	BTFSS      STATUS+0, 2
	GOTO       L_decodeDisplay33
;Displays_Multiplexados.c,225 :: 		A = 0x01;
	BSF        RB0_bit+0, BitPos(RB0_bit+0)
;Displays_Multiplexados.c,226 :: 		B = 0x01;
	BSF        RB1_bit+0, BitPos(RB1_bit+0)
;Displays_Multiplexados.c,227 :: 		C = 0x01;
	BSF        RB2_bit+0, BitPos(RB2_bit+0)
;Displays_Multiplexados.c,228 :: 		D = 0x00;
	BCF        RB3_bit+0, BitPos(RB3_bit+0)
;Displays_Multiplexados.c,229 :: 		E = 0x00;
	BCF        RB4_bit+0, BitPos(RB4_bit+0)
;Displays_Multiplexados.c,230 :: 		F = 0x00;
	BCF        RB5_bit+0, BitPos(RB5_bit+0)
;Displays_Multiplexados.c,231 :: 		G = 0x00;
	BCF        RB6_bit+0, BitPos(RB6_bit+0)
;Displays_Multiplexados.c,232 :: 		}
	GOTO       L_decodeDisplay34
L_decodeDisplay33:
;Displays_Multiplexados.c,234 :: 		else if (num == 0x08)
	MOVLW      0
	XORWF      FARG_decodeDisplay_num+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__decodeDisplay57
	MOVLW      8
	XORWF      FARG_decodeDisplay_num+0, 0
L__decodeDisplay57:
	BTFSS      STATUS+0, 2
	GOTO       L_decodeDisplay35
;Displays_Multiplexados.c,236 :: 		A = 0x01;
	BSF        RB0_bit+0, BitPos(RB0_bit+0)
;Displays_Multiplexados.c,237 :: 		B = 0x01;
	BSF        RB1_bit+0, BitPos(RB1_bit+0)
;Displays_Multiplexados.c,238 :: 		C = 0x01;
	BSF        RB2_bit+0, BitPos(RB2_bit+0)
;Displays_Multiplexados.c,239 :: 		D = 0x01;
	BSF        RB3_bit+0, BitPos(RB3_bit+0)
;Displays_Multiplexados.c,240 :: 		E = 0x01;
	BSF        RB4_bit+0, BitPos(RB4_bit+0)
;Displays_Multiplexados.c,241 :: 		F = 0x01;
	BSF        RB5_bit+0, BitPos(RB5_bit+0)
;Displays_Multiplexados.c,242 :: 		G = 0x01;
	BSF        RB6_bit+0, BitPos(RB6_bit+0)
;Displays_Multiplexados.c,243 :: 		}
	GOTO       L_decodeDisplay36
L_decodeDisplay35:
;Displays_Multiplexados.c,246 :: 		else if (num == 0x09)
	MOVLW      0
	XORWF      FARG_decodeDisplay_num+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__decodeDisplay58
	MOVLW      9
	XORWF      FARG_decodeDisplay_num+0, 0
L__decodeDisplay58:
	BTFSS      STATUS+0, 2
	GOTO       L_decodeDisplay37
;Displays_Multiplexados.c,248 :: 		A = 0x01;
	BSF        RB0_bit+0, BitPos(RB0_bit+0)
;Displays_Multiplexados.c,249 :: 		B = 0x01;
	BSF        RB1_bit+0, BitPos(RB1_bit+0)
;Displays_Multiplexados.c,250 :: 		C = 0x01;
	BSF        RB2_bit+0, BitPos(RB2_bit+0)
;Displays_Multiplexados.c,251 :: 		D = 0x01;
	BSF        RB3_bit+0, BitPos(RB3_bit+0)
;Displays_Multiplexados.c,252 :: 		E = 0x00;
	BCF        RB4_bit+0, BitPos(RB4_bit+0)
;Displays_Multiplexados.c,253 :: 		F = 0x01;
	BSF        RB5_bit+0, BitPos(RB5_bit+0)
;Displays_Multiplexados.c,254 :: 		G = 0x01;
	BSF        RB6_bit+0, BitPos(RB6_bit+0)
;Displays_Multiplexados.c,255 :: 		}
L_decodeDisplay37:
L_decodeDisplay36:
L_decodeDisplay34:
L_decodeDisplay32:
L_decodeDisplay30:
L_decodeDisplay28:
L_decodeDisplay26:
L_decodeDisplay24:
L_decodeDisplay22:
L_decodeDisplay20:
;Displays_Multiplexados.c,256 :: 		}
L_end_decodeDisplay:
	RETURN
; end of _decodeDisplay
