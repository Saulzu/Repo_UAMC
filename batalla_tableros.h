// Estas funciones AHORA no tienen parámetros, pero conforme
// avancemos, TENEMOS que poner los parámetros necesarios
// de cada función.
#include "batalla_tipos.h"


/*
Esta función recibe 2 Tableros por referencia para asignar valores 
a sus campos. Recibe los parámetros, pero el trabajo lo hace la 
función iniciaTablero(Tablero* tab).
*/
void prepararTableros(Tablero* tab1, Tablero *tab2);


/*
Esta función recibe un Tablero por referencia para asignar valores 
a sus campos. En particular, crea el campo array que representa la
matriz donde se ponen los barcos.
*/
void iniciaTablero(Tablero* tab);


/*
Esta función libera (función free) la memoria que ocupa el arreglo dinámico
de cada Tablero.
*/
void destruyeTableros(Tablero tab1, Tablero tab2);
void destruyTablero(Tablero* tab);
/* 
Esta función recibe un Tablero y coloca aleatoriamente N barcos
en posiciones aleatorias. Es decir, los coloca en el arreglo array
que está adentro del Tablero.
*/
void sembrarBarcos(Tablero tab);


/*
Esta función lee la información necesaria para crear los tableros,
por ejemplo, las dimensiones o el número de barcos iniciales.
*/
void leerInfoTableros(Tablero* tab1, Tablero* tab2);


void leerInfoJugadores(Jugador* j1, Jugador* j2);

