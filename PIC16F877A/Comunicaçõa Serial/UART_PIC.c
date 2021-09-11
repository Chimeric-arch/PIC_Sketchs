#include <UART.h>


void main()
{
  TRISB = 0x00;
  PORTB = 0x00;
  SerialBegin(9600);
  while (1)
  {
    PORTB = SerialRead();
    delay_ms(100);
  }
}
