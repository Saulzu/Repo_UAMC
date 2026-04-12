// Estas funciones AHORA no tienen parámetros, pero conforme
// avancemos, TENEMOS que poner los parámetros necesarios
// de cada función.
#include <stdio.h>
#include "batalla_config.h"
#include "batalla_tableros.h"
#include "batalla_tipos.h"

void leerConfigJuego(Tablero* tab1, Tablero* tab2, Jugador* j1, Jugador* j2) 
{
    printf("\nLeyendo la configuración del juego...\n");
    leerInfoTableros(tab1, tab2);

    j1->nBarcosTotal = tab1->totalBarcos;
    j2->nBarcosTotal = tab2->totalBarcos;
    
    leerInfoJugadores(j1, j2);
}

