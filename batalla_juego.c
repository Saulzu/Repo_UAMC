// Estas funciones AHORA no tienen parámetros, pero conforme
// avancemos, TENEMOS que poner los parámetros necesarios
// de cada función.

#include <stdio.h>
#include "batalla_juego.h"
#include "biblio_printconsola.h"

void jugar(Tablero t1, Tablero t2, Jugador j1, Jugador j2) {

   limpiaConsola();

   printf("\nAcá se realizará el ciclo principal del juego.\n");
   desplegarMarcadores(j1, j2, 5, 20, 50);
   //Aquí falta desplegarTableros(...);

   // Y el resto de TODO el juego.
}


void desplegarMarcadores(Jugador j1, Jugador j2, int ren, int col, int despl) {

   // Ambos marcadores saldrán en el mismo renglón de la terminal.
   // PERO el primero saldrá en col y... 
   desplegarMarcador(j1, ren, col);

   //   el sengundo en col+despl, es decir
   // saldrá desplazado a la DERECHA el número de espacios dado.
   desplegarMarcador(j2, ren, col+despl);
}

void desplegarMarcador(Jugador player, int ren, int col) {
   char mensaje[50];
   sprintf(mensaje, "Jugador %s: %s", player.emoji, player.nombre);
   printRenCol(ren, col, mensaje, BLANCO);

   sprintf(mensaje, "Barcos activos : %d", player.nBarcosVivos);
   printRenCol(ren+1, col, mensaje, VERDE);

   sprintf(mensaje, "Barcos hundidos: %d", player.nBarcosHundidos);
   printRenCol(ren+2, col, mensaje, ROJO);
}


void desplegarTableros(Tablero tab1, Tablero tab2, int ren, int col) {
   dibujaTablero(tab1, ren, col);

   dibujaTablero(tab2, ren, col + tab1.numCols);

   // Al dibujar tableros NO necesitamos pasar un parámetro de desplazamiento
   // porque conocemos el "ancho" del tablero 1, tab1.numCols
   
   // Pero ajustesn, porque si sus casillas ocupan 3 espacios al dibujarlas, 
   // entonces en lugar de col+ tab1.numCols, deberían
   // usar col + 3*tab1.numCols.
}

void dibujaTablero(Tablero tablero, int ren, int col) {
   printf("\nTomar el arreglo del tablero para mostrar su vista en %d,%d.\n", ren, col);
 
   // El arreglo vive en tablero.array
}

void leerTiradaValida() {
   printf("\nLeyendo el renglón y columna válidas de un tiro.\n");
}

void marcarTiro() {
   printf("\nMarcando en el tablero si el tiro hundió un barco.\n");
}

void actualizarTablero() {
   printf("\nMostrando al usuario el nuevo estado de los tableros.\n");
}


