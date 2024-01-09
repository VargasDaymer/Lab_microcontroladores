#include <pic14/pic12f683.h>
#include <stdint.h>

//Se define la cantidad de números qeu van a salir sin repetirse.
#define MAX_NUMEROS 10  //Max de 30.

//Semilla para generar los números pseudoaleatorios.
uint16_t seed = 512;

//Declaración de funciones. 
void delay (unsigned int tiempo);
uint8_t fue_utilizado(uint8_t num);
uint8_t generar_numero_unico();
uint16_t rand();

//Variable global para saber cuando se han desplehado los 100 números.
uint8_t cont = 0;

//Arreglo de numeros que ya fueron desplegados.
uint8_t numeros_usados[MAX_NUMEROS]; 

// Numeros en hex para el display.
uint8_t num[10] = {0xFC, 0x60, 0xDA, 0xF2, 0x66, 0xB6, 0xBE, 0xE0, 0xFE, 0xF7};


void main(void)
{
    TRISIO = 0b00001000; //Poner todos los pines como salidas y GP3 como entrada.
	GPIO = 0x00; //Poner pines en bajo

	while (1)
	{

	while (GP3 == 0x00){} //Esperar que el boton se presione.
		
	uint8_t num_gen = generar_numero_unico();

	uint8_t dato1 = num[num_gen / 10]; //Obtener las unidades.

	uint8_t dato2 = num[num_gen % 10]; //Obtener las decenas.

	// Enviar núnmero.

	GP1 = 0x00; //Aceptar en bajo.

	if(cont >= MAX_NUMEROS){ //Si se llega a la cantidad de números repetido se excriben 9.

	dato1 = 0xF7; //Numero 9.
	GP1 = 0x00; //Aceptar en bajo
	for (int i = 0; i < 8; i++)
	{

		int salida = 0;

		salida =  dato1 & 0b0000000000000001; //Toma el valor el LSB.
		dato1 = dato1 >> 1; //Desplaza los bits para leer el siguiente.


		GP2 = salida; //Coloca el valor an enviar.
		delay(1);
		
		//Envia el flanco.
		GP0 = 0x01;
		delay(1);
		GP0 = 0x00;
		delay(1);
		
	}

	dato1 = 0xF7;
	for (int i = 0; i < 8; i++)
	{

		int salida = 0;

		salida =  dato1 & 0b0000000000000001;
		dato1 = dato1 >> 1;


		GP2 = salida;
		delay(1);
		
		//Enviar flanco.
		GP0 = 0x01;
		delay(1);
		GP0 = 0x00;
		delay(1);
		
	}

	GP1 = 0x01; //Aceptar en alto
	delay(1);

	

	}

	else{ //Si no se ha llegado al numero maximo, imprimir aleatorio.
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
	}

	GP1 = 0x01; //Aceptar en alto
	cont++; //Se registra que se mostro un numero.
		
}

}


//GP0 = SHC (Pulsos)(Reloj)
//GP1 = STC (Aceptar)(Latch)
//GP2 = DS  (Select)(Datos)


// La función verifica que el número no este dentro del arreglo.
uint8_t fue_utilizado(uint8_t num) {

    for (uint8_t i = 0; i < MAX_NUMEROS; i++) {
        if (numeros_usados[i] == num) {
            return 1; // Si el número ya se ha utilizado, retorna 1.
        }
    }
    return 0;
}

// Genera un número fuera de la lista de utilizados.
uint8_t generar_numero_unico() {
    uint8_t num; 
	//Se genera un numero aleatorio mientras hasta que esté fuera de la lista de utilizados.
    do {
        num = rand(); // Genera un número aleatorio entre 0 y 100.
    } while (fue_utilizado(num)); // Verifica si ya fue utilizado

    // Registra el número generado.
    numeros_usados[cont] = num;

    return num;
}

//Función para generar números pseudoaleatorios.
uint16_t rand()
{
    seed = (118 * seed + 455) % 685; // Algoritmo GLC simple

    // Escala el número generado al rango de 0 a 100.
    return seed % 100;
}

void delay(unsigned int tiempo)
{
	unsigned int i;
	unsigned int j;

	for(i=0;i<tiempo;i++)
	  for(j=0;j<1275;j++);
}

