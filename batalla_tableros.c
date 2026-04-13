#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "batalla_tipos.h"
#include "batalla_tableros.h"
#include "biblio_printconsola.h"

void prepararTableros(Tablero* tab1, Tablero* tab2) {
    iniciaTablero(tab1);
    sembrarBarcos(tab1);

    iniciaTablero(tab2);
    sembrarBarcos(tab2);
}

void iniciaTablero(Tablero* tab) {
    tab->array = (int **) malloc(tab->numRens * sizeof(int*));

    for (int i = 0; i < tab->numRens; i++)
        tab->array[i] = (int*) malloc(tab->numCols * sizeof(int));

    for (int i = 0; i < tab->numRens; i++)
    {           
        for (int j = 0; j < tab->numCols; j++)
            tab->array[i][j] = CASILLA_VACIA;
    }
}

void destruyTablero(Tablero* tab) {
    for (int i = 0; i < tab->numRens; i++) {
        free(tab->array[i]);
    }
    free(tab->array);
}

void destruyeTableros(Tablero* tab1, Tablero* tab2) {
    destruyTablero(tab1);
    destruyTablero(tab2);
}

void muestraAzar(int muestra[], int N) {
    int A[N];

    for (int i = 0; i < N; i++) {
        A[i] = i;
    }
    
    int fin = N - 1;
    for (int i = 0; i < N; i++) {
        int r = rand() % (fin + 1);

        muestra[i] = A[r];
        A[r] = A[fin];
        fin = fin - 1;
    }
}

void sembrarBarcos(Tablero* tab) {
    int totalCasillas = tab->numRens * tab->numCols;

    if (tab->totalBarcos > totalCasillas) {
        printf("\nMuchos barcos para el tamaño del tablero\n");
        return;
    }

    int muestra[totalCasillas];

    muestraAzar(muestra, totalCasillas);

    for (int i = 0; i < tab->totalBarcos; i++) {
        int k = muestra[i];

        int ren = k / tab->numCols;
        int col = k % tab->numCols;

        tab->array[ren][col] = BARCO_OCULTO;
    }
}
void leerInfoTableros(Tablero* tab1, Tablero* tab2) {
    do {
        printf("\nIngresa el num. de renglones (5-30): ");
        scanf("%d", &(tab1->numRens));
        if (tab1->numRens < 5 || tab1->numRens > 30) 
            printf("Dato invalido, intenta de nuevo.\n");
    } while (tab1->numRens < 5 || tab1->numRens > 30);
   
    do {
        printf("Ingresa el num. de columnas (5-30): ");
        scanf("%d", &(tab1->numCols));
        if (tab1->numCols < 5 || tab1->numCols > 30) 
            printf("Dato invalido, intenta de nuevo.\n");
    } while (tab1->numCols < 5 || tab1->numCols > 30);

    int maxBarcos = tab1->numRens * tab1->numCols;
    printf("Cuantos barcos (1-%d): ", maxBarcos);
    scanf("%d", &(tab1->totalBarcos));

    tab2->numRens = tab1->numRens;
    tab2->numCols = tab1->numCols;
    tab2->totalBarcos = tab1->totalBarcos;
}

void leerInfoJugadores(Jugador* j1, Jugador* j2) {
    printf("Nombre jugador 1: ");
    scanf("%s", j1->nombre);

    printf("Elige tu emoji:\n");
    char emoji[5][5] = {"🤖", "🐲", "🦀", "🐼", "🦜"};

    printf("1. %s  2. %s  3. %s  4. %s, 5.%s\n", emoji[0], emoji[1], emoji[2], emoji[3], emoji[4]);

    int numEmoji;
    scanf("%d", &numEmoji);

    strcpy(j1->emoji, emoji[numEmoji - 1]);

    j1->nBarcosHundidos = 0;
    j1->nBarcosVivos = j1->nBarcosTotal;

    printf("\nNombre jugador 2: ");
    scanf("%s", j2->nombre);

    printf("Elige tu emoji:\n");
    printf("1. %s  2. %s  3. %s  4. %s, 5.%s\n", emoji[0], emoji[1], emoji[2], emoji[3], emoji[4]);

    scanf("%d", &numEmoji);

    strcpy(j2->emoji, emoji[numEmoji - 1]);

    j2->nBarcosHundidos = 0;
    j2->nBarcosVivos = j2->nBarcosTotal;
}