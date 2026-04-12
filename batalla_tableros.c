// Estas funciones AHORA no tienen parámetros, pero conforme
// avancemos, TENEMOS que poner los parámetros necesarios
// de cada función.
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "batalla_tipos.h"
#include "batalla_tableros.h"
#include "biblio_printconsola.h"

void prepararTableros(Tablero* tab1, Tablero* tab2) {
    iniciaTablero(tab1);
//sembrarBarcos(tab1);

    iniciaTablero(tab2);
//sembrarBarcos(tab2);
}

void iniciaTablero(Tablero* tab) {
    tab->array = (int **) malloc(tab->numRens * sizeof(int*));

    for (int i = 0; i < tab->numRens; i++)
        tab->array[i] = (int*) malloc(tab->numCols * sizeof(int));

// Llenar el arreglo con casillas vacías
    for (int i = 0; i < tab->numRens; i++)
    {           
        for (int j = 0; j < tab->numCols; j++)
            tab->array[i][j] = CASILLA_VACIA;
    }
}
void imprimetablero(Tablero Tab){
    for(int i = 0; i < Tab.numRens; i++){
        for(int j = 0; j < Tab.numCols; j++){
            if(Tab.array[i][j] == CASILLA_VACIA)
                printf("~");
            else if(Tab.array[i][j] == BARCO_OCULTO)
                printf("W");
            else if(Tab.array[i][j] == BARCO_HUNDIDO)
                printf("X");
            else if(Tab.array[i][j] == TIRO_CAIDO)
                printf("O");
        }
        printf("\n");
    }
}

void destruyTablero(Tablero* tab) {
// Primero liberar cada renglón
    for (int i = 0; i < tab->numRens; i++) {
        free(tab->array[i]);
    }

// Luego liberar el arreglo de apuntadores
    free(tab->array);
}

void destruyeTableros(Tablero tab1, Tablero tab2) {
    destruyTablero(&tab1);
    destruyTablero(&tab2);
}

void sembrarBarcos(Tablero tab) {
/*
 Acá deben usar su algoritmo que poner 1s en una matriz.
 En lugar de poner los 1s de manera explícita, coloquen
 un constante de tipo EdoCasilla
*/
    int barcosColocados = 0;

    while (barcosColocados < tab.totalBarcos) {
        int i = rand() % tab.numRens;
        int j = rand() % tab.numCols;

        if (tab.array[i][j] == CASILLA_VACIA) {
            tab.array[i][j] = BARCO_OCULTO;
            barcosColocados++;
        }
    }

/*
El campo totalBarcos de Tablero tiene cuántos barcos deben poner.
*/
}

void leerInfoTableros(Tablero* tab1, Tablero* tab2) {
    printf("\nIngresa el núm. de renglones: ");
    scanf("%d", &(tab1->numRens));

    printf("\nIngresa el núm. de columnas: ");
    scanf("%d", &(tab1->numCols));

    int maxBarcos = tab1->numRens * tab1->numCols;
    printf("\nCuántos barcos iniciarán (entre 1 y %d): ", maxBarcos);
    scanf("%d", &(tab1->totalBarcos));

// El tablero 2 tendrá el mismo número de columnas y renglones que
// del tablero 1.
    tab2->numRens = tab1->numRens;
    tab2->numCols = tab1->numCols;
    tab2->totalBarcos = tab1->totalBarcos;
}

void leerInfoJugadores(Jugador* j1, Jugador* j2) {
    printf("\nAcá se leerá la información de ambos jugadores (TERMINAR ESTO...).\n");
    
    printf("Nombre jugador 1: ");
    scanf("%s", j1->nombre);

    printf("Elige tu emoji:\n");
    char emoji[4][5] = {"😀", "🐷", "🐶", "🐼"};

    printf("1. %s  2. %s  3. %s  4. %s\n", emoji[0], emoji[1], emoji[2], emoji[3]);

    int numEmoji;
    scanf("%d", &numEmoji);

    strcpy(j1->emoji, emoji[numEmoji - 1]);

    j1->nBarcosHundidos = 0;
    j1->nBarcosVivos = j1->nBarcosTotal;

// Jugador 2
    printf("\nNombre jugador 2: ");
    scanf("%s", j2->nombre);

    printf("Elige tu emoji:\n");
    printf("1. %s  2. %s  3. %s  4. %s\n", emoji[0], emoji[1], emoji[2], emoji[3]);

    scanf("%d", &numEmoji);

    strcpy(j2->emoji, emoji[numEmoji - 1]);

    j2->nBarcosHundidos = 0;
    j2->nBarcosVivos = j2->nBarcosTotal;
}