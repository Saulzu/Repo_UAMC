import java.util.Scanner; 

public class act4_3 {
    public static void main(String[] args) {
        Scanner leer = new Scanner(System.in);
        int n;

        System.out.print("Introduce un numero a multiplicar: ");
        n = leer.nextInt();

        for (int i = 1; i <= 10; i++) {
            System.out.println(n + " x " + i + " = " + (n * i));
        }

    }
}