#include <stdio.h>
#include <stdlib.h>

int main() {


    printf("\e[%d;%dH", 1, 15);
    //printf("%s", "hola");

    printf("%s", "😁");

    return 0;
}