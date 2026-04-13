#include <stdio.h>
#include "batalla_juego.h"
#include "biblio_printconsola.h"

void leerTiradaValida(int maxR, int maxC, int* outRen, int* outCol) {
    int fila, col;
    int leidoFila, leidoCol;
    do {
        printf("Ingresa la fila (1-%d): ", maxR);
        leidoFila = scanf("%d", &fila);
        if (leidoFila != 1 || fila < 1 || fila > maxR) {
            printf("Fila inválida. Intenta de nuevo.\n");
            leidoFila = 0; 
        }
        printf("Ingresa la columna (1-%d): ", maxC);
        leidoCol = scanf("%d", &col);
        if (leidoCol != 1 || col < 1 || col > maxC) {
            printf("Columna inválida. Intenta de nuevo.\n");
            leidoCol = 0;
        }
    } while (leidoFila != 1 || leidoCol != 1);
    
    *outRen = fila - 1;
    *outCol = col - 1;
}

int marcarTiro(Tablero* objetivo, int fila, int col) {
    int actual = objetivo->array[fila][col];
    if (actual == BARCO_HUNDIDO || actual == TIRO_CAIDO)
        return -1;

    if (actual == BARCO_OCULTO) {
        objetivo->array[fila][col] = BARCO_HUNDIDO;
        return 1;
    }
    objetivo->array[fila][col] = TIRO_CAIDO;
    return 0;
}

void desplegarMarcadores(Jugador j1, Jugador j2) {
   int colJ1 = 5;
   int colJ2 = 50;
   int despl = colJ2 - colJ1;

   desplegarMarcador(j1, 6, colJ1);
   desplegarMarcador(j2, 6, colJ1+despl);
}

void desplegarMarcador(Jugador player, int ren, int col) {
   char mensaje[100];
   sprintf(mensaje, "Jugador %s: %s", player.emoji, player.nombre);
   printRenCol(ren+1, col, mensaje, BLANCO);

   sprintf(mensaje, "Barcos activos : %d", player.nBarcosVivos);
   printRenCol(ren+2, col, mensaje, VERDE);

   sprintf(mensaje, "Barcos hundidos: %d", player.nBarcosHundidos);
   printRenCol(ren+3, col, mensaje, ROJO);

   printf("\e[0m\n");
}

void guiaTopTablero(int numCols, int espaciosI) {
   printf("%*s", espaciosI, "");
   printf("     ");
   for (int col = 1; col <= numCols; col++) {
      printf("\e[38;5;%dm%-2d  ", MORADO, col);
   }
}

void dibujaTablero(Tablero tablero, int fila, int mostrarBarcos, int espaciosI) {
   printf("%*s", espaciosI, "");
   
  printf("\e[38;5;%dm%d \e[0m ", MORADO, fila + 1);
   for (int col = 0; col < tablero.numCols; col++) {
         int valor = tablero.array[fila][col];
         const char* simbolo = "🌊";

         if (valor == BARCO_HUNDIDO) {
            simbolo = "💥";
         } else if (valor == TIRO_CAIDO) {
            simbolo = "⚓";
         } else if (valor == BARCO_OCULTO && mostrarBarcos) {
            simbolo = "⛵";
         }

      printf("  %s", simbolo);
   }
}

void desplegarTableros(Tablero propio, Tablero enemy, Jugador* atacante, Jugador* defensor) {
   int colJ1 = 5;
   int colJ2 = 50;
   int separacionEntreTableros = colJ2 - colJ1;

   printf("\n");
   desplegarMarcadores(*atacante, *defensor);
   printf("\n");

   guiaTopTablero(propio.numCols, colJ1);
    
   int anchoTablero = 3 + (propio.numCols * 3); 
   int espaciosAlSegundo = separacionEntreTableros - anchoTablero;
    
   guiaTopTablero(enemy.numCols, espaciosAlSegundo);
   printf("\n");

   int filas;
   if (propio.numRens < enemy.numRens)
      filas = propio.numRens;
   else
      filas = enemy.numRens;

   for (int fila = 0; fila < filas; fila++) {
      dibujaTablero(propio, fila, 1, colJ1);
      printf("%*s", espaciosAlSegundo, "");
      dibujaTablero(enemy, fila, 0, 0);
      printf("\n");
   }
}

void turnoBatalla(Jugador* atacante, Jugador* defensor, int ren, int col) {
   char mensaje[100];

   printRenCol(ren, col, "═════════ TURNO DE BATALLA ═════════", BLANCO);
   sprintf(mensaje, "          %s %s", atacante->emoji, atacante->nombre);
   printRenCol(ren + 1, col, mensaje, BLANCO);
   printRenCol(ren + 2, col, "════════════════════════════════════", BLANCO);

   sprintf(mensaje, "Barcos propios: %d | Enemigos restantes: %d", 
            atacante->nBarcosVivos, defensor->nBarcosVivos);
   printRenCol(ren + 4, col, mensaje, BLANCO);
}

void resultadoTiro(int impacto, int ren, int col) {
   if (impacto) {
      printRenCol(ren,     col, "╔════════════════════════════════╗", ROJO);
      printRenCol(ren + 1, col, "║   ¡IMPACTO! BARCO HUNDIDO      ║", ROJO);
      printRenCol(ren + 2, col, "╚════════════════════════════════╝", ROJO);
   } else {
      printRenCol(ren,     col, "╔════════════════════════════════╗", CIAN);
      printRenCol(ren + 1, col, "║         AGUA - FALLO           ║", CIAN);
      printRenCol(ren + 2, col, "╚════════════════════════════════╝", CIAN);
   }
}

void jugar(Tablero* t1, Tablero* t2, Jugador* j1, Jugador* j2) {
   Tablero* propio = t1;
   Tablero* enemigo = t2;
   Jugador* atacante = j1;
   Jugador* defensor = j2;

   cursorInvisible();
   while (j1->nBarcosVivos > 0 && j2->nBarcosVivos > 0) {
      int resultado;
      int fila, col;

      do {
         limpiaConsola();
         turnoBatalla(atacante, defensor, 2, 10);
         desplegarTableros(*propio, *enemigo, atacante, defensor);

         printf("\n");
         leerTiradaValida(propio->numRens, propio->numCols, &fila, &col);
            
         resultado = marcarTiro(enemigo, fila, col);

         if (resultado == -1) {
            printf("\e[38;5;46mYa disparaste ahí. Intenta de nuevo (ENTER)...\e[0m\n");
            cursorVisible();
            while (getchar() != '\n');
            getchar();
            cursorInvisible();
         }
      } while (resultado == -1);

      limpiaConsola();
        
      if (resultado == 1) {
         defensor->nBarcosVivos--;
         defensor->nBarcosHundidos++;
         resultadoTiro(1, 2, 10);
      } else {
         resultadoTiro(0, 2, 10);
      }

      desplegarTableros(*propio, *enemigo, atacante, defensor);
        
      printf("\nPresiona ENTER para continuar...");
      cursorVisible();
      while (getchar() != '\n'); 
      getchar();
      cursorInvisible();

      if (j1->nBarcosVivos == 0 || j2->nBarcosVivos == 0)
         break;

      if (atacante == j1) {
         atacante = j2; defensor = j1; propio = t2; enemigo = t1;
      } else {
         atacante = j1; defensor = j2; propio = t1; enemigo = t2;
      }
   }
}
