#include <stdio.h>
#include <stdbool.h>

int main() {
    int nums [7] = {5, 7, 2, 3, 9, 1, 4};
    int flag = 1;
    
    int menor = nums[0];
    for (int j = 0; j < 7; j++) {
        printf("%d \n", nums[j]);
    }
    for (int i = 1; i < 7; i++) {
        if (nums[i] < menor) {
            menor = nums[i];
            flag = 1;
        } else {
            flag = 0;
            break;
        }
    }
    if(flag == 1) {
        printf("El arreglo esta ordenado de forma ascendente\n");
    } else {
        printf("El arreglo no esta de forma ascendente\n");
    }
    return 0;
}


ms-edu-secureassessment:https://onlinegdb.com/CtbYxZ25E#enforceLockdown