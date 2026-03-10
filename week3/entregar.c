#include <stdio.h>
#include <math.h>

int main() {
    int dia1, mes1, an1, dia2, mes2, an2, dif = 0;
    int dia1_orig, mes1_orig, an1_orig;

    printf("Dame la fecha inicial en formato dd/mm/aaaa: ");
    scanf("%d/%d/%d", &dia1, &mes1, &an1);
    printf("Dame la fecha final en formato dd/mm/aaaa: ");
    scanf("%d/%d/%d", &dia2, &mes2, &an2);

    dia1_orig = dia1;
    mes1_orig = mes1;
    an1_orig = an1;

    while (an1 < an2 || mes1 < mes2 || dia1 < dia2) {
        dif++;
        dia1++;
        
        // Calculamos los días del mes actual.
        int diasMes;
        if ((mes1 <= 7 && mes1 % 2 == 0) || (mes1 > 7 && mes1 % 2 != 0))
            diasMes = 30;
        else
            diasMes = 31;

        // Si el mes es febrero
        if (mes1 == 2) {
            diasMes = 28;

            if ((an1 % 4 == 0 && !(an1 % 100 == 0)) || (an1 % 400 == 0))
                diasMes = 29;
        }
        // Verificamos si el día excede los días del mes.
        if (dia1 > diasMes) {
            dia1 = 1;
            mes1++;

            // Si el mes excede 12, aumentamos el año y reiniciamos el mes.
            if (mes1 > 12) {
                mes1 = 1;
                an1++;
            }
        }
    }
    printf("Entre %d/%d/%d y %d/%d/%d hay %d días.\n", dia1_orig, mes1_orig, an1_orig, dia2, mes2, an2, dif);
    
    return 0;
}

