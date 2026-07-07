/*
 Navicat Premium Dump SQL

 Source Server         : restaurant_system
 Source Server Type    : MySQL
 Source Server Version : 80043 (8.0.43)
 Source Host           : localhost:3306
 Source Schema         : restaurant_system

 Target Server Type    : MySQL
 Target Server Version : 80043 (8.0.43)
 File Encoding         : 65001

 Date: 06/07/2026 22:14:16
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for cart
-- ----------------------------
DROP TABLE IF EXISTS `cart`;
CREATE TABLE `cart`  (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '购物车项ID',
  `user_id` bigint NOT NULL COMMENT '用户ID',
  `dish_id` bigint NOT NULL COMMENT '菜品ID',
  `quantity` int NOT NULL DEFAULT 1 COMMENT '数量',
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `uk_user_dish`(`user_id` ASC, `dish_id` ASC) USING BTREE,
  INDEX `idx_user`(`user_id` ASC) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '购物车表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of cart
-- ----------------------------

-- ----------------------------
-- Table structure for dish
-- ----------------------------
DROP TABLE IF EXISTS `dish`;
CREATE TABLE `dish`  (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '菜品ID',
  `name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '菜品名称',
  `description` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '菜品简介',
  `price` decimal(10, 2) NOT NULL COMMENT '价格',
  `image_url` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '图片URL(相对路径)',
  `category_id` bigint NULL DEFAULT NULL COMMENT '所属分类ID',
  `province` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '所属省份',
  `taste_tags` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '口味标签(逗号分隔)',
  `side_dishes` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '配菜信息(逗号分隔)',
  `stock` int NOT NULL DEFAULT 999 COMMENT '库存',
  `status` tinyint NOT NULL DEFAULT 1 COMMENT '状态: 0-下架, 1-上架',
  `sales_count` int NOT NULL DEFAULT 0 COMMENT '销量',
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `idx_province`(`province` ASC) USING BTREE,
  INDEX `idx_category`(`category_id` ASC) USING BTREE,
  INDEX `idx_status`(`status` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 16 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '菜品表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of dish
-- ----------------------------
INSERT INTO `dish` VALUES (1, '麻婆豆腐', '麻辣鲜香,豆腐嫩滑,经典的川菜代表', 28.00, '/images/dishes/mapo-tofu.jpg', 1, '四川', '辣,麻,鲜香', '牛肉末,葱花,花椒', 999, 1, 120, '2026-07-06 20:28:07', '2026-07-06 22:08:37');
INSERT INTO `dish` VALUES (2, '宫保鸡丁', '鸡肉嫩滑,花生酥脆,酸甜微辣', 38.00, '/images/dishes/kung-pao-chicken.jpg', 1, '四川', '辣,酸甜,鲜香', '花生米,葱段,干辣椒', 999, 1, 150, '2026-07-06 20:28:07', '2026-07-06 20:28:07');
INSERT INTO `dish` VALUES (3, '白切鸡', '皮爽肉滑,原汁原味,蘸料鲜美', 48.00, '/images/dishes/white-cut-chicken.jpg', 2, '广东', '清淡,鲜香', '姜葱蘸料,蒜蓉', 999, 1, 98, '2026-07-06 20:28:07', '2026-07-06 20:28:07');
INSERT INTO `dish` VALUES (4, '烧鹅', '外皮酥脆,肉质鲜嫩多汁', 68.00, '/images/dishes/roast-goose.jpg', 2, '广东', '鲜香,咸香', '酸梅酱,椒盐', 999, 1, 85, '2026-07-06 20:28:07', '2026-07-06 20:28:07');
INSERT INTO `dish` VALUES (5, '糖醋鲤鱼', '外酥里嫩,酸甜可口,造型优美', 58.00, '/images/dishes/sweet-sour-carp.jpg', 3, '山东', '酸甜,酥脆', '葱花,姜丝,蒜末', 999, 1, 76, '2026-07-06 20:28:07', '2026-07-06 20:28:07');
INSERT INTO `dish` VALUES (6, '九转大肠', '色泽红润,口感丰富,五味俱全', 58.00, '/images/dishes/braised-intestines.jpg', 3, '山东', '咸香,甜,鲜香', '葱花,姜片,蒜末', 999, 1, 62, '2026-07-06 20:28:07', '2026-07-06 20:28:07');
INSERT INTO `dish` VALUES (7, '狮子头', '肉质鲜嫩,汤汁浓郁,入口即化', 45.00, '/images/dishes/lion-head.jpg', 4, '江苏', '鲜香,清淡', '青菜,香菇,马蹄', 999, 1, 90, '2026-07-06 20:28:07', '2026-07-06 20:28:07');
INSERT INTO `dish` VALUES (8, '松鼠鳜鱼', '刀工精湛,酸甜酥脆,形如松鼠', 88.00, '/images/dishes/squirrel-mandarin.jpg', 4, '江苏', '酸甜,酥脆', '松子,番茄酱', 999, 1, 55, '2026-07-06 20:28:07', '2026-07-06 20:28:07');
INSERT INTO `dish` VALUES (9, '西湖醋鱼', '鱼肉鲜嫩,醋香浓郁,酸甜适口', 68.00, '/images/dishes/west-lake-fish.jpg', 5, '浙江', '酸甜,鲜香', '姜末,葱丝', 999, 1, 70, '2026-07-06 20:28:07', '2026-07-06 20:28:07');
INSERT INTO `dish` VALUES (10, '东坡肉', '肥而不腻,酥烂可口,酱香浓郁', 58.00, '/images/dishes/dongpo-pork.jpg', 5, '浙江', '咸香,甜,浓郁', '青菜,荷叶饼', 999, 1, 82, '2026-07-06 20:28:07', '2026-07-06 20:28:07');
INSERT INTO `dish` VALUES (11, '佛跳墙', '山珍海味,汤汁浓郁,营养丰富', 188.00, '/images/dishes/buddha-jumps-wall.jpg', 6, '福建', '鲜香,浓郁,清淡', '鲍鱼,海参,花菇,瑶柱', 999, 1, 40, '2026-07-06 20:28:07', '2026-07-06 20:28:07');
INSERT INTO `dish` VALUES (12, '剁椒鱼头', '鲜辣浓郁,鱼肉嫩滑,湘菜经典', 78.00, '/images/dishes/chopped-pepper-fish.jpg', 7, '湖南', '辣,鲜香,浓郁', '剁椒,姜片,葱花', 999, 1, 88, '2026-07-06 20:28:07', '2026-07-06 20:28:07');
INSERT INTO `dish` VALUES (13, '臭鳜鱼', '闻着臭吃着香,鱼肉鲜嫩入味', 68.00, '/images/dishes/stinky-mandarin.jpg', 8, '安徽', '咸鲜,微辣,浓郁', '辣椒,姜蒜,香菜', 999, 1, 56, '2026-07-06 20:28:07', '2026-07-06 20:28:07');
INSERT INTO `dish` VALUES (14, '北京烤鸭', '皮脆肉嫩,色泽红润,享誉世界', 128.00, '/images/dishes/beijing-duck.jpg', 9, '北京', '鲜香,酥脆', '薄饼,甜面酱,黄瓜条,葱丝', 999, 1, 110, '2026-07-06 20:28:07', '2026-07-06 20:28:07');
INSERT INTO `dish` VALUES (15, '羊肉泡馍', '汤鲜肉烂,馍香浓郁,西北经典', 35.00, '/images/dishes/pita-bread-soaked.jpg', 10, '陕西', '鲜香,浓郁,咸香', '粉丝,木耳,香菜,糖蒜', 999, 1, 95, '2026-07-06 20:28:07', '2026-07-06 20:28:07');

-- ----------------------------
-- Table structure for dish_category
-- ----------------------------
DROP TABLE IF EXISTS `dish_category`;
CREATE TABLE `dish_category`  (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '分类ID',
  `name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '分类名称',
  `description` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '分类描述',
  `sort_order` int NULL DEFAULT 0 COMMENT '排序序号',
  `status` tinyint NOT NULL DEFAULT 1 COMMENT '状态: 0-禁用, 1-启用',
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 11 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '菜品分类表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of dish_category
-- ----------------------------
INSERT INTO `dish_category` VALUES (1, '川菜', '麻辣鲜香,百菜百味', 1, 1, '2026-07-06 20:28:07', '2026-07-06 20:28:07');
INSERT INTO `dish_category` VALUES (2, '粤菜', '清淡鲜美,原汁原味', 2, 1, '2026-07-06 20:28:07', '2026-07-06 20:28:07');
INSERT INTO `dish_category` VALUES (3, '鲁菜', '咸鲜为主,火候精湛', 3, 1, '2026-07-06 20:28:07', '2026-07-06 20:28:07');
INSERT INTO `dish_category` VALUES (4, '淮扬菜', '刀工精细,口味平和', 4, 1, '2026-07-06 20:28:07', '2026-07-06 20:28:07');
INSERT INTO `dish_category` VALUES (5, '浙菜', '清鲜爽脆,精致细腻', 5, 1, '2026-07-06 20:28:07', '2026-07-06 20:28:07');
INSERT INTO `dish_category` VALUES (6, '闽菜', '鲜香清淡,汤菜讲究', 6, 1, '2026-07-06 20:28:07', '2026-07-06 20:28:07');
INSERT INTO `dish_category` VALUES (7, '湘菜', '香辣浓郁,风味独特', 7, 1, '2026-07-06 20:28:07', '2026-07-06 20:28:07');
INSERT INTO `dish_category` VALUES (8, '徽菜', '咸鲜微辣,重油重色', 8, 1, '2026-07-06 20:28:07', '2026-07-06 20:28:07');
INSERT INTO `dish_category` VALUES (9, '京菜', '融合八方,讲究排场', 9, 1, '2026-07-06 20:28:07', '2026-07-06 20:28:07');
INSERT INTO `dish_category` VALUES (10, '陕菜', '古朴粗犷,面食见长', 10, 1, '2026-07-06 20:28:07', '2026-07-06 20:28:07');

-- ----------------------------
-- Table structure for order_item
-- ----------------------------
DROP TABLE IF EXISTS `order_item`;
CREATE TABLE `order_item`  (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '明细ID',
  `order_id` bigint NOT NULL COMMENT '订单ID',
  `dish_id` bigint NOT NULL COMMENT '菜品ID',
  `dish_name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '菜品名称(快照)',
  `dish_image` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '菜品图片(快照)',
  `price` decimal(10, 2) NOT NULL COMMENT '单价(快照)',
  `quantity` int NOT NULL COMMENT '数量',
  `subtotal` decimal(12, 2) NOT NULL COMMENT '小计',
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `idx_order`(`order_id` ASC) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '订单明细表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of order_item
-- ----------------------------

-- ----------------------------
-- Table structure for order_t
-- ----------------------------
DROP TABLE IF EXISTS `order_t`;
CREATE TABLE `order_t`  (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '订单ID',
  `order_no` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '订单编号',
  `user_id` bigint NOT NULL COMMENT '用户ID',
  `total_price` decimal(12, 2) NOT NULL COMMENT '总价',
  `status` tinyint NOT NULL DEFAULT 0 COMMENT '状态: 0-待支付, 1-已支付, 2-已确认, 3-已完成, 4-已取消',
  `remark` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '备注',
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `order_no`(`order_no` ASC) USING BTREE,
  INDEX `idx_user`(`user_id` ASC) USING BTREE,
  INDEX `idx_order_no`(`order_no` ASC) USING BTREE,
  INDEX `idx_status`(`status` ASC) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '订单表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of order_t
-- ----------------------------

-- ----------------------------
-- Table structure for province_feature
-- ----------------------------
DROP TABLE IF EXISTS `province_feature`;
CREATE TABLE `province_feature`  (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `province_name` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '省份名称',
  `cuisine_name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '菜系名称',
  `description` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '省份美食简介',
  `preview_image` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '省份预览图',
  `recommend_dish_ids` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '推荐菜品ID列表(逗号分隔)',
  `status` tinyint NOT NULL DEFAULT 1 COMMENT '状态: 0-隐藏, 1-显示',
  `sort_order` int NULL DEFAULT 0 COMMENT '排序',
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `province_name`(`province_name` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 11 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '省份特色表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of province_feature
-- ----------------------------
INSERT INTO `province_feature` VALUES (1, '四川', '川菜', '天府之国,麻辣鲜香,百菜百味', NULL, '1,2', 1, 1, '2026-07-06 20:28:07', '2026-07-06 20:28:07');
INSERT INTO `province_feature` VALUES (2, '广东', '粤菜', '食在广州,清淡鲜美,原汁原味', NULL, '3,4', 1, 2, '2026-07-06 20:28:07', '2026-07-06 20:28:07');
INSERT INTO `province_feature` VALUES (3, '山东', '鲁菜', '孔孟之乡,咸鲜为主,火候精湛', NULL, '5,6', 1, 3, '2026-07-06 20:28:07', '2026-07-06 20:28:07');
INSERT INTO `province_feature` VALUES (4, '江苏', '淮扬菜', '江南水乡,刀工精细,口味平和', NULL, '7,8', 1, 4, '2026-07-06 20:28:07', '2026-07-06 20:28:07');
INSERT INTO `province_feature` VALUES (5, '浙江', '浙菜', '西湖美景,清鲜爽脆,精致细腻', NULL, '9,10', 1, 5, '2026-07-06 20:28:07', '2026-07-06 20:28:07');
INSERT INTO `province_feature` VALUES (6, '福建', '闽菜', '山海相融,鲜香清淡,汤菜讲究', NULL, '11', 1, 6, '2026-07-06 20:28:07', '2026-07-06 20:28:07');
INSERT INTO `province_feature` VALUES (7, '湖南', '湘菜', '无辣不欢,香辣浓郁,风味独特', NULL, '12', 1, 7, '2026-07-06 20:28:07', '2026-07-06 20:28:07');
INSERT INTO `province_feature` VALUES (8, '安徽', '徽菜', '徽州味道,咸鲜微辣,重油重色', NULL, '13', 1, 8, '2026-07-06 20:28:07', '2026-07-06 20:28:07');
INSERT INTO `province_feature` VALUES (9, '北京', '京菜', '帝都风味,融合八方,讲究排场', NULL, '14', 1, 9, '2026-07-06 20:28:07', '2026-07-06 20:28:07');
INSERT INTO `province_feature` VALUES (10, '陕西', '陕菜', '三秦大地,古朴粗犷,面食见长', NULL, '15', 1, 10, '2026-07-06 20:28:07', '2026-07-06 20:28:07');

-- ----------------------------
-- Table structure for review
-- ----------------------------
DROP TABLE IF EXISTS `review`;
CREATE TABLE `review`  (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '评价ID',
  `user_id` bigint NOT NULL COMMENT '用户ID',
  `dish_id` bigint NOT NULL COMMENT '菜品ID',
  `order_id` bigint NULL DEFAULT NULL COMMENT '关联订单ID',
  `rating` tinyint NOT NULL COMMENT '评分(1-5)',
  `content` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '评价内容',
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `idx_dish`(`dish_id` ASC) USING BTREE,
  INDEX `idx_user`(`user_id` ASC) USING BTREE,
  INDEX `idx_order`(`order_id` ASC) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '评价表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of review
-- ----------------------------

-- ----------------------------
-- Table structure for user
-- ----------------------------
DROP TABLE IF EXISTS `user`;
CREATE TABLE `user`  (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '用户ID',
  `username` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '用户名',
  `password` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '密码(BCrypt加密)',
  `nickname` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '昵称',
  `phone` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '手机号',
  `avatar` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '头像URL',
  `role` tinyint NOT NULL DEFAULT 0 COMMENT '角色: 0-普通用户, 1-管理员',
  `status` tinyint NOT NULL DEFAULT 1 COMMENT '状态: 0-禁用, 1-启用',
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `username`(`username` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 5 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '用户表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of user
-- ----------------------------
INSERT INTO `user` VALUES (1, 'admin', '$2a$10$5Uej1EpX7aU3871TuzYXtOHgLCr1MJ2jDzl0QTIaAkjECZc7nqUj.', '管理员', '13800000000', NULL, 1, 1, '2026-07-06 20:28:07', '2026-07-06 20:45:37');
INSERT INTO `user` VALUES (2, 'zhangsan', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '张三', '13800000001', NULL, 0, 1, '2026-07-06 20:28:07', '2026-07-06 20:28:07');
INSERT INTO `user` VALUES (3, 'lisi', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '李四', '13800000002', NULL, 0, 1, '2026-07-06 20:28:07', '2026-07-06 20:28:07');
INSERT INTO `user` VALUES (4, 'sun', '$2a$10$5Uej1EpX7aU3871TuzYXtOHgLCr1MJ2jDzl0QTIaAkjECZc7nqUj.', 'sun', '156000000', NULL, 0, 1, '2026-07-06 20:45:14', '2026-07-06 20:45:14');

SET FOREIGN_KEY_CHECKS = 1;
