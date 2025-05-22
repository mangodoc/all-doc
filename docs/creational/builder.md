# 建造者模式 (Builder Pattern)
> 将一个复杂对象的构建与其表示分离，使得同样的构建过程可以创建不同的表示。

## 场景
在需要构建涉及多个步骤且步骤可定制的对象时使用。例如：
- 构建不同配置的计算机（如游戏本、轻薄本）。
- 创建不同风格的房屋（如现代风格、古典风格）。

![](https://res.meiflower.top/dp/builder.drawio.png)

## 代码示例

### 抽象建造者 `Builder`
```java
/**
 * @Description 抽象建造者
 * @Date 2024-05-19 18:30
 * @Created by mango
 */
public interface Builder {
    void buildCpu();
    void buildMemory();
    void buildDisk();
    Computer getComputer();
}
```

### 具体建造者 `GamingComputerBuilder`
```java
/**
 * @Description 游戏电脑建造者
 * @Date 2024-05-19 18:30
 * @Created by mango
 */
public class GamingComputerBuilder implements Builder {
    private Computer computer;

    public GamingComputerBuilder() {
        this.computer = new Computer("高性能电脑");
    }

    @Override
    public void buildCpu() {
        computer.setCpu("i9-13900K");
    }

    @Override
    public void buildMemory() {
        computer.setMemory("64GB DDR5");
    }

    @Override
    public void buildDisk() {
        computer.setDisk("2TB NVMe SSD");
    }

    @Override
    public Computer getComputer() {
        return computer;
    }
}
```

### 指挥者 `Director`
```java
/**
 * @Description 指挥者
 * @Date 2024-05-19 18:30
 * @Created by mango
 */
public class Director {
    private Builder builder;

    public Director(Builder builder) {
        this.builder = builder;
    }

    public void constructComputer() {
        builder.buildCpu();
        builder.buildMemory();
        builder.buildDisk();
    }
}
```

### 使用示例
```java
/**
 * @Description 客户端使用建造者模式创建对象
 * @Date 2024-05-19 18:30
 * @Created by mango
 */
public class Client {
    public static void main(String[] args) {
        // 创建游戏电脑建造者
        Builder builder = new GamingComputerBuilder();
        Director director = new Director(builder);
        director.constructComputer();
        Computer computer = builder.getComputer();
        System.out.println(computer);
    }
}
```

### 输出结果
```
Computer{name='高性能电脑', cpu='i9-13900K', memory='64GB DDR5', disk='2TB NVMe SSD'}
```

## 总结
1. **解耦构建与表示**：通过抽象建造者接口，将对象的构建逻辑与具体实现分离。
2. **灵活定制流程**：指挥者控制构建流程，具体建造者决定如何组装每个部分。
3. **易于扩展**：如果要添加新的产品类型，只需新增具体的建造者类即可，符合开放封闭原则。
4. **避免构造器爆炸**：相比多参数构造函数，建造者模式更适合处理复杂对象的创建问题。