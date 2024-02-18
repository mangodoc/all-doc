## 字符串和数组
字符串本质是字符数组。
### 优点
1. 构建简单
2. 通过下标查询某个元素O(1)
### 缺点
1. 空间连续
2. 查找元素是否存在、删除元素和添加元素耗时O(n)

## LC242题：有效的字母异位词
* 题目难度：简单
* [源码地址](https://gitee.com/mgang/leet-code/blob/master/java/src/main/java/com/mango/leet/code/easy/LC242_ValidAnagram.java)

``` java
package com.mango.leet.code.easy;

/**
 * 242. 有效的字母异位词
 */
/**
 * 给定两个字符串 s 和 t ，编写一个函数来判断 t 是否是 s 的字母异位词。
 *
 * 注意：若 s 和 t 中每个字符出现的次数都相同，则称 s 和 t 互为字母异位词。
 *
 *  
 *
 * 示例 1:
 *
 * 输入: s = "anagram", t = "nagaram"
 * 输出: true
 * 示例 2:
 *
 * 输入: s = "rat", t = "car"
 * 输出: false
 *  
 *
 * 提示:
 *
 * 1 <= s.length, t.length <= 5 * 104
 * s 和 t 仅包含小写字母
 *  
 *
 * 进阶: 如果输入字符串包含 unicode 字符怎么办？你能否调整你的解法来应对这种情况？
 *
 * 来源：力扣（LeetCode）
 * 链接：https://leetcode-cn.com/problems/valid-anagram
 * 著作权归领扣网络所有。商业转载请联系官方授权，非商业转载请注明出处。
 */
public class LC242_ValidAnagram {

    class Solution {
        public boolean isAnagram(String s, String t) {
            if(s.length() != t.length()){
                return false;
            }
            int[] arr = new int[26];
            char[] ss = s.toCharArray();
            char[] tt = t.toCharArray();
            for(int i=0;i<ss.length;i++){
                int si = ss[i] - 'a';
                int ti = tt[i] - 'a';
                arr[si] ++;
                arr[ti] --;
            }
            for(int i=0;i<26;i++){
                if(arr[i] != 0){
                    return false;
                }
            }
            return true;
        }
    }
}
/**
 * 2022-03-01
 * 思路：
 * 定义一个长度26的数组A，s里的字符往数组下标里加1，t里的字符往数组下标里减1；
 * 最后检查数组A里数值全部为0，则说明s和t是字母异位词。
 */

```