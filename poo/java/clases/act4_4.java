import java.util.Scanner;
public class act4_4 {

    public static void main(String[] args) {
        Scanner leer = new Scanner(System.in);
        int numero;

        System.out.print("Introduce un numero: ");
        numero = leer.nextInt();

        if (numero > 0) {
            System.out.println("El numero es positivo.");
        } else if (numero < 0) {
            System.out.println("El numero es negativo.");
        } else {
            System.out.println("El numero es cero.");
        }

        if (numero % 2 == 0) {
            System.out.println("El numero es par.");
        } else {
            System.out.println("El numero es impar.");
        }

    }
}
