#include <pic14/pic12f683.h>
#include <stdint.h>

#define LFSR_SIZE 16

//Parametrosp p ara num random
 
//To compile:
//sdcc -mpic14 -p16f675 blink.c
 
//To program the chip using picp:
//Assuming /dev/ttyUSB0 is the serial port.
 
//Erase the chip:
//picp /dev/ttyUSB0 16f887 -ef
 
//Write the program:
//picp /dev/ttyUSB0 16f887 -wp blink.hex
 
//Write the configuration words (optional):
//picp /dev/ttyUSB0 16f887 -wc 0x2ff4 0x3fff
 
//Doing it all at once: erasing, programming, and reading back config words:
//picp /dev/ttyUSB0 16f887 -ef -wp blink.hex -rc
 
//To program the chip using pk2cmd:
//pk2cmd -M -PPIC16f887 -Fblink.hex
 
void delay (unsigned int tiempo);
uint16_t rand();
 
	uint8_t num[10][8] = {
	{0, 0, 1, 1, 1, 1, 1, 1}, // 0
	{0, 0, 0, 0, 0, 1, 1, 0}, // 1
	{0, 1, 0, 1, 1, 0, 1, 1}, // 2
	{0, 1, 0, 0, 1, 1, 1, 1}, // 3
	{0, 1, 1, 0, 0, 1, 1, 0}, // 4
	{0, 1, 1, 0, 1, 1, 0, 1}, // 5
	{0, 1, 1, 1, 1, 1, 0, 1}, // 6 
	{0, 0, 0, 0, 0, 1, 1, 1}, // 7
	{0, 1, 1, 1, 1, 1, 1, 1}, // 8
	{1, 1, 1, 0, 1, 1, 1, 1}  // 9
	};

void main(void)
{


    TRISIO = 0b00001000; //Poner todos los pines como salidas
	GPIO = 0x00; //Poner pines en bajo

	while (1)
	{

	while (GP3 == 0x00){} //Esperar que el boton se presione.
		
	uint8_t num_gen = rand();
	
	while (num_gen > 3)
	{
		num_gen = rand();
		delay(10);
	}
	
        
	for (uint8_t i = 0; i < 8; i++)
	{
		uint8_t dato = num[num_gen][i];

		if (dato == 1)
		{
			// Colocar 1
			GP2 = 0xFF;
			delay(10);
			GP0 = 0x00;
			delay(10);
			GP0 = 0xFF;
			delay(10);
		}

		else{
			// Colocar 0
			GP2 = 0x00;
			delay(10);
			GP0 = 0x00;
			delay(10);
			GP0 = 0xFF;
			delay(10);
		}


	}
	
			// Aceptar trama
			GP1 = 0x00;
			delay(10);
			GP1 = 0xFF;
			delay(10);		
}

	}





//p0 = SHC (Pulsos)
//p1 = STC (Aceptar)
//p2 = DS  (Select)













void delay(unsigned int tiempo)
{
	unsigned int i;
	unsigned int j;

	for(i=0;i<tiempo;i++)
	  for(j=0;j<1275;j++);
}



uint16_t rand()
{
    static uint16_t lfsr = 0xACE1u;
    uint16_t lsb = lfsr & 1; // Bit menos significativo
    lfsr >>= 1; // Desplazar un bit a la derecha

    // Aplicar retroalimentación
    if (lsb) {
        lfsr ^= 0xB400u; // Retroalimentación XOR para un LFSR de 16 bits
    }

    return lfsr & 0x9; // Para limitar el valor al rango 0-10
}
