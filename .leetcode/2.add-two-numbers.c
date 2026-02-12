/*
 * @lc app=leetcode id=2 lang=c
 *
 * [2] Add Two Numbers
 */

// @lc code=start
/**
 * Definition for singly-linked list.
 * struct ListNode {
 *     int val;
 *     struct ListNode *next;
 * };
 */
struct ListNode* addTwoNumbers(struct ListNode* l1, struct ListNode* l2) {
    unsigned long long numero_1 = 0;
    unsigned long long multiplicador = 1;  // 1, 10, 100, 1000...

    while (l1 != NULL) 
    {
        numero_1 += l1->val * multiplicador;
        multiplicador *= 10;
        l1 = l1->next;
    }

    unsigned long long numero_2 = 0;
    multiplicador = 1;
    while (l2 != NULL)
    {
        numero_2 += l2->val * multiplicador;
        multiplicador *= 10;
        l2 = l2->next;
    }

    unsigned long long total = numero_1 + numero_2;

    struct ListNode* dummy = malloc(sizeof(struct ListNode));
    struct ListNode* atual = dummy;

    do {
        struct ListNode* novoNo = malloc(sizeof(struct ListNode));
        novoNo->val = total % 10;    
        novoNo->next = NULL;
        
        atual->next = novoNo;
        atual = novoNo;
        
        total /= 10;                 
    } while (total > 0);

    return dummy->next;
}
// @lc code=end

