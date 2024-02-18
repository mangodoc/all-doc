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
.mg-badge {
  color: #fff;
  display: inline-block;
  padding-left: 8px;
  padding-right: 8px;
  text-align: center;
  background-color: green;
  border-radius: 10%;
  position: relative;
  top: -15px;
  left: 0px;
  font-size: 15px;
}
.theme-color-owner {
  background-color: #F0F !important;
  border-color: #F0F !important;
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
  <el-result style="margin:0 auto;" :sub-title="subTitle">
    <template slot="icon">
      <img class="logo" src="/static/cover-logo.png">
    </template>
    <template slot="extra">
      <el-button type="default" size="medium" @click="handleClick('changelog')">更新日志</el-button>
      <el-button type="primary" class="theme-color-owner" size="medium" @click="handleClick('README')">查看主页</el-button>
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
          subTitle: "学习架构后的总结，亦可看成读《凤凰架构》的感悟！",
          footer: window.$mangodoc.footer,
          version: window.$mangodoc.version,
          futures: [
            {
              title: "建设中",
              remark: "......"
            }
          ]
      }
    },
    methods: {
        handleClick(url) {
          window.location.href = window.$mangodoc.context + "/#/" + url;
          window.location.reload();
        }
    }
  }
)
</script>