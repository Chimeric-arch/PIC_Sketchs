
_interrupt:
	MOVWF      R15+0
	SWAPF      STATUS+0, 0
	CLRF       STATUS+0
	MOVWF      ___saveSTATUS+0
	MOVF       PCLATH+0, 0
	MOVWF      ___savePCLATH+0
	CLRF       PCLATH+0

;SoftwareProtocol.c,28 :: 		void interrupt()
;SoftwareProtocol.c,30 :: 		if (INTCON.TMR0IF)
	BTFSS      INTCON+0, 2
	GOTO       L_interrupt0
;SoftwareProtocol.c,32 :: 		INTCON.TMR0IF = 0x00;
	BCF        INTCON+0, 2
;SoftwareProtocol.c,33 :: 		TMR0 = 208;
	MOVLW      208
	MOVWF      TMR0+0
;SoftwareProtocol.c,34 :: 		clk = ~clk;
	MOVLW      1
	XORWF      PORTB+0, 1
;SoftwareProtocol.c,35 :: 		}
L_interrupt0:
;SoftwareProtocol.c,36 :: 		}
L_end_interrupt:
L__interrupt10:
	MOVF       ___savePCLATH+0, 0
	MOVWF      PCLATH+0
	SWAPF      ___saveSTATUS+0, 0
	MOVWF      STATUS+0
	SWAPF      R15+0, 1
	SWAPF      R15+0, 0
	RETFIE
; end of _interrupt

_main:

;SoftwareProtocol.c,38 :: 		void main()
;SoftwareProtocol.c,40 :: 		reg_config();
	CALL       _reg_config+0
;SoftwareProtocol.c,41 :: 		while(1)
L_main1:
;SoftwareProtocol.c,52 :: 		}
	GOTO       L_main1
;SoftwareProtocol.c,53 :: 		}
L_end_main:
	GOTO       $+0
; end of _main

_reg_config:

;SoftwareProtocol.c,56 :: 		void reg_config()
;SoftwareProtocol.c,59 :: 		OPTION_REG.T0CS = 0x00;                                                       // Usar TMR0 com clock interno
	BCF        OPTION_REG+0, 5
;SoftwareProtocol.c,60 :: 		OPTION_REG.PSA  = 0x01;                                                       // Prescaler direcionado para TMR0
	BSF        OPTION_REG+0, 3
;SoftwareProtocol.c,61 :: 		OPTION_REG.PS2  = 0x00;                                                       // Prescaler 1:2
	BCF        OPTION_REG+0, 2
;SoftwareProtocol.c,62 :: 		OPTION_REG.PS1  = 0x00;
	BCF        OPTION_REG+0, 1
;SoftwareProtocol.c,63 :: 		OPTION_REG.PS0  = 0x00;
	BCF        OPTION_REG+0, 0
;SoftwareProtocol.c,67 :: 		INTCON.GIE    = 0x01;
	BSF        INTCON+0, 7
;SoftwareProtocol.c,68 :: 		INTCON.PEIE   = 0x01;
	BSF        INTCON+0, 6
;SoftwareProtocol.c,69 :: 		INTCON.TMR0IE = 0x01;
	BSF        INTCON+0, 5
;SoftwareProtocol.c,73 :: 		TMR0 = 208;
	MOVLW      208
	MOVWF      TMR0+0
;SoftwareProtocol.c,77 :: 		TRISB = 0x00;
	CLRF       TRISB+0
;SoftwareProtocol.c,78 :: 		PORTB = 0x00;
	CLRF       PORTB+0
;SoftwareProtocol.c,80 :: 		TRISD = 0x00;
	CLRF       TRISD+0
;SoftwareProtocol.c,81 :: 		PORTD = 0x00;
	CLRF       PORTD+0
;SoftwareProtocol.c,83 :: 		}
L_end_reg_config:
	RETURN
; end of _reg_config

_sendData:

;SoftwareProtocol.c,85 :: 		void sendData(char dat_)
;SoftwareProtocol.c,87 :: 		register int i = 0x00;
	CLRF       sendData_i_L0+0
	CLRF       sendData_i_L0+1
;SoftwareProtocol.c,88 :: 		for (i < nProto; i++;)
L_sendData3:
	MOVF       sendData_i_L0+0, 0
	MOVWF      R0+0
	MOVF       sendData_i_L0+1, 0
	MOVWF      R0+1
	INCF       sendData_i_L0+0, 1
	BTFSC      STATUS+0, 2
	INCF       sendData_i_L0+1, 1
	MOVF       R0+0, 0
	IORWF      R0+1, 0
	BTFSC      STATUS+0, 2
	GOTO       L_sendData4
;SoftwareProtocol.c,90 :: 		dat = (testBit(dat_, i)) ? (dat = 0x01) : (dat = 0x00);
	MOVF       sendData_i_L0+0, 0
	MOVWF      R2+0
	MOVLW      1
	MOVWF      R0+0
	MOVLW      0
	MOVWF      R0+1
	MOVF       R2+0, 0
L__sendData14:
	BTFSC      STATUS+0, 2
	GOTO       L__sendData15
	RLF        R0+0, 1
	RLF        R0+1, 1
	BCF        R0+0, 0
	ADDLW      255
	GOTO       L__sendData14
L__sendData15:
	MOVF       FARG_sendData_dat_+0, 0
	ANDWF      R0+0, 1
	MOVLW      0
	ANDWF      R0+1, 1
	MOVF       R0+0, 0
	IORWF      R0+1, 0
	BTFSC      STATUS+0, 2
	GOTO       L_sendData6
	BSF        PORTB+0, 1
	BTFSC      PORTB+0, 1
	GOTO       L__sendData16
	BCF        ?FLOC___sendDataT32+0, BitPos(?FLOC___sendDataT32+0)
	GOTO       L__sendData17
L__sendData16:
	BSF        ?FLOC___sendDataT32+0, BitPos(?FLOC___sendDataT32+0)
L__sendData17:
	GOTO       L_sendData7
L_sendData6:
	BCF        PORTB+0, 1
	BTFSC      PORTB+0, 1
	GOTO       L__sendData18
	BCF        ?FLOC___sendDataT32+0, BitPos(?FLOC___sendDataT32+0)
	GOTO       L__sendData19
L__sendData18:
	BSF        ?FLOC___sendDataT32+0, BitPos(?FLOC___sendDataT32+0)
L__sendData19:
L_sendData7:
	BTFSC      ?FLOC___sendDataT32+0, BitPos(?FLOC___sendDataT32+0)
	GOTO       L__sendData20
	BCF        PORTB+0, 1
	GOTO       L__sendData21
L__sendData20:
	BSF        PORTB+0, 1
L__sendData21:
;SoftwareProtocol.c,91 :: 		delay_us(104);
	MOVLW      69
	MOVWF      R13+0
L_sendData8:
	DECFSZ     R13+0, 1
	GOTO       L_sendData8
;SoftwareProtocol.c,92 :: 		}
	GOTO       L_sendData3
L_sendData4:
;SoftwareProtocol.c,93 :: 		}
L_end_sendData:
	RETURN
; end of _sendData

_frequency_timerZero:

;SoftwareProtocol.c,96 :: 		unsigned char frequency_timerZero(int frequency){return 2E6/-(frequency)*-1;}
	MOVF       FARG_frequency_timerZero_frequency+0, 0
	SUBLW      0
	MOVWF      R0+0
	MOVF       FARG_frequency_timerZero_frequency+1, 0
	BTFSS      STATUS+0, 0
	ADDLW      1
	CLRF       R0+1
	SUBWF      R0+1, 1
	CALL       _int2double+0
	MOVF       R0+0, 0
	MOVWF      R4+0
	MOVF       R0+1, 0
	MOVWF      R4+1
	MOVF       R0+2, 0
	MOVWF      R4+2
	MOVF       R0+3, 0
	MOVWF      R4+3
	MOVLW      0
	MOVWF      R0+0
	MOVLW      36
	MOVWF      R0+1
	MOVLW      116
	MOVWF      R0+2
	MOVLW      147
	MOVWF      R0+3
	CALL       _Div_32x32_FP+0
	MOVLW      0
	MOVWF      R4+0
	MOVLW      0
	MOVWF      R4+1
	MOVLW      128
	MOVWF      R4+2
	MOVLW      127
	MOVWF      R4+3
	CALL       _Mul_32x32_FP+0
	CALL       _double2byte+0
L_end_frequency_timerZero:
	RETURN
; end of _frequency_timerZero
