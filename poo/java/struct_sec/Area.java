import java.util.Scanner;

public class Area {
    private double base;
    private double altura;

    public void pedirDatos(Scanner leer) {
        System.out.print("Ingrese la base del triangulo: ");
        base = leer.nextDouble();
        System.out.print("Ingrese la altura del triangulo: ");
        altura = leer.nextDouble();
    }

    public double calcularArea() {
        return (base * altura) / 2.0;
    }

    public void mostArea() {
        System.out.println("El area del triangulo es: " + calcularArea());
    }
    public static void main(String[] args) {
        Scanner leer = new Scanner(System.in);
        
        Area t = new Area();
        t.pedirDatos(leer);
        t.mostArea();
        
    }
}
