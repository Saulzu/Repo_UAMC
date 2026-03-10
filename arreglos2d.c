 #include <stdio.h>
#include <stdbool.h>
#include <stdlib.h>
#include <time.h>

#define NUM_RENS 4
#define NUM_COLS 6

int main(int argc, char const *argv[])
{
    int matriz[NUM_RENS][NUM_COLS] = {0}; // Inicializamos toda la matriz con ceros.
    
    // Inicializamos la semilla del generador de nÃºmeros aleatorios.
    srand(time(NULL)); 
    
    // Llenamos la matriz con algunos valores enteros aleatorios entre 0 y 20.
    for (int i = 0; i < NUM_RENS; i++) {
        for (int j = 0; j < NUM_COLS; j++) {
            matriz[i][j] = rand() % 21; // Genera un nÃºmero ale atorio entre 0 y 20.
        }
    }
    
    // Imprimimos la matriz para verificar que se llenÃ³ correctamente.
    printf("Matriz de %d x %d:\n", NUM_RENS, NUM_COLS);
    for (int i = 0; i < NUM_RENS; i++) {
        for (int j = 0; j < NUM_COLS; j++) {
            printf("%3d ", matriz[i][j]);
        }
        printf("\n");
    }
    
    // Ejericio 1 Basico
    int suma = 0;
    // Suma de toda la matriz
    for (int i = 0; i < NUM_RENS; i++) {
        for (int j = 0; j < NUM_COLS; j++) {
            suma = suma + matriz[i][j];
        }
          
    }
    printf("La suma de la matriz %d", suma);

     // Ejericio 3 Basico
    int sumC = 0;
    // Suma de los renglones
    int sumCol[NUM_COLS] = {0};
    for (int i = 0; i < NUM_COLS; i++) {
        for (int j = 0; j < NUM_RENS; j++) {
            sumCol [i] +=  matriz[j][i];
        }           
    }

    for (int i = 0; i < NUM_COLS; i++) {
        printf("%d Columna:", i);
        printf("%d  ",  sumCol[i]);
    }
    //Fin Ejericio 3 Basico

    return 0;
}