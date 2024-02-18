## 二叉树定义

![](https://mg.meiflower.top/oss/alg/ds/tree/tree2.png)

如上图每一个节点有左孩子和右孩子，是满二叉树，也叫完全二叉树。

又因为头节点的值都小于左右孩子的值，也称为小根堆。

### 数据结构
以链表实现：
``` java
/**
 * 二叉树
 */
public class TreeNode {
    int val;
    TreeNode left;
    TreeNode right;
    TreeNode() {}
    TreeNode(int val) { this.val = val; }
    TreeNode(int val, TreeNode left, TreeNode right) {
        this.val = val;
        this.left = left;
        this.right = right;
    }
}
```












