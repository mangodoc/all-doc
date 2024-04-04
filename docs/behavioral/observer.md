# 观察者模式
> 当被观察的对象发生变化时，会通知所有观察者，从而实现解耦。

## 场景
某个对象状态发生变化后通知对应的观察者，不再需要通过轮询。<br/>
比如：某告警生成时会通知应用的管理人员，当管理人员发生变化后，需要即时转移通知。

![](https://res.meiflower.top/dp/observer-object.png)

## 出场对象
* Subject - 观察对象，也可以称之为主题。
* AppSubject - 应用主题，具体的观察对象。
* Observer - 观察者接口。
* AppObserver - 应用变化观察者。

## 简单观察者模式
简单观察者模式实现，详情可跳转查看[代码](https://github.com/mangomei/all-code/tree/main/dp/src/main/java/com/mangomei/dp/behavioral/observer)。


### 主题基类`Subject`
``` java
package com.mangomei.dp.behavioral.observer;

import java.util.ArrayList;
import java.util.List;

/**
 * 观察对象抽象类
 *
 * @author mango
 * @since 2024/4/4
 */
public abstract class Subject {
    /**
     * 存放注册的观察者列表
     */
    List<Observer> observerList;

    public Subject() {
        this.observerList = new ArrayList<Observer>();
    }

    /**
     * 添加/注册观察者
     *
     * @param observer 观察者
     */
    public void addObserver(Observer observer) {
        this.observerList.add(observer);
    }

    /**
     * 删除观察者
     *
     * @param observer 观察者
     */
    public void deleteObserver(Observer observer) {
        this.observerList.remove(observer);
    }

    /**
     * 通知所有观察者
     */
    public void notifyObservers() {
        notifyObservers(null);
    }

    /**
     * 通知所有观察者，并传递参数
     */
    public void notifyObservers(Object obj) {
        for (Observer observer : observerList) {
            observer.update(this, obj);
        }
    }
}

```

### 观察者接口`Observer`
``` java
package com.mangomei.dp.behavioral.observer;

/**
 * 观察者接口
 *
 * @author mango
 * @since 2024/4/4
 */
public interface Observer {
    /**
     * 当被观察者subject状态发生变化时，会依次通知观察者的update方法
     *
     * @param subject 被观察者
     * @param arg 通知时传入的参数
     */
    void update(Subject subject, Object arg);
}

```

### 应用主题类`AppSubject`
``` java
package com.mangomei.dp.behavioral.observer;

import lombok.Data;

/**
 * 应用主题，被观察者
 *
 * @author mango
 * @since 2024/4/4
 */
@Data
public class AppSubject extends Subject {
    private String handler;

    public void setHandler(String handler) {
        notifyObservers(handler);
        this.handler = handler;
    }
}

```

### 应用观察者`AppObserver`
``` java
package com.mangomei.dp.behavioral.observer;

/**
 * hello spring
 *
 * @author mango
 * @since 2024/4/4
 */
public class AppObserver implements Observer{
    public void update(Subject subject, Object arg) {
        System.out.println("观察者原数据：" + subject.toString());
        System.out.println("收到状态变化通知，" + arg.toString());
    }
}

```

### 主程序`Application`
``` java
package com.mangomei.dp.behavioral.observer;

/**
 * 观察者模式主程序
 *
 * @author mango
 * @since 2024/4/4
 */
public class Application {

    public static void main(String[] args) {
        AppSubject appSubject = new AppSubject();
        appSubject.addObserver(new AppObserver());
        appSubject.setHandler("新的数据");
        appSubject.setHandler("新的数据2");
    }
}
```
## jdk观察者模式
基于jdk中定义好的`Observer`和`Observable`，实现观察者模式。

### 应用主题类`AppSubject`
``` java
package com.mangomei.dp.behavioral.jdkobserver;

import lombok.Data;

import java.util.Observable;

/**
 * 应用主题，被观察者
 *
 * @author mango
 * @since 2024/4/4
 */
@Data
public class AppSubject extends Observable {
    private String handler;

    public void setHandler(String handler) {
        setChanged();
        notifyObservers(handler);
        this.handler = handler;
    }
}
```

### 应用观察者`AppObserver`
``` java
package com.mangomei.dp.behavioral.jdkobserver;

import java.util.Observable;
import java.util.Observer;

/**
 * 应用观察者
 *
 * @author mango
 * @since 2024/4/4
 */
public class AppObserver implements Observer {
    public void update(Observable o, Object arg) {
        System.out.println("观察者原数据：" + o.toString());
        System.out.println("收到状态变化通知，" + arg.toString());
    }
}
```

### 主程序`Application`
``` java
package com.mangomei.dp.behavioral.jdkobserver;

/**
 * 观察者模式主程序
 *
 * @author mango
 * @since 2024/4/4
 */
public class Application {

    public static void main(String[] args) {
        AppSubject appSubject = new AppSubject();
        appSubject.addObserver(new AppObserver());
        appSubject.setHandler("新的数据");
        appSubject.setHandler("新的数据2");
    }
}
```

## 总结
通过观察者模式，可以将数据的变化和变化处理解耦。主题类定义为抽象类，观察者抽象为接口，方便快速实现观察者模式。

场景特点：
1. 比较关心某些数据的变化
2. 多个数据变化可以定义为多个主题
3. 某个主题可以添加多个观察者