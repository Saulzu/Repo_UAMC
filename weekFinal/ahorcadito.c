#include <stdio.h>
#include <stdlib.h>  
#include <time.h>
#include <string.h> 

void cargarPalabra(char palabraSecreta[]) {
    srand(time(NULL));

    FILE* archivo;
    archivo=fopen("palabras.txt","r");

    int numero = rand() % 10; 
    for (int i = 0; i < numero; i++)
    {
        fscanf(archivo, "%s", palabraSecreta);
    }
    printf("Palabra: %s", palabraSecreta);
    fclose();
}

void prepararProgreso(int descubiertas[], int numLetras){
    
    descubiertas[numLetras];
    for (int i = 0; i < numLetras; i++) {
        descubiertas[i] = 0; 
    }

}

void jugar(char palabraSecreta[],char descubiertas[]){
    int intentos=0;
    /* while(intentos<6){
        for (int i = 0; i < ; i++)
        {
            code 
        }
    printf("%d", descubiertas[])

    }
    */
}

int main() {
    char palabraSecreta[50];
    cargarPalabra(palabraSecreta);
    
    int numLetras = strlen(palabraSecreta);
    prepararProgreso(palabraSecreta, numLetras);
    return 0;
}