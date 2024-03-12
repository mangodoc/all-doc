## 链表
链表有`单链表`、`双链表`和`环形链表`等。

* 单链表

![](https://res.meiflower.top/alg/linktable/01.png)

* 双链表

![](https://res.meiflower.top/alg/linktable/02.png)

* 环形链表

<img src="https://res.meiflower.top/alg/linktable/03.png" style="width:400px">

### 优点  
1. 灵活分配内存空间。
2. 能在`O(1)`删除或添加元素。
### 缺点
1. 查询元素需要`O(n)`时间。

### 技巧
* 快慢指针（`slow`走一步，`fast`走2步）
* 虚假链表头

## 实战
### K 个一组翻转链表
* 题目难度：困难
* [源码地址](https://gitee.com/mgang/leet-code/blob/master/java/src/main/java/com/mango/leet/code/hard/LC25.java)
``` java
package com.mango.leet.code.hard;

/**
 * 25. K 个一组翻转链表
 */
/**
 * 给你一个链表，每 k 个节点一组进行翻转，请你返回翻转后的链表。
 *
 * k 是一个正整数，它的值小于或等于链表的长度。
 *
 * 如果节点总数不是 k 的整数倍，那么请将最后剩余的节点保持原有顺序。
 *
 * 进阶：
 *
 * 你可以设计一个只使用常数额外空间的算法来解决此问题吗？
 * 你不能只是单纯的改变节点内部的值，而是需要实际进行节点交换。
 *  
 *
 * 示例 1：
 *
 *
 * 输入：head = [1,2,3,4,5], k = 2
 * 输出：[2,1,4,3,5]
 * 示例 2：
 *
 *
 * 输入：head = [1,2,3,4,5], k = 3
 * 输出：[3,2,1,4,5]
 * 示例 3：
 *
 * 输入：head = [1,2,3,4,5], k = 1
 * 输出：[1,2,3,4,5]
 * 示例 4：
 *
 * 输入：head = [1], k = 1
 * 输出：[1]
 * 提示：
 *
 * 列表中节点的数量在范围 sz 内
 * 1 <= sz <= 5000
 * 0 <= Node.val <= 1000
 * 1 <= k <= sz
 *
 *
 * 来源：力扣（LeetCode）
 * 链接：https://leetcode-cn.com/problems/reverse-nodes-in-k-group
 * 著作权归领扣网络所有。商业转载请联系官方授权，非商业转载请注明出处。
 */
public class LC25 {
    //Definition for singly-linked list.
    class ListNode {
      int val;
      ListNode next;
      ListNode() {}
      ListNode(int val) { this.val = val; }
      ListNode(int val, ListNode next) { this.val = val; this.next = next; }
    }
    class Solution {
        public ListNode reverseKGroup(ListNode head, int k) {
            ListNode prev = null;
            ListNode curr = head;
            int len = 0;
            // 后移动
            while (curr != null){
                len ++;
                curr = curr.next;
            }
            // 长度小于k时，直接返回原链表
            if(len < k){
                return head;
            }
            curr = head;
            // 遍历
            ListNode next = null;
            int n = k;
            while(curr != null && n-- > 0){
                next = curr.next;
                curr.next = prev;
                prev = curr;
                curr = next;
            }
            // 递归翻转
            ListNode partPrev = reverseKGroup(curr,k);
            // 整合2部分链表
            head = prev;
            while (prev.next != null){
                prev = prev.next;
            }
            prev.next = partPrev;
            return head;
        }
    }
}
/**
 * 2022-03-02
 * 思路：
 * 1. 判断链表长度len,如果len<k则直接返回链表，不需要翻转
 * 2. 翻转链表的k个元素，得到prev和curr 2个断开的链表
 * 3. 将curr指向的后续链表递归翻转整合得到partPrev
 * 4. 将翻转好的prev和partPrev2个链表整合后返回
 */
```

### 删除排序链表中的重复元素
* 题目难度：简单
* [源码地址](https://gitee.com/mgang/leet-code/blob/master/java/src/main/java/com/mango/leet/code/easy/LC83_RemoveDuplicatesSortedList.java)

``` java
package com.mango.leet.code.easy;

/**
 * 83. 删除排序链表中的重复元素
 */
/**
 * 给定一个已排序的链表的头 head ， 删除所有重复的元素，使每个元素只出现一次 。返回 已排序的链表 。
 *
 *  
 *
 * 示例 1：
 *
 *
 * 输入：head = [1,1,2]
 * 输出：[1,2]
 * 示例 2：
 *
 *
 * 输入：head = [1,1,2,3,3]
 * 输出：[1,2,3]
 *  
 *
 * 提示：
 *
 * 链表中节点数目在范围 [0, 300] 内
 * -100 <= Node.val <= 100
 * 题目数据保证链表已经按升序 排列
 *
 * 来源：力扣（LeetCode）
 * 链接：https://leetcode-cn.com/problems/remove-duplicates-from-sorted-list
 * 著作权归领扣网络所有。商业转载请联系官方授权，非商业转载请注明出处。
 */

/**
 * @Author: mango
 * @Date: 2022/4/1 10:40 下午
 */
public class LC83_RemoveDuplicatesSortedList {

     /* Definition for singly-linked list.*/
     public class ListNode {
          int val;
          ListNode next;
          ListNode() {}
          ListNode(int val) { this.val = val; }
          ListNode(int val, ListNode next) { this.val = val; this.next = next; }
     }

    class Solution {
         // 双指针法
        public ListNode deleteDuplicates(ListNode head) {
            if(head == null){
                return head;
            }
            ListNode p1 = head;
            ListNode p2 = head.next;
            while(true){
                while(p2!=null && p1.val == p2.val){
                    p2 = p2.next;
                }
                p1.next = p2;
                p1 = p1.next;
                // 到结尾了，则退出
                if(p2 == null){
                    break;
                }
                p2 = p2.next;
            }
            return head;
        }
    }
}
```