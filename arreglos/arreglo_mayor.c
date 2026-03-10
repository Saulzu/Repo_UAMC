#include <stdio.h>

int main() {
    int nums [7] = {0};
    
    int mayor = nums[0];
    for (int i = 1; i < 8; i++) {
        printf("Ingrese un numero entero: \n");
        scanf("%d", &nums[i]);
        
        if (nums[i] > mayor) {
            mayor = nums[i];
        }
    }
    printf("El mayor valor es: %d\n", mayor);
}