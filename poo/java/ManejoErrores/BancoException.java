
public class BancoException extends Exception {
    
    public BancoException(String mensaje) {
        super(mensaje);
    }

    public static class SaldoInsuficienteException extends BancoException {
        public SaldoInsuficienteException(String mensaje) {
            super(mensaje);
        }
    }

    public static class CuentaBloqueadaException extends BancoException {
        public CuentaBloqueadaException(String mensaje) {
            super(mensaje);
        }
    }
}
