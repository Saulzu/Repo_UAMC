import java.util.Scanner;

public class Estudiante{
    private String nombre;
    private String materia;
    private int trimestres;
    private double calificaciones[] = new double[5]; 

    public void regisEstudiante(Scanner leer) {
        System.out.print("Ingrese el nombre del estudiante: ");
        nombre = leer.nextLine();
        
        System.out.print("Ingrese la materia: ");
        materia = leer.nextLine();
        
        System.out.print("Ingrese la cantidad de trimestres: ");
        trimestres = leer.nextInt();

        System.out.println("Ingrese las 5 calificaciones:");
        for (int i = 0; i < 5; i++) {
            System.out.print(" Calificacion " + (i + 1) + ": ");
            calificaciones[i] = leer.nextDouble();
        }
    }

    private double calcularPromedio() {
        double suma = 0;
        for (int i = 0; i < 5; i++) {
            suma += calificaciones[i];
        }
        return suma / 5.0;
    }

    public void imprimirReporte() {
        System.out.println("\nREPORTE DEL ALUMNO:");
        System.out.println("Estudiante: " + this.nombre);
        System.out.println("Materia:    " + this.materia);
        System.out.println("Trimestres: " + this.trimestres);
        System.out.println("Promedio:   " + calcularPromedio());
    }

    public static void main(String[] args) {
        Scanner leer = new Scanner(System.in);
            
        Estudiante alumno = new Estudiante();
        alumno.regisEstudiante(leer);
        alumno.imprimirReporte();
    }
}
