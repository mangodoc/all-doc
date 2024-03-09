<style type="text/css">
.coverpage{
  width:80%;
  margin:0 auto;
}
.coverpage .logo{
  width:30%;
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
.icon-title{
  height:50px;
  padding:10px;
  border-radius:5px;
  font-size:16px;
}

@media only screen and (max-width: 500px) {
  .coverpage{
    width:98%;
    margin:0 auto;
  }
  .coverpage .logo{
    width:100%;
  }
}
</style>

<div class="coverpage">
  <el-row>
    <el-col :xs="24" :md="8" v-for="(item,index) in futures">
      <el-card shadow="hover" class="future-card">
        <h3>{{item.title}}</h3>
        <div v-html="item.remark" class="future-remark">
        </div>
        <div style="color:gray;float:right;">
          <i class="el-icon-time" style="color:red;"></i> {{item.enterDate}}
        </div>
        <el-link :href="item.url" type="success" target="_blank">点击进入&gt;&gt;&gt;</el-link>
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
          footer: "v" + window.$mangodoc.version + " " + window.$mangodoc.footer,
          futures: [
            {
              title: "docsify-note",
              remark: "基于dosify的文档构建总结工具，总结了各种示例，提供了docsify-note-cli、docsify-template等工具。",
              enterDate: "2023-02-08",
              url: "https://docsify-note.meiflower.top/"
            },
            {
              title: "mangodoc",
              remark: "自己建造的文档构建工具！包括mangodoc、mangodoc-cli、mangodoc-template以及mangodoc的外部插件。",
              enterDate: "2023-03-03",
              url: "https://mangodoc.meiflower.top/"
            },
            {
              title: "CPU修行总结",
              remark: "学习CPU，并跟随UP主完成一个8位的二进制CPU的电路设计和指令设计及实现，总结笔记！",
              enterDate: "2022-10-01",
              url: "https://mgang.gitee.io/s-cpu/#/"
            },
            {
              title: "大刚学Java体系",
              remark: "学习Java体系，总结经验！主要包含Java核心知识。",
              enterDate: "2023-04-03",
              url: "https://java.meiflower.top/"
            },
            {
              title: "大刚学算法",
              remark: "学习数据结构和算法，总结为笔记。",
              enterDate: "2023-04-02",
              url: "https://alg.meiflower.top/"
            },
            {
              title: "大刚学设计模式",
              remark: "学习设计模式之路！",
              enterDate: "2023-07-30",
              url: "https://dp.meiflower.top/"
            },
            {
              title: "走上架构之路",
              remark: "阅读架构相关书籍，总结笔记！包括凤凰架构！",
              enterDate: "2023-09-30",
              url: "https://arch.meiflower.top/"
            }
          ]
      }
    },
    methods: {
    }
  }
)
</script>