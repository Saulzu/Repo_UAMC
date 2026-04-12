
#ifndef BATALLA_TIPOS_H
#define BATALLA_TIPOS_H

// Códigos de color para la consola (256 colores)
#define BLANCO 255
#define ROJO 196
#define VERDE 46

// Esta enumeración pone disponibles constantes que podemos usar en nuestro
// código para hacerlo más claro.
// Estas constantes servirán para poner los valores que viven en nuestro tablero.
typedef enum {
   CASILLA_VACIA,
   BARCO_OCULTO,
   BARCO_HUNDIDO,
   TIRO_CAIDO
} EdoCasilla;

// Una enumeración asigna un alias a los códigos enteros de los colores.
// El tipo de dato GameMode puede tomar uno de los tres valores que definen
// quiénes serán los dos jugadores.
typedef enum {
   PLAYER_CPU, 
   PLAYER_PLAYER, 
   CPU_CPU
} GameMode;

// El tipo de dato Dificultad define el nivel de dificultad.
typedef enum {
   FACIL,
   NORMAL,
   DIFICIL
} NivelDificultad;

// Tipo de dato que representa un jugador y sus datos.
typedef struct {
   int nBarcosTotal;    //Barcos inciales
   int nBarcosVivos;    //Barcos NO hundidos.
   int nBarcosHundidos; //Barcos hundidos.
   char emoji[5];       //Si es necesario, el emoji.
   char nombre[50];
} Jugador;

// Define el tipo de dato Tablero.
typedef struct {
   int numRens;
   int numCols;
   int totalBarcos; // Número de barcos al inicio.
   int** array; // Este campo es un arreglo 2D dinámico que se crea con malloc.
} Tablero;


// El tipo de dato Dificultad define el nivel de dificultad del juego.
typedef struct {
   // Quiénes serán los dos jugadores de la partida.
   GameMode modo; 

   // Dificultad del juego (número de barcos.)
   NivelDificultad dificultad;

   // Ancho y altura del tablero de ambos jugadores.
   int anchoTablero;
   int alturaTablero;

   // Número de barcos iniciales de cada jugador.
   int numBarcos;
} GameSettings;


#endif /* BATALLA_TIPOS_H */
