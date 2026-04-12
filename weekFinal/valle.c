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
    
    // Ejericio 2 Matrices - Valle
    int x, y = 0;

    printf("Cordenada X?");
    scanf("%d",&x);
    printf("Cordenada Y?");
    scanf("%d",&y);

    int delta[3] = {1, -1, 0};
    int list[2][8] = {0}; 
    int l = 1;
    for (int i = 0; i < x; i++) {
        for (int j = 0; j < y; j++) {
            int nx = x + delta[i];
            int ny = y + delta[j];

            if(i >= 0 && j >= 0 && i < NUM_RENS && j < NUM_COLS){
                list[0][l] = nx;
                list[1][l] = ny;
                l++;
                printf("%d, %d\n", nx, ny);
            }
        }
    }

    /*
    
    printf("Lista de %d x %d:\n", 2, 8);
    for (int i = 0; i < 2; i++) {
        for (int j = 0; j < 8; j++) {
            printf("%3d ", matriz[i][j]);
        }
        printf("\n");
    }

    */
    
    return 0;
}