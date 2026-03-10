#include <stdio.h>

int main() 
{
        float Peso, Altura;
        printf("Introduce tu Peso:");
        scanf("%f", &Peso);
        printf("Introduce tu Altura:");
    scanf("%f", &Altura);
    float ideal = 0.0;
    float IMC = Peso / ((Altura)*(Altura));
    if (IMC<25) {
        ideal = 25 - IMC ;
        printf("Debe subir %f kg", ideal);
    }
    else {
        ideal = IMC - 25 ;
        printf("Debes bajar %f kg", ideal);
    }
    return 0;
    
}