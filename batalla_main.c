#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <time.h>
#include <string.h>
#include <math.h> 
#include "batalla_config.c"
#include "batalla_config.h"
#include "batalla_juego.c"
#include "batalla_juego.h"
#include "batalla_tableros.c"
#include "batalla_tableros.h"
#include "batalla_tipos.h"
#include "biblio_printconsola.c"
#include "biblio_printconsola.h"

int main()
{
   Tablero mapaJ1; 
   Tablero mapaJ2;
   Jugador player1 = {10, 5, 0, "UC", "uamito"};
   Jugador player2 = {10, 5, 0, "UX", "xochito"};
   
   mapaJ1.numRens = 20;
   mapaJ1.numCols = 20;
   mapaJ1.totalBarcos = 6;

   mapaJ2.numRens = 20;
   mapaJ2.numCols = 20;
   mapaJ2.totalBarcos = 6;
   prepararTableros(&mapaJ1, &mapaJ2);
   imprimetablero(mapaJ1);
   imprimetablero(mapaJ2);
   sembrarBarcos(mapaJ1);
   sembrarBarcos(mapaJ2);
   destruyeTableros(mapaJ1, mapaJ2);
   //leerConfigJuego(&mapaJ1, &mapaJ2, &player1, &player2);

   //prepararTableros(&mapaJ1, &mapaJ2); 
   
   jugar(mapaJ1, mapaJ2, player1, player2);

   //destruyTableros(mapaJ1, mapaJ2);

   return 0;
}

