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
      <img class="logo" src="static/logo.png">
    </template>
    <template slot="extra">
      <div class="desc" v-html="desc"></div>
      <el-button type="default" size="medium" @click="handleClick('README')">查看主页</el-button>
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
          desc: "最开始是在B站看的左神的算法视频，决定开始整理算法学习笔记。后面又开始接触到labuladong和代码随想录，<br/>虽然大神们都有很多总结，但是要融会贯通还是得靠刻意练习。<a href='https://labaladong.github.io/algo'>labaladong算法笔记</a> <a href='https://programmercarl.com/'>代码随想录</a>",
          futures: [
            {
              title: "前言基础",
              remark: "1. 一些概念 （常数操作、时间复杂度、空间复杂度、对数器、比较器、master公式）<br/> 2. <a href='#/wys' target='_blank'>位运算</a> 最右位是1、异或交换、得到最右位为1的数字、计算中点值等<br/> 3. 存储方式（数组存储和链表存储）"
            },
            {
              title: "数据结构基础篇",
              remark: "1. 数组（字符串子串搜索之KMP算法）<br/> 2. 链表（单链表、双链表、环形链表、快慢指针）<br/> 3. 栈（先进先出、有效的括号、可做DFS实现）<br/> 4. 队列（后进先出、优先级队列、双端队列、可做BFS实现）<br/> 5. 哈希表（哈希函数、哈希表实现、一致性哈希算法）"
            },
            {
              title: "数据结构进阶篇",
              remark: "1. 二叉树（二叉树遍历（BFS、DFS）、平衡二叉树、二叉搜索树、满二叉树、完全二叉树、序列化和反序列化、前缀树、红黑树）<br/> 2. 堆（HeapInsert和Heapify、数组实现堆、优先级队列）<br/> 3. 位图（Java实现位图、Linux系统权限设计、亿级URL黑名单判断设计、布隆过滤器） "
            },
            {
              title: "数据结构高级篇",
              remark: "1. 图(什么是图、存储方式、邻接表实现、图的创建、遍历、拓扑排序、最小生成树之Prim和Kruskal算法、最短路径之Dijkstra算法)<br/> 2. 并查集<br/> 3. 单调栈<br/> "
            },
            {
              title: "算法进阶",
              remark: "1. 回溯、暴力递归<br/> 2. 动态规划 <br/> 3. 贪心算法<br/> 4. DFS <br/> 5. BFS" 
            },
            {
              title: "排序",
              remark: "1. 冒泡<br/> 2. 插入<br/> 3. 选择<br/> 4. 快速<br/> 5. 归并<br/> 6. 堆排序"
            },
            {
              title: "搜索",
              remark: "遍历、DFS、BFS、二分"
            },
            {
              title: "递归",
              remark: "阶乘、反转字符串、8皇后问题、汉诺塔"
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
          window.location.href = window.$mangodoc.context+"/#/"+url;
          window.location.reload();
        }
    }
  }
)
</script>