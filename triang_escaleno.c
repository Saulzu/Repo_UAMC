#include <stdio.h>

int main() {
    int R = 5;

    for(int r = 1; r<=R; r++){
        for (int s = 1; s <=R-r; s++)
        {
            printf(" ");
        }
        for (int a = 1; a <= r; a++)
        {
            printf("*");
        }
         printf("\n");
    }
    return 0;
}