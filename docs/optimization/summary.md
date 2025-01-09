# 性能优化总结
## 前置阅读
* [实验环境准备](#/advance/env-ready) - 本文会基于实验环境说明相关内容，请先阅读！

## 优化的4个层次和漏斗法则
* <green><b>层次1： 高效SQL、索引。（减少数据访问）</b></green>
* <green><b>层级2： 合理的数据库结构设计、存储引擎、表字段设计。</b></green>（返回更少数据量，查询时只需返回必要字段）
* 层次3： 分库分区分表，如`proxy`架构的`mycat`；client架构的`sharding-jdbc`。（数据量大时，减少交互次数）
* 层次4： DB架构设计，主从复制、读写分离、分布式部署等。（增加资源）

<img src="/static/opt/funnel-principle.png" style="width: 600px;" />

**总结：目前层次多在1和2上，3和4只在大数据量和集群部署时用到。**

## 熟悉索引
MySQL中索引有`主键索引`、`普通索引`、`唯一索引`、`组合索引`等，其中`主键索引`也是`聚集索引`。

@alert(warning)(提示)(聚集索引是指在B+树中，同时包含数据和主键key；MySQL的每一张表都有聚集索引，)

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
