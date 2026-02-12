/*
 * @lc app=leetcode id=9 lang=c
 *
 * [9] Palindrome Number
 */

// @lc code=start
bool isPalindrome(int x) {
    long original = x;    
    long invertido = 0;
    
    if (x < 0)
    {
        return 0;
    }
    
    while (x > 0) {
        int digito = x % 10;
        
        invertido = invertido*10 + digito;
        
        
        x = x / 10;
    }

    return original == invertido;
}



