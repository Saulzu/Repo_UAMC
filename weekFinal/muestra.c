#include <stdio.h>
#include <stdlib.h>  
#include <time.h>
#include <string.h> 

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

int main() {
    srand(time(NULL));
    int size1 = 10;
    int size2 = 15;
    
    int muestra1[size1];
    int muestra2[size2];

    muestraAzar(muestra1, size1);
    printf("Muestra de tamaño: %d = [", size1);
        for (int i = 0; i < size1; i++) {
            printf("%d,", muestra1[i]);
        }
    printf("]\n");

    muestraAzar(muestra2, size2);
    printf("Muestra de tamaño: %d = [", size2);
        for (int i = 0; i < size2; i++) {
            printf("%d,", muestra2[i]);
        }
    printf("]\n");

    return 0;
}