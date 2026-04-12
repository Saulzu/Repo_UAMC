
#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <string.h>
#include "biblio_printconsola.h"


void printRenCol(int ren, int col, char* texto, int color) {
    printf("\e[38;5;%dm", color);
    printf("\e[%d;%dH", ren, col);
    printf("%s", texto);
    fflush(stdout);
}

void cursorInvisible() {
   printf("\e[?25l");
   fflush(stdout); 
}

void cursorVisible() {
    printf("\e[?25h");
    fflush(stdout);
}

void limpiaConsola() {
    printf("\e[2J"); 
    fflush(stdout);
}
