/*
  Simple Synchronous Serial Communication Protocol - SSSCP (3SCP)
  
  Inicializar TIMER0 em 0xA9 para uma frequência de clock de 9615.
  A taxa de transmissão de dados é metade do valor do clock.
  Atualização dos dados é feita na borda de subida do clock.
*/


// Mapeamento de hardware
#define clk PORTB.RB0
#define dat PORTB.RB1

// Macros
#define testBit (byte, bit)  ((byte) &   (1<<(bit)))
#define setBit  (byte, bit)  ((byte) |=  (1<<(bit)))
#define clearBit(byte, bit)  ((byte) &= ~(1<<(bit)))

// Definições de software
#define nProto 0x07                                                             // Tamanho máximo de bits do protocolo


// Protótipo de funções
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
    clk = ~clk;
    
    if (clk)
    {
    
    }
  }
}

void main() 
{
  reg_config();
  while(1)
  {
    //sendData(21);
    /*
    if (clk)
    {
      dat = (testBit(54, i)) ? (dat = 0x01) : (dat = 0x00);
      if (i > nProto)i = 0x00;
      i++;
    }
    */
  }
}


void reg_config()
{
  // OPTION_REG register
  OPTION_REG.T0CS = 0x00;                                                       // Usar TMR0 com clock interno
  OPTION_REG.PSA  = 0x01;                                                       // Prescaler direcionado para TMR0
  OPTION_REG.PS2  = 0x00;                                                       // Prescaler 1:2
  OPTION_REG.PS1  = 0x00;
  OPTION_REG.PS0  = 0x00;
  //=========================
  
  // INTCON register
  INTCON.GIE    = 0x01;
  INTCON.PEIE   = 0x01;
  INTCON.TMR0IE = 0x01;
  //=========================
  
  // TMR0 register
  TMR0 = 208;
  //=========================
  
  // TRISB & PORTB register
  TRISB = 0x00;
  PORTB = 0x00;
  
  TRISD = 0x00;
  PORTD = 0x00;
  //=========================
}

/*
void sendData(char dat_)
{
  register int i = 0x00;
  for (i < nProto; i++;)
  {
    dat = (testBit(dat_, i)) ? (dat = 0x01) : (dat = 0x00);
    delay_us(104);
  }
}
*/


char readData()
{
  char rxBuff;
  if (dat)       setBit(rxBuff, i);
  else if (!dat) clearBit(rxBuff, i);
}


unsigned char frequency_timerZero(int frequency){return 2E6/-(frequency)*-1;}

