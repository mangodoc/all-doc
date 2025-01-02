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
  <el-result style="margin:0 auto;" sub-title="学习MySQL，总结使用经验，分享给大家！">
    <template slot="icon">
      <img class="logo" src="/static/mangodoc-template.png">
    </template>
    <template slot="extra">
      <el-button type="default" size="medium" @click="handleClick('changelog')">更新日志</el-button>
      <el-button type="primary" class="theme-color" size="medium" @click="handleClick('README')">查看主页</el-button>
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
          version: window.$mangodoc.version,
          futures: [
            {
              title: "内容1",
              remark: "描述1"
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