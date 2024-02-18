## 栈Stack
* 特点：后进先出（LIFO）

出栈入栈都是O(1)内完成

可以用一个单链表或者数组来实现

## 实战
### 有效的括号
* 题目难度：简单
* [源码地址](https://gitee.com/mgang/leet-code/blob/master/java/src/main/java/com/mango/leet/code/easy/LC20_ValidParentheses.java)

``` java
package com.mango.leet.code.easy;

/**
 * 20. 有效的括号
 */

import java.util.Stack;

/**
 * 给定一个只包括 '('，')'，'{'，'}'，'['，']' 的字符串 s ，判断字符串是否有效。
 *
 * 有效字符串需满足：
 *
 * 左括号必须用相同类型的右括号闭合。
 * 左括号必须以正确的顺序闭合。
 *  
 *
 * 示例 1：
 *
 * 输入：s = "()"
 * 输出：true
 * 示例 2：
 *
 * 输入：s = "()[]{}"
 * 输出：true
 * 示例 3：
 *
 * 输入：s = "(]"
 * 输出：false
 * 示例 4：
 *
 * 输入：s = "([)]"
 * 输出：false
 * 示例 5：
 *
 * 输入：s = "{[]}"
 * 输出：true
 *  
 *
 * 提示：
 *
 * 1 <= s.length <= 104
 * s 仅由括号 '()[]{}' 组成
 *
 * 来源：力扣（LeetCode）
 * 链接：https://leetcode-cn.com/problems/valid-parentheses
 * 著作权归领扣网络所有。商业转载请联系官方授权，非商业转载请注明出处。
 */
public class LC20_ValidParentheses {

    public static void main(String[] args) {
        System.out.println((int)'(');
        System.out.println((int)')');
        System.out.println((int)'{');
        System.out.println((int)'}');
        System.out.println((int)'[');
        System.out.println((int)']');
        System.out.println(new Solution().isValid("(){}}{"));
    }

    static class Solution {
        public boolean isValid(String s) {
            Stack<Character> stack = new Stack();
            for(int i=0;i<s.length();i++){
                if(stack.isEmpty()){
                    stack.push(s.charAt(i));
                    continue;
                }
                char c = s.charAt(i);
                Character character = stack.pop();
                if(character == ']' || character == '}' || character == ')'){
                    return false;
                }
                if((character == '[' && c == ']') ||
                        (character == '{' && c == '}') ||
                        (character == '(' && c == ')')){
                    // 括号匹配，并且左括号在前
                }else{
                    stack.push(character);
                    stack.push(c);
                }
            }
            return stack.isEmpty();
        }
        public boolean isValid2(String s) {
            Stack<Character> stack = new Stack();
            for(int i=0;i<s.length();i++){
                char c = s.charAt(i);
                if(c == '['){
                    stack.push(']');
                }else if(c == '{'){
                    stack.push('}');
                }else if(c == '('){
                    stack.push(')');
                }else if(!stack.isEmpty() && c != stack.peek()){
                    return false;
                }else {
                    stack.pop();
                }
            }
            return stack.isEmpty();
        }
        // 自己用数组加下标模拟栈，不用api
        public boolean isValid3(String s) {
            int l = s.length();
            char []st = new char[l];
            int top = -1;
            for(int i = 0;i < l;i++){
                char s_in = s.charAt(i);
                if(s_in == '(' || s_in == '[' || s_in == '{'){
                    top++;
                    st[top] = s_in;
                }
                else{
                    if(top < 0){
                        return false;
                    }
                    if(s_in == ')' && st[top] != '('){
                        return false;
                    }
                    if(s_in == ']' && st[top] != '['){
                        return false;
                    }
                    if(s_in == '}' && st[top] != '{'){
                        return false;
                    }
                    top--;
                }
            }
            if(top > -1){
                return false;
            }
            return true;
        }
    }
}
/**
 * 2022-03-02
 * 思路：
 * 利用栈先入后出的特点，如果括号匹配就出站，不匹配且做括号在前的就先入栈
 */
```