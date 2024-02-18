![](https://mg.meiflower.top/oss/alg/ds/tree/print-tree.png)


``` java
// 打印二叉树，基于中序遍历顺序加节点层级构建二维数组实现打印
public static void printTree(TreeNode node){
    List<TreeNode> inList = getInList(node);
    Map<TreeNode,Integer> levelMap = new HashMap<>();
    int level = handleTreeLevel(levelMap,node);
    // 以中序遍历顺序构建二维数组
    int row = level;
    int col = (int) Math.pow(2,row)-1;
    int[][] nums = new int[row][col];
    for(int i=0;i<inList.size();i++){
        TreeNode cur = inList.get(i);
        nums[levelMap.get(cur)-1][i] = cur.val;
    }
    // 打印二维数组
    for(int i=0;i<row;i++){
        for(int j=0;j<col;j++){
            System.out.print(0 == nums[i][j] ? "\t": getPre0Str(nums[i][j]));
        }
        System.out.println();
    }
}
// 获取中序遍历list
public static List<TreeNode> getInList(TreeNode node){
    List<TreeNode> result = new ArrayList<>();
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
        result.add(cur);
        // 如果有右，则右节点入栈
        if(null != cur.right){
            stack.push(cur.right);
            // 将node指针指向右节点
            node = cur.right;
        }
    }
    return result;
}
// 得到节点层级hash表和高度level
public static int handleTreeLevel(Map<TreeNode,Integer> levelMap,TreeNode node){
    int level = 1;
    Queue<TreeNode> queue = new LinkedList<>();
    queue.offer(node);
    levelMap.put(node,level);
    while(!queue.isEmpty()){
        TreeNode cur = queue.poll();
        if(levelMap.get(cur) != level){
            level++;
        }
        levelMap.put(cur,level);
        if(cur.left != null){
            queue.offer(cur.left);
            levelMap.put(cur.left,level+1);
        }
        if(cur.right != null){
            queue.offer(cur.right);
            levelMap.put(cur.right,level+1);
        }
    }
    return level;
}

// 获取4位补空格的字符串
public static String getPre0Str(int num){
    String str = num+"";
    int count = 4 - str.length();
    while (count>0){
        str = " "+str;
        count--;
    }
    return str;
}
```