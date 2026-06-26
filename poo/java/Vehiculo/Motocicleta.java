package Vehiculo;

public class Motocicleta extends Vehiculo {
    private int cilindrada;

    public Motocicleta(String marca, String modelo, int anio, int cilindrada) {
        super(marca, modelo, anio);
        this.cilindrada = cilindrada;
    }

    @Override
    public double calcularCostoServicio() {
        double costoBase = 800.0;
        return costoBase + (this.cilindrada * 1.5);
    }
}