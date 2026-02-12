/*
 * @lc app=leetcode id=14 lang=c
 *
 * [14] Longest Common Prefix
 */

// @lc code=start
char* longestCommonPrefix(char** strs, int strsSize) {
    if (strsSize == 0)
    {
        return "";
    }
    
    int prefixLen = strlen(strs[0]);
    
    for (int i = 1; i < strsSize; i++) {
        for (int j = 0; j < prefixLen; j++)
        {
            if (strs[0][j] != strs [i][j])
            {
                strs[0][j] = '\0';
                prefixLen = j;
                if (prefixLen == 0) return "";
                break;
            }
        }

    }

    return strs[0];
}
    
// @lc code=end

