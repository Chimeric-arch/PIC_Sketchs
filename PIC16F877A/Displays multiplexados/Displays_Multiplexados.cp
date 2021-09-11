#line 1 "D:/danie/Documentos/Proteus     Arduino/MikroC PRO for PIC/Sketchs PICs/Displays multiplexados/Displays_Multiplexados.c"
#line 28 "D:/danie/Documentos/Proteus     Arduino/MikroC PRO for PIC/Sketchs PICs/Displays multiplexados/Displays_Multiplexados.c"
void displayInit();
void DispMultiplex(int num);
void clearData();
void decodeDisplay(int num);


int valor;



void interrupt()
{
 if (TMR0IF_bit)
 {
 TMR0 = 0x06;
 TMR0IF_bit = 0x00;
 DispMultiplex(valor);
 }
}


void main()
{
 displayInit();
 while(1)
 {
 valor++;
 delay_ms(100);
 }
}


void displayInit()
{
 TRISB = 0x00;
 PORTB = 0x00;

 TRISD = 0x00;
 PORTD = 0x0F;

 GIE_bit = 0x01;
 PEIE_bit = 0x01;
 TMR0IE_bit = 0x01;
 TMR0 = 0x06;
 OPTION_REG = 0x02;
}


void DispMultiplex(int num)
{
 static char display = 0x01;

 if (display == 0x01 &&  RD0_bit )
 {
 display = 0x02;
  RD1_bit  = 0x01;
  RD2_bit  = 0x01;
  RD3_bit  = 0x01;
 clearData();
  RD0_bit  = 0x00;
 decodeDisplay (num/1000);
 }

 else if (display == 0x02 &&  RD1_bit )
 {
 display = 0x03;
  RD0_bit  = 0x01;
  RD2_bit  = 0x01;
  RD3_bit  = 0x01;
 clearData();
  RD1_bit  = 0x00;
 decodeDisplay ((num % 1000)/100);
 }

 else if (display == 0x03 &&  RD2_bit )
 {
 display = 0x04;
  RD0_bit  = 0x01;
  RD1_bit  = 0x01;
  RD3_bit  = 0x01;
 clearData();
  RD2_bit  = 0x00;
 decodeDisplay (((num % 1000)%100)/10);
 }

 else if (display == 0x04 &&  RD3_bit )
 {
 display = 0x01;
  RD0_bit  = 0x01;
  RD1_bit  = 0x01;
  RD2_bit  = 0x01;
 clearData();
  RD3_bit  = 0x00;
 decodeDisplay (num % 10);
 }
}


void clearData()
{
  RB0_bit  = 0x00;
  RB1_bit  = 0x00;
  RB2_bit  = 0x00;
  RB3_bit  = 0x00;
  RB4_bit  = 0x00;
  RB5_bit  = 0x00;
  RB6_bit  = 0x00;
}


void decodeDisplay(int num)
{
 if (num == 0x00)
 {
  RB0_bit  = 0x01;
  RB1_bit  = 0x01;
  RB2_bit  = 0x01;
  RB3_bit  = 0x01;
  RB4_bit  = 0x01;
  RB5_bit  = 0x01;
  RB6_bit  = 0x00;
 }


 else if (num == 0x01)
 {
  RB0_bit  = 0x00;
  RB1_bit  = 0x01;
  RB2_bit  = 0x01;
  RB3_bit  = 0x00;
  RB4_bit  = 0x00;
  RB5_bit  = 0x00;
  RB6_bit  = 0x00;
 }


 else if (num == 0x02)
 {
  RB0_bit  = 0x01;
  RB1_bit  = 0x01;
  RB2_bit  = 0x00;
  RB3_bit  = 0x01;
  RB4_bit  = 0x01;
  RB5_bit  = 0x00;
  RB6_bit  = 0x01;
 }


 else if (num == 0x03)
 {
  RB0_bit  = 0x01;
  RB1_bit  = 0x01;
  RB2_bit  = 0x01;
  RB3_bit  = 0x01;
  RB4_bit  = 0x00;
  RB5_bit  = 0x00;
  RB6_bit  = 0x01;
 }


 else if (num == 0x04)
 {
  RB0_bit  = 0x00;
  RB1_bit  = 0x01;
  RB2_bit  = 0x01;
  RB3_bit  = 0x00;
  RB4_bit  = 0x00;
  RB5_bit  = 0x01;
  RB6_bit  = 0x01;
 }


 else if (num == 0x05)
 {
  RB0_bit  = 0x01;
  RB1_bit  = 0x00;
  RB2_bit  = 0x01;
  RB3_bit  = 0x01;
  RB4_bit  = 0x00;
  RB5_bit  = 0x01;
  RB6_bit  = 0x01;
 }


 else if (num == 0x06)
 {
  RB0_bit  = 0x01;
  RB1_bit  = 0x00;
  RB2_bit  = 0x01;
  RB3_bit  = 0x01;
  RB4_bit  = 0x01;
  RB5_bit  = 0x01;
  RB6_bit  = 0x01;
 }

 else if (num == 0x07)
 {
  RB0_bit  = 0x01;
  RB1_bit  = 0x01;
  RB2_bit  = 0x01;
  RB3_bit  = 0x00;
  RB4_bit  = 0x00;
  RB5_bit  = 0x00;
  RB6_bit  = 0x00;
 }

 else if (num == 0x08)
 {
  RB0_bit  = 0x01;
  RB1_bit  = 0x01;
  RB2_bit  = 0x01;
  RB3_bit  = 0x01;
  RB4_bit  = 0x01;
  RB5_bit  = 0x01;
  RB6_bit  = 0x01;
 }


 else if (num == 0x09)
 {
  RB0_bit  = 0x01;
  RB1_bit  = 0x01;
  RB2_bit  = 0x01;
  RB3_bit  = 0x01;
  RB4_bit  = 0x00;
  RB5_bit  = 0x01;
  RB6_bit  = 0x01;
 }
}
