/*
 * @lc app=leetcode id=2 lang=c
 *
 * [2] Add Two Numbers
 */

#include <stdlib.h>

struct ListNode {
    int val;
    struct ListNode *next;
};

// @lc code=start
/**
 * Definition for singly-linked list.
 * struct ListNode {
 *     int val;
 *     struct ListNode *next;
 * };
 */


struct ListNode* addTwoNumbers(struct ListNode* l1, struct ListNode* l2) {
    int carry = 0;

    struct ListNode* dummy = (struct ListNode*)malloc(sizeof(struct ListNode));

    struct ListNode* current = dummy;
    

    while (l1 != NULL || l2 != NULL || carry != 0)
    {
        
        int val1 = (l1 != NULL) ? l1->val : 0;
        int val2 = (l2 != NULL) ? l2->val : 0;
        int sum = val1 + val2 + carry;
        int digit = sum%10;
        carry = sum/10;

        struct ListNode* newNode = (struct ListNode*)malloc(sizeof(struct ListNode));

        newNode->val = digit;
        newNode->next = 0;
        current->next = newNode;
        current = newNode;
        
        if(l1 != NULL) l1 = l1->next;
        if(l2 != NULL) l2 = l2->next;
    }
    
    struct ListNode* result = dummy->next;
    free(dummy);
    return result;

    return result;

}
// @lc code=end

