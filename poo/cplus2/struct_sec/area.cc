#include <iostream>

using namespace std;

class Area {
private:
    double base;
    double altura;

public:
    void leerDatos() {
        cout << "Ingrese la base del triangulo: ";
        cin >> base;
        cout << "Ingrese la altura del triangulo: ";
        cin >> altura;
    }

    double calcArea() {
        return (base * altura) / 2.0;
    }

    void mostArea() {
        cout << "El area del triangulo es: " << calcArea() << endl;
    }
};

int main() {
    Area t;
    t.leerDatos();
    t.mostArea();
    return 0;
}