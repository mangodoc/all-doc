以如下树为例：

![](https://mg.meiflower.top/oss/alg/ds/tree/tree2.png)

## 递归序
``` java
// 递归序，每个节点到3次
public static void recursion(TreeNode node){
    if(node == null){
        return ;
    }
    System.out.print(node.val+"->");
    recursion(node.left);
    System.out.print(node.val+"->");
    recursion(node.right);
    System.out.print(node.val+"->");
}
```

```
递归序:
1->2->4->4->4->2->5->5->5->2->1->3->6->6->6->3->7->7->7->3->1->
```

## 前序遍历-递归

``` java
// 前序遍历，头左右
public static void preOver(TreeNode node){
    if(node == null){
        return ;
    }
    // 在第一次处理
    System.out.print(node.val+"->");
    preOver(node.left);
    preOver(node.right);
}
```
```
前序遍历:
1->2->4->5->3->6->7->
```
## 前序遍历-非递归
``` java
// 前序遍历，非递归
public static void pre(TreeNode node){
    Stack<TreeNode> stack = new Stack<>();
    // 头节点入栈
    stack.push(node);
    while(!stack.isEmpty()){
        TreeNode cur = stack.pop();
        System.out.print(cur.val+"->");
        // 先压右，再压左
        if(null != cur.right){
            stack.push(cur.right);
        }
        if(null != cur.left){
            stack.push(cur.left);
        }
    }
}
```
```
前序遍历:(非递归)
1->2->4->5->3->6->7->
```

## 中序遍历-递归
``` java
// 中序遍历，左头右
public static void inOver(TreeNode node){
    if(node == null){
        return ;
    }
    inOver(node.left);
    // 在第二次处理
    System.out.print(node.val+"->");
    inOver(node.right);
}
```
```
中序遍历:
4->2->5->1->6->3->7->
```

## 中序遍历-非递归
``` java
// 中序遍历，非递归
public static void in(TreeNode node){
    Stack<TreeNode> stack = new Stack<>();
    // 头节点入栈
    stack.push(node);
    while(!stack.isEmpty()){
        // 左子数入栈
        while(node.left != null){
            stack.push(node.left);
            node = node.left;
        }
        TreeNode cur = stack.pop();
        System.out.print(cur.val+"->");
        // 如果有右，则右节点入栈
        if(null != cur.right){
            stack.push(cur.right);
            // 将node指针指向右节点
            node = cur.right;
        }
    }
}
```
```
中序遍历:(非递归)
4->2->5->1->6->3->7->
```

## 后序遍历-递归
``` java
// 后序遍历，左右头
public static void backOver(TreeNode node){
    if(node == null){
        return ;
    }
    backOver(node.left);
    backOver(node.right);
    // 在第三次处理
    System.out.print(node.val+"->");
}
```
```
后序遍历:
4->5->2->6->7->3->1->
```

## 后续遍历-非递归
``` java
// 后序遍历，非递归
public static void back(TreeNode node){
    Stack<TreeNode> stack = new Stack<>();
    Stack<TreeNode> collect = new Stack<>();
    // 头节点入栈
    stack.push(node);
    while(!stack.isEmpty()){
        TreeNode cur = stack.pop();
        // 弹出的元素放到收集栈内
        collect.push(cur);
        // 先压左再压右
        if(null != cur.left){
            stack.push(cur.left);
        }
        if(null != cur.right){
            stack.push(cur.right);
        }
    }
    // 最后弹出收集栈里的节点
    while(!collect.isEmpty()){
        System.out.print(collect.pop().val+"->");
    }
}
```
```
中序遍历:(非递归)
4->5->2->6->7->3->1->
```

## 广度优先遍历(bfs)
``` java
// 广度度优先遍历
public static void bfs(TreeNode node){
    // 基于队列实现
    Queue<TreeNode> queue = new LinkedList<>();
    queue.offer(node);
    while(!queue.isEmpty()){
        TreeNode cur = queue.poll();
        System.out.print(cur.val+"->");
        if(cur.left != null){
            queue.offer(cur.left);
        }
        if(cur.right != null){
            queue.offer(cur.right);
        }
    }
}
```
```
宽度优先遍历：(wfs)
1->2->3->4->5->6->7->
```