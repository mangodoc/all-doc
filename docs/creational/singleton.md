# 单例模式
> 确保某个类只生成一个对象实例，然后提供一个静态方法获取实例对象。

## 场景
在实现类redis的服务端里，`ServerConf`服务端配置需要确保只有一个对象实例。故可以使用单例模式来实现。

## 代码示例
如下是饱汉式单例实现，基于jvm的static块只会执行一次的特性来实现。

``` java
public class ServerConf {

    // 单例
    private ServerConf(){}

    private static ServerConf serverConf;

    static {
        serverConf = new ServerConf();
    }

    public static ServerConf getConf(){
        return serverConf;
    }
}
```
## 总结
1. 将构造方法设置为`private`。
2. 通过`static`块来创建一个对象。
3. 提供对外访问的静态获取对象方法。