/*
 Navicat Premium Dump SQL

 Source Server         : mysql8-docker-compose
 Source Server Type    : MySQL
 Source Server Version : 80033 (8.0.33)
 Source Host           : localhost:9306
 Source Schema         : testdb

 Target Server Type    : MySQL
 Target Server Version : 80033 (8.0.33)
 File Encoding         : 65001

 Date: 05/01/2025 00:26:10
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for t_class
-- ----------------------------
DROP TABLE IF EXISTS `t_class`;
CREATE TABLE `t_class`  (
  `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT,
  `class_name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL COMMENT '班级名称，如9年级3班',
  `main_teacher_id` bigint NOT NULL COMMENT '班主任老师',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `uk_class_name`(`class_name` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 2001 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_bin COMMENT = '班级表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for t_course
-- ----------------------------
DROP TABLE IF EXISTS `t_course`;
CREATE TABLE `t_course`  (
  `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT,
  `course_name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL COMMENT '课程名称',
  `credit` decimal(10, 2) UNSIGNED NOT NULL COMMENT '学分',
  `course_time` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL COMMENT '上课时间，如08:00-10:00',
  `course_location` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL COMMENT '上课地址，如403',
  `teacher_id` bigint NOT NULL COMMENT '授课老师id',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1002 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_bin COMMENT = '课程表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for t_student
-- ----------------------------
DROP TABLE IF EXISTS `t_student`;
CREATE TABLE `t_student`  (
  `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT,
  `name` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '姓名',
  `age` tinyint NOT NULL COMMENT '年龄',
  `sex` tinyint NOT NULL COMMENT '性别，1-男，2-女',
  `height` smallint NOT NULL COMMENT '身高',
  `create_time` datetime NOT NULL COMMENT '创建时间',
  `last_update_time` datetime NOT NULL ON UPDATE CURRENT_TIMESTAMP COMMENT '最近更新时间',
  `class_id` bigint UNSIGNED NULL DEFAULT NULL COMMENT '学生所属班级',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `idx_name`(`name` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 115001 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_bin COMMENT = '学生表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for t_student_score
-- ----------------------------
DROP TABLE IF EXISTS `t_student_score`;
CREATE TABLE `t_student_score`  (
  `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT,
  `student_id` bigint UNSIGNED NOT NULL COMMENT '学生id',
  `course_id` bigint UNSIGNED NOT NULL COMMENT '课程id',
  `score` smallint UNSIGNED NOT NULL COMMENT '分数',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 200001 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_bin COMMENT = '学生课程关系表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for t_teacher
-- ----------------------------
DROP TABLE IF EXISTS `t_teacher`;
CREATE TABLE `t_teacher`  (
  `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT,
  `name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL COMMENT '老师姓名',
  `sex` tinyint NOT NULL COMMENT '性别',
  `title` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL COMMENT '职称，如教授、讲师',
  `phone` char(11) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL COMMENT '手机号码',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 3001 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_bin COMMENT = '老师表' ROW_FORMAT = Dynamic;

SET FOREIGN_KEY_CHECKS = 1;
