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
  text-align: left;
  line-height: 25px;
}
.coverpage .version{
  color: gray;
  padding-bottom: 25px;
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
      <img class="logo" src="/static/logo.png">
    </template>
    <template slot="extra">
      <div class="desc" v-html="desc"></div>
      <div class="version">版本： V{{version}}</div>
      <el-button type="default" size="medium" @click="handleClick('changelog')">更新日志</el-button>
      <el-button type="primary" class="theme-color" size="medium" @click="handleClick('6abc/index')">快速开始</el-button>
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
          version: window.$mangodoc.version,
          desc: "学习设计模式后整理的笔记",
          futures: [
            {
              title: "设计模式6大原则",
              remark: "1. 单一职责原则 2. 开放封闭原则<br/>3. 依赖倒置原则 4. 里氏替换原则<br/>5. 接口隔离原则 6. 迪米特原则 <a href='#/6abc/index' target='_blank'>查看</a>"
            },
            {
              title: "创建型模式",
              remark: "1. <a href='#/creational/singleton' target='_blank'>单例模式</a><br/>"
            },
            {
              title: "结构型模式",
              remark: ""
            },
            {
              title: "行为型模式",
              remark: "1. <a href='#/behavioral/chain' target='_blank'>责任链模式</a><br/>2. <a href='#/behavioral/template-method' target='_blank'>模板方法模式</a><br/>3. <a href='#/behavioral/strategy' target='_blank'>策略模式</a><br/>"
            }
          ]
      }
    },
    methods: {
        handleClick(url) {
          window.location.href = "/#/"+url;
          window.location.reload();
        }
    }
  }
)
</script>