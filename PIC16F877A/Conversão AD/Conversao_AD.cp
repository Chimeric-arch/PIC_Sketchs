#line 1 "D:/danie/Documentos/Proteus     Arduino/MikroC PRO for PIC/Sketchs PICs/Conversão AD/Conversao_AD.c"
#line 11 "D:/danie/Documentos/Proteus     Arduino/MikroC PRO for PIC/Sketchs PICs/Conversão AD/Conversao_AD.c"
void AD_init();
int analogRead(unsigned char pinAD);






void main()
{


 while(1)
 {
#line 35 "D:/danie/Documentos/Proteus     Arduino/MikroC PRO for PIC/Sketchs PICs/Conversão AD/Conversao_AD.c"
 }
}



void AD_init()
{
 unsigned short clk = Clock_MHz();
 if (clk < 0x01)
 {
 ADCON0.ADCS0 = 0x00;
 ADCON0.ADCS1 = 0x00;
 ADCON1.ADCS2 = 0x00;
 }
 else if (clk > 0x01 && clk <= 0x02)
 {
 ADCON0.ADCS0 = 0x00;
 ADCON0.ADCS1 = 0x00;
 ADCON1.ADCS2 = 0x01;
 }
 else if (clk > 0x02 && clk <= 0x05)
 {
 ADCON0.ADCS0 = 0x01;
 ADCON0.ADCS1 = 0x00;
 ADCON1.ADCS2 = 0x00;
 }
 else if (clk > 0x05 && clk <= 0x0A)
 {
 ADCON0.ADCS0 = 0x01;
 ADCON0.ADCS1 = 0x00;
 ADCON1.ADCS2 = 0x01;
 }
 else if (clk > 0x0A && clk < 0x14)
 {
 ADCON0.ADCS0 = 0x00;
 ADCON0.ADCS1 = 0x01;
 ADCON1.ADCS2 = 0x01;
 }
 ADCON1.ADFM = 0x01;
 ADCON1.PCFG0= 0x00;
 ADCON1.PCFG1= 0x00;
 ADCON1.PCFG2= 0x00;
 ADCON1.PCFG3= 0x00;
}




int analogRead(unsigned char pinAD)
{
 int resultAD;
 switch (pinAD)
 {
 case 0:
 ADCON0.CHS0 = 0x00;
 ADCON0.CHS1 = 0x00;
 ADCON0.CHS2 = 0x00;
 break;

 case 1:
 ADCON0.CHS0 = 0x01;
 ADCON0.CHS1 = 0x00;
 ADCON0.CHS2 = 0x00;
 break;

 case 2:
 ADCON0.CHS0 = 0x00;
 ADCON0.CHS1 = 0x01;
 ADCON0.CHS2 = 0x00;
 break;

 case 3:
 ADCON0.CHS0 = 0x01;
 ADCON0.CHS1 = 0x01;
 ADCON0.CHS2 = 0x00;
 break;

 case 4:
 ADCON0.CHS0 = 0x00;
 ADCON0.CHS1 = 0x00;
 ADCON0.CHS2 = 0x01;
 break;

 case 5:
 ADCON0.CHS0 = 0x01;
 ADCON0.CHS1 = 0x00;
 ADCON0.CHS2 = 0x01;
 break;

 case 6:
 ADCON0.CHS0 = 0x00;
 ADCON0.CHS1 = 0x01;
 ADCON0.CHS2 = 0x01;
 break;

 case 7:
 ADCON0.CHS0 = 0x01;
 ADCON0.CHS1 = 0x01;
 ADCON0.CHS2 = 0x01;
 break;
 }
 ADCON0.ADON = 0x01;
 delay_us (0x14);
 ADCON0.GO_NOT_DONE = 0x01;
 while (ADCON0.GO_NOT_DONE);
 resultAD = (ADRESH << 0x08) + (ADRESL >> 0x00);
 delay_us (0x14);
 ADCON0.ADON = 0x00;
 return (resultAD);
}
