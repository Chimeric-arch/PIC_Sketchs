/*
        Displays Multiplexados / Catodo comum
        Daniel Gier Arndt
        MCU - PIC16F877A
        25/02/21
*/

// Definições

// Mapeamento de hardware
    // Displays
   #define dsp1  RD0_bit
   #define dsp2  RD1_bit
   #define dsp3  RD2_bit
   #define dsp4  RD3_bit

   // Segmentos
   #define  A RB0_bit
   #define  B RB1_bit
   #define  C RB2_bit
   #define  D RB3_bit
   #define  E RB4_bit
   #define  F RB5_bit
   #define  G RB6_bit
   #define  point RB7_bit

// Protótipo de funções
void displayInit();
void DispMultiplex(int num);
void clearData();
void decodeDisplay(int num);

// Variáveis globais
int valor;


//============================================================================//
void interrupt()
{
  if (TMR0IF_bit)                                                               // Overflow do TIMER0 configurado para 1ms
  {
    TMR0 = 0x06;
    TMR0IF_bit = 0x00;
    DispMultiplex(valor);
  }
}

//============================================================================//
void main() 
{
  displayInit();
  while(1)
  {
    valor++;                                                                    // Variável com o valor a ser printado no display / 4 DIGITOS
    delay_ms(100);
  }
}

//============================================================================//
void displayInit()                                                              // Inicializa display e configura timer0
{
  TRISB = 0x00;                                                                 // Configura PORTB como saida
  PORTB = 0x00;                                                                 // Configura PORTD como saida
  
  TRISD = 0x00;
  PORTD = 0x0F;
  
  GIE_bit = 0x01;                                                               // Habilita interrupção global
  PEIE_bit = 0x01;                                                              // Habilita interrupção periférica
  TMR0IE_bit = 0x01;                                                            // Habilita interrupção do TIMER0
  TMR0 = 0x06;                                                                  // Inicializa TIMER0 EM 6
  OPTION_REG = 0x02;                                                            // Configura prescaler para 1:8
}

//============================================================================//
void DispMultiplex(int num)
{
  static char display = 0x01;

  if (display == 0x01 && dsp1)                                                  // Multiplexa display 1
  {
    display =  0x02;
    dsp2 = 0x01;
    dsp3 = 0x01;
    dsp4 = 0x01;
    clearData();
    dsp1 = 0x00;
    decodeDisplay (num/1000);
  }

  else if (display == 0x02 && dsp2)                                             // Multiplexa display 2
  {
    display =  0x03;
    dsp1 = 0x01;
    dsp3 = 0x01;
    dsp4 = 0x01;
    clearData();
    dsp2 = 0x00;
    decodeDisplay ((num % 1000)/100);
  }

  else if (display == 0x03 && dsp3)                                             // Multiplexa display 3
  {
    display =  0x04;
    dsp1 = 0x01;
    dsp2 = 0x01;
    dsp4 = 0x01;
    clearData();
    dsp3 = 0x00;
    decodeDisplay (((num % 1000)%100)/10);
  }

  else if (display == 0x04 && dsp4)                                             // Multiplexa display 4
  {
    display =  0x01;
    dsp1 = 0x01;
    dsp2 = 0x01;
    dsp3 = 0x01;
    clearData();
    dsp4 = 0x00;
    decodeDisplay (num % 10);
  }
}

//============================================================================//
void clearData()                                                                // Função auxiliar que limpa o barramento de dados
{
   A = 0x00;
   B = 0x00;
   C = 0x00;
   D = 0x00;
   E = 0x00;
   F = 0x00;
   G = 0x00;
}

//============================================================================//
void decodeDisplay(int num)                                                     // Função auxiliar que decodifica display
{
  if (num == 0x00)
  {
     A = 0x01;
     B = 0x01;
     C = 0x01;
     D = 0x01;
     E = 0x01;
     F = 0x01;
     G = 0x00;
  }


  else if (num == 0x01)
  {
     A = 0x00;
     B = 0x01;
     C = 0x01;
     D = 0x00;
     E = 0x00;
     F = 0x00;
     G = 0x00;
  }


  else if (num == 0x02)
  {
     A = 0x01;
     B = 0x01;
     C = 0x00;
     D = 0x01;
     E = 0x01;
     F = 0x00;
     G = 0x01;
  }


  else if (num == 0x03)
  {
     A = 0x01;
     B = 0x01;
     C = 0x01;
     D = 0x01;
     E = 0x00;
     F = 0x00;
     G = 0x01;
  }


  else if (num == 0x04)
  {
     A = 0x00;
     B = 0x01;
     C = 0x01;
     D = 0x00;
     E = 0x00;
     F = 0x01;
     G = 0x01;
  }


  else if (num == 0x05)
  {
     A = 0x01;
     B = 0x00;
     C = 0x01;
     D = 0x01;
     E = 0x00;
     F = 0x01;
     G = 0x01;
  }


  else if (num == 0x06)
  {
     A = 0x01;
     B = 0x00;
     C = 0x01;
     D = 0x01;
     E = 0x01;
     F = 0x01;
     G = 0x01;
  }

  else if (num == 0x07)
  {
     A = 0x01;
     B = 0x01;
     C = 0x01;
     D = 0x00;
     E = 0x00;
     F = 0x00;
     G = 0x00;
  }

  else if (num == 0x08)
  {
     A = 0x01;
     B = 0x01;
     C = 0x01;
     D = 0x01;
     E = 0x01;
     F = 0x01;
     G = 0x01;
  }


  else if (num == 0x09)
  {
     A = 0x01;
     B = 0x01;
     C = 0x01;
     D = 0x01;
     E = 0x00;
     F = 0x01;
     G = 0x01;
  }
}

//============================================================================//