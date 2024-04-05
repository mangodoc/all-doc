# 观察者模式
> 当被观察的对象发生变化时，会通知所有观察者，从而实现解耦。

## 场景
某个对象状态发生变化后通知对应的观察者，不再需要通过轮询。<br/>
比如：某告警生成时会通知应用的管理人员，当管理人员发生变化后，需要即时转移通知。

![](https://res.meiflower.top/dp/observer-object.png)

## 出场对象
* Subject - 观察对象，也可以称之为主题，或者事件。
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
import java.util.concurrent.ExecutorService;

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
    public void notifyObservers(Object arg) {
        for (Observer observer : observerList) {
            observer.update(this, arg);
        }
    }

    /**
     * 异步通知观察者
     *
     * @param arg 参数
     * @param executorService 执行线程池
     */
    public void asyncNotifyObservers(Object arg, ExecutorService executorService) {
        for (Observer observer : observerList) {
            executorService.submit(() -> observer.update(this, arg));
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
## 事件发布订阅模式
### 事件发布者`EventPublisher`
``` java
package com.mangomei.dp.behavioral.publisher;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.concurrent.ExecutorService;

/**
 * 事件发布者
 *
 * @Author: mango
 * @Date: 2024/4/5 11:32
 */
public class EventPublisher {
    Map<String, List<EventListener>> listenerMap = new HashMap<>();

    /**
     * 添加监听者
     *
     * @param topic 主题
     * @param eventListener 监听者
     */
    public void addListener(String topic, EventListener eventListener) {
        List<EventListener> listenerList = listenerMap.getOrDefault(topic, new ArrayList<>());
        listenerList.add(eventListener);
        listenerMap.put(topic, listenerList);
    }

    /**
     * 移除监听者
     *
     * @param topic 主题
     * @param eventListener 监听者
     */
    public void removeListener(String topic, EventListener eventListener) {
        List<EventListener> listenerList = listenerMap.getOrDefault(topic, new ArrayList<>());
        listenerList.remove(eventListener);
    }

    /**
     * 发布事件
     *
     * @param topic 主题
     * @param event 事件
     */
    public void publishEvent(String topic, Event event) {
        List<EventListener> listenerList = listenerMap.getOrDefault(topic, new ArrayList<>());
        for (EventListener listener : listenerList) {
            listener.onEvent(event);
        }
    }

    /**
     * 发布事件，通过线程池实现异步
     *
     * @param topic 主题
     * @param event 事件
     * @param service 线程池
     */
    public void publishEvent(String topic, Event event, ExecutorService service) {
        List<EventListener> listenerList = listenerMap.getOrDefault(topic, new ArrayList<>());
        for (EventListener listener : listenerList) {
            service.submit(() -> listener.onEvent(event));
        }
    }
}
```
### 事件监听者`EventListener`
``` java
package com.mangomei.dp.behavioral.publisher;

/**
 * 事件监听者
 *
 * @Author: mango
 * @Date: 2024/4/5 11:29
 */
public interface EventListener<T> {
    /**
     * 监听事件
     *
     * @param arg 数据
     */
    void onEvent(T arg);
}
```
### 主程序`Application`
``` java
package com.mangomei.dp.behavioral.publisher;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.ToString;

import java.util.concurrent.Executors;

/**
 * 应用程序
 *
 * @Author: mango
 * @Date: 2024/4/5 11:45
 */
public class Application {
    public static void main(String[] args) {
        EventPublisher publisher = new EventPublisher();
        publisher.addListener("topic1", new Topic1Listener());
        publisher.addListener("topic2", new Topic2Listener());
        Event event = new Event("测试数据");
        publisher.publishEvent("topic1", event);
        event.setMessage("新的测试数据");
        publisher.publishEvent("topic2", event, Executors.newFixedThreadPool(1));
    }
}

class Topic1Listener implements EventListener<Event> {

    @Override
    public void onEvent(Event event) {
        System.out.println("topic1 收到消息：" + event.toString());
    }
}

class Topic2Listener implements EventListener<Event> {

    @Override
    public void onEvent(Event arg) {
        System.out.println("topic2 收到消息：" + arg.toString());
    }
}

@ToString
@Data
@AllArgsConstructor
class Event {
    private String message;
}
```
事件发布订阅模式中，支持了topic，tag也可以类似支持。

## 通知方式
可以根据实际情况，可以选择通知方式为同步或者异步。

### 同步通知
``` java
/**
 * 通知所有观察者，并传递参数
 */
public void notifyObservers(Object obj) {
    for (Observer observer : observerList) {
        observer.update(this, obj);
    }
}
```

### 异步通知
``` java
/**
 * 异步通知观察者
 *
 * @param arg 参数
 * @param executorService 执行线程池
 */
public void asyncNotifyObservers(Object arg, ExecutorService executorService) {
    for (Observer observer : observerList) {
        executorService.submit(() -> observer.update(this, arg));
    }
}
```


## 总结
通过观察者模式，可以将数据的变化和变化处理解耦。主题类定义为抽象类，观察者抽象为接口，方便快速实现观察者模式。

发布订阅模式是观察者模式的升级，能支持多对多的关系，发布者发布事件，订阅者订阅事件，事件总线则可以按类型同步或者异步通知订阅者。

场景特点：
1. 比较关心某些数据的变化
2. 多个数据变化可以定义为多个主题
3. 某个主题可以添加多个观察者