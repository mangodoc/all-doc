## 策略模式

> 定义一组算法，在运行时可以选择执行不同算法来获取不同结果。不一定要局限于针对处理具体某一件事，可以是抽象的某一类事，比如获取指标，或者执行命令。

## 场景

在实现类redis的服务端程序时，需要支持并扩展各种命令，如`ping`,`select`,`set`,`get`,`auth` 等命令执行。为了避免使用大量`if` 和 `else if`，可以使用策略模式来管理命令类，并注册到`Map` 中可以点对点执行。

![](https://res.meiflower.top/dp/strategy.drawio.png)

## 代码示例

### 流程代码
通过注解`@Cmd`注册具体策略类实例到`map`中准备应对客户端不同的命令请求。

``` java
private void registerCmdMap() {
    try {
        List<Class<?>> cmdClassList = ClassUtil.getClasses(this.getClass().getPackage().getName());
        List<String> cmdList = new ArrayList<>();
        for(Class e : cmdClassList){
            Cmd cmd = (Cmd) e.getAnnotation(Cmd.class);
            if(Objects.nonNull(cmd)) {
                ICmd bean = (ICmd) e.newInstance();
                String command = StringUtil.getNoCmdClassName(e.getSimpleName());
                cmdMap.put(command, bean);
                cmdList.add(e.getSimpleName());
            }
        }
        log.info("register client {} success",cmdList);
    }catch (Exception e){
        log.error("init client map error:{}",e.getMessage(),e);
    }
}
```

获取命令方法，截取空格分割的第一个字符串作为命令。

``` java
private ICmd parseCmd(String command){
    String[] arr = command.split(JMedisConstant.SPACE);
    String cmdType = arr[0];
    return cmdMap.get(cmdType.toUpperCase());
}
```

解析得到命令后，调度分发执行。

``` java
ICmd cmd = parseCmd(command);
CmdResponse result = cmd.dispatch(client,param);
```

命令分发方法（模板方法）中，执行`excute`方法执行具体的策略。

``` java 
public CmdResponse<T> dispatch(JMedisClient client, String[] param) {
    // 先校验参数个数
    if(expect(param)){
        // 再校验参数数据
        CmdResponse<T> validateResponse = validate(client,param);
        if(validateResponse == null) {
            return this.execute(client, param);
        }else{
            return validateResponse;
        }
    }else{
        //错误的参数个数
        return (CmdResponse<T>) this.errorWrongNumber();
    }
}
```

### PingCmd
``` java
@Cmd
@NoAuth
public class PingCmd extends BaseCmd<String> {
    @Override
    public CmdResponse<String> execute(JMedisClient client, String[] param) {
        if(param.length == 0){
            return this.renderUseEmpty("PONG");
        }else if(param.length == 1){
            return this.renderUseEmpty(param[0]);
        }
        return null;
    }

    @Override
    public boolean expect(String[] param) {
        // <=1
        return this.sizeLe(param,1);
    }
}
```

### SetCmd
``` java
@Cmd
@WithExpire
public class GetCmd extends BaseCmd<String> {
    /**
     * eg: get a
     * @param client 客户端
     * @param param 命令参数
     * @return
     */
    @Override
    public CmdResponse<String> execute(JMedisClient client, String[] param) {
        String key = param[0];
        // 将数据存储到对应下标的数据库中
        SDS value = Memory.getString(client.getDbIndex(),key);
        if(null == value){
            return this.renderUseNull();
        }
        return this.renderUseString(value.getString());
    }

    @Override
    public boolean expect(String[] param) {
        return this.sizeEq(param,1);
    }
}
```

## 总结
1. 当有一组算法需要定义时，可以使用策略来实现，避免`if else` 或者 `switch`。
2. 策略模式可以放大理解，不要局限与某一个具体的行为。比如可以是获取指标，执行命令等。
3. 运行时，通过参数加映射快速定位到具体要执行的策略。