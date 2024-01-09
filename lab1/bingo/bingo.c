#include <pic14/pic12f683.h>
#include <stdint.h>

#define MAX_NUMEROS 10  //Max de 30.

unsigned int seed = 512;

//void enviar(uint8_t dato);
uint8_t fue_utilizado(uint8_t num);
uint8_t generar_numero_unico();
void delay (unsigned int tiempo);
uint16_t rand();
 
int cont = 0;

// Numeros en hex para el display.
uint8_t num[10] = {0xFC, 0x60, 0xDA, 0xF2, 0x66, 0xB6, 0xBE, 0xE0, 0xFE, 0xF7};

uint8_t numeros_usados[MAX_NUMEROS] = {0}; 

void main(void)
{
    TRISIO = 0b00001000; //Poner todos los pines como salidas
	GPIO = 0x00; //Poner pines en bajo

	while (1)
	{

	while (GP3 == 0x00){} //Esperar que el boton se presione.
		
	uint8_t num_gen = generar_numero_unico();

	uint8_t dato1 = num[num_gen / 10];

	uint8_t dato2 = num[num_gen % 10];

	// Enviar 
	GP1 = 0x00; //Aceptar en bajo

	for (int i = 0; i < 8; i++)
	{
		int salida = 0;

		salida = dato1 & 0b00000001;
		dato1 = dato1 >> 1;


		GP2 = salida;
		delay(1);
		
		//Enviar flanco.
		GP0 = 0x01;
		delay(1);
		GP0 = 0x00;
		delay(1);
		
	}

	for (int i = 0; i < 8; i++)
	{
		int salida = 0;

		salida = dato2 & 0b00000001;
		dato2 = dato2 >> 1;


		GP2 = salida;
		delay(1);
		
		//Enviar flanco.
		GP0 = 0x01;
		delay(1);
		GP0 = 0x00;
		delay(1);
		
	}

	GP1 = 0x01; //Aceptar en alto

	

	if(cont == 10){

	GP1 = 0x00; //Aceptar en bajo

	for (int i = 0; i < 16; i++)
	{
		int salida = 0;

		salida =  0xF7F7 & 0b00000001;
		dato2 = dato2 >> 1;


		GP2 = salida;
		delay(1);
		
		//Enviar flanco.
		GP0 = 0x01;
		delay(1);
		GP0 = 0x00;
		delay(1);
		
	}

	GP1 = 0x01; //Aceptar en alto


	}
	
	cont++;
		
}

}





//p0 = SHC (Pulsos)(Reloj)
//p1 = STC (Aceptar)(Latch)
//p2 = DS  (Select)(Datos)

/****
//Función enviar
void enviar(uint8_t dato){

	for (int i = 0; i < 8; i++)
	{
		int salida = 0;

		salida = dato & 0b00000001;
		dato = dato >> 1;


		GP2 = salida;
		delay(1);
		
		//Enviar flanco.
		GP0 = 0x01;
		delay(1);
		GP0 = 0x00;
		delay(1);
		
	}




}
****/


// La función verifica que el número no este dentro del arreglo.
uint8_t fue_utilizado(uint8_t num) {

    for (int i = 0; i < MAX_NUMEROS; i++) {
        if (numeros_usados[i] == num) {
            return 1; // Si el número ya se ha utilizado, retorna 1.
        }
    }
    return 0;
}

uint8_t generar_numero_unico() {
    uint8_t num;
    do {
        num = rand(); // Genera un número aleatorio.
    } while (fue_utilizado(num)); // Verifica si ya fue utilizado

    // Registra el número generado
    for (int i = 0; i < MAX_NUMEROS; i++) {
        if (numeros_usados[i] == 0) {
            numeros_usados[i] = num;
            break;
        }
    }

    return num;
}


void delay(unsigned int tiempo)
{
	unsigned int i;
	unsigned int j;

	for(i=0;i<tiempo;i++)
	  for(j=0;j<1275;j++);
}

uint16_t rand()
{
    seed = (118 * seed + 455) % 685; // Algoritmo GLC simple

    // Escala el número generado al rango de 0 a 9
    return seed % 100;
}




