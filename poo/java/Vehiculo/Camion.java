package Vehiculo;

public class Camion extends Vehiculo {
    private double capacidadToneladas;

    public Camion(String marca, String modelo, int anio, double capacidadToneladas) {
        super(marca, modelo, anio);
        this.capacidadToneladas = capacidadToneladas;
    }

    @Override
    public double calcularCostoServicio() {
        double costoBase = 5000.0; 
        return costoBase + (this.capacidadToneladas * 450.0);
    }
}