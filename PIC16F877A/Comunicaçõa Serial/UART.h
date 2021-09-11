#ifndef UART_H
#define UART_H
#endif


// Protótipo de funções
void SerialBegin(const long int baudRate);
void SerialWrite(unsigned char byte);
void SerialWrite_String(const char* string);
char SerialRead();


void SerialBegin(const long int baudRate)
{
  SPBRG = (Clock_MHz() * 1E6)/(16 * baudRate)- 1;
  TXSTA = 0x24;
  RCSTA = 0x90;
  TRISC.TRISC6 = 0x00;
  TRISC.TRISC7 = 0x01;
}


void SerialWrite(char byte)
{
  TXREG = byte;
  while (!PIR1.TXIF);
}


void SerialWrite_String(const char* string)
{
  int i = 0x00;
  while(string[i] != '\0')
  {
    SerialWrite(string[i]);
    i++;
  }
}


char SerialRead()
{
  if (PIR1.RCIF)
  {
    PIR1.RCIF = 0x00;
    if (RCSTA.FERR || RCSTA.OERR)
    {
      char error = RCREG;
      CREN_bit = 0x00;
      CREN_bit = 0x01;
      return 0x00;
    }
    return RCREG;
  }
  else return 0x00;
}





