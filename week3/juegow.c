#include <stdio.h>
#include <stdlib.h>
#include <math.h>

int azar(int min, int max) {
    int num;
    num = min + rand() % (max-min+1);
    return num;
}

int main() {
    int minUsr, maxUsr, numAzar, num, vd = 3;
    srand (time(NULL));

    printf("Introducir el valor minimo: ");
    scanf("%d", &minUsr);
    printf("Introducir el valor maximo: ");
    scanf("%d", &maxUsr);

    printf("Tienes %d intentos para adivinar el numero.\n", vd);

    numAzar = azar(minUsr, maxUsr);

    while(vd > 0) {
        printf("Adivina el numero entre %d y %d: ", minUsr, maxUsr);
        scanf("%d", &num);

        if(num == numAzar) {
            printf("Correcto. El numero era %d\n", numAzar);
            break;
        } else if(num > numAzar) {
            printf("Demasiado alto\n");
        } else {
            printf("Demasiado bajo\n");
        }
        vd--;
    }

        if(vd == 0) {
            printf("Has perdido. El numero era %d\n", numAzar);
        }
    return 0;
}