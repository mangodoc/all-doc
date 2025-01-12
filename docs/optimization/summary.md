# 性能优化总结
## 前置阅读
* [实验环境准备](#/advance/env-ready) - 本文会基于实验环境说明相关内容，请先阅读！

## 优化的4个层次和漏斗法则
* <green><b>层次1： 高效SQL、索引。（减少数据访问）</b></green>
* <green><b>层级2： 合理的数据库结构设计、存储引擎、表字段设计。</b></green>（返回更少数据量，查询时只需返回必要字段）
* 层次3： 分库分区分表，如`proxy`架构的`mycat`；`client`架构的`sharding-jdbc`。（数据量大时，减少交互次数）
* 层次4： DB架构设计，主从复制、读写分离、分布式部署等。（增加资源）

<img src="/static/opt/funnel-principle.png" style="width: 600px;" />

**总结：目前层次多在1和2上，3和4只在大数据量和集群部署时用到。**

## 熟悉索引
MySQL中索引有`主键索引`、`普通索引`、`唯一索引`、`组合索引`等，其中`主键索引`也是`聚集索引`。

@alert(warning)(提示)(聚集索引是指在B+树中，同时包含数据和主键key；MySQL的每一张表都有聚集索引，如果用户在创建表的时候没有指定主键，那么MySQL会默认为_id字段【6个字节隐藏的】创建主键索引。)

在学生表中：
``` sql
CREATE TABLE `t_student` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(20) COLLATE utf8mb4_bin NOT NULL COMMENT '姓名',
  `age` tinyint NOT NULL COMMENT '年龄',
  `sex` tinyint NOT NULL COMMENT '性别，1-男，2-女',
  `height` smallint NOT NULL COMMENT '身高',
  `create_time` datetime NOT NULL COMMENT '创建时间',
  `last_update_time` datetime NOT NULL ON UPDATE CURRENT_TIMESTAMP COMMENT '最近更新时间',
  `class_id` bigint unsigned DEFAULT NULL COMMENT '学生所属班级',
  PRIMARY KEY (`id`),
  KEY `idx_name` (`name`) USING BTREE,
  KEY `idx_age_height` (`age`,`height`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=115001 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin COMMENT='学生表';
```
* `id` 是`主键索引`，是`聚集索引`，同时包含数据与主键key； 
* `name` 是`普通索引`，不包含数据，只包含主键key；
* `age` 和 `height` 是`组合索引`，不包含数据，只包含主键key。

## 熟悉执行计划
在MySQL中，执行计划可使用`explain {sql}`来查看：
![](/static/opt/explain-result.png)

1. id: 反映的是表的读取顺序或者查询中的执行select子句的顺序。
2. select_type: 表示查询的类型，有：simple、primary、union、subquery、derived、union、union result、prepare、execute。
3. table: 表名。
4. type: 对表的访问方式，从左到右性能逐渐变好，const、eq_ref、ref、range、index、all。
    - const：常量查询，如primary key、unique key、const key。
    - eq_ref：唯一索引查询，如primary key、unique key。
    - ref：非唯一索引查询，如普通索引。
    - range：索引范围查询，如使用between、in、>、<、like等。
    - index：全索引扫描，遍历整个索引树。
    - all：全表扫描，遍历整个表。
5. possible_keys: 可能用到的索引。
6. key: 实际用到的索引。
7. key_len: 索引长度。
8. ref: 索引的参考列。
9. rows: 扫描的行数。行数越小越好。
10. Extra: 额外信息。
    - Using index：使用索引。
    - Using where：使用where条件。
    - Using filesort：使用文件排序。（性能差，需要关注优化）
    - Using temporary：使用临时表。
    - Using join buffer：使用连接缓冲区。
    - Using index condition：使用索引下推ICP优化。
    - Using full join：使用全连接。
    - Using subquery：使用子查询。
    - Using union：使用并集。
    - Using union distinct：使用并集并去重。
