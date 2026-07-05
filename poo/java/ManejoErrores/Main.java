public class Main {
    public static void main(String[] args) {
        
        System.out.println("--- BIENVENIDO A BANCO QUIEBRA SA DE CV ---\n");

        Cuenta cuentaA = new Cuenta("CTA-523", 1500.00);
        Cuenta cuentaB = new Cuenta("CTA-268", 300.00);
        Cuenta cuentaC = new Cuenta("CTA-757", 5000.00);

        System.out.println("Saldos iniciales:");
        System.out.println("Cuenta A: " + cuentaA.getSaldo() + "Cuenta B: " + cuentaB.getSaldo() + "Cuenta C: " + cuentaC.getSaldo());
        
        System.out.println("--- 1. Retiros y Depósitos ---");
        try {
            cuentaA.depositar(500.00);  
            cuentaA.retirar(200.00);    
        } catch (BancoException.SaldoInsuficienteException e) {
            System.out.println("Fondo Insuficiente: " + e.getMessage());
        } catch (BancoException.CuentaBloqueadaException e) {
            System.out.println("Alerta de seguridad: " + e.getMessage());
        } catch (BancoException e) {
            System.out.println("No se pudo realizar la operación: " + e.getMessage());
        }
        System.out.println("\n-----------------------------------------\n");

        System.out.println("--- 2. Transferencias y Saldo Insuficiente ---");
        try {
            cuentaA.transferir(cuentaB, 800.00); 
            System.out.println();
            cuentaA.transferir(cuentaB, 4500.00); 
        } catch (BancoException.SaldoInsuficienteException e) {
            System.out.println("Transaccion rechazada: " + e.getMessage());
        } catch (BancoException e) {
            System.out.println("Error de sistema:" + e.getMessage());
        }
        System.out.println("\n-----------------------------------------\n");

        System.out.println("--- 3. Suspensión y Cuenta Bloqueada ---");        
        cuentaC.suspender();

        try {
            cuentaC.retirar(100.00);
        } catch (BancoException.CuentaBloqueadaException e) {
            System.out.println("Alerta de seguridad: " + e.getMessage());
        } catch (BancoException e) {
            System.out.println("Error de sistema:" + e.getMessage());
        }
        System.out.println("\n-----------------------------------------\n");

        System.out.println("--- 4. Activación y Cancelación ---");        
        cuentaC.activar();
        
        try {
            System.out.println("Intentando retirar tras reactivación...");
            cuentaC.retirar(1000.00);
            
            System.out.println("Cancelando cuenta...");
            cuentaC.cancelar();
            
            System.out.println("Intentando depositar en cuenta cancelada...");
            cuentaC.depositar(50.00); 
            
        } catch (BancoException e) {
            System.out.println("Operación denegada: " + e.getMessage());
        }
    }
}