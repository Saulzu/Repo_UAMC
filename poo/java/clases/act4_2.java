import java.util.Scanner;
public class act4_2 {
    public static void main(String[] args) {
        Scanner leer = new Scanner(System.in);
        
        int n1, n2, n3, promd;
        
        System.out.println("Introduce la primera calificación: ");
        n1 = leer.nextInt();
        System.out.println("Introduce la segunda calificación: ");
        n2 = leer.nextInt();
        System.out.println("Introduce la tercera calificación: ");
        n3 = leer.nextInt();

        promd = (n1 + n2 + n3) / 3;

        if(promd >= 6){
            System.out.println("El alumno aprobó");
        } else {
            System.out.println("El alumno reprobó");
        }

        System.out.println("El promedio es: " + promd);
    }
}