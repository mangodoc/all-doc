## 优先队列
本质是二叉堆（`Binary Heap`）的结构，利用一个数组结构来实现完全二叉树。

![](https://mg.meiflower.top/oss/alg/ds/queue/priority.png)

其中队列的优先级是可以自定义的。

### 特性
数组第一个元素`array[0]`优先级最高；
给定一个下标i，对于`array[i]`而言：
* 父节点下标： `(i-1)/2`
* 左侧节点下标：`2*i + 1`
* 右侧节点下标：`2*i + 2`

## 实战
### 前 K 个高频元素
``` java
package com.mango.leet.code.middle;

/**
 * 347. 前 K 个高频元素
 */

import java.util.*;

/**
 * 给你一个整数数组 nums 和一个整数 k ，请你返回其中出现频率前 k 高的元素。你可以按 任意顺序 返回答案。
 *
 *  
 *
 * 示例 1:
 *
 * 输入: nums = [1,1,1,2,2,3], k = 2
 * 输出: [1,2]
 * 示例 2:
 *
 * 输入: nums = [1], k = 1
 * 输出: [1]
 *  
 *
 * 提示：
 *
 * 1 <= nums.length <= 105
 * k 的取值范围是 [1, 数组中不相同的元素的个数]
 * 题目数据保证答案唯一，换句话说，数组中前 k 个高频元素的集合是唯一的
 *
 * 来源：力扣（LeetCode）
 * 链接：https://leetcode-cn.com/problems/top-k-frequent-elements
 * 著作权归领扣网络所有。商业转载请联系官方授权，非商业转载请注明出处。
 */
public class LC347 {
    public static void main(String[] args) {
        int[] nums = new int[]{1,1,2,2,3,3,3,3,3};
        System.out.println(Arrays.toString(new Solution().topKFrequent(nums,2)));
    }
    static class Solution {
        public int[] topKFrequent(int[] nums, int k) {
            // 1. 先计算出数字出现的次数，放到countMap里
            Map<Integer,Integer> countMap = new HashMap<>();
            for(int i=0;i<nums.length;i++){
                countMap.put(nums[i],countMap.getOrDefault(nums[i],0)+1);
            }
            // 2. 利用优先队列，自定义优先级为数字出现的频次
            Queue<Integer> queue = new PriorityQueue(new Comparator() {
                @Override
                public int compare(Object o1, Object o2) {
                    return countMap.get(o1) - countMap.get(o2);
                }
            });
            countMap.forEach((int1,int2)->{
                if(!queue.contains(int1)){
                    queue.offer(int1);
                }
            });
            // 3. 取优先队列的前k个数字返回
            int[] result = new int[k];
            for(int i=0;i<k;i++){
                result[i] = queue.poll();
            }
            return result;
        }
    }
}
/**
 * 2022-03-05
 * 思路：
 * 1. 先计算出数字出现的次数，放到countMap里
 * 2. 利用优先队列，自定义优先级为数字出现的频次
 * 3. 取优先队列的前k个数字返回
 */
```



