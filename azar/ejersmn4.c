#include <stdio.h>
#include <stdlib.h>
#include <math.h>

int azar(int min, int max) {
    int num;
    num = min + rand() % (max-min+1);
    return num;
}

int main() {
    srand (time(NULL)); 
    int dado1, dado2, n, v = 0;
    printf("Cuantas veces quieres lanzar los dados? ");
    scanf("%d", &n);
    for(int i = 0; i < n; i++) {

        dado1 = azar(1, 6);
        dado2 = azar(1, 6);
        if (dado1 == 6 && dado2 == 6)
            v ++;
        else 
            printf("Dado 1: %d, Dado 2: %d\n", dado1, dado2);
    }

    printf("Veces que se fue doble 6: %d\n", v);
}