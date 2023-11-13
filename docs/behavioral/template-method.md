# 模板方法模式
> 定义一个操作中的算法骨架，将算法的一些步骤延迟到子类中，使得子类在可以不改变该算法结构的情况下重定义该算法的某些特定步骤。

## 场景
在实现类redis的服务端时，分发执行客户端请求命令。使用模板方法定义好执行骨架，将期望参数的验证方法（可通过抽象方法和接口方法）交接子类实现。

![](https://res.meiflower.top/dp/template-method.drawio.png)

## 代码示例

``` java
/**
* 命令参数期望个数
* @param param 参数
* @return 参数格式正确返回true，反之返回false
*/
abstract boolean expect(String[] param);

/**
* 校验参数
* @param client 客户端
* @param param 参数
* @return 参数正确返回null，反之返回响应对象
*/
abstract CmdResponse<T> validate(JMedisClient client,String[] param);

/**
* 命令执行
* @param client 客户端
* @param param 命令参数
* @return 返回结果
*/
abstract CmdResponse<T> execute(JMedisClient client, String[] param);

// 模板方法
@Override
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

## 总结
1. 定义好算法骨架。
2. 使用 抽象方法 或者 接口方法 将一些步骤交由具体子类实现。