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
              enterDate: "2023-03-01",
              url: "https://docsify-note.meiflower.top/"
            },
            {
              title: "mangodoc",
              remark: "自己建造的文档构建工具！包括mangodoc、mangodoc-cli、mangodoc-template以及mangodoc的外部插件。",
              enterDate: "2024-03-08",
              url: "https://mangodoc.meiflower.top/"
            },
            {
              title: "大刚学设计模式",
              remark: "自己建造的文档构建工具！包括mangodoc、mangodoc-cli、mangodoc-template以及mangodoc的外部插件。",
              enterDate: "2024-03-08",
              url: "https://dp.meiflower.top/"
            }
          ]
      }
    },
    methods: {
    }
  }
)
</script>