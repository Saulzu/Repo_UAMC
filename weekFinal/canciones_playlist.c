#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <time.h>

// Esta estructura define el tipo Tiempo.
typedef struct {
    int horas;
    int minutos;
    int segundos;
} Tiempo;

// Esta estructura define el tipo Canción.
#define MAX_TITULO 50
#define MAX_ARTISTA 50

typedef struct {
    char titulo[MAX_TITULO];
    char artista[MAX_ARTISTA];
    Tiempo duracion; // Duración en horas, minutos y segundos
    int calificacion; // Calificación de 1 a 5
} Cancion;

#define MAX_CANCIONES 15
// Función para inicializar una canción con los datos proporcionados.
// Argumentos:
// - cancion: Puntero a la canción que se va a inicializar.
// - titulo: Título de la canción.
// - artista: Artista de la canción.
// - duracion: Duración de la canción en formato Tiempo.
// - calificacion: Calificación de la canción (1 a 5).
void iniciaCancion(Cancion *cancion, const char *titulo, const char *artista, Tiempo duracion, int calificacion) {
    cancion->duracion = duracion;
    cancion->calificacion = calificacion;

    sprintf(cancion->titulo, titulo);
    sprintf(cancion->artista, artista);

    
    return;
}

// Función para inicializar una canción con datos aleatorios. 
// La función debe generar un título, un artista, una duración y una calificación aleatoria para la canción.
// Internamente se llama a la función iniciaCancion para asignar los valores generados a la canción. 
// Argumentos:
// - cancion: Puntero a la canción que se va a inicializar con datos aleatorios.
// Debemos pasar por referencia para modificar la canción original.
void randomizeCancion(Cancion *cancion) {
    char titulo1[4][20] = {"Susurros ", "Ecos ", "Ritmos ", "Sombras "};
    char titulo2[4][20] = {"que baila en ", "perdidos bajo ", "grabados en ", "ardiendo tras "};
    char titulo3[4][20] = {"la medianoche ", "el neón ", "el olvido ", "el horizonte "};

    char artista1[5][20] = {"Dante", "Zaira", "Benito", "Mila", "Enzo"};
    char artista2[5][20] = {" Velasco", "Soler", "Malta", "Nova", "Rivas"};   

    // Generar un título aleatorio combinando partes de los arrays de títulos
    char titulo[60];
    snprintf(titulo, sizeof(titulo), "%s%s%s",
    titulo1[rand() % 4],
    titulo2[rand() % 4],
    titulo3[rand() % 4]);
    
    printf("Título generado: %s\n", titulo); // Imprimir el título generado para verificar

    // Generar un artista aleatorio combinando partes de los arrays de artistas
    char artista[40];
    snprintf(artista, sizeof(artista), "%s%s",artista1[rand() % 5],artista2[rand() % 5]);
    printf("Artista generado: %s\n", artista); // Imprimir el artista generado para verificar
    // Inicializar la canción con los valores generados
    Tiempo duracion;
    int calificacion;
    duracion.horas = rand() % 2; // 0 o 1
    duracion.minutos = rand() % 60;
    duracion.segundos = rand() % 60;
    calificacion = rand() % 5 + 1; // 1 a 5

    iniciaCancion(cancion, titulo, artista, duracion, calificacion);
}

void printSong(Cancion song){
    printf("Titulo: %s\n", song.titulo);
    printf("Duracion: %02d:%02d:%02d\n", song.duracion.horas, song.duracion.minutos, song.duracion.segundos);  
}

int main(int argc, char const *argv[]){
    srand(time(NULL)); // Semilla para la generación de números aleatorios
    Cancion playlist[MAX_CANCIONES]; // Array de 15 canciones.

    // Inicializar cada canción en la playlist con datos aleatorios.
    for (int i = 0; i < MAX_CANCIONES; i++) {
        randomizeCancion(&playlist[i]);
    }

    // Imprimir los detalles de cada canción en la playlist.
    for (int i = 0; i < MAX_CANCIONES; i++) {
        printf("Canción %d:\n", i + 1);
        printf("Título: %s\n", playlist[i].titulo);
        printf("Artista: %s\n", playlist[i].artista);
        printf("Duración: %02d:%02d:%02d\n", playlist[i].duracion.horas, playlist[i].duracion.minutos, playlist[i].duracion.segundos);
        printf("Calificación: %d/5\n", playlist[i].calificacion);
        printf("\n");
    }
    // 1. Mostrar la canción con la calificación más alta.
    int maxCalif = 0;
    int ibest = 0;
    for(int i = 1; i < MAX_CANCIONES; i++){
        if(playlist[i].calificacion > maxCalif){
            maxCalif = playlist[i].calificacion;
            ibest = i;
        }
    }

    printSong(playlist[ibest]);
    // 2. Mostrar la duración total de la playlist sumando la duración de cada canción.

    Tiempo sumP = {0, 0, 0};
    for (int i = 0; i < MAX_CANCIONES; i++)
    {
        sumP.horas = sumP.horas + playlist[i].duracion.horas;
        sumP.minutos = sumP.minutos + playlist[i].duracion.minutos;
        sumP.segundos = sumP.segundos + playlist[i].duracion.segundos;
    }

    sumP.segundos = (sumP.segundos % 60);
    sumP.minutos = sumP.minutos + (sumP.segundos/60);
    sumP.horas = (sumP.horas) + (sumP.minutos / 60);
    sumP.minutos = sumP.minutos % 60;

    printf("\nDuración de la playlist: %02d:%02d:%02d\n", sumP.horas, sumP.minutos, sumP.segundos);
    
    // 3. Mostrar las canciones que tienen calificación mayor o igual a 4.
    for(int i = 1; i < MAX_CANCIONES; i++){
        if(playlist[i].calificacion >= 4){
            printSong(playlist[i]);
        }
    }

    // 4. Mostrar las canciones que tienen una duración mayor a 3 minutos y una calificación menor a 3.
    printf("Ejercicio 4");
    for(int i = 1; i < MAX_CANCIONES; i++){
        if((playlist[i].calificacion < 3) && ( playlist[i].duracion.minutos > 3)){
            printSong(playlist[i]);
        }
    }
    // 5. Mostrar todas las canciones de un artista específico (por ejemplo, "Dante Velasco").
    printf("\nCanciones de Dante Velasco; \n");
    for (int i = 1; i < MAX_CANCIONES; i++)
    {
        if(strcmp("Dante Velasco", playlist[i].artista) == 0){
            printSong(playlist[i]);
        } 
    }
    

    return 0;
} 