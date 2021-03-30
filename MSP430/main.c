#include <msp430g2553.h>

#define RX BIT1
#define TX BIT2
#define LED BIT6

void clockInit();
void uartInit();
void uartPorts(int tx_bit, int rx_bit);

int main(void)
{
	WDTCTL = WDTPW | WDTHOLD;	// stop watchdog timer

	P1OUT = 0;
	P1SEL = 0;
	P1SEL2 = 0;
	P1DIR = 0;

	/* config LED */
	P1DIR = LED;

	clockInit();
	uartInit();
	uartPorts(TX, RX);

	/* enable interrupts */
	_BIS_SR(LPM0_bits + GIE);

	while(1);

	return 0;
}

void clockInit()
{
    DCOCTL = CALDCO_1MHZ;
    BCSCTL1 = CALBC1_1MHZ;
}

/*
 *      Steps to initializes and set UART module
        *1. Set UCSWRST (BIS.B #UCSWRST,&UCAxCTL1)
        *2. Initialize all USCI registers with UCSWRST = 1 (including UCAxCTL1)
        *3. Configure ports.
        *4. Clear UCSWRST via software (BIC.B #UCSWRST,&UCAxCTL1)
        *5. Enable interrupts (optional) via UCAxRXIE and/or UCAxTXIE
 */

void uartInit()
{
    /* #1 */
    UCA0CTL1 = UCSWRST;

    /* #2 */
    UCA0CTL1 |= UCSSEL_2; // SMCLK

    /* #3 */
    UCA0CTL0 = 0;
    UCA0CTL0 |= 0;
    // UCA0CTL0 = 0;
    UCA0BR0 = 104;      /*  104 From datasheet table- */
    UCA0BR1 = 0;        /* -selects baudrate =9600,clk = SMCLK*/
    UCA0MCTL = UCBRS_1; /* Modulation value = 6 from datasheet*/
    /* $4 */
    UCA0CTL1 &= ~UCSWRST;

    /* #5 */
    IE2 |= UCA0RXIE;

}

void uartPorts(int tx_bit, int rx_bit)
{
    P1SEL |= tx_bit | rx_bit;
    P1SEL2 |= tx_bit | rx_bit;
}

#pragma vector=USCIAB0RX_VECTOR
__interrupt void USCI0RX_ISR(void)
{
    if(UCA0RXBUF == 49){
        P1OUT = LED;
    }
    else{
        P1OUT &= ~LED;
    }
    //while(!(IFG2&UCA0TXIFG)); // USCI_A0 TX buffer ready?
    //UCA0TXBUF = UCA0RXBUF; // TX -&gt; RXed character
}


