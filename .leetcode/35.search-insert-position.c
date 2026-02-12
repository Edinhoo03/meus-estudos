/*
 * @lc app=leetcode id=35 lang=c
 *
 * [35] Search Insert Position
 */

// @lc code=start
int searchInsert(int* nums, int numsSize, int target) {
    if (nums[numsSize/2] == target) return numsSize/2;
    

    if (target < nums[0]) return 0;
    
    if (nums[numsSize/2] < target)
    {
        for (int i = numsSize/2; i < numsSize; i++)
        {
            if (nums[i] == target)
            {
                return i;
            }

            if (nums[i] > target)
            {
                return i;
            }
            

        }
        
    }

    if (nums[numsSize/2] > target)
    {
        for (int i = numsSize/2; i>= 0; i--)
        {
            if (nums[i] == target)
            {
                return i;
            }

            if (nums[i] < target)
            {
                return i + 1;
            }

        } 
    }
    

    return numsSize;

    
}
// @lc code=end

