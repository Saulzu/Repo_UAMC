import java.util.Scanner;

public class Angulos {
    private double radianes;

    public void leerAngulo(Scanner leer) {
        System.out.print("Ingrese el angulo en radianes: ");
        radianes = leer.nextDouble();
    }

    public void printAngulo() {
        System.out.println("El angulo introducido es: " + this.radianes + " radianes");
    }
    public static void main(String[] args) {
        Scanner leer = new Scanner(System.in);
            
        Angulos ang = new Angulos();
        ang.leerAngulo(leer);
        ang.printAngulo();
            
    }
}
