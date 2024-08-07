<style type="text/css">
.coverpage{
  width:80%;
  margin:0 auto;
}
.coverpage .logo{
  width: 35%;
}
.coverpage .future-remark{
  color:gray;
  font-size:14px;
  min-height:60px;
}
.coverpage .future-card{
  margin:8px;
}
.coverpage .footer{
  text-align:center;
  color:gray;
  padding-top:10px;
}
.coverpage .footer a{
  font-size:14px;
}
.coverpage .desc{
  padding-bottom: 20px;
  text-align: left;
  line-height: 25px;
}

@media only screen and (max-width: 500px) {
  .coverpage{
    width:98%;
    margin:0 auto;
  }
  .coverpage .logo{
    width: 80%;
  }
  .desc{
    width:100%;
  }
}
</style>

<div class="coverpage">
  <el-result style="margin:0 auto;">
    <template slot="icon">
      <img class="logo" src="https://res.meiflower.top/.netlify/images?url=/alg/logo.png&w=70%">
    </template>
    <template slot="extra">
      <div class="desc" v-html="desc"></div>
      <el-button type="success" size="medium" @click="handleClick('https://labuladong.online/algo/')">labuladong算法笔记</el-button>
      <el-button type="default" size="medium" @click="handleClick('https://programmercarl.com/')">代码随想录</el-button>
      <el-button type="warning" size="medium" @click="handleClick('https://www.cs.usfca.edu/~galles/visualization/Algorithms.html')">数据结构可视化</el-button>
      <el-button type="danger" size="medium" @click="handleClick('https://visualgo.net/zh')">算法可视化</el-button>
      <el-button type="success" size="medium" @click="handleClick('README')">查看主页</el-button>
      <el-button type="primary" size="medium" @click="handleClick('ds/index')">数据结构</el-button>
    </template>
  </el-result>
  <el-row>
    <el-col :xs="24" :md="8" v-for="(item,index) in futures">
      <el-card shadow="hover" class="future-card">
        <h3>{{item.title}}</h3>
        <div v-html="item.remark" class="future-remark">
        </div>
      </el-card>
    </el-col>
  </el-row>
  <div v-html="footer" class="footer">
  </div>
</div>

<script type="text/javascript">
(
  {
    data(){
      return {
          footer: window.$mangodoc.footer,
          title: window.$mangodoc.title,
          desc: "最开始是在B站看的左神的算法视频，决定开始整理算法学习笔记。后面又开始接触到labuladong和代码随想录，<br/>虽然大神们都有很多总结，但是要融会贯通还是得靠刻意练习。",
          futures: [
            {
              title: "第一章：基础概念",
              remark: "1. 复杂度分析（时间复杂度、空间复杂度）<br/> 2. <a href='#/wys' target='_blank'>位运算</a><br/> 3. 其他的一些概念 （常数操作、、对数器、比较器、master公式）<br/>"
            },
            {
              title: "第二章：排序和搜索",
              remark: "1. 递归和迭代（阶乘、反转字符串、8皇后问题、汉诺塔）<br/> 2. 排序（冒泡、插入、选择、快速、归并、堆排序）<br/> 3. 搜索(DFS、BFS、二分查找)"
            },
            {
              title: "第三章：数据结构基础篇",
              remark: "1. <a href='#/ds/array/index' target='_blank'>数组</a>（字符串子串搜索之KMP算法）<br/> 2. <a href='#/ds/linktable/index' target='_blank'>链表</a>（单链表、双链表、环形链表、快慢指针）<br/> 3.  <a href='#/ds/stack/index' target='_blank'>栈</a>（先进先出、有效的括号、可做DFS实现）<br/> 4. <a href='#/ds/queue/index' target='_blank'>队列</a>（后进先出、优先级队列、双端队列、可做BFS实现）"
            },
            {
              title: "第四章：数据结构进阶篇",
              remark: "1. 哈希表（哈希函数、哈希表实现、一致性哈希算法）<br/> 2. 二叉树（二叉树遍历（BFS、DFS）、平衡二叉树、二叉搜索树、满二叉树、完全二叉树、序列化和反序列化、前缀树、红黑树）<br/> 3. 堆（HeapInsert和Heapify、数组实现堆、优先级队列）<br/> 4. 位图（Java实现位图、Linux系统权限设计）"
            },
            {
              title: "第五章：数据结构高级篇",
              remark: "1. 图(定义、存储方式、邻接表实现、图的创建、遍历、拓扑排序、最小生成树之Prim和Kruskal算法、最短路径之Dijkstra算法)<br/> 2. 跳表 <br/> 3. 布隆过滤器（亿级URL黑名单判断设计）<br/>4. 并查集<br/> 5. 单调栈<br/>"
            },
            {
              title: "算法进阶",
              remark: "1. 回溯、暴力递归<br/> 2. 动态规划 <br/> 3. 贪心算法<br/>" 
            },
            {
              title: "索引",
              remark: "红黑树、B树、B+树"
            }
          ]
      }
    },
    methods: {
        handleClick(url) {
          if (url.startsWith("http")) {
            window.open(url, '_blank');
          } else {
            window.location.href = window.$mangodoc.context+"/#/"+url;
            window.location.reload();
          }
        }
    }
  }
)
</script>