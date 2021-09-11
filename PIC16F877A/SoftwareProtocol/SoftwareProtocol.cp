#line 1 "D:/danie/Documentos/Proteus     Arduino/MikroC PRO for PIC/Sketchs PICs/PIC16F877A/SoftwareProtocol/SoftwareProtocol.c"
#line 24 "D:/danie/Documentos/Proteus     Arduino/MikroC PRO for PIC/Sketchs PICs/PIC16F877A/SoftwareProtocol/SoftwareProtocol.c"
void reg_config();
void sendData(char dat_);
unsigned char frequency_timerZero(int frequency);

register int i = 0x00;

void interrupt()
{
 if (INTCON.TMR0IF)
 {
 INTCON.TMR0IF = 0x00;
 TMR0 = 208;
  PORTB.RB0  = ~ PORTB.RB0 ;

 if ( PORTB.RB0 )
 {

 }
 }
}

void main()
{
 reg_config();
 while(1)
 {
#line 59 "D:/danie/Documentos/Proteus     Arduino/MikroC PRO for PIC/Sketchs PICs/PIC16F877A/SoftwareProtocol/SoftwareProtocol.c"
 }
}


void reg_config()
{

 OPTION_REG.T0CS = 0x00;
 OPTION_REG.PSA = 0x01;
 OPTION_REG.PS2 = 0x00;
 OPTION_REG.PS1 = 0x00;
 OPTION_REG.PS0 = 0x00;



 INTCON.GIE = 0x01;
 INTCON.PEIE = 0x01;
 INTCON.TMR0IE = 0x01;



 TMR0 = 208;



 TRISB = 0x00;
 PORTB = 0x00;

 TRISD = 0x00;
 PORTD = 0x00;

}
#line 105 "D:/danie/Documentos/Proteus     Arduino/MikroC PRO for PIC/Sketchs PICs/PIC16F877A/SoftwareProtocol/SoftwareProtocol.c"
char readData()
{
 char rxBuff;
 if ( PORTB.RB1 )  (byte, bit) ((byte) |= (1<<(bit))) (rxBuff, i);
 else if (! PORTB.RB1 )  ((rxBuff) &= ~(1<<(i))) ;
}


unsigned char frequency_timerZero(int frequency){return 2E6/-(frequency)*-1;}
