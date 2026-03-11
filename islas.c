/******************************************************************************

EVALUACION 4: Arreglos 2D: tormenta en las islas.

1. Presiona el botC3n "Fork this" para tener una versiC3n editable.

2. Cuando termines, copia tu cC3digo y pC)galo en el documento de Google Classroom.
*******************************************************************************/
#include <stdio.h>
#include <stdbool.h>

#define NUM_ISLAS 6

// Estructura que define el tipo de dato Isla.
    typedef struct {
	    float x; // posiciC3n x de la isla.
	    float y; // posiciC3n y de la isla.
	    bool disponible; // dice si estC! o no disponible la isla.
    } Isla;

// FunciC3n que calcula la matriz de distancias entre TODAS las islas.
// En esta funciC3n no importa si la isla estC! disponible o no.
    void calcDistancias(float dist[][NUM_ISLAS], Isla islas[], int numIslas) {
	// Recuerden que la matriz de distancias es simC)trica.
	
	for (int i = 0; i < numIslas; i++) {
	    for (int j = 0; j < numIslas; j++) {
	        
	        float difx =  pow((islas[j].x - islas[i].x), 2);
            float dify =  pow((islas[j].y - islas[i].y), 2);
            float sm2 = difx + dify;
            dist[i][j] = dist[j][i] = sqrt(sm2);
            
	    }
    }

    // FunciC3n que encuentra la distancia mC-nima entre islas disponibles.
    // Aqui solo deben considerar solamente las islas que estC!n disponibles.
    float distanciaMinima(float dist[][NUM_ISLAS], Isla islas[], int numIslas) {
    	// AquC- solamente calculan la distancia mC-nima, pero dentro
    	// de las funciones NO SE IMPRIMEN RESULTADOS.
		if(islas[i].disponible && islas[j].disponible) {
			if (dist[i][j] < min) {
				min = dist[i][j];
			}
		}
    	// AquC- regresan el resultado.
    }

int main()
{
	// Este es el arreglo de islas que vamos a usar para probar las funciones.
	Isla listaIslas[NUM_ISLAS] =
	{	{2.0, 4.0, true},
		{0.0, 3.0, false},
		{7.0, 2.0, true},
		{3.0, 3.0, true},
		{6.0, 4.0, false},
		{8.0, 5.0, true}
	};


	float distancias[NUM_ISLAS][NUM_ISLAS];

	//1.  Invocar la funciC3n para calcular las distancias entre todas las islas.

	//2.  Invocar la funciC3n para encontrar la distancia mC-nima entre islas disponibles.

	//3. Imprimir la distancia mC-nima encontrada.

	return 0;
}