#include <iostream>

using namespace std;

class Angulo {
private:
    double radianes;

public:
    void leerAngulo() {
        cout << "Ingrese el angulo en radianes: ";
        cin >> radianes;
    }

    void printAngulo() {
        cout << "El angulo introducido es: " << radianes << " radianes" << endl;
    }
};

int main() {
    Angulo ang;
    ang.leerAngulo();
    ang.printAngulo();
    return 0;
}