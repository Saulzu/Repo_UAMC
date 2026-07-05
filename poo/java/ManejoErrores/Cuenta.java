public class Cuenta {
    private String numCt;
    private double saldo;
    private String estado;

    public Cuenta(String numCt, double saldoIn) {
        this.numCt = numCt;
        this.saldo = saldoIn;
        this.estado = "ACTIVA";
    }

    public String getNumCt() { return numCt; }
    public double getSaldo() { return saldo; }
    public String getEstado() { return estado; }

    public void activar() {
        estado = "ACTIVA";
        System.out.println("[INFO] Cuenta " + numCt + " ha sido ACTIVADA.");
    }
    public void suspender() {
        estado = "SUSPENDIDA";
        System.out.println("[ALERTA] Cuenta " + numCt + " ha sido SUSPENDIDA por sospecha de fraude.");
    }
    public void cancelar() {
        estado = "CANCELADA";
        System.out.println("[INFO] Cuenta " + numCt + " ha sido CANCELADA definitivamente.");
    }

    private void verificarEstado() throws BancoException.CuentaBloqueadaException, BancoException {
        if (estado.equals("SUSPENDIDA")) {
            throw new BancoException.CuentaBloqueadaException("Operación rechazada: La cuenta " + numCt + " está bloqueada por fraude.");
        }
        if (estado.equals("CANCELADA")) {
            throw new BancoException("Operación rechazada: La cuenta " + numCt + " está totalmente cancelada e inactiva.");
        }
    }

    public void depositar(double monto) throws BancoException {
        verificarEstado();
        saldo += monto;
        System.out.println("Depósito exitoso de $" + monto + " en cuenta " + numCt + ". Nuevo saldo: $" + saldo);
    }

    public void retirar(double monto) throws BancoException.SaldoInsuficienteException, BancoException.CuentaBloqueadaException, BancoException {
        verificarEstado();
        if (monto > saldo) {
            throw new BancoException.SaldoInsuficienteException("Fondos insuficientes en cuenta " + numCt + ". Saldo actual: $" + saldo + ", Intento: $" + monto);
        }
        saldo -= monto;
        System.out.println("Retiro exitoso de $" + monto + " de la cuenta " + numCt + ". Nuevo saldo: $" + saldo);
    }

    public void transferir(Cuenta destino, double monto) throws BancoException.SaldoInsuficienteException, BancoException.CuentaBloqueadaException, BancoException {
        System.out.println("Iniciando transferencia de $" + monto + " desde " + numCt + " hacia " + destino.getNumCt());
        
        this.retirar(monto);
        
        try {
            destino.depositar(monto);
        } catch (BancoException e) {
            this.saldo += monto;
            throw new BancoException("Transferencia fallida. Se devolvió el dinero a la cuenta origen. Razón de destino: " + e.getMessage());
        }
        
        System.out.println("¡Transferencia completada con éxito!");
    }
}