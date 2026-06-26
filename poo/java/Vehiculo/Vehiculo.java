package Vehiculo;
public abstract class Vehiculo implements Comparable<Vehiculo> {

    protected String marca;
    protected String modelo;
    protected int anio;

    public Vehiculo(String marca, String modelo, int anio) {
        this.marca = marca;
        this.modelo = modelo;
        this.anio = anio;
    }

    public abstract double calcularCostoServicio();

    public void mostrarInformacion() {
        System.out.println("Vehículo -> Marca: " + marca + ", Modelo: " + modelo + ", Año: " + anio);
    }


    @Override
    public int compareTo(Vehiculo otro) {
        return Double.compare(this.calcularCostoServicio(), otro.calcularCostoServicio());
    }

}