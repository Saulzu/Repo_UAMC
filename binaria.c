#include <stdio.h>
#include <stdbool.h>

void sumaUno(int bin[], int sz) {
    bool carry = true; 
    for (int i = sz - 1; i >= 0 &&; i--) {
        if (bin[i] == 1) {
            bin[i] = 0;   
        } else {
            bin[i] = 1; 
            carry = false;
        }
    }


    printf("Resultado: ");
    for (int j = 0; j < sz; j++) {
        printf("%d", bin[j]);
    }
    printf("\n");
}

int main() {
    int sz = 4;
    int bin[] = {0, 0, 1, 0};

    printf("Bin: ");
    for (int j = 0; j < sz; j++) {
        printf("%d", bin[j]);
    }
    printf("\n");

    sumaUno(bin, sz);

    return 0;
}