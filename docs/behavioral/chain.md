# 责任链模式
> 把请求从链中的一个对象传到下一个对象，直到请求被响应为止。通过这种方式去除对象之间的耦合。

## 场景
在实现客户端发送命令给服务端执行前，需要对命令校验。可能有很多个校验，一旦有校验没通过，则提前返回，此时可以使用责任链模式将要做的校验抽象为一条校验链。

![](https://res.meiflower.top/dp/chain.drawio.png)

## 代码示例
### 抽象命令行校验器类`CmdValidator`
``` java
package org.mango.jmedis.command.validator;


import org.mango.jmedis.core.JMedisClient;
import org.mango.jmedis.command.CmdExecutor;
import org.mango.jmedis.response.CmdResponse;

import java.util.Objects;

/**
 * @Description 命令校验器
 * @Date 2021-10-29 15:17
 * @Created by mango
 */
public abstract class CmdValidator {
    // 下一个校验器
    private CmdValidator next;
    /**
     * 链式校验命令行
     * @param executor 执行器
     * @param client 客户端
     * @param command 命令
     * @return 校验结果，校验通过返回null，继续下一个校验，校验失败则返回提示对象
     */
    public CmdResponse validate(CmdExecutor executor, JMedisClient client, String command){
        // 条件满足，自己处理
        CmdResponse response = this.doValidate(executor,client,command);
        if(Objects.nonNull(response)){
            return response;
        }
        //交给下一个处理器处理
        if(null != this.next){
            return this.next.validate(executor,client,command);
        }
        return null;
    }

    /**
     * 设置下一个校验器
     * @param cmdValidator
     */
    public CmdValidator setNext(CmdValidator cmdValidator){
        this.next = cmdValidator;
        return this.next;
    }

    /**
     * 校验命令
     * @param executor 执行器
     * @param client 客户端
     * @param command 命令行
     * @return 校验结果，有返回则提前结束，无返回则执行下一个
     */
    public abstract CmdResponse doValidate(CmdExecutor executor, JMedisClient client,String command);
}
```

### 实现校验器1
``` java
package org.mango.jmedis.command.validator.impl;

import org.mango.jmedis.annotation.NoAuth;
import org.mango.jmedis.core.JMedisClient;
import org.mango.jmedis.command.CmdExecutor;
import org.mango.jmedis.command.ICmd;
import org.mango.jmedis.command.validator.CmdValidator;
import org.mango.jmedis.constant.JMedisConstant;
import org.mango.jmedis.enums.ErrorEnum;
import org.mango.jmedis.response.CmdResponse;

import java.util.Objects;

/**
 * @Description 权限校验器
 * @Date 2021-10-29 22:16
 * @Created by mango
 */
public class AuthValidator extends CmdValidator {

    @Override
    public CmdResponse doValidate(CmdExecutor executor, JMedisClient client, String command) {
        String[] arr = command.split(JMedisConstant.SPACE);
        String cmdType = arr[0];
        ICmd cmd = executor.getCmd(cmdType.toUpperCase());
        // 读取不需要权限的命令跳过
        NoAuth noAuth = cmd.getClass().getAnnotation(NoAuth.class);
        if(Objects.nonNull(noAuth)){
            // 不需要认证
            return null;
        }
        // 需要认证
        if(client.isPassAuth()){// 已经认证通过
            return null;
        }else{
            // 返回需要认证的提示
            return executor.returnError(ErrorEnum.AUTH_WRONG_NEED.getMsg());
        }
    }
}
```

### 实现校验器2
``` java
package org.mango.jmedis.command.validator.impl;

import org.mango.jmedis.core.JMedisClient;
import org.mango.jmedis.command.CmdExecutor;
import org.mango.jmedis.command.validator.CmdValidator;
import org.mango.jmedis.enums.ErrorEnum;
import org.mango.jmedis.response.CmdResponse;
import org.mango.jmedis.util.StringUtil;

/**
 * @Description 不为空命令校验器
 * @Date 2021-10-29 22:03
 * @Created by mango
 */
public class NotEmptyValidator extends CmdValidator {
    @Override
    public CmdResponse doValidate(CmdExecutor executor, JMedisClient client, String command) {
        if(!StringUtil.isNotBlank(command)) {
            return executor.returnError(ErrorEnum.EMPTY_CMD.getMsg());
        }
        return null;
    }
}
```

### 实现校验器3
``` java
package org.mango.jmedis.command.validator.impl;

import org.mango.jmedis.core.JMedisClient;
import org.mango.jmedis.command.CmdExecutor;
import org.mango.jmedis.command.ICmd;
import org.mango.jmedis.command.validator.CmdValidator;
import org.mango.jmedis.constant.JMedisConstant;
import org.mango.jmedis.response.CmdResponse;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

/**
 * @Description 未知命令校验器
 * @Date 2021-10-29 22:03
 * @Created by mango
 */
public class UnknownValidator extends CmdValidator {
    private Logger log = LoggerFactory.getLogger(this.getClass());
    @Override
    public CmdResponse doValidate(CmdExecutor executor, JMedisClient client, String command) {
        String[] arr = command.split(JMedisConstant.SPACE);
        String cmdType = arr[0];
        ICmd cmd = executor.getCmd(cmdType.toUpperCase());
        if (null == cmd) {
            log.warn("command[{}] not support!", cmdType);
            return executor.returnUnknown(cmdType);
        }
        return null;
    }
}
```

### 初始化校验器链路
``` java
// 初始化命令校验器
private void initCmdValidator() {
    // 1.校验非空命令
    cmdValidator = new NotEmptyValidator();
    // 2.校验未知命令
    UnknownValidator unknownValidator = new UnknownValidator();
    // 3.校验权限
    AuthValidator authValidator = new AuthValidator();
    // 设置成链
    cmdValidator.setNext(unknownValidator).setNext(authValidator);
}
```

### 调用校验器链路
``` java
/**
* 执行命令
* @param client 客户端
* @param command 命令
* @return 执行成功返回结果，否则返回null
*/
public CmdResponse execute(JMedisClient client,String command){
    log.debug("execute command:{}",command);
    // 执行校验链
    CmdResponse response = cmdValidator.validate(this,client,command);
    if(Objects.nonNull(response)){
        return response;
    }
    // 分发命令并得到结果
    String[] param = oneStartArr(command);
    ICmd cmd = parseCmd(command);
    CmdResponse result = cmd.dispatch(client,param);
    // 设置并执行后置处理器
    this.setAndExecuteAfterHandler(cmd,client,param);
    return result;
}
```

## 总结
责任链模式，通过链路传递请求，且对请求做识别处理，直到有一个节点处理请求。具备松耦合和可扩展的特点，适合将复杂的业务拆分为多个节点关注自己细小粒度的业务的场景，如复杂校验。

场景特点：
1. 请求者不知道具体是哪个处理者能处理请求
2. 实际的处理者更专注于自己细小粒度的业务处理