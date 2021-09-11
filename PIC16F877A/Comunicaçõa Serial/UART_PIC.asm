
_SerialBegin:

;uart.h,13 :: 		void SerialBegin(const long int baudRate)
;uart.h,15 :: 		SPBRG = (Clock_MHz() * 1E6)/(16 * baudRate)- 1;
	MOVLW      4
	MOVWF      R4+0
	MOVF       FARG_SerialBegin_baudRate+0, 0
	MOVWF      R0+0
	MOVF       FARG_SerialBegin_baudRate+1, 0
	MOVWF      R0+1
	MOVF       FARG_SerialBegin_baudRate+2, 0
	MOVWF      R0+2
	MOVF       FARG_SerialBegin_baudRate+3, 0
	MOVWF      R0+3
	MOVF       R4+0, 0
L__SerialBegin14:
	BTFSC      STATUS+0, 2
	GOTO       L__SerialBegin15
	RLF        R0+0, 1
	RLF        R0+1, 1
	RLF        R0+2, 1
	RLF        R0+3, 1
	BCF        R0+0, 0
	ADDLW      255
	GOTO       L__SerialBegin14
L__SerialBegin15:
	CALL       _longint2double+0
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
	MOVLW      149
	MOVWF      R0+3
	CALL       _Div_32x32_FP+0
	MOVLW      0
	MOVWF      R4+0
	MOVLW      0
	MOVWF      R4+1
	MOVLW      0
	MOVWF      R4+2
	MOVLW      127
	MOVWF      R4+3
	CALL       _Sub_32x32_FP+0
	CALL       _double2byte+0
	MOVF       R0+0, 0
	MOVWF      SPBRG+0
;uart.h,16 :: 		TXSTA = 0x24;
	MOVLW      36
	MOVWF      TXSTA+0
;uart.h,17 :: 		RCSTA = 0x90;
	MOVLW      144
	MOVWF      RCSTA+0
;uart.h,18 :: 		TRISC.TRISC6 = 0x00;
	BCF        TRISC+0, 6
;uart.h,19 :: 		TRISC.TRISC7 = 0x01;
	BSF        TRISC+0, 7
;uart.h,20 :: 		}
L_end_SerialBegin:
	RETURN
; end of _SerialBegin

_SerialWrite:

;uart.h,23 :: 		void SerialWrite(char byte)
;uart.h,25 :: 		TXREG = byte;
	MOVF       FARG_SerialWrite_byte+0, 0
	MOVWF      TXREG+0
;uart.h,26 :: 		while (!PIR1.TXIF);
L_SerialWrite0:
	BTFSC      PIR1+0, 4
	GOTO       L_SerialWrite1
	GOTO       L_SerialWrite0
L_SerialWrite1:
;uart.h,27 :: 		}
L_end_SerialWrite:
	RETURN
; end of _SerialWrite

_SerialWrite_String:

;uart.h,30 :: 		void SerialWrite_String(const char* string)
;uart.h,32 :: 		int i = 0x00;
	CLRF       SerialWrite_String_i_L0+0
	CLRF       SerialWrite_String_i_L0+1
;uart.h,33 :: 		while(string[i] != '\0')
L_SerialWrite_String2:
	MOVF       SerialWrite_String_i_L0+0, 0
	ADDWF      FARG_SerialWrite_String_string+0, 0
	MOVWF      R0+0
	MOVF       FARG_SerialWrite_String_string+1, 0
	BTFSC      STATUS+0, 0
	ADDLW      1
	ADDWF      SerialWrite_String_i_L0+1, 0
	MOVWF      R0+1
	MOVF       R0+0, 0
	MOVWF      ___DoICPAddr+0
	MOVF       R0+1, 0
	MOVWF      ___DoICPAddr+1
	CALL       _____DoICP+0
	MOVWF      R1+0
	MOVF       R1+0, 0
	XORLW      0
	BTFSC      STATUS+0, 2
	GOTO       L_SerialWrite_String3
;uart.h,35 :: 		SerialWrite(string[i]);
	MOVF       SerialWrite_String_i_L0+0, 0
	ADDWF      FARG_SerialWrite_String_string+0, 0
	MOVWF      R0+0
	MOVF       FARG_SerialWrite_String_string+1, 0
	BTFSC      STATUS+0, 0
	ADDLW      1
	ADDWF      SerialWrite_String_i_L0+1, 0
	MOVWF      R0+1
	MOVF       R0+0, 0
	MOVWF      ___DoICPAddr+0
	MOVF       R0+1, 0
	MOVWF      ___DoICPAddr+1
	CALL       _____DoICP+0
	MOVWF      FARG_SerialWrite_byte+0
	CALL       _SerialWrite+0
;uart.h,36 :: 		i++;
	INCF       SerialWrite_String_i_L0+0, 1
	BTFSC      STATUS+0, 2
	INCF       SerialWrite_String_i_L0+1, 1
;uart.h,37 :: 		}
	GOTO       L_SerialWrite_String2
L_SerialWrite_String3:
;uart.h,38 :: 		}
L_end_SerialWrite_String:
	RETURN
; end of _SerialWrite_String

_SerialRead:

;uart.h,41 :: 		char SerialRead()
;uart.h,43 :: 		if (PIR1.RCIF)
	BTFSS      PIR1+0, 5
	GOTO       L_SerialRead4
;uart.h,45 :: 		PIR1.RCIF = 0x00;
	BCF        PIR1+0, 5
;uart.h,46 :: 		if (RCSTA.FERR || RCSTA.OERR)
	BTFSC      RCSTA+0, 2
	GOTO       L__SerialRead12
	BTFSC      RCSTA+0, 1
	GOTO       L__SerialRead12
	GOTO       L_SerialRead7
L__SerialRead12:
;uart.h,49 :: 		CREN_bit = 0x00;
	BCF        CREN_bit+0, BitPos(CREN_bit+0)
;uart.h,50 :: 		CREN_bit = 0x01;
	BSF        CREN_bit+0, BitPos(CREN_bit+0)
;uart.h,51 :: 		return 0x00;
	CLRF       R0+0
	GOTO       L_end_SerialRead
;uart.h,52 :: 		}
L_SerialRead7:
;uart.h,53 :: 		return RCREG;
	MOVF       RCREG+0, 0
	MOVWF      R0+0
	GOTO       L_end_SerialRead
;uart.h,54 :: 		}
L_SerialRead4:
;uart.h,55 :: 		else return 0x00;
	CLRF       R0+0
;uart.h,56 :: 		}
L_end_SerialRead:
	RETURN
; end of _SerialRead

_main:

;UART_PIC.c,4 :: 		void main()
;UART_PIC.c,6 :: 		TRISB = 0x00;
	CLRF       TRISB+0
;UART_PIC.c,7 :: 		PORTB = 0x00;
	CLRF       PORTB+0
;UART_PIC.c,8 :: 		SerialBegin(9600);
	MOVLW      128
	MOVWF      FARG_SerialBegin_baudRate+0
	MOVLW      37
	MOVWF      FARG_SerialBegin_baudRate+1
	CLRF       FARG_SerialBegin_baudRate+2
	CLRF       FARG_SerialBegin_baudRate+3
	CALL       _SerialBegin+0
;UART_PIC.c,9 :: 		while (1)
L_main9:
;UART_PIC.c,11 :: 		PORTB = SerialRead();
	CALL       _SerialRead+0
	MOVF       R0+0, 0
	MOVWF      PORTB+0
;UART_PIC.c,12 :: 		delay_ms(100);
	MOVLW      2
	MOVWF      R11+0
	MOVLW      4
	MOVWF      R12+0
	MOVLW      186
	MOVWF      R13+0
L_main11:
	DECFSZ     R13+0, 1
	GOTO       L_main11
	DECFSZ     R12+0, 1
	GOTO       L_main11
	DECFSZ     R11+0, 1
	GOTO       L_main11
	NOP
;UART_PIC.c,13 :: 		}
	GOTO       L_main9
;UART_PIC.c,14 :: 		}
L_end_main:
	GOTO       $+0
; end of _main
