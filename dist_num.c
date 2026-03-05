#include <stdio.h>
#include <limits.h>
#include <stdlib.h>

int main() {
    int N = 7;
    int A [7] = {5, 7, 2, 3, 9, 1, 4};

    
    int dif = 0, dmenor = INT_MAX;
    printf("Los numeros del arreglo son:");
    for (int j = 0; j < 7; j++) {
        printf(" %d", A[j]);
    }

    for (int i = 0; i < N; i++){
        for(int j = i+1; j < N; j++){
            dif = abs(A[i] - A[j]);
            if (dif < dmenor){ dmenor = dif;}
        }
    }
    printf("\nLa diferencia menor es: %d\n", dmenor);

    return 0;
}