#include <stdio.h>
#include <stdbool.h>

bool isPalindrome(int x) {
    int original = x;    
    int invertido = 0;
    
    if (x < 0) {
        return 0;
    }
    
    while (x > 0) {
        int digito = x % 10;
        invertido = invertido*10 + digito;
        x = x / 10;
    }

    return original == invertido;
}

int main() {
    printf("121: %s (esperado: true)\n", isPalindrome(121) ? "true" : "false");
    printf("-121: %s (esperado: false)\n", isPalindrome(-121) ? "true" : "false");
    printf("10: %s (esperado: false)\n", isPalindrome(10) ? "true" : "false");
    printf("0: %s (esperado: true)\n", isPalindrome(0) ? "true" : "false");
    return 0;
}
