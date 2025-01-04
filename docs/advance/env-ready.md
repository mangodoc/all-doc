# 实验环境准备
## 前置阅读
* [MySQL的安装](/#/basic/mysql-install)

## 摘要
在`mysql 8.x`数据库环境下，搭建一个可供使用的数据库`testdb`，并创建相关表，生产一些实验数据，为后续的实验做基础。
* 关键字： `mysql 8.x`；`实验数据`

## 概览
![](/static/lab/table-list.png)
根据图中对象设计，创建数据库`testdb`，并创建如下表，最后生产一些实验数据。
* `t_student`：学生表
* `t_class`：班级表
* `t_teacher`：老师表
* `t_course`：课程表
* `t_student_score`：学生课程分数表

## 创建数据库和表
数据库表结构脚本：[testdb.sql](/static/lab/testdb.sql)
* 注意：脚本会先创建数据库，再创建表。数据库会默认使用`utf8mb4`编码，字符集为`utf8mb4_bin`。

## 生产数据
数据库生产数据脚本：[testdb-data.sql](/static/lab/testdb-data.sql)

``` sql
select "student" as name, count(1) as count from t_student
union all 
select "class" as name, count(1) as count from t_class
union all 
select "course" as name, count(1) as count from t_course
union all 
select "teacher" as name, count(1) as count from t_teacher
union all 
select "student_score" as name, count(1) as count from t_student_score;
```

## 结果
执行完`创建表结构`和`生产数据`脚本后，能得到一个有如下数据量的数据库环境，可供实验使用。

@alert(warning)(温馨提示)(其中数据是借助navicat工具中的数据生成功能生产，数据不一定准确，仅供参考！)

<img src="/static/lab/result.png" style="width: 200px;">