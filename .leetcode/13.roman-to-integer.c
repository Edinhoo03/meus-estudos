/*
 * @lc app=leetcode id=13 lang=c
 *
 * [13] Roman to Integer
 */

// @lc code=start

int valor(char c) {
    switch (c) {
        case 'I': return 1;
        case 'V': return 5;
        case 'X': return 10;
        case 'L': return 50;
        case 'C': return 100;
        case 'D': return 500;
        case 'M': return 1000;
        default: return 0;
    } 
}

int romanToInt(char* s) {
    int total = 0;
    int tamanho = 0;
    while (s[tamanho] != '\0') {
        tamanho++;
    }
    


    for (int i = 0 ; s[i]; i++)
    {
        int atual = s[i];
        int proximo = s[i+1];

        if (valor(atual) < valor(proximo))
        {
            total -= valor(atual);
        }
        else
        {
            total += valor(atual);
        }
        
    }
    
    
    return total;
}


// @lc code=end

