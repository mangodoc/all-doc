## 双端队列 / Deque

![](https://mg.meiflower.top/oss/alg/ds/queue/deque.png)

### 特点
* 队列的头尾两端都能在O(1)的时间内进行数据查看、添加和删除
* 可以用一个双链表实现

### 常用的场景
实现一个长度动态变化的窗口或者连续区间

## 实战
### 滑动窗口最大值
```java 
package com.mango.leet.code.hard;

/**
 * 239. 滑动窗口最大值
 */

import java.util.*;

/**
 * 给你一个整数数组 nums，有一个大小为 k 的滑动窗口从数组的最左侧移动到数组的最右侧。你只可以看到在滑动窗口内的 k 个数字。滑动窗口每次只向右移动一位。
 *
 * 返回 滑动窗口中的最大值 。
 *
 *  
 *
 * 示例 1：
 *
 * 输入：nums = [1,3,-1,-3,5,3,6,7], k = 3
 * 输出：[3,3,5,5,6,7]
 * 解释：
 * 滑动窗口的位置                最大值
 * ---------------               -----
 * [1  3  -1] -3  5  3  6  7       3
 *  1 [3  -1  -3] 5  3  6  7       3
 *  1  3 [-1  -3  5] 3  6  7       5
 *  1  3  -1 [-3  5  3] 6  7       5
 *  1  3  -1  -3 [5  3  6] 7       6
 *  1  3  -1  -3  5 [3  6  7]      7
 * 示例 2：
 *
 * 输入：nums = [1], k = 1
 * 输出：[1]
 *  
 *
 * 提示：
 *
 * 1 <= nums.length <= 105
 * -104 <= nums[i] <= 104
 * 1 <= k <= nums.length
 *
 *
 * 来源：力扣（LeetCode）
 * 链接：https://leetcode-cn.com/problems/sliding-window-maximum
 * 著作权归领扣网络所有。商业转载请联系官方授权，非商业转载请注明出处。
 */
public class LC239 {
    public static void main(String[] args) {
        int[] nums = new int[]{1,3,-1,-3,5,3,6,7};
        //int[] nums = new int[]{1,3,1,2,0,5};
        //int[] nums = new int[]{7,2,4};
        System.out.println(Arrays.toString(new Solution().maxSlidingWindow(nums,3)));
    }

    static class Solution {
        /**
         *  * 输入：nums = [1,3,-1,-3,5,3,6,7], k = 3
         *  * 输出：[3,3,5,5,6,7]
         */
        public int[] maxSlidingWindow(int[] nums, int k) {
            // 结果数组
            int[] result = new int[nums.length - k + 1];
            // 双端队列
            Deque<Integer> deque = new LinkedList<>();
            for(int i=0;i<nums.length;i++){
                // 如果队列尾值下标的值小于当前数组下标的值，则将尾值下标从双端队列中移除
                while (!deque.isEmpty() && nums[deque.peekLast()] < nums[i]){
                    deque.pollLast();
                }
                // 将当前下标加入到尾部（有可能是最大值下标，也有可能是下一个最大值下标）
                deque.addLast(i);
                // 如果双端队列中记录的最大值下标，超过了滑动窗口的值范围，则移除掉
                if(deque.peekFirst() <= i-k){
                    deque.pollFirst();
                }
                // 给result赋值当前双端队列中记录下标的最大值
                if(i >= k-1){
                    result[i-k+1] = nums[deque.peekFirst()];
                }

            }
            return result;
        }
    }
}
/**
 * 2022-03-03
 * 思路：
 * 利用双端队列存储最大值的下标，滑动窗口超出则移除过期值
 */

```
