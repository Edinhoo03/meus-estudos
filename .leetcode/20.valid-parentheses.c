/*
 * @lc app=leetcode id=20 lang=c
 *
 * [20] Valid Parentheses
 */

// @lc code=start
bool isValid(char* s) {
    int len = strlen(s);

    if (len % 2 != 0) return 0;
    
    char stack[10001];
    int top = 0;
    
    for (int i = 0; i < len; i++)
    {
        if (s[i] == '(' || s[i] == '[' || s[i] == '{') 
        {
            stack[top] = s[i];
            top++;
        }
        else {
            if (top == 0) return 0;

            char topo = stack[--top];
            if (s[i] == ')' && topo != '(') return false;
            if (s[i] == ']' && topo != '[') return false;
            if (s[i] == '}' && topo != '{') return false;
        }
    }
    return top == 0;
}
// @lc code=end

