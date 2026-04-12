#include <stdio.h>

int cuadrado(int num) {
    return num*num;
}
void cuad_ref (int* num){
    *num = *num * *num;
}
int main(){
    int edad = 5;
    int res = cuadrado(edad);
    
    cuad_ref(&edad);


    printf("\n El resultado es: %d, ref res: %d", res, edad);


}