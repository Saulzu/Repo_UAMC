package Vehiculo;

public class Auto extends Vehiculo {
    private int numPuertas;

    public Auto(String marca, String modelo, int anio, int numPuertas) {
        super(marca, modelo, anio);
        this.numPuertas = numPuertas;
    }

    @Override
    public double calcularCostoServicio() {
        double costoBase = 1500.0;
        return costoBase + (this.numPuertas * 200.0);
    }
}