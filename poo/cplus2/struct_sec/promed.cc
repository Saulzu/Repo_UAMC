#include <iostream>
#include <string>
using namespace std;

class Estudiante {
private:
    string nombre;
    string materia;
    int trimestres;
    double calif[];

public:
    void regisEstudiante() {
        cout << "Ingrese el nombre del estudiante: ";
        getline(cin, nombre);
        
        cout << "Ingrese la materia: ";
        getline(cin, materia);
        
        cout << "Ingrese la cantidad de trimestres: ";
        cin >> trimestres;

        cout << "Ingrese las 5 calificaciones:\n";
        for (int i = 0; i < 5; i++) {
            cout << " Calificacion " << (i + 1) << ": ";
            cin >> calif[i];
        }
    }

    double calcularPromedio() {
        double suma = 0;
        for (int i = 0; i < 5; i++) {
            suma += calif[i];
        }
        return suma / 5.0;
    }

    void imprimirReporte() {
        cout << "\nREPORTE DEL ALUMNO:" << endl;
        cout << "Estudiante: " << nombre << endl;
        cout << "Materia:    " << materia << endl;
        cout << "Trimestres: " << trimestres << endl;
        cout << "Promedio:   " << calcularPromedio() << endl;
    }
};

int main() {
    Estudiante alumno;
    alumno.regisEstudiante();
    alumno.imprimirReporte();
    return 0;
}